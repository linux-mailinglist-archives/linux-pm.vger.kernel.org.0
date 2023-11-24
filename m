Return-Path: <linux-pm+bounces-205-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DE37F8634
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 23:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369A42825BA
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 22:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34033BB55;
	Fri, 24 Nov 2023 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG5Q5EEg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867D39FEA
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 22:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32778C433CB;
	Fri, 24 Nov 2023 22:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700865180;
	bh=qkwnYSoqlBcfb84gH/3LY3O2XgUdAI1yXrt+QgVwpng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LG5Q5EEgKX6cIW/WbSemc+jpnC4AVH6XFhH2IavHYRsaAdG4Yf+u7scHj7+B1U+6v
	 xAy6ws8g/2QZl9G9qSIivZfAAFEPDvLaEuigQutSypLnKxUcY7qegY5zBggdPdK5mM
	 z0/EUYh2gJ00egk/QgMjyJQAAnXHEv6Ubxa7m8wa9lXW2EnpwOYlhxQmPMusty05N7
	 tBwsmU262FNzth+F8s3JnhxTU7QRrb25NzWeROZxbquU5igA3thQ+tVAKccsE2imGA
	 4zsxcSoRgJUEWm/QC/O8cjb2+EireCnBmjStyIuN4gdVp1mYDxLynBoxICn14o/EXz
	 JCheLVxxPDzAA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 7/7] cpuidle: Handle TIF_NR_POLLING on behalf of software polling idle states
Date: Fri, 24 Nov 2023 23:32:26 +0100
Message-ID: <20231124223226.24249-8-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231124223226.24249-1-frederic@kernel.org>
References: <20231124223226.24249-1-frederic@kernel.org>
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
handling that is currently in use for hardware polling states.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/cpuidle/cpuidle-powernv.c | 10 ----------
 drivers/cpuidle/cpuidle-pseries.c | 11 -----------
 drivers/cpuidle/cpuidle.c         |  4 ++--
 drivers/cpuidle/poll_state.c      | 30 ++++++++++++------------------
 4 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 675b8eb81ebd..b88bbf7ead41 100644
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
index 4e08c9a39172..0ae76512b740 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -39,8 +39,6 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 {
 	u64 snooze_exit_time;
 
-	set_thread_flag(TIF_POLLING_NRFLAG);
-
 	pseries_idle_prolog();
 	raw_local_irq_enable();
 	snooze_exit_time = get_tb() + snooze_timeout;
@@ -50,21 +48,12 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
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
index 49078cc83f4a..9eb811b5d8b6 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -236,8 +236,8 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
 		broadcast = false;
 	}
 
-	polling = target_state->flags & CPUIDLE_FLAG_POLLING_HARD;
-
+	polling = (target_state->flags & (CPUIDLE_FLAG_POLLING_SOFT |
+					  CPUIDLE_FLAG_POLLING_HARD));
 	/*
 	 * If the target state doesn't poll on need_resched(), this is
 	 * the last check after which further TIF_NEED_RESCHED remote setting
diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index a2fe173de117..3bfa251b344a 100644
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
2.42.1


