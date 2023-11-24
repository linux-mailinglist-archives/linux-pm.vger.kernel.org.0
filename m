Return-Path: <linux-pm+bounces-203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105B87F8631
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 23:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C133C282617
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 22:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5407A28DD8;
	Fri, 24 Nov 2023 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhjYZ3hd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639939FD4
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 22:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C45C433CA;
	Fri, 24 Nov 2023 22:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700865175;
	bh=ihqiqz3/q3v0Bf/+UnffiXh+sdvTju3BkjA83XED8zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhjYZ3hdtcsr4cC2W098SMu6zoephrorXSVCY5em38yU+gwCG+wIbyfqAO5PIbzKf
	 tpgkQTEkCx2BhLpfxsUTVI1DINEJBJNxF8fz1n+KANI31MWexPQH3mJGySsf37sBIa
	 7JTR4ATQUG271FQF/loFOAG+Qy+pw6gXOY2hmEO/zE+7SbyQbgonGchdZuAWoBHXz3
	 NyqO5oLTc6q1G4XtfFP8o5ebtW7fl0Y+NHtxQN3xJsqpkEtLZz7lOm5gFGd9x4tN41
	 4aVIZc/aiXkcOGYn2HvpRnYA6ByplMGp8WiKQSYvKvElSVGswR05pETHCE4Ae89CMp
	 f1LRSNULka0wQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 5/7] cpuidle: Introduce CPUIDLE_FLAG_POLLING_HARD
Date: Fri, 24 Nov 2023 23:32:24 +0100
Message-ID: <20231124223226.24249-6-frederic@kernel.org>
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

From: Peter Zijlstra <peterz@infradead.org>

Provide a way to tell the cpuidle core about states polling/monitoring
TIF_NEED_RESCHED on the hardware level, monitor/mwait users being the
only examples in use.

This will allow cpuidle core to manage TIF_NR_POLLING on behalf of all
kinds of TIF_NEED_RESCHED polling states while keeping a necessary
distinction for the governors between software loops polling on
TIF_NEED_RESCHED and hardware monitored writes to thread flags.

[fweisbec: _ Initialize flag from acpi_processor_setup_cstates() instead
             of acpi_processor_setup_lpi_states(), as the latter seem to
             be about arm64...
           _ Rename CPUIDLE_FLAG_NO_IPI to CPUIDLE_FLAG_POLLING_HARD]

Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/acpi/processor_idle.c | 3 +++
 drivers/idle/intel_idle.c     | 5 ++++-
 include/linux/cpuidle.h       | 3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 3a34a8c425fe..a77a4d4b0dad 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -814,6 +814,9 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 			if (cx->type != ACPI_STATE_C3)
 				drv->safe_state_index = count;
 		}
+
+		if (cx->entry_method == ACPI_CSTATE_FFH)
+			state->flags |= CPUIDLE_FLAG_POLLING_HARD;
 		/*
 		 * Halt-induced C1 is not good for ->enter_s2idle, because it
 		 * re-enables interrupts on exit.  Moreover, C1 is generally not
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 3e01a6b23e75..bc56624fe0b5 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1563,7 +1563,8 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 		if (cx->type > ACPI_STATE_C1)
 			state->target_residency *= 3;
 
-		state->flags = MWAIT2flg(cx->address);
+		state->flags = MWAIT2flg(cx->address) | CPUIDLE_FLAG_POLLING_HARD;
+
 		if (cx->type > ACPI_STATE_C2)
 			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
 
@@ -1836,6 +1837,8 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
 
 static void state_update_enter_method(struct cpuidle_state *state, int cstate)
 {
+	state->flags |= CPUIDLE_FLAG_POLLING_HARD;
+
 	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
 		/*
 		 * Combining with XSTATE with IBRS or IRQ_ENABLE flags
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 66b59868622c..873fdf200dc3 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -78,13 +78,14 @@ struct cpuidle_state {
 
 /* Idle State Flags */
 #define CPUIDLE_FLAG_NONE       	(0x00)
-#define CPUIDLE_FLAG_POLLING_SOFT		BIT(0) /* polling state */
+#define CPUIDLE_FLAG_POLLING_SOFT	BIT(0) /* software need_resched() polling state */
 #define CPUIDLE_FLAG_COUPLED		BIT(1) /* state applies to multiple cpus */
 #define CPUIDLE_FLAG_TIMER_STOP 	BIT(2) /* timer is stopped on this state */
 #define CPUIDLE_FLAG_UNUSABLE		BIT(3) /* avoid using this state */
 #define CPUIDLE_FLAG_OFF		BIT(4) /* disable this state by default */
 #define CPUIDLE_FLAG_TLB_FLUSHED	BIT(5) /* idle-state flushes TLBs */
 #define CPUIDLE_FLAG_RCU_IDLE		BIT(6) /* idle-state takes care of RCU */
+#define CPUIDLE_FLAG_POLLING_HARD	BIT(7) /* hardware need_resched() polling state */
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
-- 
2.42.1


