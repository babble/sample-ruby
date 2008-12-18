# Note that we can use Ruby for the _init file. However, instead of just
# defining a method named mapUrlToJxpFile, we need to create a Proc and store
# it in the 'mapUrlToJxpFile' slot of the global scope.
#
# $mapUrlToJxpFile is a JSFunction object. We can simply assign a new value to
# it which is a Proc. There is more than one way to write this:
#
#   $mapUrlToJxpFile = Proc.new ...
#   $scope['mapUrlToJxpFile'] = Proc.new ...
#   $scope.mapUrlToJxpFile = Proc.new ...
#
# The first method works because all $scope slots are turned into globals.

$mapUrlToJxpFile = Proc.new { |uri, req|
  if uri =~ /^.(\w+)$/
    req['name'] = $1
  end
  "controller.rb"
}
