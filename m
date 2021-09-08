Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18063403B33
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 16:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhIHOHC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 10:07:02 -0400
Received: from foss.arm.com ([217.140.110.172]:47180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351775AbhIHOHC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 10:07:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 692A0D6E;
        Wed,  8 Sep 2021 07:05:54 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1A2A83F766;
        Wed,  8 Sep 2021 07:05:52 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v7 8/9] cpufreq: Use CPUFREQ_RELATION_E in DVFS governors
Date:   Wed,  8 Sep 2021 15:05:29 +0100
Message-Id: <1631109930-290049-9-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631109930-290049-1-git-send-email-vincent.donnefort@arm.com>
References: <1631109930-290049-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Let the governors schedutil, conservative and ondemand to work, if possible
on efficient frequencies only.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9edf4abc9fa0..c6d82c28f768 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -554,7 +554,7 @@ static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 					 unsigned int target_freq)
 {
-	return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_L);
+	return __resolve_freq(policy, target_freq, CPUFREQ_RELATION_LE);
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index aa39ff31ec9f..0879ec3c170c 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -111,7 +111,8 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 		if (requested_freq > policy->max)
 			requested_freq = policy->max;
 
-		__cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_H);
+		__cpufreq_driver_target(policy, requested_freq,
+					CPUFREQ_RELATION_HE);
 		dbs_info->requested_freq = requested_freq;
 		goto out;
 	}
@@ -134,7 +135,8 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 		else
 			requested_freq = policy->min;
 
-		__cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_L);
+		__cpufreq_driver_target(policy, requested_freq,
+					CPUFREQ_RELATION_LE);
 		dbs_info->requested_freq = requested_freq;
 	}
 
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index f68cad9abd11..3b8f924771b4 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -120,12 +120,12 @@ static void dbs_freq_increase(struct cpufreq_policy *policy, unsigned int freq)
 
 	if (od_tuners->powersave_bias)
 		freq = od_ops.powersave_bias_target(policy, freq,
-				CPUFREQ_RELATION_H);
+						    CPUFREQ_RELATION_HE);
 	else if (policy->cur == policy->max)
 		return;
 
 	__cpufreq_driver_target(policy, freq, od_tuners->powersave_bias ?
-			CPUFREQ_RELATION_L : CPUFREQ_RELATION_H);
+			CPUFREQ_RELATION_LE : CPUFREQ_RELATION_HE);
 }
 
 /*
@@ -163,9 +163,9 @@ static void od_update(struct cpufreq_policy *policy)
 		if (od_tuners->powersave_bias)
 			freq_next = od_ops.powersave_bias_target(policy,
 								 freq_next,
-								 CPUFREQ_RELATION_L);
+								 CPUFREQ_RELATION_LE);
 
-		__cpufreq_driver_target(policy, freq_next, CPUFREQ_RELATION_C);
+		__cpufreq_driver_target(policy, freq_next, CPUFREQ_RELATION_CE);
 	}
 }
 
@@ -184,7 +184,7 @@ static unsigned int od_dbs_update(struct cpufreq_policy *policy)
 	 */
 	if (sample_type == OD_SUB_SAMPLE && policy_dbs->sample_delay_ns > 0) {
 		__cpufreq_driver_target(policy, dbs_info->freq_lo,
-					CPUFREQ_RELATION_H);
+					CPUFREQ_RELATION_HE);
 		return dbs_info->freq_lo_delay_us;
 	}
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 045565fe5b29..a4a79a67868f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -281,6 +281,10 @@ static inline void cpufreq_stats_record_transition(struct cpufreq_policy *policy
 /* relation flags */
 #define CPUFREQ_RELATION_E BIT(2) /* Get if possible an efficient frequency */
 
+#define CPUFREQ_RELATION_LE (CPUFREQ_RELATION_L | CPUFREQ_RELATION_E)
+#define CPUFREQ_RELATION_HE (CPUFREQ_RELATION_H | CPUFREQ_RELATION_E)
+#define CPUFREQ_RELATION_CE (CPUFREQ_RELATION_C | CPUFREQ_RELATION_E)
+
 struct freq_attr {
 	struct attribute attr;
 	ssize_t (*show)(struct cpufreq_policy *, char *);
@@ -637,9 +641,11 @@ struct cpufreq_governor *cpufreq_fallback_governor(void);
 static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *policy)
 {
 	if (policy->max < policy->cur)
-		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
+		__cpufreq_driver_target(policy, policy->max,
+					CPUFREQ_RELATION_HE);
 	else if (policy->min > policy->cur)
-		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
+		__cpufreq_driver_target(policy, policy->min,
+					CPUFREQ_RELATION_LE);
 }
 
 /* Governor attribute set */
-- 
2.7.4

