cache = {}

def resolve_domain(domain):
    if domain in cache:
        return {
            "status": "Cache HIT",
            "ip": cache[domain],
            "path": []
        }

    # Simulated DNS resolution path
    path = [
        "Root Server",
        "TLD Server (.com)",
        "Authoritative Server"
    ]

    # Fake IP generation
    ip = "142.250.183." + str(len(cache) + 1)

    cache[domain] = ip

    return {
        "status": "Cache MISS",
        "ip": ip,
        "path": path
    }