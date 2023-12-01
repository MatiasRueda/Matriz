global main

extern printf
extern sscanf
extern gets

section .data
    imprimirUnDigito    db      "   %hi ",0
    imprimirDosDigitos  db      "  %hi ",0
    imprimirTresDigitos db      " %hi ",0

    msjCantMatrices     db      "Ingrese un numero de matrices (entre 1 y 5): ",0
    msjCantFilasColum   db      "Ingrese un numero de filas y columnas (entre 1 y 8): ",0


    msjIngreseNumero    dw      "Ingrese un numero entre (-99 y 99): ",0
    mensajeError        db      "Error",10,0

    espacio             db      "      ",0
    salto               db      "",10,0
    pared               db      "|",0
    numFormat           db      "%hi",0
    
    msjMatricesCargadas db      "Las matrices cargadas son: ",10,0
    cantDigitos         db      0
    valorOriginal       dw      0

    numMatrices         dw      0
    numFilCol           dw      0
    numFil              dw      0
    numCol              dw      0

    matrizActual        dq      0
    indiceVector        dq      0


    numeroNumero        dw      0
    numeroActual        dw      0

    filasIteradas       dw      0
    columIteradas       dw      0

    matricesIteradas    dw      0

    vector              dq      matriz,matriz2,matriz3,matriz4,matriz5

    msjOperaciones      db      10,"Lista de operaciones: ",10,"- Restar",10,"- Igualdad",10,"- Multiplicar",10,"- Consultar",10,10,0
    msjIngreseOp        db      "Ingrese alguna operacion: ",0


    msjNoEsValido       db      10,"No es valido esa operacion",10,0

    opRestar            db      "Restar",0
    opIgualdad          db      "Igualdad",0
    opMultiplicar       db      "Multiplicar",0
    opConsultar         db      "Consultar",0


    msjMatrizElegida    db      "Elija alguna matriz: ",0
    numMatrizElegida    dw      0


    msjFilConsulta      db      "Elija que fila quiere consultar: ",0
    msjColConsulta      db      "Elija que columna quiere consultar: ",0

    numFilConsulta      dw      0
    numColConsulta      dw      0

    numeroConsultado    dw      0
    desplazamiento      dw      0

    msjNumeroConsultado db      "El numero consultado es: %hi",10,0
    msjModificar        db      "Desea modificarlo? (S/N): ",0


    matrizSeleccionadaA dq      0
    matrizSeleccionadaB dq      0

    contador            dq      0
    longitud            dw      0
    valido              db      1       ;1 en caso de que sea valido, 0 en caso contrario

    msjRestar           db      "Quiere seguir restando? (S/N): ",0

    msjEsIgual          db      10,"Son iguales",10,10,0
    msjNoEsIgual        db      10,"No son iguales",10,10,0

    msjEscalar          db      "Ingrese un numero para multiplicar la matriz: ",0
    escalar             dw       0

    numConsulta         dw       0

;errores
    errorNumIngresado   db      "Error: numero ingresado incorrecto",10,0
    errorResIngresada   db      "Error: respuesta ingresada incorrecta",10,0

;Imprimir matrices      
    verificandoSalto    dw      0      
    columnasTotales     dw      0
    total               dw      0

section .bss
    cantMatrizIngresada     resb      100
    cantFilColumIngresado   resb      100
    
    numeroIngresado         resb      100

    matriz      times  64   resw      1
    matriz2     times  64   resw      1
    matriz3     times  64   resw      1
    matriz4     times  64   resw      1
    matriz5     times  64   resw      1

    opIngresada             resb      100

    matrizIngresada         resb      100

    filIngresada            resb      100
    colConsultaIngresada    resb      100

    respuesta               resb      100

    matrizResta times  64   resw      1

    escalarIngresado        resb      100

    consulta                resb      100

section .text
main:
    call    cantMatrices
    call    cantFilasColumnas
    call    llenarMatrices
operaciones:
    call    imprimirMatrices
    call    obtenerOp
    jmp     operaciones
ret


;##############################;
;                              ;
;     Ingreso el numero de     ;
;           matrices           ;
;                              ;
;##############################;
;Pide al usuario la cantidad de matrices que se va a utilizar
;lo ingresado por teclado lo deja en cantMatrizIngresada
cantMatrices:
    mov     rcx,msjCantMatrices
    call    imprimirUnMsj

    mov     rcx,cantMatrizIngresada
    call    ingresar

    call    valMatrizIngresada 
    cmp     byte[valido],0
    je      cantMatrices

