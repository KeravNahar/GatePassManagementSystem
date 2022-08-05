from django.urls import path
from MainSGPMS import views

urlpatterns = [
    path('',views.loginpage,name='index'),
    path('home/',views.home,name='home'),
    path('homep/',views.homepage,name='homep'),
    path('logout/',views.logout,name='log_out'),
    path('newVisitor/',views.viewForm,name='newVisitor'),
    path('listVisitor/',views.listVisitor,name='listVisitor'),
    path('display/',views.Displayid,name='DisplayID'),
    path('visitordetail/<pkid>/',views.update,name='updatedetails')
]