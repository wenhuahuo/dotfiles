import type { Plugin } from "@opencode-ai/plugin"
import { tool } from "@opencode-ai/plugin"
import * as fs from "fs"
import * as path from "path"

async function encodeImageToBase64(imagePath: string): Promise<string> {
  const resolvedPath = path.resolve(imagePath.replace(/^~/, process.env.HOME || ""))
  
  if (!fs.existsSync(resolvedPath)) {
    throw new Error(`Image file not found: ${resolvedPath}`)
  }
  
  const imageBuffer = await fs.promises.readFile(resolvedPath)
  const ext = path.extname(resolvedPath).toLowerCase().slice(1)
  const mimeType = ext === "jpg" ? "jpeg" : ext
  const base64Image = imageBuffer.toString("base64")
  return `data:image/${mimeType};base64,${base64Image}`
}

export const OpenRouterImagePlugin: Plugin = async () => {
  return {
    tool: {
      generate_image: tool({
        description: "Generate images using OpenRouter's image generation models",
        args: {
          prompt: tool.schema.string().describe("The text description of the image to generate"),
          model: tool.schema
            .string()
            .default("google/gemini-3.1-flash-image-preview")
            .describe("The model to use for image generation"),
          savePath: tool.schema
            .string()
            .optional()
            .describe("Optional path to save the generated image (e.g., ./image.png or ~/Pictures/image.png)"),
        },
        async execute(args, context) {
          const apiKey = process.env.OPENROUTER_API_KEY
          if (!apiKey) {
            throw new Error("OPENROUTER_API_KEY environment variable is not set")
          }

          const response = await fetch("https://openrouter.ai/api/v1/chat/completions", {
            method: "POST",
            headers: {
              Authorization: `Bearer ${apiKey}`,
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              model: args.model,
              messages: [
                {
                  role: "user",
                  content: args.prompt,
                },
              ],
              modalities: ["image"],
            }),
          })

          const result = await response.json()

          if (result.choices) {
            const message = result.choices[0].message
            if (message.images) {
              const images = message.images.map((img: { image_url: { url: string } }) => img.image_url.url)
              
              if (args.savePath) {
                const saveDir = path.dirname(args.savePath)
                if (saveDir && !fs.existsSync(saveDir)) {
                  fs.mkdirSync(saveDir, { recursive: true })
                }
                
                const base64Data = images[0].replace(/^data:image\/\w+;base64,/, "")
                const imageBuffer = Buffer.from(base64Data, "base64")
                fs.writeFileSync(args.savePath, imageBuffer)
                
                return `Image saved to: ${args.savePath}`
              }
              
              return `Generated ${images.length} image(s):\n${images.join("\n")}`
            }
          }

          if (result.error) {
            throw new Error(`OpenRouter API error: ${result.error.message}`)
          }

          throw new Error("No images generated")
        },
      }),
      analyze_image: tool({
        description: "Analyze a local image using OpenRouter's vision models",
        args: {
          imagePath: tool.schema
            .string()
            .describe("Path to the local image file (e.g., ./screenshot.png or ~/Pictures/photo.jpg)"),
          question: tool.schema
            .string()
            .describe("Question or instruction about the image"),
          model: tool.schema
            .string()
            .default("qwen/qwen3.5-flash-02-23")
            .describe("Vision model to use for image analysis"),
        },
        async execute(args, context) {
          const apiKey = process.env.OPENROUTER_API_KEY
          if (!apiKey) {
            throw new Error("OPENROUTER_API_KEY environment variable is not set")
          }

          const base64Image = await encodeImageToBase64(args.imagePath)

          const response = await fetch("https://openrouter.ai/api/v1/chat/completions", {
            method: "POST",
            headers: {
              Authorization: `Bearer ${apiKey}`,
              "Content-Type": "application/json",
            },
            body: JSON.stringify({
              model: args.model,
              messages: [
                {
                  role: "user",
                  content: [
                    {
                      type: "text",
                      text: args.question,
                    },
                    {
                      type: "image_url",
                      image_url: {
                        url: base64Image,
                      },
                    },
                  ],
                },
              ],
            }),
          })

          const result = await response.json()

          if (result.choices) {
            return result.choices[0].message.content
          }

          if (result.error) {
            throw new Error(`OpenRouter API error: ${result.error.message}`)
          }

          throw new Error("Failed to analyze image")
        },
      }),
    },
  }
}
