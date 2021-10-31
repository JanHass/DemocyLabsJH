module EmbedVideosHelper
  VIMEO_REGEX = /vimeo.*(staffpicks\/|channels\/|videos\/|video\/|\/)([^#\&\?]*).*/.freeze
  YOUTUBE_REGEX = /youtu.*(be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/.freeze

  def embedded_video_code(resource)
    link = resource.video_url
    title = t("proposals.show.embed_video_title", proposal: resource.title)
    if link =~ /vimeo.*/
      server = "Vimeo"
    elsif link =~ /youtu*.*/
      server = "YouTube"
    end

    if server == "Vimeo"
      reg_exp = VIMEO_REGEX
      src = "https://player.vimeo.com/video/"
    elsif server == "YouTube"
      reg_exp = YOUTUBE_REGEX
      src = "https://www.youtube.com/embed/"
    end

    if reg_exp
      match = link.match(reg_exp)
    end

    if match && match[2]
      '<iframe src="' + src + match[2] + '" style="border:0;" allowfullscreen title="' + title + '"></iframe>'
    else
      ""
    end
  end

  def valid_video_url?
    return if video_url.blank?
    return if video_url.match(VIMEO_REGEX)
    return if video_url.match(YOUTUBE_REGEX)

    errors.add(:video_url, :invalid)
  end
end
