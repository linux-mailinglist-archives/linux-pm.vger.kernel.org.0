Return-Path: <linux-pm+bounces-20073-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D474AA0531B
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 07:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7454D1882BA2
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2025 06:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416CD1A2C27;
	Wed,  8 Jan 2025 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwFtE5LS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48C1A23B7;
	Wed,  8 Jan 2025 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736317141; cv=none; b=sHD4YPWYAiGhQWoCeNBG+jOhS2kc3jpQ6U1mPykCgYFMeabAifXYJps3XAl06WHbjB2uLxPhSMvj8e4LQUNsBlCUSHV2kOHi6JvffyQsJeK+cMYAsP3uDxcIKEfq99dYvJ9/uxVfZDHg8tNuNtzHYGtomq0r8I0AImpoaIaAMqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736317141; c=relaxed/simple;
	bh=gGdAGUOk+HvvgSYDo47UFT2xU5uDDe4OpAYeqqgmhJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lCiwzg6bbDdVdzsiTUlr/gfjfIsj3sJQnJiwOeU2Hjs1vqr8XDeGCBuWDv4lt47/c/Mc3NttmZmAJMev+8zAYbxs6G9D7uNTYDx0JHiQNGxs+vpK3Ii8ad9lmSqMLOhoMq131KINxvDys9uGhWQt/P+27JGbIiNXZFJFTVUAiBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwFtE5LS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736317139; x=1767853139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gGdAGUOk+HvvgSYDo47UFT2xU5uDDe4OpAYeqqgmhJM=;
  b=LwFtE5LSIqmW3gONSfg708asCFEik9SYaURbYzQ6ti8kdYTWXQgs7Qm+
   FBaoyzjC0fnICr/7iMbhFrTDy/kDqMA0xKg+RmCzUbVVrZWjea+kZdjDT
   81KxVDTnn+5v38hTLUDGGzA60lMaCrDre16laxBPneOOJVCvABKrwhoxC
   Jfd1TN5Ie1RJr/OugH7H1PPDT3Z7WXaNyOLLI8ToWrAojM5azg1hO0hco
   x5rzzAKEyM5YopvXlVfwI8PmTmhMDRPn/+fmBCH36PLL0MJVOOEzgeP8E
   r9UAtmZGy+aBD70yi9iknScgDB5mgAGavx+PhQXPdN3X6AE6TRjnzNvFK
   A==;
X-CSE-ConnectionGUID: A9N4FKVeT2WWyJ5ET8x8Jg==
X-CSE-MsgGUID: +WMGJRFzQieGVQ4mJG/Raw==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="24133280"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="24133280"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 22:18:59 -0800
X-CSE-ConnectionGUID: DSHvP66dRwyRT+feBznBog==
X-CSE-MsgGUID: wzO32zknR3usMALdELH21w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126283142"
Received: from rzhang1-mobl.sh.intel.com ([10.239.158.59])
  by fmviesa002.fm.intel.com with ESMTP; 07 Jan 2025 22:18:57 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] tools/power turbostat: Time procfs/sysfs snapshot cost
Date: Wed,  8 Jan 2025 14:19:42 +0800
Message-ID: <20250108061942.3264396-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Column "usec" is used to measure time cost, but right now it does not
include the procfs and sysfs snapshot time, which lowers its value.

--- Background ---
Column "usec" shows
1. the number of microseconds elapsed during counter collection,
   including thread migration -- if any, for each CPU row.
2. total elapsed time to collect the counters on all cpus, for the
   summary row.
This can be used to check the time cost of a give column. For example,
run below commands separately
   turbostat --show usec sleep 1
   turbostat --show usec,CoreTmp sleep 1
and the delta in the usec column will tell the time cost for CoreTmp
(Thermal MSR read)

--- Problem ---
Some of the kernel procfs/sysfs accesses are expensive, especially on
high core count systems. "usec" column cannot tell this because it only
includes the time cost of the counters.

--- Solution ---
Leave the per CPU "usec" as it is and modify the summary "usec" to
include the time cost of the procfs/sysfs snapshot.

With it, the "usec" column can be used to get
1. the baseline, e.g.
	turbostat --show usec sleep 1
2. the baseline + some per CPU counter cost, e.g.
	turbostat --show usec,CoreTmp sleep 1
3. the baseline + some per CPU sysfs cost, e.g.
	turbostat --show usec,C1 sleep 1
4. the baseline + /proc/interrupts cost, e.g
	turbostat --show usec,IRQ sleep 1

Document update is also included.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 2 +-
 tools/power/x86/turbostat/turbostat.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index a7f7ed01421c..6fad772dacde 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -136,7 +136,7 @@ displays the statistics gathered since it was forked.
 The system configuration dump (if --quiet is not used) is followed by statistics.  The first row of the statistics labels the content of each column (below).  The second row of statistics is the system summary line.  The system summary line has a '-' in the columns for the Package, Core, and CPU.  The contents of the system summary line depends on the type of column.  Columns that count items (eg. IRQ) show the sum across all CPUs in the system.  Columns that show a percentage show the average across all CPUs in the system.  Columns that dump raw MSR values simply show 0 in the summary.  After the system summary row, each row describes a specific Package/Core/CPU.  Note that if the --cpu parameter is used to limit which specific CPUs are displayed, turbostat will still collect statistics for all CPUs in the system and will still show the system summary for all CPUs in the system.
 .SH COLUMN DESCRIPTIONS
 .PP
-\fBusec\fP For each CPU, the number of microseconds elapsed during counter collection, including thread migration -- if any.  This counter is disabled by default, and is enabled with "--enable usec", or --debug.  On the summary row, usec refers to the total elapsed time to collect the counters on all cpus.
+\fBusec\fP For each CPU, the number of microseconds elapsed during counter collection, including thread migration -- if any.  This counter is disabled by default, and is enabled with "--enable usec", or --debug.  On the summary row, usec refers to the total elapsed time to snapshot the procfs/sysfs and collect the counters on all cpus.
 .PP
 \fBTime_Of_Day_Seconds\fP For each CPU, the gettimeofday(2) value (seconds.subsec since Epoch) when the counters ending the measurement interval were collected.  This column is disabled by default, and can be enabled with "--enable Time_Of_Day_Seconds" or "--debug".  On the summary row, Time_Of_Day_Seconds refers to the timestamp following collection of counters on the last CPU.
 .PP
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 58a487c225a7..ff6c5fa95aac 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -365,6 +365,9 @@ unsigned int has_hwp_activity_window;	/* IA32_HWP_REQUEST[bits 41:32] */
 unsigned int has_hwp_epp;	/* IA32_HWP_REQUEST[bits 31:24] */
 unsigned int has_hwp_pkg;	/* IA32_HWP_REQUEST_PKG */
 unsigned int first_counter_read = 1;
+
+static struct timeval procsysfs_tv_begin;
+
 int ignore_stdin;
 bool no_msr;
 bool no_perf;
@@ -3580,7 +3583,7 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	/* remember first tv_begin */
 	if (average.threads.tv_begin.tv_sec == 0)
-		average.threads.tv_begin = t->tv_begin;
+		average.threads.tv_begin = procsysfs_tv_begin;
 
 	/* remember last tv_end */
 	average.threads.tv_end = t->tv_end;
@@ -5912,6 +5915,8 @@ int snapshot_sys_lpi_us(void)
  */
 int snapshot_proc_sysfs_files(void)
 {
+	gettimeofday(&procsysfs_tv_begin, (struct timezone *)NULL);
+
 	if (DO_BIC(BIC_IRQ))
 		if (snapshot_proc_interrupts())
 			return 1;
-- 
2.43.0


