class SnippetsController < SiteController
  def show
    @snippet = Snippet.find_by_name(params[:id])
    @page = Page.new
    render :text => @page.render_snippet(@snippet)
  end
end
