global random_int
global random_string
global file_read_string
global file_read_int
global documentary_in
global documentary_in_random
global documentary_out
global documentary_quotient
global cartoon_in
global cartoon_in_random
global cartoon_out
global cartoon_quotient
global fiction_in
global fiction_in_random
global fiction_out
global fiction_quotient
global movie_in
global movie_in_random
global movie_out
global movie_quotient
global container_init
global container_clear
global container_in
global container_in_random
global container_out
global container_shake_sort
global incorrect_command_line
global incorrect_qualifier_value
global incorrect_number_of_items
global incorrect_files
global main

extern fwrite                                           
extern fclose                                           
extern fopen                                            
extern memset                                           
extern exit                                             
extern srand                                            
extern time                                             
extern printf                                           
extern feof                                             
extern puts                                             
extern __isoc99_fscanf                                  
extern strcmp                                           
extern strlen                                           
extern fprintf                                          
extern free                                             
extern atoi                                             
extern strcpy                                           
extern fgetc                                            
extern malloc                                           
extern rand


SECTION .text                             

random_int:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     dword [rbp-4H], edi                     
        mov     dword [rbp-8H], esi                     
        call    rand                                    
        mov     edx, dword [rbp-8H]                     
        mov     ecx, edx                                
        sub     ecx, dword [rbp-4H]                     
        cdq                                             
        idiv    ecx                                     
        mov     eax, dword [rbp-4H]                     
        add     eax, edx                                
        inc     eax                                     
        leave                                           
        ret                                             


random_string:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     esi, 10                                 
        mov     edi, 5                                  
        call    random_int                              
        mov     dword [rbp-8H], eax                     
        mov     eax, dword [rbp-8H]                     
        inc     eax                                     
        cdqe                                            
        mov     rdi, rax                                
        call    malloc                                  
        mov     qword [rbp-10H], rax                    
        mov     dword [rbp-4H], 0                       
        jmp     random_string_loop

random_string_loop_end:
        mov     esi, 62
        mov     edi, 0                                  
        call    random_int                              
        mov     edx, dword [rbp-4H]                     
        movsxd  rdx, edx                                
        mov     rcx, qword [rbp-10H]                    
        add     rdx, rcx                                
        cdqe                                            
        lea     rcx, [rel alphabet]                        
        movzx   eax, byte [rax+rcx]                     
        mov     byte [rdx], al                          
        inc     dword [rbp-4H]                          
random_string_loop:
        mov     eax, dword [rbp-4H]
        cmp     eax, dword [rbp-8H]                     
        jl      random_string_loop_end
        mov     eax, dword [rbp-8H]                     
        cdqe                                            
        mov     rdx, qword [rbp-10H]                    
        add     rax, rdx                                
        mov     byte [rax], 0                           
        mov     rax, qword [rbp-10H]                    
        leave                                           
        ret                                             


file_read_string:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 144                                
        mov     qword [rbp-88H], rdi                    
        mov     qword [rbp-80H], 0                      
        mov     qword [rbp-78H], 0                      
        mov     qword [rbp-70H], 0                      
        mov     qword [rbp-68H], 0                      
        mov     qword [rbp-60H], 0                      
        mov     qword [rbp-58H], 0                      
        mov     qword [rbp-50H], 0                      
        mov     qword [rbp-48H], 0                      
        mov     qword [rbp-40H], 0                      
        mov     qword [rbp-38H], 0                      
        mov     qword [rbp-30H], 0                      
        mov     qword [rbp-28H], 0                      
        mov     dword [rbp-20H], 0                      
        mov     dword [rbp-4H], 0                       
        mov     rax, qword [rbp-88H]                    
        mov     rdi, rax                                
        call    fgetc                                   
        mov     dword [rbp-8H], eax                     
        jmp     file_read_string_loop_2
file_read_string_loop_1:
        mov     eax, dword [rbp-4H]
        lea     edx, [rax+1H]                           
        mov     dword [rbp-4H], edx                     
        mov     edx, dword [rbp-8H]                     
        cdqe                                            
        mov     byte [rbp+rax-80H], dl                  
        mov     rax, qword [rbp-88H]                    
        mov     rdi, rax                                
        call    fgetc                                   
        mov     dword [rbp-8H], eax                     
file_read_string_loop_2:
        cmp     dword [rbp-8H], -1
        jz      file_read_string_loop_3
        cmp     dword [rbp-8H], 10                      
        jz      file_read_string_loop_3
        cmp     dword [rbp-8H], 32                      
        jnz     file_read_string_loop_1
file_read_string_loop_3:
        mov     eax, dword [rbp-4H]
        lea     edx, [rax+1H]                           
        mov     dword [rbp-4H], edx                     
        cdqe                                            
        mov     byte [rbp+rax-80H], 0                   
        mov     eax, dword [rbp-4H]                     
        cdqe                                            
        mov     rdi, rax                                
        call    malloc                                  
        mov     qword [rbp-10H], rax                    
        lea     rax, [rbp-80H]                          
        mov     rdx, qword [rbp-10H]                    
        mov     rsi, rax                                
        mov     rdi, rdx                                
        call    strcpy                                  
        mov     rax, qword [rbp-10H]                    
        leave                                           
        ret                                             


