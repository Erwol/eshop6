xml.instruct!
xml.rss("version" => "2.0","xmlns:dc" =>
    "http://purl.org/dc/elements/1.1/") do
  xml.channel do
    xml.title@pagetitle
    xml.description "Merchuca - La tienda de la UCA"
    xml.link url_for :action => 'index', :only_path => false
    xml.language "es−es"
    xml.ttl "60"
    for article in @articles do
      xml.item do
        xml.title article.name
        xml.description "Artículo: #{article.name} por #{article.provider.name}"
        xml.link url_for :action => "show", :id => article, :only_path => false
        xml.guid url_for :action => "show", :id => article, :only_path => false
        xml.pubDate article.created_at.to_s :long
      end
    end
  end
end