class AndroidController < ApplicationController
  #1 = incorrect login details
  #2 = email already in use
  #3 = no item downloaded from server
  #4 = error uploading to server 
  skip_before_action :verify_authenticity_token
  require 'mongo'

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

   #POST method to download all news article for user group 
  def get_content
    user_group = params[ :user_group]
    @content = Content.where(user_group:user_group) #add code to check for dates 
    if @content.nil? || @content == []
      render plain: "Error:3"
    else
      render json: @content
    end
  end

   #POST method to download survey linked to newsItemID 
  def get_survey
    surveyID = params[ :surveyID]
    newsID = params[ :newsID]
    @survey = Survey.where(surveyID:surveyID, newsID:newsID) #get matching survey
    if @survey.nil? || @content == []
      render plain: "Error:3"
    else
      render json: @survey
    end

  end

   #POST method to upload user survey to DB, will only be TEXT 
  def post_survey
    #long JSON string already containing email, user_group, surveyID, newsID and responses?  
    body = JSON.parse(request.body.read) 
    email = body ["email"]
    surveyID = body["surveyID"]
    user_group = body["user_group"]
    responses = body["responses"]
    SurveyResponse.create(email: email, surveyID:surveyID, user_group:user_group, responses: responses)    
    #survey = params[ :surveyResponse]
    #Survey_Response.create(survey)
    render plain: "Upload Success"
  end
end