module PostsHelper
  def get_host(url)
    URI.parse(url).host
  end
end
