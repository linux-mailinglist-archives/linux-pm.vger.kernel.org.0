Return-Path: <linux-pm+bounces-80-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D01187F47EC
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 14:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF53B1C20AAE
	for <lists+linux-pm@lfdr.de>; Wed, 22 Nov 2023 13:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E4756448;
	Wed, 22 Nov 2023 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRNHLrYs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71782D50
	for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 05:39:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40790b0a224so31435075e9.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2023 05:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700660353; x=1701265153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGPyPKyzU47W/i11SE/AFAi0JIzecDdPwXQnIZMIKEk=;
        b=GRNHLrYscOHSpTFU4rxwGMjQkaDrUe59sLsQfeX4rXZ7ZLEbvVj4Mi1EE9pJoR/13n
         MqPOynwopaLTZvu7BFTqh3MgZn/IPI4lIYnXJpG3wWJFehhk+eQtNw09kEkI+0S7ZSoC
         9qp0ubPweOlqQ0pfWS6CZu2Cth6mneB0+LcPSW8OBH5eydLLkRUXhKZa+SGkbuFdwtr/
         lW2m3LFOOBtclTfauMYl/F5TDOTeAloRb16EHR7/3QWBbQeOiFOsyhB5yC4N9JgliNMf
         cVz9GunhkuQMzIWRORcfFjm33B5TwDgIoaZ8irWnUsm79mHTUof5tpSy/Y0KyNxsFp1X
         Zypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700660353; x=1701265153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGPyPKyzU47W/i11SE/AFAi0JIzecDdPwXQnIZMIKEk=;
        b=iZUf/jtdRE2yPjXCiWI+O7ftZlyNb9c4VpfjPS+hDUZ0Bte4SILDSi7k/f7jw8Tzok
         i0JutTwZY+s877yckrCEEizbA15ljx8DdTLeBASG7e6lkNgIJfyQiaA6KDkL3kA0nRLf
         oJi9YfypQ9r2Zx+baz1TI6CMSemaoOjv/AN7Y1BDHiGHvPZiX3ubnSCKLTWoE4t+tgKB
         f6hBGWJyRIgcaMMFc6yYusnUiwtYglXj9xiwCvgYw0svWvAqT5OBFcDn5PfP2cyNSb5R
         ILFLH2othFMK2C1U1rTPSINh8wMV7jiWgfjv7+B1Ptly+74xppEuCgCVl5IzMbaf6dw0
         Fz2A==
X-Gm-Message-State: AOJu0YzPhL/mAeMoSv2gmO54NM6YecINbUXE3V1h4TfRb8I2u1FiVBV5
	iX961kSwmqeO3keWttZtHppgMw==
X-Google-Smtp-Source: AGHT+IEKilmCIG0iXXMek5xKP6m4yvWkniynljYS8f6YdDDcU0B1M4JwccnS0YG6TCHIEioMpY1VIA==
X-Received: by 2002:a05:600c:1907:b0:409:50b4:3da8 with SMTP id j7-20020a05600c190700b0040950b43da8mr2417720wmq.38.1700660352813;
        Wed, 22 Nov 2023 05:39:12 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:3a2e:a7f5:93e6:508b])
        by smtp.gmail.com with ESMTPSA id o31-20020a05600c511f00b00407752bd834sm2307386wms.1.2023.11.22.05.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:39:12 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	qyousef@layalina.io,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: lukasz.luba@arm.com,
	wyes.karny@amd.com,
	beata.michalska@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 2/2] sched/schedutil: Rework iowait boost
Date: Wed, 22 Nov 2023 14:39:04 +0100
Message-Id: <20231122133904.446032-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122133904.446032-1-vincent.guittot@linaro.org>
References: <20231122133904.446032-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the max value that has already been computed inside sugov_get_util()
to cap the iowait boost and remove dependency with uclamp_rq_util_with()
which is not used anymore.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 29 ++++++++-------
 kernel/sched/sched.h             | 60 --------------------------------
 2 files changed, 14 insertions(+), 75 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index f3acf2cf26ed..4ee8ad70be99 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -169,11 +169,12 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 	return max(min, max);
 }
 
-static void sugov_get_util(struct sugov_cpu *sg_cpu)
+static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
 {
 	unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
 
 	util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
+	util = max(util, boost);
 	sg_cpu->bw_min = min;
 	sg_cpu->util = sugov_effective_cpu_perf(sg_cpu->cpu, util, min, max);
 }
@@ -266,18 +267,16 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
  * This mechanism is designed to boost high frequently IO waiting tasks, while
  * being more conservative on tasks which does sporadic IO operations.
  */
