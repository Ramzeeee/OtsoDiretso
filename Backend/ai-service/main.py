import os
import httpx
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from dotenv import load_dotenv
from safety.detector import detect_risk_level, build_safe_prompt

load_dotenv()

COLAB_API_URL = os.getenv("COLAB_API_URL")

app = FastAPI()


@app.get("/health")
def health():
    return {"status": "AI service working"}


class Message(BaseModel):
    message: str
    history: list = []


@app.post("/chat")
def chat(data: Message):
    # Step 1 — Detect risk level internally
    risk_level = detect_risk_level(data.message)
    print(f"[SAFETY] Message: '{data.message}' | Risk Level: {risk_level}")

    # Step 2 — Build safe prompt based on risk level
    safe_prompt = build_safe_prompt(data.message, risk_level)

    # Step 3 — Send to Colab model and return reply
    try:
        response = httpx.post(
            f"{COLAB_API_URL}/chat",
            json={"message": safe_prompt},
            headers={"ngrok-skip-browser-warning": "true"},
            timeout=300.0,
        )
        response.raise_for_status()
        reply = response.json().get("reply", "I'm here to listen.")
    except httpx.HTTPError as e:
        raise HTTPException(status_code=502, detail=f"Model error: {str(e)}")

    return {"reply": reply}
