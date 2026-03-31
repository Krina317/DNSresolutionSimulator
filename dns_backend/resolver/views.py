from django.http import JsonResponse
from .resolver_logic import resolve_domain
import json
from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
def resolve(request):
    if request.method == "POST":
        data = json.loads(request.body)
        domain = data.get("domain")

        result = resolve_domain(domain)
        return JsonResponse(result)

    return JsonResponse({"error": "Invalid request"})