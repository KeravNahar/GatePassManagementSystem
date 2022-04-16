from django.urls import path
from MainSGPMS import views

urlpatterns = [
    path('',views.loginpage,name='index'),
    path('home/',views.home,name='home'),
    path('logout/',views.logout,name='log_out'),
    path('newVisitor/',views.viewForm,name='newVisitor'),
    path('display/',views.Displayid,name='DisplayID'),
]