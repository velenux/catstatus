require 'rubygems'
require 'sinatra'
require 'haml'

set :haml, {:format => :html5 } # default Haml format is :xhtml

statuses = {
    0 => 'Non raggiungibile, non pervenuto',
    1 => 'Dorme',
    2 => 'Sonnecchia e/o si fa fare le coccole',
    3 => 'Guarda fuori dalla finestra',
    4 => 'Fissa un punto sopra la vostra testa',
    5 => 'Si aggira per casa',
    6 => 'Gioca moderatamente',
    7 => 'Gioca rumorosamente',
    8 => 'Si comporta da pazzo',
    9 => 'Posseduto da forze demoniache'
}

get '/' do
  @statuses = statuses
  haml :index
end

get '/status/add/:status' do
  @statuses = statuses
  puts "[#{Time.now}] Called with status: #{params[:status]}\n"
  redirect '/'
end

