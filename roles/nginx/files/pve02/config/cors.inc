map $http_origin $allow_origin {
  default "*";
  ~^https?://(.*\.)?example\.biz(:\d+)?$ $http_origin;
}

map $request_method $cors_method {
  default "allowed";
  "OPTIONS" "preflight";
}

map $cors_method $cors_max_age {
  default "";
  "preflight" 3600;
}

map $cors_method $cors_allow_methods {
  default "";
  "preflight" "GET, POST, OPTIONS";
}

map $cors_method $cors_allow_headers {
  default "";
  "preflight" "Authorization,Content-Type,Accept,Origin,User-Agent,DNT,Cache-Control,X-Mx-ReqToken,Keep-Alive,X-Requested-With,If-Modified-Since";
}

# map $cors_method $cors_content_length {
#   default $initial_content_length;
 #  "preflight" 0;
# }

#map $cors_method $cors_content_type {
#  default $initial_content_type;
#  "preflight" "text/plain charset=UTF-8";
#}
