#
# Cookbook Name:: nginx
# Recipe:: ngx_pagespeed_module
#
# Author:: Christos Kapasakalidis (<xkapasakal@gmail.com>)
#
# Copyright 2014, Christos Kapasakalidis
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ngx_pagespeed_url = node['nginx']['ngx_pagespeed']['url']

include_recipe 'build-essential::default'

ngx_pagespeed_src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/ngx_pagespeed-#{node['nginx']['ngx_pagespeed']['version']}.zip"

packages = value_for_platform_family(
    %w[default]     => %w[unzip]
)

packages.each do |name|
  package name
end

remote_file ngx_pagespeed_url do
  source   ngx_pagespeed_url
  checksum node['nginx']['ngx_pagespeed']['checksum']
  path     ngx_pagespeed_src_filepath
  backup   false
end

ngx_pagespeed_dir  = "#{Chef::Config['file_cache_path'] || '/tmp'}/ngx_pagespeed-#{node['nginx']['ngx_pagespeed']['version']}"

bash 'unarchive_ngx_pagespeed_source' do
  cwd  ::File.dirname(ngx_pagespeed_src_filepath)
  code <<-EOH
    unzip #{::File.basename(ngx_pagespeed_src_filepath)}
  EOH
  not_if { ::File.directory?("#{Chef::Config['file_cache_path'] || '/tmp'}/ngx_pagespeed-#{node['nginx']['ngx_pagespeed']['version']}") }
end


#$ cd ngx_pagespeed-1.7.30.3-beta/
#$ wget https://dl.google.com/dl/page-speed/psol/1.7.30.3.tar.gz
#$ tar -xzvf 1.7.30.3.tar.gz # expands to psol/

pagespeed_psol_url = node['nginx']['ngx_pagespeed']['psol']['url']
pagespeed_psol_src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/ngx_pagespeed-#{node['nginx']['ngx_pagespeed']['version']}/pagespeed_psol-#{node['nginx']['ngx_pagespeed']['version']}.tar.gz"

remote_file pagespeed_psol_url do
  source   pagespeed_psol_url
  checksum node['nginx']['ngx_pagespeed']['psol']['checksum']
  path     pagespeed_psol_src_filepath
  backup   false
end

bash 'unarchive_ngx_pagespeed_psol_source' do
  cwd  ::File.dirname(pagespeed_psol_src_filepath)
  code <<-EOH
    tar -xzvf #{::File.basename(pagespeed_psol_src_filepath)}
  EOH
  not_if { ::File.directory?("#{Chef::Config['file_cache_path'] || '/tmp'}/ngx_pagespeed-#{node['nginx']['ngx_pagespeed']['version']}/psol") }
end

node.run_state['nginx_configure_flags'] =
    node.run_state['nginx_configure_flags'] | ["--add-module=#{ngx_pagespeed_dir}"]