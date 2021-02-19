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
#page "/blog.html", :layout => "blog"

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
end

activate :autoprefixer do |prefix|
    prefix.browsers = "last 2 versions"
end

activate :syntax #, :line_numbers => true

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true, :tables => true, :quote => true

# Build-specific configuration
configure :build do
  config.ignored_sitemap_matchers[:source_dotfiles] = proc { |file|
    file =~ %r{/\.} && file !~ %r{/\.(s2i|openshift|htaccess|htpasswd|nojekyll|git)|containers}
  }

  activate :minify_css
  activate :minify_javascript
end
