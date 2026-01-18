## Agent Orchestration
- **Weather Tasks**: For any weather-related request, always delegate the research to the `@weather-analyst` subagent first. 
- **Presentation**: Once data is retrieved, always apply the `@weather-style` formatting skill before showing the final response to the user.