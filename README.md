# SnapClass

SnapClass is a Streamlit attendance application with face and voice attendance workflows, backed by Supabase.

## Setup

1. Create and activate a Python virtual environment.
2. Install dependencies with `pip install -r requirements.txt`.
3. Create `.streamlit/secrets.toml` with your Supabase project credentials:

```toml
SUPABASE_URL = "https://your-project.supabase.co"
SUPABASE_KEY = "your-supabase-anon-key"
```

4. Apply `schema.sql` to your Supabase project.
5. Start the app with `streamlit run app.py`.

Keep `.streamlit/secrets.toml` private. It is excluded from Git.
