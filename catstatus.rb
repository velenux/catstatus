require 'rubygems'
require 'sinatra'
require 'erubis'
require 'sass'

# we'll use that for messages/errors
enable :sessions
version  = '0.0.2'

# we'll move that in a lib maybe!
class Status
  attr_reader :timestamp
  
  # needs l10n, i18n, whatever
  @@statuses = {
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

  # class method!
  def self.statuses
    @@statuses
  end
  
  def initialize(id)
    @timestamp = Time.now
    # set default to 0
    @status = @@statuses.keys.first

    # if it's a number and a valid status
    if (id.class == Fixnum and @@statuses[id])
      @status = id
    else # if it's not a number, but converted 
         # it is a valid status
      if @@statuses[id.to_i]
	@status = id.to_i
      end
    end

    self
  end
  
  def to_s
    "#{@timestamp} -> #{@@statuses[@status]}"
  end
  
  def save # stub
    puts "\n\nSaving... at #{@timestamp} the cat #{@@statuses[@status]}\n\n"
    true
  end
  
  def verbose_status
    @@statuses[@status]
  end
  
end


# main
get '/' do
  # FIXME: move to before... do
  # vars for the view
  @statuses = Status.statuses
  @version  = version
  # store messages for the view
  @messages = session['messages'] || []
  @errors   = session['errors']   || []
  # empty cookie!
  session['messages'] = []
  session['errors']   = []
  # render view
  erb :index
end

# CSS
get '/style.css' do
  sass :style
end

# not REST, but simple
get '/status/add/:status' do
  # FIXME: move to before... do
  @statuses = Status.statuses
  
  # FIXME: move to before... do
  if session['errors'].nil?
    session['errors'] = []
  end

  # FIXME: move to before... do
  if session['messages'].nil?
    session['messages'] = []
  end
  
  # if valid, store it
  if ( params[:status].match(/^\d+$/) and @statuses[ params[:status].to_i ] )

    entry = Status.new( params[:status].to_i )
    if entry.save
      session['messages'] << "#{entry.timestamp}: il gatto #{entry.verbose_status}"
    else
      session['errors'] << "Can't save entry at #{entry.timestamp}!"
    end
  else
    session['errors'] << "Invalid parameter #{params[:status]}!"
  end
  redirect '/'
end

