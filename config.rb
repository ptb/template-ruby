Time.zone = 'America/New_York'

set :index_file, 'index.html'

set :css_dir, 'css'
set :images_dir, 'img'
set :js_dir, 'js'

page '*.atom', :layout => false
page '*.css', :layout => false
page '*.rss', :layout => false
page '*.xml', :layout => false

activate :blog do |blog|
  blog.sources = 'content/:title.html'
  blog.permalink = ':title.html'
  blog.default_extension = '.slim'

  blog.summary_separator = /(READMORE)/

  blog.paginate = true
  blog.per_page = 3
  blog.page_link = 'page-:num'

  blog.tag_template = 'articles.html'
  blog.taglink = ':tag/index.html'

  blog.calendar_template = false
  blog.year_link = ':year/index.html'
  blog.month_link = ':year/:month/index.html'
  blog.day_link = ':year/:month/:day/index.html'
end

activate :directory_indexes
set :relative_links, true
activate :relative_assets

Slim::Engine.set_default_options attr_quote: "'", format: :xhtml, pretty: true, shortcut: {'#' => {attr: 'id'}, '%' => {attr: 'itemprop'}, '&' => {tag: 'input', attr: 'type'}, '.' => {attr: 'class'}, '@' => {attr: 'role'}}, sort_attrs: true
::Compass.configuration.sass_options = {cache: false, line_comments: false, style: :expanded}

# activate :livereload, host: 'dev.example.com'

configure :build do
  Slim::Engine.set_default_options pretty: false
  ::Compass.configuration.sass_options = {style: :compressed}

  activate :asset_hash
  activate :minify_html, remove_quotes: false
  # activate :gzip, :exts => %w(.atom .css .html .js .rss .svg .txt .xhtml .xml .eot .otf .ttf)
end
