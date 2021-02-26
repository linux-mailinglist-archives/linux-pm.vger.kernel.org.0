Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922CF326336
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 14:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBZNRV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 08:17:21 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34883 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZNRU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 08:17:20 -0500
X-Originating-IP: 81.185.174.212
Received: from [192.168.43.237] (212.174.185.81.rev.sfr.net [81.185.174.212])
        (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id DA1281BF203;
        Fri, 26 Feb 2021 13:16:15 +0000 (UTC)
Subject: Re: [RFC PATCH 1/8] RISC-V: Enable CPU_IDLE drivers
To:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Anup Patel <anup@brainfault.org>, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Liush <liush@allwinnertech.com>, linux-riscv@lists.infradead.org,
        Sandeep Tripathy <milun.tripathy@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20210221093758.210981-1-anup.patel@wdc.com>
 <20210221093758.210981-2-anup.patel@wdc.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <3a6e2af7-934d-078f-4e19-d4241809e7fb@ghiti.fr>
Date:   Fri, 26 Feb 2021 08:16:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210221093758.210981-2-anup.patel@wdc.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Anup,

Le 2/21/21 à 4:37 AM, Anup Patel a écrit :
> We force select CPU_PM and provide asm/cpuidle.h so that we can
> use CPU IDLE drivers for Linux RISC-V kernel.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>   arch/riscv/Kconfig                |  7 +++++++
>   arch/riscv/configs/defconfig      |  7 +++----
>   arch/riscv/configs/rv32_defconfig |  4 ++--
>   arch/riscv/include/asm/cpuidle.h  | 24 ++++++++++++++++++++++++
>   arch/riscv/kernel/process.c       |  3 ++-
>   5 files changed, 38 insertions(+), 7 deletions(-)
>   create mode 100644 arch/riscv/include/asm/cpuidle.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fe6862b06ead..4901200b6b6c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -37,6 +37,7 @@ config RISCV
>   	select CLONE_BACKWARDS
>   	select CLINT_TIMER if !MMU
>   	select COMMON_CLK
> +	select CPU_PM if CPU_IDLE
>   	select EDAC_SUPPORT
>   	select GENERIC_ARCH_TOPOLOGY if SMP
>   	select GENERIC_ATOMIC64 if !64BIT
> @@ -430,4 +431,10 @@ source "kernel/power/Kconfig"
>   
>   endmenu
>   
> +menu "CPU Power Management"
> +
> +source "drivers/cpuidle/Kconfig"
> +
> +endmenu
> +
>   source "drivers/firmware/Kconfig"
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 6c0625aa96c7..dc4927c0e44b 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -13,11 +13,13 @@ CONFIG_USER_NS=y
>   CONFIG_CHECKPOINT_RESTORE=y
>   CONFIG_BLK_DEV_INITRD=y
>   CONFIG_EXPERT=y
> +# CONFIG_SYSFS_SYSCALL is not set
>   CONFIG_BPF_SYSCALL=y
>   CONFIG_SOC_SIFIVE=y
>   CONFIG_SOC_VIRT=y
>   CONFIG_SMP=y
>   CONFIG_HOTPLUG_CPU=y
> +CONFIG_CPU_IDLE=y
>   CONFIG_JUMP_LABEL=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_UNLOAD=y
> @@ -65,10 +67,9 @@ CONFIG_HW_RANDOM=y
>   CONFIG_HW_RANDOM_VIRTIO=y
>   CONFIG_SPI=y
>   CONFIG_SPI_SIFIVE=y
> +# CONFIG_PTP_1588_CLOCK is not set
>   CONFIG_GPIOLIB=y
>   CONFIG_GPIO_SIFIVE=y
> -# CONFIG_PTP_1588_CLOCK is not set
> -CONFIG_POWER_RESET=y

Why do you remove this config ?

>   CONFIG_DRM=y
>   CONFIG_DRM_RADEON=y
>   CONFIG_DRM_VIRTIO_GPU=y
> @@ -132,5 +133,3 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
>   # CONFIG_FTRACE is not set
>   # CONFIG_RUNTIME_TESTING_MENU is not set
>   CONFIG_MEMTEST=y
> -# CONFIG_SYSFS_SYSCALL is not set
> -CONFIG_EFI=y

And this is one too ? If those removals are intentional, maybe you can 
add something about that in the commit description ?

> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
> index 8dd02b842fef..332e43a4a2c3 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -13,12 +13,14 @@ CONFIG_USER_NS=y
>   CONFIG_CHECKPOINT_RESTORE=y
>   CONFIG_BLK_DEV_INITRD=y
>   CONFIG_EXPERT=y
> +# CONFIG_SYSFS_SYSCALL is not set
>   CONFIG_BPF_SYSCALL=y
>   CONFIG_SOC_SIFIVE=y
>   CONFIG_SOC_VIRT=y
>   CONFIG_ARCH_RV32I=y
>   CONFIG_SMP=y
>   CONFIG_HOTPLUG_CPU=y
> +CONFIG_CPU_IDLE=y
>   CONFIG_JUMP_LABEL=y
>   CONFIG_MODULES=y
>   CONFIG_MODULE_UNLOAD=y
> @@ -67,7 +69,6 @@ CONFIG_HW_RANDOM_VIRTIO=y
>   CONFIG_SPI=y
>   CONFIG_SPI_SIFIVE=y
>   # CONFIG_PTP_1588_CLOCK is not set
> -CONFIG_POWER_RESET=y
>   CONFIG_DRM=y
>   CONFIG_DRM_RADEON=y
>   CONFIG_DRM_VIRTIO_GPU=y
> @@ -131,4 +132,3 @@ CONFIG_DEBUG_BLOCK_EXT_DEVT=y
>   # CONFIG_FTRACE is not set
>   # CONFIG_RUNTIME_TESTING_MENU is not set
>   CONFIG_MEMTEST=y
> -# CONFIG_SYSFS_SYSCALL is not set
> diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
> new file mode 100644
> index 000000000000..1042d790e446
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpuidle.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2021 Allwinner Ltd
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> + */
> +
> +#ifndef _ASM_RISCV_CPUIDLE_H
> +#define _ASM_RISCV_CPUIDLE_H
> +
> +#include <asm/barrier.h>
> +#include <asm/processor.h>
> +
> +static inline void cpu_do_idle(void)
> +{
> +	/*
> +	 * Add mb() here to ensure that all
> +	 * IO/MEM access are completed prior

accessES ?

> +	 * to enter WFI.
> +	 */
> +	mb();
> +	wait_for_interrupt();
> +}
> +
> +#endif
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index dd5f985b1f40..b5b51fd26624 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -21,6 +21,7 @@
>   #include <asm/string.h>
>   #include <asm/switch_to.h>
>   #include <asm/thread_info.h>
> +#include <asm/cpuidle.h>
>   
>   register unsigned long gp_in_global __asm__("gp");
>   
> @@ -35,7 +36,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
>   
>   void arch_cpu_idle(void)
>   {
> -	wait_for_interrupt();
> +	cpu_do_idle();
>   	raw_local_irq_enable();
>   }
>   
> 
