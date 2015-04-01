class Redcarpet::Render::OriginalHTML < Redcarpet::Render::HTML
  def preprocess(full_document)
    full_document.gsub(/#(?<num>\d+)/, '[#\k<num>](#comment-\k<num>)')
  end
end
