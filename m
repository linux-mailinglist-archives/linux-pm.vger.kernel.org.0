Return-Path: <linux-pm+bounces-18981-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C69EC318
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 04:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F038166914
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 03:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5938C20C000;
	Wed, 11 Dec 2024 03:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dFY6ayh4"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435C9209F40;
	Wed, 11 Dec 2024 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887244; cv=none; b=CgKsCQZIgDhB3TgoY3EYZlnQ+aDg5cd4hy5ymiQocSL922A7l1Miks+kcZwOsrz+Qasx3NVgVaW/zMB1REyUrq7jU8wExYph8ielgcHDq0QPhy4CBv+y4gjofoeIHP5Y0Zmn+yuy9erFwYNQkHtKdjgMa7RvLb6boSuhv6Fm1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887244; c=relaxed/simple;
	bh=fRxhpuUjtgVkNwrCgE3pRuTgxUzYTw8SEXVqMTDfOKQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ZKzZYAVQMe3c3P46kxyJ74vaEgCpR/gCMoP1ARD8bLw6mqeVkkXKSAjpyWieNFBYRocjFxEOgcqfCWXoWeKO4kBqkPGNX6i8JnbPxAwXzCnxFiBHFVDn60b+PHJA2YoSrGB5RPYkYXUNIfuTiHLWKfbRM9qJcIiiSoDLuN0BpAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dFY6ayh4; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733887238; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=keIdpO0T1ZIVmdr1mrq2KQZ0w8NnEO79y3GxoIfU1pQ=;
	b=dFY6ayh4K4fVMerCfByLBW1KIrltKOuUVyIfA5v0ztMifWSvB/06Cv6i/+WoO15rEH8/MWniO4rcX4cu1NaI8zJaYv30GpIi1UHgg4E0n7yPipZrzGah5vVB01bPqrFZMq6p+7sADtJMh7/aZIgDb4e4Fp57aLuJiZK409m/KIg=
Received: from 30.221.97.190(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0WLGp4I3_1733887235 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Dec 2024 11:20:38 +0800
Message-ID: <60562222-6186-4eec-9c20-08b1cebb1311@linux.alibaba.com>
Date: Wed, 11 Dec 2024 11:20:36 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: He Rongguang <herongguang@linux.alibaba.com>
Subject: [PATCH v2] cpupower: fix TSC MHz calculation for Mperf monitor
To: trenn@suse.com, shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, shannon.zhao@linux.alibaba.com,
 linux-pm@vger.kernel.org, herongguang@linux.alibaba.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From e17f252433c923578e9c386a998200e488d9567d Mon Sep 17 00:00:00 2001
From: He Rongguang <herongguang@linux.alibaba.com>
Date: Thu, 28 Nov 2024 16:50:05 +0800
Subject: [PATCH] cpupower: fix TSC MHz calculation

Commit 'cpupower: Make TSC read per CPU for Mperf monitor' (c2adb1877b7)
changes TSC counter reads per cpu, but left time diff global (from start
of all cpus to end of all cpus), thus diff(time) is too large for a
cpu's tsc counting, resulting in far less than acutal TSC_Mhz and thus
`cpupower monitor` showing far less than actual cpu realtime frequency.

/proc/cpuinfo shows frequency:
cat /proc/cpuinfo | egrep -e 'processor' -e 'MHz'
...
processor : 171
cpu MHz   : 4108.498
...

before fix (System 100% busy):
    | Mperf              || Idle_Stats
 CPU| C0   | Cx   | Freq  || POLL | C1   | C2
 171|  0.77| 99.23|  2279||  0.00|  0.00|  0.00

after fix (System 100% busy):
    | Mperf              || Idle_Stats
 CPU| C0   | Cx   | Freq  || POLL | C1   | C2
 171|  0.46| 99.54|  4095||  0.00|  0.00|  0.00

Fixes: c2adb1877b76 ("cpupower: Make TSC read per CPU for Mperf monitor")
Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
---
Changes in v2:
- Fix scripts/checkpatch.pl style warnings.
- Link to v1:
https://lore.kernel.org/linux-pm/269b8bb2-85b5-4cc9-9354-a1270f2eed35@linux.alibaba.com/T/#u
---
 .../cpupower/utils/idle_monitor/mperf_monitor.c   | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index ae6af354a81d..08a399b0be28 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -33,7 +33,7 @@ static int mperf_get_count_percent(unsigned int
self_id, double *percent,
 				   unsigned int cpu);
 static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
 				unsigned int cpu);
