Return-Path: <linux-pm+bounces-27496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087B7AC07B4
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 10:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91469E02CA
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 08:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B396822333D;
	Thu, 22 May 2025 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HjBGmmV6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA34281531
	for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903821; cv=none; b=qFr6dlGJ7i3LeOU8zbiVVosQdzY3VkbRkDVhy8AjvAh6E/16cdgPytA53SPsX+2dnCWP5BELO7/HRBI1ZhcrGRA+wbT18vg00A+41LSk8N1X85QktrFGrc50VNed6VVM7LWJ2/ixfkxIBIm0KrQonXW2v19deAupQU132Jx4rEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903821; c=relaxed/simple;
	bh=r5kx38584z6JHejNCCLW9KYD95MVMHsMWAjh0+ftzK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SAzpcg2yMz2+qm6XZ0cT7Bal34IUFb/cag9dRIaikzBt4Xd/HXCIa7jMV8Tet++zWzgsn7tyGgWCPF6rUjEllzpjJyPd3z0qNNCTrgWJU3tFjPKL9d8F9EcKSaGivD28wFi/xrFm9laKW7HbEP2cXSz/yj88Y/hU/CntIAS58ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HjBGmmV6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747903820; x=1779439820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r5kx38584z6JHejNCCLW9KYD95MVMHsMWAjh0+ftzK4=;
  b=HjBGmmV6noQVEkNkMpuUXZzE066m76CpWVHVQttCSlZFmVCjgXnDx6IG
   AeeD7jT/8EDJuzySTTYeMiVYtRKvWGtUwkCtVL8Uu4iG9q80Wdyz3rGV5
   1nZx9IgrA/UKtdgHqyRaemQwb3udxhub7Mipl117Yf1GSIBnCD0Fanc6G
   r6j/QyOI5kLvnzzg/C/7CW3uKtW0uhDUyHCamBze6bx6fYInqBnoI/NKB
   fAh3pLyPSgo/necq9PqeqQfFzSkgjjiO7SaDXWQeNlGOmz/vmXQPB9VOp
   fsw4RuuXmc0+MGs/ZQcmfT83JiqjtviqS7tVnvEj5qjOHdKVZqJxLyhmn
   Q==;
X-CSE-ConnectionGUID: dNuWxOzTRGqW9zSRvi1sUw==
X-CSE-MsgGUID: 58cnUMW1TdKE6+SxDhLKOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="50072740"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="50072740"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 01:50:19 -0700
X-CSE-ConnectionGUID: rpwMH+ZyT4+0cy13CqHwYA==
X-CSE-MsgGUID: VDNvfjiFSRObUlfmJj+zuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="140906980"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa008.fm.intel.com with ESMTP; 22 May 2025 01:50:18 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/power turbostat: Add Android support for MSR device handling
Date: Thu, 22 May 2025 14:19:46 +0530
Message-Id: <20250522084946.1923459-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It uses /dev/msrN device paths on Android instead of /dev/cpu/N/msr,
updates error messages and permission checks to reflect the Android
device path, and wraps platform-specific code with #if defined(ANDROID)
to ensure correct behavior on both Android and non-Android systems.
These changes improve compatibility and usability of turbostat on
Android devices.
Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 089220aaa5c9..1f34781bc264 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1963,13 +1963,20 @@ int get_msr_fd(int cpu)
 
 	if (fd)
 		return fd;
-
+#if defined(ANDROID)
+	sprintf(pathname, "/dev/msr%d", cpu);
+#else
 	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
+#endif
 	fd = open(pathname, O_RDONLY);
 	if (fd < 0)
+#if defined(ANDROID)
+		err(-1, "%s open failed, try chown or chmod +r /dev/msr*, "
+		    "or run with --no-msr, or run as root", pathname);
+#else
 		err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, "
 		    "or run with --no-msr, or run as root", pathname);
-
+#endif
 	fd_percpu[cpu] = fd;
 
 	return fd;
@@ -6156,8 +6163,11 @@ void check_dev_msr()
 
 	if (no_msr)
 		return;
-
+#if defined(ANDROID)
+	sprintf(pathname, "/dev/msr%d", base_cpu);
+#else
 	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
+#endif
 	if (stat(pathname, &sb))
 		if (system("/sbin/modprobe msr > /dev/null 2>&1"))
 			no_msr = 1;
@@ -6207,7 +6217,11 @@ void check_msr_permission(void)
 	failed += check_for_cap_sys_rawio();
 
 	/* test file permissions */
+#if defined(ANDROID)
+	sprintf(pathname, "/dev/msr%d", base_cpu);
+#else
 	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
+#endif
 	if (euidaccess(pathname, R_OK)) {
 		failed++;
 	}
-- 
2.34.1


