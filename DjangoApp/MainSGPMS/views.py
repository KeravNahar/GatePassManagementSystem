from django.shortcuts import render
import firebase_admin
from firebase_admin import credentials,firestore,auth,storage
import smtplib
from pandas import notnull
from werkzeug.utils import secure_filename

from .models import newVisitor

from .forms import newVisitorForm
#firebase setup
cred = credentials.Certificate("MainSGPMS\serviceAccountKey.json")
firebase_admin.initialize_app(cred,{'storageBucket': 'gpms-9bc10.appspot.com'})

db = firestore.client()
bucket = storage.bucket()
def homepage(request):
  email='security@gmail.com'
  username='SECURITY GUARD'
  return render(request, "home.html",{'security_email': email,'security_username':username})
def loginpage(request):
  return render(request , 'login.html')

def home(request):
  email = request.POST.get('email')
  password = request.POST.get('password')

  users_ref = db.collection('GuardLogin').get()
  context = {
    'data' : [values.to_dict() for values in users_ref]
  }
  for doc in context['data']:
    emailfirebase = doc['email']
    passwordfirebase = doc['password']
    username = doc['username']

    if  emailfirebase== email and passwordfirebase == password:
      username = username.upper()
      return render(request, "home.html",{'security_email': email,'security_username':username})
  message = "Invalid Credentials"
  return render(request, 'login.html',{'msg':message})

def logout(request):
    return render(request , 'login.html')

#adding new visitors
def viewForm(request):
  form = newVisitorForm()
  return render(request,'newVisitor.html',)

def addroute(form,email,id,name,mobile,datetime_oa,city,reason,novisitor,faculty,approval,exit,img_url):
  context= {
      'id':id,'name':name,'mobile':mobile,'email':email,
      'datetime_oa':datetime_oa,
      'city':city,'reason':reason,'novisitor':novisitor,
      'img_url':img_url,
      'faculty':faculty,'approval':approval,'exit':exit
    }
  db.collection('Appointments').add(context)
  if form.is_valid():
   form.save()

def updateroute(email,id,name,mobile,datetime_oa,city,reason,novisitor,faculty,approval,exit,img_url):
  data = db.collection("Appointments").where("id", "==", id).get()
  ref = db.collection('Appointments')
  docs = ref.stream()
  docid=''
  refr={}
  for doc in docs:
    refr = {
      doc.id : doc.to_dict()
    }
  for p_id, p_info in refr.items():
    if p_info['id'] == id:
      docid = p_id
  print(docid)
  obj = newVisitor.objects.get(id = id)
  if obj.img:
      obj.img.delete()
      obj.delete()
      
  db.collection("Appointments").document(docid).delete()
  context= {
      'id':id,'name':name,'mobile':mobile,'email':email,
      'datetime_oa':datetime_oa,
      'city':city,'reason':reason,'novisitor':novisitor,
      'img_url':img_url,
      'faculty':faculty,'approval':approval,'exit':exit
        }
  db.collection('Appointments').add(context)

def sendmail(faculty,name,date,reason,mobile,novisitor):
  gmail_user = 'testu0113@gmail.com'
  gmail_password = 'Test@1234'

  sent_from = gmail_user
  to = [faculty]
  subject = 'Permission to visit campus'
  body = str('Name: '+name+' \n '+'Date of Arrival: '+date+' \n '+'Reason: '+reason+' \n '+'Contact: '+mobile+' \n '+'Number of visitors: '+novisitor)

  email_text = """\
  From: %s
  To: %s
  Subject: %s

  %s
  """ % (sent_from, ", ".join(to), subject, body)

  try:
    smtp_server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    smtp_server.ehlo()
    smtp_server.login(gmail_user, gmail_password)
    smtp_server.sendmail(sent_from, to, email_text)
    smtp_server.close()
    print ("Email sent successfully!")
  except Exception as ex:
    print ("Something went wrong….",ex)

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
  img = request.FILES.get('img', "")
  button1 = request.POST['buttonSubmit']
  img_public_url = str("https://storage.googleapis.com/gpms-9bc10.appspot.com/"+id)

  if button1 == 'Submit':
    newVisitor.objects.create(
      email = request.POST['email'],
      id = request.POST['id'],
      name = request.POST['name'],
      mobile = request.POST['mobile'],
      datetime_oa = request.POST['datetime_oa'],
      city = request.POST['city'],
      reason = request.POST['reason'],
      novisitor = request.POST['novisitor'],
      faculty = request.POST['faculty'],
      approval = request.POST['approval'],
      exit = request.POST['exit'],
      img = request.FILES.get('img', "")
    )

    obj = newVisitor.objects.get(id=id)
    blob = bucket.blob(id)
    blob.upload_from_file(obj.img)
    blob.make_public()
    img_public_url = blob.public_url
    addroute(form,email,id,name,mobile,datetime_oa,city,reason,novisitor,faculty,approval,exit,img_public_url)
    sendmail(faculty,name,datetime_oa,reason,mobile,novisitor)
  elif button1 == 'Update':
    updateroute(email,id,name,mobile,datetime_oa,city,reason,novisitor,faculty,approval,exit,img_public_url)
  return render(request, "IDview.html",{'name':name,
  'id':id,'mobile':mobile,'dateofarrival':datetime_oa,'fac_email':faculty,
  'reason':reason,'city':city,'novisitor':novisitor,'img_url':img_public_url
  })

#viewing all the appointments
def listVisitor(request):
  data = db.collection('Appointments').get()
  context = {
    'data' : [values.to_dict() for values in data]
  }
  return render(request,'listVisitor.html',context)

def update(request,pkid):
  data = db.collection("Appointments").where("id", "==", pkid).get()
  context = {
    'data' : [values.to_dict() for values in data]
  }
  return render(request,'Visitor.html',context)