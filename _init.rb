# Note that we can use Ruby for the _init file. However, instead of just
# defining a method named mapUrlToJxpFile, we need to create a Proc and store
# it in the 'mapUrlToJxpFile' slot of the global scope object.
#
# The syntax $scope.mapUrlToJxpFile is the same as $scope['mapUrlToJxpFile'].
# The JSObject class creates accessor methods on the fly.

$scope.mapUrlToJxpFile = Proc.new { |uri, req|
  if uri =~ /^.(\w+)$/
    req['name'] = $1
    "/controller.rb"
  end
}
