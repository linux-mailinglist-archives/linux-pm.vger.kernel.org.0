Return-Path: <linux-pm+bounces-42592-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCziJ91ijmn1BwEAu9opvQ
	(envelope-from <linux-pm+bounces-42592-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:31:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A730131BE8
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 00:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21D37310AE13
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 23:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5352EC55D;
	Thu, 12 Feb 2026 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPvOGqoK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3072DE711;
	Thu, 12 Feb 2026 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770939052; cv=none; b=M2A5MAF4t6U89Dj+7C0cfsycxn3xL9om8nIubNPMSfu0iLmaP5Chy/4tofEjxR37hJb0ylnuH9GhF56hwS9NwjcnJN4irRUnmz5LUWlkNm+mdcNiNkCR3aeiwToNxcBWvgAeCkgiK2xKj1an+02J5QCY0Ia0WxmdKMs9GFzAagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770939052; c=relaxed/simple;
	bh=wGXMr7yLC4zMexW2WOtbSa/ZTiZjiR+uyKVHb2Mt3tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXtPX29eWKdcPuKuXywlFEFoD1jyN8gxERnnhQFclZwsQU5eQInlESLHo+0YNAMG3lG58hJfWjtDWjIaG3ZxFZZZIlFyK9IPOYfD1t3NQYqeprqnnnjViELxQeq5fI1oGWkH8ZslEmnr+tapgPvNJ1f3HelcgbpvXAm2bwRH6VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPvOGqoK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770939051; x=1802475051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wGXMr7yLC4zMexW2WOtbSa/ZTiZjiR+uyKVHb2Mt3tw=;
  b=JPvOGqoKkBULUYDAU97vcV4e85ZK4btCaqidQiHL0181Lbk661hWOHNB
   Zj56DCbMYfCQCSqv5NTGp/uLlUQk2a8S5U26JvGziiAqxDTrOzI0loNf4
   5C/D7GQruPZeEN+SN8tIgLKrLPzdsL9pEvUwJgXnZESZ5gB0ISAAYVj0i
   SP95e2gha+dB6WWjlEjgdBoJJPyhXROpkEF77q1v7dci5j/FUqA+ka5zs
   ITxqKz8VRJW3lKKnwkeT8mRECFzwkPDdGvxAHacEouW0LPikk0vfxEyC3
   ZqQgMNkXsuR5bfkoSVoYPKZp+aGm/fIHngaLG8BTPu6IXWzwS7p/2XHLl
   Q==;
X-CSE-ConnectionGUID: TaPy/3dlTaiSWCiuK99thw==
X-CSE-MsgGUID: u07miE7QQFag8L7XOH5NKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72017418"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72017418"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 15:30:49 -0800
X-CSE-ConnectionGUID: Y6Aj5VKpTYuQYfUt5hezEQ==
X-CSE-MsgGUID: 7rFFAV4sRwWXBGzwa+wWWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211845390"
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
Subject: [PATCH v2 05/12] powercap: intel_rapl: Use shifts for power-of-2 operations
Date: Thu, 12 Feb 2026 15:30:37 -0800
Message-ID: <20260212233044.329790-6-sathyanarayanan.kuppuswamy@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-42592-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 1A730131BE8
X-Rspamd-Action: no action

Replace division by (1 << value) with shift operations for clarity and
consistency. Add ULL suffix to avoid undefined behavior from shifting
signed integers.

No functional changes intended.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/intel_rapl_common.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 74a74af8f0ec..819eab3988da 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -964,13 +964,13 @@ static int rapl_check_unit_core(struct rapl_domain *rd)
 	}
 
 	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
-	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / (1 << value);
+	rd->energy_unit = (ENERGY_UNIT_SCALE * 1000000) >> value;
 
 	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
-	rd->power_unit = 1000000 / (1 << value);
+	rd->power_unit = 1000000 >> value;
 
 	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
-	rd->time_unit = 1000000 / (1 << value);
+	rd->time_unit = 1000000 >> value;
 
 	pr_debug("Core CPU %s:%s energy=%dpJ, time=%dus, power=%duW\n",
 		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
@@ -992,13 +992,13 @@ static int rapl_check_unit_atom(struct rapl_domain *rd)
 	}
 
 	value = (ra.value & ENERGY_UNIT_MASK) >> ENERGY_UNIT_OFFSET;
-	rd->energy_unit = ENERGY_UNIT_SCALE * 1 << value;
+	rd->energy_unit = ENERGY_UNIT_SCALE * (1ULL << value);
 
 	value = (ra.value & POWER_UNIT_MASK) >> POWER_UNIT_OFFSET;
-	rd->power_unit = (1 << value) * 1000;
+	rd->power_unit = (1ULL << value) * 1000;
 
 	value = (ra.value & TIME_UNIT_MASK) >> TIME_UNIT_OFFSET;
-	rd->time_unit = 1000000 / (1 << value);
+	rd->time_unit = 1000000 >> value;
 
 	pr_debug("Atom %s:%s energy=%dpJ, time=%dus, power=%duW\n",
 		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
@@ -1121,7 +1121,7 @@ static u64 rapl_compute_time_window_core(struct rapl_domain *rd, u64 value,
 	if (!to_raw) {
 		f = (value & 0x60) >> 5;
 		y = value & 0x1f;
-		value = (1 << y) * (4 + f) * rd->time_unit / 4;
+		value = (1ULL << y) * (4 + f) * rd->time_unit / 4;
 	} else {
 		if (value < rd->time_unit)
 			return 0;
@@ -1169,13 +1169,13 @@ static int rapl_check_unit_tpmi(struct rapl_domain *rd)
 	}
 
 	value = (ra.value & TPMI_ENERGY_UNIT_MASK) >> TPMI_ENERGY_UNIT_OFFSET;
-	rd->energy_unit = ENERGY_UNIT_SCALE * 1000000 / (1 << value);
+	rd->energy_unit = (ENERGY_UNIT_SCALE * 1000000) >> value;
 
 	value = (ra.value & TPMI_POWER_UNIT_MASK) >> TPMI_POWER_UNIT_OFFSET;
-	rd->power_unit = 1000000 / (1 << value);
+	rd->power_unit = 1000000 >> value;
 
 	value = (ra.value & TPMI_TIME_UNIT_MASK) >> TPMI_TIME_UNIT_OFFSET;
-	rd->time_unit = 1000000 / (1 << value);
+	rd->time_unit = 1000000 >> value;
 
 	pr_debug("Core CPU %s:%s energy=%dpJ, time=%dus, power=%duW\n",
 		 rd->rp->name, rd->name, rd->energy_unit, rd->time_unit, rd->power_unit);
-- 
2.43.0


