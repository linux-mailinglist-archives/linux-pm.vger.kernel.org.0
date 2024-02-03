Return-Path: <linux-pm+bounces-3261-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AEB84800D
	for <lists+linux-pm@lfdr.de>; Sat,  3 Feb 2024 05:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CF27B27346
	for <lists+linux-pm@lfdr.de>; Sat,  3 Feb 2024 04:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D031FC11;
	Sat,  3 Feb 2024 04:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j53Z1fsd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B910A09;
	Sat,  3 Feb 2024 04:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933046; cv=none; b=Nf2DJ1Y5P2NM8NuoHzFFi6Qn2SSD3pU5CcZRsTHbIwvWYwclRpBaM5kdhFo8R02Herj6VtnWa+gL48yPFmzOtll2iyDZ4knmtztmr8Ga+lvLViwtAZ8QYxCE8gWyj3/Hor5EihC49HvFNSz5uRI2gKgnv3K4fafWy3+VaZzU/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933046; c=relaxed/simple;
	bh=+cMc8OL/bddGbgnV2+93XfCuqy+4YOnvUbLH8EZgxrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZT9pUdL9MRBCw9ULaJttkdeBZBDRLWajMz0ZYKGhP0Iyo37HmgQipMGjzdZDwwzsYYD8XmKz5SlnMOLeBX7p8dc63RRWSz9mhv3RoFBrouTcuzxx1Tobi0E0aoqNd57RtdcIk2zqedtMmrTBYEJ/4l32k2gxH1bFV3kFUTI6T5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j53Z1fsd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706933045; x=1738469045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+cMc8OL/bddGbgnV2+93XfCuqy+4YOnvUbLH8EZgxrc=;
  b=j53Z1fsdXb3zOXIW03PK5qh+cXDvWCYOxaIpzAKiyJJ4fgBr3gVHKsEm
   s4y0R7THlt6uUskSZwCO9WkZ49DhWPC8UeK95RhnxCg0vxqzNr8rh/kL8
   U8XL3TRwUPPbLb+tNYgg9p8wePRCljiOJRW6Q4ejKNreuKqhfW9mETmy7
   ZzPPX42MdRovaCj04Kr33KYscPymj3s7ETpoQFr3ZLr8dr/dVy9YjpqPh
   ljf4nlW55NCPYoYZpr2ZkNUrXIp3+xeC7JRFks7kYENvKlZRhL3j7jAix
   Juo/8jYbRrNN/Nz+ck7UJKCVRX9FzoXAd6wSy+R235nBBXROuJlS0TMqi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="4181413"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="4181413"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 20:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823382501"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823382501"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2024 20:04:03 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>,
	x86@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 1/9] thermal: intel: hfi: Relocate bit definitions of HFI registers
Date: Fri,  2 Feb 2024 20:05:07 -0800
Message-Id: <20240203040515.23947-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

From: Zhao Liu <zhao1.liu@intel.com>

KVM needs the definition of several HFI registers for the virtualization
of HFI. Move the necessary definitions to msr-index.h

While here, use BIT_ULL() and GENMASK_ULL() since the relevant registers
have 64 bits. Also, remove the "_BIT" suffix for consistency in naming.

No functional changes.

Cc: Len Brown <len.brown@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhuocheng Ding <zhuocheng.ding@intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h  |  4 ++++
 drivers/thermal/intel/intel_hfi.c | 10 +++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index f1bd7b91b3c6..46983fb0b5b3 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1143,7 +1143,11 @@
 
 /* Hardware Feedback Interface */
 #define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
+#define HW_FEEDBACK_PTR_VALID           BIT_ULL(0)
+#define HW_FEEDBACK_PTR_RESERVED_MASK   GENMASK_ULL(11, 1)
+
 #define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
+#define HW_FEEDBACK_CONFIG_HFI_ENABLE   BIT_ULL(0)
 
 /* x2APIC locked status */
 #define MSR_IA32_XAPIC_DISABLE_STATUS	0xBD
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 3b04c6ec4fca..9aaca74bdfa3 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -48,10 +48,6 @@
 
 #include "../thermal_netlink.h"
 
-/* Hardware Feedback Interface MSR configuration bits */
-#define HW_FEEDBACK_PTR_VALID_BIT		BIT(0)
-#define HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT	BIT(0)
-
 /* CPUID detection and enumeration definitions for HFI */
 
 #define CPUID_HFI_LEAF 6
@@ -356,7 +352,7 @@ static void hfi_enable(void)
 	u64 msr_val;
 
 	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
-	msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
+	msr_val |= HW_FEEDBACK_CONFIG_HFI_ENABLE;
 	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 }
 
@@ -366,7 +362,7 @@ static void hfi_set_hw_table(struct hfi_instance *hfi_instance)
 	u64 msr_val;
 
 	hw_table_pa = virt_to_phys(hfi_instance->hw_table);
-	msr_val = hw_table_pa | HW_FEEDBACK_PTR_VALID_BIT;
+	msr_val = hw_table_pa | HW_FEEDBACK_PTR_VALID;
 	wrmsrl(MSR_IA32_HW_FEEDBACK_PTR, msr_val);
 }
 
@@ -377,7 +373,7 @@ static void hfi_disable(void)
 	int i;
 
 	rdmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
-	msr_val &= ~HW_FEEDBACK_CONFIG_HFI_ENABLE_BIT;
+	msr_val &= ~HW_FEEDBACK_CONFIG_HFI_ENABLE;
 	wrmsrl(MSR_IA32_HW_FEEDBACK_CONFIG, msr_val);
 
 	/*
-- 
2.25.1


