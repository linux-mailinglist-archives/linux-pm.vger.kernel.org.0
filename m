Return-Path: <linux-pm+bounces-42599-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HisN4xjjmn1BwEAu9opvQ
	(envelope-from <linux-pm+bounces-42599-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:34:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF5A131C4B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE95331C8720
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 23:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1622F362B;
	Thu, 12 Feb 2026 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZL1AqXX1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430C2F260E;
	Thu, 12 Feb 2026 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939060; cv=none; b=IYHsSgQu0hutPpAJrB71AGPZmLLih50TxgjjNI34mwDJvIbSvz7dmRnRoIF1FSXCGVDZ6vf8VPzIw9aDTgDV1TQnwCrPFWWFGpTUDkJAE5OGw13MGdNbYy47n2f4OY3Naz3pQFAUzK/LoQkhayhxENIzXLvA+tLbob4+JMiWkDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939060; c=relaxed/simple;
	bh=ICHQ3RgooLOUl9W7kvF4fjTrAsEJ2DDM+UnC77xozl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HByyopco6BVNxcgb8G/x4E79AAGBX1S+EkOd5Q6wyY8ewADhP9SY/xASbY80X2riVxD2Mx1KBnKpqFq/T7pj0Taped02422/NwAy9bb7rvjx20gwVWghn0EAAQ5/Bl0yUdaGdU6NgpcdQPb3BSySnl2ahWifn0Rrrys9z+Ep77o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZL1AqXX1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770939053; x=1802475053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ICHQ3RgooLOUl9W7kvF4fjTrAsEJ2DDM+UnC77xozl8=;
  b=ZL1AqXX1SJys4USghd/o4bcxyuVkEvMKe/4jS2EuyXOHWfOJdb4q2Dou
   mpF83gC7eoFzD6n8kWBS7Ke61vBE1ptsX6BY6WhxfB5kMI/D7G1FHPElE
   nJ/1cYsSX9jYpSndHgldeVHL4qQ1Hj3ZPj34lwnFS/5crQzigi72zs07O
   EsSBuM9Kbf0XMboXkw29Z48lrnpX6fJhyv/u+fD/5qEF0zGWJJXdKHExb
   b7BP2uCMPMtsBWRb0FqFX0+url6Q1vNkhm0mScYmhjHpQB5faDo0eM8Ws
   8/Viml45/e71q86pISEcyoPbMWfCTiwdSRlz6r5kIlOobyZtehR0rZEpe
   Q==;
X-CSE-ConnectionGUID: rsfiPgTOTj2i5t3hmBM9iw==
X-CSE-MsgGUID: Aeq/iZetThG4meX0kT+OYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72017440"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72017440"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:49 -0800
X-CSE-ConnectionGUID: wklTk432R96FTQMhZx1VdQ==
X-CSE-MsgGUID: Yv8h9MOcQ0KBgnltG7HOig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211845402"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:46 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/12] powercap: intel_rapl: Use GENMASK() and BIT() macros
Date: Thu, 12 Feb 2026 15:30:38 -0800
Message-ID: <20260212233044.329790-7-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42599-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AF5A131C4B
X-Rspamd-Action: no action

Replace hardcoded bitmasks and bit shift operations with standard
GENMASK(), GENMASK_ULL(), BIT(), and BIT_ULL() macros for better
readability and to follow kernel coding conventions.

No functional changes.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 60 ++++++++++++++--------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 819eab3988da..aa505e2ebc94 100644
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
-- 
2.43.0


