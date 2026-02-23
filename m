Return-Path: <linux-pm+bounces-43045-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AYiAGp1nGmwHwQAu9opvQ
	(envelope-from <linux-pm+bounces-43045-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 16:42:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68854178EB2
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 16:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BB4730484E8
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 15:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98242EFDA4;
	Mon, 23 Feb 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZ+adLah"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965F2283FC9;
	Mon, 23 Feb 2026 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861239; cv=none; b=GRLBKt5qN4sZ9Z3IWG5j2m2viYU1PeybL6bxLQign7phc0w3HLqBH6v9+AW9nFCp2N76/TM8o7ltS9HZX6wHpfs9U9pBAqNC7zRbGZRDq+WUV484idrjH72EJF1RZ0Pcdb12RlmWDQn3FrfjulfsD8c6jficJZqRfVc+Yb+9er8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861239; c=relaxed/simple;
	bh=LFGqpZtrN2UKGPTbnoy92+JPz98vAxZ+Wmk7dSH9bKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUoCLcxJrzY5OU/umfsc8csYnXo2tjtmqF2zwXSlIqRTYAyctShlWRiWM1y4+YjT+JkJFW1XIuNMC3xxY4wVoMFE36N35pOwj3a1BDm5MZ7F/MLRcxjQXaHPbw8H+tp+6VIFS1mqh1/TelSiQfomJs+crufnIDibf1Ho69FdEpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZ+adLah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0239C116C6;
	Mon, 23 Feb 2026 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771861239;
	bh=LFGqpZtrN2UKGPTbnoy92+JPz98vAxZ+Wmk7dSH9bKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZ+adLahDOdHKgePo9CYOy9vvYE5yO/jeWmFxvOBvrm/l1I8zmHA4eZYEYHqexw0L
	 Q2t08ZWRXAzAL4RARHGacdvt/raXLa/U2p1U89BW9xvoSwPf4/EZc4mPzg2X/YJa9u
	 4GoXE1cn0TU9EdmLupN03THb7Kw3AdU5x81xJCGiUEHOvA/8rcl9NZCYBHxOZ+pvZ2
	 3TNDu6lSCz9r+3r1q6w1lwqH/IO63Q0jJH37oRj0l6DcDtVuXH37yGeDkQZlO0jnRz
	 scoA6ydrI4VjhwNPXihoTIZcai3Fo11hlQ3I+LKEW9ZmBFT76tM/gbzD2x4UM+6kQi
	 0F0hFTXREe1Yg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Subject:
 [PATCH v2 2/2] cpuidle: governors: teo: Rearrange stopped tick handling
Date: Mon, 23 Feb 2026 16:40:18 +0100
Message-ID: <1865078.VLH7GnMWUR@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3693525.iIbC2pHGDl@rafael.j.wysocki>
References: <3693525.iIbC2pHGDl@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43045-lists,linux-pm=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,arm.com,telus.net,linux.ibm.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 68854178EB2
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This change is based on the observation that it is not in fact necessary
to select a deep idle state every time the scheduler tick has been
stopped before the idle state selection takes place.  Namely, if the
time till the closest timer (that is not the tick) is short enough,
a shallow idle state can be selected because the timer will kick the
CPU out of that state, so the damage from a possible overly optimistic
selection will be limited.

Update the teo governor in accordance with the above in analogy with
the previous analogous menu governor update.

Among other things, this will cause the teo governor to call
tick_nohz_get_sleep_length() every time when the tick has been
stopped already and only change the original idle state selection
if the time till the closest timer is beyond SAFE_TIMER_RANGE_NS
which is way more straightforward than the current code flow.

Of course, this effectively throws away some of the recent teo governor
changes made recently, but the resulting simplification is worth it in
my view.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Take constraint_idx into account when looking for a deeper idle
          state (Christian)

---
 drivers/cpuidle/governors/teo.c |   81 ++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 47 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -407,50 +407,13 @@ static int teo_select(struct cpuidle_dri
 	 * better choice.
 	 */
 	if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
-		int min_idx = idx0;
-
-		if (tick_nohz_tick_stopped()) {
-			/*
-			 * Look for the shallowest idle state below the current
-			 * candidate one whose target residency is at least
-			 * equal to the tick period length.
-			 */
-			while (min_idx < idx &&
-			       drv->states[min_idx].target_residency_ns < TICK_NSEC)
-				min_idx++;
-
-			/*
-			 * Avoid selecting a state with a lower index, but with
-			 * the same target residency as the current candidate
-			 * one.
-			 */
-			if (drv->states[min_idx].target_residency_ns ==
-					drv->states[idx].target_residency_ns)
-				goto constraint;
-		}
-
-		/*
-		 * If the minimum state index is greater than or equal to the
-		 * index of the state with the maximum intercepts metric and
-		 * the corresponding state is enabled, there is no need to look
-		 * at the deeper states.
-		 */
-		if (min_idx >= intercept_max_idx &&
-		    !dev->states_usage[min_idx].disable) {
-			idx = min_idx;
-			goto constraint;
-		}
-
 		/*
 		 * Look for the deepest enabled idle state, at most as deep as
 		 * the one with the maximum intercepts metric, whose target
 		 * residency had not been greater than the idle duration in over
 		 * a half of the relevant cases in the past.
-		 *
-		 * Take the possible duration limitation present if the tick
-		 * has been stopped already into account.
 		 */
-		for (i = idx - 1, intercept_sum = 0; i >= min_idx; i--) {
+		for (i = idx - 1, intercept_sum = 0; i >= idx0; i--) {
 			intercept_sum += cpu_data->state_bins[i].intercepts;
 
 			if (dev->states_usage[i].disable)
@@ -463,7 +426,6 @@ static int teo_select(struct cpuidle_dri
 		}
 	}
 
-constraint:
 	/*
 	 * If there is a latency constraint, it may be necessary to select an
 	 * idle state shallower than the current candidate one.
@@ -472,13 +434,13 @@ constraint:
 		idx = constraint_idx;
 
 	/*
-	 * If either the candidate state is state 0 or its target residency is
-	 * low enough, there is basically nothing more to do, but if the sleep
-	 * length is not updated, the subsequent wakeup will be counted as an
-	 * "intercept" which may be problematic in the cases when timer wakeups
-	 * are dominant.  Namely, it may effectively prevent deeper idle states
-	 * from being selected at one point even if no imminent timers are
-	 * scheduled.
+	 * If the tick has not been stopped and either the candidate state is
+	 * state 0 or its target residency is low enough, there is basically
+	 * nothing more to do, but if the sleep length is not updated, the
+	 * subsequent wakeup will be counted as an "intercept".  That may be
+	 * problematic in the cases when timer wakeups are dominant because it
+	 * may effectively prevent deeper idle states from being selected at one
+	 * point even if no imminent timers are scheduled.
 	 *
 	 * However, frequent timers in the RESIDENCY_THRESHOLD_NS range on one
 	 * CPU are unlikely (user space has a default 50 us slack value for
@@ -494,7 +456,8 @@ constraint:
 	 * shallow idle states regardless of the wakeup type, so the sleep
 	 * length need not be known in that case.
 	 */
-	if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS) &&
+	if (!tick_nohz_tick_stopped() && (!idx ||
+	     drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS) &&
 	    (2 * cpu_data->short_idles >= cpu_data->total ||
 	     latency_req < LATENCY_THRESHOLD_NS))
 		goto out_tick;
@@ -502,6 +465,30 @@ constraint:
 	duration_ns = tick_nohz_get_sleep_length(&delta_tick);
 	cpu_data->sleep_length_ns = duration_ns;
 
+	/*
+	 * If the tick has been stopped and the closest timer is too far away,
+	 * update the selection to prevent the CPU from getting stuck in a
+	 * shallow idle state for too long.
+	 */
+	if (tick_nohz_tick_stopped() && duration_ns > SAFE_TIMER_RANGE_NS &&
+	    drv->states[idx].target_residency_ns < TICK_NSEC) {
+		/*
+		 * Look for the deepest enabled idle state with exit latency
+		 * within the PM QoS limit and with target residency within
+		 * duration_ns.
+		 */
+		for (i = constraint_idx; i > idx; i--) {
+			if (dev->states_usage[i].disable)
+				continue;
+
+			if (drv->states[i].target_residency_ns <= duration_ns) {
+				idx = i;
+				break;
+			}
+		}
+		return idx;
+	}
+
 	if (!idx)
 		goto out_tick;
 




