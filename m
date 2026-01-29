Return-Path: <linux-pm+bounces-41713-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIGNHfyoe2m8HgIAu9opvQ
	(envelope-from <linux-pm+bounces-41713-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0CDB3A12
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F07E303D2C6
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16822FD665;
	Thu, 29 Jan 2026 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C20yhaTc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF932F8BD3;
	Thu, 29 Jan 2026 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711828; cv=none; b=nA014QfO7Qqhwy66W1Kb7ZyY0ER8U7gZSC1RrMwq/MLlIThIExzfAB8sdGPcVe/lLV8T3ZkRKOg0+YIOM4hqGLXFfrpQbsDQKrYXsnI1rRWwhk5pJnqjUrCXrmvdQ1tb1I7ZoeGClOwaz2dqSv1WYoR5zL/GMMOyni8O+WIelkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711828; c=relaxed/simple;
	bh=/vVuhnWDKy2lPnU8VnK0UHbp/8NQ1T1VHbh/9OrD1f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8TN2c4uIsJj7mDgXWxdtZkR/lhpFpzFHKcSTmlv6Fmden2Jpaj2xKJf5tb1Rjm06llOqD6bkQUCNJ/sYZ2HPw276bkq9NAvXJ5Qw0f6Bz5jj6MgJW/DVcu3ndtQzq9QxaZ1T57tXKPUCiZyDYeLnLTcq/6vT+iFK/3PvHwSlw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C20yhaTc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769711826; x=1801247826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/vVuhnWDKy2lPnU8VnK0UHbp/8NQ1T1VHbh/9OrD1f4=;
  b=C20yhaTcrr+h46/1zsvlYORjoG/83qpcDfkzkBfsqCmGOMYLFgpEFuWK
   t7Rc4ixbVcouRHIAWNQEV0lCgQiAI6FNOkQGCFnIe9q8XE8qdZbtWgNnS
   R8CG2A7p1STxKqBb/rlN1i/H4vLDPcF7Mc/MHi+/D5GH+CPdBodWu02tT
   CMd0tuI0vm11cUrEedyWvjqqYzuN25tqilA/JL+61w+qvna0sm3CBx93t
   TgVt1djvzFM23HbrZGS8X0llbgCQeuO/eaXRMbX1z10ej7mrlR1PXhbMm
   Q3ED+I18pMjvR4NOvSYoICe2xMEMHn85vNVGWlvK/+PmR9Q2v25CyVJXf
   Q==;
X-CSE-ConnectionGUID: l7o/0dBJSOuF7Y8UyO/hXA==
X-CSE-MsgGUID: 7YCU6zboSXCBsJg0NJdqrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82388355"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="82388355"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:05 -0800
X-CSE-ConnectionGUID: 1lAFyIhwQCSfVXlrOn1lwg==
X-CSE-MsgGUID: vYFvmycCRU6Iu1AUNGBKRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="209070957"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:04 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/9] powercap: intel_rapl: Cleanup coding style
Date: Thu, 29 Jan 2026 10:36:39 -0800
Message-ID: <20260129183646.558866-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129183646.558866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260129183646.558866-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41713-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: ED0CDB3A12
X-Rspamd-Action: no action

Improve code readability and consistency by:
  - Aligning macro definitions vertically
  - Reformatting primitive info arrays with consistent indentation
  - Aligning CPU ID table entries
  - Reorganizing macro definitions for better logical grouping
  - Using consistent hex formatting (0x00 instead of 0)
  - Capitalizing hex digits consistently (0xDF instead of 0xdf)
  - Removing unnecessary parentheses around numeric constants
  - Simplifying rapl_compute_time_window_atom() to remove redundant
    assignments and clarify the to_raw/from_raw conversion paths
  - Removing unused macros (TIME_WINDOW_MIN_MSEC & TIME_WINDOW_MAX_MSEC).

No functional changes.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 453 ++++++++++++++-------------
 1 file changed, 228 insertions(+), 225 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 3471cee7ac04..74a74af8f0ec 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -31,70 +31,92 @@
 #include <asm/msr.h>
 
 /* bitmasks for RAPL MSRs, used by primitive access functions */
