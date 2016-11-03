class Image < ApplicationRecord
  belongs_to :post
  accepts_nested_attributes_for :post, allow_destroy: true

  has_attached_file :photo, styles: { lightbox: 'x1200', thumb: 'x200', mini: 'x60' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  after_post_process :save_latlong

  def photo_url_thumb
    photo.url(:thumb)
  end

  def photo_url
    photo.url(:lightbox)
  end

  def as_json(_options = {})
    {
      id: id,
      name: name,
      lat: latitude,
      lng: longitude,
      url: photo_url,
      url_thumb: photo_url_thumb
    }
  end

  private

  def save_latlong
    exif_data = MiniExiftool.new(photo.queued_for_write[:original].path)
    self.latitude = parse_latlong(exif_data['gpslatitude'])
    self.longitude = parse_latlong(exif_data['gpslongitude'])
    self.created_at = exif_data['DateTimeOriginal']
    self.updated_at = exif_data['DateTimeOriginal']
  end

  def parse_latlong(latlong)
    return unless latlong
    match, degrees, minutes, seconds, rotation = /(\d+) deg (\d+)' (.*)" (\w)/.match(latlong).to_a
    calculate_latlong(degrees, minutes, seconds, rotation)
  end

  def calculate_latlong(degrees, minutes, seconds, rotation)
    calculated_latlong = degrees.to_f + minutes.to_f / 60 + seconds.to_f / 3600
    %w(S W).include?(rotation) ? -calculated_latlong : calculated_latlong
  end
end
