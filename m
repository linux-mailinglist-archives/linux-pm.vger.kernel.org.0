Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5629269896
	for <lists+linux-pm@lfdr.de>; Tue, 15 Sep 2020 00:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgINWIo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 18:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgINWIh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Sep 2020 18:08:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4870DC061788
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 15:08:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f1so223260plo.13
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2020 15:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ACcaZ7zDQbpB1KvqQAlAsDR8BmSbNCNG05Rdb2jou+A=;
        b=lCvAw4eDj179Tcmto2DAiULdnxNCHmni70ucCSNAkKQJeImpWuVV7trWDtTapcOL0y
         KTt02PXDk0Au6TvOlAuldSlt9I3qPkCJkfqZhXSZyeVyT15k6Ex1n82Vmau+v9SDB+uG
         9GI5GKvau/1++P8IY2KzG+Y4at908FcZ6wwYI/JQ+SpYwO3aUyqFnUwUgF4u3pr6qFYz
         jeEeDvmfoCTnlpH6hoH5jI/UOc32jb2DOZxJt4qZbzgujR3gc7Dlybaoh6Ib2H8r7drH
         oov5zRXnBEk/lj8ZWI7bw8MGX+rE+xKN1L4R5eoi8Ga3LKlK2P52ZiPCbrjVtyShIayj
         x5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ACcaZ7zDQbpB1KvqQAlAsDR8BmSbNCNG05Rdb2jou+A=;
        b=Cj978vqHnxZH2JM9SNMOOX5VHUcgminBSi/SqkzbSy/veSGEecgc4h59QzGv83hghQ
         mZkXTk+uOeyux2Kay2pXtqvKlixRHNWbozLhPjOMH4LqtexVAEAuwuCtW8s3MON0QzV+
         I4nnHrw6tWnnTUWiOPBbvllGod3JUpdqx5mdMGwM2NdlDvduPv9CoyluvK/gdh0K5l7Q
         85gvKt992tubNb7q5I7KeR/7Y7IcubtUDlYPfro+yLz0U43UVjwZvrVPmCOba9qJcUNo
         3/InTEwG3IfA59zbT/wrksOnEzRuUU/GMlKwXaQvD6hpDkTsBlIfbl1IP1U0dwCSruf0
         59hA==
X-Gm-Message-State: AOAM530oPes30LOHygHVQ7Q4jptD0o/E7nFe7OWO/+EgYHLnKV9pkGus
        uXccVlGaTkER3S/b5KiZI41iiQ==
X-Google-Smtp-Source: ABdhPJw1Q+4tj8NPap6ki/0ZVLo0cdZL3ydf1phEcI0gjrnyfRFwo0oiBuEUPiYZMvklRbg2odmQlw==
X-Received: by 2002:a17:90b:408b:: with SMTP id jb11mr1369784pjb.164.1600121316292;
        Mon, 14 Sep 2020 15:08:36 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id l9sm10244020pgg.29.2020.09.14.15.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:08:35 -0700 (PDT)
Date:   Mon, 14 Sep 2020 15:08:35 -0700 (PDT)
X-Google-Original-Date: Mon, 14 Sep 2020 15:08:31 PDT (-0700)
Subject:     Re: [PATCH] cpuidle: add riscv cpuidle driver
In-Reply-To: <1600048323-2964-1-git-send-email-liush@allwinnertech.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        wangkefeng.wang@huawei.com, kernel@esmil.dk, zong.li@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, liush@allwinnertech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     liush@allwinnertech.com
Message-ID: <mhng-e743b908-36de-4226-832d-bc5acbbfd81b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 13 Sep 2020 18:52:03 PDT (-0700), liush@allwinnertech.com wrote:
> This patch adds a cpuidle driver for systems based RISCV architecture.
> This patch supports state WFI. Other states will be supported in the
> future.
>
> Signed-off-by: liush <liush@allwinnertech.com>
> ---
>  arch/riscv/Kconfig               |  7 +++++
>  arch/riscv/include/asm/cpuidle.h |  7 +++++
>  arch/riscv/kernel/Makefile       |  1 +
>  arch/riscv/kernel/cpuidle.c      |  8 ++++++
>  drivers/cpuidle/Kconfig          |  5 ++++
>  drivers/cpuidle/Kconfig.riscv    | 11 ++++++++
>  drivers/cpuidle/Makefile         |  4 +++
>  drivers/cpuidle/cpuidle-riscv.c  | 55 ++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 98 insertions(+)
>  create mode 100644 arch/riscv/include/asm/cpuidle.h
>  create mode 100644 arch/riscv/kernel/cpuidle.c
>  create mode 100644 drivers/cpuidle/Kconfig.riscv
>  create mode 100644 drivers/cpuidle/cpuidle-riscv.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index df18372..c7ddb9d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -86,6 +86,7 @@ config RISCV
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> +	select CPU_IDLE
>
>  config ARCH_MMAP_RND_BITS_MIN
>  	default 18 if 64BIT
> @@ -407,6 +408,12 @@ config BUILTIN_DTB
>  	depends on RISCV_M_MODE
>  	depends on OF
>
> +menu "CPU Power Management"
> +
> +source "drivers/cpuidle/Kconfig"
> +
> +endmenu
> +
>  menu "Power management options"
>
>  source "kernel/power/Kconfig"
> diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
> new file mode 100644
> index 00000000..2599d2f
> --- /dev/null
> +++ b/arch/riscv/include/asm/cpuidle.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __RISCV_CPUIDLE_H
> +#define __RISCV_CPUIDLE_H
> +
> +extern void cpu_do_idle(void);
> +
> +#endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index dc93710..396ba9c 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -29,6 +29,7 @@ obj-y	+= riscv_ksyms.o
>  obj-y	+= stacktrace.o
>  obj-y	+= cacheinfo.o
>  obj-y	+= patch.o
> +obj-y	+= cpuidle.o

