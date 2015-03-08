#
# Cookbook Name:: example.com
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'openresty'

# create directories
%w[ /var/www/example.com /var/www/example.com/public_html ].each do |path|
  directory path do
    owner 'www-data'
    group 'www-data'
    mode '0755'
    action :create
  end
end

# set permissions
directory "/var/www" do
  mode '0755'
  action :create
end

# write html file
cookbook_file "/var/www/example.com/public_html/index.html" do
  source "index.html"
  mode "0644"
end

# write openresty configuration file
cookbook_file "/etc/nginx/sites-available/example.com" do
  source "example.com"
  mode "0644"
end

# symlink openrest configuration file
link "/etc/nginx/sites-enabled/example.com" do
  to "/etc/nginx/sites-available/example.com"
end

# restart openresty
service 'nginx' do
  action [ :enable, :restart ]
end
