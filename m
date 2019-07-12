Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9579867378
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2019 18:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfGLQlH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jul 2019 12:41:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43219 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfGLQlH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jul 2019 12:41:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so9940493ljv.10;
        Fri, 12 Jul 2019 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=07LEgoyEHoGLp0Ac/lWdvUvBRaQXzLrYtdrkGFRgizM=;
        b=tJ6ww7yoECwP0CeZZVy94MX1ukQCov8d9Bd0f8HQ32l/tdRP6mZhyaH3Hr29u1YoDw
         ruGVeqqVNvRJ0UnodnHVbg9FTNkliGuvTG42X2PqzHgpIDh4c/cqDrJXIu5isCVeMeRp
         ax3gLgwh6DnoI2oqAlOCG2RIJ44cRBa6hTGLfOX4Qz8qwRT3WfVeFtCYHFKzaeOugJlU
         MY4JrTK1M9Qq7L0xDy9R3TsaK3/hyGj31uHwC/p2pLGOn83azOY66a5Ef+HFJk3We694
         hLLCMguBiU0g1Sq0bxESUj9lPhMYczjATXkJS1JV9+qUXOFE1sVg6kZ2OlO5Zw5Jt9qo
         CQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=07LEgoyEHoGLp0Ac/lWdvUvBRaQXzLrYtdrkGFRgizM=;
        b=pFwoon7agaauwTSLa23L95FwINCMDbK+epXd0CPEE3CjmaHATB1rq6c3xqwq+yJhcx
         D5gPvpazWVLbokLOnraZK2KRnqh0PZUP4tddrIsOtjJ+TZVTlOPcsdcvSlIe0OhC/3EQ
         NwM8piC/v8U8NFcqq9FPpoIR++j0peL7b8UfjYx8MQyC9jyVNkkxMrsoe1vmIqRpn3tY
         3rffvOQo9VfURok8wzNF53LWeMSOuKvpRch1t59S1jwC0k/X+1QsOGqGeKQViGBViPH/
         StZAqocxpZvus5K+HCMMP4ZOWv9+atYnqjU8Xb+TthjQ2p2sipvhaZpu7g0EU1xMjYeZ
         QjSg==
X-Gm-Message-State: APjAAAXR7dpOrRv/QxrbrJT10pBnpXV7lX7l+h8qic+pnrXd4dMUCBCh
        L5TxbnI3z+kAP//6P9PxclfDF65F
X-Google-Smtp-Source: APXvYqy7NG6KmwLiCxhrn45MUR985yNGqvu4tsI3gQc4vdOWJTLgDrlkJEB11DCYhzKOpemfZiKL/Q==
X-Received: by 2002:a2e:86c1:: with SMTP id n1mr6473745ljj.162.1562949663596;
        Fri, 12 Jul 2019 09:41:03 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id k8sm1521898lja.24.2019.07.12.09.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 09:41:02 -0700 (PDT)
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
 <c54c43fd-9b11-4aa8-3acf-d2260d0fca4a@gmail.com>
