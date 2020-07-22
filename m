Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E49229522
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jul 2020 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbgGVJip (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jul 2020 05:38:45 -0400
Received: from foss.arm.com ([217.140.110.172]:53058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGVJip (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Jul 2020 05:38:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C041E101E;
        Wed, 22 Jul 2020 02:38:44 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1CBE23F66F;
        Wed, 22 Jul 2020 02:38:43 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, will@kernel.org, linux@armlinux.org.uk
Cc:     mingo@redhat.com, peterz@infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH v2 4/7] cpufreq: report whether cpufreq supports Frequency Invariance (FI)
Date:   Wed, 22 Jul 2020 10:37:29 +0100
Message-Id: <20200722093732.14297-5-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722093732.14297-1-ionela.voinescu@arm.com>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that the update of the FI scale factor is done in cpufreq core for
selected functions - target(), target_index() and fast_switch(),
we can provide feedback to the task scheduler and architecture code
on whether cpufreq supports FI.

For this purpose, provide error and debug messages, together with an
external function to expose whether the cpufreq drivers support FI, by
using a static key.

The logic behind the enablement of cpufreq-based invariance is as
follows:
 - cpufreq-based invariance is disabled by default
 - cpufreq-based invariance is enabled if any of the callbacks
   above is implemented while the unsupported setpolicy() is not
 - if enabled, cpufreq-based invariance will be disabled during the
   call of the default arch_set_freq_scale() function which does
   not set a scale factor.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 28 ++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 3497c1cd6818..1d0b046fe8e9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -61,6 +61,9 @@ static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 
+/* Mark support for the scheduler's frequency invariance engine */
+static DEFINE_STATIC_KEY_FALSE(cpufreq_set_freq_scale);
+
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
 
@@ -69,6 +72,25 @@ static inline bool has_target(void)
 	return cpufreq_driver->target_index || cpufreq_driver->target;
 }
 
+static inline
+void enable_cpufreq_freq_invariance(struct cpufreq_driver *driver)
+{
+	if ((driver->target || driver->target_index || driver->fast_switch) &&
+	    !driver->setpolicy) {
+
+		static_branch_enable_cpuslocked(&cpufreq_set_freq_scale);
+		pr_debug("%s: Driver %s can provide frequency invariance.",
+			 __func__, driver->name);
+	} else
+		pr_err("%s: Driver %s cannot provide frequency invariance.",
+		__func__, driver->name);
+}
+
+bool cpufreq_sets_freq_scale(void)
+{
+	return static_branch_likely(&cpufreq_set_freq_scale);
+}
+
 /* internal prototypes */
 static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
 static int cpufreq_init_governor(struct cpufreq_policy *policy);
@@ -159,6 +181,9 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time);
 __weak void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
 		unsigned long max_freq)
 {
+	if (cpufreq_sets_freq_scale())
+		static_branch_disable_cpuslocked(&cpufreq_set_freq_scale);
+
 }
 EXPORT_SYMBOL_GPL(arch_set_freq_scale);
 
@@ -2722,6 +2747,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	cpufreq_driver = driver_data;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	enable_cpufreq_freq_invariance(cpufreq_driver);
+
 	if (driver_data->setpolicy)
 		driver_data->flags |= CPUFREQ_CONST_LOOPS;
 
@@ -2791,6 +2818,7 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 	cpus_read_lock();
 	subsys_interface_unregister(&cpufreq_interface);
 	remove_boost_sysfs_file();
+	static_branch_disable_cpuslocked(&cpufreq_set_freq_scale);
 	cpuhp_remove_state_nocalls_cpuslocked(hp_online);
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index e62b022cb07e..f81215ad76f1 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -217,6 +217,7 @@ void refresh_frequency_limits(struct cpufreq_policy *policy);
 void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);
 bool have_governor_per_policy(void);
+bool cpufreq_sets_freq_scale(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
 void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
@@ -237,6 +238,10 @@ static inline unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
 {
 	return 0;
 }
+static inline bool cpufreq_sets_freq_scale(void)
+{
+	return false;
+}
 static inline void disable_cpufreq(void) { }
 #endif
 
-- 
2.17.1

