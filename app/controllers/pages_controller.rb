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

    if @page.has_part?(@part)
      render :text => @page.render_part(@part)
    elsif @page.inherits_part?(@part)
      anc = @page.ancestors.detect{|a| a.has_part?(@part) }
      if anc
        part = anc.part(@part)
        render :text => @page.send(:parse_object, part)
      end
    end

    if self.cache
      cache.cache_response('/page/' + url, response) if request.get? and @page.cache?
    end
  end
end
