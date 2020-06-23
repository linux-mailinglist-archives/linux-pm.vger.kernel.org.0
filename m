Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46B1204923
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 07:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgFWFTb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 01:19:31 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:17588 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbgFWFTa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 01:19:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef190b50000>; Mon, 22 Jun 2020 22:18:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 22:19:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 22 Jun 2020 22:19:30 -0700
Received: from [10.24.37.103] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 05:19:21 +0000
Subject: Re: [TEGRA194_CPUFREQ Patch v3 3/4] cpufreq: Add Tegra194 cpufreq
 driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rjw@rjwysocki.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bbasu@nvidia.com>,
        <mperttunen@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>
References: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
 <1592775274-27513-4-git-send-email-sumitg@nvidia.com>
 <20200622072052.uryxo4hri6gzrkku@vireshk-i7>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <ed6956a3-3f77-2943-6387-5affc25b59d2@nvidia.com>
Date:   Tue, 23 Jun 2020 10:49:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200622072052.uryxo4hri6gzrkku@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592889525; bh=sEQVKKrqd5FMPr3hfJ8vm8kY/vg10WEobCiUip4lwic=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=KpQV2mdYmRpvLg2foGEBLfVh+ae3LYgLH9O1y3SVjdRsSF42AVgJ6iJ4mc7UWIkb0
         YguB/5fcQDhFQe/4tze3mZP6L3Bvt+c0fyYiBiorvTXLNHM6j4FIIBIevp8PSJO6Vt
         7DaodlNWwW4INZDI22t/YOQw0MQ6n9hAEAxGGA2+xt4ChZT/4uqLPP+Q/BL9CwYluF
         f0xAcIoEXswwEgRmCXe7lOTr0i39IazIY+sio2UdOvlgfdV5bnJwS86WSpx0oQxgnt
         M58mY04ov63h0rZC/UX5OfBHD4QD/z8cRKkPQojeHG6/mAskT6hxFBQC3KO3YeKjtF
         +7RiMHUaiijBg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

Thank you for the review. please find my reply inline.


>> +++ b/drivers/cpufreq/tegra194-cpufreq.c
>> @@ -0,0 +1,403 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved
> 
>                      2020
> 
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
>> +#define US_DELAY                500
>> +#define US_DELAY_MIN            2
>> +#define CPUFREQ_TBL_STEP_HZ     (50 * KHZ * KHZ)
>> +#define MAX_CNT                 ~0U
>> +
>> +/* cpufreq transisition latency */
>> +#define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanoseconds */
>> +
>> +#define LOOP_FOR_EACH_CPU_OF_CLUSTER(cl) for (cpu = (cl * 2); \
>> +                                     cpu < ((cl + 1) * 2); cpu++)
> 
> Both latency and this loop are used only once in the code, maybe just open code
> it. Also you should have passed cpu as a parameter to the macro, even if it
> works fine without it, for better readability.
> 
Ok, i will open code the loop in next version. For latency value, i feel 
named macro makes readability better. So, prefer keeping it.

>> +
>> +u16 map_freq_to_ndiv(struct mrq_cpu_ndiv_limits_response *nltbl, u32 freq)
> 
> Unused routine
> 
Sure, will remove it.

>> +{
>> +     return DIV_ROUND_UP(freq * nltbl->pdiv * nltbl->mdiv,
>> +                         nltbl->ref_clk_hz / KHZ);
>> +}
> 
>> +static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>> +{
>> +     struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
>> +     int cl = get_cpu_cluster(policy->cpu);
>> +     u32 cpu;
>> +
>> +     if (cl >= data->num_clusters)
>> +             return -EINVAL;
>> +
>> +     policy->cur = tegra194_fast_get_speed(policy->cpu); /* boot freq */
>> +
>> +     /* set same policy for all cpus in a cluster */
>> +     LOOP_FOR_EACH_CPU_OF_CLUSTER(cl)
>> +             cpumask_set_cpu(cpu, policy->cpus);
>> +
>> +     policy->freq_table = data->tables[cl];
>> +     policy->cpuinfo.transition_latency = TEGRA_CPUFREQ_TRANSITION_LATENCY;
>> +
>> +     return 0;
>> +}
> 
>> +static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
>> +                                    unsigned int index)
>> +{
>> +     struct cpufreq_frequency_table *tbl = policy->freq_table + index;
>> +
>> +     on_each_cpu_mask(policy->cpus, set_cpu_ndiv, tbl, true);
> 
> I am still a bit confused. While setting the frequency you are calling this
> routine for each CPU of the policy (cluster). Does that mean that CPUs within a
> cluster can actually run at different frequencies at any given point of time ?
> 
> If cpufreq terms, a cpufreq policy represents a group of CPUs that change
> frequency together, i.e. they share the clk line. If all CPUs in your system can
> do DVFS separately, then you must have policy per CPU, instead of cluster.
> 
T194 supports four CPU clusters, each with two cores. Each CPU cluster 
is capable of running at a specific frequency sourced by respective 
NAFLL to provide cluster specific clocks. Individual cores within a 
cluster write freq in per core register. Cluster h/w forwards the 
max(core0, core1) request to per cluster NAFLL.

>> +static void tegra194_cpufreq_free_resources(void)
>> +{
>> +     flush_workqueue(read_counters_wq);
> 
> Why is this required exactly? I see that you add the work request and
> immediately flush it, then why would you need to do this separately ?
> 
Ya, will remove flush_workqueue().

>> +     destroy_workqueue(read_counters_wq);
>> +}
>> +
>> +static struct cpufreq_frequency_table *
>> +init_freq_table(struct platform_device *pdev, struct tegra_bpmp *bpmp,
>> +             unsigned int cluster_id)
>> +{
>> +     struct cpufreq_frequency_table *freq_table;
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
> 
> So the firmware can actually return different frequency tables for the clusters,
> right ? Else you could have received the table only once and used it for all the
> CPUs.
> 
Yes, frequency tables are returned per cluster by BPMP firmware. In T194 
SOC, currently same table values are used for all clusters. This might 
change in future.

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
>> +     freq_table = devm_kcalloc(&pdev->dev, num_freqs + 1,
>> +                               sizeof(*freq_table), GFP_KERNEL);
>> +     if (!freq_table)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     for (index = 0, ndiv = resp.ndiv_min;
>> +                     ndiv < resp.ndiv_max;
>> +                     index++, ndiv += freq_table_step_size) {
>> +             freq_table[index].driver_data = ndiv;
>> +             freq_table[index].frequency = map_ndiv_to_freq(&resp, ndiv);
>> +     }
>> +
>> +     freq_table[index].driver_data = resp.ndiv_max;
>> +     freq_table[index++].frequency = map_ndiv_to_freq(&resp, resp.ndiv_max);
>> +     freq_table[index].frequency = CPUFREQ_TABLE_END;
>> +
>> +     return freq_table;
>> +}
> 
> --
> viresh
> 
