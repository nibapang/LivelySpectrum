//
//  ConverterData.swift
//  LivelySpectrum
//
//  Created by Lively Spectrum on 2025/3/5.
//


import Foundation

struct ConverterData {
    let moodTitle: String
    let mood: [Mood]
}

struct Mood {
    let moodName: String
    let colorNames: [String]
}

var converter: [ConverterData] = [
    
    ConverterData(moodTitle: "Emotion to Single Color (Basic Conversion)", mood: [
        Mood(moodName: "Happy", colorNames: ["Yellow"]),
        Mood(moodName: "Sad", colorNames: ["Blue"]),
        Mood(moodName: "Angry", colorNames: ["Red"]),
        Mood(moodName: "Calm", colorNames: ["Green"]),
        Mood(moodName: "Excited", colorNames: ["Orange"]),
        Mood(moodName: "Fearful", colorNames: ["Purple"])
    ]),
    
    ConverterData(moodTitle: "Emotion to Gradient Palette (Smooth Transitions)", mood: [
        Mood(moodName: "Happy to Sad", colorNames: ["Yellow", "Blue"]),
        Mood(moodName: "Excited to Calm", colorNames: ["Orange", "Green"])
    ]),
    
    ConverterData(moodTitle: "Emotion to Artistic Theme (Mood Board)", mood: [
        Mood(moodName: "Romantic", colorNames: ["Soft Pink", "Red", "Purple"]),
        Mood(moodName: "Nostalgic", colorNames: ["Sepia", "Faded Blue", "Vintage Tone"]),
        Mood(moodName: "Energetic", colorNames: ["Neon", "High-Contrast Shades"])
    ]),
    
    ConverterData(moodTitle: "Emotion to Cultural Color Meaning", mood: [
        Mood(moodName: "White (Western)", colorNames: ["White", "Peace"]),
        Mood(moodName: "White (Eastern)", colorNames: ["White", "Mourning"]),
        Mood(moodName: "Red (Western)", colorNames: ["Red", "Passion"]),
        Mood(moodName: "Red (Chinese)", colorNames: ["Red", "Good Luck"])
    ]),
    
    ConverterData(moodTitle: "Emotion to Productivity Palette", mood: [
        Mood(moodName: "Focus", colorNames: ["Cool Blue", "Green"]),
        Mood(moodName: "Creativity", colorNames: ["Purple", "Vibrant"]),
        Mood(moodName: "Relaxation", colorNames: ["Soft Pastel", "Earth Tone"])
    ]),
    
    ConverterData(moodTitle: "Emotion to Fashion Palette", mood: [
        Mood(moodName: "Confident", colorNames: ["Black", "Dark Red", "Royal Blue"]),
        Mood(moodName: "Joyful", colorNames: ["Bright Yellow", "Coral", "Sky Blue"]),
        Mood(moodName: "Elegant", colorNames: ["Soft Gold", "Deep Purple", "White"])
    ]),
    
    ConverterData(moodTitle: "Emotion to Light and Ambience", mood: [
        Mood(moodName: "Stressed", colorNames: ["Dim Blue"]),
        Mood(moodName: "Excited", colorNames: ["Vibrant Multi-Color"]),
        Mood(moodName: "Romantic", colorNames: ["Warm Red", "Pink Glow"])
    ]),
    
    ConverterData(moodTitle: "Emotion to Music Color Synesthesia", mood: [
        Mood(moodName: "Sad Piano Music", colorNames: ["Blue", "Gray"]),
        Mood(moodName: "Upbeat Pop", colorNames: ["Yellow", "Pink"]),
        Mood(moodName: "Heavy Rock", colorNames: ["Dark Red", "Black"])
    ]),
    
    ConverterData(moodTitle: "Emotion to Painting Style", mood: [
        Mood(moodName: "Melancholy", colorNames: ["Monochrome", "Minimal Brush"]),
        Mood(moodName: "Euphoria", colorNames: ["Abstract", "Splash Color"]),
        Mood(moodName: "Peaceful", colorNames: ["Watercolor", "Pastel Tone"])
    ]),
    
    ConverterData(moodTitle: "Emotion to Journal Backgrounds", mood: [
        Mood(moodName: "Motivated", colorNames: ["Gold Gradient"]),
        Mood(moodName: "Tired", colorNames: ["Muted Gray"]),
        Mood(moodName: "Inspired", colorNames: ["Bright", "High-Saturation"])
    ])
]
