Return-Path: <linux-pm+bounces-17545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB5D9C8486
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06361285324
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E201F7085;
	Thu, 14 Nov 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5URKj2x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1BC1F7068
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571414; cv=none; b=eVMndhQFYLjDoCZVk+ZXmC0ag4M1mYqxZ+tsGq79kRAOntsAWvGU6pktUlriqd3Bl11RpchBxXxPEnJXjDNgGcQeIFHRyoVqykiS0XCWvhvTWvxVSFpkEKAjm3NxHuiJiyLHzJR/tqay5b4CBysunB7Jx2eOcVDS8wXXIsX1j4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571414; c=relaxed/simple;
	bh=sgXWBLYxlK/aUQLaAro1Z7uGRzkbkMQ1MuooJ69i9wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CW/QQ/B7Jp4egRobZuX3/z1RzI1oxE5GU3gyW+MSrSVRfGeJxkeZQBAQ2il3llShFiz2IP7tthBFCZPkeVhFc5Sji2TkNnhKojZWZzLOQlUVjhYiueo7HZwQzapRLalqRJyaZYWeGZgQb7Tdv79XVBZXUX4GTCT9Wli643ZfzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5URKj2x; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571413; x=1763107413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sgXWBLYxlK/aUQLaAro1Z7uGRzkbkMQ1MuooJ69i9wo=;
  b=d5URKj2xBb08dIUCrDRdcntM+7kfig26aFJSqle8uqcFC4jJ8MzK+OLi
   ND8uM3i2TpBNFqwIQL8/0tzj3wGiVVMl1xbc4koHL+6sJ792/qwCtG6NC
   kdRUmhGOo72XgICt1x4g5LVzN2WlSuI7+BiNmh4wtFeAxifvg0H9fCubl
   U2uBNFTgAtn6xZv0UgF0xb9o/FDB0MdRQF9fRbiq5mO8wn1W50uRdMdBM
   4S+BuRFlDbkOag6Kcjo180X6y8Od7quoLzupzGpUydoQYOfZhQx7vlW46
   xi9kYWQkQxVIZlvBZ+828MneHS6f68BGma86KKqzB3fHZV1cNjJSqY0Gu
   w==;
X-CSE-ConnectionGUID: aOR86Z/iTg+40d2JscoD6w==
X-CSE-MsgGUID: eAjzahQmQQ6M1Z9O9q5pPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31600455"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="31600455"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:03:26 -0800
X-CSE-ConnectionGUID: IGdR2/HSSEKRCXDE0OQWHw==
X-CSE-MsgGUID: pCmZpyuhSTSyLKd4MN6G4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="125627499"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 00:03:24 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 09/10] tools/power turbostat: Cache graphics sysfs file descriptors during probe
Date: Thu, 14 Nov 2024 15:59:45 +0800
Message-ID: <20241114075946.118577-10-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114075946.118577-1-rui.zhang@intel.com>
References: <20241114075946.118577-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Snapshots of the graphics sysfs knobs are taken based on file
descriptors. To optimize this process, open the files and cache the file
descriptors during the graphics probe phase. As a result, the previously
cached pathnames become redundant and are removed.

This change aims to streamline the code without altering its functionality.

