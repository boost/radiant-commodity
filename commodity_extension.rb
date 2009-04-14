# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class CommodityExtension < Radiant::Extension
  version "0.1"
  description "Provides URLs to grab content without layouts"
  url "http://github.com/boost/radiant-commodity"
  
  define_routes do |map|
    map.resources :snippets
    map.connect 'page/*url', :controller => 'pages', :action => 'show'
  end
  
  def activate
  end
  
  def deactivate
  end
end
