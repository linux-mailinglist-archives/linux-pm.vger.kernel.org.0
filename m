Return-Path: <linux-pm+bounces-18692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB659E6EE6
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 14:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 666C918859ED
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 13:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4200420B206;
	Fri,  6 Dec 2024 13:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6R3V9ZK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C82206F1F;
	Fri,  6 Dec 2024 13:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490263; cv=none; b=tldVqpcC5yudQaFXAjZLC+I9FBb24+FTxbkdrXN3acvDBnS+HO63dBERIcSnRDskoHON8o07XX36pJxCz2rSPeIS7vqt44aHMbqOZp03AUiZjJCEgk3j895l72zqliwsC3OvBC/X5eaqx7IPs/KS0b0105aHLzos8patTFXzRAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490263; c=relaxed/simple;
	bh=vnlbtpQU0ZM/p6oSUAtyreorxH4BApB8/i74FdQ9nU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuvYde0+qKHNJcYwl8eunnk8IKmCht87VnyDBZT9lRIeN8I6M2LGGgWxH5R+fHt5efrI2GwkfykpKOoqLgeULuDHAhUFeWTRSkIOUHKzVNpugLCFE8KA0c5pUeMWrvlA3TWAH62//Ndxm2rBQsG2qNGmGCiovIGYiBkJlHaUdDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6R3V9ZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F33BC4CEE2;
	Fri,  6 Dec 2024 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733490262;
	bh=vnlbtpQU0ZM/p6oSUAtyreorxH4BApB8/i74FdQ9nU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6R3V9ZKuAK4GNNEeN5z54qY1XiCDLI7dWdmQd9l4a8L+JgvAxQxRxHxaDeLbB9j/
	 WZojL8el2aMp2iZbVRZC/iMlNEehQThDHTg2CpWr608lUVLlDfVd945t8PfynrGwZP
	 ltPOOYO2/MyALttdoL1jjuVTuvHq+oprhyC0cvjrZhji8p7ZQLZZFpxqf0uGrLtFhk
	 Wf79c6J0Sx4krmaPBvGAICVKCxFFlk+ErJHdwoyJo7Mgn4mbQQmDvLaUEdkExis6wg
	 bYO78iUqspc4EJlmJ7kuZBoHXXV3DiXFJwzObazdYT63kOvYgCCGcSNbsiFESMrJq7
	 hkKaC+QA9rMfA==
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
Subject: [PATCH 2/5] cpuidle: Introduce CPUIDLE_FLAG_MWAIT
Date: Fri,  6 Dec 2024 14:04:05 +0100
Message-ID: <20241206130408.18690-3-frederic@kernel.org>
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

From: Peter Zijlstra <peterz@infradead.org>

Provide a way to tell the cpuidle core about states monitoring
TIF_NEED_RESCHED on the hardware level, monitor/mwait users being the
only examples in use.

This will allow cpuidle core to manage TIF_NR_POLLING on behalf of all
kinds of TIF_NEED_RESCHED watching states while keeping a necessary
distinction for the governors between software loops polling on
TIF_NEED_RESCHED and hardware monitored writes to thread flags.

[fweisbec: _ Initialize flag from acpi_processor_setup_cstates() instead
             of acpi_processor_setup_lpi_states(), as the latter seem to
             be about arm64...
           _ Rename CPUIDLE_FLAG_NO_IPI to CPUIDLE_FLAG_MWAIT]

Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/acpi/processor_idle.c | 3 +++
 drivers/idle/intel_idle.c     | 5 ++++-
 include/linux/cpuidle.h       | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 698897b29de2..66cb5536d91e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -806,6 +806,9 @@ static int acpi_processor_setup_cstates(struct acpi_processor *pr)
 		if (cx->type == ACPI_STATE_C1 || cx->type == ACPI_STATE_C2)
 			drv->safe_state_index = count;
 
+		if (cx->entry_method == ACPI_CSTATE_FFH)
+			state->flags |= CPUIDLE_FLAG_MWAIT;
+
 		/*
 		 * Halt-induced C1 is not good for ->enter_s2idle, because it
 		 * re-enables interrupts on exit.  Moreover, C1 is generally not
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ac4d8faa3886..d52723fbeb04 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1787,7 +1787,8 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 		if (cx->type > ACPI_STATE_C1)
 			state->target_residency *= 3;
 
-		state->flags = MWAIT2flg(cx->address);
+		state->flags = MWAIT2flg(cx->address) | CPUIDLE_FLAG_MWAIT;
+
 		if (cx->type > ACPI_STATE_C2)
 			state->flags |= CPUIDLE_FLAG_TLB_FLUSHED;
 
@@ -2072,6 +2073,8 @@ static bool __init intel_idle_verify_cstate(unsigned int mwait_hint)
 
 static void state_update_enter_method(struct cpuidle_state *state, int cstate)
 {
+	state->flags |= CPUIDLE_FLAG_MWAIT;
+
 	if (state->flags & CPUIDLE_FLAG_INIT_XSTATE) {
 		/*
 		 * Combining with XSTATE with IBRS or IRQ_ENABLE flags
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index a9ee4fe55dcf..b8084617aa27 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -85,6 +85,7 @@ struct cpuidle_state {
 #define CPUIDLE_FLAG_OFF		BIT(4) /* disable this state by default */
 #define CPUIDLE_FLAG_TLB_FLUSHED	BIT(5) /* idle-state flushes TLBs */
 #define CPUIDLE_FLAG_RCU_IDLE		BIT(6) /* idle-state takes care of RCU */
+#define CPUIDLE_FLAG_MWAIT		BIT(7) /* hardware need_resched() monitoring */
 
 struct cpuidle_device_kobj;
 struct cpuidle_state_kobj;
-- 
2.46.0


