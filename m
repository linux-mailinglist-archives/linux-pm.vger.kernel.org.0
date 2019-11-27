Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D8010AEE4
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 12:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfK0LsK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 06:48:10 -0500
Received: from foss.arm.com ([217.140.110.172]:46656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfK0LsK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 27 Nov 2019 06:48:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A34AB30E;
        Wed, 27 Nov 2019 03:48:09 -0800 (PST)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05CFC3F6C4;
        Wed, 27 Nov 2019 03:48:07 -0800 (PST)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: vexpress-spc: Fix wrong alternation of policy->related_cpus during CPU hp
Date:   Wed, 27 Nov 2019 12:48:01 +0100
Message-Id: <20191127114801.23837-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit ca74b316df96 ("arm: Use common cpu_topology structure and
functions.") the core cpumask has to be modified during cpu hotplug
operations.

("arm: Fix topology setup in case of CPU hotplug for CONFIG_SCHED_MC")
[1] fixed that but revealed another issue on TC2, i.e in its cpufreq
driver.

During CPU hp stress operations on multiple CPUs, policy->related_cpus
can be altered. This is wrong since this cpumask should contain the
online and offline CPUs.

The WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus)) in
cpufreq_online() triggers in this case.

The core cpumask can't be used to set the policy->cpus in
ve_spc_cpufreq_init() anymore in case it is called via
cpuhp_cpufreq_online()->cpufreq_online()->cpufreq_driver->init().

An empty online() callback can be used to avoid that the init()
driver function is called during CPU hotplug in so that
policy->related_cpus will not be changed.

Implementing an online() also requires an offline() callback.

Tested on TC2 with CPU hp stress test (CPU hp from multiple CPUs at
the same time).

[1]
https://lore.kernel.org/r/20191127103353.12417-1-dietmar.eggemann@arm.com

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 506e3f2bf53a..857dcb535e97 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -492,6 +492,16 @@ static void ve_spc_cpufreq_ready(struct cpufreq_policy *policy)
 	cdev[cur_cluster] = of_cpufreq_cooling_register(policy);
 }
 
+static int ve_spc_cpufreq_online(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
+static int ve_spc_cpufreq_offline(struct cpufreq_policy *policy)
+{
+	return 0;
+}
+
 static struct cpufreq_driver ve_spc_cpufreq_driver = {
 	.name			= "vexpress-spc",
 	.flags			= CPUFREQ_STICKY |
@@ -503,6 +513,8 @@ static struct cpufreq_driver ve_spc_cpufreq_driver = {
 	.init			= ve_spc_cpufreq_init,
 	.exit			= ve_spc_cpufreq_exit,
 	.ready			= ve_spc_cpufreq_ready,
+	.online                 = ve_spc_cpufreq_online,
+	.offline                = ve_spc_cpufreq_offline,
 	.attr			= cpufreq_generic_attr,
 };
 
-- 
2.17.1

