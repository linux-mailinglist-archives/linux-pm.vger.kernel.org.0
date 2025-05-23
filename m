Return-Path: <linux-pm+bounces-27545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 991E0AC1CA0
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 07:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FCA1BA1686
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 05:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0027221D83;
	Fri, 23 May 2025 05:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDRsOtY+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1B9158535
	for <linux-pm@vger.kernel.org>; Fri, 23 May 2025 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747979350; cv=none; b=DKgtJrJIqlINqU2SF9oXGWKTrA+mTHZ5+WiD/uqdGZsqjGUbjyAcplyTTTq+t+1eWTzo7Z0L3ZWyAzB5ypQ0s5tU+9+avPD4SK0Vj/pww4lM6qLY8hUYc5vU1ura+nVAu+UCKmnRkZP90RyExPDiNWq9ayqve4pw7gfTsQKRJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747979350; c=relaxed/simple;
	bh=OUflqYaLiHmpF8ejkL19iK4yd6eBFrL8ivkCY992qiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J4XpsCVgpGwefMSPUNrVrHbxIjT2Gn+T2kQDmMximIaK5NLSheo5PLAvuYtXv3VPhqLRn5ncfiVcqZ8rcMreNxuQ8TRwSaq/0/e7hfEERchM7rJrimuMDpUcHk+l7vdomsVc6sKqGN/LTgdvip17X//oyluJ9YuCKn+nqg+gkpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDRsOtY+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747979350; x=1779515350;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OUflqYaLiHmpF8ejkL19iK4yd6eBFrL8ivkCY992qiA=;
  b=WDRsOtY+Xm3Wu/RcNZBcyDZz8eZ8xyL47xZNeELBzz0UcND+CzVnnBSw
   Bc+opgH7QLm3CqPBjPJeZ5YqgSzQCgjIXuuNNuuuXeIF6HkUQ4gsvlhF5
   K+P45S0KaaJYdJMEynHtJcjp4LqKfjS3+xhTD+gR6/BbeWd0ApF/SCba8
   l+/C5hOB32h6E6Y4LseCMCfN7DJIERQXBTAWNK9PSlhSuUS66EJ8vv9N4
   6gYCitXaaPu+IazE6r+NxLGotOXDG3cfHMylYoaLUxtU/77MJqeOmg6kd
   4yTKwFYCcRbGIqhcfEgTjE7xO4LFr5YYTpZlhBz6+gZhFNdTW1Y12CM7y
   Q==;
X-CSE-ConnectionGUID: BrGxZJaKR76jsA9NMPKImg==
X-CSE-MsgGUID: QNJaUbC+ThmB60Psfun7eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49730972"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="49730972"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 22:49:09 -0700
X-CSE-ConnectionGUID: 4VfUo8KxRTSl06VL+Nb8tw==
X-CSE-MsgGUID: o/rzqmUASGmUZ6fZseoh/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="142017537"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa009.fm.intel.com with ESMTP; 22 May 2025 22:49:07 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: lenb@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] tools/power x86_energy_perf_policy: Add Android support for MSR device path
Date: Fri, 23 May 2025 11:18:35 +0530
Message-Id: <20250523054835.3360630-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for Android by updating the MSR device path
handling in x86_energy_perf_policy. The code now uses /dev/msrN on
Android systems instead of the default /dev/cpu/N/msr path. Error
messages and modprobe instructions are also updated accordingly to
improve clarity for Android users.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 .../x86_energy_perf_policy.c                  | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index ebda9c366b2b..0c42cecca6a3 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -682,11 +682,19 @@ int get_msr(int cpu, int offset, unsigned long long *msr)
 	int retval;
 	char pathname[32];
 	int fd;
-
+#if defined(ANDROID)
+	sprintf(pathname, "/dev/msr%d", cpu);
+#else
 	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
+#endif
 	fd = open(pathname, O_RDONLY);
 	if (fd < 0)
+#if defined(ANDROID)
+		err(-1, "%s open failed, try chown or chmod +r /dev/msr*, or run as root",
+		    pathname);
+#else
 		err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, or run as root", pathname);
+#endif
 
 	retval = pread(fd, msr, sizeof(*msr), offset);
 	if (retval != sizeof(*msr)) {
@@ -706,11 +714,19 @@ int put_msr(int cpu, int offset, unsigned long long new_msr)
 	char pathname[32];
 	int retval;
 	int fd;
-
+#if defined(ANDROID)
+	sprintf(pathname, "/dev/msr%d", cpu);
+#else
 	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
+#endif
 	fd = open(pathname, O_RDWR);
 	if (fd < 0)
+#if defined(ANDROID)
+		err(-1, "%s open failed, try chown or chmod +r /dev//msr*, or run as root",
+		    pathname);
+#else
 		err(-1, "%s open failed, try chown or chmod +r /dev/cpu/*/msr, or run as root", pathname);
+#endif
 
 	retval = pwrite(fd, &new_msr, sizeof(new_msr), offset);
 	if (retval != sizeof(new_msr))
@@ -1385,10 +1401,18 @@ void probe_dev_msr(void)
 	struct stat sb;
 	char pathname[32];
 
+#if defined(ANDROID)
+	sprintf(pathname, "/dev/msr%d", base_cpu);
+#else
 	sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
+#endif
 	if (stat(pathname, &sb))
 		if (system("/sbin/modprobe msr > /dev/null 2>&1"))
+#if defined(ANDROID)
+			err(-5, "no /dev/msr0, Try \"# modprobe msr\" ");
+#else
 			err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
+#endif
 }
 
 static void get_cpuid_or_exit(unsigned int leaf,
-- 
2.34.1


