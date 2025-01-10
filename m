Return-Path: <linux-pm+bounces-20200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF43A08FE8
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7551D7A51F6
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BAD20C035;
	Fri, 10 Jan 2025 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4w6dVzj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C10320C024;
	Fri, 10 Jan 2025 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510408; cv=none; b=aWIQisPAIFdWWmH7usvLsTbmi04r22/GPJTWrtPwr+YstDVoGG+Dqjo2SNaez83z6d7J3NnMPiJurPedwq+sxlDGkGCJSfXFvDlxx/dhHE/Gg7X4jbA/XyKgWwCOOQAK2WSBkDAHyt20rysj17EZmpo0uf+C4Mn3xFVcH0jLvh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510408; c=relaxed/simple;
	bh=hiq3NjmqUPpOUOzdilX8riGPqCTp70rQ6V6K84wJDUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCOe3UpZsDmxQYp0bV3SUk1/l9kXpjTlH1UPRhZseOrzHBeh21ko52TTa9s83VZqAu8w1R+Y4xyllYQo/cf0vWuztVlLUTdKlw7ZeyI7QZkQDUzVKqDSSAqZ83zZjUArXizh3nJbDsiH3qjOtWK9NVCFGbAFfASxezmBF+Q0hZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4w6dVzj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736510406; x=1768046406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hiq3NjmqUPpOUOzdilX8riGPqCTp70rQ6V6K84wJDUY=;
  b=j4w6dVzjsXCstnMvtqzEW15pk7yUyjUFwUJDJvelh9HWDUmwtNCogu+t
   whGNBQh6Fzu/YzcLNhjYbKeZ7ginA3moqroUeA2CedMcV/yrqb6uymtW0
   ho7AqivJt7nb5f/eYPS4e60WEzPXkY3TsYsOSjkCSyc42sSCLJv4gXzP1
   jQCooVU6q+kUQ5iYlyw4CtbKc/NsxBPTFZ39ZvJwCaYOV1zPQwvRztkfa
   209E6z9yATNuZ4qtfvrytA52pDcTbrLL9IOBnue55TPZBiHCxJtETZ5Ux
   MTuVBZbFit5Nk1gEDz4dYKNsAuqNPSRpjeQ087+fcvqsXBfd4CUDVTeEz
   Q==;
X-CSE-ConnectionGUID: NZPneuZ9TL+4nlV5yTALiQ==
X-CSE-MsgGUID: gcjVas+QTS67iemoZGgwFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="40743770"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="40743770"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 04:00:06 -0800
X-CSE-ConnectionGUID: xtLEIwiHQNS2f4eZ9clkBQ==
X-CSE-MsgGUID: QsGe5Bc5RGS4okEnNltXxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="108635969"
Received: from ksztyber-mobl2.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.160])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 04:00:03 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v9 1/4] x86/smp: Allow calling mwait_play_dead with an arbitrary hint
Date: Fri, 10 Jan 2025 12:59:50 +0100
Message-ID: <20250110115953.6058-2-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110115953.6058-1-patryk.wlazlyn@linux.intel.com>
References: <20250110115953.6058-1-patryk.wlazlyn@linux.intel.com>
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


