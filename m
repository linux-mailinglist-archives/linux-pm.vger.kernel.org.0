Return-Path: <linux-pm+bounces-16654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650049B467E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 11:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12AC31F23BEB
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 10:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8024A20495A;
	Tue, 29 Oct 2024 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2oQx7V4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938620494B;
	Tue, 29 Oct 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196938; cv=none; b=lRUdKU+Ki8VPyDpzWXLcifsPou9ioe62YParSOQfGyUenZABroXJHYDsanxTv2KTuIlgF958PfJJgJMZ+LltbkCR7/dFy+85XDZRqBnm2fQ2SoCtzJ7XbftP0NofRVMvcCaLZ5/Qe5K/BxgQ8bOiq+dgk5t3HyYUQVp3c+LM1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196938; c=relaxed/simple;
	bh=ll+KMMKsIpAPHwvjoTYrT6EqV+8eotFfO6RGKcxRknU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZ+mySk0yKWHzUBmB6h1ZU/qe/iYx4eXJa6Rxr0b54ekFytAE04exfLUIAP/0s1v0s15GzkfcZhCdLUDTCANjzmjm911bC5e1AlyFb3G+N1OuY0hh1O0pb7D6T8GKmeJcs00gmF4q2VWiexX0o3GBLJKuDmtquC9pXuQ2z4hsME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2oQx7V4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730196936; x=1761732936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ll+KMMKsIpAPHwvjoTYrT6EqV+8eotFfO6RGKcxRknU=;
  b=W2oQx7V4dlEqq9hzyVbM41vf5rfL59jYkeRSOuEDroUkiuMdXOc7Tp7C
   BQsjV9H4skM7aZlALzRNsjxXmyLHcnlothe6wiAJmJd9htdAGNSae9ypS
   95xg7E/kU5QuJbnWY8xN7YJmUZuqcGpX8J0strQQnkevrALFCfXSHruXg
   GyEcsjN1Y04VpcMZVK/VyDIsMjf4Xkq0s7q4k91WgnLgvfrDwiZIcfWay
   +yHrVos5RnJ7/BM4HRR3hOMQk+2pUc8llRfhyzXEW0GGIo22fBWfb9/Hn
   QNDkIADtK/GmLmyHP1v4RC50+ncUZcbQf74/rUy4z8OvFOLUeBufNSNec
   g==;
X-CSE-ConnectionGUID: mVI59gPuReGP3EkJf8vcBw==
X-CSE-MsgGUID: a1SIZ0fDTo2BMshxgERbrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="33624090"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="33624090"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:15:36 -0700
X-CSE-ConnectionGUID: FIA7ZBvsQkug3NFSZfeu9g==
X-CSE-MsgGUID: qPlMIO4VSwyZNf3/9Ge+ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="119375276"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.58])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:15:33 -0700
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH v2 1/3] x86/smp: Move mwait hint computation out of mwait_play_dead
Date: Tue, 29 Oct 2024 11:15:05 +0100
Message-ID: <20241029101507.7188-2-patryk.wlazlyn@linux.intel.com>
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

The following patches will provide a way for idle driver to set the
mwait hint for offline code to use to reach the deepest cstate.

Make the following changes simpler by moving the mwait hint computation
to a separate function.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 arch/x86/kernel/smpboot.c | 44 ++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0c35207320cb..683898e3b20e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1270,28 +1270,14 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
-/*
- * We need to flush the caches before going to sleep, lest we have
- * dirty data in our caches when we come back up.
- */
-static inline void mwait_play_dead(void)
+/* Computes mwait hint for the deepest mwait hint based on cpuid leaf 0x5 */
+static inline unsigned int get_deepest_mwait_hint(void)
 {
-	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int highest_cstate = 0;
 	unsigned int highest_subcstate = 0;
 	int i;
 
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
 	eax = CPUID_MWAIT_LEAF;
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
@@ -1314,6 +1300,30 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
 
+	return eax;
+}
+
+/*
+ * We need to flush the caches before going to sleep, lest we have
+ * dirty data in our caches when we come back up.
+ */
+static inline void mwait_play_dead(void)
+{
+	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
+	unsigned int hint;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		return;
+	if (!this_cpu_has(X86_FEATURE_MWAIT))
+		return;
+	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
+		return;
+	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
+		return;
+
+	hint = get_deepest_mwait_hint();
+
 	/* Set up state for the kexec() hack below */
 	md->status = CPUDEAD_MWAIT_WAIT;
 	md->control = CPUDEAD_MWAIT_WAIT;
@@ -1333,7 +1343,7 @@ static inline void mwait_play_dead(void)
 		mb();
 		__monitor(md, 0, 0);
 		mb();
-		__mwait(eax, 0);
+		__mwait(hint, 0);
 
 		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
 			/*
-- 
2.47.0


