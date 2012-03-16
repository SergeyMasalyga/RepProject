require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'data_mapper'
require 'dm-timestamps'
require 'dm-validations'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/pdbm.db")

class Project
include DataMapper::Resource

property :id, Serial
property :title, String
property :description, Text
property :platforms, String
property :tools, String
property :create_at, DateTime
has n, :records

end


class Record
include DataMapper::Resource
property :id, Serial
property :reporting_time, String
property :description, Text
property :spent_time, String 
property :create_at, DateTime

#validates_format_of :spent_time, :with => /^([01]?[0-9]|2[0-3]):[0-5][0-9]$/
belongs_to :project
belongs_to :user
end

class User
include DataMapper::Resource
property :id, Serial
property :login, String
property :name, String
property :password, String
property :email, String
property :position, String
property :created_at, DateTime
property :admin, Boolean
has n, :records
end

DataMapper.finalize
DataMapper.auto_upgrade!