finCantMatrices:
ret


;##############################;
;                              ;
;     Ingreso el numero de     ;
;       filas y columnas       ;
;                              ;
;##############################;
;Pide al usuario la cantidad de columnas y filas que tendran las matrices utilizadas
;lo ingresado por teclado lo deja numFil y numCol en formato word
cantFilasColumnas:
    mov     rcx,msjCantFilasColum
    call    imprimirUnMsj

    mov     rcx,cantFilColumIngresado
    call    ingresar

    call    valFilColumIngresada 
    cmp     byte[valido],0
    je      cantFilasColumnas

    mov     rax,0
    mov     ax,word[numFilCol]
    mov     word[numFil],ax
    mov     word[numCol],ax

ret

;##############################;
;                              ;
;      Ingreso numeros a       ;
;         las matrices         ;
;                              ;
;##############################;
;Pide al usuario los numeros necesarios para llenar las matrices
llenarMatrices:
    mov     rax,0
    mov     rbx,0
    mov     rdx,0
    mov     ax,word[numCol]
    mov     bx,word[numFil]

    imul    ax,bx
    mov     qword[contador],rax

    mov     rbx,qword[indiceVector]
    mov     rax,[vector + rbx]
    mov     qword[matrizActual],rax   
    mov     rdi,0

iterarMatriz:
    mov     rcx,msjIngreseNumero
    call    imprimirUnMsj

    mov     rcx,numeroIngresado
    call    ingresar

    call    valNumIngresado
    cmp     byte[valido],0
    je      iterarMatriz

    mov     rax,0
    mov     rbx,0
    mov     rdx,0
    mov     ax,[numeroNumero]

    mov     word[numeroActual],ax
    mov     bx,word[numeroActual]

    mov     rax,0
    mov     rax,qword[matrizActual]
    mov     [rax + rdi],rbx 
    add     rdi,2

    dec     qword[contador]
    cmp     qword[contador],0
    jg      iterarMatriz
    jmp     finIterarMatriz

error:
    mov     rcx,mensajeError
    call    imprimirUnMsj
    jmp     iterarMatriz

finIterarMatriz:
    call    imprimirMatriz

    mov     rax,0
    mov     rbx,0

    inc     word[matricesIteradas]
    mov     ax,word[matricesIteradas]
    cmp     ax,word[numMatrices]
    je      finPrograma

    add     qword[indiceVector],8
    jmp     llenarMatrices

finPrograma:
ret

;##############################;
;                              ;
;    Obtiene una Operacion     ;
;                              ;
;##############################;
;Pide al usuario una operacion para realizar
;Valida la operacion, en caso de no ser valida,
;le vuelve a pedir al usuario hasta ingresar una valida.
;Por ultimo la operacion se guarda en opIngresada
obtenerOp:
    mov     rcx,msjOperaciones
    call    imprimirUnMsj

    mov     rcx,msjIngreseOp
    call    imprimirUnMsj

    mov     rcx,opIngresada
    call    ingresar

    call    valEjecutarOp
    cmp     byte[valido],0
    je      noEsValido
    
    jmp     finObtenerOp

noEsValido:
    mov     rcx,msjNoEsValido
    call    imprimirUnMsj
    jmp     obtenerOp

finObtenerOp:
ret

;OPERACIONES
;##############################;
;                              ;
;      Resta de matrices       ; 
;                              ;
;##############################;
restaMatriz:
    call   selecDosMatrices

    mov     rax,0
    mov     rbx,0
    mov     rdx,0
    mov     qword[contador],0
    mov     ax,word[numFil]
    mov     bx,word[numCol]
    imul    ax,bx

    mov     qword[contador],rax

    mov     rax,0
    mov     rbx,0
    mov     rcx,0

    mov     rdx,0  

    mov     r8,0
    mov     r9,0

    mov     rax,matrizResta
    mov     r8,[matrizSeleccionadaA]
    mov     rbx,[matrizSeleccionadaB]

