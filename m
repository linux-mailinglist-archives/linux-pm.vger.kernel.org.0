Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 523FB2B28F
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 12:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfE0K4K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 06:56:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55312 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfE0K4K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 06:56:10 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id c71e16143d68c4a3; Mon, 27 May 2019 12:56:08 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     x86 <x86@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Ido Schimmel <idosch@idosch.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] x86: intel_epb: Do not build when CONFIG_PM is unset
Date:   Mon, 27 May 2019 12:56:07 +0200
Message-ID: <3844875.YPkTDDlcrF@kreacher>
In-Reply-To: <20190509174338.GA24432@splinter>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan> <1627338.1fd8ofggM8@kreacher> <20190509174338.GA24432@splinter>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 9ed0985332a6 ("x86: intel_epb: Take CONFIG_PM into account")
prevented the majority of the Performance and Energy Bias Hint (EPB)
handling code from being built when CONFIG_PM is unset to fix a
regression introduced by commit b9c273babce7 ("PM / arch: x86:
MSR_IA32_ENERGY_PERF_BIAS sysfs interface").

In hindsight, however, it would be better to skip all of the EPB
handling code for CONFIG_PM unset as there really is no reason for
it to be there in that case.  Namely, if the EPB is not touched
by the kernel at all with CONFIG_PM unset, there is no need to
worry about modifying the EPB inadvertently on CPU online and since
the system will not suspend or hibernate then, there is no need to
worry about possible modifications of the EPB by the platform
firmware during system-wide PM transitions.

For this reason, revert the changes made by commit 9ed0985332a6
and only allow intel_epb.o to be built when CONFIG_PM is set.

Note that this changes the behavior of the kernels built with
CONFIG_PM unset as they will not modify the EPB on boot if it is
zero initially any more, so it is not a fix strictly speaking, but
users building their kernels with CONFIG_PM unset really should not
expect them to take energy efficiency into account.  Moreover, if
CONFIG_PM is unset for performance reasons, leaving EPB as set
initially by the platform firmware will actually be consistent
with the user's expectations.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is complementary to the EPB handling changes made in the current
development cycle, so IMO it would be good to do it in this cycle too
if there are no technical concerns or objections regarding it.

---
 arch/x86/kernel/cpu/Makefile    |    5 ++++-
 arch/x86/kernel/cpu/intel_epb.c |   22 +---------------------
 2 files changed, 5 insertions(+), 22 deletions(-)

Index: linux-pm/arch/x86/kernel/cpu/Makefile
===================================================================
--- linux-pm.orig/arch/x86/kernel/cpu/Makefile
+++ linux-pm/arch/x86/kernel/cpu/Makefile
@@ -28,7 +28,10 @@ obj-y			+= cpuid-deps.o
 obj-$(CONFIG_PROC_FS)	+= proc.o
 obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
 
-obj-$(CONFIG_CPU_SUP_INTEL)		+= intel.o intel_pconfig.o intel_epb.o
+ifdef CONFIG_CPU_SUP_INTEL
+obj-y			+= intel.o intel_pconfig.o
+obj-$(CONFIG_PM)	+= intel_epb.o
+endif
 obj-$(CONFIG_CPU_SUP_AMD)		+= amd.o
 obj-$(CONFIG_CPU_SUP_HYGON)		+= hygon.o
 obj-$(CONFIG_CPU_SUP_CYRIX_32)		+= cyrix.o
Index: linux-pm/arch/x86/kernel/cpu/intel_epb.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/cpu/intel_epb.c
+++ linux-pm/arch/x86/kernel/cpu/intel_epb.c
@@ -97,7 +97,6 @@ static void intel_epb_restore(void)
 	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, (epb & ~EPB_MASK) | val);
 }
 
-#ifdef CONFIG_PM
 static struct syscore_ops intel_epb_syscore_ops = {
 	.suspend = intel_epb_save,
 	.resume = intel_epb_restore,
@@ -194,25 +193,6 @@ static int intel_epb_offline(unsigned in
 	return 0;
 }
 
-static inline void register_intel_ebp_syscore_ops(void)
-{
-	register_syscore_ops(&intel_epb_syscore_ops);
-}
-#else /* !CONFIG_PM */
-static int intel_epb_online(unsigned int cpu)
-{
-	intel_epb_restore();
-	return 0;
-}
-
-static int intel_epb_offline(unsigned int cpu)
-{
-	return intel_epb_save();
-}
-
-static inline void register_intel_ebp_syscore_ops(void) {}
-#endif
-
 static __init int intel_epb_init(void)
 {
 	int ret;
@@ -226,7 +206,7 @@ static __init int intel_epb_init(void)
 	if (ret < 0)
 		goto err_out_online;
 
-	register_intel_ebp_syscore_ops();
+	register_syscore_ops(&intel_epb_syscore_ops);
 	return 0;
 
 err_out_online:



