Return-Path: <linux-pm+bounces-2158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D510182BFF7
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 13:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 772C6B228F6
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jan 2024 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D96759B5F;
	Fri, 12 Jan 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Unjk2JTN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F5259B54
	for <linux-pm@vger.kernel.org>; Fri, 12 Jan 2024 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705063753; x=1736599753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7pESR+73w4BUKt7vIp4BWTGMpwvGOAhTKlANzwXnpWc=;
  b=Unjk2JTNzZphPSitJHIKTGSvE+UshnayMyXPTxIqtf6rBC1TsTm5GPDg
   AoQN6AWKuP9UxcKMEjB+Biz9J1wkz9AeGbuNNClNO0sRcNGTVaxXSINPZ
   dPNOxCs9GeFTFDsC1E0kwUollrJQu861PGJTmcSzOC1kEAfiKJfk/KrU6
   sn4Fr20tIySHJMp1sISTmya0aNPTxVZR8uEzW20z4KMisLeNAsUNaIMEJ
   eHfmZGOy1BeGZ/ST2G5WJh8pFqVTWymw/duxZ11CJuVuV530jneL5BjpE
   irOfoKK/LbT8kTEIb/tlRfxBHmMNKVKwvp3m3eUapV1U5z1J1KPM9TpDD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="6525654"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="6525654"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 04:49:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="17390863"
Received: from pwlazlyn-mobl.ger.corp.intel.com (HELO pwlazlyn) ([10.246.16.73])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 04:49:11 -0800
From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
To: len.brown@intel.com
Cc: linux-pm@vger.kernel.org
Subject: [PATCH 2/4] tools/power turbostat: Add --no-perf option
Date: Fri, 12 Jan 2024 13:48:13 +0100
Message-Id: <20240112124815.970-3-patryk.wlazlyn@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112124815.970-1-patryk.wlazlyn@linux.intel.com>
References: <20240112124815.970-1-patryk.wlazlyn@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the --no-perf option to allow users to run turbostat without
accessing perf.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |  2 ++
 tools/power/x86/turbostat/turbostat.c | 26 +++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index 5575c947134d..8d3d9cac27e0 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -69,6 +69,8 @@ The column name "all" can be used to enable all disabled-by-default built-in cou
 .PP
 +\fB--no-msr\fP Disable all the uses of the MSR driver.
 +.PP
++\fB--no-perf\fP Disable all the uses of the perf API.
++.PP
 \fB--interval seconds\fP overrides the default 5.0 second measurement interval.
 .PP
 \fB--num_iterations num\fP number of the measurement iterations.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f192d75d5977..ba10a10c5144 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -265,6 +265,7 @@ unsigned int has_hwp_pkg;	/* IA32_HWP_REQUEST_PKG */
 unsigned int first_counter_read = 1;
 int ignore_stdin;
 bool no_msr;
+bool no_perf;
 
 int get_msr(int cpu, off_t offset, unsigned long long *msr);
 
@@ -1321,8 +1322,17 @@ static void bic_disable_msr_access(void)
 	bic_enabled &= ~bic_msrs;
 }
 
+static void bic_disable_perf_access(void)
+{
+	const unsigned long bic_perf = BIC_IPC;
+
+	bic_enabled &= ~bic_perf;
+}
+
 static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu, int group_fd, unsigned long flags)
 {
+	assert(!no_perf);
+
 	return syscall(__NR_perf_event_open, hw_event, pid, cpu, group_fd, flags);
 }
 
@@ -1339,8 +1349,9 @@ static int perf_instr_count_open(int cpu_num)
 	/* counter for cpu_num, including user + kernel and all processes */
 	fd = perf_event_open(&pea, -1, cpu_num, -1, 0);
 	if (fd == -1) {
-		warnx("capget(CAP_PERFMON) failed, try \"# setcap cap_sys_admin=ep %s\"", progname);
-		BIC_NOT_PRESENT(BIC_IPC);
+		warnx("capget(CAP_PERFMON) failed, try \"# setcap cap_sys_admin=ep %s\""
+		      " or use --no-perf", progname);
+		bic_disable_perf_access();
 	}
 
 	return fd;
@@ -1406,6 +1417,7 @@ void help(void)
 		"  -J, --Joules	displays energy in Joules instead of Watts\n"
 		"  -l, --list	list column headers only\n"
 		"  -M, --no-msr Disable all uses of the MSR driver\n"
+		"  -P, --no-perf Disable all uses of the perf API\n"
 		"  -n, --num_iterations num\n"
 		"		number of the measurement iterations\n"
 		"  -N, --header_iterations num\n"
@@ -6676,6 +6688,7 @@ void cmdline(int argc, char **argv)
 		{ "out", required_argument, 0, 'o' },
 		{ "quiet", no_argument, 0, 'q' },
 		{ "no-msr", no_argument, 0, 'M' },
+		{ "no-perf", no_argument, 0, 'P' },
 		{ "show", required_argument, 0, 's' },
 		{ "Summary", no_argument, 0, 'S' },
 		{ "TCC", required_argument, 0, 'T' },
@@ -6689,11 +6702,14 @@ void cmdline(int argc, char **argv)
 	 * Parse some options early, because they may make other options invalid,
 	 * like adding the MSR counter with --add and at the same time using --no-msr.
 	 */
-	while ((opt = getopt_long_only(argc, argv, "M", long_options, &option_index)) != -1) {
+	while ((opt = getopt_long_only(argc, argv, "MP", long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'M':
 			no_msr = 1;
 			break;
+		case 'P':
+			no_perf = 1;
+			break;
 		default:
 			break;
 		}
@@ -6759,6 +6775,7 @@ void cmdline(int argc, char **argv)
 			quiet = 1;
 			break;
 		case 'M':
+		case 'P':
 			/* Parsed earlier */
 			break;
 		case 'n':
@@ -6824,6 +6841,9 @@ int main(int argc, char **argv)
 	if (no_msr)
 		bic_disable_msr_access();
 
+	if (no_perf)
+		bic_disable_perf_access();
+
 	if (!quiet) {
 		print_version();
 		print_bootcmd();
-- 
2.43.0