-static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
+static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 			       unsigned long max_cap)
 {
-	unsigned long boost;
-
 	/* No boost currently required */
 	if (!sg_cpu->iowait_boost)
-		return;
+		return 0;
 
 	/* Reset boost if the CPU appears to have been idle enough */
 	if (sugov_iowait_reset(sg_cpu, time, false))
-		return;
+		return 0;
 
 	if (!sg_cpu->iowait_boost_pending) {
 		/*
@@ -286,7 +285,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 		sg_cpu->iowait_boost >>= 1;
 		if (sg_cpu->iowait_boost < IOWAIT_BOOST_MIN) {
 			sg_cpu->iowait_boost = 0;
-			return;
+			return 0;
 		}
 	}
 
@@ -296,10 +295,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 	 * sg_cpu->util is already in capacity scale; convert iowait_boost
 	 * into the same scale so we can compare.
 	 */
-	boost = (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
-	boost = uclamp_rq_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
-	if (sg_cpu->util < boost)
-		sg_cpu->util = boost;
+	return (sg_cpu->iowait_boost * max_cap) >> SCHED_CAPACITY_SHIFT;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -329,6 +325,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 					      u64 time, unsigned long max_cap,
 					      unsigned int flags)
 {
+	unsigned long boost;
+
 	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
@@ -337,8 +335,8 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
 		return false;
 
-	sugov_get_util(sg_cpu);
-	sugov_iowait_apply(sg_cpu, time, max_cap);
+	boost = sugov_iowait_apply(sg_cpu, time, max_cap);
+	sugov_get_util(sg_cpu, boost);
 
 	return true;
 }
@@ -439,9 +437,10 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
+		unsigned long boost;
 
-		sugov_get_util(j_sg_cpu);
-		sugov_iowait_apply(j_sg_cpu, time, max_cap);
+		boost = sugov_iowait_apply(j_sg_cpu, time, max_cap);
+		sugov_get_util(j_sg_cpu, boost);
 
 		util = max(j_sg_cpu->util, util);
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c1574cd388e7..e58a54bda77d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3058,59 +3058,6 @@ static inline bool uclamp_rq_is_idle(struct rq *rq)
 	return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
 }
 
-/**
- * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
- * @rq:		The rq to clamp against. Must not be NULL.
- * @util:	The util value to clamp.
- * @p:		The task to clamp against. Can be NULL if you want to clamp
- *		against @rq only.
- *
- * Clamps the passed @util to the max(@rq, @p) effective uclamp values.
- *
- * If sched_uclamp_used static key is disabled, then just return the util
- * without any clamping since uclamp aggregation at the rq level in the fast
- * path is disabled, rendering this operation a NOP.
- *
- * Use uclamp_eff_value() if you don't care about uclamp values at rq level. It
- * will return the correct effective uclamp value of the task even if the
- * static key is disabled.
- */
-static __always_inline
-unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
-				  struct task_struct *p)
-{
-	unsigned long min_util = 0;
-	unsigned long max_util = 0;
-
-	if (!static_branch_likely(&sched_uclamp_used))
-		return util;
-
-	if (p) {
-		min_util = uclamp_eff_value(p, UCLAMP_MIN);
-		max_util = uclamp_eff_value(p, UCLAMP_MAX);
-
-		/*
-		 * Ignore last runnable task's max clamp, as this task will
-		 * reset it. Similarly, no need to read the rq's min clamp.
-		 */
-		if (uclamp_rq_is_idle(rq))
-			goto out;
-	}
-
-	min_util = max_t(unsigned long, min_util, uclamp_rq_get(rq, UCLAMP_MIN));
-	max_util = max_t(unsigned long, max_util, uclamp_rq_get(rq, UCLAMP_MAX));
-out:
-	/*
-	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
-	 * RUNNABLE tasks with _different_ clamps, we can end up with an
-	 * inversion. Fix it now when the clamps are applied.
-	 */
-	if (unlikely(min_util >= max_util))
-		return min_util;
-
-	return clamp(util, min_util, max_util);
-}
-
 /* Is the rq being capped/throttled by uclamp_max? */
 static inline bool uclamp_rq_is_capped(struct rq *rq)
 {
@@ -3148,13 +3095,6 @@ static inline unsigned long uclamp_eff_value(struct task_struct *p,
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline
-unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
-				  struct task_struct *p)
-{
-	return util;
-}
-
 static inline bool uclamp_rq_is_capped(struct rq *rq) { return false; }
 
 static inline bool uclamp_is_used(void)
-- 
2.34.1


