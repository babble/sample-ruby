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

if action == "list"
  ss = Student.find().limit(50).sort(:name => 1)
  require 'views/students'
  return
end

my_student = Student.find($request.s__id)
if action == "delete"
  my_student.remove
  $response.sendRedirectTemporary("/students")
  return
end
    
courses = Course.find
msg = ''

if action == "save"
  $Forms.fillInObject("s_" , my_student , $request)
  if my_student._new
    my_student._new = nil
  end
        
  my_student.save
  msg = "Saved"
end
    
if action == "add" && $request.course_for
  c = Course.findOne($request.course_for)
  if !c
    msg = "Can't find course"
  else
    my_student.add_score(c , $request.score)
    my_student.save
  end
end
    
# TODO
my_student._form = $Forms.Form(my_student , "s_")
    
s = my_student
    
require 'views/student'
