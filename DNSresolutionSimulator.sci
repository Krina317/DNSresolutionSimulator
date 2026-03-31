clc;
clear;

// ---------------- DNS DATABASE ----------------

// Root Server (maps TLD)
root = struct("com", "tld_com");

// TLD Server (.com)
tld_com = struct("shahkrina.com", "auth_shahkrina");

// Authoritative Server
auth_shahkrina = struct(...
    "shahkrina.com", "192.168.1.10", ...
    "www.shahkrina.com", "192.168.1.10" ...
);

// Cache
cache = struct();

// ---------------- FUNCTION ----------------

function ip = resolve(domain)
    global root tld_com auth_shahkrina cache;

    disp("--------------------------------------------------");
    disp("Resolving domain: " + domain);

    // Step 1: Check cache
    if isfield(cache, domain) then
        disp("Cache HIT ✅");
        ip = cache(domain);
        disp("IP Address: " + ip);
        return;
    else
        disp("Cache MISS ❌");
    end

    // Step 2: Extract TLD
    parts = strsplit(domain, ".");
    tld = parts($);  // last part (com)

    // Step 3: Query Root Server
    if isfield(root, tld) then
        disp("Querying Root Server...");
        tld_server = root(tld);
        disp("Root → directs to: " + tld_server);
    else
        disp("ERROR ❌: TLD not found");
        ip = "";
        return;
    end

    // Step 4: Query TLD Server
    if isfield(tld_com, domain) then
        disp("Querying TLD Server...");
        auth_server = tld_com(domain);
        disp("TLD → directs to: " + auth_server);
    else
        disp("ERROR ❌: Domain not found in TLD");
        ip = "";
        return;
    end

    // Step 5: Query Authoritative Server
    if isfield(auth_shahkrina, domain) then
        disp("Querying Authoritative Server...");
        ip = auth_shahkrina(domain);
        disp("Authoritative → IP: " + ip);
    else
        disp("ERROR ❌: Record not found");
        ip = "";
        return;
    end

    // Step 6: Store in cache
    cache(domain) = ip;
    disp("Stored in cache ✔");

    disp("--------------------------------------------------");
endfunction

// ---------------- MAIN ----------------

while %t
    disp(" ");
    disp("===== DNS RESOLUTION SIMULATOR =====");
    disp("1. Resolve Domain");
    disp("2. Exit");

    choice = input("Enter choice: ");

    if choice == 1 then
        domain = input("Enter domain (e.g. shahkrina.com): ", "string");
        resolve(domain);
    elseif choice == 2 then
        disp("Exiting...");
        break;
    else
        disp("Invalid choice");
    end
end
