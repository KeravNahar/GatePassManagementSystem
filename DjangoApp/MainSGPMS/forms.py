from dataclasses import field
from pyexpat import model
from django import forms
from matplotlib import widgets
from .models import newVisitor

CHOICES=(('YES','Yes'),('NO','No'))
class newVisitorForm(forms.ModelForm):
    exit = forms.ChoiceField(choices=CHOICES, widget=forms.RadioSelect,label='Exit Approved')
    approval = forms.ChoiceField(choices=CHOICES, widget=forms.RadioSelect,label='Visitation Approved')
    img =  forms.ImageField()
    class Meta:
        model = newVisitor
        fields = ['id','name','mobile','email',
        'datetime_oa',
        'city','reason','novisitor',
        'faculty','img','approval','exit']
        labels = {
            'id':'Visitor ID number',
            'name':'Full Name', 'datetime_oa': 'Arrival Time and Date', 'reason':'Visitation Reason', 
            'mobile':'Mobile No.', 'email':'Email Address', 
            'novisitor':'Number of Visitors','faculty':'Faculty for approval',
            'approval':'Visitation Approved','exit':'Exit Approved',
            'img': 'Image'
            }
        widgets = {
            'id':forms.TextInput(attrs={'class':'form-control'}),
            'name':forms.TextInput(attrs={'class':'form-control'}),
            'mobile':forms.NumberInput(attrs={'class':'form-control'}),
            'email':forms.EmailInput(attrs={'class':'form-control'}),
            'datetime_oa':forms.TextInput(attrs={'class':'form-control'}),
            'city':forms.TextInput(attrs={'class':'form-control'}),
            'reason':forms.Textarea(attrs={'class':'form-control'}),
            'novisitor':forms.NumberInput(attrs={'class':'form-control'}),
            'faculty':forms.Select(attrs={'class':'form-select'}),
             }