extern void main() {
    char* video_memory = (char*) 0xb8000; // Pointer to the first text cell in video memory
    *video_memory = 'X'; // Sets the value of video_memory to an X.
}