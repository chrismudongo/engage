class AndroidController < ApplicationController
  #1 = incorrect login details
  #2 = email already in use
  #3 = no item downloaded from server
  #4 = error uploading to server 

	skip_before_action :verify_authenticity_token

	# POST method to verify user details on login
  def login

    # send paramaters of body
    email = params[:email]
    password = params[:password]

    # find student of username and password
    @user = User.find(:email => email , :password => password)
    if @user != nil
       #email and password match
       render plain: "Login Success:group"+@user.find(:user_group)
    else
      render plain: "Error:1"
    end
  end

  #POST method to add new user 
  def new_user 

    email = params[:email]
    password = params[:password]
    user_group = params[:user_group]

    #check email is unique 
    if User.find(:email => email).count() == 0
      @user = User.new
      #insert new user into DB
      @user.insert_one({:email => email, :password => password, :user_group => user_group})
  	  render plain: "SignUp Success:email"+email
    else
      render plain: "Error:2"
    end

  end

   #POST method to download all news article for user group 
  def get_content  

  	group = params[:group]

    @newsItems = NewsItems.find(:user_group => group) #returns multiple documents, maybe add all into an array  

  	render plain: "Success:Content="+group

  end

   #POST method to download survey linked to newsItemID 
  def get_survey 

    surveyID = params[:surveyID]
    newsID = params [:newsID]

    @Survey = Surveys.find(:surveyID => surveyID , :newsID => newsID) 
    if @Survey != nil
      #return JSON document, will only be text
  	   render plain: @survey
    else
        rend plain: "Error:3"
    end
  end

   #POST method to upload user survey to DB, will only be TEXT 
  def post_survey 

    #long JSON string already containing email, user_group, surveyID, newsID and responses?  
    survey = params[:survey]

    @response = SurveyRespones.new
    result = @response.insert_one(survey)
    if result.n == 1
      render plain: "Upload Success"
    else
      render plain: "Error:4"
  end

  #POST method to get main content stored seperately 

end
