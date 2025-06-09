# ASCII Dancer - Interactive Assembly Language Animation

An interactive ASCII character animation system that responds to dance commands with fluid movements and mirroring capabilities, implemented entirely in x86 Assembly Language.

## Key Features
- **11 Distinct Dance Moves**: Commands for limbs and body positions
- **Mirroring System**: Automatic reflection when dancer turns
- **Voice Commands**: "say [message]" outputs custom text
- **Input Validation**: Detects invalid commands and conflicts
- **Text Animation**: Smooth transitions between poses
- **Direction Control**: "turn" command flips orientation

## Technical Specifications
- **Language**: x86 Assembly (MASM syntax)
- **Dependencies**: Irvine32 library
- **Memory Management**: Efficient stack and register usage
- **Error Handling**: Invalid command detection
- **Animation**: Frame-by-frame text rendering

## Supported Commands
| Movement Commands       | Description                |
|-------------------------|----------------------------|
| left/right hand to head | Raises hand to head        |
| left/right hand to hip  | Places hand on hip         |
| left/right hand to start| Returns arm to default     |
| left/right leg in/out   | Leg position changes       |
| turn                    | Flips dancer's orientation |

## Development Highlights
- Custom animation rendering system
- Mirror image transformation logic
- Command parsing and validation
- Memory-efficient string handling
- Terminal-based user interface

## How to Run
1. Ensure MASM and Irvine32 libraries are installed
2. Assemble with:
   ```bash
   ml /c /coff ASCII_Dancer.asm
   link /SUBSYSTEM:CONSOLE ASCII_Dancer.obj irvine32.lib
   ```
