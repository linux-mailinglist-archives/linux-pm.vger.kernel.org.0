Return-Path: <linux-pm+bounces-18695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 600E79E6EED
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 14:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B12116CA36
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 13:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269D420C47C;
	Fri,  6 Dec 2024 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N79inSYl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20C5207655;
	Fri,  6 Dec 2024 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490272; cv=none; b=UZzzq5LP2O0dpEwdk3Sh7e9ArdZ/93DMAVPkgNO3XvOnpiIfmdT5DZm3GcXMgDiBJrbsMZ0U8eGe/W7Cgy27WBtjfS1uUt0yOhqgH240XSFtYq4iRKMrRzt+PFByy2Ao2CJmMnamJa6HWUGFs8CRIJI3v+IrfwvimtVs5bmrwvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490272; c=relaxed/simple;
	bh=pAiIzXceRjp6FxVnLb+1NpJxcsd0OOyzRdXDgocx5VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q22fB8oeDS40I9e7QufRmlPePQXFNtbppjVpqezKQUtkrLqc3sWFYRgkbAoAzcdraf6XkWL5aVEam7QmBzm+1lTPGuUbwrpdFPWxPq5ncJDkRLnlNiMOjKc64KB4HdoDwIsnFAwZzc5bkao5uONlV4H2SahFMlTEVV3iOFeUMUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N79inSYl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C48C4CEDF;
	Fri,  6 Dec 2024 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733490270;
	bh=pAiIzXceRjp6FxVnLb+1NpJxcsd0OOyzRdXDgocx5VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N79inSYl0xqIXhRAaoAt++wveZTGUUhPsc4QufIjsd9Y0vJJDA18ildfeplaCgt53
	 xz/jK56qcPjZJDjcnXsVG4hbhG044d9zg9UtKUDTyj9EZwYD1skC7czsdoKCHhxE7k
	 82BFwdKeBqyPf0THDhNPqqmdIpp1C6VkabdATuPlsIipAJ+Sr4WN8HGLd0oB8mCjGn
	 GSnJjs1wXxhhBc6+7uHGCUSs9yIUn3fmLd7zDXsRhLQZ8VJr+te3MXeq5/geV9BxW1
	 4enRbW5bAah1DdxihRA1HLWg6fCCIBoSqmC0M9whGkJni/3DVMdksJd0uPysZI1B7T
	 TTBzffSAO5Gzw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5/5] cpuidle: Handle TIF_NR_POLLING on behalf of software polling idle states
Date: Fri,  6 Dec 2024 14:04:08 +0100
Message-ID: <20241206130408.18690-6-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241206130408.18690-1-frederic@kernel.org>
References: <20241206130408.18690-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Software polling idle states set again TIF_NR_POLLING and clear it upon
exit. This involves error prone duplicated code and wasted cycles
performing atomic operations, sometimes RmW fully ordered.

To avoid this, benefit instead from the same generic TIF_NR_POLLING
handling that is currently in use for hardware monitoring states.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/cpuidle/cpuidle-powernv.c | 10 ----------
 drivers/cpuidle/cpuidle-pseries.c | 11 -----------
 drivers/cpuidle/cpuidle.c         |  2 +-
 drivers/cpuidle/poll_state.c      | 30 ++++++++++++------------------
 4 files changed, 13 insertions(+), 40 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 9ebedd972df0..1bf0d2234016 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -71,8 +71,6 @@ static int snooze_loop(struct cpuidle_device *dev,
 {
 	u64 snooze_exit_time;
 
-	set_thread_flag(TIF_POLLING_NRFLAG);
-
 	local_irq_enable();
 
 	snooze_exit_time = get_tb() + get_snooze_timeout(dev, drv, index);
@@ -81,21 +79,13 @@ static int snooze_loop(struct cpuidle_device *dev,
 	HMT_very_low();
 	while (!need_resched()) {
 		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
-			/*
-			 * Task has not woken up but we are exiting the polling
-			 * loop anyway. Require a barrier after polling is
-			 * cleared to order subsequent test of need_resched().
-			 */
-			clear_thread_flag(TIF_POLLING_NRFLAG);
 			dev->poll_time_limit = true;
-			smp_mb();
 			break;
 		}
 	}
 
 	HMT_medium();
 	ppc64_runlatch_on();
-	clear_thread_flag(TIF_POLLING_NRFLAG);
 
 	local_irq_disable();
 
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index f68c65f1d023..704bb01d9e9e 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -40,8 +40,6 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 {
 	u64 snooze_exit_time;
 
-	set_thread_flag(TIF_POLLING_NRFLAG);
-
 	pseries_idle_prolog();
 	raw_local_irq_enable();
 	snooze_exit_time = get_tb() + snooze_timeout;
@@ -51,21 +49,12 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 		HMT_low();
 		HMT_very_low();
 		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
-			/*
-			 * Task has not woken up but we are exiting the polling
-			 * loop anyway. Require a barrier after polling is
-			 * cleared to order subsequent test of need_resched().
-			 */
 			dev->poll_time_limit = true;
-			clear_thread_flag(TIF_POLLING_NRFLAG);
-			smp_mb();
 			break;
 		}
 	}
 
 	HMT_medium();
-	clear_thread_flag(TIF_POLLING_NRFLAG);
-
 	raw_local_irq_disable();
 
 	pseries_idle_epilog();
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 46c0a2726f67..fecc50c2860e 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -237,7 +237,7 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 		broadcast = false;
 	}
 
-	polling = target_state->flags & CPUIDLE_FLAG_MWAIT;
+	polling = target_state->flags & (CPUIDLE_FLAG_MWAIT | CPUIDLE_FLAG_POLLING);
 
 	/*
 	 * If the target state doesn't poll on need_resched(), this is
diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 9b6d90a72601..d69936e2517e 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -13,35 +13,29 @@
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start;
-
-	time_start = local_clock_noinstr();
+	u64 time_start = local_clock_noinstr();
+	unsigned int loop_count = 0;
+	u64 limit;
 
 	dev->poll_time_limit = false;
 
 	raw_local_irq_enable();
-	if (!current_set_polling_and_test()) {
-		unsigned int loop_count = 0;
-		u64 limit;
 
-		limit = cpuidle_poll_time(drv, dev);
+	limit = cpuidle_poll_time(drv, dev);
 
-		while (!need_resched()) {
-			cpu_relax();
-			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
-				continue;
+	while (!need_resched()) {
+		cpu_relax();
+		if (loop_count++ < POLL_IDLE_RELAX_COUNT)
+			continue;
 
-			loop_count = 0;
-			if (local_clock_noinstr() - time_start > limit) {
-				dev->poll_time_limit = true;
-				break;
-			}
+		loop_count = 0;
+		if (local_clock_noinstr() - time_start > limit) {
+			dev->poll_time_limit = true;
+			break;
 		}
 	}
 	raw_local_irq_disable();
 
-	current_clr_polling();
-
 	return index;
 }
 
-- 
2.46.0


