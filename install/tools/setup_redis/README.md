# Setup redis service for systemd

Requirements: 
+ [redis-trib.rb](https://github.com/antirez/redis/blob/unstable/src/redis-trib.rb) in etc/redis-trib.rb (you can find it at ```[REDIS SOURCE]/src/redis-trib.rb``` , and it dependence ruby).
+ prebuilt redis-server in **[REDIS_DIST]/bin/redis-server** (use ```make install PREFIX=[REDIS_DIST]```)
+ copy all files in **etc** into **[REDIS_DIST]/etc**

Use ```gem install redis``` to install redis module for ruby.
