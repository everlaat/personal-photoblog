require 'tempfile'
require 'github/markup'

class BlogMailer < ApplicationMailer
  def receive(mail)
    author = Author.find_by(email: mail.from)
    if author
      mail_to_post author, mail
    end
  end

  def render_mail_body(mail)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, with_toc_data: false)
    body = ''
    if mail.multipart?
      if defined? mail.text_part.body
        decoded = mail.text_part.body.decoded
        body = markdown.render(decoded)
      end
    else
      body = markdown.render(mail.body.raw_source)
    end
    return body
  end

  def mail_to_post(author, mail)
    body = render_mail_body(mail)
    last_post = Post.last()
    if last_post && last_post.title == mail.subject
      post = last_post
      if body != ''
        post.content = body
      end
    else
      post = Post.new
      post.author = author
      post.title = mail.subject
      post.content = body
    end
    post.posted_at = DateTime.now
    post.save()
    mail_add_photos(mail, post)
  end

  def mail_add_photos(mail, post)
    mail.attachments.each do | attachment |
      if (attachment.content_type.start_with?('image/'))
        filename = attachment.filename
        begin
          ext = File.extname(filename).downcase
          file = Tempfile.new([filename,".#{ext}"], encoding: 'ascii-8bit')
          file.write attachment.body.decoded
          image = Image.new
          image.photo = file
          image.name = filename
          image.post = post
          image.save()
          file.close
          file.unlink
        rescue => e
          puts "Unable to save data for #{filename} because #{e.message}"
        end
      end
    end
  end

end
