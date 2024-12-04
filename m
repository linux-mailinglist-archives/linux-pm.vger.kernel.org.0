Return-Path: <linux-pm+bounces-18540-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC4C9E3C35
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 15:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633261652F8
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2024 14:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BF61FCCE0;
	Wed,  4 Dec 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWs2YcZV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F881F8AD6;
	Wed,  4 Dec 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321325; cv=none; b=VWE0knzNreWJHsTYTi697nV6pIYEOHV8w3K/m0fh/am8iTlIizVxdddaPqQb7vAebmLHXpwbqDe4cuwSjNIcYOKFptmECMgxKN4/xX1Q2V3OoPoxKeFaqGN5xBJCf2U/6NWhJl8cWvdUQcUyGeMLNw/5O5U0CWKOylGifWNER44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321325; c=relaxed/simple;
	bh=hiq3NjmqUPpOUOzdilX8riGPqCTp70rQ6V6K84wJDUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QHmlWi+t5QKCFyFw0W68xwGmh5CnVX4bVDOie2d3eHcoS1udnCQ99z+wA7ByZllVsYcPTSv22UkAjwucciITzzOnfY7tfqICEnvsSjVb9rpAdD6eUtaF4vCu+hByDp2zaJFE72I5NLak1qibEgEuAxd+7OJc5juqtof1femvE5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWs2YcZV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733321324; x=1764857324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hiq3NjmqUPpOUOzdilX8riGPqCTp70rQ6V6K84wJDUY=;
  b=BWs2YcZV+RD4LX9mwL0P9vnMdPW/UTrwjrtTdR7BChdslj85qE6rv8sZ
   WFhlwS0K0JUUAKzwPVip1qJrt/1xw9xY6WKY604VkG5vPFOD3gqxhBG67
   F1Do1g3ySi2QJFQF/eOqsxWcmduhSOmYFvej6xs/AMxIi3dNKX6+p108O
   RitNcWm1J2rEk2eoSJls29stI9fcanyLmpVWaCB7yoAMtq0TdItjRV90J
   Q6wVHiLt9ecKpXuFRNRXXepudb+fHTuWV8aBflA0CU8EHdJnbIteMtBJe
   ewonGM4Jox62mdqs7j4TRpH9mS8cKGvVnBqCwE2CZGkLbTAlJOEfd9+4e
   w==;
X-CSE-ConnectionGUID: DPutB5hBSjusQ3CjEKOkhg==
X-CSE-MsgGUID: sAqofvFCQ0GiisvPTiCK6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="56071342"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="56071342"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:08:44 -0800
X-CSE-ConnectionGUID: +18tohteRkKeTuDiqtZ7Fg==
X-CSE-MsgGUID: UZ4F0g70Qn2kAfqbeuoQIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="98202772"
Received: from dhhellew-desk2.ger.corp.intel.com.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:08:41 -0800
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
Subject: [PATCH v8 1/4] x86/smp: Allow calling mwait_play_dead with an arbitrary hint
Date: Wed,  4 Dec 2024 15:08:25 +0100
Message-ID: <20241204140828.11699-2-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com>
References: <20241204140828.11699-1-patryk.wlazlyn@linux.intel.com>
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
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
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


