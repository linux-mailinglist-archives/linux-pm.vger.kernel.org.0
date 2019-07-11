Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3DC65F8B
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2019 20:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfGKSfl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Jul 2019 14:35:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34776 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfGKSfl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jul 2019 14:35:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so4752745lfq.1;
        Thu, 11 Jul 2019 11:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wKMI5ifbIPZAJbFiPZeuzbDh42mNlq1JCxAaFNXFBZM=;
        b=lGRaSTp/kJmMQY4/UXQfzWQxN6kJ37RANV2EgmG5cyeA7hB9S5qJ9Qd+peZ1PkXaoC
         vpbuUibVs/kHzgURy5fDIC7k3opQL4RMEF/iBidMYYsy86PfYNsc/6QvxHJOjEQO47gm
         cMf7KkEQhOvUtQ5W+GJU0BB0iGzAOSkuVSs3yzs/RDQBTY19HTfu1AO9y90yNp5Sy+fe
         1JwYhPkIVp3/iRcOBuzOnUeRWmtt3HnuVsZC/LJdG9cs5FK40wDFJLQdEZtYmeDL2wST
         29sNSEOJyWgQPekEwCcgUcm0TXSE0mDLnIMBlWCnLYEoK4ie/544Q0pSfBKvE/3xnFfY
         70rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wKMI5ifbIPZAJbFiPZeuzbDh42mNlq1JCxAaFNXFBZM=;
        b=fZwXRBgNWwfbIr09DOj0Ci3af3ivDMrn764bY/FK5f1iwY37Ox21wM2o9JDdYxV6kZ
         hfsxD84tYB5sOtFh298QJIGjMG/j7R3DIZMc/8VKEjh3z3nsYJjK9r7S7ngBULYxwWWo
         NKaTXLGAtFWWsaWSVVgHkpLi/C79TIEnl6RufMiXrmGftAPd9lC2LDLY3doDBuRdYhlk
         VHhxq/WEkZF6LEQ84RxM6ch+2Q6CoxRz3aPOrUCnCPcpHzQRS1PFydaOgTVGNOWxVgKu
         7Bo3EcAoZ0ecg+ygxu+ncimu/M3eRF2Ht+fNNJHlSOR13V9e8rAiqq+Ye7xUTC3gVDfg
         A3sQ==
X-Gm-Message-State: APjAAAVyZo/8+8/87mzIlp4b5Hr1cS0FJ+f+nNs10Ktm/dO55KvNYXVo
        K81JEja19vAl93V6koFEg2UVebSW
X-Google-Smtp-Source: APXvYqzQQCneYJZEHs5X7hJTQTW9sgutGejskcGUh3zXo27THqReH+bSYb5at7FsIE1521mVmsfXAA==
X-Received: by 2002:ac2:50cd:: with SMTP id h13mr2686090lfm.36.1562870137666;
        Thu, 11 Jul 2019 11:35:37 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id n24sm1111590ljc.25.2019.07.11.11.35.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 11:35:36 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] cpuidle: Add unified driver for NVIDIA Tegra SoCs
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190711031312.10038-1-digetx@gmail.com>
 <20190711031312.10038-4-digetx@gmail.com>
