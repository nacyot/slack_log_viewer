require 'sinatra/base'
require 'json'
require 'twemoji'
require 'cgi'
require 'date'

# Main class of Slack Log Viewer. Sinatra app.
#
# @since 0.1
class SlackLogViewer < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/node_modules'
  set :public_folder, File.dirname(__FILE__) + '/static'

  before do
    files = ['users.json', 'channels.json']

    unless request.path_info =~ /not_log_dir/
      unless files.all? { |file| File.exist?(settings.log_dir + '/' + file) }
        redirect '/not_log_dir'
      end
    end
  end

  get '/' do
    locals = { channels: channels }
    haml :index, locals: locals
  end

  get '/channels/:channel' do
    locals = {
      channels: channels,
      channel: params[:channel],
      dates: dates(params[:channel])
    }

    haml :channel, locals: locals
  end

  get '/channels/:channel/:day' do
    indexed_dates = dates(params[:channel])
    today_index = indexed_dates.find_index do |day|
      day == params[:day]
    end
    prev_day = indexed_dates[today_index - 1]
    next_day = indexed_dates[today_index + 1]

    locals = {
      channels: channels,
      channel: params[:channel],
      dates: indexed_dates,
      day: params[:day],
      prev_day: prev_day,
      next_day: next_day,
      logs: logs(params[:channel], params[:day])
    }

    haml :day, locals: locals
  end

  get '/not_log_dir' do
    haml :not_log_dir
  end

  private

  def channels
    Dir["#{settings.log_dir}/*"]
      .select { |e| e !~ /\.json/ }
      .map { |e| File.basename(e) }
  end

  def dates(channel)
    Dir["#{settings.log_dir}/#{channel}/*"]
      .map { |e| File.basename(e, '.json') }
      .sort
      .reverse
  end

  def logs(channel, day)
    date = Date.parse(day)
    logs = JSON.load(File.read("#{settings.log_dir}/#{channel}/#{day}.json"))
    logs = logs.reject do |log|
      date.year != Time.at(log['ts'].to_i).year
    end

    parse(logs)
  end

  def parse(logs)
    user_dic = users_data
    ch_dic = channels_data

    logs.map do |log|
      log['user'] = user_dic[log['user']]
      log['raw_text'] = log['text']
      log['text'] =
        log['text']
        .gsub(/simple_smile/, 'smile')
        .gsub(/<@(.*?)(\|.*?)?>/){ "@#{user_dic[$1]['name']}" }
        .gsub(/<#(.*?)(\|.*?)?>/){ $2 ? "##{$2[1..-1]}" : "##{ch_dic[$1]['name']}" }
        .gsub(/<(.*?)(\|.*?)?>/, "<a href='\\1'>\\1</a>")
        .gsub(/```(.*?)```/m){ "<pre>#{ $1.strip if $1 }</pre>" }
        .gsub("\n", '<br />')
      log
    end
  end

  def users_data
    Hash[
      *JSON
        .load(File.read("#{settings.log_dir}/users.json"))
        .map { |user| [user['id'], user] }
        .flatten
    ]
  end

  def channels_data
    Hash[
      *JSON
        .load(File.read("#{settings.log_dir}/channels.json"))
        .map { |ch| [ch['id'], ch] }
        .flatten
    ]
  end
end
