from django.shortcuts import render
import firebase_admin
from firebase_admin import credentials,firestore,auth,storage

from .forms import newVisitorForm
#firebase setup
cred = credentials.Certificate("MainSGPMS\serviceAccountKey.json")
firebase_admin.initialize_app(cred)
db = firestore.client()


#db.collection('test').add({'test':'test'})
# Create your views here.
#login authentication and home
def loginpage(request):
  return render(request , 'login.html')

def home(request):
  email = request.POST.get('email')
  password = request.POST.get('password')
  users_ref = db.collection('GuardLogin')
  docs = users_ref.stream()

  for doc in docs:
    emailfirebase = u'{}'.format(doc.to_dict()['email'])
    passwordfirebase = u'{}'.format(doc.to_dict()['password'])
    if  emailfirebase== email and passwordfirebase == password:
      return render(request, "home.html",{'security_email': email,})
    else:
      message = "Invalid Credentials"
      return render(request, 'login.html',{'msg':message})

def logout(request):
    auth.logout(request)
    return render(request , 'login.html')

#adding new visitors
def viewForm(request):
  form = newVisitorForm()
  return render(request,'newVisitor.html',)

def Displayid(request):
  form = newVisitorForm(request.POST, request.FILES)
  email = request.POST.get('email')
  id = request.POST.get('id')  
  name = request.POST.get('name')
  mobile = request.POST.get('mobile')
  datetime_oa = request.POST.get('datetime_oa')
  city = request.POST.get('city')
  reason = request.POST.get('reason')
  novisitor = request.POST.get('novisitor')
  faculty = request.POST.get('faculty')
  approval = request.POST.get('approval')
  exit = request.POST.get('exit')

  context= {
      'id':id,'name':name,'mobile':mobile,'email':email,
      'datetime_oa':datetime_oa,
      'city':city,'reason':reason,'novisitor':novisitor,
      'faculty':faculty,'approval':approval,'exit':exit
        }
  db.collection('Appointments').add(context)
  if form.is_valid():
   form.save()

  return render(request, "IDview.html",{'name':name,
  'id':id,'mobile':mobile,'dateofarrival':datetime_oa,'fac_email':faculty,
  'reason':reason,'city':city,'novisitor':novisitor,
  })

#viewing all the appointments
def listVisitor(request):
  """docs = db.collection('Appointments').get()
  for doc in docs:
    print(doc.to_dict())"""
  return render(request,'listVisitor.html')