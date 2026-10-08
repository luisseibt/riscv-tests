// multicore_simdev of vcml-pydrofoil (system.addr_multicore_simdev)
#define MULTICORE_SIMDEV_BASE 0x1C203000
#define SIMDEV_CORE_DONE  (*(volatile unsigned int *)(MULTICORE_SIMDEV_BASE + 0x00))
#define SIMDEV_SOUT_CORE0 (*(volatile unsigned int *)(MULTICORE_SIMDEV_BASE + 0x08))
#define SIMDEV_SOUT_CORE1 (*(volatile unsigned int *)(MULTICORE_SIMDEV_BASE + 0x0C))

static inline unsigned long read_hartid(void)
{
    unsigned long hartid;
    asm volatile("csrr %0, mhartid" : "=r"(hartid));
    return hartid;
}
