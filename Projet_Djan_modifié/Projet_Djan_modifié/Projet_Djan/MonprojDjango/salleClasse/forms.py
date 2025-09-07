from django.core import validators
from django import forms
from .models import User

class ClassroomRegistration(forms.ModelForm):
    class Meta:
        model = User
        fields = ['name', 'password', 'principal']
        widgets = {
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'date': forms.DateInput(attrs={'class': 'form-control'}),
            'password': forms.PasswordInput(attrs={'class': 'form-control'}),
            'principal': forms.TextInput(attrs={'class': 'form-control'}),
        }