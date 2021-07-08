Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56983BF80E
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jul 2021 12:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhGHKMO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 06:12:14 -0400
Received: from foss.arm.com ([217.140.110.172]:55394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231324AbhGHKMO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Jul 2021 06:12:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43396113E;
        Thu,  8 Jul 2021 03:09:32 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (e120877-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9BF43F5A1;
        Thu,  8 Jul 2021 03:09:30 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com
Cc:     linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com, mka@chromium.org,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v4 7/9] cpufreq: CPUFREQ_RELATION_E in schedutil ondemand and conservative
Date:   Thu,  8 Jul 2021 11:09:04 +0100
Message-Id: <1625738946-295849-8-git-send-email-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
References: <1625738946-295849-1-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Avoid inefficient frequencies with the freq-table relation
CPUFREQ_RELATION_E instead of CPUFREQ_RELATION_L in governors where it is
possible. Are left aside:

  - userspace: there is no reason to not honour user requests.
  - powersave: selects the lowest frequency possible.

Caveat in ondemand: the governor only using CPUFREQ_RELATION_L when
powersavebias is set, the inefficient frequencies would be skipped only in
a such configuration.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 74eaa23bcc7c..f8d01d083df0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -545,7 +545,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 		unsigned int idx;
 
 		idx = cpufreq_frequency_table_target(policy, target_freq,
-						     CPUFREQ_RELATION_L);
+						     CPUFREQ_RELATION_E);
 		policy->cached_resolved_idx = idx;
 		return policy->freq_table[idx].frequency;
 	}
diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index aa39ff31ec9f..084b35dbb4ef 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -134,7 +134,7 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
 		else
 			requested_freq = policy->min;
 
-		__cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_L);
+		__cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_E);
 		dbs_info->requested_freq = requested_freq;
 	}
 
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index ac361a8b1d3b..19689d15d3d3 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -123,7 +123,7 @@ static void dbs_freq_increase(struct cpufreq_policy *policy, unsigned int freq)
 		return;
 
 	__cpufreq_driver_target(policy, freq, od_tuners->powersave_bias ?
-			CPUFREQ_RELATION_L : CPUFREQ_RELATION_H);
+			CPUFREQ_RELATION_E : CPUFREQ_RELATION_H);
 }
 
 /*
@@ -161,7 +161,7 @@ static void od_update(struct cpufreq_policy *policy)
 		if (od_tuners->powersave_bias)
 			freq_next = od_ops.powersave_bias_target(policy,
 								 freq_next,
-								 CPUFREQ_RELATION_L);
+								 CPUFREQ_RELATION_E);
 
 		__cpufreq_driver_target(policy, freq_next, CPUFREQ_RELATION_C);
 	}
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c7764ae05f84..0110408fcf2d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -638,7 +638,7 @@ static inline void cpufreq_policy_apply_limits(struct cpufreq_policy *policy)
 	if (policy->max < policy->cur)
 		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
 	else if (policy->min > policy->cur)
-		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
+		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_E);
 }
 
 /* Governor attribute set */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 57124614363d..d6c7694b75bd 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -481,7 +481,7 @@ static void sugov_work(struct kthread_work *work)
 	raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
 
 	mutex_lock(&sg_policy->work_lock);
-	__cpufreq_driver_target(sg_policy->policy, freq, CPUFREQ_RELATION_L);
+	__cpufreq_driver_target(sg_policy->policy, freq, CPUFREQ_RELATION_E);
 	mutex_unlock(&sg_policy->work_lock);
 }
 
-- 
2.7.4

