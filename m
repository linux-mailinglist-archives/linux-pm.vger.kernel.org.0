Return-Path: <linux-pm+bounces-42593-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGQ1Lt9ijmn1BwEAu9opvQ
	(envelope-from <linux-pm+bounces-42593-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:31:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A67F131BEF
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 426C1310CA96
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 23:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6E22ED848;
	Thu, 12 Feb 2026 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGSn2Yd/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B472E0400;
	Thu, 12 Feb 2026 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939052; cv=none; b=HbMpr4FC7NSjvUZFheSoz0U/ghDie0Q/uiYgY37vQ85ZnchB+yrCoT+XCgbYD3cJCvjtMF5smb/ahcR3QBPAJjEUNPUt1I7PxrSkmiRv9enfaQF5bRO4T9c6lfJ1saakR4jo5Tlu5cHk2RLAk/hU9Ua/ew4Zek9f9mqaDjfFauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939052; c=relaxed/simple;
	bh=0OYe9pnYnq/aknJZOeO1YkpKJ3ZHIZch7vkQWVXm8uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCLtyJse4Gbhns2qWcsVeZycsRWdf3c+Z7lWAc4Ce2QCpZspBIDFuXaDn9aX/sTJCt4sK3sYYxf5l3l5N9zgT1PbdCOz63QM3kijoDVQN+ou9eQHu2dYSfkqq7FOvcFnIB61DmL0w6tp8OxAT80XhcObZtKWaVqrY4mw4HCPoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGSn2Yd/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770939051; x=1802475051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0OYe9pnYnq/aknJZOeO1YkpKJ3ZHIZch7vkQWVXm8uk=;
  b=WGSn2Yd/nTr7Q1V9ay1IocA4RQaprV/UH9nq1c4LzA7eJYiaisxMsGoB
   3WFyWpkPQQUwPFexrd9+DIS7Xz8dU3axp3XfPMEbHys8e29cpqMz9Nd5Y
   7M7/LGS6pwiaA2FB7BnT1IQb+JsEYTQQ1RaY4FIWckCjf6FScMij5hCDD
   xDhmOF+S0IfamRVZrMptgJGh9dVG85nmwZlAlRfa65nO+f6P0W07GwRlk
   VTJ+cZBDnRrE30SS/3/lCtPBkA0DnWdaKbDn+rUNy6aLm5+qRFJ4IAjWj
   ky0TEojGeWacfR7peIi316iic0TDQYeo7NTrTHPuxYvMJ++CiaCm2uNAm
   g==;
X-CSE-ConnectionGUID: JbZ+eNAQStelwWuGWcn4LQ==
X-CSE-MsgGUID: u+j3ZvykTdyTL1KZbRct3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72017426"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72017426"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:49 -0800
X-CSE-ConnectionGUID: B3whxwFVRF6d5uwyiyoMnA==
X-CSE-MsgGUID: f1bIqwlnQPiQDFF0e6OUbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211845404"
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
Subject: [PATCH v2 07/12] powercap: intel_rapl: Use unit conversion macros from units.h
Date: Thu, 12 Feb 2026 15:30:39 -0800
Message-ID: <20260212233044.329790-8-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-42593-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 1A67F131BEF
X-Rspamd-Action: no action

Replace hardcoded numeric constants with standard unit conversion
macros from linux/units.h for better code clarity and
self-documentation.

Add MICROJOULE_PER_JOULE and NANOJOULE_PER_JOULE to units.h to
support energy unit conversions, following the existing pattern
for power units.

No functional changes.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 19 ++++++++++---------
 include/linux/units.h                |  3 +++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index aa505e2ebc94..38b21e3077de 100644
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
-	rd->energy_unit = (ENERGY_UNIT_SCALE * 1000000) >> value;
+	rd->energy_unit = (ENERGY_UNIT_SCALE * MICROJOULE_PER_JOULE) >> value;
 
 	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
-	rd->power_unit = 1000000 >> value;
+	rd->power_unit = MICROWATT_PER_WATT >> value;
 
 	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
-	rd->time_unit = 1000000 >> value;
+	rd->time_unit = USEC_PER_SEC >> value;
 
 	pr_debug("Core CPU %s:%s energy=%dpJ, time=%dus, power=%duW\n",
 		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
@@ -995,10 +996,10 @@ static int rapl_check_unit_atom(struct rapl_domain *rd)
 	rd->energy_unit = ENERGY_UNIT_SCALE * (1ULL << value);
 
 	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
-	rd->power_unit = (1ULL << value) * 1000;
+	rd->power_unit = (1ULL << value) * MILLIWATT_PER_WATT;
 
 	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
-	rd->time_unit = 1000000 >> value;
+	rd->time_unit = USEC_PER_SEC >> value;
 
 	pr_debug("Atom %s:%s energy=%dpJ, time=%dus, power=%duW\n",
 		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
@@ -1169,13 +1170,13 @@ static int rapl_check_unit_tpmi(struct rapl_domain *rd)
 	}
 
 	value = (ra.value & TPMI_ENERGY_UNIT_MASK) >> TPMI_ENERGY_UNIT_OFFSET;
-	rd->energy_unit = (ENERGY_UNIT_SCALE * 1000000) >> value;
+	rd->energy_unit = (ENERGY_UNIT_SCALE * MICROJOULE_PER_JOULE) >> value;
 
 	value = (ra.value & TPMI_POWER_UNIT_MASK) >> TPMI_POWER_UNIT_OFFSET;
-	rd->power_unit = 1000000 >> value;
+	rd->power_unit = MICROWATT_PER_WATT >> value;
 
 	value = (ra.value & TPMI_TIME_UNIT_MASK) >> TPMI_TIME_UNIT_OFFSET;
-	rd->time_unit = 1000000 >> value;
+	rd->time_unit = USEC_PER_SEC >> value;
 
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


