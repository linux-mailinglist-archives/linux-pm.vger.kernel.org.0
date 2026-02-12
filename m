Return-Path: <linux-pm+bounces-42594-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOYGCAVjjmn1BwEAu9opvQ
	(envelope-from <linux-pm+bounces-42594-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:32:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA43131C1F
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FADA3144B64
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 23:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B252F2619;
	Thu, 12 Feb 2026 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqkdOSMV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014492E266C;
	Thu, 12 Feb 2026 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939053; cv=none; b=B2e7ErNjBX87oud0q7+Atv4huYYHkxlxBGwnVRJU8rinY7R4eYPXEiVa8sdp98dY+JCyzO3pD8vVcKGYfaokta+zJbn0kcfXkkHaaeRJyfX//L4bZm+vPxIvpB9V9vUiEIyjw+BrSh3VDCqED25CRG6eHpGCuHhEtNdejtwjTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939053; c=relaxed/simple;
	bh=JXIWk0PGmnWQ3ytLCxfsjtlwLjr1q749B4naFtpBORs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFDXdUCh4+TBMMqwquiQplHhM/bc3ew5cY8SRrxLpRhYxAu0wiyNvrRiqBbuKJOYBaf3t8qPDWBDy/pF4J5n4HaHCfnjD1UutZAmeK4LxAQDZGPfIlPqB4Zy32DdkdYBGG5Ipi2E5zIxm5xg0k5AVTRqUXSh/49IJCqshjKIlxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqkdOSMV; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770939051; x=1802475051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JXIWk0PGmnWQ3ytLCxfsjtlwLjr1q749B4naFtpBORs=;
  b=PqkdOSMV0bnptdWOu6I/YNWOyYC0Y67jQuEA2kTrlo/e8mwMEMt37etA
   2U/+zk31QIVEybPbnDiGgdBJ/WPpWqNGTrkY0GMPqyVDeD6gImldWLcWA
   CJsX7tosEb+4MmeUM6Bk7KEp1Ej/O7wPk8M2xbfFKnsDhtf5s+dzv4r+/
   h+Ac7iD+u4XaTLTsdHEXLgmcZAOOQg4OY9SboF7jgHUjjp1QI46jxCLmE
   CSJXZ1v5RRIqhqFEnpL+eOm5OboHLThh/v2I1PTrpJ77sIBIWZOsX+Uk7
   QpeO0Hv5WFBM6IFEPzDVCNT8Ytb4fwAtDZls0UwKehLw5VK0RGUCSv+eb
   g==;
X-CSE-ConnectionGUID: DXgatB/pQrGZsrFdrPV6Sg==
X-CSE-MsgGUID: HmJ570L3QTODUKzctvcobA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72017417"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72017417"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:49 -0800
X-CSE-ConnectionGUID: Mo8xG+QkQzW2zwe1jrhKDg==
X-CSE-MsgGUID: TDaZEuSnSX6CA9NU9rOoNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211845381"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:45 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/12] powercap: intel_rapl: Cleanup coding style
Date: Thu, 12 Feb 2026 15:30:34 -0800
Message-ID: <20260212233044.329790-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212233044.329790-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260212233044.329790-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42594-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sathyanarayanan.kuppuswamy@linux.intel.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7FA43131C1F
X-Rspamd-Action: no action

Improve code readability and consistency by:
  - Aligning macro definitions vertically
  - Reformatting primitive info arrays with consistent indentation
  - Aligning CPU ID table entries
  - Reorganizing macro definitions for better logical grouping
  - Using consistent hex formatting (0x00 instead of 0)
  - Capitalizing hex digits consistently (0xDF instead of 0xdf)
  - Removing unnecessary parentheses around numeric constants

No functional changes.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 446 ++++++++++++++-------------
 1 file changed, 227 insertions(+), 219 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 3471cee7ac04..12f2d6de0541 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -31,70 +31,95 @@
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
+
+#define TIME_WINDOW_MAX_MSEC		40000
+#define TIME_WINDOW_MIN_MSEC		250
 
-#define TIME_WINDOW_MAX_MSEC 40000
-#define TIME_WINDOW_MIN_MSEC 250
-#define ENERGY_UNIT_SCALE    1000	/* scale from driver unit to powercap unit */
 enum unit_type {
 	ARBITRARY_UNIT,		/* no translation */
 	POWER_UNIT,
@@ -102,12 +127,6 @@ enum unit_type {
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
@@ -222,13 +241,6 @@ static struct rapl_defaults *get_defaults(struct rapl_package *rp)
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
@@ -659,99 +671,104 @@ static u64 rapl_unit_xlate(struct rapl_domain *rd, enum unit_type type,
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
@@ -1143,14 +1160,6 @@ static u64 rapl_compute_time_window_atom(struct rapl_domain *rd, u64 value,
 	return value;
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
@@ -1241,77 +1250,77 @@ static const struct rapl_defaults rapl_defaults_amd = {
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
@@ -1780,7 +1789,6 @@ enum perf_rapl_events {
 	PERF_RAPL_PSYS,		/* psys */
 	PERF_RAPL_MAX
 };
-#define RAPL_EVENT_MASK GENMASK(7, 0)
 
 static const int event_to_domain[PERF_RAPL_MAX] = {
 	[PERF_RAPL_PP0]		= RAPL_DOMAIN_PP0,
-- 
2.43.0