iterarMatrices:
    mov     rcx,0

    mov     dx,[r8]
    mov     cx,[rbx]
    sub     dx,cx

    mov     [rax],dx

    add     rax,2
    add     rbx,2
    add     r8,2

    dec     qword[contador]
    cmp     qword[contador],0
    je      finRestaMatriz

    jmp     iterarMatrices

finRestaMatriz:
    mov     rax,0
    mov     rax,matrizResta
    mov     qword[matrizActual],rax

    call    imprimirMatriz

ingresarRespuesta:
    mov     rcx,msjRestar
    call    imprimirUnMsj

    mov     rcx,respuesta
    call    ingresar

    mov     rbx,respuesta
    call    valRespuesta
    cmp     byte[valido],0
    je      ingresarRespuesta

    cmp     byte[respuesta],"N"
    je      finOpResta

seleccionarMatriz:
    call    elegirMatriz

    call    valNumMatriz
    cmp     byte[valido],0
    je      seleccionarMatriz

    call    calcularMatrizElegida

    mov     rax,0
    mov     rax,qword[matrizActual]
    mov     qword[matrizSeleccionadaA],rax

    mov     rax,0
    mov     rbx,0
    mov     rdx,0
    mov     qword[contador],0
    mov     ax,word[numFil]
    mov     bx,word[numCol]
    imul    ax,bx

    mov     qword[contador],rax

    mov     rax,0
    mov     rbx,0
    mov     rcx,0
    mov     rdx,0

    mov     rax,matrizResta
    mov     rbx,[matrizSeleccionadaA]

seguirRestando:
    mov     cx,[rax]
    mov     dx,[rbx]

    sub     cx,dx

    mov     [rax],cx

    add     rax,2
    add     rbx,2

    dec     qword[contador]
    cmp     qword[contador],0
    je      finRestaMatriz

    jmp     seguirRestando

finOpResta:
ret

;##############################;
;                              ;
;      Igualdad matrices       ; 
;                              ;
;##############################;
igualdadMatrices:
    mov     rax,0
    mov     rbx,0
    mov     rdx,0
    mov     qword[contador],0
    mov     ax,word[numFil]
    mov     bx,word[numCol]
    imul    ax,bx

    mov     qword[contador],rax

    mov     rax,0
    mov     rbx,0
    mov     r8,0

    call    selecDosMatrices
    mov     rbx,[matrizSeleccionadaA]
    mov     r8,[matrizSeleccionadaB]

verificandoIgualdad:
    mov     ax,[rbx]
    cmp     [r8],ax
    jne     noEsIgual      

    dec     qword[contador]
    cmp     qword[contador],0
    je      finVerificacionIgualdad

    add     rbx,2
    add     r8,2
    jmp     verificandoIgualdad

finVerificacionIgualdad:
    mov     rcx,msjEsIgual
    call    imprimirUnMsj
    jmp     finIgualdadMatrices

noEsIgual:
    mov     rcx,msjNoEsIgual
    call    imprimirUnMsj

finIgualdadMatrices:
ret


;##############################;
;                              ;
;     Multiplicar matrices     ; 
;                              ;
;##############################;
multiplicarMatriz:
    mov     rcx,msjEscalar
    call    imprimirUnMsj

    mov     rcx,escalarIngresado
    call    ingresar

    call    valEscalarIngresado
    cmp     byte[valido],0
    je      multiplicarMatriz

elegirMatrizMultiplicar:
    call    elegirMatriz

    call    valNumMatriz
    cmp     byte[valido],0
    je      elegirMatrizMultiplicar

    call    calcularMatrizElegida

    mov     rax,0
    mov     rbx,0
    mov     rdx,0
    mov     qword[contador],0
    mov     ax,word[numFil]
    mov     bx,word[numCol]
    imul    ax,bx

    mov     qword[contador],rax

    mov     rax,0
    mov     rbx,0
    mov     rcx,0
    mov     rbx,qword[matrizActual]
iterarMatrizMultiplicar:
    mov     ax,[rbx]
    imul    ax,word[escalar]
    mov     [rbx],ax

    dec     qword[contador]
    cmp     qword[contador],0
    je      finIterarMatrizMultiplicar

    add     rbx,2
    jmp     iterarMatrizMultiplicar

finIterarMatrizMultiplicar:
ret


;##############################;
;                              ;        
;           CONSULTAR          ; 
;                              ;
;##############################;
consultarMatriz:
    call    elegirMatriz

    call    valNumMatriz
    cmp     byte[valido],0
    je      consultarMatriz

    call    calcularMatrizElegida