file_read_int:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     rax, qword [rbp-18H]                    
        mov     rdi, rax                                
        call    file_read_string                        
        mov     qword [rbp-8H], rax                     
        mov     rax, qword [rbp-8H]                     
        mov     rdi, rax                                
        call    atoi                                    
        mov     dword [rbp-0CH], eax                    
        mov     rax, qword [rbp-8H]                     
        mov     rdi, rax                                
        call    free                                    
        mov     eax, dword [rbp-0CH]                    
        leave                                           
        ret                                             


documentary_in:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     qword [rbp-10H], rsi                    
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    file_read_string                        
        mov     rdx, qword [rbp-8H]                     
        mov     qword [rdx], rax                        
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    file_read_int                           
        mov     rdx, qword [rbp-8H]                     
        mov     dword [rdx+8H], eax                     
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    file_read_int                           
        mov     rdx, qword [rbp-8H]                     
        mov     dword [rdx+0CH], eax                    
        nop                                             
        leave                                           
        ret                                             


documentary_in_random:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     eax, 0                                  
        call    random_string                           
        mov     rdx, qword [rbp-8H]                     
        mov     qword [rdx], rax                        
        mov     esi, 2021                               
        mov     edi, 1950                               
        call    random_int                              
        mov     rdx, qword [rbp-8H]                     
        mov     dword [rdx+8H], eax                     
        mov     esi, 10                                 
        mov     edi, 1                                  
        call    random_int                              
        mov     rdx, qword [rbp-8H]                     
        mov     dword [rdx+0CH], eax                    
        nop                                             
        leave                                           
        ret                                             


documentary_out:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     qword [rbp-10H], rsi                    
        mov     rax, qword [rbp-8H]                     
        mov     esi, dword [rax+0CH]                    
        mov     rax, qword [rbp-8H]                     
        mov     ecx, dword [rax+8H]                     
        mov     rax, qword [rbp-8H]                     
        mov     rdx, qword [rax]                        
        mov     rax, qword [rbp-10H]                    
        mov     r8d, esi                                
        lea     rsi, [rel documentary_output]                        
        mov     rdi, rax                                
        mov     eax, 0                                  
        call    fprintf                                 
        nop                                             
        leave                                           
        ret                                             


documentary_quotient:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     rax, qword [rbp-8H]                     
        mov     eax, dword [rax+8H]                     
        vcvtsi2sd xmm1, xmm1, eax                       
        vmovsd  qword [rbp-10H], xmm1                   
        mov     rax, qword [rbp-8H]                     
        mov     rax, qword [rax]                        
        mov     rdi, rax                                
        call    strlen                                  
        test    rax, rax                                
        js      documentary_quotient_1
        vcvtsi2sd xmm0, xmm0, rax                       
        jmp     documentary_quotient_2
documentary_quotient_1:
        mov     rdx, rax
        shr     rdx, 1                                  
        and     eax, 01H                                
        or      rdx, rax                                
        vcvtsi2sd xmm0, xmm0, rdx                       
        vaddsd  xmm0, xmm0, xmm0                        
documentary_quotient_2:
        vmovsd  xmm2, qword [rbp-10H]
        vdivsd  xmm0, xmm2, xmm0                        
        vmovq   rax, xmm0                               
        vmovq   xmm0, rax                               
        leave                                           
        ret                                             


cartoon_in:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     qword [rbp-20H], rsi                    
        mov     rax, qword [rbp-20H]                    
        mov     rdi, rax                                
        call    file_read_string                        
        mov     rdx, qword [rbp-18H]                    
        mov     qword [rdx], rax                        
        mov     rax, qword [rbp-20H]                    
        mov     rdi, rax                                
        call    file_read_int                           
        mov     rdx, qword [rbp-18H]                    
        mov     dword [rdx+8H], eax                     
        mov     rax, qword [rbp-20H]                    
        mov     rdi, rax                                
        call    file_read_string                        
        mov     qword [rbp-8H], rax                     
        mov     rax, qword [rbp-8H]                     
        lea     rdx, [rel draw_lowercase]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    strcmp                                  
        test    eax, eax                                
        jnz     cartoon_in_puppet_case
        mov     rax, qword [rbp-18H]                    
        mov     byte [rax+0CH], 1                       
        jmp     cartoon_in_end_2
cartoon_in_puppet_case:
        mov     rax, qword [rbp-8H]
        lea     rdx, [rel puppet_lowercase]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    strcmp                                  
        test    eax, eax                                
        jnz     cartoon_in_plasticine_case
        mov     rax, qword [rbp-18H]                    
        mov     byte [rax+0CH], 2                       
        jmp     cartoon_in_end_2
cartoon_in_plasticine_case:
        mov     rax, qword [rbp-8H]
        lea     rdx, [rel plasticine_lowercase]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    strcmp                                  
        test    eax, eax                                
        jnz     cartoon_in_end_1
        mov     rax, qword [rbp-18H]                    
        mov     byte [rax+0CH], 3                       
        jmp     cartoon_in_end_2
cartoon_in_end_1:
        mov     rax, qword [rbp-18H]
        mov     byte [rax+0CH], 1                       
