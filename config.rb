require 'tilt'

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir, 'fonts'
set :markdown_engine, :redcarpet
set :markdown,
  :disable_indented_code_blocks => true,
  :fenced_code_blocks           => true,
  :no_intra_emphasis            => true,
  :prettify                     => true,
  :smartypants                  => true,
  :tables                       => true,
  :with_toc_data                => true

# Activate the syntax highlighter
activate :syntax
activate :sprockets

# This is needed for Github pages, since they're hosted on a subdomain
activate :relative_assets
set :relative_links, true

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
