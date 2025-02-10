Return-Path: <linux-pm+bounces-21692-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0304DA2ED4E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 14:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7411887B5C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1528E2236E8;
	Mon, 10 Feb 2025 13:14:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F9A1B0F00
	for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193267; cv=none; b=gdxpckzLLE8ND5BeqXj7b/Mn4tu545AO6K851yTs/OIvuNLQiaSCN+Kypy7dBVCHwGIjsHxAhxdkKym8N6J9hO7RiP1qCXSZSOTFnT82y6bFQNCP8beSTOpMROlTdAx/FAfFjq8Qa+5h2tINKxnpStFzz2RenDGCKQinTGpKXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193267; c=relaxed/simple;
	bh=50UMeUbur0nYrtJsf3ETLpUGsoawcHTagy4EKQB/HYI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EVKDg2gpqbpCnMlTnLpoCzmWH6ov0sTDLLecg0wniWwBtb7X8J0qg6Zzf8Bal4cr+xAljBemPycWIt95zd2oj48DGTErkFDa03l0/P82NupHDn9QsAb98QcHYoQOkA5mzn7kpy9qylNwhlIsVtRRe9gPjLmz4AOaFx9Thjm8RZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ys4hM607fzWfj8;
	Mon, 10 Feb 2025 21:10:59 +0800 (CST)
Received: from kwepemo100006.china.huawei.com (unknown [7.202.195.47])
	by mail.maildlp.com (Postfix) with ESMTPS id 84CFD1800E7;
	Mon, 10 Feb 2025 21:14:19 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemo100006.china.huawei.com (7.202.195.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Feb 2025 21:14:18 +0800
From: Jie Zhan <zhanjie9@hisilicon.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <yu.c.chen@intel.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhanjie9@hisilicon.com>,
	<zhenglifeng1@huawei.com>, <lihuisong@huawei.com>, <wanghuiqiang@huawei.com>,
	<fanghao11@huawei.com>, <prime.zeng@hisilicon.com>
Subject: [PATCH] cpufreq: governor: Fix negative 'idle_time' handling in dbs_update()
Date: Mon, 10 Feb 2025 21:06:59 +0800
Message-ID: <20250210130659.3533182-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemo100006.china.huawei.com (7.202.195.47)

We observed an issue that the cpu frequency can't raise up with a 100% cpu
load when nohz is off and the 'conservative' governor is selected.

'idle_time' can be negative if it's obtained from get_cpu_idle_time_jiffy()
when nohz is off.  This was found and explained in commit 9485e4ca0b48
("cpufreq: governor: Fix handling of special cases in dbs_update()").

However, commit 7592019634f8 ("cpufreq: governors: Fix long idle detection
logic in load calculation") introduced a comparison between 'idle_time' and
'samling_rate' to detect a long idle interval.  While 'idle_time' is
converted to int before comparison, it's actually promoted to unsigned
again when compared with an unsigned 'sampling_rate'.  Hence, this leads to
wrong idle interval detection when it's in fact 100% busy and sets
policy_dbs->idle_periods to a very large value.  'conservative' adjusts the
frequency to minimum because of the large 'idle_periods', such that the
frequency can't raise up.  'Ondemand' doesn't use policy_dbs->idle_periods
so it fortunately avoids the issue.

Modify negative 'idle_time' to 0 before any use of it in dbs_update().

Fixes: 7592019634f8 ("cpufreq: governors: Fix long idle detection logic in load calculation")
Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/cpufreq/cpufreq_governor.c | 41 ++++++++++++++----------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index af44ee6a6430..cd045ca2268c 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -147,6 +147,20 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 
 		idle_time = cur_idle_time - j_cdbs->prev_cpu_idle;
 		j_cdbs->prev_cpu_idle = cur_idle_time;
+		/*
+		 * idle_time can be negative if cur_idle_time is returned by
+		 * get_cpu_idle_time_jiffy() when NO_HZ is off.  In that case
+		 * idle_time is roughly equal to the difference between
+		 * time_elapsed and "busy time" obtained from CPU statistics.
+		 * Then, the "busy time" can end up being greater than
+		 * time_elapsed (for example, if jiffies_64 and the CPU
+		 * statistics are updated by different CPUs), so idle_time may
+		 * in fact be negative.  That means, though, that the CPU was
+		 * busy all the time (on the rough average) during the last
+		 * sampling interval, so idle_time should be regarded as 0 in
+		 * order to make the further process correct.
+		 */
+		idle_time = (int)idle_time < 0 ? 0 : idle_time;
 
 		if (ignore_nice) {
 			u64 cur_nice = kcpustat_field(&kcpustat_cpu(j), CPUTIME_NICE, j);
@@ -162,7 +176,7 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			 * calls, so the previous load value can be used then.
 			 */
 			load = j_cdbs->prev_load;
-		} else if (unlikely((int)idle_time > 2 * sampling_rate &&
+		} else if (unlikely(idle_time > 2 * sampling_rate &&
 				    j_cdbs->prev_load)) {
 			/*
 			 * If the CPU had gone completely idle and a task has
@@ -189,30 +203,13 @@ unsigned int dbs_update(struct cpufreq_policy *policy)
 			load = j_cdbs->prev_load;
 			j_cdbs->prev_load = 0;
 		} else {
-			if (time_elapsed >= idle_time) {
-				load = 100 * (time_elapsed - idle_time) / time_elapsed;
-			} else {
-				/*
-				 * That can happen if idle_time is returned by
-				 * get_cpu_idle_time_jiffy().  In that case
-				 * idle_time is roughly equal to the difference
-				 * between time_elapsed and "busy time" obtained
-				 * from CPU statistics.  Then, the "busy time"
-				 * can end up being greater than time_elapsed
-				 * (for example, if jiffies_64 and the CPU
-				 * statistics are updated by different CPUs),
-				 * so idle_time may in fact be negative.  That
-				 * means, though, that the CPU was busy all
-				 * the time (on the rough average) during the
-				 * last sampling interval and 100 can be
-				 * returned as the load.
-				 */
-				load = (int)idle_time < 0 ? 100 : 0;
-			}
+			load = time_elapsed > idle_time ?
+			       100 * (time_elapsed - idle_time) / time_elapsed :
+			       0;
 			j_cdbs->prev_load = load;
 		}
 
-		if (unlikely((int)idle_time > 2 * sampling_rate)) {
+		if (unlikely(idle_time > 2 * sampling_rate)) {
 			unsigned int periods = idle_time / sampling_rate;
 
 			if (periods < idle_periods)
-- 
2.33.0


