# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=x86-64 -scheduler-stats -dispatch-stats -iterations=100 -timeline -timeline-max-iterations=1  -noalias=true < %s | FileCheck %s

# LLVM-MCA-BEGIN
movb %spl, (%rax)
movb %bpl, (%rcx)
movb %sil, (%rdx)
movb %dil, (%rbx)
# LLVM-MCA-END

# LLVM-MCA-BEGIN
movw %sp, (%rax)
movw %bp, (%rcx)
movw %si, (%rdx)
movw %di, (%rbx)
# LLVM-MCA-END

# LLVM-MCA-BEGIN
movl %esp, (%rax)
movl %ebp, (%rcx)
movl %esi, (%rdx)
movl %edi, (%rbx)
# LLVM-MCA-END

# LLVM-MCA-BEGIN
movq %rsp, (%rax)
movq %rbp, (%rcx)
movq %rsi, (%rdx)
movq %rdi, (%rbx)
# LLVM-MCA-END

# LLVM-MCA-BEGIN
movd %mm0, (%rax)
movd %mm1, (%rcx)
movd %mm2, (%rdx)
movd %mm3, (%rbx)
# LLVM-MCA-END

# LLVM-MCA-BEGIN
movaps %xmm0, (%rax)
movaps %xmm1, (%rcx)
movaps %xmm2, (%rdx)
movaps %xmm3, (%rbx)
# LLVM-MCA-END

# CHECK:      [0] Code Region

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      400
# CHECK-NEXT: Total Cycles:      403
# CHECK-NEXT: Total uOps:        400

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    0.99
# CHECK-NEXT: IPC:               0.99
# CHECK-NEXT: Block RThroughput: 4.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     1.00           *            movb	%spl, (%rax)
# CHECK-NEXT:  1      1     1.00           *            movb	%bpl, (%rcx)
# CHECK-NEXT:  1      1     1.00           *            movb	%sil, (%rdx)
# CHECK-NEXT:  1      1     1.00           *            movb	%dil, (%rbx)

# CHECK:      Dynamic Dispatch Stall Cycles:
# CHECK-NEXT: RAT     - Register unavailable:                      0
# CHECK-NEXT: RCU     - Retire tokens unavailable:                 0
# CHECK-NEXT: SCHEDQ  - Scheduler full:                            329  (81.6%)
# CHECK-NEXT: LQ      - Load queue full:                           0
# CHECK-NEXT: SQ      - Store queue full:                          0
# CHECK-NEXT: GROUP   - Static restrictions on the dispatch group: 0

# CHECK:      Dispatch Logic - number of cycles where we saw N micro opcodes dispatched:
# CHECK-NEXT: [# dispatched], [# cycles]
# CHECK-NEXT:  0,              56  (13.9%)
# CHECK-NEXT:  1,              329  (81.6%)
# CHECK-NEXT:  3,              1  (0.2%)
# CHECK-NEXT:  4,              17  (4.2%)

# CHECK:      Schedulers - number of cycles where we saw N micro opcodes issued:
# CHECK-NEXT: [# issued], [# cycles]
# CHECK-NEXT:  0,          3  (0.7%)
# CHECK-NEXT:  1,          400  (99.3%)

# CHECK:      Scheduler's queue usage:
# CHECK-NEXT: [1] Resource name.
# CHECK-NEXT: [2] Average number of used buffer entries.
# CHECK-NEXT: [3] Maximum number of used buffer entries.
# CHECK-NEXT: [4] Total number of buffer entries.

# CHECK:       [1]            [2]        [3]        [4]
# CHECK-NEXT: SBPortAny        49         54         54

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SBDivider
# CHECK-NEXT: [1]   - SBFPDivider
# CHECK-NEXT: [2]   - SBPort0
# CHECK-NEXT: [3]   - SBPort1
# CHECK-NEXT: [4]   - SBPort4
# CHECK-NEXT: [5]   - SBPort5
# CHECK-NEXT: [6.0] - SBPort23
# CHECK-NEXT: [6.1] - SBPort23

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]
# CHECK-NEXT:  -      -      -      -     4.00    -     2.00   2.00

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -      -      -     1.00    -      -     1.00   movb	%spl, (%rax)
# CHECK-NEXT:  -      -      -      -     1.00    -     1.00    -     movb	%bpl, (%rcx)
# CHECK-NEXT:  -      -      -      -     1.00    -      -     1.00   movb	%sil, (%rdx)
# CHECK-NEXT:  -      -      -      -     1.00    -     1.00    -     movb	%dil, (%rbx)

