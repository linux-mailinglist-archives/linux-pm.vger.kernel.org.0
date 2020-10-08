Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E59A28749A
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 14:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgJHMzZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 08:55:25 -0400
Received: from foss.arm.com ([217.140.110.172]:56082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729722AbgJHMzX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Oct 2020 08:55:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD6BD1063;
        Thu,  8 Oct 2020 05:55:22 -0700 (PDT)
Received: from [10.57.48.204] (unknown [10.57.48.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB7043F71F;
        Thu,  8 Oct 2020 05:55:20 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] cpufreq: mediatek-hw: Register EM power table
To:     Hector Yuan <hector.yuan@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
References: <1602159204-13756-1-git-send-email-hector.yuan@mediatek.com>
 <1602159204-13756-2-git-send-email-hector.yuan@mediatek.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <7e58516f-a6bf-eac4-9dfb-9a4d7efa7498@arm.com>
Date:   Thu, 8 Oct 2020 13:55:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1602159204-13756-2-git-send-email-hector.yuan@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Hector,

On 10/8/20 1:13 PM, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Register CPU power table to energy model framework
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>   drivers/cpufreq/mediatek-cpufreq-hw.c |   50 +++++++++++++++++++++++++--------
>   1 file changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index 8fa12e5..3808ea0 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -5,6 +5,7 @@
>   
>   #include <linux/bitfield.h>
>   #include <linux/cpufreq.h>
> +#include <linux/energy_model.h>
>   #include <linux/init.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> @@ -17,9 +18,10 @@
>   #define LUT_ROW_SIZE			0x4
>   
>   enum {
> -	REG_LUT_TABLE,
> -	REG_ENABLE,
> -	REG_PERF_STATE,
> +	REG_FREQ_LUT_TABLE,
> +	REG_FREQ_ENABLE,
> +	REG_FREQ_PERF_STATE,
> +	REG_EM_POWER_TBL,
>   
>   	REG_ARRAY_SIZE,
>   };
> @@ -27,23 +29,44 @@ enum {
>   struct cpufreq_mtk {
>   	struct cpufreq_frequency_table *table;
>   	void __iomem *reg_bases[REG_ARRAY_SIZE];
> +	int nr_opp;
>   	cpumask_t related_cpus;
>   };
>   
>   static const u16 cpufreq_mtk_offsets[REG_ARRAY_SIZE] = {
> -	[REG_LUT_TABLE]		= 0x0,
> -	[REG_ENABLE]		= 0x84,
> -	[REG_PERF_STATE]	= 0x88,
> +	[REG_FREQ_LUT_TABLE]	= 0x0,
> +	[REG_FREQ_ENABLE]	= 0x84,
> +	[REG_FREQ_PERF_STATE]	= 0x88,
> +	[REG_EM_POWER_TBL]	= 0x3D0,
>   };
>   
>   static struct cpufreq_mtk *mtk_freq_domain_map[NR_CPUS];
>   
> +static int mtk_cpufreq_get_cpu_power(unsigned long *mW,
> +				     unsigned long *KHz, int cpu)
> +{
> +	struct cpufreq_mtk *c = mtk_freq_domain_map[cpu];
> +	int i;
> +
> +	for (i = 0; i < c->nr_opp; i++) {
> +		if (c->table[i].frequency < *KHz)
> +			break;
> +	}
> +	i--;
> +
> +	*KHz = c->table[i].frequency;
> +	*mW = readl_relaxed(c->reg_bases[REG_EM_POWER_TBL] +
> +			    i * LUT_ROW_SIZE) / 1000;
> +
> +	return 0;
> +}
> +
>   static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>   				       unsigned int index)
>   {
>   	struct cpufreq_mtk *c = policy->driver_data;
>   
> -	writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
> +	writel_relaxed(index, c->reg_bases[REG_FREQ_PERF_STATE]);
>   
>   	return 0;
>   }
> @@ -55,7 +78,7 @@ static unsigned int mtk_cpufreq_hw_get(unsigned int cpu)
>   
>   	c = mtk_freq_domain_map[cpu];
>   
> -	index = readl_relaxed(c->reg_bases[REG_PERF_STATE]);
> +	index = readl_relaxed(c->reg_bases[REG_FREQ_PERF_STATE]);
>   	index = min(index, LUT_MAX_ENTRIES - 1);
>   
>   	return c->table[index].frequency;
> @@ -64,6 +87,7 @@ static unsigned int mtk_cpufreq_hw_get(unsigned int cpu)
>   static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   {
>   	struct cpufreq_mtk *c;
> +	struct em_data_callback em_cb = EM_DATA_CB(mtk_cpufreq_get_cpu_power);
>   
>   	c = mtk_freq_domain_map[policy->cpu];
>   	if (!c) {
> @@ -77,7 +101,8 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>   	policy->driver_data = c;
>   
>   	/* HW should be in enabled state to proceed now */
> -	writel_relaxed(0x1, c->reg_bases[REG_ENABLE]);
> +	writel_relaxed(0x1, c->reg_bases[REG_FREQ_ENABLE]);
> +	em_register_perf_domain(policy->cpus, c->nr_opp, &em_cb);


The function name has changed recently (v5.9-rc1) to:
em_dev_register_perf_domain()

Please check your base kernel tree and update.

Regards,
Lukasz