cartoon_in_end_2:
        mov     rax, qword [rbp-8H]
        mov     rdi, rax                                
        call    free                                    
        nop                                             
        leave                                           
        ret                                             


cartoon_in_random:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     eax, 0                                  
        call    random_string                           
        mov     rdx, qword [rbp-8H]                     
        mov     qword [rdx], rax                        
        mov     esi, 2021                               
        mov     edi, 1950                               
        call    random_int                              
        mov     rdx, qword [rbp-8H]                     
        mov     dword [rdx+8H], eax                     
        mov     esi, 3                                  
        mov     edi, 1                                  
        call    random_int                              
        mov     edx, eax                                
        mov     rax, qword [rbp-8H]                     
        mov     byte [rax+0CH], dl                      
        nop                                             
        leave                                           
        ret                                             


cartoon_out:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     qword [rbp-20H], rsi                    
        mov     rax, qword [rbp-18H]                    
        movzx   eax, byte [rax+0CH]                     
        movsx   eax, al                                 
        cmp     eax, 3                                  
        jz      cartoon_out_plasticine_case
        cmp     eax, 3                                  
        jg      cartoon_out_end
        cmp     eax, 1                                  
        jz      cartoon_out_draw_case
        cmp     eax, 2                                  
        jz      cartoon_out_puppet_case
        jmp     cartoon_out_end
cartoon_out_draw_case:
        lea     rax, [rel draw_uppercase]
        mov     qword [rbp-8H], rax                     
        jmp     cartoon_out_end
cartoon_out_puppet_case:
        lea     rax, [rel puppet_uppercase]
        mov     qword [rbp-8H], rax                     
        jmp     cartoon_out_end
cartoon_out_plasticine_case:  lea     rax, [rel plasticine_uppercase]
        mov     qword [rbp-8H], rax                     
        nop                                             
cartoon_out_end:  mov     rax, qword [rbp-18H]
        mov     ecx, dword [rax+8H]                     
        mov     rax, qword [rbp-18H]                    
        mov     rdx, qword [rax]                        
        mov     rsi, qword [rbp-8H]                     
        mov     rax, qword [rbp-20H]                    
        mov     r8, rsi                                 
        lea     rsi, [rel cartoon_output]                        
        mov     rdi, rax                                
        mov     eax, 0                                  
        call    fprintf                                 
        nop                                             
        leave                                           
        ret                                             


cartoon_quotient:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     rax, qword [rbp-8H]                     
        mov     eax, dword [rax+8H]                     
        vcvtsi2sd xmm1, xmm1, eax                       
        vmovsd  qword [rbp-10H], xmm1                   
        mov     rax, qword [rbp-8H]                     
        mov     rax, qword [rax]                        
        mov     rdi, rax                                
        call    strlen                                  
        test    rax, rax                                
        js      cartoon_quotient_1
        vcvtsi2sd xmm0, xmm0, rax                       
        jmp     cartoon_quotient_2
cartoon_quotient_1:
        mov     rdx, rax
        shr     rdx, 1                                  
        and     eax, 01H                                
        or      rdx, rax                                
        vcvtsi2sd xmm0, xmm0, rdx                       
        vaddsd  xmm0, xmm0, xmm0                        
cartoon_quotient_2:
        vmovsd  xmm2, qword [rbp-10H]
        vdivsd  xmm0, xmm2, xmm0                        
        vmovq   rax, xmm0                               
        vmovq   xmm0, rax                               
        leave                                           
        ret                                             


fiction_in:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     qword [rbp-10H], rsi                    
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    file_read_string                        
        mov     rdx, qword [rbp-8H]                     
        mov     qword [rdx], rax                        
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    file_read_int                           
        mov     rdx, qword [rbp-8H]                     
        mov     dword [rdx+8H], eax                     
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    file_read_string                        
        mov     rdx, qword [rbp-8H]                     
        mov     qword [rdx+10H], rax                    
        nop                                             
        leave                                           
        ret                                             


fiction_in_random:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     eax, 0                                  
        call    random_string                           
        mov     rdx, qword [rbp-8H]                     
        mov     qword [rdx], rax                        
        mov     esi, 2021                               
        mov     edi, 1950                               
        call    random_int                              
        mov     rdx, qword [rbp-8H]                     
        mov     dword [rdx+8H], eax                     
        mov     eax, 0                                  
        call    random_string                           
        mov     rdx, qword [rbp-8H]                     
        mov     qword [rdx+10H], rax                    
        nop                                             
        leave                                           
        ret                                             


fiction_out:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     qword [rbp-10H], rsi                    
        mov     rax, qword [rbp-8H]                     
        mov     rsi, qword [rax+10H]                    
        mov     rax, qword [rbp-8H]                     
        mov     ecx, dword [rax+8H]                     
        mov     rax, qword [rbp-8H]                     
        mov     rdx, qword [rax]                        
        mov     rax, qword [rbp-10H]                    
        mov     r8, rsi                                 
        lea     rsi, [rel fiction_output]                        
        mov     rdi, rax                                
        mov     eax, 0                                  
        call    fprintf                                 
        nop                                             
        leave                                           
        ret                                             


