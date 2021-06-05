#Clean Dataset
Response.all.map { |c| c.destroy }
Outcome.all.map { |c| c.destroy }
Survey.all.map { |s| s.destroy }
Career.all.map { |c| c.destroy }
Choice.all.map { |c| c.destroy }
Question.all.map { |c| c.destroy }

#Create Questions
primera = Question.create(name: 'primera', description: 'Me trasladaría a una zona agrícola - ganadera para ejercer mi profesión')

#Create Choices
Choice.create(text: 'si', question_id: primera.id)
Choice.create(text: 'no', questions: primera.id)

#Create Careers
Career.create(name: 'Computacion', description: ' ')
Career.create(name: 'Veterinaria', description: ' ')
Career.create(name: 'Agronomia', description: ' ')
Career.create(name: 'Arquitectura', description: ' ')
Career.create(name: 'Arte', description: ' ')
Career.create(name: 'Economía', description: ' ')
Career.create(name: 'Educación física', description: ' ')
Career.create(name: 'Filosofía', description: ' ')
Career.create(name: 'Física', description: ' ')
Career.create(name: 'Geología', description: ' ')
Career.create(name: 'Historia', description: ' ')
Career.create(name: 'Literaruta', description: ' ')
Career.create(name: 'Matemáticas', description: ' ')
Career.create(name: 'Medicina', description: ' ')
Career.create(name: 'Periodismo', description: ' ')
Career.create(name: 'Química', description: ' ')
Career.create(name: 'Sociología', description: ' ')

#Create Surveys

#Create Outcomes

#Create Responses