consultarFila:
    mov     rcx,msjFilConsulta
    call    imprimirUnMsj

    mov     rcx,consulta
    call    ingresar

    mov     rbx,consulta
    call    valConsulta

    cmp     byte[valido],0
    je      consultarFila

    mov     rax,0
    mov     ax,word[numConsulta]
    mov     word[numFilConsulta],ax  

consultarColumna:
    mov     rcx,msjColConsulta
    call    imprimirUnMsj

    mov     rcx,consulta
    call    ingresar

    mov     rbx,consulta
    call    valConsulta

    cmp     byte[valido],0
    je      consultarColumna

    mov     rax,0
    mov     ax,word[numConsulta]
    mov     word[numColConsulta],ax  

;calcular desplazamiento
    mov     rax,0
    mov     rbx,0
    mov     rdx,0

;calcular largo fila
    mov     ax,2
    imul    ax,word[numFil]

    dec     word[numFilConsulta]

    imul    ax,word[numFilConsulta] ;fila calculada

;calculo la columna
    dec     word[numColConsulta]
    imul    dx,word[numColConsulta],2

    add     dx,ax
    mov     word[desplazamiento],dx

    mov     rax,0

    mov     rbx,qword[matrizActual] 
    mov     ax,word[rbx + rdx]   
    mov     word[numeroConsultado],ax

    mov     rdx,0

    mov     rcx,msjNumeroConsultado
    mov     dx,word[numeroConsultado]
    sub     rsp,32
    call    printf
    add     rsp,32

;consulto si modificar o no
consultarModificar:
    mov     rcx,msjModificar
    call    imprimirUnMsj

    mov     rcx,respuesta
    call    ingresar

    mov     rbx,respuesta
    call    valRespuesta
    cmp     byte[valido],0
    je      consultarModificar

    cmp     byte[respuesta],"N"
    je      finConsultarMatriz

;Ingresa un nuevo numero
nuevoNumero:
    mov     rcx,msjIngreseNumero
    call    imprimirUnMsj

    mov     rcx,numeroIngresado
    call    ingresar

    call    valNumIngresado
    cmp     byte[valido],0
    je      nuevoNumero

    mov     rax,0
    mov     rbx,0
    mov     rdx,0

    mov     rbx,qword[matrizActual] 
    mov     dx,word[desplazamiento]

    mov     ax,word[numeroNumero]
    
    mov     word[rbx + rdx],ax

finConsultarMatriz:
ret

;##############################;
;                              ;
;         VALIDACIONES         ;
;                              ;
;##############################;
;Todas las validaciones tienen el mismo procedimiento
;Verifican que cumplan ciertas condiciones
;En caso de ser valida deja 1 en la variable valido
;en caso contrario deja un 0 en la variable valido
valMatrizIngresada:
    mov     byte[valido],1
    mov     rbx,cantMatrizIngresada

    call    longitudCadena

    cmp     word[longitud],1
    jne     noEsValidoMatriz

    mov     rcx,cantMatrizIngresada
    mov     rdx,numFormat
    mov     r8,numMatrices
    call    convertirANumero

    cmp     rax,1
    jl      noEsValidoMatriz

    cmp     word[numMatrices],1
    jl      noEsValidoMatriz
    cmp     word[numMatrices],5
    jg      noEsValidoMatriz

    jmp     finValMatrizIngresada

noEsValidoMatriz:
    mov     rcx,errorNumIngresado
    call    imprimirUnMsj
    mov     byte[valido],0

finValMatrizIngresada:
ret


valFilColumIngresada:
    mov     rbx,0
    mov     byte[valido],1

    mov     rbx,cantFilColumIngresado
    call    longitudCadena

    cmp     word[longitud],1
    jne     noEsValidoFilCol

    mov     rcx,cantFilColumIngresado
    mov     rdx,numFormat
    mov     r8,numFilCol
    call    convertirANumero

    cmp     rax,1
    jl      noEsValidoFilCol

    cmp     word[numFilCol],1
    jl      noEsValidoFilCol
    cmp     word[numFilCol],8
    jg      noEsValidoFilCol

    jmp     finValFilCol

noEsValidoFilCol:
    mov     rcx,errorNumIngresado
    call    imprimirUnMsj
    mov     byte[valido],0

