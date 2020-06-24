Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E412075D5
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jun 2020 16:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390423AbgFXOiy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jun 2020 10:38:54 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56268 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388652AbgFXOiy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2020 10:38:54 -0400
Received: from 89-64-84-125.dynamic.chello.pl (89.64.84.125) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 45514ec22c03a9c3; Wed, 24 Jun 2020 16:38:52 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] intel_idle: Eliminate redundant static variable
Date:   Wed, 24 Jun 2020 16:38:51 +0200
Message-ID: <1731670.qoJTzjjlrN@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The value of the lapic_timer_always_reliable static variable in
the intel_idle driver reflects the boot_cpu_has(X86_FEATURE_ARAT)
value and so it also reflects the static_cpu_has(X86_FEATURE_ARAT)
value.

Hence, the lapic_timer_always_reliable check in intel_idle() is
redundant and apart from this lapic_timer_always_reliable is only
used in two places in which boot_cpu_has(X86_FEATURE_ARAT) can be
used directly.

Eliminate the lapic_timer_always_reliable variable in accordance
with the above observations.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -66,8 +66,6 @@ static struct cpuidle_device __percpu *i
 static unsigned long auto_demotion_disable_flags;
 static bool disable_promotion_to_c1e;
 
-static bool lapic_timer_always_reliable;
-
 struct idle_cpu {
 	struct cpuidle_state *state_table;
 
@@ -142,7 +140,7 @@ static __cpuidle int intel_idle(struct c
 	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
 		leave_mm(cpu);
 
-	if (!static_cpu_has(X86_FEATURE_ARAT) && !lapic_timer_always_reliable) {
+	if (!static_cpu_has(X86_FEATURE_ARAT)) {
 		/*
 		 * Switch over to one-shot tick broadcast if the target C-state
 		 * is deeper than C1.
@@ -1562,7 +1560,7 @@ static int intel_idle_cpu_online(unsigne
 {
 	struct cpuidle_device *dev;
 
-	if (!lapic_timer_always_reliable)
+	if (!boot_cpu_has(X86_FEATURE_ARAT))
 		tick_broadcast_enable();
 
 	/*
@@ -1655,16 +1653,13 @@ static int __init intel_idle_init(void)
 		goto init_driver_fail;
 	}
 
-	if (boot_cpu_has(X86_FEATURE_ARAT))	/* Always Reliable APIC Timer */
-		lapic_timer_always_reliable = true;
-
 	retval = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "idle/intel:online",
 				   intel_idle_cpu_online, NULL);
 	if (retval < 0)
 		goto hp_setup_fail;
 
 	pr_debug("Local APIC timer is reliable in %s\n",
-		 lapic_timer_always_reliable ? "all C-states" : "C1");
+		 boot_cpu_has(X86_FEATURE_ARAT) ? "all C-states" : "C1");
 
 	return 0;
 