-#define ENERGY_STATUS_MASK      0xffffffff
+#define ENERGY_STATUS_MASK		0xffffffff
 
-#define POWER_LIMIT1_MASK       0x7FFF
-#define POWER_LIMIT1_ENABLE     BIT(15)
-#define POWER_LIMIT1_CLAMP      BIT(16)
+#define POWER_LIMIT1_MASK		0x7FFF
+#define POWER_LIMIT1_ENABLE		BIT(15)
+#define POWER_LIMIT1_CLAMP		BIT(16)
 
-#define POWER_LIMIT2_MASK       (0x7FFFULL<<32)
-#define POWER_LIMIT2_ENABLE     BIT_ULL(47)
-#define POWER_LIMIT2_CLAMP      BIT_ULL(48)
-#define POWER_HIGH_LOCK         BIT_ULL(63)
-#define POWER_LOW_LOCK          BIT(31)
+#define POWER_LIMIT2_MASK		(0x7FFFULL<<32)
+#define POWER_LIMIT2_ENABLE		BIT_ULL(47)
+#define POWER_LIMIT2_CLAMP		BIT_ULL(48)
+#define POWER_HIGH_LOCK			BIT_ULL(63)
+#define POWER_LOW_LOCK			BIT(31)
 
 #define POWER_LIMIT4_MASK		0x1FFF
 
-#define TIME_WINDOW1_MASK       (0x7FULL<<17)
-#define TIME_WINDOW2_MASK       (0x7FULL<<49)
+#define TIME_WINDOW1_MASK		(0x7FULL<<17)
+#define TIME_WINDOW2_MASK		(0x7FULL<<49)
 
-#define POWER_UNIT_OFFSET	0
-#define POWER_UNIT_MASK		0x0F
+#define POWER_UNIT_OFFSET		0x00
+#define POWER_UNIT_MASK			0x0F
 
-#define ENERGY_UNIT_OFFSET	0x08
-#define ENERGY_UNIT_MASK	0x1F00
+#define ENERGY_UNIT_OFFSET		0x08
+#define ENERGY_UNIT_MASK		0x1F00
 
-#define TIME_UNIT_OFFSET	0x10
-#define TIME_UNIT_MASK		0xF0000
+#define TIME_UNIT_OFFSET		0x10
+#define TIME_UNIT_MASK			0xF0000
 
-#define POWER_INFO_MAX_MASK     (0x7fffULL<<32)
-#define POWER_INFO_MIN_MASK     (0x7fffULL<<16)
-#define POWER_INFO_MAX_TIME_WIN_MASK     (0x3fULL<<48)
-#define POWER_INFO_THERMAL_SPEC_MASK     0x7fff
+#define POWER_INFO_MAX_MASK		(0x7fffULL<<32)
+#define POWER_INFO_MIN_MASK		(0x7fffULL<<16)
+#define POWER_INFO_MAX_TIME_WIN_MASK	(0x3fULL<<48)
+#define POWER_INFO_THERMAL_SPEC_MASK	0x7fff
 
-#define PERF_STATUS_THROTTLE_TIME_MASK 0xffffffff
-#define PP_POLICY_MASK         0x1F
+#define PERF_STATUS_THROTTLE_TIME_MASK	0xffffffff
+#define PP_POLICY_MASK			0x1F
 
 /*
  * SPR has different layout for Psys Domain PowerLimit registers.
  * There are 17 bits of PL1 and PL2 instead of 15 bits.
  * The Enable bits and TimeWindow bits are also shifted as a result.
  */
-#define PSYS_POWER_LIMIT1_MASK       0x1FFFF
-#define PSYS_POWER_LIMIT1_ENABLE     BIT(17)
+#define PSYS_POWER_LIMIT1_MASK		0x1FFFF
+#define PSYS_POWER_LIMIT1_ENABLE	BIT(17)
 
-#define PSYS_POWER_LIMIT2_MASK       (0x1FFFFULL<<32)
-#define PSYS_POWER_LIMIT2_ENABLE     BIT_ULL(49)
+#define PSYS_POWER_LIMIT2_MASK		(0x1FFFFULL<<32)
+#define PSYS_POWER_LIMIT2_ENABLE	BIT_ULL(49)
 
