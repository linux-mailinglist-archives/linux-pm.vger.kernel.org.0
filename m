Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD434399260
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 20:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhFBSUi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 14:20:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47146 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFBSUh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 14:20:37 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.5)
 id 8222830f74e83cdf; Wed, 2 Jun 2021 20:18:52 +0200
Received: from kreacher.localnet (89-64-80-45.dynamic.chello.pl [89.64.80.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D4D9B6697FA;
        Wed,  2 Jun 2021 20:18:51 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/5] cpuidle: teo: Change the main idle state selection logic
Date:   Wed, 02 Jun 2021 20:16:32 +0200
Message-ID: <3055244.5fSG56mABF@kreacher>
In-Reply-To: <1867445.PYKUYFuaPT@kreacher>
References: <1867445.PYKUYFuaPT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.64.80.45
X-CLIENT-HOSTNAME: 89-64-80-45.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrvdeljedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppeekledrieegrdektddrgeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdeigedrkedtrdeghedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=2 Fuz1=2 Fuz2=2
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Two aspects of the current main idle state selection logic in the
TEO (Timer Events Oriented) cpuidle governor are quite questionable.

First of all, the "hits" and "misses" metrics used by it are only
updated for a given idle state if the time till the next timer event
("sleep length") is between the target residency of that state and
the target residency of the next one.  Consequently, they are likely
to become stale if the sleep length tends to fall outside that
interval which increases the likelihood of subomtimal idle state
selection.

Second, the decision on whether or not to select the idle state
"matching" the sleep length is based on the metrics collected for
that state alone, whereas in principle the metrics collected for
the other idle states should be taken into consideration when that
decision is made.  For example, if the measured idle duration is less
than the target residency of the idle state "matching" the sleep
length, then it is also less than the target residency of any deeper
idle state and that should be taken into account when considering
whether or not to select any of those states, but currently it is
not.

In order to address the above shortcomings, modify the main idle
state selection logic in the TEO governor to take the metrics
collected for all of the idle states into account when deciding
whether or not to select the one "matching" the sleep length.

Moreover, drop the "misses" metric that becomes redundant after the
above change and rename the "early_hits" metric to "intercepts" so
that its role is better reflected by its name (the idea being that
if a CPU wakes up earlier than indicated by the sleep length, then
it must be a result of a non-timer interrupt that "intercepts" the
CPU).

Also rename the states[] array in struct struct teo_cpu to
state_bins[] to avoid confusing it with the states[] array in
struct cpuidle_driver and update the documentation to match the
new code (and make it more comprehensive while at it).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |  380 +++++++++++++++++++++-------------------
 1 file changed, 206 insertions(+), 174 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/teo.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/teo.c
+++ linux-pm/drivers/cpuidle/governors/teo.c
@@ -2,47 +2,90 @@
 /*
  * Timer events oriented CPU idle governor
  *
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2021 Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  *
  * The idea of this governor is based on the observation that on many systems
  * timer events are two or more orders of magnitude more frequent than any
- * other interrupts, so they are likely to be the most significant source of CPU
+ * other interrupts, so they are likely to be the most significant cause of CPU
  * wakeups from idle states.  Moreover, information about what happened in the
  * (relatively recent) past can be used to estimate whether or not the deepest
- * idle state with target residency within the time to the closest timer is
- * likely to be suitable for the upcoming idle time of the CPU and, if not, then
- * which of the shallower idle states to choose.
- *
- * Of course, non-timer wakeup sources are more important in some use cases and
- * they can be covered by taking a few most recent idle time intervals of the
- * CPU into account.  However, even in that case it is not necessary to consider
- * idle duration values greater than the time till the closest timer, as the
- * patterns that they may belong to produce average values close enough to
- * the time till the closest timer (sleep length) anyway.
- *
- * Thus this governor estimates whether or not the upcoming idle time of the CPU
- * is likely to be significantly shorter than the sleep length and selects an
- * idle state for it in accordance with that, as follows:
- *
- * - Find an idle state on the basis of the sleep length and state statistics
- *   collected over time:
- *
- *   o Find the deepest idle state whose target residency is less than or equal
- *     to the sleep length.
- *
- *   o Select it if it matched both the sleep length and the observed idle
- *     duration in the past more often than it matched the sleep length alone
- *     (i.e. the observed idle duration was significantly shorter than the sleep
- *     length matched by it).
- *
- *   o Otherwise, select the shallower state with the greatest matched "early"
- *     wakeups metric.
- *
- * - If the majority of the most recent idle duration values are below the
- *   target residency of the idle state selected so far, use those values to
- *   compute the new expected idle duration and find an idle state matching it
- *   (which has to be shallower than the one selected so far).
+ * idle state with target residency within the (known) time till the closest
+ * timer event, referred to as the sleep length, is likely to be suitable for
+ * the upcoming CPU idle period and, if not, then which of the shallower idle
+ * states to choose instead of it.
+ *
+ * Of course, non-timer wakeup sources are more important in some use cases
+ * which can be covered by taking a few most recent idle time intervals of the
+ * CPU into account.  However, even in that context it is not necessary to
+ * consider idle duration values greater than the sleep length, because the
+ * closest timer will ultimately wake up the CPU anyway unless it is woken up
+ * earlier.
+ *
+ * Thus this governor estimates whether or not the prospective idle duration of
+ * a CPU is likely to be significantly shorter than the sleep length and selects
+ * an idle state for it accordingly.
+ *
+ * The computations carried out by this governor are based on using bins whose
+ * boundaries are aligned with the target residency parameter values of the CPU
+ * idle states provided by the cpuidle driver in the ascending order.  That is,
+ * the first bin spans from 0 up to, but not including, the target residency of
+ * the second idle state (idle state 1), the second bin spans from the target
+ * residency of idle state 1 up to, but not including, the target residency of
+ * idle state 2, the third bin spans from the target residency of idle state 2
+ * up to, but not including, the target residency of idle state 3 and so on.
+ * The last bin spans from the target residency of the deepest idle state
+ * supplied by the driver to infinity.
+ *
+ * Two metrics called "hits" and "intercepts" are associated with each bin.
+ * They are updated every time before selecting an idle state for the given CPU
+ * in accordance with what happened last time.
+ *
+ * The "hits" metric reflects the relative frequency of situations in which the
+ * sleep length and the idle duration measured after CPU wakeup fall into the
+ * same bin (that is, the CPU appears to wake up "on time" relative to the sleep
+ * length).  In turn, the "intercepts" metric reflects the relative frequency of
+ * situations in which the measured idle duration is so much shorter than the
+ * sleep length that the bin it falls into corresponds to an idle state
+ * shallower than the one whose bin is fallen into by the sleep length.
+ *
+ * In order to select an idle state for a CPU, the governor takes the following
+ * steps (modulo the possible latency constraint that must be taken into account
+ * too):
+ *
+ * 1. Find the deepest CPU idle state whose target residency does not exceed
+ *    the current sleep length (the candidate idle state) and compute two sums
+ *    as follows:
+ *
+ *    - The sum of the "hits" and "intercepts" metrics for the candidate state
+ *      and all of the deeper idle states (it represents the cases in which the
+ *      CPU was idle long enough to avoid being intercepted if the sleep length
+ *      had been equal to the current one).
+ *
+ *    - The sum of the "intercepts" metrics for all of the idle states shallower
+ *      than the candidate one (it represents the cases in which the CPU was not
+ *      idle long enough to avoid being intercepted if the sleep length had been
+ *      equal to the current one).
+ *
+ * 2. If the second sum is greater than the first one, look for an alternative
+ *    idle state to select.
+ *
+ *    - Traverse the idle states shallower than the candidate one in the
+ *      descending order.
+ *
+ *    - For each of them compute the sum of the "intercepts" metrics over all of
+ *      the idle  states between it and the candidate one (including the former
+ *      and excluding the latter).
+ *
+ *    - If that sum is greater than a half of the second sum computed in step 1
+ *      (which means that the target residency of the state in question had not
+ *      exceeded the idle duration in over a half of the relevant cases), select
+ *      the given idle state instead of the candidate one.
+ *
+ * 3. If the majority of the most recent idle duration values are below the
+ *    current anticipated idle duration, use those values to compute the new
+ *    expected idle duration and find an idle state matching it (which has to
+ *    be shallower than the current candidate one).
  */
 
 #include <linux/cpuidle.h>
@@ -65,44 +108,29 @@
 #define INTERVALS	8
 
 /**
- * struct teo_idle_state - Idle state data used by the TEO cpuidle governor.
- * @early_hits: "Early" CPU wakeups "matching" this state.
- * @hits: "On time" CPU wakeups "matching" this state.
- * @misses: CPU wakeups "missing" this state.
- *
- * A CPU wakeup is "matched" by a given idle state if the idle duration measured
- * after the wakeup is between the target residency of that state and the target
- * residency of the next one (or if this is the deepest available idle state, it
- * "matches" a CPU wakeup when the measured idle duration is at least equal to
- * its target residency).
- *
- * Also, from the TEO governor perspective, a CPU wakeup from idle is "early" if
- * it occurs significantly earlier than the closest expected timer event (that
- * is, early enough to match an idle state shallower than the one matching the
- * time till the closest timer event).  Otherwise, the wakeup is "on time", or
- * it is a "hit".
- *
- * A "miss" occurs when the given state doesn't match the wakeup, but it matches
- * the time till the closest timer event used for idle state selection.
+ * struct teo_bin - Metrics used by the TEO cpuidle governor.
+ * @intercepts: The "intercepts" metric.
+ * @hits: The "hits" metric.
  */
-struct teo_idle_state {
-	unsigned int early_hits;
+struct teo_bin {
+	unsigned int intercepts;
 	unsigned int hits;
-	unsigned int misses;
 };
 
 /**
  * struct teo_cpu - CPU data used by the TEO cpuidle governor.
  * @time_span_ns: Time between idle state selection and post-wakeup update.
  * @sleep_length_ns: Time till the closest timer event (at the selection time).
- * @states: Idle states data corresponding to this CPU.
+ * @state_bins: Idle state data bins for this CPU.
+ * @total: Grand total of the "intercepts" and "hits" mertics for all bins.
  * @interval_idx: Index of the most recent saved idle interval.
  * @intervals: Saved idle duration values.
  */
 struct teo_cpu {
 	s64 time_span_ns;
 	s64 sleep_length_ns;
-	struct teo_idle_state states[CPUIDLE_STATE_MAX];
+	struct teo_bin state_bins[CPUIDLE_STATE_MAX];
+	unsigned int total;
 	int interval_idx;
 	u64 intervals[INTERVALS];
 };
@@ -110,7 +138,7 @@ struct teo_cpu {
 static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
 
 /**
- * teo_update - Update CPU data after wakeup.
+ * teo_update - Update CPU metrics after wakeup.
  * @drv: cpuidle driver containing state data.
  * @dev: Target CPU.
  */
@@ -118,7 +146,6 @@ static void teo_update(struct cpuidle_dr
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	int i, idx_timer = 0, idx_duration = 0;
-	unsigned int hits, misses;
 	u64 measured_ns;
 
 	if (cpu_data->time_span_ns >= cpu_data->sleep_length_ns) {
@@ -151,15 +178,21 @@ static void teo_update(struct cpuidle_dr
 			measured_ns /= 2;
 	}
 
+	cpu_data->total = 0;
+
 	/*
-	 * Decay the "early hits" metric for all of the states and find the
-	 * states matching the sleep length and the measured idle duration.
+	 * Decay the "hits" and "intercepts" metrics for all of the bins and
+	 * find the bins that the sleep length and the measured idle duration
+	 * fall into.
 	 */
 	for (i = 0; i < drv->state_count; i++) {
 		s64 target_residency_ns = drv->states[i].target_residency_ns;
-		unsigned int early_hits = cpu_data->states[i].early_hits;
+		struct teo_bin *bin = &cpu_data->state_bins[i];
 
-		cpu_data->states[i].early_hits -= early_hits >> DECAY_SHIFT;
+		bin->hits -= bin->hits >> DECAY_SHIFT;
+		bin->intercepts -= bin->intercepts >> DECAY_SHIFT;
+
+		cpu_data->total += bin->hits + bin->intercepts;
 
 		if (target_residency_ns <= cpu_data->sleep_length_ns) {
 			idx_timer = i;
@@ -169,28 +202,17 @@ static void teo_update(struct cpuidle_dr
 	}
 
 	/*
-	 * Update the "hits" and "misses" data for the state matching the sleep
-	 * length.  If it matches the measured idle duration too, this is a hit,
-	 * so increase the "hits" metric for it then.  Otherwise, this is a
-	 * miss, so increase the "misses" metric for it.  In the latter case
-	 * also increase the "early hits" metric for the state that actually
-	 * matches the measured idle duration.
+	 * If the measured idle duration falls into the same bin as the sleep
+	 * length, this is a "hit", so update the "hits" metric for that bin.
+	 * Otherwise, update the "intercepts" metric for the bin fallen into by
+	 * the measured idle duration.
 	 */
-	hits = cpu_data->states[idx_timer].hits;
-	hits -= hits >> DECAY_SHIFT;
-
-	misses = cpu_data->states[idx_timer].misses;
-	misses -= misses >> DECAY_SHIFT;
-
-	if (idx_timer == idx_duration) {
-		hits += PULSE;
-	} else {
-		misses += PULSE;
-		cpu_data->states[idx_duration].early_hits += PULSE;
-	}
+	if (idx_timer == idx_duration)
+		cpu_data->state_bins[idx_timer].hits += PULSE;
+	else
+		cpu_data->state_bins[idx_duration].intercepts += PULSE;
 
-	cpu_data->states[idx_timer].misses = misses;
-	cpu_data->states[idx_timer].hits = hits;
+	cpu_data->total += PULSE;
 
 	/*
 	 * Save idle duration values corresponding to non-timer wakeups for
@@ -206,6 +228,12 @@ static bool teo_time_ok(u64 interval_ns)
 	return !tick_nohz_tick_stopped() || interval_ns >= TICK_NSEC;
 }
 
+static s64 teo_middle_of_bin(int idx, struct cpuidle_driver *drv)
+{
+	return (drv->states[idx].target_residency_ns +
+		drv->states[idx+1].target_residency_ns) / 2;
+}
+
 /**
  * teo_find_shallower_state - Find shallower idle state matching given duration.
  * @drv: cpuidle driver containing state data.
@@ -241,12 +269,12 @@ static int teo_select(struct cpuidle_dri
 {
 	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
-	int constraint_idx = drv->state_count;
-	unsigned int hits = 0, misses = 0;
-	unsigned int early_hits = 0;
-	int prev_max_early_idx = -1;
-	int max_early_idx = -1;
-	int idx0 = -1, idx = -1;
+	unsigned int idx_intercept_sum = 0;
+	unsigned int intercept_sum = 0;
+	unsigned int idx_hit_sum = 0;
+	unsigned int hit_sum = 0;
+	int constraint_idx = 0;
+	int idx0 = 0, idx = -1;
 	ktime_t delta_tick;
 	s64 duration_ns;
 	int i;
@@ -261,119 +289,122 @@ static int teo_select(struct cpuidle_dri
 	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
 	cpu_data->sleep_length_ns = duration_ns;
 
-	for (i = 0; i < drv->state_count; i++) {
-		struct cpuidle_state *s = &drv->states[i];
-
-		if (dev->states_usage[i].disable) {
-			/*
-			 * Ignore disabled states with target residencies beyond
-			 * the anticipated idle duration.
-			 */
-			if (s->target_residency_ns > duration_ns)
-				continue;
-
-			/*
-			 * This state is disabled, so the range of idle duration
-			 * values corresponding to it is covered by the current
-			 * candidate state, but still the "hits" and "misses"
-			 * metrics of the disabled state need to be used to
-			 * decide whether or not the state covering the range in
-			 * question is good enough.
-			 */
-			hits = cpu_data->states[i].hits;
-			misses = cpu_data->states[i].misses;
-
-			if (early_hits >= cpu_data->states[i].early_hits ||
-			    idx < 0)
-				continue;
+	/* Check if there is any choice in the first place. */
+	if (drv->state_count < 2) {
+		idx = 0;;
+		goto end;
+	}
+	if (!dev->states_usage[0].disable) {
+		idx = 0;
+		if (drv->states[1].target_residency_ns > duration_ns)
+			goto end;
+	}
 
-			/*
-			 * If the current candidate state has been the one with
-			 * the maximum "early hits" metric so far, the "early
-			 * hits" metric of the disabled state replaces the
-			 * current "early hits" count to avoid selecting a
-			 * deeper state with lower "early hits" metric.
-			 */
-			if (max_early_idx == idx) {
-				early_hits = cpu_data->states[i].early_hits;
-				continue;
-			}
+	/*
+	 * Find the deepest idle state whose target residency does not exceed
+	 * the current sleep length and the deepest idle state not deeper than
+	 * the former whose exit latency does not exceed the current latency
+	 * constraint.  Compute the sums of metrics for early wakeup pattern
+	 * detection.
+	 */
+	for (i = 1; i < drv->state_count; i++) {
+		struct teo_bin *prev_bin = &cpu_data->state_bins[i-1];
+		struct cpuidle_state *s = &drv->states[i];
 
-			/*
-			 * The current candidate state is closer to the disabled
-			 * one than the current maximum "early hits" state, so
-			 * replace the latter with it, but in case the maximum
-			 * "early hits" state index has not been set so far,
-			 * check if the current candidate state is not too
-			 * shallow for that role.
-			 */
-			if (teo_time_ok(drv->states[idx].target_residency_ns)) {
-				prev_max_early_idx = max_early_idx;
-				early_hits = cpu_data->states[i].early_hits;
-				max_early_idx = idx;
-			}
+		/*
+		 * Update the sums of idle state mertics for all of the states
+		 * shallower than the current one.
+		 */
+		intercept_sum += prev_bin->intercepts;
+		hit_sum += prev_bin->hits;
 
+		if (dev->states_usage[i].disable)
 			continue;
-		}
 
 		if (idx < 0) {
 			idx = i; /* first enabled state */
-			hits = cpu_data->states[i].hits;
-			misses = cpu_data->states[i].misses;
 			idx0 = i;
 		}
 
 		if (s->target_residency_ns > duration_ns)
 			break;
 
-		if (s->exit_latency_ns > latency_req && constraint_idx > i)
+		idx = i;
+
+		if (s->exit_latency_ns <= latency_req)
 			constraint_idx = i;
 
-		idx = i;
-		hits = cpu_data->states[i].hits;
-		misses = cpu_data->states[i].misses;
+		idx_intercept_sum = intercept_sum;
+		idx_hit_sum = hit_sum;
+	}
 
-		if (early_hits < cpu_data->states[i].early_hits &&
-		    teo_time_ok(drv->states[i].target_residency_ns)) {
-			prev_max_early_idx = max_early_idx;
-			early_hits = cpu_data->states[i].early_hits;
-			max_early_idx = i;
-		}
+	/* Avoid unnecessary overhead. */
+	if (idx < 0) {
+		idx = 0; /* No states enabled, must use 0. */
+		goto end;
+	} else if (idx == idx0) {
+		goto end;
 	}
 
 	/*
-	 * If the "hits" metric of the idle state matching the sleep length is
-	 * greater than its "misses" metric, that is the one to use.  Otherwise,
-	 * it is more likely that one of the shallower states will match the
-	 * idle duration observed after wakeup, so take the one with the maximum
-	 * "early hits" metric, but if that cannot be determined, just use the
-	 * state selected so far.
+	 * If the sum of the intercepts metric for all of the idle states
+	 * shallower than the current candidate one (idx) is greater than the
+	 * sum of the intercepts and hits metrics for the candidate state and
+	 * all of the deeper states, the CPU is likely to wake up early, so find
+	 * an alternative idle state to select.
 	 */
-	if (hits <= misses) {
+	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
+		s64 last_enabled_span_ns = duration_ns;
+		int last_enabled_idx = idx;
+
 		/*
-		 * The current candidate state is not suitable, so take the one
-		 * whose "early hits" metric is the maximum for the range of
-		 * shallower states.
+		 * Look for the deepest idle state whose target residency had
+		 * not exceeded the idle duration in over a half of the relevant
+		 * cases in the past.
+		 *
+		 * Take the possible latency constraint and duration limitation
+		 * present if the tick has been stopped already into account.
 		 */
-		if (idx == max_early_idx)
-			max_early_idx = prev_max_early_idx;
+		intercept_sum = 0;
 
-		if (max_early_idx >= 0) {
-			idx = max_early_idx;
-			duration_ns = drv->states[idx].target_residency_ns;
+		for (i = idx - 1; i >= idx0; i--) {
+			s64 span_ns;
+
+			intercept_sum += cpu_data->state_bins[i].intercepts;
+
+			if (dev->states_usage[i].disable)
+				continue;
+
+			span_ns = teo_middle_of_bin(i, drv);
+			if (!teo_time_ok(span_ns)) {
+				/*
+				 * The current state is too shallow, so select
+				 * the first enabled deeper state.
+				 */
+				duration_ns = last_enabled_span_ns;
+				idx = last_enabled_idx;
+				break;
+			}
+
+			if (2 * intercept_sum > idx_intercept_sum) {
+				idx = i;
+				duration_ns = span_ns;
+				break;
+			}
+
+			last_enabled_span_ns = span_ns;
+			last_enabled_idx = i;
 		}
 	}
 
 	/*
-	 * If there is a latency constraint, it may be necessary to use a
-	 * shallower idle state than the one selected so far.
+	 * If there is a latency constraint, it may be necessary to select an
+	 * idle state shallower than the current candidate one.
 	 */
-	if (constraint_idx < idx)
+	if (idx > constraint_idx)
 		idx = constraint_idx;
 
-	if (idx < 0) {
-		idx = 0; /* No states enabled. Must use 0. */
-	} else if (idx > idx0) {
+	if (idx > idx0) {
 		unsigned int count = 0;
 		u64 sum = 0;
 
@@ -416,6 +447,7 @@ static int teo_select(struct cpuidle_dri
 		}
 	}
 
+end:
 	/*
 	 * Don't stop the tick if the selected state is a polling one or if the
 	 * expected idle duration is shorter than the tick period length.



