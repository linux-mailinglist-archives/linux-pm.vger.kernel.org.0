Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2947515CDBE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 23:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgBMWFJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 17:05:09 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:52960 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgBMWFJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 17:05:09 -0500
Received: from 79.184.254.199.ipv4.supernova.orange.pl (79.184.254.199) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 593c948fae40964e; Thu, 13 Feb 2020 23:05:06 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/9] intel_idle: Simplify LAPIC timer reliability checks
Date:   Thu, 13 Feb 2020 22:59:22 +0100
Message-ID: <18406440.OXBZXsHz07@kreacher>
In-Reply-To: <2960689.qre192dJKD@kreacher>
References: <2960689.qre192dJKD@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The lapic_timer_always_reliable variable really takes only two values
and some arithmetic in intel_idle() related to comparing it with the
target C-state's MWAIT hint value is unnecessary.

Simplify the code by replacing lapic_timer_always_reliable with
a bool variable lapic_timer_always_reliable and dropping the
LAPIC_TIMER_ALWAYS_RELIABLE symbol along with the excess
computations in intel_idle().

While at it, add a comment explaining the branch taken in intel_idle()
if the LAPIC timer is only reliable in C1 and modify the related debug
message in intel_idle_init() accordingly (the modification of this
message in the only expected functional impact of the change made
here).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d55606608ac8..8d66efc53b89 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -66,10 +66,7 @@ static int max_cstate = CPUIDLE_STATE_MAX - 1;
 static unsigned int disabled_states_mask;
 
 static unsigned int mwait_substates;
-
-#define LAPIC_TIMER_ALWAYS_RELIABLE 0xFFFFFFFF
-/* Reliable LAPIC Timer States, bit 1 for C1 etc.  */
-static unsigned int lapic_timer_reliable_states = (1 << 1);	 /* Default to only C1 */
+static bool lapic_timer_always_reliable;
 
 struct idle_cpu {
 	struct cpuidle_state *state_table;
@@ -908,7 +905,6 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 	unsigned long ecx = 1; /* break on interrupt flag */
 	struct cpuidle_state *state = &drv->states[index];
 	unsigned long eax = flg2MWAIT(state->flags);
-	unsigned int cstate;
 	bool uninitialized_var(tick);
 	int cpu = smp_processor_id();
 
@@ -919,13 +915,16 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
 		leave_mm(cpu);
 
-	if (!static_cpu_has(X86_FEATURE_ARAT)) {
-		cstate = (((eax) >> MWAIT_SUBSTATE_SIZE) &
-				MWAIT_CSTATE_MASK) + 1;
-		tick = false;
-		if (!(lapic_timer_reliable_states & (1 << (cstate)))) {
+	if (!static_cpu_has(X86_FEATURE_ARAT) && !lapic_timer_always_reliable) {
+		/*
+		 * Switch over to one-shot tick broadcast if the target C-state
+		 * is deeper than C1.
+		 */
+		if ((eax >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) {
 			tick = true;
 			tick_broadcast_enter();
+		} else {
+			tick = false;
 		}
 	}
 
@@ -1555,7 +1554,7 @@ static int intel_idle_cpu_online(unsigned int cpu)
 {
 	struct cpuidle_device *dev;
 
-	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
+	if (!lapic_timer_always_reliable)
 		tick_broadcast_enable();
 
 	/*
@@ -1647,15 +1646,15 @@ static int __init intel_idle_init(void)
 	}
 
 	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
-		lapic_timer_reliable_states = LAPIC_TIMER_ALWAYS_RELIABLE;
+		lapic_timer_always_reliable = true;
 
 	retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
 				   intel_idle_cpu_online, NULL);
 	if (retval < 0)
 		goto hp_setup_fail;
 
-	pr_debug("lapic_timer_reliable_states 0x%x\n",
-		 lapic_timer_reliable_states);
+	pr_debug("Local APIC timer is reliable in %s\n",
+		 lapic_timer_always_reliable ? "all C-states" : "C1");
 
 	return 0;
 
-- 
2.16.4





