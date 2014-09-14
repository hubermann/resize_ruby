require 'RMagick'
require 'fileutils'


#resize function
def uploadoriginal(file,path)
	ext = File.extname(file)
  	if ext.upcase == ".JPG"
  		extfinal = ".jpg"
  	elsif ext.upcase == ".JPEG"
  		extfinal = ".jpg"
  	elsif ext.upcase == ".GIF"
  		extfinal = ".gif"
  	elsif ext.upcase == ".PNG"
  		extfinal = ".png"
  	end	
		
		
  	#nombre original de la imagen
  	filename_orig = File.basename(file, '.*')

  	#remove white space in image name
  	filename_orig = filename_orig.gsub(" ","-")

  	width = 1200

  	image = Magick::Image.read(file).first

  	widthimage = image.columns
  	heightimage = image.rows
  	height = (width * heightimage) / widthimage
  	thumbnail = image.thumbnail(width, height)

  	#processed image filename
  	finalname = path + filename_orig + extfinal
  	q=99
  	thumbnail.write(finalname){ self.quality = q }
    return filename_orig + extfinal
    
    ext =nil 
    thumbnail = nil 
    filename_orig = nil
    widthimage = nil 
    image=nil
end

#preguntas al usuario 

#carpeta de imagenes originales
#originals images folder
puts "nombre de la carpeta con imagenes?"  
	STDOUT.flush  
	folder_path = gets.chomp
	
unless File.directory?(folder_path)
	puts "No se encuentra carpeta con imagenes"
	exit
end

puts "nombre de la carpeta destino?"  
	STDOUT.flush  
	destination_folder = gets.chomp

unless File.directory?(destination_folder)
  FileUtils.mkdir_p(destination_folder)
end
@path = "#{destination_folder}/"


		

#leo el contenido de la carpeta
dirListing = Dir.entries(folder_path)

counter = 0
dirListing.each { |file| 

	accepted_formats = [".JPG", "JPEG", ".PNG", ".GIF"]
	ext = File.extname(file)
	
	if accepted_formats.include? ext.upcase
		counter = counter+1
		puts "#{counter} >> Procesando: #{ext} | (#{file})"
		#carpeta para guardar procesadas (salida)
		#processed images folder (output)
		#if not exits = 
		
		
		
		@origen = "#{folder_path}/#{file}"
		
		uploadoriginal(@origen,@path)
	else
		puts "Formato no valido #{ext} | (#{file})"
	end
	file = nil
	
}
puts "Proceso finalizado!"
exit