finValFilCol:
ret

valNumIngresado:
    mov     byte[valido],1

    mov     rbx,numeroIngresado
    call    longitudCadena

    cmp     word[longitud],0
    je      noEsValidoNum
    cmp     word[longitud],3
    jg      noEsValidoNum

    mov     rcx,numeroIngresado
    mov     rdx,numFormat
    mov     r8,numeroNumero
    call    convertirANumero

    cmp     rax,1
    jl      noEsValidoNum

    cmp     word[numeroNumero],99
    jg      noEsValidoNum
    cmp     word[numeroNumero],-99
    jl      noEsValidoNum

    jmp     finValNumIngresado

noEsValidoNum:
    mov     rcx,errorNumIngresado
    call    imprimirUnMsj
    mov     byte[valido],0

finValNumIngresado:
ret


valEjecutarOp:
    mov     byte[valido],1

    mov     rcx,6
    lea     rsi,[opIngresada]
    lea     rdi,[opRestar]
repe cmpsb
    je      restaMatriz

    mov     rcx,8
    lea     rsi,[opIngresada]
    lea     rdi,[opIgualdad]
repe cmpsb
    je      igualdadMatrices

    mov     rcx,11
    lea     rsi,[opIngresada]
    lea     rdi,[opMultiplicar]
repe cmpsb
    je      multiplicarMatriz

    mov     rcx,9
    lea     rsi,[opIngresada]
    lea     rdi,[opConsultar]
repe cmpsb
    je      consultarMatriz

    mov     byte[valido],0

finValOp:
ret

;##############################;
;                              ;
;        Valido Escalar        ; 
;                              ;
;##############################;
valEscalarIngresado:
    mov     byte[valido],1

    mov     rbx,escalarIngresado
    call    longitudCadena

    cmp     word[longitud],0
    je      noEsValidoEscalar

    mov     rcx,escalarIngresado
    mov     rdx,numFormat
    mov     r8,escalar
    call    convertirANumero

    cmp     rax,1
    jl      noEsValidoEscalar

    jmp     finValEscalarIngresado

noEsValidoEscalar:
    mov     rcx,errorNumIngresado
    call    imprimirUnMsj
    mov     byte[valido],0

finValEscalarIngresado:
ret


;##############################;
;                              ;
;     Valido la respuesta      ; 
;                              ;
;##############################;
valRespuesta:
    mov     byte[valido],1

    call    longitudCadena

    cmp     word[longitud],1
    jne     noEsValidaRespuesta

    mov     rbx,respuesta

    cmp     byte[rbx],"S"
    je      finValRespuesta
    cmp     byte[rbx],"N"
    je      finValRespuesta

noEsValidaRespuesta:
    mov     rcx,errorResIngresada
    call    imprimirUnMsj
    mov     byte[valido],0
finValRespuesta:
ret


;##############################;
;                              ;
;     Valido la consulta       ; 
;                              ;
;##############################;
valConsulta:
    mov     byte[valido],1

    call    longitudCadena

    cmp     word[longitud],1
    jne     noEsValidoConsulta

    mov     rcx,consulta
    mov     rdx,numFormat
    mov     r8,numConsulta
    call    convertirANumero

    cmp     rax,1
    jl      noEsValidoConsulta

    cmp     word[numConsulta],1
    jl      noEsValidoConsulta

    mov     rax,0
    mov     ax,word[numFil]
    cmp     word[numConsulta],ax
    jg      noEsValidoConsulta

    jmp     finValConsulta

noEsValidoConsulta:
    mov     rcx,errorNumIngresado
    call    imprimirUnMsj
    mov     byte[valido],0
finValConsulta:
ret

;##############################;
;                              ;
;       Valido el numero       ;
;     de la matriz elegida     ;
;                              ;
;##############################;
valNumMatriz:
    mov     byte[valido],1
    mov     rax,0
    mov     rbx,0

    mov     rbx,matrizIngresada
    call    longitudCadena

    cmp     word[longitud],1
    jne     noEsValidoNumMatriz

    mov     rcx,matrizIngresada
    mov     rdx,numFormat
    mov     r8,numMatrizElegida
    call    convertirANumero

    cmp     rax,1
    jl      noEsValidoNumMatriz

    cmp     word[numMatrizElegida],1
    jl      noEsValidoNumMatriz

    mov     rax,0
    mov     ax,word[numMatrices]
    cmp     word[numMatrizElegida],ax
    jg      noEsValidoNumMatriz

    jmp     finValNumMatriz

