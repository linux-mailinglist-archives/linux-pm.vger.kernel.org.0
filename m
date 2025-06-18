Return-Path: <linux-pm+bounces-28930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F573ADE16A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 05:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94721899637
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 03:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A901946A0;
	Wed, 18 Jun 2025 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WaAUYhbv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45FF13E02D;
	Wed, 18 Jun 2025 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750215817; cv=none; b=TBTQl2mXFcLsx7h+Gma7K0dDWuWxnuGA1bt3L99kfSBXoZwOZFsA2r+7XACEeF3DrEY6ivbPB8aTiMoLQPmTZDpFOu9MOhW4SvKuv4Cbl4KKrt0P6SHs6fgp0JcB5kVJcrIV2WMKkKcfX5OpaSXbKDZxMcSwdtm1qaUcMm+NOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750215817; c=relaxed/simple;
	bh=wBHzSOQV0F9MYMOYT8LLj7nLzOTQDw6XiAEoJCc7QAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mpHdMS7/XrZ+6O2TwMrDhmbdsEh1SmQJkfjHob1IYty6Rq8Ub0ncEg6UvCzIgdotjv/y2Ce3g3Tg4qitmYMUy5WWQe+34zvV0cuhyj/9oora+zewl+yQ4zufkcIIbSDCRhRC49W+uC8SDRELaBQSB+SYv1hIs47iHvU1lfvsIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WaAUYhbv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750215815; x=1781751815;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wBHzSOQV0F9MYMOYT8LLj7nLzOTQDw6XiAEoJCc7QAk=;
  b=WaAUYhbvDZAA2r3C+MDxxfrlNsQRBXSwqcFfwklf0o3Pk4U/T7OJ2TX3
   LbuIQQ1Yrs5yGvM5hTqVzLZaJmvq17ywRJKCE5MyoqRcjQR4mO0+00ucR
   nMXtHszOSzHEQmFIBpPdJLJKehDp73atPk9ywT3IjtLe51kctqHMs25AK
   eeSsQXa1McJoyVcVRzFlWt/7Oql0Dx/v/jrHMOTtPK/hmKhABvsAYj4ZN
   f3/E2CprBKnm3uX5DNIYNdkr/8foTnj/THWd5AERVkZmAdq2Om/AaN/u+
   HIGBosp3foQWbyXYVdAIAlWs4TKUxVz6kgPyPI06/j+pQF7tsfjXyF0An
   Q==;
X-CSE-ConnectionGUID: ac6mMT9AS1WJJf0ClOB6Lw==
X-CSE-MsgGUID: yCYDu1FIQGyGUALUzEwEdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="55035019"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="55035019"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 20:03:34 -0700
X-CSE-ConnectionGUID: 7kgiN8XUT6a/GJU7B6+2Bw==
X-CSE-MsgGUID: xQXZtLJBSpObTfIgO0YC8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="149946871"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.124])
  by orviesa008.jf.intel.com with ESMTP; 17 Jun 2025 20:03:32 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH] powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed
Date: Wed, 18 Jun 2025 11:03:30 +0800
Message-ID: <20250618030330.279410-1-rui.zhang@intel.com>
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

Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
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


