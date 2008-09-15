require 'model'

if $request["name"].nil?
  IO.foreach( File.join(File.dirname(__FILE__), "help.html")) {|line| puts line}
else
  puts "name: <b>#{ $request.name }</b><br>"

  m = MyModel.find($request.name)
  if m
    m.inc
  else
    m = MyModel.new($request.name)
  end
  $db.ms.save(m)

  puts "name: <b>#{ m.name }</b><br>"
  puts "count: <b>#{ m.counter.to_i }</b><br>"
  puts "<br/>"
  puts "<a href='http://127.0.0.1:8080'>Instructions</a>"
end
