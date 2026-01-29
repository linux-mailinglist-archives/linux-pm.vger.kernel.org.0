Return-Path: <linux-pm+bounces-41729-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /wSyJojIe2n5IQIAu9opvQ
	(envelope-from <linux-pm+bounces-41729-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:52:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32439B45A9
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3DA23004D19
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0935C359F9E;
	Thu, 29 Jan 2026 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fr1oJhDG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78643587BB;
	Thu, 29 Jan 2026 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769719940; cv=none; b=EvH0P+FfDY4C+crKwCYjHo45Jk+hCRm7brsAg+2LJKt7JTdda6rm7Uyw5oNaqfxkHYsQaqiMQGvKMpymQEJAROYJ6IS1IURv0cyx2NVCnx3qi/BlRoij1y68T636f4WOyz3BM2SbMgvxygkh1y8ufVry6pSE/BA2pxCV2TYypgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769719940; c=relaxed/simple;
	bh=ZaOTBopmHVAbrZqBYT4DgQsTB1Ta2a2ggr3lInqad5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alBUnNqryecfbuXDm/gHv8mVLEZPFyarvBMj2sNCps4S9E9S6JEPHkE/nsfexT9X+HUawDJLOfYFWaEr1nD+x6PQz+LIxSeWvQbi3QJi4x1Q8EQYDlj4n2f+CxoWdntMdH5Dsy/HVUw7v/4XD7R4sHPwIpnaCZZGTXhXb5Md/fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fr1oJhDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F15C19421;
	Thu, 29 Jan 2026 20:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769719940;
	bh=ZaOTBopmHVAbrZqBYT4DgQsTB1Ta2a2ggr3lInqad5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fr1oJhDGLPyINka1SfyKNky6b/BspSwpLMkF7NWjHJUiScb8ei7SLPdhWF39JiS7k
	 3nL2NXBhyq99LL5mmcjQ9BBWZ2jVRDALwL5g/23458onFPutm8aA3soKhGsbLqoux9
	 tSVnJLsF8SZg7DSMv4yUnI4bA1HYq4zHTQu7H82dgcxc0MjQFtTB0eEh/ERV2d6lkE
	 V2x8+24/GBVYU9e7hB/Aq8BpXgFVDryTzXmFz7VFaafUSeM5os2VEHzNqmXPjW6d6E
	 S/QOUMIE1W2Z9N0eroA27yXdtpiIIpkn+VhsAOsx0Mst+/v9adVxPgxvWyRcqGU91E
	 yW+f0aFlFe4gA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v3 2/2] cpuidle: governors: teo: Refine intercepts-based idle state
 lookup
Date: Thu, 29 Jan 2026 21:51:11 +0100
Message-ID: <2417298.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12846604.O9o76ZdvQC@rafael.j.wysocki>
References: <12846604.O9o76ZdvQC@rafael.j.wysocki>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41729-lists,linux-pm=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 32439B45A9
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are cases in which decisions made by the teo governor are
arguably overly conservative.

For instance, suppose that there are 4 idle states and the values of
the intercepts metric for the first 3 of them are 400, 250, and 251,
respectively.  If the total sum computed in teo_update() is 1000, the
governor will select idle state 1 (provided that all idle states are
enabled and the scheduler tick has not been stopped) although arguably
idle state 0 would be a better choice because the likelihood of getting
an idle duration below the target residency of idle state 1 is greater
than the likelihood of getting an idle duration between the target
residency of idle state 1 and the target residency of idle state 2.

To address this, refine the candidate idle state lookup based on
intercepts to start at the state with the maximum intercepts metric,
below the deepest enabled one, to avoid the cases in which the search
may stop before reaching that state.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: No changes

v1 -> v2:
   * Multiple fixes related to the handling of cases in which some states
     are disabled.
   * Fixes in new comments (there was some confusion in those comments
     regarding the direction of idle states table traversal).
   * Fixed typos in new comments.

---
 drivers/cpuidle/governors/teo.c |   50 ++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 7 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -74,12 +74,17 @@
  *      than the candidate one (it represents the cases in which the CPU was
  *      likely woken up by a non-timer wakeup source).
  *
