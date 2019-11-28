Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0D110C263
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 03:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfK1CbW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 21:31:22 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34052 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbfK1CbV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 21:31:21 -0500
Received: by mail-pf1-f195.google.com with SMTP id n13so12354530pff.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2019 18:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w3MhAgNwJCDzFmg83BGAd8t/eEyIf/GsxgnTUb2ToXs=;
        b=AbV2WhvURSc4H37cMnU1McRpKMN3PNtGgOrYok6XE+t9/06vmiOzXjxO8o2/A4nNp4
         Th474P4Odokl5RWixStRMW5aLqjuL+perV6RJMm+oYT0og/XFeKaql61vRSRiMJ2pq32
         0omD61mSXnitttdyY+8RdTvxmea7rn86qHhC8uuVGiCvCxLNuvzRjfd/GUuY0RIQYSP2
         cmdskrvBVEhe3S9Q8lDcJdRWRIlI7bSrEFH1y1U4Rk/tYvNaQaqZi/+FF5T+ytaNx+SZ
         qeKAzvV5MkymttKH0wbACMhRa1dZMoMvjL94xGienEDXbooxuQVYAxmfQ3NFUZlSxovl
         0VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w3MhAgNwJCDzFmg83BGAd8t/eEyIf/GsxgnTUb2ToXs=;
        b=AK0MDlrz4DgJTQUgErCYoyeqVV5aZibiuqfgpG9BGSxD8ly471NKJjXFwtJB40RAYm
         S2WuvnXX7UoA4hR7oJ7jlQ2ieWKBsbDF8/yTr9m0IG5SvUWsgvwPNpKZZVut/t4RCzy+
         HTHUug7nGm/45BSLKBA2rKR0lnqBFwaEx6AHrUEvjCSMtRQGnLR90FNBe53y2qN4caS/
         opvGiRV7nG3/IiKM9LEwp1svr1cZpA5dL14DfhWUDwB51tDfka0zYZh5qu9FyV1xSgCU
         uCu3hXTZObdhwCLvF2JkoRERWnH0NFfhU+TXViKyxeUe7O0oT49ymY5Fz1H2L5o9YW1e
         uXKw==
X-Gm-Message-State: APjAAAUIEyTL2dkP3eVcVhP9EuZktfiztzKlz8LsU/Ah79Opv1GmqaWS
        +Ii7rFUpFDvxp291qYLxAzrzBw==
X-Google-Smtp-Source: APXvYqx4TG+a8InkKBmHDvzMujmJEOUlgarnckvNwhCekHG+3RWiohoP5Zo9pN47GWMMV9wizulVyg==
X-Received: by 2002:a62:cf46:: with SMTP id b67mr30054210pfg.77.1574908280836;
        Wed, 27 Nov 2019 18:31:20 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id q15sm1312656pgi.55.2019.11.27.18.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 18:31:20 -0800 (PST)
Date:   Thu, 28 Nov 2019 08:01:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: vexpress-spc: Fix wrong alternation of
 policy->related_cpus during CPU hp
Message-ID: <20191128023116.3skwbeowk7wtjaxc@vireshk-i7>
References: <20191127114801.23837-1-dietmar.eggemann@arm.com>
 <20191127120816.GC29301@bogus>
 <20191127121402.vd3tul4gmqm6qtyb@vireshk-i7>
 <20191127133200.GE29301@bogus>
 <a60cab69-4d47-d418-94bd-74630bf9e846@arm.com>
 <20191127154029.GA4826@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127154029.GA4826@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-11-19, 15:40, Sudeep Holla wrote:
> diff --git i/arch/arm/mach-vexpress/spc.c w/arch/arm/mach-vexpress/spc.c
> index 354e0e7025ae..e0e2e789a0b7 100644
> --- i/arch/arm/mach-vexpress/spc.c
> +++ w/arch/arm/mach-vexpress/spc.c
> @@ -551,8 +551,9 @@ static struct clk *ve_spc_clk_register(struct device *cpu_dev)
> 
>  static int __init ve_spc_clk_init(void)
>  {
> -       int cpu;
> +       int cpu, cluster;
>         struct clk *clk;
> +       bool init_opp_table[MAX_CLUSTERS] = { false };
> 
>         if (!info)
>                 return 0; /* Continue only if SPC is initialised */
> @@ -578,8 +579,17 @@ static int __init ve_spc_clk_init(void)
>                         continue;
>                 }
> 
> +               cluster = topology_physical_package_id(cpu_dev->id);
> +               if (init_opp_table[cluster])
> +                       continue;
> +
>                 if (ve_init_opp_table(cpu_dev))
>                         pr_warn("failed to initialise cpu%d opp table\n", cpu);
> +               else if (dev_pm_opp_set_sharing_cpus(cpu_dev,
> +                        topology_core_cpumask(cpu_dev->id)))
> +                       pr_warn("failed to mark OPPs shared for cpu%d\n", cpu);
> +
> +               init_opp_table[cluster] = true;
>         }
> 
>         platform_device_register_simple("vexpress-spc-cpufreq", -1, NULL, 0);
> diff --git i/drivers/cpufreq/vexpress-spc-cpufreq.c w/drivers/cpufreq/vexpress-spc-cpufreq.c
> index 506e3f2bf53a..83c85d3d67e3 100644
> --- i/drivers/cpufreq/vexpress-spc-cpufreq.c
> +++ w/drivers/cpufreq/vexpress-spc-cpufreq.c
> @@ -434,7 +434,7 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
>         if (cur_cluster < MAX_CLUSTERS) {
>                 int cpu;
> 
> -               cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
> +               dev_pm_opp_get_sharing_cpus(cpu_dev, policy->cpus);
> 
>                 for_each_cpu(cpu, policy->cpus)
>                         per_cpu(physical_cluster, cpu) = cur_cluster;

This is a better *work-around* I would say, as we can't break it the
way I explained earlier :)

-- 
viresh
