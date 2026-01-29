Return-Path: <linux-pm+bounces-41714-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OLfGeKoe2m8HgIAu9opvQ
	(envelope-from <linux-pm+bounces-41714-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E00DEB39DE
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 19:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B6C63028122
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87D2FBDED;
	Thu, 29 Jan 2026 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGq1LRXt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7462FB0B9;
	Thu, 29 Jan 2026 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711828; cv=none; b=h6qe0mlwNpIBdSHC+tr0G9FJnbR0Y0UhX8h8JHkYJ6JS6WqydaTfeuOuhaVkbv4tp2C3Nc3gryBt/spxX1FnfwUuQkOJXlVjgEaHFFVH4SrvdTIAlcHG/G32YEZx1ICVzZqLpWwB/v0YtHiqOk5NDBf6kZNT7Pn8eFH2QO3E7Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711828; c=relaxed/simple;
	bh=m91yGa01BJGvQIQd8V8kwIaiUDcEEaPiwT9/wKPpdq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jBmxgZe/mN9ohdbklO+oe8UZjPO59lDyWz1Lhi/cpGsa4uYdfXSPw7wHM1iuoqUDd2dtTaJ17gwBB1WvbaVv6N/FI/GIwNUHjxkMaJLAGz4pHNMfdMAFeJ5W+C0FgFGV/+KovH+1bJ/513Pqk64m0xHySqEv9WMmHDKuGv2NThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGq1LRXt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769711827; x=1801247827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m91yGa01BJGvQIQd8V8kwIaiUDcEEaPiwT9/wKPpdq0=;
  b=jGq1LRXtvSe+zDFid7wEETk0UhzNPZEgeyCfi50m4nlVg0d5F2V179ap
   Cbshi68xdwVCeEbsDjAN1zVHFEBY89bMFsmG0/oL78W8RCMS5rknts3H1
   oyZ43cCroP9RkkMhU0lVhjlJazkx33bML8zIgNBjCCs+friCBt+1HxsE1
   XzX4WlFvFgFMOBMiAawk7a5VVStJ5+HVjGhicv0NvpCB4BWTMk/z2BpNb
   S/aNgm+HNXCpseA9f8TbcqtRc2VqPZBSVXXQX1ZpglxmiKdqDp3ad69N0
   y5oAZ+wNjW98IaR2Pn5wDj0ZK/o7UvX0K0NogSirzyJyr85WUgvb8qtnx
   w==;
X-CSE-ConnectionGUID: XCgjzVwlS3u9umhTW9XtmQ==
X-CSE-MsgGUID: QbKGJZZ/RZ67p/LY3s0haw==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82388364"
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="82388364"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:06 -0800
X-CSE-ConnectionGUID: 3hTz1OcETVe0RaI5ugX+5Q==
X-CSE-MsgGUID: 3ToLsi50Q16YbldgF20Iyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,261,1763452800"; 
   d="scan'208";a="209070966"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 10:37:06 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/9] powercap: intel_rapl: Use unit conversion macros from units.h
Date: Thu, 29 Jan 2026 10:36:41 -0800
Message-ID: <20260129183646.558866-5-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41714-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: E00DEB39DE
X-Rspamd-Action: no action

Replace hardcoded numeric constants with standard unit conversion
macros from linux/units.h for better code clarity and
self-documentation.

Add MICROJOULE_PER_JOULE and NANOJOULE_PER_JOULE to units.h to
support energy unit conversions, following the existing pattern
for power units.

No functional changes.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 19 ++++++++++---------
 include/linux/units.h                |  3 +++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 0faafba8cc7c..8f9d504fb64c 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -24,6 +24,7 @@
 #include <linux/suspend.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
@@ -964,13 +965,13 @@ static int rapl_check_unit_core(struct rapl_domain *rd)
 	}
 
 	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
-	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / BIT(value);
+	rd->energy_unit = ENERGY_UNIT_SCALE * MICROJOULE_PER_JOULE / BIT(value);
 
 	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
-	rd->power_unit = 1000000 / BIT(value);
+	rd->power_unit = MICROWATT_PER_WATT / BIT(value);
 
 	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
-	rd->time_unit = 1000000 / BIT(value);
+	rd->time_unit = USEC_PER_SEC / BIT(value);
 
 	pr_debug("Core CPU %s:%s energy=%dpJ, time=%dus, power=%duW\n",
 		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
@@ -995,10 +996,10 @@ static int rapl_check_unit_atom(struct rapl_domain *rd)
 	rd->energy_unit = ENERGY_UNIT_SCALE * BIT(value);
 
 	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
-	rd->power_unit = BIT(value) * 1000;
+	rd->power_unit = BIT(value) * MILLIWATT_PER_WATT;
 
 	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
-	rd->time_unit = 1000000 / BIT(value);
+	rd->time_unit = USEC_PER_SEC / BIT(value);
 
 	pr_debug("Atom %s:%s energy=%dpJ, time=%dus, power=%duW\n",
 		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
@@ -1169,13 +1170,13 @@ static int rapl_check_unit_tpmi(struct rapl_domain *rd)
 	}
 
 	value = (ra.value & TPMI_ENERGY_UNIT_MASK) >> TPMI_ENERGY_UNIT_OFFSET;
-	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / BIT(value);
+	rd->energy_unit = ENERGY_UNIT_SCALE * MICROJOULE_PER_JOULE / BIT(value);
 
 	value = (ra.value & TPMI_POWER_UNIT_MASK) >> TPMI_POWER_UNIT_OFFSET;
-	rd->power_unit = 1000000 / BIT(value);
+	rd->power_unit = MICROWATT_PER_WATT / BIT(value);
 
 	value = (ra.value & TPMI_TIME_UNIT_MASK) >> TPMI_TIME_UNIT_OFFSET;
-	rd->time_unit = 1000000 / BIT(value);
+	rd->time_unit = USEC_PER_SEC / BIT(value);
 
 	pr_debug("Core CPU %s:%s energy=%dpJ, time=%dus, power=%duW\n",
 		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
@@ -1208,7 +1209,7 @@ static const struct rapl_defaults rapl_defaults_spr_server = {
 	.check_unit = rapl_check_unit_core,
 	.set_floor_freq = set_floor_freq_default,
 	.compute_time_window = rapl_compute_time_window_core,
-	.psys_domain_energy_unit = 1000000000,
+	.psys_domain_energy_unit = NANOJOULE_PER_JOULE,
 	.spr_psys_bits = true,
 };
 
diff --git a/include/linux/units.h b/include/linux/units.h
index 00e15de33eca..8c17d98cd67e 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -35,6 +35,9 @@
 #define MICROWATT_PER_MILLIWATT	1000UL
 #define MICROWATT_PER_WATT	1000000UL
 
+#define MICROJOULE_PER_JOULE	1000000UL
+#define NANOJOULE_PER_JOULE	1000000000UL
+
 #define BYTES_PER_KBIT		(KILO / BITS_PER_BYTE)
 #define BYTES_PER_MBIT		(MEGA / BITS_PER_BYTE)
 #define BYTES_PER_GBIT		(GIGA / BITS_PER_BYTE)
-- 
2.43.0


