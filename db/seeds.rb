#Clean Dataset
Response.all.map { |c| c.destroy }
Outcome.all.map { |c| c.destroy }
Survey.all.map { |s| s.destroy }
Career.all.map { |c| c.destroy }
Choice.all.map { |c| c.destroy }
Question.all.map { |c| c.destroy }


#Create Questions   #using numbers as names of questions is provisory
Question.create(name: '1. ', description: 'Me trasladaría a una zona agrícola - ganadera para ejercer mi profesión')
Question.create(name: '2. ', description: 'Tengo buena memoria y no me cuesta estudiar y retener fórmulas y palabras técnicas.')
Question.create(name: '3. ', description: 'Me gusta escribir. En general mis trabajos son largos y están bien organizados.')
Question.create(name: '4. ', description: 'Sé quien es Steven Hawking: Conozco y me atraen sus descubrimientos.')
Question.create(name: '5. ', description: 'Me actualizo respecto de los avances tecnológicos y me intereso por investigar y conocer')
Question.create(name: '6. ', description: 'Sé quien es Andy Warhol y a qué movimiento artístico pertenece. Me apasiona conocer acerca del arte y sus exponentes.')
Question.create(name: '7. ', description: 'En general me intereso por las dificultades que ha tenido que atravesar la humanidad y cómo lo ha superado.')
Question.create(name: '8. ', description: 'Me apasiona leer y no me importa si el libro que elijo tiene muchas páginas, para mí es un gran entretenimiento.')
Question.create(name: '9. ', description: 'Me atrae conocer los procesos y las áreas que hacen funcionar a las empresas.')
Question.create(name: '10. ', description: 'Me siento identificado con el pensamiento de algunos filósofos y escritores.')
Question.create(name: '11. ', description: 'Me encanta estudiar el cuerpo humano y conocer cómo funciona. Además, no me impresiona la sangre.')
Question.create(name: '12. ', description: 'Si pudiera elegir, pasaría mucho tiempo diseñando novedosos objetos o edificios en mi computadora.')
Question.create(name: '13. ', description: 'Si mi blog fuera temático, trataría acerca de:')
Question.create(name: '14. ', description: 'Integraría un equipo de trabajo encargado de producir un audiovisual sobre:')
Question.create(name: '15. ', description: 'Sería importante destacarme como:')


#Create Choices
@questions = Question.all
Choice.create(text: 'si', question_id: @questions[0].id)
Choice.create(text: 'no', question_id: @questions[0].id)
Choice.create(text: 'si', question_id: @questions[1].id)
Choice.create(text: 'no', question_id: @questions[1].id)
Choice.create(text: 'si', question_id: @questions[2].id)
Choice.create(text: 'no', question_id: @questions[2].id)
Choice.create(text: 'si', question_id: @questions[3].id)
Choice.create(text: 'no', question_id: @questions[3].id)
Choice.create(text: 'si', question_id: @questions[4].id)
Choice.create(text: 'no', question_id: @questions[4].id)
Choice.create(text: 'si', question_id: @questions[5].id)
Choice.create(text: 'no', question_id: @questions[5].id)
Choice.create(text: 'si', question_id: @questions[6].id)
Choice.create(text: 'no', question_id: @questions[6].id)
Choice.create(text: 'si', question_id: @questions[7].id)
Choice.create(text: 'no', question_id: @questions[7].id)
Choice.create(text: 'si', question_id: @questions[8].id)
Choice.create(text: 'no', question_id: @questions[8].id)
Choice.create(text: 'si', question_id: @questions[9].id)
Choice.create(text: 'no', question_id: @questions[9].id)
Choice.create(text: 'si', question_id: @questions[10].id)
Choice.create(text: 'no', question_id: @questions[10].id)
Choice.create(text: 'si', question_id: @questions[11].id)
Choice.create(text: 'no', question_id: @questions[11].id)
Choice.create(text: 'si', question_id: @questions[12].id)
Choice.create(text: 'no', question_id: @questions[12].id)
Choice.create(text: 'La importancia de la expresión artística en el desarrollo de la identidad de los pueblos.', question_id: @questions[13].id)
Choice.create(text: 'La arquelogía urbana como forma de aprender acerca de la historia cultural de una ciudad.', question_id: @questions[13].id)
Choice.create(text: 'La tecnología satelital en un proyecto para descubrir actividad volcánica para prevenir catástrofes climáticas.', question_id: @questions[13].id)
Choice.create(text: 'Ninguna de las opciones.', question_id: @questions[13].id)
Choice.create(text: 'La práctica de deportes y su influencia positiva en el estado de ánimo de las personas.', question_id: @questions[13].id)
Choice.create(text: 'Los pensadores del siglo XX y su aporte a la gestión de las organizaciones.', question_id: @questions[13].id)
Choice.create(text: 'Las mascotas y su incidencia en la calidad de vida de las personas no videntes.', question_id: @questions[13].id)
Choice.create(text: 'El uso de la PC como herramienta para el control de los procesos industriales.', question_id: @questions[13].id)
Choice.create(text: 'Procesos productivos de una empresa.', question_id: @questions[13].id)
Choice.create(text: 'Ninguna de las opciones.', question_id: @questions[13].id)
Choice.create(text: 'Director de una investigación técnico científica', question_id: @questions[14].id)
Choice.create(text: 'Gerente general de una empresa reconocida por su responsabilidad social.', question_id: @questions[14].id)
Choice.create(text: 'Un deportista famoso por su destreza física y su ética profesional.', question_id: @questions[14].id)
Choice.create(text: 'Experto en la detección precoz de enfermedades neurológicas en niños.', question_id: @questions[14].id)
Choice.create(text: 'Un agente de prensa audaz, número uno en el ranking de notas a celebridades.', question_id: @questions[14].id)
Choice.create(text: 'Ninguna de las opciones.', question_id: @questions[14].id)


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

