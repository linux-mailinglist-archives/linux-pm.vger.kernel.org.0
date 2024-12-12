Return-Path: <linux-pm+bounces-19080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498359EDD7D
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 03:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D96188A5ED
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 02:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B558C13D881;
	Thu, 12 Dec 2024 02:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Dy7Fs174"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7EC15E8B;
	Thu, 12 Dec 2024 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733969710; cv=none; b=extOzUaZpHuy2DgbJpd4fj8xAY1I4UXrTO5gxuZ1rs6No+zUbWQAZBzE1GGvcRbNyGNufCP9cd8Sw40032Bp3llJMj7j5k51Hh+p04uQms/DwvoKukA0LfVRmtISvOE1cOSbElW04+nnvibkHh8IxQUmV6O+eTTac6rM8PfeaPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733969710; c=relaxed/simple;
	bh=/CnNBg2D4i7ETt3RajcfbOv7J8vf0GeJ8ssFf/Vvxmw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iAgVLcnVKUwrPmxz4Vdz6rA4/uBBm8Bn5gZil/2mUkxzDaqGWI1UeTL3JptbwUwYvOoKpKjxSEwPML7d+GAylZlWtEyrBGnFh/SHRYPXG9w7zphKVEAzGaI2BwO/j0+zcWiCW+7For7erV258JhHNWMO2Zqk+SZzrsKvWN8v+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Dy7Fs174; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733969700; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	bh=0cogIC2UexIl+bJSuBhlmkVNDgY9+Vttkj5vIbyRkb4=;
	b=Dy7Fs174KTwv4D19kw2kq4iATfVMXdw+iZ+LyZHG3aqgP8Wjkbf0FwoWFQDAEBNNArfe8sYhJdDyowhJ10XOgjYSHQf+ht2399q4IbGzekcHhnc+sfakmMz6w4pB7fnYPHDZgGDm+fBaaz/7Fr21kao9EKXeISbWKjwsc+5nZx4=
Received: from 30.221.97.226(mailfrom:herongguang@linux.alibaba.com fp:SMTPD_---0WLJy8AQ_1733969699 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 10:15:00 +0800
Message-ID: <6084e3c9-921b-4450-97bd-51ec44c52c04@linux.alibaba.com>
Date: Thu, 12 Dec 2024 10:14:59 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: trenn@suse.com, shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 wyes.karny@amd.com
Cc: linux-kernel@vger.kernel.org, shannon.zhao@linux.alibaba.com,
 linux-pm@vger.kernel.org
From: He Rongguang <herongguang@linux.alibaba.com>
Subject: [PATCH v3] cpupower: fix TSC MHz calculation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

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
Changes in v3:
- disable thunderbird sending mail auto wrap.
- Link to v2: https://lore.kernel.org/linux-pm/60562222-6186-4eec-9c20-08b1cebb1311@linux.alibaba.com/T/#u

Changes in v2:
- Fix scripts/checkpatch.pl style warnings.
- Link to v1: https://lore.kernel.org/linux-pm/269b8bb2-85b5-4cc9-9354-a1270f2eed35@linux.alibaba.com/T/#u
---
 .../cpupower/utils/idle_monitor/mperf_monitor.c   | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
index ae6af354a81d..08a399b0be28 100644
--- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
@@ -33,7 +33,7 @@ static int mperf_get_count_percent(unsigned int self_id, double *percent,
 				   unsigned int cpu);
 static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
 				unsigned int cpu);
-static struct timespec time_start, time_end;
+static struct timespec *time_start, *time_end;
 
 static cstate_t mperf_cstates[MPERF_CSTATE_COUNT] = {
 	{
@@ -174,7 +174,7 @@ static int mperf_get_count_percent(unsigned int id, double *percent,
 		dprint("%s: TSC Ref - mperf_diff: %llu, tsc_diff: %llu\n",
 		       mperf_cstates[id].name, mperf_diff, tsc_diff);
 	} else if (max_freq_mode == MAX_FREQ_SYSFS) {
-		timediff = max_frequency * timespec_diff_us(time_start, time_end);
+		timediff = max_frequency * timespec_diff_us(time_start[cpu], time_end[cpu]);
 		*percent = 100.0 * mperf_diff / timediff;
 		dprint("%s: MAXFREQ - mperf_diff: %llu, time_diff: %llu\n",
 		       mperf_cstates[id].name, mperf_diff, timediff);
@@ -207,7 +207,7 @@ static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
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

