#
# Cookbook Name:: nginx
# Attributes:: ngx_pagespeed
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

default['nginx']['ngx_pagespeed']['url']              = 'https://github.com/pagespeed/ngx_pagespeed/archive/v1.7.30.3-beta.zip'
default['nginx']['ngx_pagespeed']['checksum']         = '0b9cb0fc13c3d00a98452fa93de1c0f5dc3ab535fcb4def866e6ec215eb9f423'
default['nginx']['ngx_pagespeed']['version']          = '1.7.30.3-beta'
default['nginx']['ngx_pagespeed']['psol']['url']      = 'https://dl.google.com/dl/page-speed/psol/1.7.30.3.tar.gz'
default['nginx']['ngx_pagespeed']['psol']['checksum'] = '44e050877be1d03fc4e435c205f59165ae0bab8b78be32916d83af21e093b020'
