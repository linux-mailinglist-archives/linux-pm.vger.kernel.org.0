Return-Path: <linux-pm+bounces-41183-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P4JLuPGb2mgMQAAu9opvQ
	(envelope-from <linux-pm+bounces-41183-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 19:18:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B35494C4
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 19:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA3627ECA06
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8A043D4F2;
	Tue, 20 Jan 2026 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1zf/kJh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9571643DA3C;
	Tue, 20 Jan 2026 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923003; cv=none; b=nDrYdMD7xvDXS0BumyWC9MtRdFbiF7h7bFCM+gAjRUa3qlgZvjXlqOjA4KZodnHRZc0B935/GmfS40Ewqf0Q4Xmus6SPxr7cWOVVUyqYqsvtBI5RN8BzqwS6t8tFPMSV+MqrvPSKv0D+vcoIRpSyW89xHChwDJ51+iY1Gf9y0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923003; c=relaxed/simple;
	bh=wx2PTvUA8XiPbeKJPwWhvmYVE3zPcEvWB5FSA+rmcXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImcbsesB+Lq5ZXDQB7EI8vqviFXEM5I6yU+vIR0ss5sqc0Ss8YmRtC3Ql+ZopZ20yKtzshgOjN3K71tbi0L7iqDsJlSfmmWkjBeK3pSdlbB05UvkygMcaIPYUgDd0nJcwoVzazg5xVllpu80zoa1pRIhGV2rhG+DhWWe/vpirdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1zf/kJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0504DC19422;
	Tue, 20 Jan 2026 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768923003;
	bh=wx2PTvUA8XiPbeKJPwWhvmYVE3zPcEvWB5FSA+rmcXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X1zf/kJhaiPpRQe5XLbqDdmv0zXk9306UPbaMjs5H/1GRkT2ZFZ269Z4kGgKA+azZ
	 tdGvVSrGniOSgk0ga/EUccTbnBLR7iUAnCmB9DKfOnjVJcyBequp8PuwJPvHleRPa6
	 AbUtHqPdbYrNiEFIw/kiM/7JN20mAZrST5m1PmhhzJOW27npDMNDal3dGns0d8KCsn
	 QiAMQbuYF+L+J14ZaBrJgOimFL8MwIsWQ0e/3Vnhm4sxPmPyihOUgr2DA4b/dwdr/m
	 7SCrAz9mTahy7JOFHC3+wrCZSeV9WPkF9uEztlORyLt/POS1kcVT5o6CYthFaus5YN
	 vMmCIvSOuBTgg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [Update][PATCH v1.1 4/5] cpuidle: governors: teo: Adjust the classification
 of wakeup events
Date: Tue, 20 Jan 2026 16:29:59 +0100
Message-ID: <4707705.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2257365.irdbgypaU6@rafael.j.wysocki>
References: <2257365.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41183-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 57B35494C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

v1 -> v1.1
   * Drop the change in teo_select() along with the corresponding
     part of the changelog (after receiving testing feedback from
     Christian)

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




