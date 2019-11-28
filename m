Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2DE10C67B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 11:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfK1KQA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 05:16:00 -0500
Received: from foss.arm.com ([217.140.110.172]:33190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfK1KQA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 28 Nov 2019 05:16:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 784181FB;
        Thu, 28 Nov 2019 02:15:59 -0800 (PST)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 053CF3F6C4;
        Thu, 28 Nov 2019 02:15:57 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH 1/2] ARM: vexpress: Set-up shared OPP table instead of individual for each CPU
Date:   Thu, 28 Nov 2019 10:15:46 +0000
Message-Id: <20191128101547.519-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently we add individual copy of same OPP table for each CPU within
the cluster. This is redundant and doesn't reflect the reality.

We can't use core cpumask to set policy->cpus in ve_spc_cpufreq_init()
anymore as it gets called via cpuhp_cpufreq_online()->cpufreq_online()
->cpufreq_driver->init() and the cpumask gets updated upon CPU hotplug
operations. It also may cause issues when the vexpress_spc_cpufreq
driver is built as a module.

Since ve_spc_clk_init is built-in device initcall, we should be able to
use the same topology_core_cpumask to set the opp sharing cpumask via
dev_pm_opp_set_sharing_cpus and use the same later in the driver via
dev_pm_opp_get_sharing_cpus.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/mach-vexpress/spc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
index 354e0e7025ae..1da11bdb1dfb 100644
--- a/arch/arm/mach-vexpress/spc.c
+++ b/arch/arm/mach-vexpress/spc.c
@@ -551,8 +551,9 @@ static struct clk *ve_spc_clk_register(struct device *cpu_dev)
 
 static int __init ve_spc_clk_init(void)
 {
-	int cpu;
+	int cpu, cluster;
 	struct clk *clk;
+	bool init_opp_table[MAX_CLUSTERS] = { false };
 
 	if (!info)
 		return 0; /* Continue only if SPC is initialised */
@@ -578,8 +579,17 @@ static int __init ve_spc_clk_init(void)
 			continue;
 		}
 
+		cluster = topology_physical_package_id(cpu_dev->id);
+		if (init_opp_table[cluster])
+			continue;
+
 		if (ve_init_opp_table(cpu_dev))
 			pr_warn("failed to initialise cpu%d opp table\n", cpu);
+		else if (dev_pm_opp_set_sharing_cpus(cpu_dev,
+			 topology_core_cpumask(cpu_dev->id)))
+			pr_warn("failed to mark OPPs shared for cpu%d\n", cpu);
+		else
+			init_opp_table[cluster] = true;
 	}
 
 	platform_device_register_simple("vexpress-spc-cpufreq", -1, NULL, 0);
-- 
2.17.1

