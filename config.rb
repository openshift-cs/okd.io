###
# Settings
###
set :site_title, "OpenShift Origin"
set :site_url, 'https://www.openshift.org/'
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
page "/sitemap.xml", layout: false

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
configure :development do
  activate :php
end

# Build-specific configuration
configure :build do
  config.ignored_sitemap_matchers[:source_dotfiles] = proc { |file|
    file =~ %r{/\.} && file !~ %r{/\.(s2i|openshift|htaccess|htpasswd|nojekyll|git)|containers}
  }

  activate :minify_css
  activate :minify_javascript
end