fiction_quotient:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     rax, qword [rbp-8H]                     
        mov     eax, dword [rax+8H]                     
        vcvtsi2sd xmm1, xmm1, eax                       
        vmovsd  qword [rbp-10H], xmm1                   
        mov     rax, qword [rbp-8H]                     
        mov     rax, qword [rax]                        
        mov     rdi, rax                                
        call    strlen                                  
        test    rax, rax                                
        js      fiction_quotient_1
        vcvtsi2sd xmm0, xmm0, rax                       
        jmp     fiction_quotient_2
fiction_quotient_1:
        mov     rdx, rax
        shr     rdx, 1                                  
        and     eax, 01H                                
        or      rdx, rax                                
        vcvtsi2sd xmm0, xmm0, rdx                       
        vaddsd  xmm0, xmm0, xmm0                        
fiction_quotient_2:
        vmovsd  xmm2, qword [rbp-10H]
        vdivsd  xmm0, xmm2, xmm0                        
        vmovq   rax, xmm0                               
        vmovq   xmm0, rax                               
        leave                                           
        ret                                             


movie_in:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     edi, 32                                 
        call    malloc                                  
        mov     qword [rbp-8H], rax                     
        lea     rax, [rbp-0CH]                          
        mov     rcx, qword [rbp-18H]                    
        mov     rdx, rax                                
        lea     rax, [rel number_format]                        
        mov     rsi, rax                                
        mov     rdi, rcx                                
        mov     eax, 0                                  
        call    __isoc99_fscanf                         
        mov     eax, dword [rbp-0CH]                    
        cmp     eax, 3                                  
        jz      movie_in_documentary_case
        cmp     eax, 3                                  
        jg      movie_in_end_1
        cmp     eax, 1                                  
        jz      movie_in_fiction_case
        cmp     eax, 2                                  
        jz      movie_in_cartoon_case
        jmp     movie_in_end_1
