Return-Path: <linux-pm+bounces-41712-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE2kFPKoe2m8HgIAu9opvQ
	(envelope-from <linux-pm+bounces-41712-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E2CB3A04
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C3B43038AEA
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6068C2FC00D;
	Thu, 29 Jan 2026 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bglzhkLj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39ED2F9984;
	Thu, 29 Jan 2026 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711828; cv=none; b=sNOH+jOOVQkdoCY36ucyp8iWWi62I6GaYfvOf2+GsO5d/BFbxL9Td/YVwGzFb0i57V/CuExqDzicZyYR9lJG1lQRoBKxZens0h9IzulljYfjR5YyuKmILkjgj6lENHLYEP4KI0Qt1J4RRl0IKfzsFdyGmnhMqFGVIwF7fzZPGHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711828; c=relaxed/simple;
	bh=RQXf3rqsQ3wvdkn5lJc58ZpRzqeHt4q+lDv4SoGb6Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uchWsZk0pH8YaMWaNfVIYSeoPCUCLEGuGH8fCMpguviWRrP7AuCsIGzLrNkw7ycT6Ka7rs3B7VhjuMnwzK164TzeAEVtlDs6AO+ZAXiEfPj0lScK4vmZMSKlrnvFZFrTipoT3SQEslJFAw92QXWztXsdhFoW9aP+5G2X/WPbjS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bglzhkLj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769711827; x=1801247827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RQXf3rqsQ3wvdkn5lJc58ZpRzqeHt4q+lDv4SoGb6Es=;
  b=bglzhkLjv4ScIfZJ2JjBlfO2spYSXTO18b/HcxQcR71Jg6JMHLY/U+wM
   tAQFEihiJi34X0Tmsp0StkkxMBcXmp6DMha9eYha1ETRrxBz+Ahe7DvOp
   Xg4wUJoyf9oJTpbGRrH+Nv85BHPggdUB9qilXvbQSBp5WZtfdhWQqOOmX
   2a+5rqfAw0oz+zpfh/JJN8WJvofw1S2zeDmyhvr1te6yuoiyJyVhGwk93
   trdkufdqxxdmWfTNXT9SfE6/1wZFACRrH57DNYzdduLXPMPKTb2P11wMY
   Vxhj5dzeWzMLI80tKixToNVXg+QmkIm1m6k4LNeX/GQtY7MV+VflNMOL+
   A==;
X-CSE-ConnectionGUID: hhxXC/ooSgCT9vr89Gim+g==
X-CSE-MsgGUID: DVea+I2STuiM1S+YNpBvqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82388360"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="82388360"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:06 -0800
X-CSE-ConnectionGUID: N0qi9STRRCmnZewdmkFusg==
X-CSE-MsgGUID: ST4YKXsSR2K9pSkqrGJsBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="209070961"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:05 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/9] powercap: intel_rapl: Use GENMASK() and BIT() macros
Date: Thu, 29 Jan 2026 10:36:40 -0800
Message-ID: <20260129183646.558866-4-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41712-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: A8E2CB3A04
X-Rspamd-Action: no action

Replace hardcoded bitmasks and bit shift operations with standard
GENMASK(), GENMASK_ULL(), BIT(), and BIT_ULL() macros for better
readability and to follow kernel coding conventions.

No functional changes.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 78 ++++++++++++++--------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 74a74af8f0ec..0faafba8cc7c 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -31,62 +31,62 @@
 #include <asm/msr.h>
 
 /* bitmasks for RAPL MSRs, used by primitive access functions */
-#define ENERGY_STATUS_MASK		0xffffffff
+#define ENERGY_STATUS_MASK		GENMASK(31, 0)
 
-#define POWER_LIMIT1_MASK		0x7FFF
+#define POWER_LIMIT1_MASK		GENMASK(14, 0)
 #define POWER_LIMIT1_ENABLE		BIT(15)
 #define POWER_LIMIT1_CLAMP		BIT(16)
 
-#define POWER_LIMIT2_MASK		(0x7FFFULL<<32)
+#define POWER_LIMIT2_MASK		GENMASK_ULL(46, 32)
 #define POWER_LIMIT2_ENABLE		BIT_ULL(47)
 #define POWER_LIMIT2_CLAMP		BIT_ULL(48)
 #define POWER_HIGH_LOCK			BIT_ULL(63)
 #define POWER_LOW_LOCK			BIT(31)
 
