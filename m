Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0390110B28E
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 16:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfK0PlU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 10:41:20 -0500
Received: from foss.arm.com ([217.140.110.172]:49276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfK0PlT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Nov 2019 10:41:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42FDF1045;
        Wed, 27 Nov 2019 07:41:19 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB58F3F68E;
        Wed, 27 Nov 2019 07:41:17 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:40:29 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: vexpress-spc: Fix wrong alternation of
 policy->related_cpus during CPU hp
Message-ID: <20191127154029.GA4826@bogus>
References: <20191127114801.23837-1-dietmar.eggemann@arm.com>
 <20191127120816.GC29301@bogus>
 <20191127121402.vd3tul4gmqm6qtyb@vireshk-i7>
 <20191127133200.GE29301@bogus>
 <a60cab69-4d47-d418-94bd-74630bf9e846@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a60cab69-4d47-d418-94bd-74630bf9e846@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 27, 2019 at 03:58:49PM +0100, Dietmar Eggemann wrote:
> On 27/11/2019 14:32, Sudeep Holla wrote:

[...]

> >
> > Yes but there's no architectural way. I need to revise and see tc2_pm.c
> > to check if we can do any magic there.
>
> I'm fine with finding a better solution to return a fixed topology core
> cpumask or calling this patch a workaround. AFAICS, only TC2 is affected.
>
> ("arm: Fix topology setup in case of CPU hotplug for CONFIG_SCHED_MC")
> is needed for other systems as well in case we have commit ca74b316df96
> ("arm: Use common cpu_topology structure and functions."). We probably
> don't want to revert commit ca74b316df96?
>

Correct

> We do CPU hp stress tests in our EAS mainline integration test suite
> https://developer.arm.com/tools-and-software/open-source-software/linux-kernel/energy-aware-scheduling/eas-mainline-development
> and there is where we initially encountered this issue on TC2.

I could come up with the patch below. If this is any cleaner and acceptable
I am happy to post it. One advantage of moving the use of topology_core_cpumask
inside ve_spc_clk_init is that it's just device_initcall and not a module.
It allows to handle ve_spc_cpufreq as module. I prefer this than the
previous solution/workaround. Let me know.

Regards,
Sudeep

-->8

diff --git i/arch/arm/mach-vexpress/spc.c w/arch/arm/mach-vexpress/spc.c
index 354e0e7025ae..e0e2e789a0b7 100644
--- i/arch/arm/mach-vexpress/spc.c
+++ w/arch/arm/mach-vexpress/spc.c
@@ -551,8 +551,9 @@ static struct clk *ve_spc_clk_register(struct device *cpu_dev)

 static int __init ve_spc_clk_init(void)
 {
-       int cpu;
+       int cpu, cluster;
        struct clk *clk;
+       bool init_opp_table[MAX_CLUSTERS] = { false };

        if (!info)
                return 0; /* Continue only if SPC is initialised */
@@ -578,8 +579,17 @@ static int __init ve_spc_clk_init(void)
                        continue;
                }

+               cluster = topology_physical_package_id(cpu_dev->id);
+               if (init_opp_table[cluster])
+                       continue;
+
                if (ve_init_opp_table(cpu_dev))
                        pr_warn("failed to initialise cpu%d opp table\n", cpu);
+               else if (dev_pm_opp_set_sharing_cpus(cpu_dev,
+                        topology_core_cpumask(cpu_dev->id)))
+                       pr_warn("failed to mark OPPs shared for cpu%d\n", cpu);
+
+               init_opp_table[cluster] = true;
        }

        platform_device_register_simple("vexpress-spc-cpufreq", -1, NULL, 0);
diff --git i/drivers/cpufreq/vexpress-spc-cpufreq.c w/drivers/cpufreq/vexpress-spc-cpufreq.c
index 506e3f2bf53a..83c85d3d67e3 100644
--- i/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ w/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -434,7 +434,7 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
        if (cur_cluster < MAX_CLUSTERS) {
                int cpu;

-               cpumask_copy(policy->cpus, topology_core_cpumask(policy->cpu));
+               dev_pm_opp_get_sharing_cpus(cpu_dev, policy->cpus);

                for_each_cpu(cpu, policy->cpus)
                        per_cpu(physical_cluster, cpu) = cur_cluster;

