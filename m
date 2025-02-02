Return-Path: <linux-pm+bounces-21236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89F7A24F23
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 18:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F26162E79
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189D41FAC52;
	Sun,  2 Feb 2025 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg4+fRm4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F4B1F9F73
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516397; cv=none; b=ils1CZrMpusKrZTg/v68N3DqgarAmZbjlfNpM3YDegTucwnPVZE30Gjx4bCpmoUMHzFEwMpIXnJ+DozoEFk08INus6oP6jWqM1Qz3xTxc/6sCvXZx+48ZjVXzxipByn7dnNQbdYwIaKDxI0dqRESVDcifwWZeII8N55546xtzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516397; c=relaxed/simple;
	bh=g8HieEwPr/jjn7MVyejBANxeNQfG154FQDsz9L/zD+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhUCF5lGMTsArtz4GZPebjFo/awf6UZKTP8636qvQKlPF/4F72pmhIIID1sXx7R/y5xdINzcKj3UzfBIPaDNyWtBCe0ARLBFH6As4canhEG7Lmwx6zrd0IzvUOkTRoXHsHzvR74KY5FHhSHxYQy4hjyl8A8HVRp6seFQCbnbL08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg4+fRm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9068BC4CED1;
	Sun,  2 Feb 2025 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738516395;
	bh=g8HieEwPr/jjn7MVyejBANxeNQfG154FQDsz9L/zD+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=lg4+fRm4KuVH9ECv3Pj3ROEJ30gyUK0O4ZEAmQnoI9nagBsaO5+x/rBjdYIpU9J51
	 heWI57HV6CDqKKuWg0dbM1xYYY4d9MXUysGtRRASrq3kW7c5AzEy2QD35tVjMMV4wq
	 zpqbc9vm4qkVfoez3060HQVKeLctd+wToikaajuOvsngwmN9NAUB/I+Wt3/BHgVpgd
	 us36vM7G3PHpe//QxkogKyQM3U4EBydhwF6yyNoIKSrY/bqQjLNH6DuT+eHEtYAUOt
	 WINmm92VHrrUqifB+vfc1hgnIm7DvaShbYw7aeLU9xkJ1QGv2t+yhsKXjh3yhSgsPl
	 j+9xPClhDO78A==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 13/25] tools/power turbostat: Enhance turbostat self-performance visibility
Date: Sun,  2 Feb 2025 11:09:29 -0600
Message-ID: <1af5baeda512d0940748fdf9b559e1041dbab0cf.1738515889.git.len.brown@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
References: <e8a99af68c068865dbac7f3330e97bf8e96edf33.1738515889.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

Include procfs and sysfs data collection time in the system summary
row of the "usec" column.  This is useful for isolating where the
time goes during turbostat data collection.

Background:

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

Problem:

Some of the kernel procfs/sysfs accesses are expensive, especially on
high core count systems. "usec" column cannot tell this because it only
includes the time cost of the counters.

Solution:

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

Man-page update is also included.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 | 2 +-
 tools/power/x86/turbostat/turbostat.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index f043a93defd4..99bf905ade81 100644
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
index 1bcecfed721b..adcf5f0a0633 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -370,6 +370,9 @@ unsigned int has_hwp_activity_window;	/* IA32_HWP_REQUEST[bits 41:32] */
 unsigned int has_hwp_epp;	/* IA32_HWP_REQUEST[bits 31:24] */
 unsigned int has_hwp_pkg;	/* IA32_HWP_REQUEST_PKG */
 unsigned int first_counter_read = 1;
+
+static struct timeval procsysfs_tv_begin;
+
 int ignore_stdin;
 bool no_msr;
 bool no_perf;
@@ -3638,7 +3641,7 @@ int sum_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 
 	/* remember first tv_begin */
 	if (average.threads.tv_begin.tv_sec == 0)
-		average.threads.tv_begin = t->tv_begin;
+		average.threads.tv_begin = procsysfs_tv_begin;
 
 	/* remember last tv_end */
 	average.threads.tv_end = t->tv_end;
@@ -5983,6 +5986,8 @@ int snapshot_sys_lpi_us(void)
  */
 int snapshot_proc_sysfs_files(void)
 {
+	gettimeofday(&procsysfs_tv_begin, (struct timezone *)NULL);
+
 	if (DO_BIC(BIC_IRQ) || DO_BIC(BIC_NMI))
 		if (snapshot_proc_interrupts())
 			return 1;
-- 
2.43.0


