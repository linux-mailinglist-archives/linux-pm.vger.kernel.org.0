Return-Path: <linux-pm+bounces-17544-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2849C8485
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79EE428521D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15811F6695;
	Thu, 14 Nov 2024 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfhImkHv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251431F7077
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571414; cv=none; b=B/6iX0hs21fcjkVQt75bOWLvff5pW2TzEIvVVk2K9AQs4fgfnXGXK8XLNArj8py14tU8hPrddH+IXjpXzLimQ6Z5QvTxV0erT5PUE9bKm4LbSI4Lxw5ulcIIWAPtMCP4iKNXcxGVjVJ5sUbbu5gRShb4fSJn2ALqr7PnhyLcpS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571414; c=relaxed/simple;
	bh=RvzuHv9H5LZC77DRGmwAzhDp31sHdWHn1NJLjqs7cU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hz9zsbKBrdGHKmz1bopco1B9/AW4r2yDyxbX501XOLdUFWsKQfQFvO3XBF60sNHvgwWzyvfuQh3eHf72ARUSE4byfGsUs/0OZYTChavioisQlmk15WGLIJYdnh63rjN52USjV4EeYL3jZhiMxvIt/rCgPzk8FRDCj6kTe4kWfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfhImkHv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571413; x=1763107413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RvzuHv9H5LZC77DRGmwAzhDp31sHdWHn1NJLjqs7cU4=;
  b=kfhImkHvI60gLtADOPmm4+4UNC5pxy2ZJQ2Ox3fST3g+tsxkJCWJN7C8
   HWyD9Fr3S1cahEh88uwvbTbW/gnEu55ARWzubUtv3B1ae2gbcN/IY5t/U
   aq434fQpO2VBchKiIcVn8BM65YEndI6l6J1wCJPlgIBlIIMfMsBsktqCr
   AQtPKFGne4/xk6wh+yKLuPqbiIvw2TLbCIkBj6pfqBP9cMMAmBTFmAGCF
   +U9rUmBznKeCL+983FiqF3Tyl0YlyJ0YZCIiHrFvF1iDUSqXC4SK4cJLX
   PGR9KAbvYbd2+20NJth9iMZiix0JvvhuyKK7dwQTZr6KAyovV52q3Z3EF
   A==;
X-CSE-ConnectionGUID: 4n8PddRpQmiDKI5S0O9QHA==
X-CSE-MsgGUID: C/3A8OIJQmiI4QqO8GaRow==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31600457"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="31600457"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:03:27 -0800
X-CSE-ConnectionGUID: VPiQPKHUQV28fci/ZyD8nQ==
X-CSE-MsgGUID: nm0rYe0sTSGbxjcxuaJRIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="125627505"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 00:03:26 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 10/10] tools/power turbostat: Add support for /sys/class/drm/card1
Date: Thu, 14 Nov 2024 15:59:46 +0800
Message-ID: <20241114075946.118577-11-rui.zhang@intel.com>
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

On some machines, the graphics device is enumerated as
/sys/class/drm/card1 instead of /sys/class/drm/card0. The current
implementation does not handle this scenario, resulting in the loss of
graphics C6 residency and frequency information.

Add support for /sys/class/drm/card1, ensuring that turbostat can
retrieve and display the graphics columns for these platforms.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 38 ++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 52b6ffc41bdf..43ca50107e1a 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -6443,8 +6443,14 @@ static void set_graphics_fp(char *path, int idx)
 		gfx_info[idx].fp = fopen_or_die(path, "r");
 }
 
+/* Enlarge this if there are /sys/class/drm/card2 ... */
+#define GFX_MAX_CARDS	2
+
 static void probe_graphics(void)
 {
+	char path[PATH_MAX];
+	int i;
+
 	/* Xe graphics sysfs knobs */
 	if (!access("/sys/class/drm/card0/device/tile0/gt0/gtidle/idle_residency_ms", R_OK)) {
 		FILE *fp;
@@ -6485,22 +6491,36 @@ static void probe_graphics(void)
 
 next:
 	/* New i915 graphics sysfs knobs */
-	if (!access("/sys/class/drm/card0/gt/gt0/rc6_residency_ms", R_OK)) {
-		set_graphics_fp("/sys/class/drm/card0/gt/gt0/rc6_residency_ms", GFX_rc6);
+	for (i = 0; i < GFX_MAX_CARDS; i++) {
+		snprintf(path, PATH_MAX, "/sys/class/drm/card%d/gt/gt0/rc6_residency_ms", i);
+		if (!access(path, R_OK))
+			break;
+	}
 
-		set_graphics_fp("/sys/class/drm/card0/gt/gt0/rps_cur_freq_mhz", GFX_MHz);
+	if (i == GFX_MAX_CARDS)
+		goto legacy_i915;
 
-		set_graphics_fp("/sys/class/drm/card0/gt/gt0/rps_act_freq_mhz", GFX_ACTMHz);
+	snprintf(path, PATH_MAX, "/sys/class/drm/card%d/gt/gt0/rc6_residency_ms", i);
+	set_graphics_fp(path, GFX_rc6);
 
-		set_graphics_fp("/sys/class/drm/card0/gt/gt1/rc6_residency_ms", SAM_mc6);
+	snprintf(path, PATH_MAX, "/sys/class/drm/card%d/gt/gt0/rps_cur_freq_mhz", i);
+	set_graphics_fp(path, GFX_MHz);
 
-		set_graphics_fp("/sys/class/drm/card0/gt/gt1/rps_cur_freq_mhz", SAM_MHz);
+	snprintf(path, PATH_MAX, "/sys/class/drm/card%d/gt/gt0/rps_act_freq_mhz", i);
+	set_graphics_fp(path, GFX_ACTMHz);
 
-		set_graphics_fp("/sys/class/drm/card0/gt/gt1/rps_act_freq_mhz", SAM_ACTMHz);
+	snprintf(path, PATH_MAX, "/sys/class/drm/card%d/gt/gt1/rc6_residency_ms", i);
+	set_graphics_fp(path, SAM_mc6);
 
-		goto end;
-	}
+	snprintf(path, PATH_MAX, "/sys/class/drm/card%d/gt/gt1/rps_cur_freq_mhz", i);
+	set_graphics_fp(path, SAM_MHz);
+
+	snprintf(path, PATH_MAX, "/sys/class/drm/card%d/gt/gt1/rps_act_freq_mhz", i);
+	set_graphics_fp(path, SAM_ACTMHz);
+
+	goto end;
 
+legacy_i915:
 	/* Fall back to traditional i915 graphics sysfs knobs */
 	set_graphics_fp("/sys/class/drm/card0/power/rc6_residency_ms", GFX_rc6);
 
-- 
2.43.0


