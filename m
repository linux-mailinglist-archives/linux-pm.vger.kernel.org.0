Return-Path: <linux-pm+bounces-18199-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DC09DB515
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 10:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57071282529
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 09:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F4C156238;
	Thu, 28 Nov 2024 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RP6dXqr9"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A57F288DB;
	Thu, 28 Nov 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787454; cv=none; b=lsDb4zFcKJCfUazmLVV5WLLqWDC6SRaNJEeiR/FeIJZSUT3DYxvqjtRSzM23OMIxQqKfUJaYwa9+dHCpe7EfZS/marZClX4T2ki+Xsvf6rpuieilBIInmFGhjSj120EXQPTdj57CPN7+GImzvAaXSTdGotc3u7F+wNrVjT7usfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787454; c=relaxed/simple;
	bh=yhUJak+aiRwd+DuRnOGIixGNrFSkXjoy8lNGqwYmHck=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=lz/3wEzKEyC6gRV3hvyTm72eqcwkVuUFCAYkFnVC/DN2iS9kzG3gH3TNLLEcbG23k8rZ7x1TDTTCDjGV4PU1/HkyDykfOGkx2Nnf41o3rjT4yWyItRH9QBAqZzbBqzGW0PVIdQQjUnYdQNRGOKKWYKpj+p+A/Ag3ZAdfoJjjWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RP6dXqr9; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732787446; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=CLgZI6pExZXq1orTPdpeKWc5Bi0ajupm/DC0JUti5JA=;
	b=RP6dXqr9BRtkikRd60GP4P1cU8VX5zcXLWFh0e8Xx2whwlba8CdMiSYvoVAmYWA6LeD/4YX+3YwXBQ9DeUbbrrhbfILD5olpq79sgpLxVgmBGcAbYn5m3cqNVqOM6KTZjf5vKuLX7g5ovj7oEvWrKkh8qrC82WaoLE2VbjUgit0=
Received: from 30.221.97.4(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0WKPZXAe_1732787445 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 17:50:45 +0800
Message-ID: <269b8bb2-85b5-4cc9-9354-a1270f2eed35@linux.alibaba.com>
Date: Thu, 28 Nov 2024 17:50:45 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: He Rongguang <herongguang@linux.alibaba.com>
Subject: [PATCH] cpupower: fix TSC MHz calculation for Mperf monitor
To: trenn@suse.com, shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 wyes.karny@amd.com
Cc: linux-kernel@vger.kernel.org, shannon.zhao@linux.alibaba.com,
 linux-pm@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit 'cpupower: Make TSC read per CPU for Mperf monitor' (c2adb1877b7)
changes TSC counter reads to per cpu, but left time diff global (from
start of all cpus to end of all cpus), thus diff(time) is too large for
a cpu's tsc counting, resulting in far less than acutal TSC_Mhz and thus
`cpupower monitor` showing far less than actual cpu realtime frequency.

Fix this by making timediff also per cpu.

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

Fixes: c2adb1877b76f ("cpupower: Make TSC read per CPU for Mperf monitor")
Signed-off-by: He Rongguang <herongguang@linux.alibaba.com>
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

