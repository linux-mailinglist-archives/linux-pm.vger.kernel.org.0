Return-Path: <linux-pm+bounces-9760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 642E0912692
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 15:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871671C21430
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 13:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253F4155723;
	Fri, 21 Jun 2024 13:22:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5E31EA80;
	Fri, 21 Jun 2024 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976169; cv=none; b=tbiS+cTLVisUIKomzMDMNZTpTHYKlRDylKxXkmsLPxHeBYZ6pwSB61L8z07zG0jV4wrULeEw+0RNx/Ct0AwsgS45kn02yMAPwTVEMv+IJkgq2q15roOTJXcaj5nQbtJuwCR7XOEktga4/hMn/0cbpS4mXNrCfroDJ2WCUfTUwF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976169; c=relaxed/simple;
	bh=f8Wd7tZhsoqiQNpFCzZytTUfL4ROwPtRxfGsxay1z/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVq5SETaBZLMuV8EFoFczbmWx7vvOrzOZhBaz9QFLcOdaewdrLXcCX/75PqICzrTSfzRIHSdTuqKnUlHqxJZNMY7GRky24vHU5YLsTSU0DA9tCr+SMhfdUd5Qj+xqfrIuscYChPlBB5K/sHQyfL5vYjm/dFSS7pRRxK7ygE/PEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA2EDDA7;
	Fri, 21 Jun 2024 06:23:10 -0700 (PDT)