-#define POWER_LIMIT4_MASK		0x1FFF
+#define POWER_LIMIT4_MASK		GENMASK(12, 0)
 
-#define TIME_WINDOW1_MASK		(0x7FULL<<17)
-#define TIME_WINDOW2_MASK		(0x7FULL<<49)
+#define TIME_WINDOW1_MASK		GENMASK_ULL(23, 17)
+#define TIME_WINDOW2_MASK		GENMASK_ULL(55, 49)
 
 #define POWER_UNIT_OFFSET		0x00
-#define POWER_UNIT_MASK			0x0F
+#define POWER_UNIT_MASK			GENMASK(3, 0)
 
 #define ENERGY_UNIT_OFFSET		0x08
-#define ENERGY_UNIT_MASK		0x1F00
+#define ENERGY_UNIT_MASK		GENMASK(12, 8)
 
 #define TIME_UNIT_OFFSET		0x10
-#define TIME_UNIT_MASK			0xF0000
+#define TIME_UNIT_MASK			GENMASK(19, 16)
 
-#define POWER_INFO_MAX_MASK		(0x7fffULL<<32)
-#define POWER_INFO_MIN_MASK		(0x7fffULL<<16)
-#define POWER_INFO_MAX_TIME_WIN_MASK	(0x3fULL<<48)
-#define POWER_INFO_THERMAL_SPEC_MASK	0x7fff
+#define POWER_INFO_MAX_MASK		GENMASK_ULL(46, 32)
+#define POWER_INFO_MIN_MASK		GENMASK_ULL(30, 16)
+#define POWER_INFO_MAX_TIME_WIN_MASK	GENMASK_ULL(53, 48)
+#define POWER_INFO_THERMAL_SPEC_MASK	GENMASK(14, 0)
 
-#define PERF_STATUS_THROTTLE_TIME_MASK	0xffffffff
-#define PP_POLICY_MASK			0x1F
+#define PERF_STATUS_THROTTLE_TIME_MASK	GENMASK(31, 0)
+#define PP_POLICY_MASK			GENMASK(4, 0)
 
 /*
  * SPR has different layout for Psys Domain PowerLimit registers.
  * There are 17 bits of PL1 and PL2 instead of 15 bits.
  * The Enable bits and TimeWindow bits are also shifted as a result.
  */
-#define PSYS_POWER_LIMIT1_MASK		0x1FFFF
+#define PSYS_POWER_LIMIT1_MASK		GENMASK_ULL(16, 0)
 #define PSYS_POWER_LIMIT1_ENABLE	BIT(17)
 
-#define PSYS_POWER_LIMIT2_MASK		(0x1FFFFULL<<32)
+#define PSYS_POWER_LIMIT2_MASK		GENMASK_ULL(48, 32)
 #define PSYS_POWER_LIMIT2_ENABLE	BIT_ULL(49)
 
-#define PSYS_TIME_WINDOW1_MASK		(0x7FULL<<19)
-#define PSYS_TIME_WINDOW2_MASK		(0x7FULL<<51)
+#define PSYS_TIME_WINDOW1_MASK		GENMASK_ULL(25, 19)
+#define PSYS_TIME_WINDOW2_MASK		GENMASK_ULL(57, 51)
 
 /* bitmasks for RAPL TPMI, used by primitive access functions */
-#define TPMI_POWER_LIMIT_MASK		0x3FFFF
+#define TPMI_POWER_LIMIT_MASK		GENMASK_ULL(17, 0)
 #define TPMI_POWER_LIMIT_ENABLE		BIT_ULL(62)
-#define TPMI_TIME_WINDOW_MASK		(0x7FULL<<18)
-#define TPMI_INFO_SPEC_MASK		0x3FFFF
-#define TPMI_INFO_MIN_MASK		(0x3FFFFULL << 18)
-#define TPMI_INFO_MAX_MASK		(0x3FFFFULL << 36)
-#define TPMI_INFO_MAX_TIME_WIN_MASK	(0x7FULL << 54)
+#define TPMI_TIME_WINDOW_MASK		GENMASK_ULL(24, 18)
+#define TPMI_INFO_SPEC_MASK		GENMASK_ULL(17, 0)
+#define TPMI_INFO_MIN_MASK		GENMASK_ULL(35, 18)
+#define TPMI_INFO_MAX_MASK		GENMASK_ULL(53, 36)
+#define TPMI_INFO_MAX_TIME_WIN_MASK	GENMASK_ULL(60, 54)
 
 /* Non HW constants */
 #define RAPL_PRIMITIVE_DERIVED		BIT(1)	/* not from raw data */
