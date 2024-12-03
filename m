Return-Path: <linux-pm+bounces-18414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3AC9E14A3
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D9A6B23EF0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E91CCEE0;
	Tue,  3 Dec 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFQYhFB9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11171B0F14;
	Tue,  3 Dec 2024 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212284; cv=none; b=nHrjDsAkTIOIWjg+LQfhwu1+L4Cjcj3alcVGEkiZtUDGr367rQiWDt8JTs/PgHoihIh02HUDfEWQCZISyxC4QGDyRXqIdBR8CVP6nUGUmDmPJZUI8C4H6w4KNGfDz0nS3OroTc6+ryNmzl7pOWkV1zOZOaY+G+/31Mn911XR1/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212284; c=relaxed/simple;
	bh=v3qwmxpDKqg3xwk9gjV3fcUAEJOvWXxp7rHJ7S8iLmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnIvFF+d9IJUpMfoYoy2kMzCFgEpsMUZkcGT8JWcEKjyHapxxQjE+NoSkIhHwu5Rhf79p3ZEByzF6c0NhUyyGN3yrQrfJh4qIiVP5mIODMJSq2KcHlhpuXjqNIncJ9Q0VbqgD1+Fc54vdqW6eF/cz4r8csKXGLvtrFzGtT2Zjtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFQYhFB9; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733212283; x=1764748283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v3qwmxpDKqg3xwk9gjV3fcUAEJOvWXxp7rHJ7S8iLmc=;
  b=iFQYhFB92vW0YJDFesXP3Sv44Z5I1obBBgstFi4qP0RlNN4Z36UKCsec
   yb7jEg1/4uUE2vFfrrXJegcOC5kTtLKc6+ejpGVY9fhu7ZHSv3J/Fvps3
   2wRSJ4Xg8Uf28b9WWHSCTKPTSNe4jrDSUr5nmXCRSc+wd9Z8QjJB8GWfB
   2XiwRX1KbjDsxa2ptlG0Y9DvzwfGD1XUarGGYBL31WKT/zfF6aA+35Nyv
   ndlcp5Mk5MjyEXDbDxYmuaUfXJF8fz5fke8g7N0LSw2Ded/elXDwU2+F4
   FiCHTZhXa5fnxXnXvtTUS+m7uSWIb6d/7SKokX+Cl5Oy5SFV3J/kguGnV
   A==;
X-CSE-ConnectionGUID: mrZuU0CtSUqD/uaphFDZpA==
X-CSE-MsgGUID: UEhlQh+KQtqH4LdNIGWE6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="50822853"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="50822853"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 23:51:22 -0800
X-CSE-ConnectionGUID: jdO5AyTcTNe2dPY4K8miag==
X-CSE-MsgGUID: jWphu4LmRBeMB15khgxaPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="124183034"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by orviesa002.jf.intel.com with ESMTP; 02 Dec 2024 23:51:21 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 3/4] tools/power turbostat: Improve --help output
Date: Tue,  3 Dec 2024 15:51:18 +0800
Message-ID: <20241203075119.584419-4-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203075119.584419-1-rui.zhang@intel.com>
References: <20241203075119.584419-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the `--help` output of turbostat by standardizing the format
and enhancing readability. The following changes are made to ensure
consistency and clarity in the help message:
1. Use a consistent pattern for each parameter's help message:
   - Display the parameter and its input (if any) on the same line,
     separated by a space.
   - Provide the detailed description on a separate line.
2. Ensure that the first character of each description is in lower-case.

These changes make the help output more uniform and easier to read,
helping users quickly understand the available options and their usage.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 41 +++++++++++++++++----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 508d65e60981..442a993c5114 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2148,41 +2148,52 @@ void help(void)
 		"when COMMAND completes.\n"
 		"If no COMMAND is specified, turbostat wakes every 5-seconds\n"
 		"to print statistics, until interrupted.\n"
-		"  -a, --add	add a counter\n"
+		"  -a, --add counter\n"
+		"		add a counter\n"
 		"		  eg. --add msr0x10,u64,cpu,delta,MY_TSC\n"
 		"		  eg. --add perf/cstate_pkg/c2-residency,package,delta,percent,perfPC2\n"
 		"		  eg. --add pmt,name=XTAL,type=raw,domain=package0,offset=0,lsb=0,msb=63,guid=0x1a067102\n"
-		"  -c, --cpu	cpu-set	limit output to summary plus cpu-set:\n"
+		"  -c, --cpu cpu-set\n"
+		"		limit output to summary plus cpu-set:\n"
 		"		  {core | package | j,k,l..m,n-p }\n"
-		"  -d, --debug	displays usec, Time_Of_Day_Seconds and more debugging\n"
+		"  -d, --debug\n"
+		"		displays usec, Time_Of_Day_Seconds and more debugging\n"
 		"		debug messages are printed to stderr\n"
-		"  -D, --Dump	displays the raw counter values\n"
-		"  -e, --enable	[all | column]\n"
+		"  -D, --Dump\n"
+		"		displays the raw counter values\n"
+		"  -e, --enable [all | column]\n"
 		"		shows all or the specified disabled column\n"
-		"  -H, --hide [column|column,column,...]\n"
+		"  -H, --hide [column | column,column,...]\n"
 		"		hide the specified column(s)\n"
 		"  -i, --interval sec.subsec\n"
-		"		Override default 5-second measurement interval\n"
-		"  -J, --Joules	displays energy in Joules instead of Watts\n"
-		"  -l, --list	list column headers only\n"
-		"  -M, --no-msr Disable all uses of the MSR driver\n"
-		"  -P, --no-perf Disable all uses of the perf API\n"
+		"		override default 5-second measurement interval\n"
+		"  -J, --Joules\n"
+		"		displays energy in Joules instead of Watts\n"
+		"  -l, --list\n"
+		"		list column headers only\n"
+		"  -M, --no-msr\n"
+		"		disable all uses of the MSR driver\n"
+		"  -P, --no-perf\n"
+		"		disable all uses of the perf API\n"
 		"  -n, --num_iterations num\n"
 		"		number of the measurement iterations\n"
 		"  -N, --header_iterations num\n"
 		"		print header every num iterations\n"
 		"  -o, --out file\n"
 		"		create or truncate \"file\" for all output\n"
-		"  -q, --quiet	skip decoding system configuration header\n"
-		"  -s, --show [column|column,column,...]\n"
+		"  -q, --quiet\n"
+		"		skip decoding system configuration header\n"
+		"  -s, --show [column | column,column,...]\n"
 		"		show only the specified column(s)\n"
 		"  -S, --Summary\n"
 		"		limits output to 1-line system summary per interval\n"
 		"  -T, --TCC temperature\n"
 		"		sets the Thermal Control Circuit temperature in\n"
 		"		  degrees Celsius\n"
-		"  -h, --help	print this help message\n"
-		"  -v, --version	print version information\n" "\n" "For more help, run \"man turbostat\"\n");
+		"  -h, --help\n"
+		"		print this help message\n"
+		"  -v, --version\n"
+		"		print version information\n" "\n" "For more help, run \"man turbostat\"\n");
 }
 
 /*
-- 
2.43.0


