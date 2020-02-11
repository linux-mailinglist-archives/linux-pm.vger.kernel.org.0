Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1143159909
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 19:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbgBKSqh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 13:46:37 -0500
Received: from foss.arm.com ([217.140.110.172]:52406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbgBKSqh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Feb 2020 13:46:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D37FB30E;
        Tue, 11 Feb 2020 10:46:36 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A4BC73F68F;
        Tue, 11 Feb 2020 10:46:34 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com, rjw@rjwysocki.net,
        ionela.voinescu@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 5/7] cpufreq: add function to get the hardware max frequency
Date:   Tue, 11 Feb 2020 18:45:40 +0000
Message-Id: <20200211184542.29585-6-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211184542.29585-1-ionela.voinescu@arm.com>
References: <20200211184542.29585-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add weak function to return the hardware maximum frequency of a
CPU, with the default implementation returning cpuinfo.max_freq.

The default can be overwritten by a strong function in platforms
that want to provide an alternative implementation.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 20 ++++++++++++++++++++
 include/linux/cpufreq.h   |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 77114a3897fb..d2ff3018861d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1733,6 +1733,26 @@ unsigned int cpufreq_quick_get_max(unsigned int cpu)
 }
 EXPORT_SYMBOL(cpufreq_quick_get_max);
 
+/**
+ * cpufreq_get_hw_max_freq - get the max hardware frequency of the CPU
+ * @cpu: CPU number
+ *
+ * The default return value is the max_freq field of cpuinfo.
+ */
+__weak unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	unsigned int ret_freq = 0;
+
+	if (policy) {
+		ret_freq = policy->cpuinfo.max_freq;
+		cpufreq_cpu_put(policy);
+	}
+
+	return ret_freq;
+}
+EXPORT_SYMBOL(cpufreq_get_hw_max_freq);
+
 static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
 {
 	if (unlikely(policy_is_inactive(policy)))
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 31b1b0e03df8..b4423ff619f4 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -194,6 +194,7 @@ extern struct kobject *cpufreq_global_kobject;
 unsigned int cpufreq_get(unsigned int cpu);
 unsigned int cpufreq_quick_get(unsigned int cpu);
 unsigned int cpufreq_quick_get_max(unsigned int cpu);
+unsigned int cpufreq_get_hw_max_freq(unsigned int cpu);
 void disable_cpufreq(void);
 
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
@@ -223,6 +224,10 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
 {
 	return 0;
 }
+static inline unsigned int cpufreq_get_hw_max_freq(unsigned int cpu)
+{
+	return 0;
+}
 static inline void disable_cpufreq(void) { }
 #endif
 
-- 
2.17.1