movie_in_fiction_case:
        mov     rax, qword [rbp-8H]
        mov     byte [rax], 1                           
        mov     rax, qword [rbp-8H]                     
        add     rax, 8                                  
        mov     rdx, qword [rbp-18H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    fiction_in                              
        mov     rax, qword [rbp-8H]                     
        jmp     movie_in_end_2
movie_in_cartoon_case:
        mov     rax, qword [rbp-8H]
        mov     byte [rax], 2                           
        mov     rax, qword [rbp-8H]                     
        add     rax, 8                                  
        mov     rdx, qword [rbp-18H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    cartoon_in                              
        mov     rax, qword [rbp-8H]                     
        jmp     movie_in_end_2
movie_in_documentary_case:
        mov     rax, qword [rbp-8H]
        mov     byte [rax], 3                           
        mov     rax, qword [rbp-8H]                     
        add     rax, 8                                  
        mov     rdx, qword [rbp-18H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    documentary_in                          
        mov     rax, qword [rbp-8H]                     
        jmp     movie_in_end_2
movie_in_end_1:
        mov     eax, 0
movie_in_end_2:
        leave
        ret                                             


movie_in_random:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     edi, 32                                 
        call    malloc                                  
        mov     qword [rbp-8H], rax                     
        mov     esi, 3                                  
        mov     edi, 1                                  
        call    random_int                              
        mov     dword [rbp-0CH], eax                    
        cmp     dword [rbp-0CH], 3                      
        jz      movie_random_documentary_case
        cmp     dword [rbp-0CH], 3                      
        jg      movie_random_end
        cmp     dword [rbp-0CH], 1                      
        jz      movie_random_fiction_case
        cmp     dword [rbp-0CH], 2                      
        jz      movie_random_cartoon_case
        jmp     movie_random_end
movie_random_fiction_case:
        mov     rax, qword [rbp-8H]
        mov     byte [rax], 1                           
        mov     rax, qword [rbp-8H]                     
        add     rax, 8                                  
        mov     rdi, rax                                
        call    fiction_in_random                       
        jmp     movie_random_end
movie_random_cartoon_case:
        mov     rax, qword [rbp-8H]
        mov     byte [rax], 2                           
        mov     rax, qword [rbp-8H]                     
        add     rax, 8                                  
        mov     rdi, rax                                
        call    cartoon_in_random                       
        jmp     movie_random_end
movie_random_documentary_case:  mov     rax, qword [rbp-8H]
        mov     byte [rax], 3                           
        mov     rax, qword [rbp-8H]                     
        add     rax, 8                                  
        mov     rdi, rax                                
        call    documentary_in_random                   
        nop                                             
movie_random_end:
        mov     rax, qword [rbp-8H]
        leave                                           
        ret                                             


movie_out:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     qword [rbp-10H], rsi                    
        mov     rax, qword [rbp-8H]                     
        movzx   eax, byte [rax]                         
        movsx   eax, al                                 
        cmp     eax, 3                                  
        jz      movie_out_documentary_case
        cmp     eax, 3                                  
        jg      movie_out_end_1
        cmp     eax, 1                                  
        jz      movie_out_fiction_case
        cmp     eax, 2                                  
        jz      movie_out_cartoon_case
        jmp     movie_out_end_1
movie_out_fiction_case:
        mov     rax, qword [rbp-8H]
        add     rax, 8                                  
        mov     rdx, qword [rbp-10H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    fiction_out                             
        jmp     movie_out_end_2
movie_out_cartoon_case:
        mov     rax, qword [rbp-8H]
        add     rax, 8                                  
        mov     rdx, qword [rbp-10H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    cartoon_out                             
        jmp     movie_out_end_2
movie_out_documentary_case:  mov     rax, qword [rbp-8H]
        add     rax, 8                                  
        mov     rdx, qword [rbp-10H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    documentary_out                         
        jmp     movie_out_end_2
movie_out_end_1:  lea     rax, [rel incorrect_movie]
        mov     rdi, rax                                
        call    puts                                    
        nop                                             
movie_out_end_2:  nop
        leave                                           
        ret                                             


movie_quotient:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     rax, qword [rbp-8H]                     
        movzx   eax, byte [rax]                         
        movsx   eax, al                                 
        cmp     eax, 3                                  
        jz      movie_quotient_documentary_case
        cmp     eax, 3                                  
        jg      movie_quotient_end_1
        cmp     eax, 1                                  
        jz      movie_quotient_fiction_case
        cmp     eax, 2                                  
        jz      movie_quotient_cartoon_case
        jmp     movie_quotient_end_1
movie_quotient_fiction_case:
        mov     rax, qword [rbp-8H]
        add     rax, 8                                  
        mov     rdi, rax                                
        call    fiction_quotient                        
        vmovq   rax, xmm0                               
        jmp     movie_quotient_end_2
movie_quotient_cartoon_case:
        mov     rax, qword [rbp-8H]
        add     rax, 8                                  
        mov     rdi, rax                                
        call    cartoon_quotient                        
        vmovq   rax, xmm0                               
        jmp     movie_quotient_end_2
movie_quotient_documentary_case:
        mov     rax, qword [rbp-8H]
        add     rax, 8                                  
        mov     rdi, rax                                
        call    documentary_quotient                    
        vmovq   rax, xmm0                               
        jmp     movie_quotient_end_2
movie_quotient_end_1:
        mov     rax, qword [rel zero]
movie_quotient_end_2:
        vmovq   xmm0, rax
        leave                                           
        ret                                             


container_init:
        push    rbp                                     
        mov     rbp, rsp                                
        mov     qword [rbp-8H], rdi                     
        mov     rax, qword [rbp-8H]                     
        mov     dword [rax], 0                          
        nop                                             
        pop     rbp                                     
        ret                                             


container_clear:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     dword [rbp-4H], 0                       
        jmp     container_clear_loop_2
container_clear_loop_1:
        mov     rdx, qword [rbp-18H]
        mov     eax, dword [rbp-4H]                     
        cdqe                                            
        mov     rax, qword [rdx+rax*8+8H]               
        mov     rdi, rax                                
        call    free                                    
        inc     dword [rbp-4H]                          
container_clear_loop_2:
        mov     rax, qword [rbp-18H]
        mov     eax, dword [rax]                        
        cmp     dword [rbp-4H], eax                     
        jl      container_clear_loop_1
        mov     rax, qword [rbp-18H]                    
        mov     dword [rax], 0                          
        nop                                             
        leave                                           
        ret                                             


container_in:
        push    rbp                                     
        mov     rbp, rsp                                
        push    rbx                                     
        sub     rsp, 24                                 
        mov     qword [rbp-18H], rdi                    
        mov     qword [rbp-20H], rsi                    
        jmp     container_in_loop_2
container_in_loop_1:
        mov     rax, qword [rbp-18H]
        mov     ebx, dword [rax]                        
        mov     rax, qword [rbp-20H]                    
        mov     rdi, rax                                
        call    movie_in                                
        mov     rcx, qword [rbp-18H]                    
        movsxd  rdx, ebx                                
        mov     qword [rcx+rdx*8+8H], rax               
        mov     rdx, qword [rbp-18H]                    
        movsxd  rax, ebx                                
        mov     rax, qword [rdx+rax*8+8H]               
        test    rax, rax                                
        jz      container_in_loop_2
        mov     rax, qword [rbp-18H]                    
        mov     eax, dword [rax]                        
        lea     edx, [rax+1H]                           
        mov     rax, qword [rbp-18H]                    
        mov     dword [rax], edx                        
container_in_loop_2:
        mov     rax, qword [rbp-20H]
        mov     rdi, rax                                
        call    feof                                    
        test    eax, eax                                
        jz      container_in_loop_1
        nop                                             
        nop                                             
        mov     rbx, qword [rbp-8H]                     
        leave                                           
        ret                                             


container_in_random:
        push    rbp                                     
        mov     rbp, rsp                                
        push    rbx                                     
        sub     rsp, 24                                 
        mov     qword [rbp-18H], rdi                    
        mov     dword [rbp-1CH], esi                    
        jmp     container_in_random_2
container_in_random_1:
        mov     rax, qword [rbp-18H]
        mov     ebx, dword [rax]                        
        mov     eax, 0                                  
        call    movie_in_random                         
        mov     rcx, qword [rbp-18H]                    
        movsxd  rdx, ebx                                
        mov     qword [rcx+rdx*8+8H], rax               
        mov     rdx, qword [rbp-18H]                    
        movsxd  rax, ebx                                
        mov     rax, qword [rdx+rax*8+8H]               
        test    rax, rax                                
        jz      container_in_random_2
        mov     rax, qword [rbp-18H]                    
        mov     eax, dword [rax]                        
        lea     edx, [rax+1H]                           
        mov     rax, qword [rbp-18H]                    
        mov     dword [rax], edx                        
container_in_random_2:
        mov     rax, qword [rbp-18H]
        mov     eax, dword [rax]                        
        cmp     dword [rbp-1CH], eax                    
        jg      container_in_random_1
        nop                                             
        nop                                             
        mov     rbx, qword [rbp-8H]                     
        leave                                           
        ret                                             


container_out:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     qword [rbp-20H], rsi                    
        mov     rax, qword [rbp-18H]                    
        mov     edx, dword [rax]                        
        mov     rax, qword [rbp-20H]                    
        lea     rcx, [rel container_contains_string]                        
        mov     rsi, rcx                                
        mov     rdi, rax                                
        mov     eax, 0                                  
        call    fprintf                                 
        mov     dword [rbp-4H], 0                       
        jmp     container_out_1
container_out_2:
        mov     eax, dword [rbp-4H]
        lea     edx, [rax+1H]                           
        mov     rax, qword [rbp-20H]                    
        lea     rcx, [rel number_format_with_colon]                        
        mov     rsi, rcx                                
        mov     rdi, rax                                
        mov     eax, 0                                  
        call    fprintf                                 
        mov     rdx, qword [rbp-18H]                    
        mov     eax, dword [rbp-4H]                     
        cdqe                                            
        mov     rax, qword [rdx+rax*8+8H]               
        mov     rdx, qword [rbp-20H]                    
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    movie_out                               
        inc     dword [rbp-4H]                          
container_out_1:
        mov     rax, qword [rbp-18H]
        mov     eax, dword [rax]                        
        cmp     dword [rbp-4H], eax                     
        jl      container_out_2
        nop                                             
        nop                                             
        leave                                           
        ret                                             


container_shake_sort:
        push    rbp                                     
        mov     rbp, rsp                                
        push    rbx                                     
        sub     rsp, 72                                 
        mov     qword [rbp-48H], rdi                    
        mov     rax, qword [rbp-48H]                    
        mov     eax, dword [rax]                        
        dec     eax                                     
        mov     dword [rbp-14H], eax                    
        mov     dword [rbp-18H], 0                      
        mov     rax, qword [rbp-48H]                    
        mov     eax, dword [rax]                        
        dec     eax                                     
        mov     dword [rbp-1CH], eax                    
container_shake_sort_loop_1:
        mov     eax, dword [rbp-18H]
        mov     dword [rbp-20H], eax                    
        jmp     container_shake_sort_loop_4
container_shake_sort_loop_2:
        mov     rdx, qword [rbp-48H]
        mov     eax, dword [rbp-20H]                    
        cdqe                                            
        mov     rax, qword [rdx+rax*8+8H]               
        mov     rdi, rax                                
        call    movie_quotient                          
        vmovq   rbx, xmm0                               
        mov     eax, dword [rbp-20H]                    
        inc     eax                                     
        mov     rdx, qword [rbp-48H]                    
        cdqe                                            
        mov     rax, qword [rdx+rax*8+8H]               
        mov     rdi, rax                                
        call    movie_quotient                          
        vmovq   rax, xmm0                               
        vmovq   xmm1, rbx                               
        vmovq   xmm2, rax                               
        vcomisd xmm1, xmm2                              
        jbe     container_shake_sort_loop_3
        mov     rdx, qword [rbp-48H]                    
        mov     eax, dword [rbp-20H]                    
        cdqe                                            
        mov     rax, qword [rdx+rax*8+8H]               
        mov     qword [rbp-38H], rax                    
        mov     eax, dword [rbp-20H]                    
        inc     eax                                     
        mov     rdx, qword [rbp-48H]                    
        cdqe                                            
        mov     rcx, qword [rdx+rax*8+8H]               
        mov     rdx, qword [rbp-48H]                    
        mov     eax, dword [rbp-20H]                    
        cdqe                                            
        mov     qword [rdx+rax*8+8H], rcx               
        mov     eax, dword [rbp-20H]                    
        inc     eax                                     
        mov     rdx, qword [rbp-48H]                    
        cdqe                                            
        mov     rcx, qword [rbp-38H]                    
        mov     qword [rdx+rax*8+8H], rcx               
        mov     eax, dword [rbp-20H]                    
        mov     dword [rbp-14H], eax                    
container_shake_sort_loop_3:
        inc     dword [rbp-20H]
container_shake_sort_loop_4:
        mov     eax, dword [rbp-20H]
        cmp     eax, dword [rbp-1CH]                    
        jl      container_shake_sort_loop_2
        mov     eax, dword [rbp-14H]                    
        mov     dword [rbp-1CH], eax                    
        mov     eax, dword [rbp-1CH]                    
        mov     dword [rbp-24H], eax                    
        jmp     container_shake_sort_loop_7
container_shake_sort_loop_5:
        mov     rdx, qword [rbp-48H]
        mov     eax, dword [rbp-24H]                    
        cdqe                                            
        mov     rax, qword [rdx+rax*8+8H]               
        mov     rdi, rax                                
        call    movie_quotient                          
        vmovq   rbx, xmm0                               
        mov     eax, dword [rbp-24H]                    
        dec     eax                                     
        mov     rdx, qword [rbp-48H]                    
        cdqe                                            
        mov     rax, qword [rdx+rax*8+8H]               
        mov     rdi, rax                                
        call    movie_quotient                          
        vmovq   rax, xmm0                               
        vmovq   xmm3, rax                               
        vmovq   xmm4, rbx                               
        vcomisd xmm3, xmm4                              
        jbe     container_shake_sort_loop_6
        mov     rdx, qword [rbp-48H]                    
        mov     eax, dword [rbp-24H]                    
        cdqe                                            
        mov     rax, qword [rdx+rax*8+8H]               
        mov     qword [rbp-30H], rax                    
        mov     eax, dword [rbp-24H]                    
        dec     eax                                     
        mov     rdx, qword [rbp-48H]                    
        cdqe                                            
        mov     rcx, qword [rdx+rax*8+8H]               
        mov     rdx, qword [rbp-48H]                    
        mov     eax, dword [rbp-24H]                    
        cdqe                                            
        mov     qword [rdx+rax*8+8H], rcx               
        mov     eax, dword [rbp-24H]                    
        dec     eax                                     
        mov     rdx, qword [rbp-48H]                    
        cdqe                                            
        mov     rcx, qword [rbp-30H]                    
        mov     qword [rdx+rax*8+8H], rcx               
        mov     eax, dword [rbp-24H]                    
        mov     dword [rbp-14H], eax                    
container_shake_sort_loop_6:
        dec     dword [rbp-24H]
container_shake_sort_loop_7:
        mov     eax, dword [rbp-24H]
        cmp     eax, dword [rbp-18H]                    
        jg      container_shake_sort_loop_5
        mov     eax, dword [rbp-14H]                    
        mov     dword [rbp-18H], eax                    
        mov     eax, dword [rbp-18H]                    
        cmp     eax, dword [rbp-1CH]                    
        jl      container_shake_sort_loop_1
        nop                                             
        nop                                             
        mov     rbx, qword [rbp-8H]                     
        leave                                           
        ret                                             


incorrect_command_line:
        push    rbp                                     
        mov     rbp, rsp                                
        lea     rax, [rel incorrect_command_line_string]                        
        mov     rdi, rax                                
        call    puts                                    
        nop                                             
        pop     rbp                                     
        ret                                             


incorrect_qualifier_value:
        push    rbp                                     
        mov     rbp, rsp                                
        lea     rax, [rel incorrect_qualifier_value_string]                        
        mov     rdi, rax                                
        call    puts                                    
        nop                                             
        pop     rbp                                     
        ret                                             


incorrect_number_of_items:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     dword [rbp-4H], edi                     
        mov     eax, dword [rbp-4H]                     
        mov     esi, eax                                
        lea     rax, [rel incorrect_number_of_items_string]                        
        mov     rdi, rax                                
        mov     eax, 0                                  
        call    printf                                  
        nop                                             
        leave                                           
        ret                                             


incorrect_files:
        push    rbp                                     
        mov     rbp, rsp                                
        lea     rax, [rel incorrect_files_string]                        
        mov     rdi, rax                                
        mov     eax, 0                                  
        call    printf                                  
        nop                                             
        pop     rbp                                     
        ret                                             


main:   
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 80096                              
        mov     dword [rbp-138D4H], edi                 
        mov     qword [rbp-138E0H], rsi                 
        mov     edi, 0                                  
        call    time                                    
        mov     edi, eax                                
        call    srand                                   
        mov     rax, qword [rbp-138E0H]                 
        mov     rax, qword [rax+8H]                     
        mov     qword [rbp-8H], rax                     
        mov     rax, qword [rbp-138E0H]                 
        mov     rax, qword [rax+10H]                    
        mov     qword [rbp-10H], rax                    
        mov     rax, qword [rbp-138E0H]                 
        mov     rax, qword [rax+18H]                    
        mov     qword [rbp-18H], rax                    
        mov     rax, qword [rbp-138E0H]                 
        mov     rax, qword [rax+20H]                    
        mov     qword [rbp-20H], rax                    
        cmp     dword [rbp-138D4H], 5                   
        jz      start_case
        mov     eax, 0                                  
        call    incorrect_command_line                  
        mov     edi, 1                                  
        call    exit                                    
start_case:
        lea     rax, [rel start]
        mov     rdi, rax                                
        call    puts                                    
        lea     rax, [rbp-138D0H]                       
        mov     edx, 80008                              
        mov     esi, 0                                  
        mov     rdi, rax                                
        call    memset                                  
        lea     rax, [rbp-138D0H]                       
        mov     rdi, rax                                
        call    container_init                          
        mov     rax, qword [rbp-8H]                     
        lea     rdx, [rel file_qualifier]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    strcmp                                  
        test    eax, eax                                
        jnz     number_qualifier_case
        mov     rax, qword [rbp-10H]                    
        lea     rdx, [rel read_write_access]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    fopen                                   
        mov     qword [rbp-30H], rax                    
        mov     rdx, qword [rbp-30H]                    
        lea     rax, [rbp-138D0H]                       
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    container_in                            
        mov     rax, qword [rbp-30H]                    
        mov     rdi, rax                                
        call    fclose                                  
        jmp     open_files
number_qualifier_case:
        mov     rax, qword [rbp-8H]
        lea     rdx, [rel number_qualifier]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    strcmp                                  
        test    eax, eax                                
        jnz     incorrect_qualifier_value_case
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    atoi                                    
        mov     dword [rbp-24H], eax                    
        cmp     dword [rbp-24H], 0                      
        jle     incorrect_number_of_items_case
        cmp     dword [rbp-24H], 10000                  
        jle     in_random_case
incorrect_number_of_items_case:
        mov     eax, dword [rbp-24H]
        mov     edi, eax                                
        call    incorrect_number_of_items               
        mov     edi, 3                                  
        call    exit                                    
in_random_case:  mov     edx, dword [rbp-24H]
        lea     rax, [rbp-138D0H]                       
        mov     esi, edx                                
        mov     rdi, rax                                
        call    container_in_random                     
        jmp     open_files
incorrect_qualifier_value_case:
        mov     eax, 0
        call    incorrect_qualifier_value               
        mov     edi, 2                                  
        call    exit                                    
open_files:
        mov     rax, qword [rbp-18H]
        lea     rdx, [rel write_plus_access]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    fopen                                   
        mov     qword [rbp-38H], rax                    
        mov     rax, qword [rbp-20H]                    
        lea     rdx, [rel write_plus_access]                        
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    fopen                                   
        mov     qword [rbp-40H], rax                    
        cmp     qword [rbp-38H], 0                      
        jz      incorrect_files_case
        cmp     qword [rbp-40H], 0                      
        jnz     output_container_end
incorrect_files_case:
        mov     eax, 0
        call    incorrect_files                         
        mov     edi, 4                                  
        call    exit                                    
output_container_end:
        mov     rax, qword [rbp-38H]
        mov     rcx, rax                                
        mov     edx, 17                                 
        mov     esi, 1                                  
        lea     rax, [rel container_input]                        
        mov     rdi, rax                                
        call    fwrite                                  
        mov     rdx, qword [rbp-38H]                    
        lea     rax, [rbp-138D0H]                       
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    container_out                           
        lea     rax, [rbp-138D0H]                       
        mov     rdi, rax                                
        call    container_shake_sort                    
        mov     rax, qword [rbp-40H]                    
        mov     rcx, rax                                
        mov     edx, 30                                 
        mov     esi, 1                                  
        lea     rax, [rel container_sorted]                        
        mov     rdi, rax                                
        call    fwrite                                  
        mov     rdx, qword [rbp-40H]                    
        lea     rax, [rbp-138D0H]                       
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    container_out                           
        lea     rax, [rbp-138D0H]                       
        mov     rdi, rax                                
        call    container_clear                         
        mov     rax, qword [rbp-38H]                    
        mov     rdi, rax                                
        call    fclose                                  
        mov     rax, qword [rbp-40H]                    
        mov     rdi, rax                                
        call    fclose                                  
        lea     rax, [rel stop]                        
        mov     rdi, rax                                
        call    puts                                    
        mov     edi, 0                                  

        call    exit

SECTION .rodata

documentary_output: db "Documentary: name = %s, year = %d, duration = %d", 10, 0
cartoon_output: db "Cartoon: name = %s, year = %d, type = %s", 10, 0
fiction_output: db "Fiction: name = %s, year = %d, director = %s", 10, 0
draw_lowercase: db "draw", 0
puppet_lowercase: db "puppet", 0
plasticine_lowercase: db "plasticine", 0
draw_uppercase: db "DRAW", 0
puppet_uppercase: db "PUPPET", 0
plasticine_uppercase: db "PLASTICINE", 0
number_format: db "%d", 0
number_format_with_colon: db "%d: ", 0
incorrect_movie: db "Incorrect movie!", 10, 0
container_contains_string: db "Container contains %d elements.", 10, 0
incorrect_command_line_string: db "incorrect command line!", 10, "  Waited:", 10, "     command -f infile outfile01 outfile02", 10, "  Or:", 10, "     command -n number outfile01 outfile02", 10, 0
incorrect_qualifier_value_string: db "incorrect qualifier value!", 10, "  Waited:", 10, "     command -f infile outfile01 outfile02", 10, "  Or:", 10, "     command -n number outfile01 outfile02", 10, 0
incorrect_number_of_items_string: db "incorrect number of items = %d. Set 0 < number <= 10000", 10, 0
incorrect_files_string: db "passed files not found (or broken)", 10, 0
start: db "Start", 0
stop: db "Stop", 0
file_qualifier: db "-f", 0
number_qualifier: db "-n", 0
read_write_access: db "rw", 0
write_plus_access: db "w+", 0
container_input: db "Input container:", 10, 0
container_sorted: db "Sorted container (ascending):", 10, 0
alphabet: db "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", 0
zero:  dq 0
