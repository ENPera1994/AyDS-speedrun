#Clean Dataset
Survey.all.map { |s| s.detroy }
Career.all.map { |c| c.detroy }

#Create Careers
Career.create(name: 'Computacion', description: 'Duracion 5 años, https://www.unrc.edu.ar/unrc/carreras/ProgAsig2.php?n=BatVf5iHwU0Fx5G7YNW8kNLQ%2BhOdQH4W7AWg7BMXHW8%3D')
Career.create(name: 'Veterinaria', description: 'Duracion 5 años y medio, https://www.unrc.edu.ar/unrc/carreras/ayv_medicina_veterinaria.htm')