-static struct timespec time_start, time_end;
+static struct timespec *time_start, *time_end;

 static cstate_t mperf_cstates[MPERF_CSTATE_COUNT] = {
 	{
@@ -174,7 +174,7 @@ static int mperf_get_count_percent(unsigned int id,
double *percent,
 		dprint("%s: TSC Ref - mperf_diff: %llu, tsc_diff: %llu\n",
 		       mperf_cstates[id].name, mperf_diff, tsc_diff);
 	} else if (max_freq_mode == MAX_FREQ_SYSFS) {
-		timediff = max_frequency * timespec_diff_us(time_start, time_end);
+		timediff = max_frequency * timespec_diff_us(time_start[cpu],
time_end[cpu]);
 		*percent = 100.0 * mperf_diff / timediff;
 		dprint("%s: MAXFREQ - mperf_diff: %llu, time_diff: %llu\n",
 		       mperf_cstates[id].name, mperf_diff, timediff);
@@ -207,7 +207,7 @@ static int mperf_get_count_freq(unsigned int id,
unsigned long long *count,
 	if (max_freq_mode == MAX_FREQ_TSC_REF) {
 		/* Calculate max_freq from TSC count */
 		tsc_diff = tsc_at_measure_end[cpu] - tsc_at_measure_start[cpu];
-		time_diff = timespec_diff_us(time_start, time_end);
+		time_diff = timespec_diff_us(time_start[cpu], time_end[cpu]);
 		max_frequency = tsc_diff / time_diff;
 	}

@@ -226,9 +226,8 @@ static int mperf_start(void)
 {
 	int cpu;

-	clock_gettime(CLOCK_REALTIME, &time_start);
-
 	for (cpu = 0; cpu < cpu_count; cpu++) {
+		clock_gettime(CLOCK_REALTIME, &time_start[cpu]);
 		mperf_get_tsc(&tsc_at_measure_start[cpu]);
 		mperf_init_stats(cpu);
 	}
@@ -243,9 +242,9 @@ static int mperf_stop(void)
 	for (cpu = 0; cpu < cpu_count; cpu++) {
 		mperf_measure_stats(cpu);
 		mperf_get_tsc(&tsc_at_measure_end[cpu]);
+		clock_gettime(CLOCK_REALTIME, &time_end[cpu]);
 	}

-	clock_gettime(CLOCK_REALTIME, &time_end);
 	return 0;
 }

@@ -349,6 +348,8 @@ struct cpuidle_monitor *mperf_register(void)
 	aperf_current_count = calloc(cpu_count, sizeof(unsigned long long));
 	tsc_at_measure_start = calloc(cpu_count, sizeof(unsigned long long));
 	tsc_at_measure_end = calloc(cpu_count, sizeof(unsigned long long));
+	time_start = calloc(cpu_count, sizeof(struct timespec));
+	time_end = calloc(cpu_count, sizeof(struct timespec));
 	mperf_monitor.name_len = strlen(mperf_monitor.name);
 	return &mperf_monitor;
 }
@@ -361,6 +362,8 @@ void mperf_unregister(void)
 	free(aperf_current_count);
 	free(tsc_at_measure_start);
 	free(tsc_at_measure_end);
+	free(time_start);
+	free(time_end);
 	free(is_valid);
 }

-- 
2.43.0