Message-ID: <01ec2515-8c54-4809-b79a-363db12c453f@gmail.com>
Date:   Fri, 12 Jul 2019 19:41:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c54c43fd-9b11-4aa8-3acf-d2260d0fca4a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.07.2019 21:35, Dmitry Osipenko пишет:
> 11.07.2019 6:13, Dmitry Osipenko пишет:
>> The new driver is based on the old CPU Idle drivers that are removed now
>> from arm/arch/mach-tegra/ directory. Those removed drivers were reworked
>> and squashed into a single unified driver that covers multiple hardware
>> generations, starting from Tegra20 and ending with Tegra124.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/mach-tegra/tegra.c     |   4 +
>>  drivers/cpuidle/Kconfig.arm     |   8 +
>>  drivers/cpuidle/Makefile        |   1 +
>>  drivers/cpuidle/cpuidle-tegra.c | 304 ++++++++++++++++++++++++++++++++
>>  include/soc/tegra/cpuidle.h     |   4 +
>>  5 files changed, 321 insertions(+)
>>  create mode 100644 drivers/cpuidle/cpuidle-tegra.c
>>
>> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
>> index d9237769a37c..f1ce2857a251 100644
>> --- a/arch/arm/mach-tegra/tegra.c
>> +++ b/arch/arm/mach-tegra/tegra.c
>> @@ -36,6 +36,7 @@
>>  #include <asm/mach/arch.h>
>>  #include <asm/mach/time.h>
>>  #include <asm/mach-types.h>
>> +#include <asm/psci.h>
>>  #include <asm/setup.h>
>>  
>>  #include "board.h"
>> @@ -92,6 +93,9 @@ static void __init tegra_dt_init_late(void)
>>  	if (IS_ENABLED(CONFIG_ARCH_TEGRA_2x_SOC) &&
>>  	    of_machine_is_compatible("nvidia,tegra20"))
>>  		platform_device_register_simple("tegra20-cpufreq", -1, NULL, 0);
>> +
>> +	if (IS_ENABLED(CONFIG_ARM_TEGRA_CPUIDLE) && !psci_smp_available())
>> +		platform_device_register_simple("tegra-cpuidle", -1, NULL, 0);
>>  }
>>  
>>  static const char * const tegra_dt_board_compat[] = {
>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>> index 48cb3d4bb7d1..d90861361f1d 100644
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>> @@ -76,3 +76,11 @@ config ARM_MVEBU_V7_CPUIDLE
>>  	depends on ARCH_MVEBU && !ARM64
>>  	help
>>  	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
>> +
>> +config ARM_TEGRA_CPUIDLE
>> +	bool "CPU Idle Driver for NVIDIA Tegra SoCs"
>> +	depends on ARCH_TEGRA && !ARM64
>> +	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>> +	select ARM_CPU_SUSPEND
>> +	help
>> +	  Select this to enable cpuidle for NVIDIA Tegra20/30/114/124 SoCs.
>> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>> index 9d7176cee3d3..470d17fa8746 100644
>> --- a/drivers/cpuidle/Makefile
>> +++ b/drivers/cpuidle/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
>>  obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
>>  obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
>>  obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
>> +obj-$(CONFIG_ARM_TEGRA_CPUIDLE)		+= cpuidle-tegra.o
>>  
>>  ###############################################################################
>>  # MIPS drivers
>> diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
>> new file mode 100644
>> index 000000000000..54974cd2255f
>> --- /dev/null
>> +++ b/drivers/cpuidle/cpuidle-tegra.c
>> @@ -0,0 +1,304 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * CPU idle driver for Tegra CPUs
>> + *
>> + * Copyright (c) 2010-2013, NVIDIA Corporation.
>> + * Copyright (c) 2011 Google, Inc.
>> + * Author: Colin Cross <ccross@android.com>
>> + *         Gary King <gking@nvidia.com>
>> + *
>> + * Rework for 3.3 by Peter De Schrijver <pdeschrijver@nvidia.com>
>> + *
>> + * Tegra20/124 driver unification by Dmitry Osipenko <digetx@gmail.com>
>> + */
>> +
>> +#include <linux/cpuidle.h>
>> +#include <linux/cpumask.h>
>> +#include <linux/cpu_pm.h>
>> +#include <linux/errno.h>
>> +#include <linux/ktime.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/types.h>
>> +
>> +#include <linux/clk/tegra.h>
>> +#include <linux/firmware/trusted_foundations.h>
>> +
>> +#include <soc/tegra/cpuidle.h>
>> +#include <soc/tegra/flowctrl.h>
>> +#include <soc/tegra/fuse.h>
>> +#include <soc/tegra/pm.h>
>> +
>> +#include <asm/cpuidle.h>
>> +#include <asm/firmware.h>
>> +#include <asm/smp_plat.h>
>> +#include <asm/suspend.h>
>> +
>> +#define TEGRA_C1		0
>> +#define TEGRA_C7		1
>> +#define TEGRA_CC6		2
>> +
>> +static atomic_t tegra_idle_barrier;
>> +
>> +static inline bool tegra_cpuidle_using_firmware(void)
>> +{
>> +	return firmware_ops->prepare_idle && firmware_ops->do_idle;
>> +}
>> +
>> +static int tegra_shutdown_secondary_cpu(unsigned long cpu)
>> +{
>> +	tegra_cpu_die(cpu);
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int tegra_await_secondary_cpus_shutdown(void)
>> +{
>> +	ktime_t timeout = ktime_add_ms(ktime_get(), 1);
>> +
>> +	/*
>> +	 * The boot CPU shall await for the secondaries shutdown in order
>> +	 * to power-off CPU's cluster safely.
>> +	 */
>> +	do {
>> +		if (tegra_cpu_rail_off_ready())
>> +			return 0;
>> +
>> +	} while (ktime_compare(ktime_get(), timeout) < 0);
>> +
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +static void tegra_wake_up_secondary_cpus(void)
>> +{
>> +	unsigned int cpu, lcpu;
>> +
>> +	for_each_cpu(lcpu, cpu_online_mask) {
>> +		cpu = cpu_logical_map(lcpu);
>> +
>> +		if (cpu > 0) {
>> +			tegra_enable_cpu_clock(cpu);
>> +			tegra_cpu_out_of_reset(cpu);
>> +			flowctrl_write_cpu_halt(cpu, 0);
>> +		}
>> +	}
>> +}
>> +
>> +static int tegra_cpuidle_cc6_enter(void)
>> +{
>> +	int err;
>> +
>> +	err = tegra_await_secondary_cpus_shutdown();
>> +	if (err)
>> +		return err;
>> +
>> +	err = tegra_idle_lp2_last();
>> +
>> +	tegra_wake_up_secondary_cpus();
>> +
>> +	return err;
>> +}
>> +
>> +static int tegra_cpuidle_c7_enter(void)
>> +{
>> +	int err;
>> +
>> +	if (tegra_cpuidle_using_firmware()) {
>> +		err = call_firmware_op(prepare_idle, TF_PM_MODE_LP2_NOFLUSH_L2);
>> +		if (err)
>> +			return err;
>> +
>> +		return call_firmware_op(do_idle, 0);
>> +	}
>> +
>> +	return cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
>> +}
>> +
>> +static int tegra_cpuidle_enter(struct cpuidle_device *dev,
>> +			       int index, unsigned int cpu)
>> +{
>> +	int err;
>> +
>> +	local_fiq_disable();
>> +	tegra_set_cpu_in_lp2();
>> +	cpu_pm_enter();
>> +
>> +	switch (index) {
>> +	case TEGRA_C7:
>> +		err = tegra_cpuidle_c7_enter();
>> +		break;
>> +	case TEGRA_CC6:
>> +		cpuidle_coupled_parallel_barrier(dev, &tegra_idle_barrier);
> 
> I realized that this is not very correct. We still need to do a proper
> barrier with SGI checking in order to bail out if other CPU sent IPI
> during of the awaiting for a coupled barrier to avoid the overhead of
> unnecessary power-gating. Will correct that in the next revision.

UPDATE: Actually, turned out it's even a necessity to handle the SGI
because GIC's driver doesn't save and replay SGI across CPU cluster PM.
