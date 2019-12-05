Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F39F8114263
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 15:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfLEOPV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 09:15:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41073 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfLEOPU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 09:15:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so2596425lfp.8;
        Thu, 05 Dec 2019 06:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wzep174WCTcC1ylDAnxlMqZM1R1EhRXQds7swrstswI=;
        b=eKN1cSEh0kd1WE7WXm3PmvW+zXtWnPq+tMxGojEk6pDa+uT8NehzL6Jehm6RSKxU1D
         bJeruxzSsmoe4Zob+mCQbqLTadh4qBX2dDbdxDuUs9ifbwFV+wRo8U7Wes22mvsKEChd
         dMwRAc+IKgdWva1j7jYXPnerw2g7qlnjDXgK3SWU8f1p5H62F/M1y1xs1Snqpy1IiIcQ
         7dSbBkZ6+SWcdImMUnu7i+vHdrYobbJzFIipc4veha56Jh7qWCbS4iyAoN//BKJGdRZx
         5Q7qqqDE0jDbrJu6f2WQkDgO1+n+FkiA1mq4F2xBSOL3nLbTLwvupluWaAWlpiAFrdoT
         6JZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wzep174WCTcC1ylDAnxlMqZM1R1EhRXQds7swrstswI=;
        b=D0l9av1K38I5lumEcD+0D8orrhvLEV/Bvf33jykxmI7EmEUfGIb9rX/1WIWxVa010o
         aNx0qJct3lK7BXNu1t/iJTd6Br4ckzkFm+g4geXRPVsK0shQhrMXXpvWos0DVxwv/Qa8
         ftExbsnKzj2cBI+2OW6PB8XjlD2aHIWBOFtY4YxsiogNobygz+PzG2PfY6UM9kCr4Ia9
         rA74/YkCjl2O/3pMtoKwlhToJeJBVIedTa67ikMEdk2WjeyR9/RlWcFZpw1Af4cXqf5a
         +FdCCYJuwEdCVneDxVkW48NrEL1DZ/n2qD2nDqwmACRh6AszJGMhsK3YAWs0Ig0Qby2o
         zHVg==
X-Gm-Message-State: APjAAAVNbpOgamBSHp8qaQaPNMOGJ+si4Td9e6B2oD412NLcJGkdSDVm
        Z5yq3r73puAJujgcZDiFB14=