@@ -111,9 +111,9 @@
 #define TPMI_POWER_UNIT_OFFSET		POWER_UNIT_OFFSET
 #define TPMI_POWER_UNIT_MASK		POWER_UNIT_MASK
 #define TPMI_ENERGY_UNIT_OFFSET		0x06
-#define TPMI_ENERGY_UNIT_MASK		0x7C0
+#define TPMI_ENERGY_UNIT_MASK		GENMASK_ULL(10, 6)
 #define TPMI_TIME_UNIT_OFFSET		0x0C
-#define TPMI_TIME_UNIT_MASK		0xF000
+#define TPMI_TIME_UNIT_MASK		GENMASK_ULL(15, 12)
 
 #define RAPL_EVENT_MASK			GENMASK(7, 0)
 
@@ -964,13 +964,13 @@ static int rapl_check_unit_core(struct rapl_domain *rd)
 	}
 
 	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
-	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / (1 << value);
+	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / BIT(value);
 
 	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
-	rd->power_unit = 1000000 / (1 << value);
+	rd->power_unit = 1000000 / BIT(value);
 
 	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
-	rd->time_unit = 1000000 / (1 << value);
+	rd->time_unit = 1000000 / BIT(value);
 
 	pr_debug("Core CPU %s:%s energy=%dpJ, time=%dus, power=%duW\n",
 		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
@@ -992,13 +992,13 @@ static int rapl_check_unit_atom(struct rapl_domain *rd)
 	}
 
 	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
-	rd->energy_unit = ENERGY_UNIT_SCALE * 1 << value;
+	rd->energy_unit = ENERGY_UNIT_SCALE * BIT(value);
 
 	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
-	rd->power_unit = (1 << value) * 1000;
+	rd->power_unit = BIT(value) * 1000;
 
 	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
-	rd->time_unit = 1000000 / (1 << value);
+	rd->time_unit = 1000000 / BIT(value);
 
 	pr_debug("Atom %s:%s energy=%dpJ, time=%dus, power=%duW\n",
 		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
@@ -1102,8 +1102,8 @@ static void set_floor_freq_atom(struct rapl_domain *rd, bool enable)
 			      &power_ctrl_orig_val);
 	mdata = power_ctrl_orig_val;
 	if (enable) {
-		mdata &= ~(0x7f << 8);
-		mdata |= 1 << 8;
+		mdata &= ~GENMASK(14, 8);
+		mdata |= BIT(8);
 	}
 	iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_CR_WRITE,
 		       defaults->floor_freq_reg_addr, mdata);
@@ -1136,7 +1136,7 @@ static u64 rapl_compute_time_window_core(struct rapl_domain *rd, u64 value,
 		if (y > 0x1f)
 			return 0x7f;
 
-		f = div64_u64(4 * (value - (1ULL << y)), 1ULL << y);
+		f = div64_u64(4 * (value - BIT_ULL(y)), BIT_ULL(y));
 		value = (y & 0x1f) | ((f & 0x3) << 5);
 	}
 	return value;
@@ -1169,13 +1169,13 @@ static int rapl_check_unit_tpmi(struct rapl_domain *rd)
 	}
 
 	value = (ra.value & TPMI_ENERGY_UNIT_MASK) >> TPMI_ENERGY_UNIT_OFFSET;
-	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / (1 << value);
+	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / BIT(value);
 
 	value = (ra.value & TPMI_POWER_UNIT_MASK) >> TPMI_POWER_UNIT_OFFSET;
-	rd->power_unit = 1000000 / (1 << value);
+	rd->power_unit = 1000000 / BIT(value);
 
 	value = (ra.value & TPMI_TIME_UNIT_MASK) >> TPMI_TIME_UNIT_OFFSET;
-	rd->time_unit = 1000000 / (1 << value);
+	rd->time_unit = 1000000 / BIT(value);
 
 	pr_debug("Core CPU %s:%s energy=%dpJ, time=%dus, power=%duW\n",
 		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
-- 
2.43.0