noEsValidoNumMatriz:
    mov     rcx,errorNumIngresado
    call    imprimirUnMsj
    mov     byte[valido],0

finValNumMatriz:  
ret


;##############################;
;                              ;
;     LLAMADAS AUXILIARES      ; 
;                              ;
;##############################;

;##############################;
;                              ;
;   Seleccion de 2 matrices    ; 
;                              ;
;##############################;
selecDosMatrices:
SeleccionarMatrizA:
    call    elegirMatriz

    call    valNumMatriz
    cmp     byte[valido],0
    je      SeleccionarMatrizA

    call    calcularMatrizElegida

    mov     rax,0
    mov     rax,qword[matrizActual]
    mov     qword[matrizSeleccionadaA],rax

SeleccionarMatrizB:
    call    elegirMatriz

    call    valNumMatriz
    cmp     byte[valido],0
    je      SeleccionarMatrizB

    call    calcularMatrizElegida

    mov     rax,0
    mov     rax,qword[matrizActual]
    mov     qword[matrizSeleccionadaB],rax

ret

;##############################;
;                              ;
;  Pide al usuario una matriz  ;
;                              ;
;##############################;
elegirMatriz:
    mov     rcx,msjMatrizElegida
    call    imprimirUnMsj

    mov     rcx,matrizIngresada
    call    ingresar

ret

;##############################;
;                              ;
;        Calcular matriz       ;
;            elegida           ;
;                              ;
;##############################;
; Deja en la variable matrizActual la 
;matriz que se usara
; Antes se tuvo que elegir una matriz
;y dejarla en la variable numMatrizElegida
calcularMatrizElegida:
    dec     word[numMatrizElegida]

    mov     rax,0
    mov     rbx,0
    mov     bx,8
    imul    bx,word[numMatrizElegida]

    mov     rax,[vector + rbx]
    mov     qword[matrizActual],rax
ret

;###########################;
;                           ;
;     Imprimir Matriz       ;
;                           ;
;############################

imprimirMatriz:
    mov     rax,0
    mov     rbx,0
    mov     rdx,0
    mov     ax,word[numCol]
    mov     bx,word[numFil]
    mov     word[columIteradas],0


    imul    ax,bx
    mov     qword[contador],rax

    call    imprimirSalto
    mov     rbx,[matrizActual] 

iteracion:
    cmp     word[columIteradas],0  
    je      nuevaFila
    jmp     imprimirNumero

nuevaFila:
    call imprimirPared

imprimirNumero:
    mov     rax,0
    mov     rdx,0

    mov     ax,[rbx] 
    call    calcularDigitos

    call    imprimirSegunDigitos

   
    inc     word[columIteradas]

    mov     rax,0
    mov     ax,word[numCol]
    cmp     word[columIteradas],ax 
    je      finDeFila
    jmp     siguiente

finDeFila:
    mov     word[columIteradas],0 
    call    imprimirPared
    call    imprimirSalto
    add     rbx,2          
    dec     qword[contador]
    cmp     qword[contador],0
    je      fin
    jmp     iteracion


siguiente:
    add     rbx,2
    dec     qword[contador]
    cmp     qword[contador],0
    je      fin
    jmp     iteracion

fin:
    call    imprimirSalto
ret

imprimirSegunDigitos:
    cmp     byte[cantDigitos],1
    je      imprimoUnDigito

    cmp     byte[cantDigitos],2
    je      imprimoDosDigitos

    cmp     byte[cantDigitos],3
    je      imprimoTresDigitos

imprimoUnDigito:
    mov     rcx,imprimirUnDigito
    mov     dx,ax
    sub     rsp,32
    call    printf
    add     rsp,32
    jmp     finImprimirSegunDigitos

imprimoDosDigitos:
    mov     rcx,imprimirDosDigitos
    mov     dx,ax
    sub     rsp,32
    call    printf
    add     rsp,32
    jmp     finImprimirSegunDigitos

imprimoTresDigitos:
    mov     rcx,imprimirTresDigitos
    mov     dx,ax
    sub     rsp,32
    call    printf
    add     rsp,32

