from django.shortcuts import render, redirect
from .forms import RegistrationForm
from django.contrib.auth.hashers import make_password  # Добавлен импорт для хеширования пароля

def register(request):
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.password = make_password(form.cleaned_data['password'])  # Хеширование пароля
            user.save()
            return redirect('login')  # Перенаправление на страницу входа
    else:
        form = RegistrationForm()
    return render(request, 'registration/register.html', {'form': form})
