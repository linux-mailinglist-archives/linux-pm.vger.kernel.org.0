Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2633A3BF80D
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 12:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhGHKMM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 06:12:12 -0400
Received: from foss.arm.com ([217.140.110.172]:55378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbhGHKMM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Jul 2021 06:12:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 979941063;
        Thu,  8 Jul 2021 03:09:30 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 204033F5A1;
        Thu,  8 Jul 2021 03:09:29 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v4 6/9] cpufreq: Add a new freq-table relation CPUFREQ_RELATION_E
Date:   Thu,  8 Jul 2021 11:09:03 +0100
Message-Id: <1625738946-295849-7-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This new freq-table relation allows to look for the lowest frequency above
the request that is efficient but within the limit of the maximum allowed
by the policy.

Inefficient frequencies, skipped by CPUFREQ_RELATION_E must be marked with
the flag CPUFREQ_INEFFICIENT_FREQ.

CPUFREQ_RELATION_E is only effective if the driver allows it via
the policy flag relation_efficient. If it does not, the fallback
is CPUFREQ_RELATION_L.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 802abc925b2a..74eaa23bcc7c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2246,8 +2246,12 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	    !(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS))
 		return 0;
 
-	if (cpufreq_driver->target)
+	if (cpufreq_driver->target) {
+		/* Verify CPUFREQ_RELATION_E support  */
+		relation = cpufreq_frequency_relation_efficient(policy,
+								relation);
 		return cpufreq_driver->target(policy, target_freq, relation);
+	}
 
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index d68600b84d93..0a46924305fb 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -143,6 +143,9 @@ int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
 	case CPUFREQ_RELATION_C:
 		optimal.frequency = ~0;
 		break;
+	case CPUFREQ_RELATION_E:
+		relation = CPUFREQ_RELATION_L;
+		break;
 	}
 
 	cpufreq_for_each_valid_entry_idx(pos, table, i) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d10784cf7ee4..c7764ae05f84 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -115,6 +115,11 @@ struct cpufreq_policy {
 	bool			strict_target;
 
 	/*
+	 * Set if the driver supports CPUFREQ_RELATION_E.
+	 */
+	bool			relation_efficient;
+
+	/*
 	 * Preferred average time interval between consecutive invocations of
 	 * the driver to set the frequency for this policy.  To be set by the
 	 * scaling driver (0, which is the default, means no preference).
@@ -269,6 +274,7 @@ static inline void cpufreq_stats_record_transition(struct cpufreq_policy *policy
 #define CPUFREQ_RELATION_L 0  /* lowest frequency at or above target */
 #define CPUFREQ_RELATION_H 1  /* highest frequency below or at target */
 #define CPUFREQ_RELATION_C 2  /* closest frequency to target */
+#define CPUFREQ_RELATION_E 3  /* lowest efficient frequency at or above target */
 
 struct freq_attr {
 	struct attribute attr;
@@ -973,17 +979,45 @@ static inline int cpufreq_table_find_index_c(struct cpufreq_policy *policy,
 		return cpufreq_table_find_index_dc(policy, target_freq);
 }
 
+static inline unsigned int
+cpufreq_frequency_relation_efficient(struct cpufreq_policy *policy,
+				     unsigned int relation)
+{
+	if (!policy->relation_efficient && relation == CPUFREQ_RELATION_E)
+		return CPUFREQ_RELATION_L;
+
+	return relation;
+}
+
+static inline unsigned int
+cpufreq_frequency_find_efficient(struct cpufreq_policy *policy,
+				 unsigned int idx)
+{
+	struct cpufreq_frequency_table *table = policy->freq_table;
+	unsigned int efficient_idx = table[idx].efficient;
+
+	return table[efficient_idx].frequency <= policy->max ? efficient_idx :
+							       idx;
+}
+
 static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 						 unsigned int target_freq,
 						 unsigned int relation)
 {
+	unsigned int idx;
+
 	if (unlikely(policy->freq_table_sorted == CPUFREQ_TABLE_UNSORTED))
 		return cpufreq_table_index_unsorted(policy, target_freq,
 						    relation);
 
+	relation = cpufreq_frequency_relation_efficient(policy, relation);
+
 	switch (relation) {
 	case CPUFREQ_RELATION_L:
-		return cpufreq_table_find_index_l(policy, target_freq);
+	case CPUFREQ_RELATION_E:
+		idx = cpufreq_table_find_index_l(policy, target_freq);
+		return relation == CPUFREQ_RELATION_L ? idx :
+			cpufreq_frequency_find_efficient(policy, idx);
 	case CPUFREQ_RELATION_H:
 		return cpufreq_table_find_index_h(policy, target_freq);
 	case CPUFREQ_RELATION_C:
-- 
2.7.4

