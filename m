Return-Path: <linux-pm+bounces-27315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B58ABB5C1
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 09:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA861898A84
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 07:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD69265CC2;
	Mon, 19 May 2025 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjmWEAJ/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4379D2586E0;
	Mon, 19 May 2025 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638553; cv=none; b=XqOD/nHGxEDXbxT/2EM/2GaKDhI8p6cg8UWq2K9JL5ceWaRFLY0NouBNeiTPXCBjIjsew2RQ7cOfwG3U2F33ySrNVhkmF1WEmetT8Pyy1GhN+gSkng1vJF470+HKb15mR807ttNlTBu2WqQyD3Lt+sX9nooavbQLXDucrdoWYao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638553; c=relaxed/simple;
	bh=YPfaHyzVc1GkjxTfsXefHKSQnQddmr9nsMn8mGq/bRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJRt8pjjU2/Z2MhWVblSiTCG0cR6vItUVpxde6ONDoFVMJX2Ynfs3pfpMict4MxFNeiFg4iymuJOexlqOsfXKLDhBh3SapLH2fiP4LvSN/3/hZ/omP6kOT1L5D611LWh4iekm2iHqnXsqil45iIMX1bfpcTCZneJedw/fuIZZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjmWEAJ/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747638552; x=1779174552;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YPfaHyzVc1GkjxTfsXefHKSQnQddmr9nsMn8mGq/bRQ=;
  b=hjmWEAJ/Uv1a705WKLVbdv70Hzm2Xw5j6AN5b/kCE/o3ZjAdsboHv8Ws
   nJsyaHGca6NdWJzo0THc9zBQ1moz6vh46bigTIditk44ZIhVopSvT2370
   liJkG9SXSynbO55wLjcbRpaGRRhd0NYtA7FMLjyUWdIZRIKeOx3aBBIQ3
   0BiuvaiT3KotefuEfz4Yve1DXZIwA/Jt5/nnAovcIM1BVdrJaBkqZD4Kc
   D9QWpBaufZ+bq9Lsj22voCqxB3sGZe/3jnMIRG4cyuV0s2CNPvwSKONG3
   N7Iy5qx/cMFELcIcCII8FeIVt9bCX0/LdROtUu/crtyWIKLGe+E3TQrGe
   w==;
X-CSE-ConnectionGUID: bF4HhNGFTKWChFJ7R/wX3g==
X-CSE-MsgGUID: gmC6gUSwQGeKMFOP+T21fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="59752787"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="59752787"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 00:09:05 -0700
X-CSE-ConnectionGUID: WJQM+OVRTFawgrmKBv9J9w==
X-CSE-MsgGUID: i62RG5J6TaKO3DrGxXPPKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="170321353"
Received: from rzhang1-mobl7.sh.intel.com ([10.238.6.124])
  by fmviesa001.fm.intel.com with ESMTP; 19 May 2025 00:09:02 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: zhangn1985@outlook.com,
	daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] thermal: intel: x86_pkg_temp_thermal: Fix bogus trip temperature
Date: Mon, 19 May 2025 15:09:01 +0800
Message-ID: <20250519070901.1031233-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tj_max value obtained from the Intel TCC library are in Celsius,
whereas the thermal subsystem operates in milli-Celsius.
This discrepancy leads to incorrect trip temperature calculations.

Fix bogus trip temperature by converting tj_max to milli-Celsius Unit.

Fixes: 8ef0ca4a177d ("Merge back other thermal control material for 6.3.")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reported-by: zhang ning <zhangn1985@outlook.com>
Closes: https://lore.kernel.org/all/TY2PR01MB3786EF0FE24353026293F5ACCD97A@TY2PR01MB3786.jpnprd01.prod.outlook.com/
Tested-by: zhang ning <zhangn1985@outlook.com>
---
Commit 983eb370cb87 ("thermal/x86_pkg_temp_thermal: Use Intel TCC
library") converts tj_max to use the standard API without switching the
Unit, which is a bug. This was mitigated by the next commit 58374a3970a0
("thermal/x86_pkg_temp_thermal: Add support for handling dynamic tjmax")
which uses the Celsius tj_max for failure check only.

This may confuse the maintainer and the bug was introduced by commit
8ef0ca4a177d ("Merge back other thermal control material for 6.3."),
when addressing the conflicts with commit d3ecaf17b586
("thermal/drivers/intel: Use generic thermal_zone_get_trip() function").
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 4894a26b1e4e..3fc679b6f11b 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -330,6 +330,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	tj_max = intel_tcc_get_tjmax(cpu);
 	if (tj_max < 0)
 		return tj_max;
+	tj_max *= 1000;
 
 	zonedev = kzalloc(sizeof(*zonedev), GFP_KERNEL);
 	if (!zonedev)
-- 
2.43.0


