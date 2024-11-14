Return-Path: <linux-pm+bounces-17543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC829C8483
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 09:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9AE0285255
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 08:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592461F707C;
	Thu, 14 Nov 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSb66DEY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13DB1F6695
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571413; cv=none; b=XyDNaahzsiO86/a8qo24eNW09+LhdX0UDim41JRCM94AQUOrbiPZCmWK+BJuwKFePZv4MKA+QZsAMH2dqLWvhPDjvL82Vv9PTS0hven+3doP863Sh/w8Xoavoz329JYF4UMt0NZYrZqbrlsr0c6k/xvvUgAqV7awv+XSSBsjjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571413; c=relaxed/simple;
	bh=Ar9yrjBs5DsPBzg9E7xXiaurQFtJrWm3n27TGirj4hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhCDsNpzXM0uu3k+axva/AVs3Vk/yM6uIY1nOmRE4xcuVjL9LmS+pCpvg7UUgcZ7yLFt075yi8JK6AJI0QWPy0zhWOeQxHOqvdFgMpvHmkUMvMAFDE8BVIiZ7q7XAxQrlL/8KgoGNJsxqVDhuKsz++q23oV477IUcUbSFeUA850=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSb66DEY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571412; x=1763107412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ar9yrjBs5DsPBzg9E7xXiaurQFtJrWm3n27TGirj4hE=;
  b=FSb66DEY/K9UsBO+tkmtHuUAQDpTR8SCAY/3K7bfBW+lViFo52chp04N
   S+yOJ16GMZXkTjjsue3CUlCK+yZzmxS75zRhkVrg/dEXjIYEGk76/nEjv
   86hjcKWy+WhqCxdKt+ulCoQQJin1hPvmBRmARk3yZfQC61zYuopinNF9P
   PVyrhxi3GIiqyFLz/FU+ylm/nMYKUsnOMaGlCU0ZV+WtJXzJzfIhgyXaQ
   RH8GhNgzBvWkXbuZr7ecrIJF/XasrnuWiVfIZzsFIn1VNezyVbLTAe7i0
   P3sWRDNeXDh2ItNwvotoqSeHJos/QQz3O/cerbhbh4IdBRQ8SVjMGHTo3
   A==;
X-CSE-ConnectionGUID: fJ2wdJCnSbitrmskHIb97A==
X-CSE-MsgGUID: MpFjcdGvRy6yw/DPx8SPkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="31600445"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="31600445"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:03:24 -0800
X-CSE-ConnectionGUID: NPwW+JVCR3q4peylXOspFg==
X-CSE-MsgGUID: NBeSBwSDRVCv0mdbhvP4OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="125627494"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa001.jf.intel.com with ESMTP; 14 Nov 2024 00:03:23 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 08/10] tools/power turbostat: Consolidate graphics sysfs access
Date: Thu, 14 Nov 2024 15:59:44 +0800
Message-ID: <20241114075946.118577-9-rui.zhang@intel.com>
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

Currently, there is an inconsistency in how graphics sysfs knobs are
accessed: graphics residency sysfs knobs are opened and closed for each
read, while graphics frequency sysfs knobs are opened once and remain
open until turbostat exits. This inconsistency is confusing and adds
unnecessary code complexity.

Consolidate the access method by opening the sysfs files once and
reusing the file pointers for subsequent accesses. This approach
simplifies the code and ensures a consistent method for accessing
graphics sysfs knobs.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 4956f4b837d1..aa0dab13d346 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5731,27 +5731,24 @@ int snapshot_proc_interrupts(void)
  */
 int snapshot_graphics(int idx)
 {
-	FILE *fp;
 	int retval;
 
+	if (gfx_info[idx].fp == NULL)
+		gfx_info[idx].fp = fopen_or_die(gfx_info[idx].path, "r");
+	else
+		rewind(gfx_info[idx].fp);
+
 	switch (idx) {
 	case GFX_rc6:
 	case SAM_mc6:
-		fp = fopen_or_die(gfx_info[idx].path, "r");
-		retval = fscanf(fp, "%lld", &gfx_info[idx].val_ull);
+		retval = fscanf(gfx_info[idx].fp, "%lld", &gfx_info[idx].val_ull);
 		if (retval != 1)
 			err(1, "rc6");
-		fclose(fp);
 		return 0;
 	case GFX_MHz:
 	case GFX_ACTMHz:
 	case SAM_MHz:
 	case SAM_ACTMHz:
-		if (gfx_info[idx].fp == NULL)
-			gfx_info[idx].fp = fopen_or_die(gfx_info[idx].path, "r");
-		else
-			rewind(gfx_info[idx].fp);
-
 		retval = fscanf(gfx_info[idx].fp, "%d", &gfx_info[idx].val);
 		if (retval != 1)
 			err(1, "MHz");
-- 
2.43.0


