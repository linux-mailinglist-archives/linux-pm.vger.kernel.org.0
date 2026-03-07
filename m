Return-Path: <linux-pm+bounces-43907-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOmCDGBOrGlRogEAu9opvQ
	(envelope-from <linux-pm+bounces-43907-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 17:12:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3D222CA68
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 17:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4031301BECE
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DF6314A95;
	Sat,  7 Mar 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCKAQkS/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F5314A9E;
	Sat,  7 Mar 2026 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772899930; cv=none; b=F1gIi/brCA2YueVjggFI5syDdlaQPq1adOy09AN+HEQXm9c0AgyqXa71AIq9cKQMJ+wvWxwo+slgLUASgEt9+fysTI5OHSN9be/r5J/1b/oMXe4BQhGsjLwaNkyvAuhorxKjVCR4u0ulLaPZCA7UTJEsr6BA90sNY5QUmHYx7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772899930; c=relaxed/simple;
	bh=COcBWYVQ3me1XrZcYzsiT/MjFffyneHpAQ+6AOpHX7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oqiWIP4QVVxkpD7FjrYaMdVDm6NmHqBMrBY7WOYtcYut3Zy1u2nBjtx8RtcuXRpIaWJ+L/8ynGgWEaP2wI1qF/4B1q7KYKZ7upt9bBq4NLue+3OdZFpVn9Tc3tDUxbKdZL/JnDPyyUIoCl6jzi2dsZLDhTqP1LElW2jpFX/ZqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCKAQkS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2BBC19422;
	Sat,  7 Mar 2026 16:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772899929;
	bh=COcBWYVQ3me1XrZcYzsiT/MjFffyneHpAQ+6AOpHX7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCKAQkS/OCKSBf8kTCBwM54F6cAAXbj33WhocOM8luROR+fmgNF/nQXWEy4rZlir9
	 X7EJBpdG13OAe3qplmuLPh61CDLXIR6QKhcdwdFgxh9yOVxTD1+fd77huLfqLDyEzh
	 mWOw8Y5J67RCg/QJ4xwnp0eXHqc0SrGVT+phggC6GE+N9FRN2mh8SnPpxkas/tIdA6
	 fjse1+HeeDz6z9keSkMiHkVhCjGWxRisKtNvoJdN0ed555TaJE59qoeN7Xrw1AJKvg
	 L+aSdzQu1AZukyYeCK2BQq1Swcxi4PJ+IaGKwuZkp7tDz7xegogfeMmhT81cMwqIRv
	 V0h73MdJOY5og==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Qais Yousef <qyousef@layalina.io>,
 Christian Loehle <christian.loehle@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject:
 [PATCH v1] sched: idle: Make skipping governor callbacks more consistent
Date: Sat, 07 Mar 2026 17:12:05 +0100
Message-ID: <12857700.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <20260304030306.uk5c63xw4oqvjffb@airbuntu>
References:
 <20260301191959.406218221@kernel.org>
 <CAJZ5v0h-bGU34d9OnhYqdzz+5UiKV1rBEB9NS-TL4=sK2jf-LQ@mail.gmail.com>
 <20260304030306.uk5c63xw4oqvjffb@airbuntu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9D3D222CA68
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-43907-lists,linux-pm=lfdr.de];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the cpuidle governor .select() callback is skipped because there
is only one idle state in the cpuidle driver, the .reflect() callback
should be skipped as well, at least for consistency (if not for
correctness), so do it.

Fixes: e5c9ffc6ae1b ("cpuidle: Skip governor when only one idle state is available")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/cpuidle.c |   10 ----------
 kernel/sched/idle.c       |   11 ++++++++++-
 2 files changed, 10 insertions(+), 11 deletions(-)

--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -359,16 +359,6 @@ noinstr int cpuidle_enter_state(struct c
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		   bool *stop_tick)
 {
-	/*
-	 * If there is only a single idle state (or none), there is nothing
-	 * meaningful for the governor to choose. Skip the governor and
-	 * always use state 0 with the tick running.
-	 */
-	if (drv->state_count <= 1) {
-		*stop_tick = false;
-		return 0;
-	}
-
 	return cpuidle_curr_governor->select(drv, dev, stop_tick);
 }
 
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -221,7 +221,7 @@ static void cpuidle_idle_call(void)
 
 		next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
 		call_cpuidle(drv, dev, next_state);
-	} else {
+	} else if (drv->state_count > 1) {
 		bool stop_tick = true;
 
 		/*
@@ -239,6 +239,15 @@ static void cpuidle_idle_call(void)
 		 * Give the governor an opportunity to reflect on the outcome
 		 */
 		cpuidle_reflect(dev, entered_state);
+	} else {
+		tick_nohz_idle_retain_tick();
+
+		/*
+		 * If there is only a single idle state (or none), there is
+		 * nothing meaningful for the governor to choose.  Skip the
+		 * governor and always use state 0.
+		 */
+		call_cpuidle(drv, dev, 0);
 	}
 
 exit_idle:




