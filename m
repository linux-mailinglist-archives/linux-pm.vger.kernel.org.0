Return-Path: <linux-pm+bounces-42832-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIfzAAEHlmm4YQIAu9opvQ
	(envelope-from <linux-pm+bounces-42832-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:37:53 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AFB158C0C
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B57FA3002923
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 18:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6F1346AEB;
	Wed, 18 Feb 2026 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfOnXoRG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3EC23ABBE;
	Wed, 18 Feb 2026 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439867; cv=none; b=rfnsQuVXtbgUDcRpxfEvUizFF9/iCQm22GsmldicSNV0rlX1G7XVyKySgMvf6K5d+YUeowLW+EgAMHkEufG6RjkXqyJPJ4G+DXFT3JmKpUtNLDY5lYoqRAL4TztY28tGaxJjsfMrhI9mDgLflTLXc6CaQMJv/e4LK88ViRE2flw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439867; c=relaxed/simple;
	bh=0ZwroL/EU90eOY5DTA3U3esYB7P57rsTLbI62v15E3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBUBa9AIAMnU9nHGTYZ/Jd1lIPOSuzchTEOd5RQYdbRtIB0GdfzWwY0yhcHzDSmhUsvDhPtf8yqkTcy07GRMZZTit9UHcKgVWVX0KycdszdanhnLSaN9hpyjnHUYS8VQNtciZ3iZdbWL6Xa0P9eboA5shUoPon/CiZYQtabYjZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfOnXoRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FD6C116D0;
	Wed, 18 Feb 2026 18:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771439866;
	bh=0ZwroL/EU90eOY5DTA3U3esYB7P57rsTLbI62v15E3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DfOnXoRG2ArK8ghlIw5gpzG4H0EGw+M9DST3dXtG305xmZVXeBLtWe7HQjjRk4Flw
	 ft+V/6n2+Uu3HGVz9tNHf6wfPH+Pmm/NdrZOMYGGkyGwG609mCgAvEq1EaVkjA4pUP
	 po2OYHUZx19wGx3sf/vddohsh6DvCit8sDIVlSbiTj0lUn/43KN3KbHazLTGce/di3
	 x2XhsNFxoIZDkL6ulIDbuzuE2hQdTfW8O1BgiNOWBfZlkLRLjNT5WlnKSqbinNlWD3
	 pqdHndU4MPU4PYCIHU1wDsnNOR15/h9gfo93bGHpjDL7kRtt5iqIXk34TaXAd1V7y0
	 a/x5mnGrUME/Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Subject:
 [PATCH v1 2/2] cpuidle: governors: teo: Rearrange stopped tick handling
Date: Wed, 18 Feb 2026 19:37:37 +0100
Message-ID: <3409058.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <1953482.tdWV9SEqCh@rafael.j.wysocki>
References: <1953482.tdWV9SEqCh@rafael.j.wysocki>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42832-lists,linux-pm=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,arm.com,telus.net,linux.ibm.com,gmail.com];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 30AFB158C0C
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
changes, but the resulting simplification is worth it in my view.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   80 ++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 47 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -413,50 +413,13 @@ static int teo_select(struct cpuidle_dri
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
@@ -469,7 +432,6 @@ static int teo_select(struct cpuidle_dri
 		}
 	}
 
-constraint:
 	/*
 	 * If there is a latency constraint, it may be necessary to select an
 	 * idle state shallower than the current candidate one.
@@ -478,13 +440,13 @@ constraint:
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
@@ -500,7 +462,8 @@ constraint:
 	 * shallow idle states regardless of the wakeup type, so the sleep
 	 * length need not be known in that case.
 	 */
-	if ((!idx || drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS) &&
+	if (!tick_nohz_tick_stopped() && (!idx ||
+	     drv->states[idx].target_residency_ns < RESIDENCY_THRESHOLD_NS) &&
 	    (2 * cpu_data->short_idles >= cpu_data->total ||
 	     latency_req < LATENCY_THRESHOLD_NS))
 		goto out_tick;
@@ -508,6 +471,29 @@ constraint:
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
+		 * Look for the deepest enabled idle state with target
+		 * residency within duration_ns.
+		 */
+		for (i = drv->state_count - 1; i > idx; i--) {
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
 




