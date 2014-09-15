require 'fileutils'
require "mini_magick"

#resize function
def uploadoriginal(file,path,newsize)
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

    image = MiniMagick::Image.open(file)
    
  	image.resize newsize
    
  	#processed image filename
  	finalname = path + filename_orig + extfinal
  	image.write(finalname){ self.quality(100) }
    return filename_orig + extfinal
   
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

#new size
puts "nuevo size"  
	STDOUT.flush  
	@newsize = gets.chomp
	
unless @newsize > 0.to_s
	puts "error en nuevo size"
	exit
end
		

#leo el contenido de la carpeta
dirListing = Dir.entries(folder_path)


dirListing.each { |file| 

	accepted_formats = [".JPG", "JPEG", ".PNG", ".GIF"]
	ext = File.extname(file)
	
	if accepted_formats.include? ext.upcase
		
		puts " Procesando: #{ext} | (#{file})"
		#carpeta para guardar procesadas (salida)
		#processed images folder (output)
		#if not exits = 
		
		
		
		@origen = "#{folder_path}/#{file}"
		
		uploadoriginal(@origen,@path,@newsize)
	else
		puts "Formato no valido #{ext} | (#{file})"
	end
	file = nil
	
}
puts "Proceso finalizado!"
exit
