from django import forms
from .models import User

class UserRegisterForm(forms.ModelForm):
    class Meta:
        model = User
        fields = ['email', 'telephone', 'account', 'password', 'name']
        widgets = {
            'email': forms.EmailInput(attrs={'class': 'form-control', 'placeholder': '電子信箱'}),
            'telephone': forms.TextInput(attrs={'class': 'form-control', 'placeholder': '手機'}),
            'account': forms.TextInput(attrs={'class': 'form-control', 'placeholder': '使用者帳號'}),
            'password': forms.PasswordInput(attrs={'class': 'form-control', 'placeholder': '密碼'}),
            'name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': '姓名'})
        }

