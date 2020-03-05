Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9F9317A1FA
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2020 10:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgCEJHN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 04:07:13 -0500
Received: from foss.arm.com ([217.140.110.172]:45200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCEJHM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Mar 2020 04:07:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C65C04B2;
        Thu,  5 Mar 2020 01:07:11 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 325343F534;
        Thu,  5 Mar 2020 01:07:09 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, rjw@rjwysocki.net,
        pkondeti@codeaurora.org, ionela.voinescu@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 5/7] cpufreq: add function to get the hardware max frequency
Date:   Thu,  5 Mar 2020 09:06:25 +0000
Message-Id: <20200305090627.31908-6-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200305090627.31908-1-ionela.voinescu@arm.com>
References: <20200305090627.31908-1-ionela.voinescu@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add weak function to return the hardware maximum frequency of a CPU,
with the default implementation returning cpuinfo.max_freq, which is
the best information we can generically get from the cpufreq framework.

The default can be overwritten by a strong function in platforms
that want to provide an alternative implementation, with more accurate
information, obtained either from hardware or firmware.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 20 ++++++++++++++++++++
 include/linux/cpufreq.h   |  5 +++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index cbe6c94bf158..985228aee46f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1725,6 +1725,26 @@ unsigned int cpufreq_quick_get_max(unsigned int cpu)
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
index 0fb561d1b524..f7240251a949 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -205,6 +205,7 @@ static inline bool policy_is_shared(struct cpufreq_policy *policy)
 unsigned int cpufreq_get(unsigned int cpu);
 unsigned int cpufreq_quick_get(unsigned int cpu);
 unsigned int cpufreq_quick_get_max(unsigned int cpu);
+unsigned int cpufreq_get_hw_max_freq(unsigned int cpu);
 void disable_cpufreq(void);
 
 u64 get_cpu_idle_time(unsigned int cpu, u64 *wall, int io_busy);
@@ -232,6 +233,10 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
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

