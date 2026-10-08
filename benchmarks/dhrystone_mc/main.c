#include <stdint.h>
#include "helpers.h"

extern int dhrystone_main(unsigned long hartid);

// Every core runs its own copy of this program (one ELF per core, see
// linker.ld), startup.S passes mhartid in a0.
void main(int hartid) {
    dhrystone_main(hartid);
    SIMDEV_CORE_DONE = hartid;
}
