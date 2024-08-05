Return-Path: <linux-pm+bounces-11920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4363947D59
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 16:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2331F22270
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FAF13C827;
	Mon,  5 Aug 2024 14:58:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A213C67E;
	Mon,  5 Aug 2024 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869897; cv=none; b=j7ueIIzzFMjco/AewjUUYOXSVBnCivK8qWGDyxMT8lopJvNHc2mFddUq1bBLvmwCXOHrw5reLAT0RR25hlSn9nwrJza6FFoFEn4h1tbxu/6FL3Q2GYKg7Yb7cSJF7s5VQGgmmxGmDGlG5ugbP5F2pRXjqucAYEh09n8Wp5HNUfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869897; c=relaxed/simple;
	bh=f6oj3279yYwJLfqBf7SnOcMGsAOqP80sDhzbCu3c6Aw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u7dYrCEecQTuJoC5eU3+ttHUwABWvcj4ne56BRaoe8cgxX6/Tyhqi1W83ftan87ShFL8eNua4n88pLhc/mUO3vgkUNQU+ylrBpvo5uzjvsa39zmfjTY6Yqu1+zYWQOlGtQcQkVOgwbJrkiovrYkunJpCMDi72bUflNuOjTbcNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66A8A106F;
	Mon,  5 Aug 2024 07:58:40 -0700 (PDT)
Received: from [10.1.25.54] (e127648.arm.com [10.1.25.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEDBC3F6A8;
	Mon,  5 Aug 2024 07:58:11 -0700 (PDT)
Message-ID: <181bb5c2-5790-41bf-9ed8-3d3164b8697d@arm.com>
Date: Mon, 5 Aug 2024 15:58:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6.1.y] cpuidle: teo: Remove recent intercepts metric
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, stable@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org,
 daniel.lezcano@linaro.org, ulf.hansson@linaro.org, anna-maria@linutronix.de,
 dsmythies@telus.net, kajetan.puchalski@arm.com, lukasz.luba@arm.com,
 dietmar.eggemann@arm.com
References: <20240628095955.34096-1-christian.loehle@arm.com>
 <CAJZ5v0jPyy0HgtQcSt=7ZO-khSGex2uAxL1x6HZFkFbvpbxcmA@mail.gmail.com>
 <9bbf6989-f41f-4533-a7c8-b274744663cd@arm.com>
Content-Language: en-US
In-Reply-To: <9bbf6989-f41f-4533-a7c8-b274744663cd@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

commit 449914398083148f93d070a8aace04f9ec296ce3 upstream.

The logic for recent intercepts didn't work, there is an underflow
of the 'recent' value that can be observed during boot already, which
teo usually doesn't recover from, making the entire logic pointless.
Furthermore the recent intercepts also were never reset, thus not
actually being very 'recent'.

Having underflowed 'recent' values lead to teo always acting as if
we were in a scenario were expected sleep length based on timers is
too high and it therefore unnecessarily selecting shallower states.

Experiments show that the remaining 'intercept' logic is enough to
quickly react to scenarios in which teo cannot rely on the timer
expected sleep length.

See also here:
https://lore.kernel.org/lkml/0ce2d536-1125-4df8-9a5b-0d5e389cd8af@arm.com/

Fixes: 77577558f25d ("cpuidle: teo: Rework most recent idle duration values treatment")
Link: https://patch.msgid.link/20240628095955.34096-3-christian.loehle@arm.com
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c | 79 ++++++---------------------------
 1 file changed, 14 insertions(+), 65 deletions(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index d9262db79cae..65475526bb11 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -54,16 +54,12 @@
  * shallower than the one whose bin is fallen into by the sleep length (these
  * situations are referred to as "intercepts" below).
  *
- * In addition to the metrics described above, the governor counts recent
- * intercepts (that is, intercepts that have occurred during the last
- * %NR_RECENT invocations of it for the given CPU) for each bin.
- *
  * In order to select an idle state for a CPU, the governor takes the following
  * steps (modulo the possible latency constraint that must be taken into account
  * too):
  *
  * 1. Find the deepest CPU idle state whose target residency does not exceed
- *    the current sleep length (the candidate idle state) and compute 3 sums as
+ *    the current sleep length (the candidate idle state) and compute 2 sums as
  *    follows:
  *
  *    - The sum of the "hits" and "intercepts" metrics for the candidate state
@@ -76,20 +72,15 @@
  *      idle long enough to avoid being intercepted if the sleep length had been
  *      equal to the current one).
  *
- *    - The sum of the numbers of recent intercepts for all of the idle states
- *      shallower than the candidate one.
- *
- * 2. If the second sum is greater than the first one or the third sum is
- *    greater than %NR_RECENT / 2, the CPU is likely to wake up early, so look
- *    for an alternative idle state to select.
+ * 2. If the second sum is greater than the first one the CPU is likely to wake
+ *    up early, so look for an alternative idle state to select.
  *
  *    - Traverse the idle states shallower than the candidate one in the
  *      descending order.
  *
- *    - For each of them compute the sum of the "intercepts" metrics and the sum
- *      of the numbers of recent intercepts over all of the idle states between
- *      it and the candidate one (including the former and excluding the
- *      latter).
+ *    - For each of them compute the sum of the "intercepts" metrics over all
+ *      of the idle states between it and the candidate one (including the
+ *      former and excluding the latter).
  *
  *    - If each of these sums that needs to be taken into account (because the
  *      check related to it has indicated that the CPU is likely to wake up
@@ -114,22 +105,14 @@
 #define PULSE		1024
 #define DECAY_SHIFT	3
 
-/*
- * Number of the most recent idle duration values to take into consideration for
- * the detection of recent early wakeup patterns.
- */
-#define NR_RECENT	9
-
 /**
  * struct teo_bin - Metrics used by the TEO cpuidle governor.
  * @intercepts: The "intercepts" metric.
  * @hits: The "hits" metric.
- * @recent: The number of recent "intercepts".
  */
 struct teo_bin {
 	unsigned int intercepts;
 	unsigned int hits;
-	unsigned int recent;
 };
 
 /**
@@ -137,17 +120,13 @@ struct teo_bin {
  * @time_span_ns: Time between idle state selection and post-wakeup update.
  * @sleep_length_ns: Time till the closest timer event (at the selection time).
  * @state_bins: Idle state data bins for this CPU.
- * @total: Grand total of the "intercepts" and "hits" mertics for all bins.
- * @next_recent_idx: Index of the next @recent_idx entry to update.
- * @recent_idx: Indices of bins corresponding to recent "intercepts".
+ * @total: Grand total of the "intercepts" and "hits" metrics for all bins.
  */
 struct teo_cpu {
 	s64 time_span_ns;
 	s64 sleep_length_ns;
 	struct teo_bin state_bins[CPUIDLE_STATE_MAX];
 	unsigned int total;
-	int next_recent_idx;
-	int recent_idx[NR_RECENT];
 };
 
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
@@ -216,27 +195,16 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		}
 	}
 
