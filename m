Return-Path: <linux-pm+bounces-15457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DB19987FD
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 15:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0ADBB2747C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 13:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907541CBEB4;
	Thu, 10 Oct 2024 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEO9Ev/Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D31C9EB9;
	Thu, 10 Oct 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567614; cv=none; b=huvcw1hlrREusaquoMPhJUi3DWBJd11adSDi02cq2lGlY7V4T15Cj10+PfDX87NXiMHdJOfe7H2rs/I5yfNU1yr4ZwExuoEWGQKeTrsLHudH7ofT3Scskkd9ZB3JDZgyAHJQon1FEyR5OQbWCy660SrGwFDreFw4A+sIXxfg/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567614; c=relaxed/simple;
	bh=oNq5n3k+uHSQU0ZTV0v6QtwqnkLk4h+7tyka8HePvOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFExjF1vicehARvYhYeo6AON7ksuYcAIV67uFVfLJ5ZgasZR9V3j/pRXLzh/XqKDehNwuuBeYNriIdPDoYQsV8D2HblYIIuKiGVueuVpU1lUsDM8umEX6ntNsM5rr3ICNiRip8O8zhkGea2BBqwz6a9gBksuLNW5XH1Y5LQpq/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEO9Ev/Y; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728567613; x=1760103613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oNq5n3k+uHSQU0ZTV0v6QtwqnkLk4h+7tyka8HePvOA=;
  b=nEO9Ev/Yx3rXxXHpB+okB3xeCjZQQpP0mLlT/g6GihvaqQUKaUR+yF72
   DVxtGQzxN9fb6jLlBOb80bdqv8zplnwvXi4Y0TMdQFLAQOxaGle2GNciS
   fnvpyVIv1wFSjv/CzG0/m/0AkgnvU9JBqPW83S//zSebwJocHn4hgxNLN
   WsvB1sr/ipsDia4H8Hs8ENLbVWB3ITgFxeHZxbEEOXpVsY8oSuPdUNY37
   4fQkhV2zSfQDOSwXFJ/tQl8OBkXazNv60rXpdLx5gnmNkjD1T1Z7vtTKj
   vHxuMDTzg8D54FwBGOItYg+IGYbPGWjPVwByUUJ+bNE9w9pifmJVYgVAA
   A==;
X-CSE-ConnectionGUID: JdmHMXVVRL24UV/xUQl1Ew==
X-CSE-MsgGUID: jJELuzu+QB2B+6F5C02wlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31718277"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31718277"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:40:13 -0700
X-CSE-ConnectionGUID: Ebh9qc76ShK+sZ0lbDF+PQ==
X-CSE-MsgGUID: xA2GXhqwTWKybUnwtCOxqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81114922"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.12])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 06:40:09 -0700
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael.j.wysocki@intel.com,
	len.brown@intel.com,
	artem.bityutskiy@linux.intel.com,
	dave.hansen@linux.intel.com,
	patryk.wlazlyn@linux.intel.com
Subject: [PATCH 1/3] x86/smp: Move mwait hint computation out of mwait_play_dead
Date: Thu, 10 Oct 2024 15:39:53 +0200
Message-ID: <20241010133955.7749-2-patryk.wlazlyn@linux.intel.com>
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
2.46.2


