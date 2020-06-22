Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A741B203089
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jun 2020 09:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbgFVHU5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jun 2020 03:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731339AbgFVHU4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2020 03:20:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCC6C061794
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 00:20:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p3so5080808pgh.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2020 00:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TKu4b/neMK0AHW1Fq9DdzM2DE1aRPxbJSRBuKY9XmU0=;
        b=dOabQXPqHS/z/a9D5rdE5KrM3vn8itgNDR0a3+kEkRWP3H2bx2ES8qpaN4zEhx+cR3
         vEX23sObt6hSims2SkDI/mvhwaM+MbhQTHPTgGq+024E8nae97F2AepZZhS3Qe5kypxE
         DDjmY8Tr7n24Dkh3lU89LvP8G8xF57Hv7FnTpGCzVjMBo5IgBkWBdw8yB+eUP3qPDZC7
         r3AflGoV/k/N+kFjiA4YIdpMVNg8DpeeIu1PZbGclRJgZ/kM4oV/F0pp89IA+OCP2m/C
         UDSzQulhXOamap2+671hN87wU7wfct91jvLWvsJ4o0C9qAAgGC7wsSTMmayjp6iLx0vF
         vzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TKu4b/neMK0AHW1Fq9DdzM2DE1aRPxbJSRBuKY9XmU0=;
        b=eJanDT58Uh2uzvqYNmoP5hCc4imIchYOvbByfnqJNFa4lk2FS4cL+42vxwMiUTaOeZ
         VrgUTJnvQLhvG8ZZ14MQRJ1KVHGSfkzH0NhWVGOfekC0aFXr7atuncFWaRzIHTluT/kn
         QxCfFSWM+o7xsAfeuIGohE7q3qoEJbSdL9fPqF+C6BiFT3V24FIatJ7vZ/U3eTT+rqr7
         s0iqlZKBfCMfBQM4IEpzgnxnoyNpJPQEVZiZITl5Q49iDOhiMkwgYEZvCUZWDI96g4br
         1n3cq/1uPDAha4z7G95mlnwFF3WKoi5gzPzV2n7Ve2GmqwN/WlE60AC0mEXPawWe+SWN
         sRdA==
X-Gm-Message-State: AOAM530+YegETrIuqBCMqck1aZSIO79aBHb7MbJWevjyfS6E8E9fo60k
        wy5BWfBVz7DfOYHNclI22SuMLA==
X-Google-Smtp-Source: ABdhPJyYR8Nknc0FZ9ccI1tVx2q5D4kHN+UZFFBUA1ZWvJytIH+NFRNcKQk49YOzhWQilC3NG7MZ4Q==
X-Received: by 2002:aa7:96e9:: with SMTP id i9mr19604759pfq.232.1592810455513;
        Mon, 22 Jun 2020 00:20:55 -0700 (PDT)
Received: from localhost ([122.172.111.76])
        by smtp.gmail.com with ESMTPSA id 26sm5161063pfp.35.2020.06.22.00.20.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 00:20:54 -0700 (PDT)
Date:   Mon, 22 Jun 2020 12:50:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch v3 3/4] cpufreq: Add Tegra194 cpufreq
 driver
Message-ID: <20200622072052.uryxo4hri6gzrkku@vireshk-i7>
References: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
 <1592775274-27513-4-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592775274-27513-4-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-06-20, 03:04, Sumit Gupta wrote:
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> new file mode 100644
> index 0000000..8de8000
> --- /dev/null
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -0,0 +1,403 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved

                    2020

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
> +#define US_DELAY                500
> +#define US_DELAY_MIN            2
> +#define CPUFREQ_TBL_STEP_HZ     (50 * KHZ * KHZ)
> +#define MAX_CNT                 ~0U
> +
> +/* cpufreq transisition latency */
> +#define TEGRA_CPUFREQ_TRANSITION_LATENCY (300 * 1000) /* unit in nanoseconds */
> +
> +#define LOOP_FOR_EACH_CPU_OF_CLUSTER(cl) for (cpu = (cl * 2); \
> +					cpu < ((cl + 1) * 2); cpu++)

Both latency and this loop are used only once in the code, maybe just open code
it. Also you should have passed cpu as a parameter to the macro, even if it
works fine without it, for better readability.

> +
> +u16 map_freq_to_ndiv(struct mrq_cpu_ndiv_limits_response *nltbl, u32 freq)

Unused routine

> +{
> +	return DIV_ROUND_UP(freq * nltbl->pdiv * nltbl->mdiv,
> +			    nltbl->ref_clk_hz / KHZ);
> +}