# CHECK:      Timeline view:
# CHECK-NEXT: Index     0123456

# CHECK:      [0,0]     DeER ..   movb	%spl, (%rax)
# CHECK-NEXT: [0,1]     D=eER..   movb	%bpl, (%rcx)
# CHECK-NEXT: [0,2]     D==eER.   movb	%sil, (%rdx)
# CHECK-NEXT: [0,3]     D===eER   movb	%dil, (%rbx)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       movb	%spl, (%rax)
# CHECK-NEXT: 1.     1     2.0    0.0    0.0       movb	%bpl, (%rcx)
# CHECK-NEXT: 2.     1     3.0    0.0    0.0       movb	%sil, (%rdx)
# CHECK-NEXT: 3.     1     4.0    0.0    0.0       movb	%dil, (%rbx)
# CHECK-NEXT:        1     2.5    0.3    0.0       <total>

# CHECK:      [1] Code Region

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      400
# CHECK-NEXT: Total Cycles:      403
# CHECK-NEXT: Total uOps:        400

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    0.99
# CHECK-NEXT: IPC:               0.99
# CHECK-NEXT: Block RThroughput: 4.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     1.00           *            movw	%sp, (%rax)
# CHECK-NEXT:  1      1     1.00           *            movw	%bp, (%rcx)
# CHECK-NEXT:  1      1     1.00           *            movw	%si, (%rdx)
# CHECK-NEXT:  1      1     1.00           *            movw	%di, (%rbx)

# CHECK:      Dynamic Dispatch Stall Cycles:
# CHECK-NEXT: RAT     - Register unavailable:                      0
# CHECK-NEXT: RCU     - Retire tokens unavailable:                 0
# CHECK-NEXT: SCHEDQ  - Scheduler full:                            329  (81.6%)
# CHECK-NEXT: LQ      - Load queue full:                           0
# CHECK-NEXT: SQ      - Store queue full:                          0
# CHECK-NEXT: GROUP   - Static restrictions on the dispatch group: 0

# CHECK:      Dispatch Logic - number of cycles where we saw N micro opcodes dispatched:
# CHECK-NEXT: [# dispatched], [# cycles]
# CHECK-NEXT:  0,              56  (13.9%)
# CHECK-NEXT:  1,              329  (81.6%)
# CHECK-NEXT:  3,              1  (0.2%)
# CHECK-NEXT:  4,              17  (4.2%)

# CHECK:      Schedulers - number of cycles where we saw N micro opcodes issued:
# CHECK-NEXT: [# issued], [# cycles]
# CHECK-NEXT:  0,          3  (0.7%)
# CHECK-NEXT:  1,          400  (99.3%)

# CHECK:      Scheduler's queue usage:
# CHECK-NEXT: [1] Resource name.
# CHECK-NEXT: [2] Average number of used buffer entries.
# CHECK-NEXT: [3] Maximum number of used buffer entries.
# CHECK-NEXT: [4] Total number of buffer entries.

# CHECK:       [1]            [2]        [3]        [4]
# CHECK-NEXT: SBPortAny        49         54         54

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SBDivider
# CHECK-NEXT: [1]   - SBFPDivider
# CHECK-NEXT: [2]   - SBPort0
# CHECK-NEXT: [3]   - SBPort1
# CHECK-NEXT: [4]   - SBPort4
# CHECK-NEXT: [5]   - SBPort5
# CHECK-NEXT: [6.0] - SBPort23
# CHECK-NEXT: [6.1] - SBPort23

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]
# CHECK-NEXT:  -      -      -      -     4.00    -     2.00   2.00

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -      -      -     1.00    -      -     1.00   movw	%sp, (%rax)
# CHECK-NEXT:  -      -      -      -     1.00    -     1.00    -     movw	%bp, (%rcx)
# CHECK-NEXT:  -      -      -      -     1.00    -      -     1.00   movw	%si, (%rdx)
# CHECK-NEXT:  -      -      -      -     1.00    -     1.00    -     movw	%di, (%rbx)

# CHECK:      Timeline view:
# CHECK-NEXT: Index     0123456

