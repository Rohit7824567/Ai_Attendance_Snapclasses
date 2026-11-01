import streamlit as st
import socket
from urllib.parse import urlparse
from supabase import create_client, Client

supabase: Client = create_client(
    st.secrets["SUPABASE_URL"],
    st.secrets["SUPABASE_KEY"]
)


@st.cache_data(ttl=30)
def check_supabase_health():
    """Checks whether the Supabase domain is reachable."""
    url = st.secrets.get("SUPABASE_URL", "")
    if not url:
        return False, "SUPABASE_URL is missing in .streamlit/secrets.toml"
    try:
        host = urlparse(url).netloc.split(":")[0]
        socket.getaddrinfo(host, 443)
        return True, "Connected"
    except socket.gaierror:
        return False, f"Cannot reach Supabase host '{host}'. The Supabase project is likely paused or deleted in your Supabase dashboard."
    except Exception as e:
        return False, f"Connection error: {e}"