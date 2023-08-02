# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


{"educacion": ["infantil", "competencias-digitales", "gobernanza"], "lenguas": ["portugues"], "ciencia-y-cultura": ["educacion-artistica", "divulgacion-cientifica"], "cooperacion": ["cooperacion"]}.each do |school, types|
    school = School.create({name: school})
    puts school
    types.each do |type|
        school.types.create({name: type})
        puts type
    end
end

[{date: "2023-09-01", name: "Comprendiendo el portugués", type: "portugues", school: "lenguas"},
{date: "2023-09-01", name: "Divulgación y cooperación en la ciencia", type: "divulgacion-cientifica", school: "ciencia-y-cultura"},
{date: "2023-06-01", name: "Divulgación y cooperación en la ciencia", type: "divulgacion-cientifica", school: "ciencia-y-cultura"},
{date: "2023-06-01", name: "Especialista en cooperación internacional", type: "cooperacion", school: "cooperacion"}].each do |course|
    c = Course.create({date: Date.parse(course[:date]), name: course[:name], type: Type.find_by(name: course[:type]), school: School.find_by(name: course[:school])})
    puts c
end