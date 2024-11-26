Return-Path: <linux-pm+bounces-18138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE30F9D9E55
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 21:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFD9B216CA
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2024 20:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432111DFDAD;
	Tue, 26 Nov 2024 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcqlEhLy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706F1DFD97;
	Tue, 26 Nov 2024 20:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652171; cv=none; b=PEsz+x78auBLGbWILJfMJ4o+Fsjp8RLQOGTCDyI4rJfw4R1bpwTWbJDZ1SkYQefAMINOtGP0e4+lpWPPPk+xj51KvOrL6+MK5srkAu55rCSXLxWeFpnZ+F+V+j0TfDVV4TbkWnBjCnGfOs6RsWcWd5C/qMdIT4x9BOXejPLZI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652171; c=relaxed/simple;
	bh=qza0Tpv/OZnOr/Qj0ZSV60FrbrGJCP472AgkqiS92Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjfBnptNoESO2xZ369o7xbjMn4RFsieY1YnzGYZsNVUAMough4rFmTuooZoMsr7kMS+Wh/qB0BIvkN8YHIhUhQbZeqf+5fczz9UHQERqNCAjCUdLDWhtUEtmLVgM6mF/FFSNDSKTLgx6fC8lfAR/y7GH/zfcFvTj2UkLvomu7cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcqlEhLy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732652170; x=1764188170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qza0Tpv/OZnOr/Qj0ZSV60FrbrGJCP472AgkqiS92Eo=;
  b=dcqlEhLywpVS+KQ0ZioLlcBP6jK8Z1Uj30hjvfb6lD/2rwwsieeF/ZDZ
   NyTZt6zyiw0IRgiLNTFyb0ZwDXGSdaQv4Nv58sylerscwWXOVTt5a/REv
   KbUGWMf9F7X8BJddagVFEKdai0aXL+d2P2T9WYJb2PrdqreER0XNs54I9
   5g0gF6YFM2S6BmE8eMPHQBJA3tWgMoQW/H1rTQyPrIDpUd+7D8TSZKoFo
   JpFkwEmIe9xsoouprgs4fbjLMUbmvXb/1PfAse4hRDr1j13ZQ9q3R0PgL
   vj1/P3KSMsQcRY0HRx2E2W4iOYcbIMOrliAeJE887y54xmxDBuivoI4uY
   A==;
X-CSE-ConnectionGUID: 3TgMQFjCQQKDUgOwrrJUmA==
X-CSE-MsgGUID: JfkWvfxhTXOacSAnhzR0zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="36624228"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="36624228"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 12:16:09 -0800
X-CSE-ConnectionGUID: KskfpBIETOaNv+P79qp4Wg==
X-CSE-MsgGUID: Hw/We5N/Q3OirSTvMmDW0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="92047584"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.245.172])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 12:16:06 -0800
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
Subject: [PATCH v5 3/3] intel_idle: Provide the default enter_dead() handler
Date: Tue, 26 Nov 2024 21:15:39 +0100
Message-ID: <20241126201539.477448-4-patryk.wlazlyn@linux.intel.com>
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

The recent mwait_play_dead code relies on cpuidle driver to call the
function with the right mwait hint, for the deepest cstate for which the
driver provides the enter_dead handler.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
---
 drivers/idle/intel_idle.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ac4d8faa3886..c6874a6dbe95 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -56,6 +56,7 @@
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
 #include <asm/fpu/api.h>
+#include <asm/smp.h>
 
 #define INTEL_IDLE_VERSION "0.5.1"
 
@@ -227,6 +228,16 @@ static __cpuidle int intel_idle_s2idle(struct cpuidle_device *dev,
 	return 0;
 }
 
+static __cpuidle void intel_idle_enter_dead(struct cpuidle_device *dev,
+					    int index)
+{
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	struct cpuidle_state *state = &drv->states[index];
+	unsigned long eax = flg2MWAIT(state->flags);
+
+	mwait_play_dead(eax);
+}
+
 /*
  * States are indexed by the cstate number,
  * which is also the index into the MWAIT hint array.
@@ -1798,6 +1809,7 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
 
 		state->enter = intel_idle;
+		state->enter_dead = intel_idle_enter_dead;
 		state->enter_s2idle = intel_idle_s2idle;
 	}
 }
@@ -2143,10 +2155,12 @@ static void __init intel_idle_init_cstates_icpu(struct cpuidle_driver *drv)
 		if (intel_idle_max_cstate_reached(cstate))
 			break;
 
-		if (!cpuidle_state_table[cstate].enter &&
-		    !cpuidle_state_table[cstate].enter_s2idle)
+		if (!cpuidle_state_table[cstate].enter)
 			break;
 
+		if (!cpuidle_state_table[cstate].enter_dead)
+			cpuidle_state_table[cstate].enter_dead = intel_idle_enter_dead;
+
 		/* If marked as unusable, skip this state. */
 		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_UNUSABLE) {
 			pr_debug("state %s is disabled\n",
-- 
2.47.1