-#define PSYS_TIME_WINDOW1_MASK       (0x7FULL<<19)
-#define PSYS_TIME_WINDOW2_MASK       (0x7FULL<<51)
+#define PSYS_TIME_WINDOW1_MASK		(0x7FULL<<19)
+#define PSYS_TIME_WINDOW2_MASK		(0x7FULL<<51)
 
 /* bitmasks for RAPL TPMI, used by primitive access functions */
-#define TPMI_POWER_LIMIT_MASK	0x3FFFF
-#define TPMI_POWER_LIMIT_ENABLE	BIT_ULL(62)
-#define TPMI_TIME_WINDOW_MASK	(0x7FULL<<18)
-#define TPMI_INFO_SPEC_MASK	0x3FFFF
-#define TPMI_INFO_MIN_MASK	(0x3FFFFULL << 18)
-#define TPMI_INFO_MAX_MASK	(0x3FFFFULL << 36)
+#define TPMI_POWER_LIMIT_MASK		0x3FFFF
+#define TPMI_POWER_LIMIT_ENABLE		BIT_ULL(62)
+#define TPMI_TIME_WINDOW_MASK		(0x7FULL<<18)
+#define TPMI_INFO_SPEC_MASK		0x3FFFF
+#define TPMI_INFO_MIN_MASK		(0x3FFFFULL << 18)
+#define TPMI_INFO_MAX_MASK		(0x3FFFFULL << 36)
 #define TPMI_INFO_MAX_TIME_WIN_MASK	(0x7FULL << 54)
 
 /* Non HW constants */
-#define RAPL_PRIMITIVE_DERIVED       BIT(1)	/* not from raw data */
-#define RAPL_PRIMITIVE_DUMMY         BIT(2)
+#define RAPL_PRIMITIVE_DERIVED		BIT(1)	/* not from raw data */
+#define RAPL_PRIMITIVE_DUMMY		BIT(2)
+
+#define ENERGY_UNIT_SCALE		1000	/* scale from driver unit to powercap unit */
+
+/* per domain data, some are optional */
+#define NR_RAW_PRIMITIVES		(NR_RAPL_PRIMITIVES - 2)
+
+#define	DOMAIN_STATE_INACTIVE		BIT(0)
+#define	DOMAIN_STATE_POWER_LIMIT_SET	BIT(1)
+
+/* Sideband MBI registers */
+#define IOSF_CPU_POWER_BUDGET_CTL_BYT	0x02
+#define IOSF_CPU_POWER_BUDGET_CTL_TNG	0xDF
+
+#define PACKAGE_PLN_INT_SAVED		BIT(0)
+#define MAX_PRIM_NAME			32
+
+/* TPMI Unit register has different layout */
+#define TPMI_POWER_UNIT_OFFSET		POWER_UNIT_OFFSET
+#define TPMI_POWER_UNIT_MASK		POWER_UNIT_MASK
+#define TPMI_ENERGY_UNIT_OFFSET		0x06
+#define TPMI_ENERGY_UNIT_MASK		0x7C0
+#define TPMI_TIME_UNIT_OFFSET		0x0C
+#define TPMI_TIME_UNIT_MASK		0xF000
+
+#define RAPL_EVENT_MASK			GENMASK(7, 0)
 
