Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECCB250A76
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 23:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgHXVD7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 17:03:59 -0400
Received: from foss.arm.com ([217.140.110.172]:43058 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHXVD4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Aug 2020 17:03:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09C1331B;
        Mon, 24 Aug 2020 14:03:56 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9445E3F71F;
        Mon, 24 Aug 2020 14:03:54 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, will@kernel.org, valentin.schneider@arm.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH v3 3/5] cpufreq: report whether cpufreq supports Frequency Invariance (FI)
Date:   Mon, 24 Aug 2020 22:02:50 +0100
Message-Id: <20200824210252.27486-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824210252.27486-1-ionela.voinescu@arm.com>
References: <20200824210252.27486-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that the update of the FI scale factor is done in cpufreq core for
selected functions - target(), target_index() and fast_switch(),
we can provide feedback to the task scheduler and architecture code
on whether cpufreq supports FI.

For this purpose provide an external function to expose whether the
cpufreq drivers support FI, by using a static key.

The logic behind the enablement of cpufreq-based invariance is as
follows:
 - cpufreq-based invariance is disabled by default
 - cpufreq-based invariance is enabled if any of the callbacks
   above is implemented while the unsupported setpolicy() is not

The cpufreq_supports_freq_invariance() function only returns whether
cpufreq is instrumented with the arch_set_freq_scale() calls that
result in support for frequency invariance. Due to the lack of knowledge
on whether the implementation of arch_set_freq_scale() actually results
in the setting of a scale factor based on cpufreq information, it is up
to the architecture code to ensure the setting and provision of the
scale factor to the scheduler.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 20 ++++++++++++++++++++
 include/linux/cpufreq.h   |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 34533c6b3bd0..b3a7d1cc5e92 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -61,6 +61,9 @@ static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 
+/* Mark support for the scheduler's frequency invariance engine */
+static DEFINE_STATIC_KEY_FALSE(cpufreq_freq_invariance);
+
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
 
@@ -69,6 +72,20 @@ static inline bool has_target(void)
 	return cpufreq_driver->target_index || cpufreq_driver->target;
 }
 
+static inline
+void enable_cpufreq_freq_invariance(struct cpufreq_driver *driver)
+{
+	if (!driver->setpolicy) {
+		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
+		pr_debug("supports frequency invariance");
+	}
+}
+
+bool cpufreq_supports_freq_invariance(void)
+{
+	return static_branch_likely(&cpufreq_freq_invariance);
+}
+
 /* internal prototypes */
 static unsigned int __cpufreq_get(struct cpufreq_policy *policy);
 static int cpufreq_init_governor(struct cpufreq_policy *policy);
@@ -2721,6 +2738,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	cpufreq_driver = driver_data;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	enable_cpufreq_freq_invariance(cpufreq_driver);
+
 	if (driver_data->setpolicy)
 		driver_data->flags |= CPUFREQ_CONST_LOOPS;
 
@@ -2790,6 +2809,7 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
 	cpus_read_lock();
 	subsys_interface_unregister(&cpufreq_interface);
 	remove_boost_sysfs_file();
+	static_branch_disable_cpuslocked(&cpufreq_freq_invariance);
 	cpuhp_remove_state_nocalls_cpuslocked(hp_online);
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 8f141d4c859c..091df9968945 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -217,6 +217,7 @@ void refresh_frequency_limits(struct cpufreq_policy *policy);
 void cpufreq_update_policy(unsigned int cpu);
 void cpufreq_update_limits(unsigned int cpu);
 bool have_governor_per_policy(void);
+bool cpufreq_supports_freq_invariance(void);
 struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
 void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
@@ -237,6 +238,10 @@ static inline unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
 {
 	return 0;
 }
+static inline bool cpufreq_supports_freq_invariance(void)
+{
+	return false;
+}
 static inline void disable_cpufreq(void) { }
 #endif
 
-- 
2.17.1

