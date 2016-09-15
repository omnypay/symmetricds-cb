name 'symmetricds'
maintainer 'OmnyPay Ops'
maintainer_email 'ops@omnypay.net'
license 'all_rights'
description 'Installs/Configures symmetricds'
long_description 'Installs/Configures symmetricds'
version          IO.read(File.join(File.dirname(__FILE__), 'VERSION')).chomp rescue '0.0.1'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
issues_url 'https://github.com/omnypay/symmetricds/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
source_url 'https://github.com/omnypay/symmetricds' if respond_to?(:source_url)

%w(apt java).each do |dependency|
    depends dependency
end
