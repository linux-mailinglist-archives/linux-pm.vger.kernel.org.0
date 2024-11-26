Return-Path: <linux-pm+bounces-18136-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8F49D9E51
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 21:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0772850F2
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 20:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BA51DF747;
	Tue, 26 Nov 2024 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CItlMpWR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397A21DF255;
	Tue, 26 Nov 2024 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652164; cv=none; b=Gd6uuT2NfP/UV4vfNOuO/3+fBVeVektoDlo6F3g4W8Qe2/6RxbgGc/Pu/qThUvIyd4XqYHC3xASy3M8ZoG//m6kASf87AVlmMQmIf7JW4AkXO/XDwr/URAtzTyzLUE83phD/QVJjKeuhBgvqjlPGzW2AuRc+ugE/48P0XTC59ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652164; c=relaxed/simple;
	bh=tLTcOIyNI/MsmVTvIjNqiTC1HMXXKD2Lm4GN5eOVPvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUZx4bpLCBVzBGBkGzRpymEcm9F1NN0bppf6gyg/MhZVvVNXQ8fU2THrOdLvFhLZaMkoKgUuo+1HyBbnL3vhQip2WiF+CVtjHV0+kCGvHnD0Zb/D/vpzoAss4GoO5Z0d9BTMSZ5NNbnl7n+joqY07B/lQR/MLjxB5UjB4g4HjS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CItlMpWR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732652163; x=1764188163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tLTcOIyNI/MsmVTvIjNqiTC1HMXXKD2Lm4GN5eOVPvY=;
  b=CItlMpWRnOYSMUk6QNWT14ERTRqAOJIx0w0o4bUUG0zYqCuVDC1enYm1
   KEXm+5HMLrF2UtoZN5TlZg3a2zS3KDYH+ig36AaKrC95LW0Qf9fvy3M2X
   QZpOKNEUhfwrooy4sprL8jd3Jpsv+ALs6RL66uYns3un6iNxoCOMsafa2
   0y5MFPJbzGXiH/TtWEryeRMHU3AjEE4mvuh9hfw1kSSZoutwJ/kLGa2By
   Aarj1y1bUcWRIFiLsyOK+1QfZKCzxylwvvNyb6GrzjcZ7lOaBaCJXQjyV
   XlCIXCh3V04lRjnW5FCWcoS6CMjODt/O3QDrM30mKG4d+FuN+3m11DG2g
   g==;
X-CSE-ConnectionGUID: 0t6A/WHzSCKXEu5rybzgVw==
X-CSE-MsgGUID: 6PG0jkwtS3WQqjARK8i+ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36624203"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="36624203"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 12:16:03 -0800
X-CSE-ConnectionGUID: ErZkSzwYRCCywixTxpgpPQ==
X-CSE-MsgGUID: OBxY6uKUR2SAdii8aquCBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="92047557"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.172])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 12:16:00 -0800
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
Subject: [PATCH v5 1/3] x86/smp: Allow calling mwait_play_dead with an arbitrary hint
Date: Tue, 26 Nov 2024 21:15:37 +0100
Message-ID: <20241126201539.477448-2-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241126201539.477448-1-patryk.wlazlyn@linux.intel.com>
References: <20241126201539.477448-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MWAIT instruction needs different hints on different CPUs to reach
specific idle states. The current hint calculation* in mwait_play_dead()
code works in practice on current Intel hardware, but it fails on a
recent one, Intel's Sierra Forest and possibly some future ones.  Those
newer CPUs' power efficiency suffers when the CPU is put offline.

* The current algorithm for looking up the mwait hint for the deepest
cstate, in mwait_play_dead() code works by inspecting CPUID leaf 0x5 and
calculates the mwait hint based on the number of reported substates.
This approach depends on the hints associated with them to be continuous
in the range [0, NUM_SUBSTATES-1]. This continuity is not documented and
is not met on the recent Intel platforms.

For example, Intel's Sierra Forest report two cstates with two substates
each in cpuid leaf 0x5:

  Name*   target cstate    target subcstate (mwait hint)
  ===========================================================
  C1      0x00             0x00
  C1E     0x00             0x01

  --      0x10             ----

  C6S     0x20             0x22
  C6P     0x20             0x23

  --      0x30             ----

  /* No more (sub)states all the way down to the end. */
  ===========================================================

   * Names of the cstates are not included in the CPUID leaf 0x5, they are
     taken from the product specific documentation.

Notice that hints 0x20 and 0x21 are skipped entirely for the target
cstate 0x20 (C6), being a cause of the problem for the current cpuid
leaf 0x5 algorithm.

Allow cpuidle code to call mwait play dead loop with a known hint for
the deepest idle state on a given platform, skipping the cpuid based
calculation.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 arch/x86/include/asm/smp.h |  3 +++
 arch/x86/kernel/smpboot.c  | 46 +++++---------------------------------
 2 files changed, 8 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..633b4a4aec6b 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
+void mwait_play_dead(unsigned long hint);
 
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
@@ -164,6 +165,8 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return (struct cpumask *)cpumask_of(0);
 }
+
+static inline void mwait_play_dead(unsigned long eax_hint) { }
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b5a8f0891135..5dc143e1d6af 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1276,45 +1276,9 @@ void play_dead_common(void)
  * We need to flush the caches before going to sleep, lest we have
  * dirty data in our caches when we come back up.
  */
-static inline void mwait_play_dead(void)
+void __noreturn mwait_play_dead(unsigned long eax_hint)
 {
 	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
-	unsigned int eax, ebx, ecx, edx;
-	unsigned int highest_cstate = 0;
-	unsigned int highest_subcstate = 0;
-	int i;
-
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		return;
-	if (!this_cpu_has(X86_FEATURE_MWAIT))
-		return;
-	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
-		return;
-	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
-		return;
-
-	eax = CPUID_MWAIT_LEAF;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-
-	/*
-	 * eax will be 0 if EDX enumeration is not valid.
-	 * Initialized below to cstate, sub_cstate value when EDX is valid.
-	 */
-	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED)) {
-		eax = 0;
-	} else {
-		edx >>= MWAIT_SUBSTATE_SIZE;
-		for (i = 0; i < 7 && edx; i++, edx >>= MWAIT_SUBSTATE_SIZE) {
-			if (edx & MWAIT_SUBSTATE_MASK) {
-				highest_cstate = i;
-				highest_subcstate = edx & MWAIT_SUBSTATE_MASK;
-			}
-		}
-		eax = (highest_cstate << MWAIT_SUBSTATE_SIZE) |
-			(highest_subcstate - 1);
-	}
 
 	/* Set up state for the kexec() hack below */
 	md->status = CPUDEAD_MWAIT_WAIT;
@@ -1335,7 +1299,7 @@ static inline void mwait_play_dead(void)
 		mb();
 		__monitor(md, 0, 0);
 		mb();
-		__mwait(eax, 0);
+		__mwait(eax_hint, 0);
 
 		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
 			/*
@@ -1407,9 +1371,9 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-	mwait_play_dead();
-	if (cpuidle_play_dead())
-		hlt_play_dead();
+	/* Below returns only on error. */
+	cpuidle_play_dead();
+	hlt_play_dead();
 }
 
 #else /* ... !CONFIG_HOTPLUG_CPU */
-- 
2.47.1


