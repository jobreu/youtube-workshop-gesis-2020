#### Cutout from first presentation round



# Getting API Access

- First of all, we need a Google account.
- You can use an already existing one
- you can create a new one
- For safety reasons, we advise you to create a new account
(If you accidentally share your login credentials, people using the credentials only
  have access to your Bot account and not your personal or work account)
- You can create a new account [here](https://accounts.google.com/signup/v2/webcreateaccount?service=mail&continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&ltmpl=googlemail&gmb=exp&biz=false&flowName=GlifWebSignIn&flowEntry=SignUp)

- Second, we need to:
  - Sign up for the Google developer console
- Create a new Project
- Activate the YouTube Data API
- Create Authentification Credentials

---
  # Google Developer Console

  - Go to the [Developer Console](https://console.developers.google.com) and log in with your (new) Google Account

- Create a new Project by clicking on the "Create" button on the top right Corner

![plot](Images/CreateProject.png)

---
  # Watch out

  - You only have a limited number of Projects that you can create, so be carefull not
to constantly delete and create new ones

- More information can be found [here](https://support.google.com/cloud/answer/6330231)

---
  # Creating a New Project

  - Specify a Project Name (you do not have to indicate an organisation) and click on create once you are done

![plot](Images/ProjectName.png)
---
  # Activate the YouTube Data v3 API

  - click on the button to "Activate APIs"

![plot](Images/ActivateAPI.png)

---
  # Activate the YouTube Data and Analytics APIs

  - Enter "YouTube" in the search bar, click on the data API and then activate it by clicking on the "Activate" button

![plot](Images/APIs.png)

---

  ![plot](Images/Activate.png)

---

  ![plot](Images/AuthentificationButton.png)

---

  ![plot](Images/UserAgreement.png)

---

  ![plot](Images/CreateOAuth.png)

---

  ![plot](Images/OtherApplication.png)

---
  class: center, middle

# DONE!

---
  # What can we do with these Credentials now?

  - We can see what the API allows us to do in the [Google API Explorer](https://developers.google.com/apis-explorer/#p/)

                                                                           - Basically, you can automate any action and see all data that you
                                                                         also would be able to see when logged into YouTube with your Google account

                                                                         - Fortunately for us, the YouTube API is very [well documented](https://developers.google.com/youtube/v3/docs/)