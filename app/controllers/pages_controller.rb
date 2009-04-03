class PagesController < SiteController
  def show
    url = params[:url].join("/")
    
    if url =~ /(.*?)\/(\w+)$/
      page = $1
      @part = $2
      
      page = '/' if page.blank?
      @page = Page.find_by_url(page, true)
      
      if !@page
        @page = Page.find_by_url(url, true)
        @part = :body
      end
    else
      @page = Page.find_by_url(url, true)
      @part = :body
    end

    render :text => @page.render_part(@part)
    @cache.cache_response('/page/' + url, response) if request.get? and @page.cache?
  end
end
