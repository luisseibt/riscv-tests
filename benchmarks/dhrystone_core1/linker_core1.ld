OUTPUT_ARCH("riscv")
ENTRY(_start)

MEMORY
{
  /* Kern 1 bekommt die zweite Hälfte: 64K ab 0x80010000 */
  ram (rwx) : ORIGIN = 0x80010000, LENGTH = 64K
}

SECTIONS
{
  /* Code and read-only data */
  .text.init : { *(.text.init) } > ram
  .text : { *(.text) *(.text.*) } > ram
  .tohost : { *(.tohost) } > ram
  .rodata : { *(.rodata) *(.rodata.*) } > ram
  
  /* Initialized data */
  .data : { *(.data) *(.data.*) } > ram
  .sdata : {
    PROVIDE( __global_pointer$ = . + 0x800 );
    *(.srodata.cst16) *(.srodata.cst8) *(.srodata.cst4) *(.srodata.cst2) *(.srodata*)
    *(.sdata .sdata.* .gnu.linkonce.s.*)
  } > ram

  /* Uninitialized data (BSS) */
  .sbss : {
    *(.sbss .sbss.* .gnu.linkonce.sb.*)
    *(.scommon)
  } > ram

  .bss : {
    . = ALIGN(4);
    PROVIDE( _bss_start = . );
    *(.bss .bss.*)
    *(COMMON)
    . = ALIGN(4);
    PROVIDE( _bss_end = . );
  } > ram

  /* Thread-local data */
  .tdata : {
    PROVIDE( _tdata_begin = . );
    *(.tdata)
    PROVIDE( _tdata_end = . );
  } > ram
  .tbss : {
    *(.tbss)
    PROVIDE( _tbss_end = . );
  } > ram

  /* End of memory boundaries used by syscalls.c (e.g. sbrk) */
  PROVIDE( _end = . );
  PROVIDE( _sp = ORIGIN(ram) + LENGTH(ram) );
}