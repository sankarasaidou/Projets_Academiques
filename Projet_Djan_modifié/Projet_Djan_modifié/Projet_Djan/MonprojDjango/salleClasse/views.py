from django.shortcuts import render
from .forms import ClassroomRegistration
from .models import User

# Create your views here.
def add_show(request):
    if request.method == 'POST':
        fm = ClassroomRegistration(request.POST)
        if fm.is_valid():
            nm = fm.cleaned_data['name']
            dt = fm.cleaned_data['date']
            pw = fm.cleaned_data['password']
            pr = fm.cleaned_data['principal']
            reg = User(name=nm, date=dt, password=pw, principal=pr)
            reg.save()
            fm = ClassroomRegistration()
            list_clas = User.objects.all() 
    else:
        fm = ClassroomRegistration()
        list_clas = User.objects.all()

    return render(request, 'salleClasse/ajouterMontrer.html', {'form': fm, 'classe': list_clas})


def about(request):
    return render(request, 'salleClasse/about.html')

def contact(request):
    return render(request, 'salleClasse/contact.html')