Message-ID: <c54c43fd-9b11-4aa8-3acf-d2260d0fca4a@gmail.com>
Date:   Thu, 11 Jul 2019 21:35:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711031312.10038-4-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.07.2019 6:13, Dmitry Osipenko пишет:
> The new driver is based on the old CPU Idle drivers that are removed now
> from arm/arch/mach-tegra/ directory. Those removed drivers were reworked
> and squashed into a single unified driver that covers multiple hardware
> generations, starting from Tegra20 and ending with Tegra124.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/tegra.c     |   4 +
>  drivers/cpuidle/Kconfig.arm     |   8 +
>  drivers/cpuidle/Makefile        |   1 +
>  drivers/cpuidle/cpuidle-tegra.c | 304 ++++++++++++++++++++++++++++++++
>  include/soc/tegra/cpuidle.h     |   4 +
>  5 files changed, 321 insertions(+)
>  create mode 100644 drivers/cpuidle/cpuidle-tegra.c
> 
> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
> index d9237769a37c..f1ce2857a251 100644
> --- a/arch/arm/mach-tegra/tegra.c
> +++ b/arch/arm/mach-tegra/tegra.c
> @@ -36,6 +36,7 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
>  #include <asm/mach-types.h>
> +#include <asm/psci.h>
>  #include <asm/setup.h>
>  
>  #include "board.h"
> @@ -92,6 +93,9 @@ static void __init tegra_dt_init_late(void)
>  	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
>  	    of_machine_is_compatible("nvidia,tegra20"))
>  		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
> +
> +	if (IS_ENABLED(CONFIG_ARM_TEGRA_CPUIDLE) && !psci_smp_available())
> +		platform_device_register_simple("tegra-cpuidle", -1, NULL, 0);
>  }
>  
>  static const char * const tegra_dt_board_compat[] = {
> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
> index 48cb3d4bb7d1..d90861361f1d 100644
> --- a/drivers/cpuidle/Kconfig.arm
> +++ b/drivers/cpuidle/Kconfig.arm
> @@ -76,3 +76,11 @@ config ARM_MVEBU_V7_CPUIDLE
>  	depends on ARCH_MVEBU && !ARM64
>  	help
>  	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
> +
> +config ARM_TEGRA_CPUIDLE
> +	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
> +	depends on ARCH_TEGRA && !ARM64
> +	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
> +	select ARM_CPU_SUSPEND
> +	help
> +	  Select this to enable cpuidle for NVIDIA Tegra20/30/114/124 SoCs.
> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
> index 9d7176cee3d3..470d17fa8746 100644
> --- a/drivers/cpuidle/Makefile
> +++ b/drivers/cpuidle/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
>  obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
>  obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
>  obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
> +obj-$(CONFIG_ARM_TEGRA_CPUIDLE)		+= cpuidle-tegra.o
>  
>  ###############################################################################
>  # MIPS drivers
> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
> new file mode 100644
> index 000000000000..54974cd2255f
> --- /dev/null
> +++ b/drivers/cpuidle/cpuidle-tegra.c
> @@ -0,0 +1,304 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * CPU idle driver for Tegra CPUs
> + *
> + * Copyright (c) 2010-2013, NVIDIA Corporation.
> + * Copyright (c) 2011 Google, Inc.
> + * Author: Colin Cross <ccross@android.com>
> + *         Gary King <gking@nvidia.com>
> + *
> + * Rework for 3.3 by Peter De Schrijver <pdeschrijver@nvidia.com>
> + *
> + * Tegra20/124 driver unification by Dmitry Osipenko <digetx@gmail.com>
> + */
> +
> +#include <linux/cpuidle.h>
> +#include <linux/cpumask.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/errno.h>
> +#include <linux/ktime.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +#include <linux/clk/tegra.h>
> +#include <linux/firmware/trusted_foundations.h>
> +
> +#include <soc/tegra/cpuidle.h>
> +#include <soc/tegra/flowctrl.h>
> +#include <soc/tegra/fuse.h>
> +#include <soc/tegra/pm.h>
> +
> +#include <asm/cpuidle.h>
> +#include <asm/firmware.h>
> +#include <asm/smp_plat.h>
> +#include <asm/suspend.h>
> +
> +#define TEGRA_C1		0
> +#define TEGRA_C7		1
> +#define TEGRA_CC6		2
> +
> +static atomic_t tegra_idle_barrier;
> +
> +static inline bool tegra_cpuidle_using_firmware(void)
> +{
> +	return firmware_ops->prepare_idle && firmware_ops->do_idle;
> +}
> +
> +static int tegra_shutdown_secondary_cpu(unsigned long cpu)
> +{
> +	tegra_cpu_die(cpu);
> +
> +	return -EINVAL;
> +}
> +
> +static int tegra_await_secondary_cpus_shutdown(void)
> +{
> +	ktime_t timeout = ktime_add_ms(ktime_get(), 1);
> +
> +	/*
> +	 * The boot CPU shall await for the secondaries shutdown in order
> +	 * to power-off CPU's cluster safely.
> +	 */
> +	do {
> +		if (tegra_cpu_rail_off_ready())
> +			return 0;
> +
> +	} while (ktime_compare(ktime_get(), timeout) < 0);
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static void tegra_wake_up_secondary_cpus(void)
> +{
> +	unsigned int cpu, lcpu;
> +
> +	for_each_cpu(lcpu, cpu_online_mask) {
> +		cpu = cpu_logical_map(lcpu);
> +
> +		if (cpu > 0) {
> +			tegra_enable_cpu_clock(cpu);
> +			tegra_cpu_out_of_reset(cpu);
> +			flowctrl_write_cpu_halt(cpu, 0);
> +		}
> +	}
> +}
> +
> +static int tegra_cpuidle_cc6_enter(void)
> +{
> +	int err;
> +
> +	err = tegra_await_secondary_cpus_shutdown();
> +	if (err)
> +		return err;
> +
> +	err = tegra_idle_lp2_last();
> +
> +	tegra_wake_up_secondary_cpus();
> +
> +	return err;
> +}
> +
> +static int tegra_cpuidle_c7_enter(void)
> +{
> +	int err;
> +
> +	if (tegra_cpuidle_using_firmware()) {
> +		err = call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
> +		if (err)
> +			return err;
> +
> +		return call_firmware_op(do_idle, 0);
> +	}
> +
> +	return cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
> +}
> +
> +static int tegra_cpuidle_enter(struct cpuidle_device *dev,
> +			       int index, unsigned int cpu)
> +{
> +	int err;
> +
> +	local_fiq_disable();
> +	tegra_set_cpu_in_lp2();
> +	cpu_pm_enter();
> +
> +	switch (index) {
> +	case TEGRA_C7:
> +		err = tegra_cpuidle_c7_enter();
> +		break;
> +	case TEGRA_CC6:
> +		cpuidle_coupled_parallel_barrier(dev, &tegra_idle_barrier);

I realized that this is not very correct. We still need to do a proper
barrier with SGI checking in order to bail out if other CPU sent IPI
during of the awaiting for a coupled barrier to avoid the overhead of
unnecessary power-gating. Will correct that in the next revision.
