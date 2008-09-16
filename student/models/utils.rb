# This contains objects that aren't first-class (don't have their own
# collection in the database).

class Address

  def initialize(s="", c="", st="", pc="")
    @street, @city, @state, @postal_code = s, c, st, pc
  end

  def to_s
    "#{street}\n#{city}, #{state} #{postal_code}"
  end

end

# Grade for a class
class Score

  def initialize(course, grd)
    @for_course, @grade = course, grd
  end

  def passed?
    @grade >= 2.0
  end

  def to_s
    "#{@for_course}: #@grade"
  end

end
