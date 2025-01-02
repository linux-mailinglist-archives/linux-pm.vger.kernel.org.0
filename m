Return-Path: <linux-pm+bounces-19910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5159E9FFABF
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 16:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917E6162CDC
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A64A1B6D0B;
	Thu,  2 Jan 2025 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKX9u/P9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725C61B414A;
	Thu,  2 Jan 2025 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735830146; cv=none; b=XGxGDWqbDi5VRt31cPM2sj4ZbhZgZihKxgN3rnwfPEeu3N1xcq7wPSUv3JbGF+SwPEGH2fkyocjs6fJDM6cbcNKNeKtzTQ/cVqPS5Surv3Ucuiu+YyPC7JFWXFfvHNr2L3CEVqDDTHjyuCO1UWZ/GHfdfX3DHWFYFT0gxR3EkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735830146; c=relaxed/simple;
	bh=pAiIzXceRjp6FxVnLb+1NpJxcsd0OOyzRdXDgocx5VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjReXWtXx8T0zHAXHnQM+uWBrWBebO9A7Bilom401gixLHk9ufO5HmxmBpbWwJPKRGISOAnB6JldyzUX7QYE7C9w8RPdCK1PaNnwyPAyZZ6qxxHhIzKWAR7hKw097DFW3nrV0Z6hkuTY5AQJZX3ae9333SihT7AUwqdRdle6vp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKX9u/P9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068C1C4CED7;
	Thu,  2 Jan 2025 15:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735830146;
	bh=pAiIzXceRjp6FxVnLb+1NpJxcsd0OOyzRdXDgocx5VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKX9u/P9iy4qqcOJA5BOhYzW+q3TLEVQNBUl8oJG2Gzo+ip+mrH087BUxWnV5TBUY
	 r70G0h/sR53kXvwqtU8ofZbF6uxZYAfz37EF8JpOez7Xe99YgHdmCPu6G5excX89lf
	 2Lj+s8Lca6rUCAux9vKIcTksItE6L0CCflAQEzg8JXL/1mPk1i4/R2ksMRUfxCx6oT
	 L69C27KHWDH8Hmodxp0M5rxRSexDw7ZIzyWOSzxjYpBcnOMepkMfvIfNiFvceAB89t
	 cyYVKu2V0IMz1n4AI2mWT6RkVSxk2t5Fzxi0tQgp3vIj3ZRAppLKjHHzIzVFzgXEv7
	 x5JICyLPpD6dQ==
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
Subject: [PATCH 6/6] cpuidle: Handle TIF_NR_POLLING on behalf of software polling idle states
Date: Thu,  2 Jan 2025 16:02:00 +0100
Message-ID: <20250102150201.21639-7-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250102150201.21639-1-frederic@kernel.org>
References: <20250102150201.21639-1-frederic@kernel.org>
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


