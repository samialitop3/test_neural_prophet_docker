from django.contrib import admin

from django.db.models.manager import BaseManager
from .models import Test
from .services import TestNeuralProphet
# Register your models here.


class TestAdmin(admin.ModelAdmin):
    actions = ["test_prophet"]

    @admin.action(description="Test Neural Prophet")
    def test_prophet(
        self, request, queryset: BaseManager[Test]
    ):
        for instance in queryset:
            TestNeuralProphet().test_neural_prophet()

admin.site.register(Test, TestAdmin)