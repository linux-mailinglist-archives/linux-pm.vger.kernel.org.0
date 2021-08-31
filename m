Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB89D3FC59C
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 12:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbhHaKZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 06:25:40 -0400
Received: from foss.arm.com ([217.140.110.172]:52944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240962AbhHaKZk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Aug 2021 06:25:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 363E41FB;
        Tue, 31 Aug 2021 03:24:45 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C06493F5A1;
        Tue, 31 Aug 2021 03:24:43 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v6 7/7] PM / EM: Mark inefficiencies in CPUFreq
Date:   Tue, 31 Aug 2021 11:24:13 +0100
Message-Id: <1630405453-275784-8-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
References: <1630405453-275784-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Model has a 1:1 mapping between OPPs and performance states
(em_perf_state). If a CPUFreq driver registers an Energy Model,
inefficiencies found by the latter can be applied to CPUFreq.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index cb09afbf01e2..153ddc7b0506 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1121,7 +1121,6 @@ void cpufreq_generic_init(struct cpufreq_policy *policy,
 
 static inline void cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
 {
-	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu),
-				  policy->related_cpus);
+	dev_pm_opp_of_register_em(get_cpu_device(policy->cpu), policy->related_cpus);
 }
 #endif /* _LINUX_CPUFREQ_H */
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index d353ef29e37f..dfcbb2deb794 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) "energy_model: " fmt
 
 #include <linux/cpu.h>
+#include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/debugfs.h>
 #include <linux/energy_model.h>
@@ -231,6 +232,46 @@ static int em_create_pd(struct device *dev, int nr_states,
 	return 0;
 }
 
+static void em_cpufreq_update_efficiencies(struct device *dev)
+{
+	struct em_perf_domain *pd = dev->em_pd;
+	struct em_perf_state *table;
+	struct cpufreq_policy *policy;
+	bool found = false;
+	int i;
+
+	if (!_is_cpu_device(dev) || !pd)
+		return;
+
+	policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
+	if (!policy) {
+		dev_warn(dev, "EM: Access to CPUFreq policy failed");
+		return;
+	}
+
+	table = pd->table;
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+		if (!(table[i].flags & EM_PERF_STATE_INEFFICIENT))
+			continue;
+
+		cpufreq_table_set_inefficient(policy, table[i].frequency);
+		found = true;
+	}
+
+	if (!found)
+		return;
+
+	if (cpufreq_table_update_efficiencies(policy))
+		return;
+
+	/*
+	 * Efficiencies have been installed in CPUFreq, inefficient frequencies
+	 * will be skipped. The EM can do the same.
+	 */
+	pd->flags |= EM_PERF_DOMAIN_SKIP_INEFFICIENCIES;
+}
+
 /**
  * em_pd_get() - Return the performance domain for a device
  * @dev : Device to find the performance domain for
@@ -347,6 +388,8 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 	if (milliwatts)
 		dev->em_pd->flags |= EM_PERF_DOMAIN_MILLIWATTS;
 
+	em_cpufreq_update_efficiencies(dev);
+
 	em_debug_create_pd(dev);
 	dev_info(dev, "EM: created perf domain\n");
 
-- 
2.7.4

