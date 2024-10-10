Return-Path: <linux-pm+bounces-15458-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC4A998801
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 15:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8291F2676D
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 13:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5D01CC156;
	Thu, 10 Oct 2024 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9Kel9SS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD51CC14D;
	Thu, 10 Oct 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567618; cv=none; b=LAtVu2BoD6NCnbSO57vSv96B5t1za/CYh+NMFtjRNfsW3bIF2UO6bfMpI0rkXZh+qIjhBi02qnRq/TaU+8TL+9tYyLVfgxr6IHc1D1Ax7yWm5gEChdiuRqmAivpJ5qSONQLYGAX1IlW0zSZ5lvLHLGiCGkNJZth2Lb6kaSAW64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567618; c=relaxed/simple;
	bh=/vtAg8TAG1CjchAZm8cIV+bE0I35wWJuxX7iZ9Yr3P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kO05WKBI+9UTAr1YR8keGLKrjOKe3Eg5uLQq3MJ4WYmBzBFoWGmTi/uxgdaYqWrRb9mD0jFuuAhqCxZk3CR4euP6M6hJwPWr131JWwdtZ6nPNHmGvNttD6iKy4WqOmNytOVwj6rhIkfcNTJrS6xlmYN6YPdvnKRc+21R+vIX1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9Kel9SS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728567617; x=1760103617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/vtAg8TAG1CjchAZm8cIV+bE0I35wWJuxX7iZ9Yr3P8=;
  b=j9Kel9SSExiC0aCVK6CNeqN/AvPmlvn7EO4C9C1an5m924YJTxUuHkse
   vpMYMQFkoscMgp2yPAh6bmAoD+gkacJxz1yKulUekdBOg5tRi7wuDJQl+
   d0uaKaG4MQhBDre6Xad591QAFoQz2P2Q82k218hjOfdSyN7ZwV5DfANSU
   +lJOgAFviP4iAtQ8ey+jy/BqjgGI+HzP5Vv1ZTK66rbZZoWG4LpD5x77j
   ylnanOFEzebLrf0yoe3hDlmsAh3UKwcs5nXJNOvRn9kYO1vD9vJx1TYG9
   tA+Bk3Oo2j1lYNp0+zvvhJbbPh5H9S0BgpSl5Z/hnESDk6WsDuRq3wC4R
   g==;
X-CSE-ConnectionGUID: 4HJHiLHfQWuNUfiby2LabA==
X-CSE-MsgGUID: HgP6046MRTWrEesS8c8Srw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31718279"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31718279"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:40:17 -0700
X-CSE-ConnectionGUID: Y1/QDPW/RG2qnnP3uM4+9w==
X-CSE-MsgGUID: 5g+tOaTuSqWKmjEe+eM0Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81114926"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.12])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:40:13 -0700
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH 2/3] x86/smp: Allow forcing the mwait hint for play dead loop
Date: Thu, 10 Oct 2024 15:39:54 +0200
Message-ID: <20241010133955.7749-3-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010133955.7749-1-patryk.wlazlyn@linux.intel.com>
References: <20241010133955.7749-1-patryk.wlazlyn@linux.intel.com>
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
index 683898e3b20e..67d1fc976683 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -127,6 +127,9 @@ int __read_mostly __max_smt_threads = 1;
 /* Flag to indicate if a complete sched domain rebuild is required */
 bool x86_topology_update;
 
+#define PLAY_DEAD_MWAIT_HINT_UNSET 0U
+static unsigned int __read_mostly play_dead_mwait_hint = PLAY_DEAD_MWAIT_HINT_UNSET;
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
2.46.2


