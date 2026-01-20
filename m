Return-Path: <linux-pm+bounces-41182-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEDsLpbRb2mgMQAAu9opvQ
	(envelope-from <linux-pm+bounces-41182-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 20:03:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D9249F8C
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 20:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFEA5928032
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A103477E2D;
	Tue, 20 Jan 2026 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0RxOSk0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C59E477E27;
	Tue, 20 Jan 2026 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922778; cv=none; b=EaZTr6LSBzzIHQwYKlDgv80ZU9dLVBttVxBSlpkKKf54uQ0A+2Gh87RWeAD1ZyDQKZ0cad6ZkB0mtcyqgxK26b5tqIM0hTeRGkNUJzytWo0/UXm34Ovshfa91gtzSo/7TV05fZMxXtPuLYaeKM7M7FMzYQ2Omj3sVT87yakvNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922778; c=relaxed/simple;
	bh=YJYvgxBd2qNJndkwJ9WWeubU/T+r3vnDqMWmSrmfqVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iWZSGiAQxH4oJxo4DjFbl+hxfrLnm+gJvEqRlNLH5QeYblJPMzNm/cr7CoixjItvGGdGJmpek6K04YiaT+xNEn0sC1NIpDKLDUdkAIFV8yMjkTwp8fUYIXOGzQIgbZRkbyhn3j5XHvtNftoxQVwdOfF2tn7EBcyU7PBam3ukKhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0RxOSk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C10C16AAE;
	Tue, 20 Jan 2026 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768922778;
	bh=YJYvgxBd2qNJndkwJ9WWeubU/T+r3vnDqMWmSrmfqVs=;
	h=From:To:Cc:Subject:Date:From;
	b=C0RxOSk0OYvizktA1rWo2LIoFcZJmtwYypWad0xbFIJrIchtymBYRX8LkfGdBtHhw
	 Mpq8iRUTbzruF90Q3eyaCzACYBDhbb5xqiL4554xKFVJia0ZPIUjOviMDzLfmBGPDL
	 Ix5R7B2tDECzBnA3uxUYk1m8iGqQWLOSf5FU5tQGULQo+2DIE2O7mY9xfTsh0M2wW3
	 g5PmE5aHk2Sh9i57VabYpYv2lE0Di6MQUf10LPAn6+HgCe4dTgbeFLLPpqXzaHKh7Z
	 X5WGcoWpFI8yxJZzJNUNql4bqXqchkQ+AplCR4orHRWBu9GNSNTpxi9wrUPXR3Btk4
	 53u6PEcT1KRWg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v1] cpuidle: governors: menu: Always check timers with tick stopped
Date: Tue, 20 Jan 2026 16:26:14 +0100
Message-ID: <5959091.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
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
	TAGGED_FROM(0.00)[bounces-41182-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 45D9249F8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 5484e31bbbff ("cpuidle: menu: Skip tick_nohz_get_sleep_length()
call in some cases"), if the return value of get_typical_interval()
multiplied by NSEC_PER_USEC is not greater than RESIDENCY_THRESHOLD_NS,
the menu governor will skip computing the time till the closest timer.
If that happens when the tick has been stopped already, the selected
idle state may be too deep due to the subsequent check comparing
predicted_ns with TICK_NSEC and causing its value to be replaced with
the expected time till the closest timer, which is KTIME_MAX in that
case.  That will cause the deepest enabled idle state to be selected,
but the time till the closest timer very well may be shorter than the
target residency of that state, in which case a shallower state should
be used.

Address this by making menu_select() always compute the time till the
closest timer when the tick has been stopped.

Also move the predicted_ns check mentioned above into the branch in
which the time till the closest timer is determined because it only
needs to be done in that case.

Fixes: 5484e31bbbff ("cpuidle: menu: Skip tick_nohz_get_sleep_length() call in some cases")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -239,7 +239,7 @@ static int menu_select(struct cpuidle_dr
 
 	/* Find the shortest expected idle interval. */
 	predicted_ns = get_typical_interval(data) * NSEC_PER_USEC;
-	if (predicted_ns > RESIDENCY_THRESHOLD_NS) {
+	if (predicted_ns > RESIDENCY_THRESHOLD_NS || tick_nohz_tick_stopped()) {
 		unsigned int timer_us;
 
 		/* Determine the time till the closest timer. */
@@ -259,6 +259,16 @@ static int menu_select(struct cpuidle_dr
 				   RESOLUTION * DECAY * NSEC_PER_USEC);
 		/* Use the lowest expected idle interval to pick the idle state. */
 		predicted_ns = min((u64)timer_us * NSEC_PER_USEC, predicted_ns);
+		/*
+		 * If the tick is already stopped, the cost of possible short
+		 * idle duration misprediction is much higher, because the CPU
+		 * may be stuck in a shallow idle state for a long time as a
+		 * result of it.  In that case, say we might mispredict and use
+		 * the known time till the closest timer event for the idle
+		 * state selection.
+		 */
+		if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
+			predicted_ns = data->next_timer_ns;
 	} else {
 		/*
 		 * Because the next timer event is not going to be determined
@@ -285,16 +295,6 @@ static int menu_select(struct cpuidle_dr
 	}
 
 	/*
-	 * If the tick is already stopped, the cost of possible short idle
-	 * duration misprediction is much higher, because the CPU may be stuck
-	 * in a shallow idle state for a long time as a result of it.  In that
-	 * case, say we might mispredict and use the known time till the closest
-	 * timer event for the idle state selection.
-	 */
-	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
-		predicted_ns = data->next_timer_ns;
-
-	/*
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
 	 */




