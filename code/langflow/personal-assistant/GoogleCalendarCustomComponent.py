from langflow.custom import Component
from langflow.io import MessageTextInput, IntInput, Output, StrInput
from langflow.schema import Data
from composio import Composio
import json
import re

class FinalFixedCalendarComponent(Component):
    display_name = "Composio Google Calendar (Auto-Repair)"
    description = "Self-healing calendar tool that fixes malformed LLM tool calls."
    icon = "calendar"

    inputs = [
        StrInput(name="api_key", display_name="Composio API Key"),
        StrInput(name="entity_id", display_name="Entity ID", value="default"),
        MessageTextInput(name="summary", display_name="Summary", tool_mode=True),
        MessageTextInput(name="start_time", display_name="Start Time", tool_mode=True),
        IntInput(name="duration", display_name="Duration (Hours)", value=1, tool_mode=True),
        MessageTextInput(name="attendees", display_name="Attendees", tool_mode=True),
    ]

    outputs = [
        Output(display_name="Result", name="result", method="create_event"),
    ]

    def create_event(self) -> Data:
        client = Composio(api_key=self.api_key)
        
        # 1. THE HEALER: Extract parameters if they were all shoved into 'attendees'
        raw_attendees = str(self.attendees.text if hasattr(self.attendees, 'text') else self.attendees)
        final_summary = str(self.summary)
        final_start = str(self.start_time)
        final_attendees = []

        # If the LLM sent a giant string instead of separate fields (your error case)
        if "start_datetime" in raw_attendees:
            # Extract start_datetime using Regex
            date_match = re.search(r'start_datetime":\s*"([^"]+)"', raw_attendees)
            if date_match:
                final_start = date_match.group(1)
            
            # Extract summary
            summary_match = re.search(r'summary":\s*"([^"]+)"', raw_attendees)
            if summary_match:
                final_summary = summary_match.group(1)

        # 2. Fix the Attendees specifically
        try:
            # Try parsing the raw input as JSON
            parsed = json.loads(raw_attendees)
            if isinstance(parsed, list):
                final_attendees = [item['email'] if isinstance(item, dict) else item for item in parsed]
        except:
            # Regex to find any email addresses in the messy string
            final_attendees = re.findall(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}', raw_attendees)

        # 3. Final Payload Construction
        payload = {
            "calendar_id": "primary",
            "summary": final_summary if final_summary and "{" not in final_summary else "New Event",
            "start_datetime": final_start,
            "event_duration_hour": int(self.duration),
            "timezone": "Australia/Melbourne",
            "attendees": final_attendees
        }

        try:
            response = client.tools.execute(
                user_id=self.entity_id,
                slug="GOOGLECALENDAR_CREATE_EVENT",
                arguments=payload,
                dangerously_skip_version_check=True
            )
            self.status = "Success!"
            return Data(value=str(response))
        except Exception as e:
            self.status = f"Error: {str(e)}"
            return Data(value=f"Failed. Payload Sent: {payload}. Error: {str(e)}")