Received: from [10.57.42.30] (unknown [10.57.42.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E5F13F73B;
	Fri, 21 Jun 2024 06:22:44 -0700 (PDT)
Message-ID: <0966aecc-0e3f-4c18-80ec-34c968556e95@arm.com>
Date: Fri, 21 Jun 2024 14:22:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCHv3 1/3] Revert: "cpuidle: teo: Introduce util-awareness"
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org
Cc: vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, ulf.hansson@linaro.org, anna-maria@linutronix.de,
 kajetan.puchalski@arm.com, lukasz.luba@arm.com, dietmar.eggemann@arm.com
References: <20240611112413.1241352-1-christian.loehle@arm.com>
 <20240611112413.1241352-2-christian.loehle@arm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240611112413.1241352-2-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This reverts commit 9ce0f7c4bc64d820b02a1c53f7e8dba9539f942b.

Util-awareness was reported to be too aggressive in selecting shallower
states. Additionally a single threshold was found to not be suitable
for reasoning about sleep length as, for all practical purposes,
almost arbitrary sleep lengths are still possible for any load value.

Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
Reported-by: Qais Yousef <qyousef@layalina.io>
Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
v3: Restore copyright header too and pick up tags

 drivers/cpuidle/governors/teo.c | 105 --------------------------------
 1 file changed, 105 deletions(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 7244f71c59c5..b6a8ba6772e1 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -2,13 +2,8 @@
 /*
  * Timer events oriented CPU idle governor
  *
- * TEO governor:
  * Copyright (C) 2018 - 2021 Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
- *
- * Util-awareness mechanism:
- * Copyright (C) 2022 Arm Ltd.
- * Author: Kajetan Puchalski <kajetan.puchalski@arm.com>
  */
 
 /**
@@ -104,56 +99,16 @@
  *      select the given idle state instead of the candidate one.
  *
  * 3. By default, select the candidate state.
- *
- * Util-awareness mechanism:
- *
- * The idea behind the util-awareness extension is that there are two distinct
- * scenarios for the CPU which should result in two different approaches to idle
- * state selection - utilized and not utilized.
- *
- * In this case, 'utilized' means that the average runqueue util of the CPU is
- * above a certain threshold.
- *
- * When the CPU is utilized while going into idle, more likely than not it will
- * be woken up to do more work soon and so a shallower idle state should be
- * selected to minimise latency and maximise performance. When the CPU is not
- * being utilized, the usual metrics-based approach to selecting the deepest
- * available idle state should be preferred to take advantage of the power
- * saving.
- *
- * In order to achieve this, the governor uses a utilization threshold.
- * The threshold is computed per-CPU as a percentage of the CPU's capacity
- * by bit shifting the capacity value. Based on testing, the shift of 6 (~1.56%)
- * seems to be getting the best results.
- *
- * Before selecting the next idle state, the governor compares the current CPU
- * util to the precomputed util threshold. If it's below, it defaults to the
- * TEO metrics mechanism. If it's above, the closest shallower idle state will
- * be selected instead, as long as is not a polling state.
  */
 
 #include <linux/cpuidle.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/sched/clock.h>
-#include <linux/sched/topology.h>
 #include <linux/tick.h>
 
 #include "gov.h"
 
-/*
- * The number of bits to shift the CPU's capacity by in order to determine
- * the utilized threshold.
- *
- * 6 was chosen based on testing as the number that achieved the best balance
- * of power and performance on average.
- *
- * The resulting threshold is high enough to not be triggered by background
- * noise and low enough to react quickly when activity starts to ramp up.
- */
-#define UTIL_THRESHOLD_SHIFT 6
-
 /*
  * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
  * is used for decreasing metrics on a regular basis.
@@ -188,7 +143,6 @@ struct teo_bin {
  * @next_recent_idx: Index of the next @recent_idx entry to update.
  * @recent_idx: Indices of bins corresponding to recent "intercepts".
  * @tick_hits: Number of "hits" after TICK_NSEC.
- * @util_threshold: Threshold above which the CPU is considered utilized
  */
 struct teo_cpu {
 	s64 time_span_ns;
@@ -198,28 +152,10 @@ struct teo_cpu {
 	int next_recent_idx;
 	int recent_idx[NR_RECENT];
 	unsigned int tick_hits;
-	unsigned long util_threshold;
 };
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
 
-/**
- * teo_cpu_is_utilized - Check if the CPU's util is above the threshold
- * @cpu: Target CPU
- * @cpu_data: Governor CPU data for the target CPU
- */
-#ifdef CONFIG_SMP
-static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
-{
-	return sched_cpu_util(cpu) > cpu_data->util_threshold;
-}
-#else
-static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
-{
-	return false;
-}
-#endif
-
 /**
  * teo_update - Update CPU metrics after wakeup.
  * @drv: cpuidle driver containing state data.
@@ -386,7 +322,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
 	bool alt_intercepts, alt_recent;
-	bool cpu_utilized;
 	s64 duration_ns;
 	int i;
 
@@ -411,32 +346,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	if (!dev->states_usage[0].disable)
 		idx = 0;
 
-	cpu_utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
-	/*
-	 * If the CPU is being utilized over the threshold and there are only 2
-	 * states to choose from, the metrics need not be considered, so choose
-	 * the shallowest non-polling state and exit.
-	 */
-	if (drv->state_count < 3 && cpu_utilized) {
-		/*
-		 * If state 0 is enabled and it is not a polling one, select it
-		 * right away unless the scheduler tick has been stopped, in
-		 * which case care needs to be taken to leave the CPU in a deep
-		 * enough state in case it is not woken up any time soon after
-		 * all.  If state 1 is disabled, though, state 0 must be used
-		 * anyway.
-		 */
-		if ((!idx && !(drv->states[0].flags & CPUIDLE_FLAG_POLLING) &&
-		    teo_state_ok(0, drv)) || dev->states_usage[1].disable) {
-			idx = 0;
-			goto out_tick;
-		}
-		/* Assume that state 1 is not a polling one and use it. */
-		idx = 1;
-		duration_ns = drv->states[1].target_residency_ns;
-		goto end;
-	}
-
 	/* Compute the sums of metrics for early wakeup pattern detection. */
 	for (i = 1; i < drv->state_count; i++) {
 		struct teo_bin *prev_bin = &cpu_data->state_bins[i-1];
@@ -560,18 +469,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	if (idx > constraint_idx)
 		idx = constraint_idx;
 
-	/*
-	 * If the CPU is being utilized over the threshold, choose a shallower
-	 * non-polling state to improve latency, unless the scheduler tick has
-	 * been stopped already and the shallower state's target residency is
-	 * not sufficiently large.
-	 */
-	if (cpu_utilized) {
-		i = teo_find_shallower_state(drv, dev, idx, KTIME_MAX, true);
-		if (teo_state_ok(i, drv))
-			idx = i;
-	}
-
 	/*
 	 * Skip the timers check if state 0 is the current candidate one,
 	 * because an immediate non-timer wakeup is expected in that case.
@@ -667,11 +564,9 @@ static int teo_enable_device(struct cpuidle_driver *drv,
 			     struct cpuidle_device *dev)
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
-	unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
 	int i;
 
 	memset(cpu_data, 0, sizeof(*cpu_data));
-	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
 
 	for (i = 0; i < NR_RECENT; i++)
 		cpu_data->recent_idx[i] = -1;
-- 
2.34.1

