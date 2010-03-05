require 'rubygems'
require 'sinatra'
require 'haml'

set :haml, {:format => :html5 } # default Haml format is :xhtml

statuses = {
    0 => 'Non è in zona',
    1 => 'Dorme',
    2 => 'Sonnecchia e/o si fa fare le coccole',
    3 => 'Guarda fuori dalla finestra',
    4 => 'Fissa un punto sopra la vostra testa',
    5 => 'Si aggira per casa',
    6 => 'Gioca moderatamente',
    7 => 'Gioca rumorosamente',
    8 => 'Si comporta da pazzo',
    9 => 'E` Posseduto da forze demoniache'
}

get '/' do
  content_type 'text/html', :charset => 'utf-8'
  @statuses = statuses
  haml :index
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

