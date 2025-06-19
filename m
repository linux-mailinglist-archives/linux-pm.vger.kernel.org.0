Return-Path: <linux-pm+bounces-29053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E6CADFE6F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 09:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260321895CBB
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 07:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3852248F7B;
	Thu, 19 Jun 2025 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjAAM/U0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE924889F;
	Thu, 19 Jun 2025 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750317225; cv=none; b=Pd8vfpS4B/OLaiUoli1cNat04MTGqv1NlcmUnC34ScnN+1mRG4lH+vCXhdDtBPavj9IKbxPsna78xrU8sjvf3cic3thHkRB+SVwA1UnF3TU23+474VO4QZewrgTj9PQljYT0h6Sshz9j+qqXQATqWKhabzUx9itUq/F40Li8DZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750317225; c=relaxed/simple;
	bh=4xA0RoGRvB2kw00QVEj11UUfC0eS3ezt7ZAVTF3rcY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SosEgI60CFHF/YH7/4YChzMRnJrYOV5BVgLyAJ4UCpO+WDZlNt9i+5nxAd1QZ1TmCRM89OXdm4egB/SCDexSCnCwoLoBJ3V76b7JB/A+fgqgTN60gSrkcb+ylkPN8WPWPndXfR4eVymrPf+BhiWHQIWcOVYxpUvheKigCR6YmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjAAM/U0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750317224; x=1781853224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4xA0RoGRvB2kw00QVEj11UUfC0eS3ezt7ZAVTF3rcY8=;
  b=hjAAM/U0eWwEJPzH7lzZiweRqWTxQNwiww4kM6UYjaoYXkkWSg+oU+Nt
   FUFUxwfb4fhWAW+1N5BoGEC0EeCJco1mh3OyQLEfnxLPCrjzdm6iNB90M
   LH/VUr7zuWJyiIBVs18Q9B1Kek6R3Wj/XgnpultnF6IqYTMiwU5HMW1zf
   7/sJae0yhM3LO1bNE5dEaXuZL8As46C8/9zvJTvavTuwUH/az4vnrsKFP
   GYgLlKeifG3lXkT0G+GLfnLOpKIjYzkrE+KOek1t9n7O/TqcmfN68fTaZ
   WE2lQ8BdiWRqMRPrYWALKT8OAHOguKcgH37HdJUuaVhJ6vZ9YYmaHatIM
   g==;
X-CSE-ConnectionGUID: qk3I7cokRxCxtoisy6mZRg==
X-CSE-MsgGUID: 5GlpS0+DSPure8HiQ0BtHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="51793791"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="51793791"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 00:13:44 -0700
X-CSE-ConnectionGUID: 9HG0g9j6SrKNmYm3Fo3D5A==
X-CSE-MsgGUID: ZHxfMLB+QoKPcsVd/Gf7aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="155123323"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.124])
  by orviesa004.jf.intel.com with ESMTP; 19 Jun 2025 00:13:41 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH V2] powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed
Date: Thu, 19 Jun 2025 15:13:40 +0800
Message-ID: <20250619071340.384782-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PL1 cannot be disabled on some platforms. The ENABLE bit is still set
after software clears it. This behavior leads to a scenario where, upon
user request to disable the Power Limit through the powercap sysfs, the
ENABLE bit remains set while the CLAMPING bit is inadvertently cleared.

According to the Intel Software Developer's Manual, the CLAMPING bit,
"When set, allows the processor to go below the OS requested P states in
order to maintain the power below specified Platform Power Limit value."

Thus this means the system may operate at higher power levels than
intended on such platforms.

Enhance the code to check ENABLE bit after writing to it, and stop
further processing if ENABLE bit cannot be changed.

Cc: stable@vger.kernel.org
Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Fixes: 2d281d8196e3 ("PowerCap: Introduce Intel RAPL power capping driver")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
Changes since V1:
- Add Fixes tag
- CC stable kernel
---
 drivers/powercap/intel_rapl_common.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index e3be40adc0d7..602f540cbe15 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -341,12 +341,27 @@ static int set_domain_enable(struct powercap_zone *power_zone, bool mode)
 {
 	struct rapl_domain *rd = power_zone_to_rapl_domain(power_zone);
 	struct rapl_defaults *defaults = get_defaults(rd->rp);
+	u64 val;
 	int ret;
 
 	cpus_read_lock();
 	ret = rapl_write_pl_data(rd, POWER_LIMIT1, PL_ENABLE, mode);
-	if (!ret && defaults->set_floor_freq)
+	if (ret)
+		goto end;
+
+	ret = rapl_read_pl_data(rd, POWER_LIMIT1, PL_ENABLE, false, &val);
+	if (ret)
+		goto end;
+
+	if (mode != val) {
+		pr_debug("%s cannot be %s\n", power_zone->name, mode ? "enabled" : "disabled");
+		goto end;
+	}
+
+	if (defaults->set_floor_freq)
 		defaults->set_floor_freq(rd, mode);
+
+end:
 	cpus_read_unlock();
 
 	return ret;
-- 
2.43.0


