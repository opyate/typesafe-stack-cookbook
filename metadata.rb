maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs the Typesafe Stack."
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"

recipe "typesafe_stack", "Installs the Typesafe Stack"


%w{ debian ubuntu amazon }.each do |os|
  supports os
end
