Return-Path: <linux-pm+bounces-18257-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B8D9DEC0B
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 19:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56FE2B21DB7
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2024 18:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC41A0BE3;
	Fri, 29 Nov 2024 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kw5XFExZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961DA1A0B04;
	Fri, 29 Nov 2024 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732904573; cv=none; b=RL+WZMS+zWluGc7yhMPYErZ3XmUY4RQ5x88cqYaZx8JfBlXsTICt3kK7wQhiOn+nb2P3YxtnkYhxX5y+pvTsrz1E3QBM/uDjeTBFK9fRLTgJ7sUnFmDYe/kzSiiF5M92FIHdPbychzMNe5GZ/QYyZcwCM+NPLR1qLz2oDBDQh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732904573; c=relaxed/simple;
	bh=LYd2Z7bHeCCWjN/Q2ZNdswf4Q7BqSo9TVw8fJ8XD6jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKdhUyj2Dmd6RGnLZSaK1O7b0cmB/gqc0O6Kah6lrmHEI7kXuY+OQToauuYHJJUgGte7dh7cPTirfOlmRe5vTkCVDL8QTM/sAEFPJkFTxJ9LMPxdsQbb9MCof1DBesGykEolsqCFzKsLW6SkAyhcurZH9Va1XSnP5G2Qidf+/Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kw5XFExZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732904572; x=1764440572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LYd2Z7bHeCCWjN/Q2ZNdswf4Q7BqSo9TVw8fJ8XD6jg=;
  b=kw5XFExZNxRgGuzNNGI5R+0/ez5IR6WE/kBSQQ0tmc9L6RAU4Ea8qlzR
   kjMaOrYWQFYzD36v0oVBfpypJt1ZXW7vlscWd9KuhOfRfJ7pgOLG4NK7d
   kJ9kgHjKC/s/AR+wjU1ePCm2FHJPyScqoOio4yTiUbO+C753a+GLCE/0w
   n7z6DeZBhUxLS0Mm9iKF4OyyFoXwGnzdp1VWODAmGjXmJ9JP6pGc9DVQr
   TZCKbqD6T76FgMdk5S/K+98Uy//CB7AZDkassjIflvgMAQ5NVsesMNVkb
   JuYmftwX/Hw9aDr6NTE0G5TjS5HeCN7zXh9FQd/1U/w05Jaj094+SUWak
   w==;
X-CSE-ConnectionGUID: znKuqCo5SgmU0QJbC+FhqQ==
X-CSE-MsgGUID: TXXWd0YwQDGpN7712O1DMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11271"; a="36811941"
X-IronPort-AV: E=Sophos;i="6.12,196,1728975600"; 
   d="scan'208";a="36811941"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 10:22:51 -0800
X-CSE-ConnectionGUID: bbwd57osQEKlHH8c28PZVg==
X-CSE-MsgGUID: ce4C+h0AQ0iyZhemcpderg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,196,1728975600"; 
   d="scan'208";a="92422113"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.203])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2024 10:22:48 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	gautham.shenoy@amd.com,
	tglx@linutronix.de,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v7 1/4] x86/smp: Allow calling mwait_play_dead with an arbitrary hint
Date: Fri, 29 Nov 2024 19:22:29 +0100
Message-ID: <20241129182232.14987-2-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
References: <20241129182232.14987-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a helper function to allow offlined CPUs to enter FFh idle
states with a specific MWAIT hint. The new helper will be used in
subsequent patches by the acpi_idle and intel_idle drivers.

No functional change intended.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 arch/x86/include/asm/smp.h |  3 ++
 arch/x86/kernel/smpboot.c  | 90 ++++++++++++++++++++------------------
 2 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..dfd09a1e09bf 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
+void mwait_play_dead(unsigned int hint);
 
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
@@ -164,6 +165,8 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return (struct cpumask *)cpumask_of(0);
 }
+
+static inline void mwait_play_dead(unsigned int eax_hint) { }
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b5a8f0891135..8a3545c2cae9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1272,13 +1272,57 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
+void __noreturn mwait_play_dead(unsigned int eax_hint)
+{
+	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
+
+	/* Set up state for the kexec() hack below */
+	md->status = CPUDEAD_MWAIT_WAIT;
+	md->control = CPUDEAD_MWAIT_WAIT;
+
+	wbinvd();
+
+	while (1) {
+		/*
+		 * The CLFLUSH is a workaround for erratum AAI65 for
+		 * the Xeon 7400 series.  It's not clear it is actually
+		 * needed, but it should be harmless in either case.
+		 * The WBINVD is insufficient due to the spurious-wakeup
+		 * case where we return around the loop.
+		 */
+		mb();
+		clflush(md);
+		mb();
+		__monitor(md, 0, 0);
+		mb();
+		__mwait(eax_hint, 0);
+
+		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
+			/*
+			 * Kexec is about to happen. Don't go back into mwait() as
+			 * the kexec kernel might overwrite text and data including
+			 * page tables and stack. So mwait() would resume when the
+			 * monitor cache line is written to and then the CPU goes
+			 * south due to overwritten text, page tables and stack.
+			 *
+			 * Note: This does _NOT_ protect against a stray MCE, NMI,
+			 * SMI. They will resume execution at the instruction
+			 * following the HLT instruction and run into the problem
+			 * which this is trying to prevent.
+			 */
+			WRITE_ONCE(md->status, CPUDEAD_MWAIT_KEXEC_HLT);
+			while(1)
+				native_halt();
+		}
+	}
+}
+
 /*
  * We need to flush the caches before going to sleep, lest we have
  * dirty data in our caches when we come back up.
  */
-static inline void mwait_play_dead(void)
+static inline void mwait_play_dead_cpuid_hint(void)
 {
-	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int highest_cstate = 0;
 	unsigned int highest_subcstate = 0;
@@ -1316,45 +1360,7 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
 
-	/* Set up state for the kexec() hack below */
-	md->status = CPUDEAD_MWAIT_WAIT;
-	md->control = CPUDEAD_MWAIT_WAIT;
-
-	wbinvd();
-
-	while (1) {
-		/*
-		 * The CLFLUSH is a workaround for erratum AAI65 for
-		 * the Xeon 7400 series.  It's not clear it is actually
-		 * needed, but it should be harmless in either case.
-		 * The WBINVD is insufficient due to the spurious-wakeup
-		 * case where we return around the loop.
-		 */
-		mb();
-		clflush(md);
-		mb();
-		__monitor(md, 0, 0);
-		mb();
-		__mwait(eax, 0);
-
-		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
-			/*
-			 * Kexec is about to happen. Don't go back into mwait() as
-			 * the kexec kernel might overwrite text and data including
-			 * page tables and stack. So mwait() would resume when the
-			 * monitor cache line is written to and then the CPU goes
-			 * south due to overwritten text, page tables and stack.
-			 *
-			 * Note: This does _NOT_ protect against a stray MCE, NMI,
-			 * SMI. They will resume execution at the instruction
-			 * following the HLT instruction and run into the problem
-			 * which this is trying to prevent.
-			 */
-			WRITE_ONCE(md->status, CPUDEAD_MWAIT_KEXEC_HLT);
-			while(1)
-				native_halt();
-		}
-	}
+	mwait_play_dead(eax);
 }
 
 /*
@@ -1407,7 +1413,7 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-	mwait_play_dead();
+	mwait_play_dead_cpuid_hint();
 	if (cpuidle_play_dead())
 		hlt_play_dead();
 }
-- 
2.47.1


