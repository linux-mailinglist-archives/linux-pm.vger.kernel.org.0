Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915F519E71C
	for <lists+linux-pm@lfdr.de>; Sat,  4 Apr 2020 20:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDDSiy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Apr 2020 14:38:54 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17601 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgDDSiy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Apr 2020 14:38:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e88d3d80000>; Sat, 04 Apr 2020 11:37:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 04 Apr 2020 11:38:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 04 Apr 2020 11:38:52 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 4 Apr
 2020 18:38:51 +0000
Received: from [10.24.37.103] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 4 Apr 2020
 18:38:47 +0000
Subject: Re: [TEGRA194_CPUFREQ Patch 2/3] cpufreq: Add Tegra194 cpufreq driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        <mperttunen@nvidia.com>, <sumitg@nvidia.com>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <1575394348-17649-2-git-send-email-sumitg@nvidia.com>
 <20200326115023.xy3n5bl7uetuw7mx@vireshk-i7>
From:   sumitg <sumitg@nvidia.com>
Message-ID: <d233b26b-6b50-7d41-9f33-a5dc151e0e7d@nvidia.com>
Date:   Sun, 5 Apr 2020 00:08:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200326115023.xy3n5bl7uetuw7mx@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586025432; bh=5hdYw6ObfGFLG9jd7U4HnmWEClP8GiKvWCoh8X9OSgI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JgMYdbwUbXedZkmtlgwLgotdD5XBTnbRfd8+VzIPxVAItPIWtZdKzjXWh8HDCiK5P
         E/Byrm5R8gc3drmATdYYHROEby12KKeMW26FfoHdvK0X9CpNxA0AFH8KVgGG5T+I4B
         n2wJ4KMU/ST+K6FKmSM/da5gCPk4ckX5MIZQ1BGRC/DoLnlEDdj8LIMZYdwBJpfZpf
         d7JeYfspqxAVJQZX0fSvtwTWJyyNoEM2Cc6HQMVYY/x7c6SMNblPXJDX06Ntpk1CH0
         Ta0w1cLh7MXX1SYYEQGydNYuaHibCJhm5kbZ3b59CfvhTpAiDQ9gAK0MiNa72o4kOb
         3EM1a1HCBZqsg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 26/03/20 5:20 PM, Viresh Kumar wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 03-12-19, 23:02, Sumit Gupta wrote:
>> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
>> new file mode 100644
>> index 0000000..9df12f4
>> --- /dev/null
>> +++ b/drivers/cpufreq/tegra194-cpufreq.c
>> @@ -0,0 +1,423 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved
>> + */
>> +
>> +#include <linux/cpu.h>
>> +#include <linux/cpufreq.h>
>> +#include <linux/delay.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +#include <asm/smp_plat.h>
>> +
>> +#include <soc/tegra/bpmp.h>
>> +#include <soc/tegra/bpmp-abi.h>
>> +
>> +#define KHZ                     1000
>> +#define REF_CLK_MHZ             408 /* 408 MHz */
>> +#define US_DELAY                2000
>> +#define US_DELAY_MIN            2
>> +#define CPUFREQ_TBL_STEP_HZ     (50 * KHZ * KHZ)
>> +#define MAX_CNT                 ~0U
>> +
>> +/* cpufreq transisition latency */
>> +#define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanoseconds */
>> +
>> +enum cluster {
>> +     CLUSTER0,
>> +     CLUSTER1,
>> +     CLUSTER2,
>> +     CLUSTER3,
> 
> All these have same CPUs ? Or big little kind of stuff ? How come they
> have different frequency tables ?
> 
T194 SOC has homogeneous architecture where each cluster has two 
symmetric Carmel cores and and not big little. LUT's are per cluster and 
all LUT's have same values currently. Future SOC's may have different 
LUT values per cluster.

>> +     MAX_CLUSTERS,
>> +};
>> +
>> +struct tegra194_cpufreq_data {
>> +     void __iomem *regs;
>> +     size_t num_clusters;
>> +     struct cpufreq_frequency_table **tables;
>> +};
>> +
>> +static DEFINE_MUTEX(cpufreq_lock);
>> +
>> +struct tegra_cpu_ctr {
>> +     u32 cpu;
>> +     u32 delay;
>> +     u32 coreclk_cnt, last_coreclk_cnt;
>> +     u32 refclk_cnt, last_refclk_cnt;
>> +};
>> +
>> +static struct workqueue_struct *read_counters_wq;
>> +struct read_counters_work {
>> +     struct work_struct work;
>> +     struct tegra_cpu_ctr c;
>> +};
>> +
>> +static enum cluster get_cpu_cluster(u8 cpu)
>> +{
>> +     return MPIDR_AFFINITY_LEVEL(cpu_logical_map(cpu), 1);
>> +}
>> +
>> +/*
>> + * Read per-core Read-only system register NVFREQ_FEEDBACK_EL1.
>> + * The register provides frequency feedback information to
>> + * determine the average actual frequency a core has run at over
>> + * a period of time.
>> + *   [31:0] PLLP counter: Counts at fixed frequency (408 MHz)
>> + *   [63:32] Core clock counter: counts on every core clock cycle
>> + *                   where the core is architecturally clocking
>> + */
>> +static u64 read_freq_feedback(void)
>> +{
>> +     u64 val = 0;
>> +
>> +     asm volatile("mrs %0, s3_0_c15_c0_5" : "=r" (val) : );
>> +
>> +     return val;
>> +}
>> +
>> +u16 map_freq_to_ndiv(struct mrq_cpu_ndiv_limits_response *nltbl, u32 freq)
>> +{
>> +     return DIV_ROUND_UP(freq * nltbl->pdiv * nltbl->mdiv,
>> +                         nltbl->ref_clk_hz / KHZ);
>> +}
>> +
>> +static inline u32 map_ndiv_to_freq(struct mrq_cpu_ndiv_limits_response
>> +                                *nltbl, u16 ndiv)
>> +{
>> +     return nltbl->ref_clk_hz / KHZ * ndiv / (nltbl->pdiv * nltbl->mdiv);
>> +}
>> +
>> +static void tegra_read_counters(struct work_struct *work)
>> +{
>> +     struct read_counters_work *read_counters_work;
>> +     struct tegra_cpu_ctr *c;
>> +     u64 val;
>> +
>> +     /*
>> +      * ref_clk_counter(32 bit counter) runs on constant clk,
>> +      * pll_p(408MHz).
>> +      * It will take = 2 ^ 32 / 408 MHz to overflow ref clk counter
>> +      *              = 10526880 usec = 10.527 sec to overflow
>> +      *
>> +      * Like wise core_clk_counter(32 bit counter) runs on core clock.
>> +      * It's synchronized to crab_clk (cpu_crab_clk) which runs at
>> +      * freq of cluster. Assuming max cluster clock ~2000MHz,
>> +      * It will take = 2 ^ 32 / 2000 MHz to overflow core clk counter
>> +      *              = ~2.147 sec to overflow
>> +      */
>> +     read_counters_work = container_of(work, struct read_counters_work,
>> +                                       work);
>> +     c = &read_counters_work->c;
>> +
>> +     val = read_freq_feedback();
>> +     c->last_refclk_cnt = lower_32_bits(val);
>> +     c->last_coreclk_cnt = upper_32_bits(val);
>> +     udelay(c->delay);
>> +     val = read_freq_feedback();
>> +     c->refclk_cnt = lower_32_bits(val);
>> +     c->coreclk_cnt = upper_32_bits(val);
>> +}
>> +
>> +/*
>> + * Return instantaneous cpu speed
>> + * Instantaneous freq is calculated as -
>> + * -Takes sample on every query of getting the freq.
>> + *   - Read core and ref clock counters;
>> + *   - Delay for X us
>> + *   - Read above cycle counters again
>> + *   - Calculates freq by subtracting current and previous counters
>> + *     divided by the delay time or eqv. of ref_clk_counter in delta time
>> + *   - Return Kcycles/second, freq in KHz
>> + *
>> + *   delta time period = x sec
>> + *                     = delta ref_clk_counter / (408 * 10^6) sec
>> + *   freq in Hz = cycles/sec
>> + *              = (delta cycles / x sec
>> + *              = (delta cycles * 408 * 10^6) / delta ref_clk_counter
>> + *   in KHz     = (delta cycles * 408 * 10^3) / delta ref_clk_counter
>> + *
>> + * @cpu - logical cpu whose freq to be updated
>> + * Returns freq in KHz on success, 0 if cpu is offline
>> + */
>> +static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
>> +{
>> +     struct read_counters_work read_counters_work;
>> +     struct tegra_cpu_ctr c;
>> +     u32 delta_refcnt;
>> +     u32 delta_ccnt;
>> +     u32 rate_mhz;
>> +
>> +     read_counters_work.c.cpu = cpu;
>> +     read_counters_work.c.delay = delay;
>> +     INIT_WORK_ONSTACK(&read_counters_work.work, tegra_read_counters);
>> +     queue_work_on(cpu, read_counters_wq, &read_counters_work.work);
>> +     flush_work(&read_counters_work.work);
> 
> Why can't this be done in current context ?
> 
We used work queue instead of smp_call_function_single() to have long delay.

>> +     c = read_counters_work.c;
>> +
>> +     if (c.coreclk_cnt < c.last_coreclk_cnt)
>> +             delta_ccnt = c.coreclk_cnt + (MAX_CNT - c.last_coreclk_cnt);
>> +     else
>> +             delta_ccnt = c.coreclk_cnt - c.last_coreclk_cnt;
>> +     if (!delta_ccnt)
>> +             return 0;
>> +
>> +     /* ref clock is 32 bits */
>> +     if (c.refclk_cnt < c.last_refclk_cnt)
>> +             delta_refcnt = c.refclk_cnt + (MAX_CNT - c.last_refclk_cnt);
>> +     else
>> +             delta_refcnt = c.refclk_cnt - c.last_refclk_cnt;
>> +     if (!delta_refcnt) {
>> +             pr_debug("cpufreq: %d is idle, delta_refcnt: 0\n", cpu);
>> +             return 0;
>> +     }
>> +     rate_mhz = ((unsigned long)(delta_ccnt * REF_CLK_MHZ)) / delta_refcnt;
>> +
>> +     return (rate_mhz * KHZ); /* in KHz */
>> +}
>> +
>> +static unsigned int tegra194_get_speed(u32 cpu)
>> +{
>> +     return tegra194_get_speed_common(cpu, US_DELAY);
>> +}
>> +
>> +static unsigned int tegra194_fast_get_speed(u32 cpu)
>> +{
>> +     return tegra194_get_speed_common(cpu, US_DELAY_MIN);
> 
> Why is this required specially here ? Why can't you work with normal
> delay ?
> 
Less delay value used during init to reduce cpu boot time.

>> +}
>> +
>> +static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>> +{
>> +     struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
>> +     int cluster = get_cpu_cluster(policy->cpu);
>> +
>> +     if (cluster >= data->num_clusters)
>> +             return -EINVAL;
>> +
>> +     policy->cur = tegra194_fast_get_speed(policy->cpu); /* boot freq */
>> +
>> +     /* set same policy for all cpus */
>> +     cpumask_copy(policy->cpus, cpu_possible_mask);
> 
> You are copying cpu_possible_mask mask here, and so this routine will
> get called only once.
> 
> I still don't understand the logic behind clusters and frequency
> tables.
> 
Currently, we use same policy for all CPU's to maximize throughput. Will 
add separate patch later to set policy as per cluster. But we are not 
using that in T194 due to perf reasons.

>> +
>> +     policy->freq_table = data->tables[cluster];
>> +     policy->cpuinfo.transition_latency = TEGRA_CPUFREQ_TRANSITION_LATENCY;
>> +
>> +     return 0;
>> +}
>> +
>> +static void set_cpu_ndiv(void *data)
>> +{
>> +     struct cpufreq_frequency_table *tbl = data;
>> +     u64 ndiv_val = (u64)tbl->driver_data;
>> +
>> +     asm volatile("msr s3_0_c15_c0_4, %0" : : "r" (ndiv_val));
>> +}
>> +
>> +static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
>> +                                    unsigned int index)
>> +{
>> +     struct cpufreq_frequency_table *tbl = policy->freq_table + index;
>> +     static struct cpufreq_freqs freqs;
>> +
>> +     mutex_lock(&cpufreq_lock);
> 
> No need of lock here.
>
Done

>> +     freqs.old = policy->cur;
>> +     freqs.new = tbl->frequency;
>> +
>> +     cpufreq_freq_transition_begin(policy, &freqs);
>> +     on_each_cpu_mask(policy->cpus, set_cpu_ndiv, tbl, true);
> 
> When CPUs share clock line, why is this required for every CPU ?
>Per core NVFREQ_REQ system register is written to make frequency 
requests for the core. Cluster h/w then forwards the max(core0, core1) 
request to cluster NAFLL.

>> +     cpufreq_freq_transition_end(policy, &freqs, 0);
>> +
>> +     mutex_unlock(&cpufreq_lock);
>> +
>> +     return 0;
>> +}
>> +
>> +static struct cpufreq_driver tegra194_cpufreq_driver = {
>> +     .name = "tegra194",
>> +     .flags = CPUFREQ_STICKY | CPUFREQ_CONST_LOOPS |
>> +             CPUFREQ_NEED_INITIAL_FREQ_CHECK | CPUFREQ_ASYNC_NOTIFICATION,
> 
> Why Async here ? I am really confused if I am not able to understand
> the driver or you :)
> 
Have removed the flag as it was not required. Thank you for pointing.

>> +     .verify = cpufreq_generic_frequency_table_verify,
>> +     .target_index = tegra194_cpufreq_set_target,
>> +     .get = tegra194_get_speed,
>> +     .init = tegra194_cpufreq_init,
>> +     .attr = cpufreq_generic_attr,
>> +};
>> +
>> +static void tegra194_cpufreq_free_resources(void)
>> +{
>> +     flush_workqueue(read_counters_wq);
>> +     destroy_workqueue(read_counters_wq);
>> +}
>> +
>> +static struct cpufreq_frequency_table *init_freq_table
> 
> Don't break line here, rather break after above *.
> 
Done

>> +             (struct platform_device *pdev, struct tegra_bpmp *bpmp,
>> +              unsigned int cluster_id)
>> +{
>> +     struct cpufreq_frequency_table *opp_table;
> 
> Please name it freq_table :)
> 
Done

>> +     struct mrq_cpu_ndiv_limits_response resp;
>> +     unsigned int num_freqs, ndiv, delta_ndiv;
>> +     struct mrq_cpu_ndiv_limits_request req;
>> +     struct tegra_bpmp_message msg;
>> +     u16 freq_table_step_size;
>> +     int err, index;
>> +
>> +     memset(&req, 0, sizeof(req));
>> +     req.cluster_id = cluster_id;
>> +
>> +     memset(&msg, 0, sizeof(msg));
>> +     msg.mrq = MRQ_CPU_NDIV_LIMITS;
>> +     msg.tx.data = &req;
>> +     msg.tx.size = sizeof(req);
>> +     msg.rx.data = &resp;
>> +     msg.rx.size = sizeof(resp);
>> +
>> +     err = tegra_bpmp_transfer(bpmp, &msg);
>> +     if (err)
>> +             return ERR_PTR(err);
>> +
>> +     /*
>> +      * Make sure frequency table step is a multiple of mdiv to match
>> +      * vhint table granularity.
>> +      */
>> +     freq_table_step_size = resp.mdiv *
>> +                     DIV_ROUND_UP(CPUFREQ_TBL_STEP_HZ, resp.ref_clk_hz);
>> +
>> +     dev_dbg(&pdev->dev, "cluster %d: frequency table step size: %d\n",
>> +             cluster_id, freq_table_step_size);
>> +
>> +     delta_ndiv = resp.ndiv_max - resp.ndiv_min;
>> +
>> +     if (unlikely(delta_ndiv == 0))
>> +             num_freqs = 1;
>> +     else
>> +             /* We store both ndiv_min and ndiv_max hence the +1 */
>> +             num_freqs = delta_ndiv / freq_table_step_size + 1;
>> +
>> +     num_freqs += (delta_ndiv % freq_table_step_size) ? 1 : 0;
>> +
>> +     opp_table = devm_kcalloc(&pdev->dev, num_freqs + 1, sizeof(*opp_table),
>> +                              GFP_KERNEL);
>> +     if (!opp_table)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     for (index = 0, ndiv = resp.ndiv_min;
>> +                     ndiv < resp.ndiv_max;
>> +                     index++, ndiv += freq_table_step_size) {
>> +             opp_table[index].driver_data = ndiv;
>> +             opp_table[index].frequency = map_ndiv_to_freq(&resp, ndiv);
>> +     }
>> +
>> +     opp_table[index].driver_data = resp.ndiv_max;
>> +     opp_table[index++].frequency = map_ndiv_to_freq(&resp, resp.ndiv_max);
>> +     opp_table[index].frequency = CPUFREQ_TABLE_END;
>> +
>> +     return opp_table;
>> +}
>> +
>> +static int tegra194_cpufreq_probe(struct platform_device *pdev)
>> +{
>> +     struct tegra194_cpufreq_data *data;
>> +     struct tegra_bpmp *bpmp;
>> +     int err, i;
>> +
>> +     data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>> +     if (!data)
>> +             return -ENOMEM;
>> +
>> +     data->num_clusters = MAX_CLUSTERS;
>> +     data->tables = devm_kcalloc(&pdev->dev, data->num_clusters,
>> +                                 sizeof(*data->tables), GFP_KERNEL);
>> +     if (!data->tables)
>> +             return -ENOMEM;
>> +
>> +     platform_set_drvdata(pdev, data);
>> +
>> +     read_counters_wq = alloc_workqueue("read_counters_wq", __WQ_LEGACY, 1);
>> +     if (!read_counters_wq) {
>> +             dev_err(&pdev->dev, "fail to create_workqueue\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     bpmp = of_tegra_bpmp_get();
>> +     if (IS_ERR(bpmp)) {
>> +             err = PTR_ERR(bpmp);
>> +             goto err_free_res;
>> +     }
>> +
>> +     for (i = 0; i < data->num_clusters; i++) {
>> +             data->tables[i] = init_freq_table(pdev, bpmp, i);
>> +             if (IS_ERR(data->tables[i])) {
>> +                     err = PTR_ERR(data->tables[i]);
>> +                     goto put_bpmp;
>> +             }
>> +     }
>> +
>> +     tegra_bpmp_put(bpmp);
>> +
>> +     tegra194_cpufreq_driver.driver_data = data;
>> +
>> +     err = cpufreq_register_driver(&tegra194_cpufreq_driver);
>> +     if (err)
>> +             goto err_free_res;
>> +
>> +     return err;
>> +
>> +put_bpmp:
>> +     tegra_bpmp_put(bpmp);
>> +err_free_res:
>> +     tegra194_cpufreq_free_resources();
>> +     return err;
>> +}
>> +
>> +static int tegra194_cpufreq_remove(struct platform_device *pdev)
>> +{
>> +     cpufreq_unregister_driver(&tegra194_cpufreq_driver);
>> +     tegra194_cpufreq_free_resources();
>> +
>> +     return 0;
>> +}
>> +
>> +static struct platform_driver tegra194_cpufreq_platform_driver = {
>> +     .driver = {
>> +             .name = "tegra194-cpufreq",
>> +     },
>> +     .probe = tegra194_cpufreq_probe,
>> +     .remove = tegra194_cpufreq_remove,
>> +};
>> +
>> +static int __init tegra_cpufreq_init(void)
> 
> I seem to be forgetting this, but should we use __init with modules or
> not ?
> 
Yes

Thankyou for the review. I will send v2 with suggested changes.

> --
> viresh
> 