# CHECK:      [0,0]     DeER ..   movw	%sp, (%rax)
# CHECK-NEXT: [0,1]     D=eER..   movw	%bp, (%rcx)
# CHECK-NEXT: [0,2]     D==eER.   movw	%si, (%rdx)
# CHECK-NEXT: [0,3]     D===eER   movw	%di, (%rbx)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       movw	%sp, (%rax)
# CHECK-NEXT: 1.     1     2.0    0.0    0.0       movw	%bp, (%rcx)
# CHECK-NEXT: 2.     1     3.0    0.0    0.0       movw	%si, (%rdx)
# CHECK-NEXT: 3.     1     4.0    0.0    0.0       movw	%di, (%rbx)
# CHECK-NEXT:        1     2.5    0.3    0.0       <total>

# CHECK:      [2] Code Region

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      400
# CHECK-NEXT: Total Cycles:      403
# CHECK-NEXT: Total uOps:        400

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    0.99
# CHECK-NEXT: IPC:               0.99
# CHECK-NEXT: Block RThroughput: 4.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     1.00           *            movl	%esp, (%rax)
# CHECK-NEXT:  1      1     1.00           *            movl	%ebp, (%rcx)
# CHECK-NEXT:  1      1     1.00           *            movl	%esi, (%rdx)
# CHECK-NEXT:  1      1     1.00           *            movl	%edi, (%rbx)

# CHECK:      Dynamic Dispatch Stall Cycles:
# CHECK-NEXT: RAT     - Register unavailable:                      0
# CHECK-NEXT: RCU     - Retire tokens unavailable:                 0
# CHECK-NEXT: SCHEDQ  - Scheduler full:                            329  (81.6%)
# CHECK-NEXT: LQ      - Load queue full:                           0
# CHECK-NEXT: SQ      - Store queue full:                          0
# CHECK-NEXT: GROUP   - Static restrictions on the dispatch group: 0

# CHECK:      Dispatch Logic - number of cycles where we saw N micro opcodes dispatched:
# CHECK-NEXT: [# dispatched], [# cycles]
# CHECK-NEXT:  0,              56  (13.9%)
# CHECK-NEXT:  1,              329  (81.6%)
# CHECK-NEXT:  3,              1  (0.2%)
# CHECK-NEXT:  4,              17  (4.2%)

# CHECK:      Schedulers - number of cycles where we saw N micro opcodes issued:
# CHECK-NEXT: [# issued], [# cycles]
# CHECK-NEXT:  0,          3  (0.7%)
# CHECK-NEXT:  1,          400  (99.3%)

# CHECK:      Scheduler's queue usage:
# CHECK-NEXT: [1] Resource name.
# CHECK-NEXT: [2] Average number of used buffer entries.
# CHECK-NEXT: [3] Maximum number of used buffer entries.
# CHECK-NEXT: [4] Total number of buffer entries.

# CHECK:       [1]            [2]        [3]        [4]
# CHECK-NEXT: SBPortAny        49         54         54

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SBDivider
# CHECK-NEXT: [1]   - SBFPDivider
# CHECK-NEXT: [2]   - SBPort0
# CHECK-NEXT: [3]   - SBPort1
# CHECK-NEXT: [4]   - SBPort4
# CHECK-NEXT: [5]   - SBPort5
# CHECK-NEXT: [6.0] - SBPort23
# CHECK-NEXT: [6.1] - SBPort23

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]
# CHECK-NEXT:  -      -      -      -     4.00    -     2.00   2.00

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -      -      -     1.00    -      -     1.00   movl	%esp, (%rax)
# CHECK-NEXT:  -      -      -      -     1.00    -     1.00    -     movl	%ebp, (%rcx)
# CHECK-NEXT:  -      -      -      -     1.00    -      -     1.00   movl	%esi, (%rdx)
# CHECK-NEXT:  -      -      -      -     1.00    -     1.00    -     movl	%edi, (%rbx)

# CHECK:      Timeline view:
# CHECK-NEXT: Index     0123456