-#define TIME_WINDOW_MAX_MSEC 40000
-#define TIME_WINDOW_MIN_MSEC 250
-#define ENERGY_UNIT_SCALE    1000	/* scale from driver unit to powercap unit */
 enum unit_type {
 	ARBITRARY_UNIT,		/* no translation */
 	POWER_UNIT,
@@ -102,12 +124,6 @@ enum unit_type {
 	TIME_UNIT,
 };
 
-/* per domain data, some are optional */
-#define NR_RAW_PRIMITIVES (NR_RAPL_PRIMITIVES - 2)
-
-#define	DOMAIN_STATE_INACTIVE           BIT(0)
-#define	DOMAIN_STATE_POWER_LIMIT_SET    BIT(1)
-
 static const char *pl_names[NR_POWER_LIMITS] = {
 	[POWER_LIMIT1] = "long_term",
 	[POWER_LIMIT2] = "short_term",
@@ -222,13 +238,6 @@ static struct rapl_defaults *get_defaults(struct rapl_package *rp)
 	return rp->priv->defaults;
 }
 
-/* Sideband MBI registers */
-#define IOSF_CPU_POWER_BUDGET_CTL_BYT (0x2)
-#define IOSF_CPU_POWER_BUDGET_CTL_TNG (0xdf)
-
-#define PACKAGE_PLN_INT_SAVED   BIT(0)
-#define MAX_PRIM_NAME (32)
-
 /* per domain data. used to describe individual knobs such that access function
  * can be consolidated into one instead of many inline functions.
  */
@@ -659,99 +668,104 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
 /* RAPL primitives for MSR and MMIO I/F */
 static struct rapl_primitive_info rpi_msr[NR_RAPL_PRIMITIVES] = {
 	/* name, mask, shift, msr index, unit divisor */
-	[POWER_LIMIT1] = PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
-			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	[POWER_LIMIT2] = PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
-			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	[POWER_LIMIT4] = PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
-				RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
-	[ENERGY_COUNTER] = PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
-			    RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
-	[FW_LOCK] = PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
-			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[FW_HIGH_LOCK] = PRIMITIVE_INFO_INIT(FW_LOCK, POWER_HIGH_LOCK, 63,
-			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL1_ENABLE] = PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
-			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL1_CLAMP] = PRIMITIVE_INFO_INIT(PL1_CLAMP, POWER_LIMIT1_CLAMP, 16,
-			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL2_ENABLE] = PRIMITIVE_INFO_INIT(PL2_ENABLE, POWER_LIMIT2_ENABLE, 47,
-			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL2_CLAMP] = PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
-			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[TIME_WINDOW1] = PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
-			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	[TIME_WINDOW2] = PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
-			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	[THERMAL_SPEC_POWER] = PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER, POWER_INFO_THERMAL_SPEC_MASK,
-			    0, RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	[MAX_POWER] = PRIMITIVE_INFO_INIT(MAX_POWER, POWER_INFO_MAX_MASK, 32,
-			    RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	[MIN_POWER] = PRIMITIVE_INFO_INIT(MIN_POWER, POWER_INFO_MIN_MASK, 16,
-			    RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	[MAX_TIME_WINDOW] = PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW, POWER_INFO_MAX_TIME_WIN_MASK, 48,
-			    RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
-	[THROTTLED_TIME] = PRIMITIVE_INFO_INIT(THROTTLED_TIME, PERF_STATUS_THROTTLE_TIME_MASK, 0,
-			    RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
-	[PRIORITY_LEVEL] = PRIMITIVE_INFO_INIT(PRIORITY_LEVEL, PP_POLICY_MASK, 0,
-			    RAPL_DOMAIN_REG_POLICY, ARBITRARY_UNIT, 0),
-	[PSYS_POWER_LIMIT1] = PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT1, PSYS_POWER_LIMIT1_MASK, 0,
-			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	[PSYS_POWER_LIMIT2] = PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT2, PSYS_POWER_LIMIT2_MASK, 32,
-			    RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	[PSYS_PL1_ENABLE] = PRIMITIVE_INFO_INIT(PSYS_PL1_ENABLE, PSYS_POWER_LIMIT1_ENABLE, 17,
-			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PSYS_PL2_ENABLE] = PRIMITIVE_INFO_INIT(PSYS_PL2_ENABLE, PSYS_POWER_LIMIT2_ENABLE, 49,
-			    RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PSYS_TIME_WINDOW1] = PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW1, PSYS_TIME_WINDOW1_MASK, 19,
-			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	[PSYS_TIME_WINDOW2] = PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW2, PSYS_TIME_WINDOW2_MASK, 51,
-			    RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+	[POWER_LIMIT1]		= PRIMITIVE_INFO_INIT(POWER_LIMIT1, POWER_LIMIT1_MASK, 0,
+						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	[POWER_LIMIT2]		= PRIMITIVE_INFO_INIT(POWER_LIMIT2, POWER_LIMIT2_MASK, 32,
+						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	[POWER_LIMIT4]		= PRIMITIVE_INFO_INIT(POWER_LIMIT4, POWER_LIMIT4_MASK, 0,
+						      RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
+	[ENERGY_COUNTER]	= PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
+						      RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
+	[FW_LOCK]		= PRIMITIVE_INFO_INIT(FW_LOCK, POWER_LOW_LOCK, 31,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[FW_HIGH_LOCK]		= PRIMITIVE_INFO_INIT(FW_LOCK, POWER_HIGH_LOCK, 63,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL1_ENABLE]		= PRIMITIVE_INFO_INIT(PL1_ENABLE, POWER_LIMIT1_ENABLE, 15,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL1_CLAMP]		= PRIMITIVE_INFO_INIT(PL1_CLAMP, POWER_LIMIT1_CLAMP, 16,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL2_ENABLE]		= PRIMITIVE_INFO_INIT(PL2_ENABLE, POWER_LIMIT2_ENABLE, 47,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL2_CLAMP]		= PRIMITIVE_INFO_INIT(PL2_CLAMP, POWER_LIMIT2_CLAMP, 48,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[TIME_WINDOW1]		= PRIMITIVE_INFO_INIT(TIME_WINDOW1, TIME_WINDOW1_MASK, 17,
+						      RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+	[TIME_WINDOW2]		= PRIMITIVE_INFO_INIT(TIME_WINDOW2, TIME_WINDOW2_MASK, 49,
+						      RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+	[THERMAL_SPEC_POWER]	= PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER,
+						      POWER_INFO_THERMAL_SPEC_MASK, 0,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MAX_POWER]		= PRIMITIVE_INFO_INIT(MAX_POWER, POWER_INFO_MAX_MASK, 32,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MIN_POWER]		= PRIMITIVE_INFO_INIT(MIN_POWER, POWER_INFO_MIN_MASK, 16,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MAX_TIME_WINDOW]	= PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW,
+						      POWER_INFO_MAX_TIME_WIN_MASK, 48,
+						      RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
+	[THROTTLED_TIME]	= PRIMITIVE_INFO_INIT(THROTTLED_TIME,
+						      PERF_STATUS_THROTTLE_TIME_MASK, 0,
+						      RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
+	[PRIORITY_LEVEL]	= PRIMITIVE_INFO_INIT(PRIORITY_LEVEL, PP_POLICY_MASK, 0,
+						      RAPL_DOMAIN_REG_POLICY, ARBITRARY_UNIT, 0),
+	[PSYS_POWER_LIMIT1]	= PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT1, PSYS_POWER_LIMIT1_MASK, 0,
+						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	[PSYS_POWER_LIMIT2]	= PRIMITIVE_INFO_INIT(PSYS_POWER_LIMIT2, PSYS_POWER_LIMIT2_MASK,
+						      32, RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	[PSYS_PL1_ENABLE]	= PRIMITIVE_INFO_INIT(PSYS_PL1_ENABLE, PSYS_POWER_LIMIT1_ENABLE,
+						      17, RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT,
+						      0),
+	[PSYS_PL2_ENABLE]	= PRIMITIVE_INFO_INIT(PSYS_PL2_ENABLE, PSYS_POWER_LIMIT2_ENABLE,
+						      49, RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT,
+						      0),
+	[PSYS_TIME_WINDOW1]	= PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW1, PSYS_TIME_WINDOW1_MASK,
+						      19, RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+	[PSYS_TIME_WINDOW2]	= PRIMITIVE_INFO_INIT(PSYS_TIME_WINDOW2, PSYS_TIME_WINDOW2_MASK,
+						      51, RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
 	/* non-hardware */
-	[AVERAGE_POWER] = PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0, POWER_UNIT,
-			    RAPL_PRIMITIVE_DERIVED),
+	[AVERAGE_POWER]		= PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0, POWER_UNIT,
+						      RAPL_PRIMITIVE_DERIVED),
 };
 
 /* RAPL primitives for TPMI I/F */
 static struct rapl_primitive_info rpi_tpmi[NR_RAPL_PRIMITIVES] = {
 	/* name, mask, shift, msr index, unit divisor */
-	[POWER_LIMIT1] = PRIMITIVE_INFO_INIT(POWER_LIMIT1, TPMI_POWER_LIMIT_MASK, 0,
-		RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
-	[POWER_LIMIT2] = PRIMITIVE_INFO_INIT(POWER_LIMIT2, TPMI_POWER_LIMIT_MASK, 0,
-		RAPL_DOMAIN_REG_PL2, POWER_UNIT, 0),
-	[POWER_LIMIT4] = PRIMITIVE_INFO_INIT(POWER_LIMIT4, TPMI_POWER_LIMIT_MASK, 0,
-		RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
-	[ENERGY_COUNTER] = PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
-		RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
-	[PL1_LOCK] = PRIMITIVE_INFO_INIT(PL1_LOCK, POWER_HIGH_LOCK, 63,
-		RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL2_LOCK] = PRIMITIVE_INFO_INIT(PL2_LOCK, POWER_HIGH_LOCK, 63,
-		RAPL_DOMAIN_REG_PL2, ARBITRARY_UNIT, 0),
-	[PL4_LOCK] = PRIMITIVE_INFO_INIT(PL4_LOCK, POWER_HIGH_LOCK, 63,
-		RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
-	[PL1_ENABLE] = PRIMITIVE_INFO_INIT(PL1_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
-		RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
-	[PL2_ENABLE] = PRIMITIVE_INFO_INIT(PL2_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
-		RAPL_DOMAIN_REG_PL2, ARBITRARY_UNIT, 0),
-	[PL4_ENABLE] = PRIMITIVE_INFO_INIT(PL4_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
-		RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
-	[TIME_WINDOW1] = PRIMITIVE_INFO_INIT(TIME_WINDOW1, TPMI_TIME_WINDOW_MASK, 18,
-		RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
-	[TIME_WINDOW2] = PRIMITIVE_INFO_INIT(TIME_WINDOW2, TPMI_TIME_WINDOW_MASK, 18,
-		RAPL_DOMAIN_REG_PL2, TIME_UNIT, 0),
-	[THERMAL_SPEC_POWER] = PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER, TPMI_INFO_SPEC_MASK, 0,
-		RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	[MAX_POWER] = PRIMITIVE_INFO_INIT(MAX_POWER, TPMI_INFO_MAX_MASK, 36,
-		RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	[MIN_POWER] = PRIMITIVE_INFO_INIT(MIN_POWER, TPMI_INFO_MIN_MASK, 18,
-		RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
-	[MAX_TIME_WINDOW] = PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW, TPMI_INFO_MAX_TIME_WIN_MASK, 54,
-		RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
-	[THROTTLED_TIME] = PRIMITIVE_INFO_INIT(THROTTLED_TIME, PERF_STATUS_THROTTLE_TIME_MASK, 0,
-		RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
+	[POWER_LIMIT1]		= PRIMITIVE_INFO_INIT(POWER_LIMIT1, TPMI_POWER_LIMIT_MASK, 0,
+						      RAPL_DOMAIN_REG_LIMIT, POWER_UNIT, 0),
+	[POWER_LIMIT2]		= PRIMITIVE_INFO_INIT(POWER_LIMIT2, TPMI_POWER_LIMIT_MASK, 0,
+						      RAPL_DOMAIN_REG_PL2, POWER_UNIT, 0),
+	[POWER_LIMIT4]		= PRIMITIVE_INFO_INIT(POWER_LIMIT4, TPMI_POWER_LIMIT_MASK, 0,
+						      RAPL_DOMAIN_REG_PL4, POWER_UNIT, 0),
+	[ENERGY_COUNTER]	= PRIMITIVE_INFO_INIT(ENERGY_COUNTER, ENERGY_STATUS_MASK, 0,
+						      RAPL_DOMAIN_REG_STATUS, ENERGY_UNIT, 0),
+	[PL1_LOCK]		= PRIMITIVE_INFO_INIT(PL1_LOCK, POWER_HIGH_LOCK, 63,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL2_LOCK]		= PRIMITIVE_INFO_INIT(PL2_LOCK, POWER_HIGH_LOCK, 63,
+						      RAPL_DOMAIN_REG_PL2, ARBITRARY_UNIT, 0),
+	[PL4_LOCK]		= PRIMITIVE_INFO_INIT(PL4_LOCK, POWER_HIGH_LOCK, 63,
+						      RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
+	[PL1_ENABLE]		= PRIMITIVE_INFO_INIT(PL1_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
+						      RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT, 0),
+	[PL2_ENABLE]		= PRIMITIVE_INFO_INIT(PL2_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
+						      RAPL_DOMAIN_REG_PL2, ARBITRARY_UNIT, 0),
+	[PL4_ENABLE]		= PRIMITIVE_INFO_INIT(PL4_ENABLE, TPMI_POWER_LIMIT_ENABLE, 62,
+						      RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT, 0),
+	[TIME_WINDOW1]		= PRIMITIVE_INFO_INIT(TIME_WINDOW1, TPMI_TIME_WINDOW_MASK, 18,
+						      RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
+	[TIME_WINDOW2]		= PRIMITIVE_INFO_INIT(TIME_WINDOW2, TPMI_TIME_WINDOW_MASK, 18,
+						      RAPL_DOMAIN_REG_PL2, TIME_UNIT, 0),
+	[THERMAL_SPEC_POWER]	= PRIMITIVE_INFO_INIT(THERMAL_SPEC_POWER, TPMI_INFO_SPEC_MASK, 0,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MAX_POWER]		= PRIMITIVE_INFO_INIT(MAX_POWER, TPMI_INFO_MAX_MASK, 36,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MIN_POWER]		= PRIMITIVE_INFO_INIT(MIN_POWER, TPMI_INFO_MIN_MASK, 18,
+						      RAPL_DOMAIN_REG_INFO, POWER_UNIT, 0),
+	[MAX_TIME_WINDOW]	= PRIMITIVE_INFO_INIT(MAX_TIME_WINDOW, TPMI_INFO_MAX_TIME_WIN_MASK,
+						      54, RAPL_DOMAIN_REG_INFO, TIME_UNIT, 0),
+	[THROTTLED_TIME]	= PRIMITIVE_INFO_INIT(THROTTLED_TIME, PERF_STATUS_THROTTLE_TIME_MASK,
+						      0, RAPL_DOMAIN_REG_PERF, TIME_UNIT, 0),
 	/* non-hardware */
-	[AVERAGE_POWER] = PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0,
-		POWER_UNIT, RAPL_PRIMITIVE_DERIVED),
+	[AVERAGE_POWER]		= PRIMITIVE_INFO_INIT(AVERAGE_POWER, 0, 0, 0, POWER_UNIT,
+						      RAPL_PRIMITIVE_DERIVED),
 };
 
 static struct rapl_primitive_info *get_rpi(struct rapl_package *rp, int prim)
@@ -1131,26 +1145,16 @@ static u64 rapl_compute_time_window_core(struct rapl_domain *rd, u64 value,
 static u64 rapl_compute_time_window_atom(struct rapl_domain *rd, u64 value,
 					 bool to_raw)
 {
+	if (to_raw)
+		return div64_u64(value, rd->time_unit);
+
 	/*
 	 * Atom time unit encoding is straight forward val * time_unit,
 	 * where time_unit is default to 1 sec. Never 0.
 	 */
-	if (!to_raw)
-		return (value) ? value * rd->time_unit : rd->time_unit;
-
-	value = div64_u64(value, rd->time_unit);
-
-	return value;
+	return (value) ? value * rd->time_unit : rd->time_unit;
 }
 
-/* TPMI Unit register has different layout */
-#define TPMI_POWER_UNIT_OFFSET	POWER_UNIT_OFFSET
-#define TPMI_POWER_UNIT_MASK	POWER_UNIT_MASK
-#define TPMI_ENERGY_UNIT_OFFSET	0x06
-#define TPMI_ENERGY_UNIT_MASK	0x7C0
-#define TPMI_TIME_UNIT_OFFSET	0x0C
-#define TPMI_TIME_UNIT_MASK	0xF000
-
 static int rapl_check_unit_tpmi(struct rapl_domain *rd)
 {
 	struct reg_action ra;
@@ -1241,77 +1245,77 @@ static const struct rapl_defaults rapl_defaults_amd = {
 };
 
 static const struct x86_cpu_id rapl_ids[] __initconst = {
-	X86_MATCH_VFM(INTEL_SANDYBRIDGE,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,	&rapl_defaults_core),
-
-	X86_MATCH_VFM(INTEL_IVYBRIDGE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,	&rapl_defaults_core),
-
-	X86_MATCH_VFM(INTEL_HASWELL,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_HASWELL_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_HASWELL_G,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_HASWELL_X,		&rapl_defaults_hsw_server),
-
-	X86_MATCH_VFM(INTEL_BROADWELL,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_BROADWELL_G,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_BROADWELL_D,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_BROADWELL_X,	&rapl_defaults_hsw_server),
-
-	X86_MATCH_VFM(INTEL_SKYLAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_SKYLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_SKYLAKE_X,		&rapl_defaults_hsw_server),
-	X86_MATCH_VFM(INTEL_KABYLAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_KABYLAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ICELAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ICELAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ICELAKE_X,		&rapl_defaults_hsw_server),
-	X86_MATCH_VFM(INTEL_ICELAKE_D,		&rapl_defaults_hsw_server),
-	X86_MATCH_VFM(INTEL_COMETLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_COMETLAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_TIGERLAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ROCKETLAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ALDERLAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,        &rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_BARTLETTLAKE,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_METEORLAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_METEORLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&rapl_defaults_spr_server),
-	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&rapl_defaults_spr_server),
-	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_NOVALAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_NOVALAKE_L,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ARROWLAKE_H,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ARROWLAKE,		&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ARROWLAKE_U,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_LAKEFIELD,		&rapl_defaults_core),
-
-	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&rapl_defaults_byt),
-	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&rapl_defaults_cht),
-	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID, &rapl_defaults_tng),
-	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID2,&rapl_defaults_ann),
-	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_TREMONT,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,	&rapl_defaults_core),
-	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,	&rapl_defaults_core),
-
-	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,	&rapl_defaults_hsw_server),
-	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,	&rapl_defaults_hsw_server),
-
-	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
-	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
-	X86_MATCH_VENDOR_FAM(AMD, 0x1A, &rapl_defaults_amd),
-	X86_MATCH_VENDOR_FAM(HYGON, 0x18, &rapl_defaults_amd),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SANDYBRIDGE_X,		&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_IVYBRIDGE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_IVYBRIDGE_X,		&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_HASWELL,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_G,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_HASWELL_X,			&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_BROADWELL,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_G,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_D,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BROADWELL_X,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_VFM(INTEL_SKYLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SKYLAKE_X,			&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_KABYLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_NNPI,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ICELAKE_X,			&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_ICELAKE_D,			&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_COMETLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_TIGERLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ROCKETLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_BARTLETTLAKE,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_METEORLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,		&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,		&rapl_defaults_spr_server),
+	X86_MATCH_VFM(INTEL_LUNARLAKE_M,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_NOVALAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_NOVALAKE_L,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_H,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE,			&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ARROWLAKE_U,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_LAKEFIELD,			&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,		&rapl_defaults_byt),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,		&rapl_defaults_cht),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID,	&rapl_defaults_tng),
+	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_MID2,	&rapl_defaults_ann),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_PLUS,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_GOLDMONT_D,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_D,		&rapl_defaults_core),
+	X86_MATCH_VFM(INTEL_ATOM_TREMONT_L,		&rapl_defaults_core),
+
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNL,		&rapl_defaults_hsw_server),
+	X86_MATCH_VFM(INTEL_XEON_PHI_KNM,		&rapl_defaults_hsw_server),
+
+	X86_MATCH_VENDOR_FAM(AMD, 0x17,			&rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(AMD, 0x19,			&rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(AMD, 0x1A,			&rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(HYGON, 0x18,		&rapl_defaults_amd),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
@@ -1780,7 +1784,6 @@ enum perf_rapl_events {
 	PERF_RAPL_PSYS,		/* psys */
 	PERF_RAPL_MAX
 };
-#define RAPL_EVENT_MASK GENMASK(7, 0)
 
 static const int event_to_domain[PERF_RAPL_MAX] = {
 	[PERF_RAPL_PP0]		= RAPL_DOMAIN_PP0,
-- 
2.43.0


