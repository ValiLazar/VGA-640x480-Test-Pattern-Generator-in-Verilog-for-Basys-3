Generator de Modele de Test VGA în Verilog pentru Basys 3

📝 Descriere Generală
Acest proiect demonstrează cum se generează un model de test static pentru un afișaj VGA, folosind o placă FPGA Digilent Basys 3. Proiectul este scris în Verilog și produce un semnal video la o rezoluție de 640x480 pixeli.

Scopul este de a afișa o imagine compusă dintr-o varietate de forme geometrice și bare de culori, pentru a testa și valida funcționalitatea unui controler VGA. Imaginea generată este împărțită într-o matrice de 4x3 celule, fiecare conținând un element grafic distinct.

🖼️ Imagine de Ieșire
Imaginea de mai jos arată exact ce produce acest proiect pe un monitor conectat la placa Basys 3.

✨ Caracteristici Principale

Controler VGA 640x480: Generează semnale de sincronizare Hsync și Vsync pentru rezoluția 640x480 @ 60Hz.

Imagine Statică: Proiectul afișează o imagine statică, ideală pentru testarea culorilor și a geometriei.


Matrice de Test: Ecranul este împărțit într-o grilă de 4 coloane și 3 rânduri pentru a organiza elementele de test.

Forme Geometrice: Desenează procedural diverse forme, inclusiv:

Cercuri 

O semilună (realizată prin suprapunerea a două cercuri) 

Un semicerc 

Un pătrat 

Un dreptunghi 

Un triunghi 


Bare de Culori: Generează bare de culori primare (Roșu, Verde, Albastru) și culori secundare (Cyan, Magenta, Galben) pentru a testa gama de culori a afișajului.

📁 Structura Proiectului
Proiectul este alcătuit din următoarele fișiere cheie:

1. vga_top.v
Acesta este modulul de nivel superior care integrează întregul design.

Instanțiază un 

Clocking Wizard pentru a genera ceasul de 25 MHz necesar pentru temporizarea VGA de 640x480.

Instanțiază controlerul vga_640X400 pentru a obține semnalele de sincronizare.

Conține logica pentru a desena fiecare formă și bară de culoare în funcție de coordonatele curente ale pixelilor (h_count_wire, v_count_wire).

2. vga_640X400.v
Acest sub-modul este responsabil exclusiv pentru generarea temporizărilor VGA.

Implementează contoare pentru a genera impulsurile de sincronizare orizontală și verticală.

Definește parametrii pentru front porch, back porch și lățimea pulsului, conform standardului VGA 640x480.

3. Basys3_Master.xdc
Acesta este fișierul de constrângeri esențial care mapează porturile din 

vga_top.v la pinii fizici ai plăcii Basys 3.

Asignează ceasul de intrare la pinul W5.

Asignează butonul de reset la pinul U18.

Asignează ieșirile de culoare (

vgaRed, vgaGreen, vgaBlue) și de sincronizare (Hsync, Vsync) la pinii conectorului VGA.

4. vga_test.v
Un modul de simulare (testbench) folosit pentru a verifica funcționalitatea modulului 

vga_640X400 într-un simulator Verilog, înainte de implementarea pe hardware.

🛠️ Hardware și Software
Hardware Necesar
O placă de dezvoltare Digilent Basys 3

Un monitor cu intrare VGA

Un cablu VGA

Software Necesar
Xilinx Vivado Design Suite: Proiectul utilizează un fișier de constrângeri (.xdc) și un IP de ceas (Clocking Wizard), specifice acestui software.           
![img3](https://github.com/user-attachments/assets/e10b2e94-e924-4287-90c9-dbaaa807ef73)