# CHECK:      [0,0]     DeER ..   movl	%esp, (%rax)
# CHECK-NEXT: [0,1]     D=eER..   movl	%ebp, (%rcx)
# CHECK-NEXT: [0,2]     D==eER.   movl	%esi, (%rdx)
# CHECK-NEXT: [0,3]     D===eER   movl	%edi, (%rbx)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       movl	%esp, (%rax)
# CHECK-NEXT: 1.     1     2.0    0.0    0.0       movl	%ebp, (%rcx)
# CHECK-NEXT: 2.     1     3.0    0.0    0.0       movl	%esi, (%rdx)
# CHECK-NEXT: 3.     1     4.0    0.0    0.0       movl	%edi, (%rbx)
# CHECK-NEXT:        1     2.5    0.3    0.0       <total>

# CHECK:      [3] Code Region

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      400
# CHECK-NEXT: Total Cycles:      403
# CHECK-NEXT: Total uOps:        400

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    0.99
# CHECK-NEXT: IPC:               0.99
# CHECK-NEXT: Block RThroughput: 4.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     1.00           *            movq	%rsp, (%rax)
# CHECK-NEXT:  1      1     1.00           *            movq	%rbp, (%rcx)
# CHECK-NEXT:  1      1     1.00           *            movq	%rsi, (%rdx)
# CHECK-NEXT:  1      1     1.00           *            movq	%rdi, (%rbx)

# CHECK:      Dynamic Dispatch Stall Cycles:
# CHECK-NEXT: RAT     - Register unavailable:                      0
# CHECK-NEXT: RCU     - Retire tokens unavailable:                 0
# CHECK-NEXT: SCHEDQ  - Scheduler full:                            329  (81.6%)
# CHECK-NEXT: LQ      - Load queue full:                           0
# CHECK-NEXT: SQ      - Store queue full:                          0
# CHECK-NEXT: GROUP   - Static restrictions on the dispatch group: 0

# CHECK:      Dispatch Logic - number of cycles where we saw N micro opcodes dispatched:
# CHECK-NEXT: [# dispatched], [# cycles]
# CHECK-NEXT:  0,              56  (13.9%)
# CHECK-NEXT:  1,              329  (81.6%)
# CHECK-NEXT:  3,              1  (0.2%)
# CHECK-NEXT:  4,              17  (4.2%)

# CHECK:      Schedulers - number of cycles where we saw N micro opcodes issued:
# CHECK-NEXT: [# issued], [# cycles]
# CHECK-NEXT:  0,          3  (0.7%)
# CHECK-NEXT:  1,          400  (99.3%)

# CHECK:      Scheduler's queue usage:
# CHECK-NEXT: [1] Resource name.
# CHECK-NEXT: [2] Average number of used buffer entries.
# CHECK-NEXT: [3] Maximum number of used buffer entries.
# CHECK-NEXT: [4] Total number of buffer entries.

# CHECK:       [1]            [2]        [3]        [4]
# CHECK-NEXT: SBPortAny        49         54         54

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SBDivider
# CHECK-NEXT: [1]   - SBFPDivider
# CHECK-NEXT: [2]   - SBPort0
# CHECK-NEXT: [3]   - SBPort1
# CHECK-NEXT: [4]   - SBPort4
# CHECK-NEXT: [5]   - SBPort5
# CHECK-NEXT: [6.0] - SBPort23
# CHECK-NEXT: [6.1] - SBPort23

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]
# CHECK-NEXT:  -      -      -      -     4.00    -     2.00   2.00

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -      -      -     1.00    -      -     1.00   movq	%rsp, (%rax)
# CHECK-NEXT:  -      -      -      -     1.00    -     1.00    -     movq	%rbp, (%rcx)
# CHECK-NEXT:  -      -      -      -     1.00    -      -     1.00   movq	%rsi, (%rdx)
# CHECK-NEXT:  -      -      -      -     1.00    -     1.00    -     movq	%rdi, (%rbx)

# CHECK:      Timeline view:
# CHECK-NEXT: Index     0123456

# CHECK:      [0,0]     DeER ..   movq	%rsp, (%rax)
# CHECK-NEXT: [0,1]     D=eER..   movq	%rbp, (%rcx)
# CHECK-NEXT: [0,2]     D==eER.   movq	%rsi, (%rdx)
# CHECK-NEXT: [0,3]     D===eER   movq	%rdi, (%rbx)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       movq	%rsp, (%rax)
# CHECK-NEXT: 1.     1     2.0    0.0    0.0       movq	%rbp, (%rcx)
# CHECK-NEXT: 2.     1     3.0    0.0    0.0       movq	%rsi, (%rdx)
# CHECK-NEXT: 3.     1     4.0    0.0    0.0       movq	%rdi, (%rbx)
# CHECK-NEXT:        1     2.5    0.3    0.0       <total>

