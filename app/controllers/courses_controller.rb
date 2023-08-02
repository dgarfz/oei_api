class CoursesController < ApplicationController
  before_action :set_courses, only: %i[ radar ]

  def radar
    render json: @courses.order(:date).group_by(&:date).map{|date, courses| {"date": date.strftime("%Y-%m-%d"), courses: courses.pluck("name")}}
  end

  private
    def set_courses
      if params["criteria"].include? "closest"
        @courses = Course.closest
      end
      if params["criteria"].include? "latest"
        @courses = Course.latest
      end
      if params["criteria"].grep(/^type-/).present?
        type = Type.find_by name: params["criteria"].grep(/^type-/).join.sub("type-", '')

        @courses ||= Course.all
        @courses = @courses.where(type: type)
      end
      if params["criteria"].grep(/^school-/).present?
        school = School.find_by name: params["criteria"].grep(/^school-/).join.sub("school-", '')

        @courses ||= Course.all
        @courses = @courses.where(school: school)
      end

      if params["editions"].present?
        courses = []
        params["editions"].each do |edition|
          courses += edition["courses"].map{|course| "(date = '#{DateTime.parse(edition["date"]).to_formatted_s(:db)}' AND name = '#{course["name"]}' AND type_id = #{Type.find_by(name: course["type"]).id})"}
          #courses += edition["courses"].map{|course| { date: DateTime.parse(edition["date"]), name: course["name"],  type: Type.find_by(name: course["type"]).id}}
        end
        
        @courses = @courses.where(courses.join(" OR "))
      end
    end    
end
