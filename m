Return-Path: <linux-pm+bounces-43046-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFEGJYV1nGmwHwQAu9opvQ
	(envelope-from <linux-pm+bounces-43046-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 16:43:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB229178ED0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CB513074E01
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDD02EDD6C;
	Mon, 23 Feb 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO99lQUO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A92A2EBBA4;
	Mon, 23 Feb 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861243; cv=none; b=gSjxC+9Qu4tOt4kDI1K5AASSOWjNjLh/hu/3TN7TqAKJUxgMi3CV/UPM04jUq5ysB+tMfLDycbhOSkHH/EyhnxFgl2xTp/KJVp4h4Cy848JiyHiDzAVZNaSppelzrHH6dQpRqLxbhRSvN1C5a34+wgbvCnb3QVcVZINtezsD3wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861243; c=relaxed/simple;
	bh=GDYNDlHOz302hkydh0Yq7QkZCk7b6MEbVLVFrY4W2Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X17wWzPaOwNztlZIuO+lzcmrV+rDsnbxcbq3nUMnFMUSqT7y/UeXjz82n3lTB81zWKT2v95xynsbqm3i9SpmynjV4qWQGi22hrR1teCc7gbpCT75wGmy6DXVmBHoajcKwxAlNqoC3784mTTa+x+jcIfLIIzNe4DRbUC3B9WZdrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO99lQUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DE0C116D0;
	Mon, 23 Feb 2026 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771861243;
	bh=GDYNDlHOz302hkydh0Yq7QkZCk7b6MEbVLVFrY4W2Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lO99lQUOQXVFXAp//bcupCwfeJDvvI2iMawzmffp3yI/mpB+yTSxGypKXEW+KaILR
	 IYhVzE3Fl0dfQJhgN8sQIYP9/dUf3cU7v+hAr6Li4nueyPGceQMhmFp9fJLJhX3IUA
	 vWTn2t8nLncQaufVh/5WZaev2K5nRZvHicayrGsNWOSYNMXuwhyFE0UZuBlA/G9q9S
	 64SEZyGWVivjL64RUDOhdfHadH+E0dnTdBsUnpLZPJv4sYY7b6EUv10SkOtRhFZNRA
	 7laTRL8H9/ridQSK3fp962clp0M9JKLT5AjpXblnVYQ83pxm7G02NIqw95RYPWVklr
	 nRY5vdUA7n1vA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Subject: [PATCH v2 1/2] cpuidle: governors: menu: Refine stopped tick handling
Date: Mon, 23 Feb 2026 16:38:55 +0100
Message-ID: <3341782.5fSG56mABF@rafael.j.wysocki>
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
	TAGGED_FROM(0.00)[bounces-43046-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: EB229178ED0
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This change is based on the observation that it is not in fact necessary
to select a deep idle state every time the scheduler tick has been
stopped before the idle state selection takes place.  Namely, if the
time till the closest timer (that is not the tick) is short enough,
a shallow idle state can be selected because the timer will kick the
CPU out of that state, so the damage from a possible overly optimistic
selection will be limited.

Update the menu governor in accordance with the above and use twice
the tick period length as the "safe timer range" for allowing the
original predicted_ns value to be used even if the tick has been
stopped.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/cpuidle/governors/gov.h  |    5 +++++
 drivers/cpuidle/governors/menu.c |   15 +++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

--- a/drivers/cpuidle/governors/gov.h
+++ b/drivers/cpuidle/governors/gov.h
@@ -10,5 +10,10 @@
  * check the time till the closest expected timer event.
  */
 #define RESIDENCY_THRESHOLD_NS	(15 * NSEC_PER_USEC)
+/*
+ * If the closest timer is in this range, the governor idle state selection need
+ * not be adjusted after the scheduler tick has been stopped.
+ */
+#define SAFE_TIMER_RANGE_NS	(2 * TICK_NSEC)
 
 #endif /* __CPUIDLE_GOVERNOR_H */
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -261,13 +261,16 @@ static int menu_select(struct cpuidle_dr
 		predicted_ns = min((u64)timer_us * NSEC_PER_USEC, predicted_ns);
 		/*
 		 * If the tick is already stopped, the cost of possible short
-		 * idle duration misprediction is much higher, because the CPU
-		 * may be stuck in a shallow idle state for a long time as a
-		 * result of it.  In that case, say we might mispredict and use
-		 * the known time till the closest timer event for the idle
-		 * state selection.
+		 * idle duration misprediction is higher because the CPU may get
+		 * stuck in a shallow idle state then.  To avoid that, if
+		 * predicted_ns is small enough, say it might be mispredicted
+		 * and use the known time till the closest timer for idle state
+		 * selection unless that timer is going to trigger within
+		 * SAFE_TIMER_RANGE_NS in which case it can be regarded as a
+		 * sufficient safety net.
 		 */
-		if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
+		if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC &&
+		    data->next_timer_ns > SAFE_TIMER_RANGE_NS)
 			predicted_ns = data->next_timer_ns;
 	} else {
 		/*