# CHECK:      [4] Code Region

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      400
# CHECK-NEXT: Total Cycles:      403
# CHECK-NEXT: Total uOps:        400

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    0.99
# CHECK-NEXT: IPC:               0.99
# CHECK-NEXT: Block RThroughput: 4.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     1.00           *      U     movd	%mm0, (%rax)
# CHECK-NEXT:  1      1     1.00           *      U     movd	%mm1, (%rcx)
# CHECK-NEXT:  1      1     1.00           *      U     movd	%mm2, (%rdx)
# CHECK-NEXT:  1      1     1.00           *      U     movd	%mm3, (%rbx)

# CHECK:      Dynamic Dispatch Stall Cycles:
# CHECK-NEXT: RAT     - Register unavailable:                      0
# CHECK-NEXT: RCU     - Retire tokens unavailable:                 0
# CHECK-NEXT: SCHEDQ  - Scheduler full:                            329  (81.6%)
# CHECK-NEXT: LQ      - Load queue full:                           0
# CHECK-NEXT: SQ      - Store queue full:                          0
# CHECK-NEXT: GROUP   - Static restrictions on the dispatch group: 0

# CHECK:      Dispatch Logic - number of cycles where we saw N micro opcodes dispatched:
# CHECK-NEXT: [# dispatched], [# cycles]
# CHECK-NEXT:  0,              56  (13.9%)
# CHECK-NEXT:  1,              329  (81.6%)
# CHECK-NEXT:  3,              1  (0.2%)
# CHECK-NEXT:  4,              17  (4.2%)

# CHECK:      Schedulers - number of cycles where we saw N micro opcodes issued:
# CHECK-NEXT: [# issued], [# cycles]
# CHECK-NEXT:  0,          3  (0.7%)
# CHECK-NEXT:  1,          400  (99.3%)

# CHECK:      Scheduler's queue usage:
# CHECK-NEXT: [1] Resource name.
# CHECK-NEXT: [2] Average number of used buffer entries.
# CHECK-NEXT: [3] Maximum number of used buffer entries.
# CHECK-NEXT: [4] Total number of buffer entries.

# CHECK:       [1]            [2]        [3]        [4]
# CHECK-NEXT: SBPortAny        49         54         54

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SBDivider
# CHECK-NEXT: [1]   - SBFPDivider
# CHECK-NEXT: [2]   - SBPort0
# CHECK-NEXT: [3]   - SBPort1
# CHECK-NEXT: [4]   - SBPort4
# CHECK-NEXT: [5]   - SBPort5
# CHECK-NEXT: [6.0] - SBPort23
# CHECK-NEXT: [6.1] - SBPort23

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]
# CHECK-NEXT:  -      -      -      -     4.00    -     2.00   2.00

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -      -      -     1.00    -      -     1.00   movd	%mm0, (%rax)
# CHECK-NEXT:  -      -      -      -     1.00    -     1.00    -     movd	%mm1, (%rcx)
# CHECK-NEXT:  -      -      -      -     1.00    -      -     1.00   movd	%mm2, (%rdx)
# CHECK-NEXT:  -      -      -      -     1.00    -     1.00    -     movd	%mm3, (%rbx)

# CHECK:      Timeline view:
# CHECK-NEXT: Index     0123456

# CHECK:      [0,0]     DeER ..   movd	%mm0, (%rax)
# CHECK-NEXT: [0,1]     D=eER..   movd	%mm1, (%rcx)
# CHECK-NEXT: [0,2]     D==eER.   movd	%mm2, (%rdx)
# CHECK-NEXT: [0,3]     D===eER   movd	%mm3, (%rbx)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       movd	%mm0, (%rax)
# CHECK-NEXT: 1.     1     2.0    0.0    0.0       movd	%mm1, (%rcx)
# CHECK-NEXT: 2.     1     3.0    0.0    0.0       movd	%mm2, (%rdx)
# CHECK-NEXT: 3.     1     4.0    0.0    0.0       movd	%mm3, (%rbx)
# CHECK-NEXT:        1     2.5    0.3    0.0       <total>

