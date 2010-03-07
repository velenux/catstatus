require 'rubygems'
require 'sinatra'
require 'erubis'
require 'sass'

# we'll use that for messages/errors
enable :sessions

version  = '0.0.2'

# needs l10n, i18n, whatever
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
  # vars for the view
  @statuses = statuses
  @version  = version
  # store messages for the view
  @messages = session['messages'] || []
  # empty cookie!
  session['messages'] = []
  # render view
  erb :index
end

get '/style.css' do
  sass :style
end

get '/status/add/:status' do
  timestamp = Time.now
  @statuses = statuses
  session['messages'] << "#{timestamp}: il gatto #{@statuses[params[:status].to_i]}."
  #puts "[#{timestamp}]\nil gatto #{@statuses[params[:status].to_i]} (status: #{params[:status]})\n\n"
  redirect '/'
end

