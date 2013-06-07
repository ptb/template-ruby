author = data.authors.author1

feed_name = author[:org]
org_full_url = author[:org_full_url]
org_description = author[:org_description]

xml.instruct!
xml.rss :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title feed_name
    xml.link "#{org_full_url}/"
    xml.description org_description
    xml.atom :link, :href => "#{org_full_url}/subscribe/index.rss", :rel => 'self', :type => 'application/rss+xml'
    unless blog.articles.empty?
      xml.pubDate blog.articles.first.date.to_time.rfc2822
    end

    unless blog.articles.empty?
      blog.articles.each do |article|
        xml.item do
          xml.title article.title
          xml.link "#{org_full_url}#{article.url}"
          xml.guid "#{org_full_url}#{article.url}"
          xml.pubDate article.date.to_time.rfc2822
          xml.description article.body
        end
      end
    end
  end
end