# CHECK:      [5] Code Region

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      400
# CHECK-NEXT: Total Cycles:      403
# CHECK-NEXT: Total uOps:        400

# CHECK:      Dispatch Width:    4
# CHECK-NEXT: uOps Per Cycle:    0.99
# CHECK-NEXT: IPC:               0.99
# CHECK-NEXT: Block RThroughput: 4.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     1.00           *            movaps	%xmm0, (%rax)
# CHECK-NEXT:  1      1     1.00           *            movaps	%xmm1, (%rcx)
# CHECK-NEXT:  1      1     1.00           *            movaps	%xmm2, (%rdx)
# CHECK-NEXT:  1      1     1.00           *            movaps	%xmm3, (%rbx)

# CHECK:      Dynamic Dispatch Stall Cycles:
# CHECK-NEXT: RAT     - Register unavailable:                      0
# CHECK-NEXT: RCU     - Retire tokens unavailable:                 0
# CHECK-NEXT: SCHEDQ  - Scheduler full:                            329  (81.6%)
# CHECK-NEXT: LQ      - Load queue full:                           0
# CHECK-NEXT: SQ      - Store queue full:                          0
# CHECK-NEXT: GROUP   - Static restrictions on the dispatch group: 0

# CHECK:      Dispatch Logic - number of cycles where we saw N micro opcodes dispatched:
# CHECK-NEXT: [# dispatched], [# cycles]
# CHECK-NEXT:  0,              56  (13.9%)
# CHECK-NEXT:  1,              329  (81.6%)
# CHECK-NEXT:  3,              1  (0.2%)
# CHECK-NEXT:  4,              17  (4.2%)

# CHECK:      Schedulers - number of cycles where we saw N micro opcodes issued:
# CHECK-NEXT: [# issued], [# cycles]
# CHECK-NEXT:  0,          3  (0.7%)
# CHECK-NEXT:  1,          400  (99.3%)

# CHECK:      Scheduler's queue usage:
# CHECK-NEXT: [1] Resource name.
# CHECK-NEXT: [2] Average number of used buffer entries.
# CHECK-NEXT: [3] Maximum number of used buffer entries.
# CHECK-NEXT: [4] Total number of buffer entries.

# CHECK:       [1]            [2]        [3]        [4]
# CHECK-NEXT: SBPortAny        49         54         54

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SBDivider
# CHECK-NEXT: [1]   - SBFPDivider
# CHECK-NEXT: [2]   - SBPort0
# CHECK-NEXT: [3]   - SBPort1
# CHECK-NEXT: [4]   - SBPort4
# CHECK-NEXT: [5]   - SBPort5
# CHECK-NEXT: [6.0] - SBPort23
# CHECK-NEXT: [6.1] - SBPort23

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]
# CHECK-NEXT:  -      -      -      -     4.00    -     2.00   2.00

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6.0]  [6.1]  Instructions:
# CHECK-NEXT:  -      -      -      -     1.00    -      -     1.00   movaps	%xmm0, (%rax)
# CHECK-NEXT:  -      -      -      -     1.00    -     1.00    -     movaps	%xmm1, (%rcx)
# CHECK-NEXT:  -      -      -      -     1.00    -      -     1.00   movaps	%xmm2, (%rdx)
# CHECK-NEXT:  -      -      -      -     1.00    -     1.00    -     movaps	%xmm3, (%rbx)

# CHECK:      Timeline view:
# CHECK-NEXT: Index     0123456

# CHECK:      [0,0]     DeER ..   movaps	%xmm0, (%rax)
# CHECK-NEXT: [0,1]     D=eER..   movaps	%xmm1, (%rcx)
# CHECK-NEXT: [0,2]     D==eER.   movaps	%xmm2, (%rdx)
# CHECK-NEXT: [0,3]     D===eER   movaps	%xmm3, (%rbx)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       movaps	%xmm0, (%rax)
# CHECK-NEXT: 1.     1     2.0    0.0    0.0       movaps	%xmm1, (%rcx)
# CHECK-NEXT: 2.     1     3.0    0.0    0.0       movaps	%xmm2, (%rdx)
# CHECK-NEXT: 3.     1     4.0    0.0    0.0       movaps	%xmm3, (%rbx)
# CHECK-NEXT:        1     2.5    0.3    0.0       <total>