Presumably we want this to be a Kconfig option, if only to avoid excess size on
the smaller systems?

>  obj-$(CONFIG_MMU) += vdso.o vdso/
>
>  obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
> diff --git a/arch/riscv/kernel/cpuidle.c b/arch/riscv/kernel/cpuidle.c
> new file mode 100644
> index 00000000..a3289e7
> --- /dev/null
> +++ b/arch/riscv/kernel/cpuidle.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <asm/cpuidle.h>
> +
> +void cpu_do_idle(void)
> +{
> +	__asm__ __volatile__ ("wfi");
> +

We have wait_for_interrupt() that does this already, but it's one line so it
doesn't really matter.  Either way, there's an extra newline here.

Additionally, we have arch_cpu_idle() which is calling cpu_do_idle() on other
platforms.  Presumably we should be doing something similar, under the
assumption that we will eventually have cpu_do_idle() hook into CPU idle
drivers here?

> +}
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index c0aeedd..f6be0fd 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -62,6 +62,11 @@ depends on PPC
>  source "drivers/cpuidle/Kconfig.powerpc"
>  endmenu
>
> +menu "RISCV CPU Idle Drivers"
> +depends on RISCV
> +source "drivers/cpuidle/Kconfig.riscv"
> +endmenu
> +
>  config HALTPOLL_CPUIDLE
>  	tristate "Halt poll cpuidle driver"
>  	depends on X86 && KVM_GUEST
> diff --git a/drivers/cpuidle/Kconfig.riscv b/drivers/cpuidle/Kconfig.riscv
> new file mode 100644
> index 00000000..e86d36b
> --- /dev/null
> +++ b/drivers/cpuidle/Kconfig.riscv
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# RISCV CPU Idle drivers
> +#
> +config RISCV_CPUIDLE
> +        bool "Generic RISCV CPU idle Driver"
> +        select DT_IDLE_STATES
> +	select CPU_IDLE_MULTIPLE_DRIVERS

Looks like there's some space/tab issues here.  IIRC checkpatch will catch this
sort of thing.

> +        help
> +          Select this option to enable generic cpuidle driver for RISCV.
> +	  Now only support C0 State.
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 26bbc5e..4c83c4e 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -34,3 +34,7 @@ obj-$(CONFIG_MIPS_CPS_CPUIDLE)		+= cpuidle-cps.o
>  # POWERPC drivers
>  obj-$(CONFIG_PSERIES_CPUIDLE)		+= cpuidle-pseries.o
>  obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
> +
> +###############################################################################
> +# RISCV drivers
> +obj-$(CONFIG_RISCV_CPUIDLE)		+= cpuidle-riscv.o
> diff --git a/drivers/cpuidle/cpuidle-riscv.c b/drivers/cpuidle/cpuidle-riscv.c
> new file mode 100644
> index 00000000..5dddcfa
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-riscv.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RISC-V CPU idle driver.
> + *
> + * Copyright (C) 2020-2022 Allwinner Ltd
> + *
> + * Based on code - driver/cpuidle/cpuidle-at91.c
> + *
> + */
> +#include <linux/cpuidle.h>
> +#include <linux/cpumask.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <asm/cpuidle.h>
> +
> +#define MAX_IDLE_STATES	1
> +
> +/* TODO: Implement deeper idle states */
> +static int riscv_low_level_suspend_enter(int state)
> +{
> +	return 0;

As far as I can tell, this driver just doesn't do anything?  Assuming that's
the case, it's probably best to just drop everything but cpu_do_idle() until we
have something to exercise this.

> +}
> +
> +/* Actual code that puts the SoC in different idle states */
> +static int riscv_enter_idle(struct cpuidle_device *dev,
> +			struct cpuidle_driver *drv,
> +			       int index)
> +{
> +	return CPU_PM_CPU_IDLE_ENTER_PARAM(riscv_low_level_suspend_enter,
> +					   index, 0);
> +}
> +
> +static struct cpuidle_driver riscv_idle_driver = {
> +	.name			= "riscv_idle",
> +	.owner			= THIS_MODULE,
> +	.states[0]		= {
> +		.enter			= riscv_enter_idle,
> +		.exit_latency		= 1,
> +		.target_residency	= 1,
> +		.name			= "WFI",
> +		.desc			= "RISCV WFI",
> +	},
> +	.state_count = MAX_IDLE_STATES,
> +};
> +
> +static int __init riscv_cpuidle_init(void)
> +{
> +	return cpuidle_register(&riscv_idle_driver, NULL);
> +}
> +
> +device_initcall(riscv_cpuidle_init);
