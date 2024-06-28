Return-Path: <linux-pm+bounces-10184-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896F391BC1C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 12:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4971C21BF8
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128E4153578;
	Fri, 28 Jun 2024 10:02:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0391553AA;
	Fri, 28 Jun 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568937; cv=none; b=SZ8iiM9ZG49EDNdLvkI4yzbBgzxIKhBdlo7yIui1/wTupy1EQjvxA6vbuUUgHYyghG+2/md/SmG/vTjsdyqg58XFvFw1Az5SQPJi72g17J8mAMUTOSPj77TTC3K9n+8x7RNNsIIylY6VH9Q9D0gngEjLoW5PNepM02gykAc8N8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568937; c=relaxed/simple;
	bh=qiVrANxih+JYVVUbbsDyeEiFtMWlVRdPEHzp/AFLtbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZbGcSLWQcyeYHdUFh/H1IZdtCLcDMe3rYUEDsvOPL+a6lfhK1RUNjolfai1c1vZu4Mgd+SiZn8CJqfcJwoW2v5RNZac5zMmpDalYklpWPDwDbm/DLmieAcP+dKVXPBYe09CkDMz1YGVwGNpVHqaMNc1+huDrrC5/KlBRT6GaTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F1C0106F;
	Fri, 28 Jun 2024 03:02:39 -0700 (PDT)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.1.30.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D26033F6A8;
	Fri, 28 Jun 2024 03:02:11 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: vincent.guittot@linaro.org,
	qyousef@layalina.io,
	peterz@infradead.org,
	daniel.lezcano@linaro.org,
	ulf.hansson@linaro.org,
	anna-maria@linutronix.de,
	dsmythies@telus.net,
	kajetan.puchalski@arm.com,
	lukasz.luba@arm.com,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 2/3] cpuidle: teo: Remove recent intercepts metric
Date: Fri, 28 Jun 2024 10:59:54 +0100
Message-Id: <20240628095955.34096-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628095955.34096-1-christian.loehle@arm.com>
References: <20240628095955.34096-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpuidle/governors/teo.c | 76 ++++++---------------------------
 1 file changed, 13 insertions(+), 63 deletions(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index b6a8ba6772e1..200a3598cbcf 100644
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
@@ -116,22 +107,14 @@
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
@@ -140,8 +123,6 @@ struct teo_bin {
  * @sleep_length_ns: Time till the closest timer event (at the selection time).
  * @state_bins: Idle state data bins for this CPU.
  * @total: Grand total of the "intercepts" and "hits" metrics for all bins.
- * @next_recent_idx: Index of the next @recent_idx entry to update.
- * @recent_idx: Indices of bins corresponding to recent "intercepts".
  * @tick_hits: Number of "hits" after TICK_NSEC.
  */
 struct teo_cpu {
@@ -149,8 +130,6 @@ struct teo_cpu {
 	s64 sleep_length_ns;
 	struct teo_bin state_bins[CPUIDLE_STATE_MAX];
 	unsigned int total;
-	int next_recent_idx;
-	int recent_idx[NR_RECENT];
 	unsigned int tick_hits;
 };
 
@@ -222,13 +201,6 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
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
 	 * If the deepest state's target residency is below the tick length,
 	 * make a record of it to help teo_select() decide whether or not
@@ -255,14 +227,10 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
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
 
 end:
 	cpu_data->total += PULSE;
@@ -315,13 +283,10 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int tick_intercept_sum = 0;
 	unsigned int idx_intercept_sum = 0;
 	unsigned int intercept_sum = 0;
-	unsigned int idx_recent_sum = 0;
-	unsigned int recent_sum = 0;
 	unsigned int idx_hit_sum = 0;
 	unsigned int hit_sum = 0;
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
-	bool alt_intercepts, alt_recent;
 	s64 duration_ns;
 	int i;
 
@@ -357,7 +322,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 */
 		intercept_sum += prev_bin->intercepts;
 		hit_sum += prev_bin->hits;
-		recent_sum += prev_bin->recent;
 
 		if (dev->states_usage[i].disable)
 			continue;
@@ -373,7 +337,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		/* Save the sums for the current state. */
 		idx_intercept_sum = intercept_sum;
 		idx_hit_sum = hit_sum;
-		idx_recent_sum = recent_sum;
 	}
 
 	/* Avoid unnecessary overhead. */
@@ -398,37 +361,28 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	 * If the sum of the intercepts metric for all of the idle states
 	 * shallower than the current candidate one (idx) is greater than the
 	 * sum of the intercepts and hits metrics for the candidate state and
-	 * all of the deeper states, or the sum of the numbers of recent
-	 * intercepts over all of the states shallower than the candidate one
-	 * is greater than a half of the number of recent events taken into
-	 * account, a shallower idle state is likely to be a better choice.
+	 * all of the deeper states a shallower idle state is likely to be a
+	 * better choice.
 	 */
-	alt_intercepts = 2 * idx_intercept_sum > cpu_data->total - idx_hit_sum;
-	alt_recent = idx_recent_sum > NR_RECENT / 2;
-	if (alt_recent || alt_intercepts) {
+	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
 		int first_suitable_idx = idx;
 
 		/*
 		 * Look for the deepest idle state whose target residency had
 		 * not exceeded the idle duration in over a half of the relevant
-		 * cases (both with respect to intercepts overall and with
-		 * respect to the recent intercepts only) in the past.
+		 * cases in the past.
 		 *
 		 * Take the possible duration limitation present if the tick
 		 * has been stopped already into account.
 		 */
 		intercept_sum = 0;
-		recent_sum = 0;
 
 		for (i = idx - 1; i >= 0; i--) {
 			struct teo_bin *bin = &cpu_data->state_bins[i];
 
 			intercept_sum += bin->intercepts;
-			recent_sum += bin->recent;
 
-			if ((!alt_recent || 2 * recent_sum > idx_recent_sum) &&
-			    (!alt_intercepts ||
-			     2 * intercept_sum > idx_intercept_sum)) {
+			if (2 * intercept_sum > idx_intercept_sum) {
 				/*
 				 * Use the current state unless it is too
 				 * shallow or disabled, in which case take the
@@ -564,13 +518,9 @@ static int teo_enable_device(struct cpuidle_driver *drv,
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