finImprimirSegunDigitos:
ret

calcularDigitos:
    mov     byte[cantDigitos],0

    mov     word[valorOriginal],ax

    cmp     ax,0
    jg      casoPositivos
    cmp     ax,0
    jl      casoNegativos

    mov     byte[cantDigitos],1
    jmp     finCalcularDigitos

casoPositivos:
    sub     ax,10
    cmp     ax,0
    jl      unDigito
    cmp     ax,0
    jge     dosDigitos

casoNegativos:
    add     ax,10
    cmp     ax,0
    jg      dosDigitos

    cmp     ax,0
    jle     tresDigitos

unDigito:
    mov     byte[cantDigitos],1
    jmp     finCalcularDigitos

dosDigitos:
    mov     byte[cantDigitos],2
    jmp     finCalcularDigitos

tresDigitos:
    mov     byte[cantDigitos],3

finCalcularDigitos:
    mov     ax,word[valorOriginal]
ret

imprimirPared:  
    mov     rcx,pared
    sub     rsp,32
    call    printf
    add     rsp,32

ret

imprimirEspacio:
    mov     rcx,espacio
    sub     rsp,32
    call    printf
    add     rsp,32

ret


imprimirSalto:
    mov     rcx,salto   
    sub     rsp,32
    call    printf
    add     rsp,32

ret

imprimirUnMsj:
    sub     rsp,32
    call    printf
    add     rsp,32

ret

ingresar:
    sub     rsp,32
    call    gets
    add     rsp,32

ret

convertirANumero:
    sub     rsp,32
    call    sscanf
    add     rsp,32

ret


;##############################;
;                              ;
;  Imprime todas las matrices  ;
;                              ;
;##############################;
imprimirMatrices:
    mov     rcx,msjMatricesCargadas
    call    imprimirUnMsj

    call    imprimirSalto


    mov     word[verificandoSalto],0     
    mov     word[columnasTotales],0
    mov     word[total],0

    mov     rax,0
    mov     rbx,0
    mov     ax,word[numFil]
    mov     bx,word[numCol]
    imul    ax,bx
    mov     bx,word[numMatrices]
    imul    ax,bx
    mov     word[total],ax


    mov     rax,0
    mov     rbx,0
    mov     ax,word[numCol]
    mov     bx,word[numMatrices]
    imul    ax,bx
    mov     word[columnasTotales],ax

    mov     rax,0
    mov     rbx,0
    mov     rdx,0
    mov     word[filasIteradas],0
    mov     word[columIteradas],0
    mov     qword[indiceVector],0

eligiendoMatriz:
    call    imprimirPared

    mov     rbx,qword[indiceVector]
    mov     rax,[vector + rbx]
    mov     qword[matrizActual],rax 
    mov     rbx,qword[matrizActual]

    mov     rax,0   
    imul    ax,word[numCol],2          
    imul    ax,word[filasIteradas]   
    add     bx,ax

imprimirLaMatriz:
    mov     rax,0

    mov     ax,[rbx]
    call    calcularDigitos

    call    imprimirSegunDigitos

    dec     word[total]
    cmp     word[total],0
    je      finImprimirMatrices


    inc     word[columIteradas]
    inc     word[verificandoSalto]
    mov     dx,word[numCol]
    cmp     word[columIteradas],dx
    je      siguienteMatriz

    add     rbx,2
    jmp     imprimirLaMatriz

siguienteMatriz:
    mov     rax,0
    mov     ax,word[verificandoSalto]
    cmp     word[columnasTotales],ax
    je      siguientesFilas


    call    imprimirPared
    call    imprimirEspacio

    mov     word[columIteradas],0
    add     qword[indiceVector],8
    jmp     eligiendoMatriz


siguientesFilas:  
    mov     word[columIteradas],0
    mov     qword[indiceVector],0
    mov     word[verificandoSalto],0
    mov     rbx,0
    inc     word[filasIteradas]

    call    imprimirPared
    call    imprimirSalto

    jmp     eligiendoMatriz

finImprimirMatrices:
    call    imprimirPared
    call    imprimirSalto
ret


longitudCadena:
    mov     word[longitud],0    
iterCadena:
    cmp     byte[rbx],0
    je      finIterCadena
    inc     word[longitud]
    inc     rbx
    jmp     iterCadena
finIterCadena:
ret
