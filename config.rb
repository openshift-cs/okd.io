###
# Settings
###
set :site_title, "OKD"
set :site_url, 'https://www.okd.io/'
set :openshift_assets, 'https://assets.openshift.net/content'


###
# Assets
###
set :css_dir, 'css'
set :fonts_dir, 'fonts'
set :images_dir, 'img'
set :js_dir, 'js'

###
# Page command
###
#page "/sitemap.xml", layout: false
page "/", :layout => "layout"
page "/blog.html", :layout => "blog"

###
# Extra Helpers
###
helpers do
  def label_to_name(label)
    label.downcase.gsub(" ","_")
  end
end

#ignore accelerators page(s)
ignore 'accelerators/*'

# Development-specific configuration
#configure :development do
#  activate :php
#end

activate :blog do |blog|
    # set options on blog
    blog.tag_template = "tag.html"
    blog.calendar_template = "calendar.html" 
    blog.layout = "article_layout"
    blog.prefix = "blog"
end

activate :syntax #, :line_numbers => true

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true, :tables => true, :quote => true

# Build-specific configuration
configure :build do
  # JM: Creates warnings in the build process. I'm not sure if we even need that.
  #  config.ignored_sitemap_matchers[:source_dotfiles] = proc { |file|
  #    file =~ %r{/\.} && file !~ %r{/\.(s2i|openshift|htaccess|htpasswd|nojekyll|git)|containers}
  #  }

  activate :minify_css
  activate :minify_javascript
end

activate :search do |search|
  search.resources = ['blog/']
  search.index_path = 'search/lunr-index.json' # defaults to `search.json` 
  search.lunr_dirs = ['source/vendor/lunr-custom/'] # optional alternate paths where to look for lunr js files
  #search.language = 'es' # defaults to 'en'

  search.fields = {
    title:   {boost: 100, store: true, required: true},
    content: {boost: 50},
    url:     {index: false, store: true},
    author:  {boost: 30}
  }
end