Return-Path: <linux-pm+bounces-16655-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9C69B4680
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 11:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359D91C226EB
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 10:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A9F20494B;
	Tue, 29 Oct 2024 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJR3kn8u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2483F204F74;
	Tue, 29 Oct 2024 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196942; cv=none; b=b+VCONxr3YIlhdSCGo0DvaFOcQvIBUsHm4dN2V9+owLc/+dyN/Ud3IAnX6RVLNQudUgN1jtDu4Lesk78sXEKr5UJofq/MFXMgTh0J8gFwPYbr10byjF2LQyUlZFGdoQrxqwu1zdIPKEpuboEF7bs8PdG1K5SdhIgnBHfsuahMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196942; c=relaxed/simple;
	bh=AmdziJTruptBgthbP1kO8JhRYQ48WuaGHdC/UKqmZi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofvy51qS/iLGbvar5BL1w23wAbFPNgHFPEj6Bu8EuouaiN9OWY4Z+G0flTJ6d1r77ye+kaEuCVGymlptcKxQqZF/FSrQ5ytxFugVmRwSl1S+7tXzMdFsyECmZxyXEf6RkdfYzWZuHHJe9oEKriMQH5cSo4AJlC0hWSBANYYu63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJR3kn8u; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730196940; x=1761732940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AmdziJTruptBgthbP1kO8JhRYQ48WuaGHdC/UKqmZi0=;
  b=eJR3kn8uKo6dmy0RPH3jLVKp7t45w6K/+Fb3BNDU9qTwCs35mIR/fKwB
   ZWqIdTBc5PwPZcDPVlXdhEWHQpU7cvLaOP+n5HGzlYnDXbZidsLN8suNw
   Kqwwaz0ifDzDEP/HJExSF9jsqSjuBuV9Nb6noR0Ue7ouOytjMwiBUsZzn
   yyIsPREdYW4vdQPH49U23AXTpJ3hKwwUmQheLC8hbFzTreAq0x4tulr29
   BjbYYb23yecPuGP01xfQK5r8AcgJrcClgmN2TIV13dx6sv7OLBBjX2YQJ
   IeSxsDTKuXLA/Z96VELJiMgVOOuZzt+kP8s+xSuktPghjLljK17DYJtUL
   A==;
X-CSE-ConnectionGUID: YpmHnXnsQYe3v7h5fu0QoA==
X-CSE-MsgGUID: 6WPcbuYBTWSNMnI+wfHiog==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="33624102"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="33624102"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:15:40 -0700
X-CSE-ConnectionGUID: KUavw6ZoQpaqvZZTYbUi+g==
X-CSE-MsgGUID: Ep3C9lTdTtGbQ3gfNSXziQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="119375287"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.58])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:15:36 -0700
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v2 2/3] x86/smp: Allow forcing the mwait hint for play dead loop
Date: Tue, 29 Oct 2024 11:15:06 +0100
Message-ID: <20241029101507.7188-3-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029101507.7188-1-patryk.wlazlyn@linux.intel.com>
References: <20241029101507.7188-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation for looking up the mwait hint for the deepest
cstate depends on them to be continuous in range [0, NUM_SUBSTATES-1].
While that is correct on most Intel x86 platforms, it is not
architectural and may not result in reaching the most optimized idle
state on some of them.

For example Intel's Sierra Forest report two C6 substates in cpuid leaf 5:
    C6S  (hint 0x22)
    C6SP (hint 0x23)

Hints 0x20 and 0x21 are skipped entirely, causing the current
implementation to compute the wrong hint, when looking for the deepest
cstate for offlined CPU to enter. As a result, package with an offlined
CPU can never reach PC6.

Allow the idle driver to communicate the deepest idle cstate to the x86
offline code.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 arch/x86/include/asm/smp.h |  3 +++
 arch/x86/kernel/smpboot.c  | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f40698f..2cb083a84225 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
+void smp_set_mwait_play_dead_hint(unsigned int hint);
 
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
@@ -164,6 +165,8 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return (struct cpumask *)cpumask_of(0);
 }
+
+static inline void smp_set_mwait_play_dead_hint(unsigned int hint) { }
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 683898e3b20e..08f7b43f3fc3 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -127,6 +127,9 @@ int __read_mostly __max_smt_threads = 1;
 /* Flag to indicate if a complete sched domain rebuild is required */
 bool x86_topology_update;
 
+#define PLAY_DEAD_MWAIT_HINT_UNSET 0U
+static unsigned int __read_mostly play_dead_mwait_hint;
+
 int arch_update_cpu_topology(void)
 {
 	int retval = x86_topology_update;
@@ -1270,6 +1273,11 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
+void smp_set_mwait_play_dead_hint(unsigned int hint)
+{
+	WRITE_ONCE(play_dead_mwait_hint, hint);
+}
+
 /* Computes mwait hint for the deepest mwait hint based on cpuid leaf 0x5 */
 static inline unsigned int get_deepest_mwait_hint(void)
 {
@@ -1322,7 +1330,9 @@ static inline void mwait_play_dead(void)
 	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
 		return;
 
-	hint = get_deepest_mwait_hint();
+	hint = READ_ONCE(play_dead_mwait_hint);
+	if (hint == PLAY_DEAD_MWAIT_HINT_UNSET)
+		hint = get_deepest_mwait_hint();
 
 	/* Set up state for the kexec() hack below */
 	md->status = CPUDEAD_MWAIT_WAIT;
-- 
2.47.0


