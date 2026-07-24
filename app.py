import gradio as gr
import uvicorn
from dashboard.server import DashboardServer

# Initialize JARVIS Dashboard FastAPI backend
dashboard_server = DashboardServer()
fastapi_app = dashboard_server.app

# Create Gradio UI wrapper for Hugging Face Free Gradio Space
with gr.Blocks(title="JARVIS Remote Control") as demo:
    gr.Markdown("# 🤖 JARVIS Mark-XLVIII Remote Control Dashboard")
    gr.HTML('<iframe src="/login" style="width:100%; height:850px; border:none; border-radius:12px;"></iframe>')

# Mount FastAPI app (Serves WebSockets, APIs, and static files on free Gradio Space)
app = gr.mount_gradio_app(fastapi_app, demo, path="/ui")

if __name__ == "__main__":
    uvicorn.run("app:app", host="0.0.0.0", port=7860, reload=False)
