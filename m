Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE9810B600
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 19:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfK0Spt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 13:45:49 -0500
Received: from foss.arm.com ([217.140.110.172]:51762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727418AbfK0Spt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Nov 2019 13:45:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAC8931B;
        Wed, 27 Nov 2019 10:45:48 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50C2C3F6C4;
        Wed, 27 Nov 2019 10:45:47 -0800 (PST)
Date:   Wed, 27 Nov 2019 18:45:42 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: vexpress-spc: Fix wrong alternation of
 policy->related_cpus during CPU hp
Message-ID: <20191127184542.GA21368@bogus>
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
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 27, 2019 at 03:40:29PM +0000, Sudeep Holla wrote:
> 
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

missing else here, found when I was looking at the patch to stash/commit
locally.

> +
> +               init_opp_table[cluster] = true;
>         }
> 
>         platform_device_register_simple("vexpress-spc-cpufreq", -1, NULL, 0);

--
Regards,
Sudeep
