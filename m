Return-Path: <linux-pm+bounces-18167-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A512B9DAB95
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 17:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3732819D4
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8EC200B9F;
	Wed, 27 Nov 2024 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glWD8j6+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E8B200BB3;
	Wed, 27 Nov 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724150; cv=none; b=VJjsqY49aKgpnMqxKVycFmx75lrttEq5f3RVfED5lsD1dURWgYJU+g17aN0tas97DnFOhoBwzDphqkiezAKxYB4wdguoxvYlH8pacZ6z3cAfZPRawLVf4sAl/183UtavzFzDffFe8843TpO3LMWQjtLAUGDkbGYtdiZxmOSpUk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724150; c=relaxed/simple;
	bh=wc4zWEKELkAS6PpC+lFAQ2biVVOOJfbXtAHMR5RiDJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDTkwxKDFw/v0QISb6CHrMolQqV0G5XPu/f5yFvSC5ySe94n1FnoZBH1HRVO+bxyqY0akfIO0GL38uW7Q7gfrpV1iu4FZTw54tp7w11nhPN/MOCb3TZset75UT4GMDHqFqqnIJF0fLaS77JSOrftBRJKXC4ao0EsjYRrd5UlOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glWD8j6+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732724148; x=1764260148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wc4zWEKELkAS6PpC+lFAQ2biVVOOJfbXtAHMR5RiDJo=;
  b=glWD8j6+SfULOhQd3ufuO6cx371F6xnfXgZkDa5pcCzqHmSggVI8KbUR
   k9KCv/QptyrBhXPJtn6AHbDw+ohg8xMbpDFqxFxJ6nt/GktjknWKDxll8
   /JdlmWmbGDYPggPoVQHXPoaHgvwYLyp1sVOn+M/a0iW9tMQ6DVa+gP3kr
   Orm7en15FPxJd/JF8Nqf98mCMhMETGm2RjJ4VBHKnA7fDpdficrwt5BjA
   KblCzbmOJdOS/foIse+Abb65NxCjMrZ8R/mi6IitJXYxGKZ6+L3MD3oL8
   NLKEcaFpu0iOPQj3DkksTDJ/p4tyU5s8rQmSGidNtwMikqDWcNpfv7VXK
   g==;
X-CSE-ConnectionGUID: NV4+B8moTbmXFEwp4RxL+g==
X-CSE-MsgGUID: rTJN9+aHRaOCWR9NY3KOTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="43597587"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="43597587"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 08:15:48 -0800
X-CSE-ConnectionGUID: MeolhsYAQlGfnSeonUB9ZQ==
X-CSE-MsgGUID: fhr6MUorQK2r3CfWZdWFZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="97042407"
Received: from mlehtone-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.148])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 08:15:45 -0800
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
Subject: [PATCH v6 1/4] x86/smp: Allow calling mwait_play_dead with an arbitrary hint
Date: Wed, 27 Nov 2024 17:15:15 +0100
Message-ID: <20241127161518.432616-2-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
References: <20241127161518.432616-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MWAIT instruction needs different hints on different CPUs to reach
specific idle states. The current hint calculation in mwait_play_dead()
code works in practice on current Intel hardware, but is not documented
and fails on a recent Intel's Sierra Forest and possibly some future
ones. Those newer CPUs' power efficiency suffers when the CPU is put
offline.

Allow cpuidle code to provide mwait_play_dead with a known hint for
efficient play_dead code.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 arch/x86/include/asm/smp.h |  4 +-
 arch/x86/kernel/smpboot.c  | 86 ++++++++++++++++++++------------------
 2 files changed, 49 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..ab90b95037f3 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
+void mwait_play_dead_with_hint(unsigned int hint);
 
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
@@ -151,7 +152,6 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
 {
 	return per_cpu(cpu_l2c_shared_map, cpu);
 }
-
 #else /* !CONFIG_SMP */
 #define wbinvd_on_cpu(cpu)     wbinvd()
 static inline int wbinvd_on_all_cpus(void)
@@ -164,6 +164,8 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return (struct cpumask *)cpumask_of(0);
 }
+
+static inline void mwait_play_dead_with_hint(unsigned int eax_hint) { }
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index b5a8f0891135..ef112143623d 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1272,13 +1272,57 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
+void __noreturn mwait_play_dead_with_hint(unsigned int eax_hint)
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
2.47.1


