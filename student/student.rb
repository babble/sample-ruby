require 'models/student'

# DEBUG
class Object
  def method_missing sym, *args
    msg = "method_missing: symbol = #{sym}, args = #{args.join(', ')}, class of self = #{self.class.name}"
    puts "<p style='color:red;'>#{msg}</p>"
    $stderr.puts "**** #{msg}"
  end
end

action = $request.action.downcase
data = {}

if action == "list"
  data['ss'] = Student.find().limit(50).sort(:name => 1)
  $djang10.get_template('/views/students').call(data)
  return
end

my_student = Student.find($request.s__id)
if action == "delete"
  my_student.remove
  $response.sendRedirectTemporary("/students")
  return
end
    
data['courses'] = Course.find
msg = ''

if action == "save"
  $Forms.fillInObject("s_" , my_student , $request)
  if my_student._new
    my_student._new = nil
  end
        
  my_student.save
  data['msg'] = "Saved"
end
    
if action == "add" && $request.course_for
  c = Course.findOne($request.course_for)
  if !c
    data['msg'] = "Can't find course"
  else
    my_student.add_score(c , $request.score)
    my_student.save
  end
end
    
# TODO
my_student._form = $Forms.Form(my_student , "s_")
    
data['s'] = my_student

$djang10.get_template('/views/student').call(data)