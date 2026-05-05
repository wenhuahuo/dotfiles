export const TaskDoneNotifyPlugin = async ({ $ }) => {
  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        await $`afplay /System/Library/Sounds/Glass.aiff`
        await $`osascript -e 'display notification "Task completed" with title "OpenCode"'`
      }

      if (event.type === "session.error") {
        await $`afplay /System/Library/Sounds/Basso.aiff`
        await $`osascript -e 'display notification "Task failed" with title "OpenCode"'`
      }
    },
  }
}
