require 'ancestree'

class ActiveRecord::Base
  include InheritAncestorAttributes
end