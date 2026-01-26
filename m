Return-Path: <linux-pm+bounces-41492-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ3JMxDGd2nckgEAu9opvQ
	(envelope-from <linux-pm+bounces-41492-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 20:52:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC18CC82
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 20:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30518301BC07
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jan 2026 19:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79BE288C0E;
	Mon, 26 Jan 2026 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr5Q7JpX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95391219A8D;
	Mon, 26 Jan 2026 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457092; cv=none; b=C2Kcw3QpICZEcSRkad+MAu6MFWdwZ8Ywbn2g8mRp5tOm/flW4Q+jwMURW/7Gs2C6nZFeGn0z205fMYORnLijmFyF3PuHDLMxwhaBaL2G2DYGQfjStkfXeoSPdj58IJIKPAyWfpK6sNnXavxnHdmw/UkJu9zPPzjyuboPPBaPlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457092; c=relaxed/simple;
	bh=BgyLYI7vn3wJNjwuLVs1tvgN7MJFbi6a3c7cpdKhx0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOynYjU4hODPuOP8Fzcgvb5ljX5+QKpG18cCOhT2X2G0JzHwsDh2jMlRW/lmPIGqxyNXdboelW4BzP68bwGVKSRGfi30fGV74MyEb4zf+2v7SokzfZSVVFIw3dOLaaHBLZn7EObrks/rGX12z7LvFWXsjx95qQblHeA/lwG9Tng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hr5Q7JpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781FBC19422;
	Mon, 26 Jan 2026 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457092;
	bh=BgyLYI7vn3wJNjwuLVs1tvgN7MJFbi6a3c7cpdKhx0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hr5Q7JpXynR+zwvNYmHgY8ssidWpxhz3g1wVS1Kedct2pki8VdkDfyT6aG/W7oxF/
	 XiW10oiARi6tsjODfQjTdlUvFlEnipfCAJ9WXQMdPDe9xATGHvYKQh+ahxF7L5iqij
	 88bd9uKLEh0fZb1gN/Fs3IcS2eFZxQSBdvKviN7NCbRsc9ZIFgFZZka3egyiGQ+SnX
	 HVqKr1Fc8Xm6mXlNuufVaarIK7Cg4XilXtatc7qh0ik3oevgPx0yEYHzzmSBtTfV/z
	 P0l1nCZqcv9hIsNhd+15IY9kK+Ph0Bm+KhWRW6JFU7VKY/RisKzspTbk1AXScqnW+f
	 CZDjMl6e90zKg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v2 1/2] cpuidle: governors: teo: Adjust the classification of wakeup
 events
Date: Mon, 26 Jan 2026 20:45:20 +0100
Message-ID: <5079287.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12831359.O9o76ZdvQC@rafael.j.wysocki>
References: <12831359.O9o76ZdvQC@rafael.j.wysocki>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41492-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 4DFC18CC82
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If differences between target residency values of adjacent idle states
of a given CPU are relatively large, the corresponding idle state bins
used by the teo governors are large either and the rule by which hits
are distinguished from intercepts is inaccurate.

Namely, by that rule, a wakeup event is classified as a hit if the
sleep length (the time till the closest timer other than the tick)
and the measured idle duration, adjusted for the entered idle state
exit latency, fall into the same idle state bin.  However, if that bin
is large enough, the actual difference between the sleep length and
the measured idle duration may be significant.  It may in fact be
significantly greater than the analogous difference for an event where
the sleep length and the measured idle duration fall into different
bins.

For this reason, amend the rule in question with a check that will
only allow a wakeup event to be counted as a hit if the difference
between the sleep length and the measured idle duration is less than
LATENCY_THRESHOLD_NS (which means that the difference between the
sleep length and the raw measured idle duration is below the sum of
LATENCY_THRESHOLD_NS and 1/2 of the entered idle state exit latency).
Otherwise, the event will be counted as an intercept.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1.1 -> v2: No changes

v1 -> v1.1
   * Drop the change in teo_select() along with the corresponding
     part of the changelog (after receiving testing feedback from
     Christian)

This is a resend of

https://lore.kernel.org/linux-pm/4707705.LvFx2qVVIh@rafael.j.wysocki/

It applies on top of the first three patches from

https://lore.kernel.org/linux-pm/2257365.irdbgypaU6@rafael.j.wysocki/

---
 drivers/cpuidle/governors/teo.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -48,13 +48,11 @@
  * in accordance with what happened last time.
  *
  * The "hits" metric reflects the relative frequency of situations in which the
- * sleep length and the idle duration measured after CPU wakeup fall into the
- * same bin (that is, the CPU appears to wake up "on time" relative to the sleep
- * length).  In turn, the "intercepts" metric reflects the relative frequency of
- * non-timer wakeup events for which the measured idle duration falls into a bin
- * that corresponds to an idle state shallower than the one whose bin is fallen
- * into by the sleep length (these events are also referred to as "intercepts"
- * below).
+ * sleep length and the idle duration measured after CPU wakeup are close enough
+ * (that is, the CPU appears to wake up "on time" relative to the sleep length).
+ * In turn, the "intercepts" metric reflects the relative frequency of non-timer
+ * wakeup events for which the measured idle duration is measurably less than
+ * the sleep length (these events are also referred to as "intercepts" below).
  *
  * The governor also counts "intercepts" with the measured idle duration below
  * the tick period length and uses this information when deciding whether or not
@@ -253,12 +251,16 @@ static void teo_update(struct cpuidle_dr
 	}
 
 	/*
-	 * If the measured idle duration falls into the same bin as the sleep
-	 * length, this is a "hit", so update the "hits" metric for that bin.
+	 * If the measured idle duration falls into the same bin as the
+	 * sleep length and the difference between them is less than
+	 * LATENCY_THRESHOLD_NS, this is a "hit", so update the "hits"
+	 * metric for that bin.
+	 *
 	 * Otherwise, update the "intercepts" metric for the bin fallen into by
 	 * the measured idle duration.
 	 */
-	if (idx_timer == idx_duration) {
+	if (idx_timer == idx_duration &&
+	    cpu_data->sleep_length_ns - measured_ns < LATENCY_THRESHOLD_NS) {
 		cpu_data->state_bins[idx_timer].hits += PULSE;
 	} else {
 		cpu_data->state_bins[idx_duration].intercepts += PULSE;




