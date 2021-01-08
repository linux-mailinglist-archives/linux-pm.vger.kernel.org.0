Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F6F2EF6FA
	for <lists+linux-pm@lfdr.de>; Fri,  8 Jan 2021 19:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbhAHSGo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Jan 2021 13:06:44 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:43634 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbhAHSGn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2021 13:06:43 -0500
Received: from 89-64-81-105.dynamic.chello.pl (89.64.81.105) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id f8e5a3c0ad700087; Fri, 8 Jan 2021 19:06:01 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        x86 Maintainers <x86@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH] x86: PM: Register syscore_ops for scale invariance
Date:   Fri, 08 Jan 2021 19:05:59 +0100
Message-ID: <1803209.Mvru99baaF@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

On x86 scale invariace tends to be disabled during resume from
suspend-to-RAM, because the MPERF or APERF MSR values are not as
expected then due to updates taking place after the platform
firmware has been invoked to complete the suspend transition.

That, of course, is not desirable, especially if the schedutil
scaling governor is in use, because the lack of scale invariance
causes it to be less reliable.

To counter that effect, modify init_freq_invariance() to register
a syscore_ops object for scale invariance with the ->resume callback
pointing to init_counter_refs() which will run on the CPU starting
the resume transition (the other CPUs will be taken care of the
"online" operations taking place later).

Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in frequency invariant accounting")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/smpboot.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

Index: linux-pm/arch/x86/kernel/smpboot.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/smpboot.c
+++ linux-pm/arch/x86/kernel/smpboot.c
@@ -56,6 +56,7 @@
 #include <linux/numa.h>
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
+#include <linux/syscore_ops.h>
 
 #include <asm/acpi.h>
 #include <asm/desc.h>
@@ -2083,6 +2084,23 @@ static void init_counter_refs(void)
 	this_cpu_write(arch_prev_mperf, mperf);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static struct syscore_ops freq_invariance_syscore_ops = {
+	.resume = init_counter_refs,
+};
+
+static void register_freq_invariance_syscore_ops(void)
+{
+	/* Bail out if registered already. */
+	if (freq_invariance_syscore_ops.node.prev)
+		return;
+
+	register_syscore_ops(&freq_invariance_syscore_ops);
+}
+#else
+static inline void register_freq_invariance_syscore_ops(void) {}
+#endif
+
 static void init_freq_invariance(bool secondary, bool cppc_ready)
 {
 	bool ret = false;
@@ -2109,6 +2127,7 @@ static void init_freq_invariance(bool se
 	if (ret) {
 		init_counter_refs();
 		static_branch_enable(&arch_scale_freq_key);
+		register_freq_invariance_syscore_ops();
 		pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
 	} else {
 		pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");



