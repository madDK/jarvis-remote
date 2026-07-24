from dashboard.server import DashboardServer

dashboard_server = DashboardServer()
app = dashboard_server.app

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("app:app", host="0.0.0.0", port=7860, reload=False)