X-Google-Smtp-Source: APXvYqxDsjhSKWK+uSVzdnXGuwNFxGT3Omee51LOWQUVpNA82oYyAbz8BSHfqBLZ/hseHq/ttcy9vg==
X-Received: by 2002:a19:c84:: with SMTP id 126mr5414925lfm.5.1575555317304;
        Thu, 05 Dec 2019 06:15:17 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id s22sm5158466ljm.41.2019.12.05.06.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 06:15:16 -0800 (PST)
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
To:     Sumit Gupta <sumitg@nvidia.com>, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bbasu@nvidia.com, mperttunen@nvidia.com
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9b9eb84d-2d9a-8dbd-cbe6-1595ed1e7f4e@gmail.com>
Date:   Thu, 5 Dec 2019 17:15:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.12.2019 20:32, Sumit Gupta пишет:
> Add support for CPU frequency scaling on Tegra194. The frequency
> of each core can be adjusted by writing a clock divisor value to
> an MSR on the core. The range of valid divisors is queried from
> the BPMP.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/Kconfig.arm        |   6 +
>  drivers/cpufreq/Makefile           |   1 +
>  drivers/cpufreq/tegra194-cpufreq.c | 423 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 430 insertions(+)
>  create mode 100644 drivers/cpufreq/tegra194-cpufreq.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index a905796..4bcd47c 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -320,6 +320,12 @@ config ARM_TEGRA186_CPUFREQ
>  	help
>  	  This adds the CPUFreq driver support for Tegra186 SOCs.
>  
> +config ARM_TEGRA194_CPUFREQ
> +	tristate "Tegra194 CPUFreq support"
> +	depends on ARCH_TEGRA && TEGRA_BPMP
> +	help
> +	  This adds CPU frequency driver support for Tegra194 SOCs.
> +
>  config ARM_TI_CPUFREQ
>  	bool "Texas Instruments CPUFreq support"
>  	depends on ARCH_OMAP2PLUS
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index 9a9f5cc..433d492 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_ARM_TANGO_CPUFREQ)		+= tango-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
>  obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
> +obj-$(CONFIG_ARM_TEGRA194_CPUFREQ)	+= tegra194-cpufreq.o
>  obj-$(CONFIG_ARM_TI_CPUFREQ)		+= ti-cpufreq.o
>  obj-$(CONFIG_ARM_VEXPRESS_SPC_CPUFREQ)	+= vexpress-spc-cpufreq.o
>  
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> new file mode 100644
> index 0000000..9df12f4
> --- /dev/null
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -0,0 +1,423 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved
> + */
> +
> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <asm/smp_plat.h>
> +
> +#include <soc/tegra/bpmp.h>
> +#include <soc/tegra/bpmp-abi.h>
> +
> +#define KHZ                     1000
> +#define REF_CLK_MHZ             408 /* 408 MHz */
> +#define US_DELAY                2000
> +#define US_DELAY_MIN            2
> +#define CPUFREQ_TBL_STEP_HZ     (50 * KHZ * KHZ)
> +#define MAX_CNT                 ~0U
> +
> +/* cpufreq transisition latency */
> +#define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanoseconds */
> +
> +enum cluster {
> +	CLUSTER0,
> +	CLUSTER1,
> +	CLUSTER2,
> +	CLUSTER3,
> +	MAX_CLUSTERS,
> +};
> +
> +struct tegra194_cpufreq_data {
> +	void __iomem *regs;
> +	size_t num_clusters;
> +	struct cpufreq_frequency_table **tables;
> +};
> +
> +static DEFINE_MUTEX(cpufreq_lock);
> +
> +struct tegra_cpu_ctr {
> +	u32 cpu;
> +	u32 delay;
> +	u32 coreclk_cnt, last_coreclk_cnt;
> +	u32 refclk_cnt, last_refclk_cnt;
> +};
> +
> +static struct workqueue_struct *read_counters_wq;
> +struct read_counters_work {
> +	struct work_struct work;
> +	struct tegra_cpu_ctr c;
> +};
> +
> +static enum cluster get_cpu_cluster(u8 cpu)
> +{
> +	return MPIDR_AFFINITY_LEVEL(cpu_logical_map(cpu), 1);
> +}
> +
> +/*
> + * Read per-core Read-only system register NVFREQ_FEEDBACK_EL1.
> + * The register provides frequency feedback information to
> + * determine the average actual frequency a core has run at over
> + * a period of time.
> + *	[31:0] PLLP counter: Counts at fixed frequency (408 MHz)
> + *	[63:32] Core clock counter: counts on every core clock cycle
> + *			where the core is architecturally clocking
> + */
> +static u64 read_freq_feedback(void)
> +{
> +	u64 val = 0;
> +
> +	asm volatile("mrs %0, s3_0_c15_c0_5" : "=r" (val) : );
> +
> +	return val;
> +}
> +
> +u16 map_freq_to_ndiv(struct mrq_cpu_ndiv_limits_response *nltbl, u32 freq)
> +{
> +	return DIV_ROUND_UP(freq * nltbl->pdiv * nltbl->mdiv,
> +			    nltbl->ref_clk_hz / KHZ);
> +}
> +
> +static inline u32 map_ndiv_to_freq(struct mrq_cpu_ndiv_limits_response
> +				   *nltbl, u16 ndiv)
> +{
> +	return nltbl->ref_clk_hz / KHZ * ndiv / (nltbl->pdiv * nltbl->mdiv);
> +}
> +
> +static void tegra_read_counters(struct work_struct *work)
> +{
> +	struct read_counters_work *read_counters_work;
> +	struct tegra_cpu_ctr *c;
> +	u64 val;
> +
> +	/*
> +	 * ref_clk_counter(32 bit counter) runs on constant clk,
> +	 * pll_p(408MHz).
> +	 * It will take = 2 ^ 32 / 408 MHz to overflow ref clk counter
> +	 *              = 10526880 usec = 10.527 sec to overflow
> +	 *
> +	 * Like wise core_clk_counter(32 bit counter) runs on core clock.
> +	 * It's synchronized to crab_clk (cpu_crab_clk) which runs at
> +	 * freq of cluster. Assuming max cluster clock ~2000MHz,
> +	 * It will take = 2 ^ 32 / 2000 MHz to overflow core clk counter
> +	 *              = ~2.147 sec to overflow
> +	 */
> +	read_counters_work = container_of(work, struct read_counters_work,
> +					  work);
> +	c = &read_counters_work->c;
> +
> +	val = read_freq_feedback();
> +	c->last_refclk_cnt = lower_32_bits(val);
> +	c->last_coreclk_cnt = upper_32_bits(val);
> +	udelay(c->delay);
> +	val = read_freq_feedback();
> +	c->refclk_cnt = lower_32_bits(val);
> +	c->coreclk_cnt = upper_32_bits(val);
> +}
> +
> +/*
> + * Return instantaneous cpu speed
> + * Instantaneous freq is calculated as -
> + * -Takes sample on every query of getting the freq.
> + *	- Read core and ref clock counters;
> + *	- Delay for X us
> + *	- Read above cycle counters again
> + *	- Calculates freq by subtracting current and previous counters
> + *	  divided by the delay time or eqv. of ref_clk_counter in delta time
> + *	- Return Kcycles/second, freq in KHz
> + *
> + *	delta time period = x sec
> + *			  = delta ref_clk_counter / (408 * 10^6) sec
> + *	freq in Hz = cycles/sec
> + *		   = (delta cycles / x sec
> + *		   = (delta cycles * 408 * 10^6) / delta ref_clk_counter
> + *	in KHz	   = (delta cycles * 408 * 10^3) / delta ref_clk_counter
> + *
> + * @cpu - logical cpu whose freq to be updated
> + * Returns freq in KHz on success, 0 if cpu is offline
> + */
> +static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
> +{
> +	struct read_counters_work read_counters_work;
> +	struct tegra_cpu_ctr c;
> +	u32 delta_refcnt;
> +	u32 delta_ccnt;
> +	u32 rate_mhz;
> +
> +	read_counters_work.c.cpu = cpu;
> +	read_counters_work.c.delay = delay;
> +	INIT_WORK_ONSTACK(&read_counters_work.work, tegra_read_counters);
> +	queue_work_on(cpu, read_counters_wq, &read_counters_work.work);
> +	flush_work(&read_counters_work.work);

What will happen if CPU is offline?
