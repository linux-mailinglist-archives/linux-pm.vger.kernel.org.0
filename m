Return-Path: <linux-pm+bounces-42833-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAVwFREHlmm4YQIAu9opvQ
	(envelope-from <linux-pm+bounces-42833-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:38:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B33B0158C1A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 19:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11785301CFDB
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 18:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168B8346E5F;
	Wed, 18 Feb 2026 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/eiLerR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6C346A0C;
	Wed, 18 Feb 2026 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439871; cv=none; b=dLIFJx+ZrEvlbdtlkmZiWyTiZMjSFp/sFm5rojHP+XybhJYAFui3occZV/wKERInsedfsNBqRYQS6wsOrPRUmZTDnpoWyeKv2eTMj5Bjba5jSp75DZeMIpHiXRNUiEdELg4fbFA4VbWv4U1aWUjAFoONVcfr1soDIaklKycODeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439871; c=relaxed/simple;
	bh=wFHSU6gb3Sz2Bqn4Ru9sbl3xVlZ6vE1LlJRPw9jKukw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahXirUo72FNhk07del3Qc4Ij/5N7TlOo4mfj4T0qzjMOqyz72u++tE1w26jXxooveQKISFxQcgJahZ5sZAZoEH5bueTlkzTUJmcPAC86j6JkhV3e734cjzPSXWwxO0P1vbf+4SNtujUnD88TuDQtu/eV6QfkhJ92+pAGDwt+x6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/eiLerR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD3FC19423;
	Wed, 18 Feb 2026 18:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771439870;
	bh=wFHSU6gb3Sz2Bqn4Ru9sbl3xVlZ6vE1LlJRPw9jKukw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/eiLerRqxTOE2SQnDVLvzxEFaghr5sCOqngJpiX/wIElIYlFYyvRM+eWd52SdrnX
	 6hO54wPVjOx8PetiuXBgSHpPQ5ndHCwVh2k6NqT5trOImzCEhKF1oNNN6TLay8SS3A
	 DI6cC8QKB1g7hnRW/lznY7x7qzXLXnBS4y3M7t/rhuMfhNN61lgKl8NUHZdmFLZVPB
	 T+B5jpPXz0gGI7nKnAtYfCTFtUe4urvxhPbZlbo6ZnvdFbb7bbXiqk1zBpQWdamX0i
	 VqRwJsdhbdLRlEnDf8DsY4xByZFsXeDtAncMrncm8N9e151UTmY3GF3JLI5BRJVR04
	 0hIO9jTdgiPlQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>,
 "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
Subject: [PATCH v1 1/2] cpuidle: governors: menu: Refine stopped tick handling
Date: Wed, 18 Feb 2026 19:35:57 +0100
Message-ID: <3037084.e9J7NaK4W3@rafael.j.wysocki>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42833-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B33B0158C1A
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