-	i = cpu_data->next_recent_idx++;
-	if (cpu_data->next_recent_idx >= NR_RECENT)
-		cpu_data->next_recent_idx = 0;
-
-	if (cpu_data->recent_idx[i] >= 0)
-		cpu_data->state_bins[cpu_data->recent_idx[i]].recent--;
-
 	/*
 	 * If the measured idle duration falls into the same bin as the sleep
 	 * length, this is a "hit", so update the "hits" metric for that bin.
 	 * Otherwise, update the "intercepts" metric for the bin fallen into by
 	 * the measured idle duration.
 	 */
-	if (idx_timer == idx_duration) {
+	if (idx_timer == idx_duration)
 		cpu_data->state_bins[idx_timer].hits += PULSE;
-		cpu_data->recent_idx[i] = -1;
-	} else {
+	else
 		cpu_data->state_bins[idx_duration].intercepts += PULSE;
-		cpu_data->state_bins[idx_duration].recent++;
-		cpu_data->recent_idx[i] = idx_duration;
-	}
 
 	cpu_data->total += PULSE;
 }
@@ -289,13 +257,10 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	unsigned int idx_intercept_sum = 0;
 	unsigned int intercept_sum = 0;
-	unsigned int idx_recent_sum = 0;
-	unsigned int recent_sum = 0;
 	unsigned int idx_hit_sum = 0;
 	unsigned int hit_sum = 0;
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
-	bool alt_intercepts, alt_recent;
 	ktime_t delta_tick;
 	s64 duration_ns;
 	int i;
@@ -338,7 +303,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 */
 		intercept_sum += prev_bin->intercepts;
 		hit_sum += prev_bin->hits;
-		recent_sum += prev_bin->recent;
 
 		if (dev->states_usage[i].disable)
 			continue;
@@ -358,7 +322,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 		idx_intercept_sum = intercept_sum;
 		idx_hit_sum = hit_sum;
-		idx_recent_sum = recent_sum;
 	}
 
 	/* Avoid unnecessary overhead. */
@@ -373,42 +336,32 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * If the sum of the intercepts metric for all of the idle states
 	 * shallower than the current candidate one (idx) is greater than the
 	 * sum of the intercepts and hits metrics for the candidate state and
-	 * all of the deeper states, or the sum of the numbers of recent
-	 * intercepts over all of the states shallower than the candidate one
-	 * is greater than a half of the number of recent events taken into
-	 * account, the CPU is likely to wake up early, so find an alternative
-	 * idle state to select.
+	 * all of the deeper states a shallower idle state is likely to be a
+	 * better choice.
 	 */
-	alt_intercepts = 2 * idx_intercept_sum > cpu_data->total - idx_hit_sum;
-	alt_recent = idx_recent_sum > NR_RECENT / 2;
-	if (alt_recent || alt_intercepts) {
+	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
 		s64 first_suitable_span_ns = duration_ns;
 		int first_suitable_idx = idx;
 
 		/*
 		 * Look for the deepest idle state whose target residency had
 		 * not exceeded the idle duration in over a half of the relevant
-		 * cases (both with respect to intercepts overall and with
-		 * respect to the recent intercepts only) in the past.
+		 * cases in the past.
 		 *
 		 * Take the possible latency constraint and duration limitation
 		 * present if the tick has been stopped already into account.
 		 */
 		intercept_sum = 0;
-		recent_sum = 0;
 
 		for (i = idx - 1; i >= 0; i--) {
 			struct teo_bin *bin = &cpu_data->state_bins[i];
 			s64 span_ns;
 
 			intercept_sum += bin->intercepts;
-			recent_sum += bin->recent;
 
 			span_ns = teo_middle_of_bin(i, drv);
 
-			if ((!alt_recent || 2 * recent_sum > idx_recent_sum) &&
-			    (!alt_intercepts ||
-			     2 * intercept_sum > idx_intercept_sum)) {
+			if (2 * intercept_sum > idx_intercept_sum) {
 				if (teo_time_ok(span_ns) &&
 				    !dev->states_usage[i].disable) {
 					idx = i;
@@ -508,13 +461,9 @@ static int teo_enable_device(struct cpuidle_driver *drv,
 			     struct cpuidle_device *dev)
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
-	int i;
 
 	memset(cpu_data, 0, sizeof(*cpu_data));
 
-	for (i = 0; i < NR_RECENT; i++)
-		cpu_data->recent_idx[i] = -1;
-
 	return 0;
 }
 
-- 
2.34.1