> +static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
> +	int cl = get_cpu_cluster(policy->cpu);
> +	u32 cpu;
> +
> +	if (cl >= data->num_clusters)
> +		return -EINVAL;
> +
> +	policy->cur = tegra194_fast_get_speed(policy->cpu); /* boot freq */
> +
> +	/* set same policy for all cpus in a cluster */
> +	LOOP_FOR_EACH_CPU_OF_CLUSTER(cl)
> +		cpumask_set_cpu(cpu, policy->cpus);
> +
> +	policy->freq_table = data->tables[cl];
> +	policy->cpuinfo.transition_latency = TEGRA_CPUFREQ_TRANSITION_LATENCY;
> +
> +	return 0;
> +}

> +static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
> +				       unsigned int index)
> +{
> +	struct cpufreq_frequency_table *tbl = policy->freq_table + index;
> +
> +	on_each_cpu_mask(policy->cpus, set_cpu_ndiv, tbl, true);

I am still a bit confused. While setting the frequency you are calling this
routine for each CPU of the policy (cluster). Does that mean that CPUs within a
cluster can actually run at different frequencies at any given point of time ?

If cpufreq terms, a cpufreq policy represents a group of CPUs that change
frequency together, i.e. they share the clk line. If all CPUs in your system can
do DVFS separately, then you must have policy per CPU, instead of cluster.

> +static void tegra194_cpufreq_free_resources(void)
> +{
> +	flush_workqueue(read_counters_wq);

Why is this required exactly? I see that you add the work request and
immediately flush it, then why would you need to do this separately ?

> +	destroy_workqueue(read_counters_wq);
> +}
> +
> +static struct cpufreq_frequency_table *
> +init_freq_table(struct platform_device *pdev, struct tegra_bpmp *bpmp,
> +		unsigned int cluster_id)
> +{
> +	struct cpufreq_frequency_table *freq_table;
> +	struct mrq_cpu_ndiv_limits_response resp;
> +	unsigned int num_freqs, ndiv, delta_ndiv;
> +	struct mrq_cpu_ndiv_limits_request req;
> +	struct tegra_bpmp_message msg;
> +	u16 freq_table_step_size;
> +	int err, index;
> +
> +	memset(&req, 0, sizeof(req));
> +	req.cluster_id = cluster_id;
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.mrq = MRQ_CPU_NDIV_LIMITS;
> +	msg.tx.data = &req;
> +	msg.tx.size = sizeof(req);
> +	msg.rx.data = &resp;
> +	msg.rx.size = sizeof(resp);
> +
> +	err = tegra_bpmp_transfer(bpmp, &msg);

So the firmware can actually return different frequency tables for the clusters,
right ? Else you could have received the table only once and used it for all the
CPUs.

> +	if (err)
> +		return ERR_PTR(err);
> +
> +	/*
> +	 * Make sure frequency table step is a multiple of mdiv to match
> +	 * vhint table granularity.
> +	 */
> +	freq_table_step_size = resp.mdiv *
> +			DIV_ROUND_UP(CPUFREQ_TBL_STEP_HZ, resp.ref_clk_hz);
> +
> +	dev_dbg(&pdev->dev, "cluster %d: frequency table step size: %d\n",
> +		cluster_id, freq_table_step_size);
> +
> +	delta_ndiv = resp.ndiv_max - resp.ndiv_min;
> +
> +	if (unlikely(delta_ndiv == 0))
> +		num_freqs = 1;
> +	else
> +		/* We store both ndiv_min and ndiv_max hence the +1 */
> +		num_freqs = delta_ndiv / freq_table_step_size + 1;
> +
> +	num_freqs += (delta_ndiv % freq_table_step_size) ? 1 : 0;
> +
> +	freq_table = devm_kcalloc(&pdev->dev, num_freqs + 1,
> +				  sizeof(*freq_table), GFP_KERNEL);
> +	if (!freq_table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (index = 0, ndiv = resp.ndiv_min;
> +			ndiv < resp.ndiv_max;
> +			index++, ndiv += freq_table_step_size) {
> +		freq_table[index].driver_data = ndiv;
> +		freq_table[index].frequency = map_ndiv_to_freq(&resp, ndiv);
> +	}
> +
> +	freq_table[index].driver_data = resp.ndiv_max;
> +	freq_table[index++].frequency = map_ndiv_to_freq(&resp, resp.ndiv_max);
> +	freq_table[index].frequency = CPUFREQ_TABLE_END;
> +
> +	return freq_table;
> +}

-- 
viresh
