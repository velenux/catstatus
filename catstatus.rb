require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'

version  = '0.0.1'
statuses = {
    0 => 'Non è in zona',
    1 => 'Dorme',
    2 => 'Sonnecchia e/o si fa fare le coccole',
    3 => 'Guarda fuori dalla finestra',
    4 => 'Fissa un punto sopra la vostra testa',
    5 => 'Si aggira per casa',
    6 => 'Mangia',
    7 => 'Gioca moderatamente',
    8 => 'Gioca rumorosamente',
    9 => 'Si comporta da pazzo',
  10 => 'E` Posseduto da forze demoniache'
}

get '/' do
  #content_type 'text/html', :charset => 'utf-8'
  @statuses = statuses
  @version  = version
  set :haml, {:format => :html5, :lang => 'it', :charset => 'utf-8' } # default Haml format is :xhtml
  haml :index
end

get '/style.css' do
  sass :style
end

get '/status/add/:status' do
  @statuses = statuses
  puts "
[#{Time.now}] 
il gatto #{@statuses[params[:status].to_i]}
(valore: #{params[:status]})

"
  redirect '/'
end

