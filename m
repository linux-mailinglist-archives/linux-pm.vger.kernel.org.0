Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6165E255FCC
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 19:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgH1ReE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 13:34:04 -0400
Received: from foss.arm.com ([217.140.110.172]:54160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgH1ReB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Aug 2020 13:34:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C23BD6E;
        Fri, 28 Aug 2020 10:34:00 -0700 (PDT)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 232073F71F;
        Fri, 28 Aug 2020 10:33:59 -0700 (PDT)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        dietmar.eggemann@arm.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, will@kernel.org, valentin.schneider@arm.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH v4 3/5] cpufreq: report whether cpufreq supports Frequency Invariance (FI)
Date:   Fri, 28 Aug 2020 18:33:01 +0100
Message-Id: <20200828173303.11939-4-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828173303.11939-1-ionela.voinescu@arm.com>
References: <20200828173303.11939-1-ionela.voinescu@arm.com>
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
 drivers/cpufreq/cpufreq.c | 16 ++++++++++++++++
 include/linux/cpufreq.h   |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 34533c6b3bd0..f97c743a988d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -61,6 +61,12 @@ static struct cpufreq_driver *cpufreq_driver;
 static DEFINE_PER_CPU(struct cpufreq_policy *, cpufreq_cpu_data);
 static DEFINE_RWLOCK(cpufreq_driver_lock);
 
+static DEFINE_STATIC_KEY_FALSE(cpufreq_freq_invariance);
+bool cpufreq_supports_freq_invariance(void)
+{
+	return static_branch_likely(&cpufreq_freq_invariance);
+}
+
 /* Flag to suspend/resume CPUFreq governors */
 static bool cpufreq_suspended;
 
@@ -2721,6 +2727,15 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	cpufreq_driver = driver_data;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
+	/*
+	 * Mark support for the scheduler's frequency invariance engine for
+	 * drivers that implement target(), target_index() or fast_switch().
+	 */
+	if (!cpufreq_driver->setpolicy) {
+		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
+		pr_debug("supports frequency invariance");
+	}
+
 	if (driver_data->setpolicy)
 		driver_data->flags |= CPUFREQ_CONST_LOOPS;
 
@@ -2790,6 +2805,7 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
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

