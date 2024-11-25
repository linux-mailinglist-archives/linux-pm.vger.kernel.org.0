Return-Path: <linux-pm+bounces-18054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273A49D8794
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 15:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6600FB3ED6E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 13:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476B11AC427;
	Mon, 25 Nov 2024 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U30kob43"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0072B1ABEA0;
	Mon, 25 Nov 2024 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540864; cv=none; b=ev3ndn4OFPYrZgrFYbRBmUM8SVvsAYhWpLIEQLy4S6SRbY9Sy5vE8TdVp3/cQudKzhJFhua7mKgfel7grR2buMvYP5fbd0/DTDbGsg7iOmWUCuAX4om4oNuRZXukF0D1CL6jjrWRyH+w6g92qxxRYpVN7b5mrCnm02XRV7fb6ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540864; c=relaxed/simple;
	bh=CeeQ0dFzv1BrbotXihAUXKkfZ/dZKppVe1itQis5KWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NX/nVDUWefucq7sQE2moOYfc15EXPO2xBiy8dR9yV5wWCe7D2CpSSmTO6rdSPwY/L7yDUj/ZMbWmYtOi1iVbfu8QDh/QRJPOrhEU+Y/JGnAJafGs8yh+4JT0O8bk9YTQqlwIDZiIJlvwSKzoKLtFWZLESxJD26Tj2So8lDRxGZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U30kob43; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732540862; x=1764076862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CeeQ0dFzv1BrbotXihAUXKkfZ/dZKppVe1itQis5KWg=;
  b=U30kob43mF6SLwQctFBaJL3UcQFxmCsvPQajhyGQzd344dQbpKx+97LK
   sMIX6yZhLKaV9QKvodYn9PAMtkUK2OT+e8rSsdeAj45VHYGFWMHkWRIHL
   I3uuHsR64T7b4uyDrNgEuL6cS+d0APBWlLmYtwCWGcb2tIBnuq25jdKC0
   k2ri3UHAau2LRDd8lyoPWXKF4qiHBJM5dI43cJ0nKmY7Qjs9sFUqwsrY9
   LvpyxZGjd0Nad64DLoBOHlxA6aF7BiDETQVVJDcq6IK26TsmzHHF+Jk5d
   sRGkKro2fm/K/xx/ONhC+mE/b6Omeg8tno23bsb3zA5AJs5wvmHDjRd4B
   w==;
X-CSE-ConnectionGUID: qJUmiTXhQ1m+/ayUZIBb6g==
X-CSE-MsgGUID: 415JR6/GRkGXqTsG+F1NAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11267"; a="43145470"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="43145470"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:21:02 -0800
X-CSE-ConnectionGUID: 16p4D08vSTmZUc1NQPqkgQ==
X-CSE-MsgGUID: x+3URJXKR+2IQQawBLKnbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="91161711"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pwlazlyn-mobl1.intel.com) ([10.245.245.34])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 05:20:57 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	gautham.shenoy@amd.com
Subject: [RFC PATCH v4 4/8] x86/smp: Allow calling mwait_play_dead with arbitrary hint
Date: Mon, 25 Nov 2024 14:20:24 +0100
Message-ID: <20241125132029.7241-5-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
References: <20241125132029.7241-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MWAIT instruction needs different hints on different CPUs to reach
the most specific idle states. The current hint calculation* in
mwait_play_dead() code works in practice on current hardware, but it
fails on a recent one, Intel's Sierra Forest and possibly some future ones.
Those newer CPUs' power efficiency suffers when the CPU is put offline.

 * The current calculation is the for loop inspecting edx in
   mwait_play_dead()

The current implementation for looking up the mwait hint for the deepest
cstate, in mwait_play_dead() code works by inspecting CPUID leaf 0x5 and
calculates the mwait hint based on the number of reported substates.
This approach depends on the hints associated with them to be continuous
in the range [0, NUM_SUBSTATES-1]. This continuity is not documented and
is not met on the recent Intel platforms.

For example, Intel's Sierra Forest report two cstates with two substates
each in cpuid leaf 5:

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

Allow cpuidle code to provide mwait play dead loop with known, mwait
hint for the deepest idle state on a given platform, skipping the cpuid
based calculation.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 arch/x86/include/asm/smp.h |  3 ++
 arch/x86/kernel/smpboot.c  | 86 ++++++++++++++++++++------------------
 2 files changed, 49 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..d12fab4a83c5 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
+void mwait_play_dead_with_hint(unsigned long hint);
 
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
@@ -164,6 +165,8 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return (struct cpumask *)cpumask_of(0);
 }
+
+static inline void mwait_play_dead_with_hint(unsigned long eax_hint) { }
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b5a8f0891135..d0464c7a0af5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1272,13 +1272,57 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
+void __noreturn mwait_play_dead_with_hint(unsigned long eax_hint)
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
 static inline void mwait_play_dead(void)
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
+	mwait_play_dead_with_hint(eax);
 }
 
 /*
-- 
2.47.0


