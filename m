Return-Path: <linux-pm+bounces-28901-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 808A1ADCBE2
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 14:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07EB18980CB
	for <lists+linux-pm@lfdr.de>; Tue, 17 Jun 2025 12:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761042DF3E4;
	Tue, 17 Jun 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FL70Voxa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AF2E06CF;
	Tue, 17 Jun 2025 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750164557; cv=none; b=HsCQnPm0shSrixCkuVB2gYKQoR1qxMsxPe/QRcBZg8dZy4R/k4bgnyN/w8lI2gJ4TIrhYpE3VIUm+sXWPFE7Kp8ES7Z8e3330vkbI+45SFz/PYxpVQdAyN2q2/54rl9zQXa5zzhgYrN8Yf9GAsDN+TE6sYPoB3Y+k5hgByrMZsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750164557; c=relaxed/simple;
	bh=U98R0X6/8fnK9rCzgloNwlJHN8hx6yL/+Cb0wkk0l20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUN+/Gr+e2AgvDGHs7T2Q2TSuJJDlrDK2/mpIOXV47+dQDfmq1PW8jj5PJKIkdnJeB6VftWRPDIiSUnZUhUMKGpwMGTyO+Y39SVgAuxTrLBZ70NWE8KKGqVhQ/rm6BYXuL2gWDISSzenyY4jYRNy/kOZx4YaILufamHQ/t5xCUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FL70Voxa; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750164555; x=1781700555;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U98R0X6/8fnK9rCzgloNwlJHN8hx6yL/+Cb0wkk0l20=;
  b=FL70Voxa/AyjhcIohx79RAgggRl1J46iNAp/95s9zYq+RL9aFo9ALBOg
   y0CiDqTWhtbnxJ39BxBm5WLVL6mPYu6ydmEamElSe3NLlt5ygPztYf6OP
   RYe9Z18KMAkDt7LgF8yPSXVykIKMLf/zJgvJTjckYhxMByyMCZ5i3yRf5
   cYuEYaaZEDyAkxuCKBNvPU1V2EiaJQNg24hfTWfprgN/CYxRXaUrekT6t
   y7sstZvA+W83ZSIKXcEqTiROhqu65289cEWh5hhUr3lrgcyIioP33B1UN
   xqmYumwvxfoqO7cHANXtYfoZcrustpS5mnfuiIIl6ynytpsXxSg9oHai0
   Q==;
X-CSE-ConnectionGUID: fIqSIYSqQqizraJ63ppehA==
X-CSE-MsgGUID: Qtx4LbBXS+q6GPNwSTuzvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52254986"
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="52254986"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 05:49:06 -0700
X-CSE-ConnectionGUID: oWDfXEy6SmOiFsj81lim1g==
X-CSE-MsgGUID: HKltE5ioQEaY/VjTQyX9IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,243,1744095600"; 
   d="scan'208";a="153661271"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO rzhang1-mobl7.intel.com) ([10.247.119.11])
  by fmviesa005.fm.intel.com with ESMTP; 17 Jun 2025 05:49:03 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 1/2] tools/power turbostat: Fix bogus SysWatt for forked program
Date: Tue, 17 Jun 2025 20:48:59 +0800
Message-ID: <20250617124900.186591-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to delta_cpu(), delta_platform() is called in turbostat main
loop. This ensures accurate SysWatt readings in periodic monitoring mode
$ sudo turbostat -S -q --show power -i 1
CoreTmp	PkgTmp	PkgWatt	CorWatt	GFXWatt	RAMWatt	PKG_%	RAM_%	SysWatt
60	61	6.21	1.13	0.16	0.00	0.00	0.00	13.07
58	61	6.00	1.07	0.18	0.00	0.00	0.00	12.75
58	61	5.74	1.05	0.17	0.00	0.00	0.00	12.22
58	60	6.27	1.11	0.24	0.00	0.00	0.00	13.55

However, delta_platform() is missing for forked program and causes bogus
SysWatt reporting,
$ sudo turbostat -S -q --show power sleep 1
1.004736 sec
CoreTmp	PkgTmp	PkgWatt	CorWatt	GFXWatt	RAMWatt	PKG_%	RAM_%	SysWatt
57	58	6.05	1.02	0.16	0.00	0.00	0.00	0.03

Add missing delta_platform() for forked program.

Fixes: e5f687b89bc2 ("tools/power turbostat: Add RAPL psys as a built-in counter")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5230e072e414..5f8ab899b552 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -9817,6 +9817,7 @@ int fork_it(char **argv)
 	timersub(&tv_odd, &tv_even, &tv_delta);
 	if (for_all_cpus_2(delta_cpu, ODD_COUNTERS, EVEN_COUNTERS))
 		fprintf(outf, "%s: Counter reset detected\n", progname);
+	delta_platform(&platform_counters_odd, &platform_counters_even);
 
 	compute_average(EVEN_COUNTERS);
 	format_all_counters(EVEN_COUNTERS);
-- 
2.43.0


