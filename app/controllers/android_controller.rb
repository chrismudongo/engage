class AndroidController < ApplicationController
  #1 = incorrect login details
  #2 = email already in use
  #3 = no item downloaded from server
  #4 = error uploading to server
  skip_before_action :verify_authenticity_token
  require 'mongo'
  require 'json'

  # POST method to verify user details on login
  def login
    # send paramaters of body
    email = params[ :email]
    password = params[ :password]
    # find student of username and password
    @user = User.where(email:email, password:password)
    if @user.nil? || @user == []
       #email and password match
       render plain: "Error:1"
    else
       render plain: "Login Success:"+@user[0]["user_group"]
       #render json: @user
    end
  end

  #POST method to add new user
  def new_user
    email = params[ :email]
    password = params[ :password]
    user_group = params[ :user_group]
    #check email is unique
    if User.where(email:email).blank?
      User.create( email: email, password: password, user_group: user_group )
      render plain: "SignUp Success:"+user_group
    else
      render plain: "Error:2"
    end
  end

  def get_content
    user_group = params[ :user_group]
    @content = GridFsFile.all
    temp = []

    @content.each do |x|
      if x.nil?

      else
        if x.user_group ==user_group
          tt =
          temp.push({path: contents_path(x.id), filename: x.filename, type: x.contentType, user_group: x.user_group, id: x.id, topic:x.topic, uploa$
        else

        end
      end
    end

   render json: temp
  end

   #POST method to download survey linked to newsItemID
  def get_survey
    survey_name = params[ :survey]
    #newsID = params[ :newsID]
    @survey = Survey.where(name:survey_name) #get matching survey
    if @survey.nil? || @content == []
      render plain: "Error:3"
    else
      render json: @survey[0]
    end
  end

   #POST method to upload user survey to DB, will only be TEXT
  def post_survey
    body = JSON.parse(request.body.read)
    email = body ["email"]
    surveyID = body["surveyID"]
    user_group = body["user_group"]
    responses = body["responses"]
    #newsID = body["NewsItem"]
    SurveyResponse.create(email: email, surveyID:surveyID, user_group:user_group, responses: responses)
    render plain: "Upload Success"
  end

  def forgot_password
    email = params[ :email]
    @user = User.where(email: email)
    if @user.blank?
      render plain: "Error:No User"
    else
      ApplicationMailer.forgot_email(@user[0]).deliver
      render plain: "Email Success"
    end
  end

end