No functional change intended.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 82 +++++++++++----------------
 1 file changed, 32 insertions(+), 50 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index aa0dab13d346..52b6ffc41bdf 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -370,7 +370,6 @@ enum gfx_sysfs_idx {
 };
 
 struct gfx_sysfs_info {
-	const char *path;
 	FILE *fp;
 	unsigned int val;
 	unsigned long long val_ull;
@@ -5733,10 +5732,7 @@ int snapshot_graphics(int idx)
 {
 	int retval;
 
-	if (gfx_info[idx].fp == NULL)
-		gfx_info[idx].fp = fopen_or_die(gfx_info[idx].path, "r");
-	else
-		rewind(gfx_info[idx].fp);
+	rewind(gfx_info[idx].fp);
 
 	switch (idx) {
 	case GFX_rc6:
@@ -6441,6 +6437,12 @@ static void probe_intel_uncore_frequency(void)
 		probe_intel_uncore_frequency_legacy();
 }
 
+static void set_graphics_fp(char *path, int idx)
+{
+	if (!access(path, R_OK))
+		gfx_info[idx].fp = fopen_or_die(path, "r");
+}
+
 static void probe_graphics(void)
 {
 	/* Xe graphics sysfs knobs */
@@ -6448,7 +6450,6 @@ static void probe_graphics(void)
 		FILE *fp;
 		char buf[8];
 		bool gt0_is_gt;
-		int idx;
 
 		fp = fopen("/sys/class/drm/card0/device/tile0/gt0/gtidle/name", "r");
 		if (!fp)
@@ -6467,28 +6468,17 @@ static void probe_graphics(void)
 		else
 			goto next;
 
-		idx = gt0_is_gt ? GFX_rc6 : SAM_mc6;
-		gfx_info[idx].path = "/sys/class/drm/card0/device/tile0/gt0/gtidle/idle_residency_ms";
+		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt0/gtidle/idle_residency_ms", gt0_is_gt ? GFX_rc6 : SAM_mc6);
 
-		idx = gt0_is_gt ? GFX_MHz : SAM_MHz;
-		if (!access("/sys/class/drm/card0/device/tile0/gt0/freq0/cur_freq", R_OK))
-			gfx_info[idx].path = "/sys/class/drm/card0/device/tile0/gt0/freq0/cur_freq";
+		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt0/freq0/cur_freq", gt0_is_gt ? GFX_MHz : SAM_MHz);
 
-		idx = gt0_is_gt ? GFX_ACTMHz : SAM_ACTMHz;
-		if (!access("/sys/class/drm/card0/device/tile0/gt0/freq0/act_freq", R_OK))
-			gfx_info[idx].path = "/sys/class/drm/card0/device/tile0/gt0/freq0/act_freq";
+		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt0/freq0/act_freq", gt0_is_gt ? GFX_ACTMHz : SAM_ACTMHz);
 
-		idx = gt0_is_gt ? SAM_mc6 : GFX_rc6;
-		if (!access("/sys/class/drm/card0/device/tile0/gt1/gtidle/idle_residency_ms", R_OK))
-			gfx_info[idx].path = "/sys/class/drm/card0/device/tile0/gt1/gtidle/idle_residency_ms";
+		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt1/gtidle/idle_residency_ms", gt0_is_gt ? SAM_mc6 : GFX_rc6);
 
-		idx = gt0_is_gt ? SAM_MHz : GFX_MHz;
-		if (!access("/sys/class/drm/card0/device/tile0/gt1/freq0/cur_freq", R_OK))
-			gfx_info[idx].path = "/sys/class/drm/card0/device/tile0/gt1/freq0/cur_freq";
+		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt1/freq0/cur_freq", gt0_is_gt ? SAM_MHz : GFX_MHz);
 
-		idx = gt0_is_gt ? SAM_ACTMHz : GFX_ACTMHz;
-		if (!access("/sys/class/drm/card0/device/tile0/gt1/freq0/act_freq", R_OK))
-			gfx_info[idx].path = "/sys/class/drm/card0/device/tile0/gt1/freq0/act_freq";
+		set_graphics_fp("/sys/class/drm/card0/device/tile0/gt1/freq0/act_freq", gt0_is_gt ? SAM_ACTMHz : GFX_ACTMHz);
 
 		goto end;
 	}
@@ -6496,52 +6486,44 @@ static void probe_graphics(void)
 next:
 	/* New i915 graphics sysfs knobs */
 	if (!access("/sys/class/drm/card0/gt/gt0/rc6_residency_ms", R_OK)) {
-		gfx_info[GFX_rc6].path = "/sys/class/drm/card0/gt/gt0/rc6_residency_ms";
+		set_graphics_fp("/sys/class/drm/card0/gt/gt0/rc6_residency_ms", GFX_rc6);
 
-		if (!access("/sys/class/drm/card0/gt/gt0/rps_cur_freq_mhz", R_OK))
-			gfx_info[GFX_MHz].path = "/sys/class/drm/card0/gt/gt0/rps_cur_freq_mhz";
+		set_graphics_fp("/sys/class/drm/card0/gt/gt0/rps_cur_freq_mhz", GFX_MHz);
 
-		if (!access("/sys/class/drm/card0/gt/gt0/rps_act_freq_mhz", R_OK))
-			gfx_info[GFX_ACTMHz].path = "/sys/class/drm/card0/gt/gt0/rps_act_freq_mhz";
+		set_graphics_fp("/sys/class/drm/card0/gt/gt0/rps_act_freq_mhz", GFX_ACTMHz);
 
-		if (!access("/sys/class/drm/card0/gt/gt1/rc6_residency_ms", R_OK))
-			gfx_info[SAM_mc6].path = "/sys/class/drm/card0/gt/gt1/rc6_residency_ms";
+		set_graphics_fp("/sys/class/drm/card0/gt/gt1/rc6_residency_ms", SAM_mc6);
 
-		if (!access("/sys/class/drm/card0/gt/gt1/rps_cur_freq_mhz", R_OK))
-			gfx_info[SAM_MHz].path = "/sys/class/drm/card0/gt/gt1/rps_cur_freq_mhz";
+		set_graphics_fp("/sys/class/drm/card0/gt/gt1/rps_cur_freq_mhz", SAM_MHz);
 
-		if (!access("/sys/class/drm/card0/gt/gt1/rps_act_freq_mhz", R_OK))
-			gfx_info[SAM_ACTMHz].path = "/sys/class/drm/card0/gt/gt1/rps_act_freq_mhz";
+		set_graphics_fp("/sys/class/drm/card0/gt/gt1/rps_act_freq_mhz", SAM_ACTMHz);
 
 		goto end;
 	}
 
 	/* Fall back to traditional i915 graphics sysfs knobs */
-	if (!access("/sys/class/drm/card0/power/rc6_residency_ms", R_OK))
-		gfx_info[GFX_rc6].path = "/sys/class/drm/card0/power/rc6_residency_ms";
+	set_graphics_fp("/sys/class/drm/card0/power/rc6_residency_ms", GFX_rc6);
 
-	if (!access("/sys/class/drm/card0/gt_cur_freq_mhz", R_OK))
-		gfx_info[GFX_MHz].path = "/sys/class/drm/card0/gt_cur_freq_mhz";
-	else if (!access("/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz", R_OK))
-		gfx_info[GFX_MHz].path = "/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz";
+	set_graphics_fp("/sys/class/drm/card0/gt_cur_freq_mhz", GFX_MHz);
+	if (!gfx_info[GFX_MHz].fp)
+		set_graphics_fp("/sys/class/graphics/fb0/device/drm/card0/gt_cur_freq_mhz", GFX_MHz);
 
-	if (!access("/sys/class/drm/card0/gt_act_freq_mhz", R_OK))
-		gfx_info[GFX_ACTMHz].path = "/sys/class/drm/card0/gt_act_freq_mhz";
-	else if (!access("/sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz", R_OK))
-		gfx_info[GFX_ACTMHz].path = "/sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz";
+	set_graphics_fp("/sys/class/drm/card0/gt_act_freq_mhz", GFX_ACTMHz);
+	if (!gfx_info[GFX_ACTMHz].fp)
+		set_graphics_fp("/sys/class/graphics/fb0/device/drm/card0/gt_act_freq_mhz", GFX_ACTMHz);
 
 end:
-	if (gfx_info[GFX_rc6].path)
+	if (gfx_info[GFX_rc6].fp)
 		BIC_PRESENT(BIC_GFX_rc6);
-	if (gfx_info[GFX_MHz].path)
+	if (gfx_info[GFX_MHz].fp)
 		BIC_PRESENT(BIC_GFXMHz);
-	if (gfx_info[GFX_ACTMHz].path)
+	if (gfx_info[GFX_ACTMHz].fp)
 		BIC_PRESENT(BIC_GFXACTMHz);
-	if (gfx_info[SAM_mc6].path)
+	if (gfx_info[SAM_mc6].fp)
 		BIC_PRESENT(BIC_SAM_mc6);
-	if (gfx_info[SAM_MHz].path)
+	if (gfx_info[SAM_MHz].fp)
 		BIC_PRESENT(BIC_SAMMHz);
-	if (gfx_info[SAM_ACTMHz].path)
+	if (gfx_info[SAM_ACTMHz].fp)
 		BIC_PRESENT(BIC_SAMACTMHz);
 }
 
-- 
2.43.0