+ *    Also find the idle state with the maximum intercepts metric (if there are
+ *    multiple states with the maximum intercetps metric, choose the one with
+ *    the highest index).
+ *
  * 2. If the second sum computed in step 1 is greater than a half of the sum of
  *    both metrics for the candidate state bin and all subsequent bins (if any),
  *    a shallower idle state is likely to be more suitable, so look for it.
  *
  *    - Traverse the enabled idle states shallower than the candidate one in the
- *      descending order.
+ *      descending order, starting at the state with the maximum intercepts
+ *      metric found in step 1.
  *
  *    - For each of them compute the sum of the "intercepts" metrics over all
  *      of the idle states between it and the candidate one (including the
@@ -308,8 +313,10 @@ static int teo_select(struct cpuidle_dri
 	ktime_t delta_tick = TICK_NSEC / 2;
 	unsigned int idx_intercept_sum = 0;
 	unsigned int intercept_sum = 0;
+	unsigned int intercept_max = 0;
 	unsigned int idx_hit_sum = 0;
 	unsigned int hit_sum = 0;
+	int intercept_max_idx = -1;
 	int constraint_idx = 0;
 	int idx0 = 0, idx = -1;
 	s64 duration_ns;
@@ -340,17 +347,32 @@ static int teo_select(struct cpuidle_dri
 	if (!dev->states_usage[0].disable)
 		idx = 0;
 
-	/* Compute the sums of metrics for early wakeup pattern detection. */
+	/*
+	 * Compute the sums of metrics for early wakeup pattern detection and
+	 * look for the state bin with the maximum intercepts metric below the
+	 * deepest enabled one (if there are multiple states with the maximum
+	 * intercepts metric, choose the one with the highest index).
+	 */
 	for (i = 1; i < drv->state_count; i++) {
 		struct teo_bin *prev_bin = &cpu_data->state_bins[i-1];
+		unsigned int prev_intercepts = prev_bin->intercepts;
 		struct cpuidle_state *s = &drv->states[i];
 
 		/*
 		 * Update the sums of idle state metrics for all of the states
 		 * shallower than the current one.
 		 */
-		intercept_sum += prev_bin->intercepts;
 		hit_sum += prev_bin->hits;
+		intercept_sum += prev_intercepts;
+		/*
+		 * Check if this is the bin with the maximum number of
+		 * intercepts so far and in that case update the index of
+		 * the state with the maximum intercetps metric.
+		 */
+		if (prev_intercepts >= intercept_max) {
+			intercept_max = prev_intercepts;
+			intercept_max_idx = i - 1;
+		}
 
 		if (dev->states_usage[i].disable)
 			continue;
@@ -414,9 +436,22 @@ static int teo_select(struct cpuidle_dri
 		}
 
 		/*
-		 * Look for the deepest idle state whose target residency had
-		 * not exceeded the idle duration in over a half of the relevant
-		 * cases in the past.
+		 * If the minimum state index is greater than or equal to the
+		 * index of the state with the maximum intercepts metric and
+		 * the corresponding state is enabled, there is no need to look
+		 * at the deeper states.
+		 */
+		if (min_idx >= intercept_max_idx &&
+		    !dev->states_usage[min_idx].disable) {
+			idx = min_idx;
+			goto constraint;
+		}
+
+		/*
+		 * Look for the deepest enabled idle state, at most as deep as
+		 * the one with the maximum intercetps metric, whose target
+		 * residency had not been greater than the idle duration in over
+		 * a half of the relevant cases in the past.
 		 *
 		 * Take the possible duration limitation present if the tick
 		 * has been stopped already into account.
@@ -428,7 +463,8 @@ static int teo_select(struct cpuidle_dri
 				continue;
 
 			idx = i;
-			if (2 * intercept_sum > idx_intercept_sum)
+			if (2 * intercept_sum > idx_intercept_sum &&
+			    i <= intercept_max_idx)
 				break;
 		}
 	}




