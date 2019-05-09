Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 078951949A
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 23:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfEIV2p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 17:28:45 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45726 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIV2o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 17:28:44 -0400
Received: from 79.184.254.161.ipv4.supernova.orange.pl (79.184.254.161) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 37c162ea729ea0f2; Thu, 9 May 2019 23:28:42 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Ido Schimmel <idosch@idosch.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] x86: intel_epb: Take CONFIG_PM into account
Date:   Thu, 09 May 2019 23:28:41 +0200
Message-ID: <3431308.1mSSVdqTRr@kreacher>
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

Commit b9c273babce7 (PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs
interface) caused kernels built with CONFIG_PM unset to crash on
systems supporting the Performance and Energy Bias Hint (EPB),
because it attempts to add files to sysfs directories that don't
exist on those systems.

Prevent that from happening by taking CONFIG_PM into account so
that the code depending on it is not compiled at all when it is
not set.

Fixes: b9c273babce7 (PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs interface)
Reported-by: Ido Schimmel <idosch@mellanox.com>
Tested-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/cpu/intel_epb.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

Index: linux-pm/arch/x86/kernel/cpu/intel_epb.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/cpu/intel_epb.c
+++ linux-pm/arch/x86/kernel/cpu/intel_epb.c
@@ -97,6 +97,7 @@ static void intel_epb_restore(void)
 	wrmsrl(MSR_IA32_ENERGY_PERF_BIAS, (epb & ~EPB_MASK) | val);
 }
 
+#ifdef CONFIG_PM
 static struct syscore_ops intel_epb_syscore_ops = {
 	.suspend = intel_epb_save,
 	.resume = intel_epb_restore,
@@ -193,6 +194,25 @@ static int intel_epb_offline(unsigned in
 	return 0;
 }
 
+static inline void register_intel_ebp_syscore_ops(void)
+{
+	register_syscore_ops(&intel_epb_syscore_ops);
+}
+#else /* !CONFIG_PM */
+static int intel_epb_online(unsigned int cpu)
+{
+	intel_epb_restore();
+	return 0;
+}
+
+static int intel_epb_offline(unsigned int cpu)
+{
+	return intel_epb_save();
+}
+
+static inline void register_intel_ebp_syscore_ops(void) {}
+#endif
+
 static __init int intel_epb_init(void)
 {
 	int ret;
@@ -206,7 +226,7 @@ static __init int intel_epb_init(void)
 	if (ret < 0)
 		goto err_out_online;
 
-	register_syscore_ops(&intel_epb_syscore_ops);
+	register_intel_ebp_syscore_ops();
 	return 0;
 
 err_out_online:



