Return-Path: <linux-pm+bounces-18794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB3C9E8D1B
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 09:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B2E280A13
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACCA2144A4;
	Mon,  9 Dec 2024 08:16:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842AD54918;
	Mon,  9 Dec 2024 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732195; cv=none; b=K61NhBNp+PSp+xz0yjWLu8gfrVUBDeyt9CqS2gE8xPZpgpGIuLif6qM+TQSRigZCGRhdiFSBmxdavMrRi51T/nuHVUM/O2OIKS9Dg4AlEmu0mG5GiKx7k1DpFRCe89KKhZnfu9hAAcgsbSlKxMajxBQtzBsrvw64Y8DZHT33WrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732195; c=relaxed/simple;
	bh=FsqqDwgE2TDVdwyc/1L7H+hXF8l1UCyvklow5IYYd6E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AmIUkGXWz+TbFtAR5O0NtRflqDyXw2SQVZ5UiVLEOBCbwhTPWLy/tMZowU1mZGLuxl5chFzCwPkjpwIgpp1nLXwekM39zCtHUniIC953klTUd2INOpDAJqhJYri28I1Ru4JYOEvXFf56U7rfK9uNBqUEZbC2nbn0M9o2OlCZMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 4B98GSnQ060615;
	Mon, 9 Dec 2024 16:16:28 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4B98EYk9052216;
	Mon, 9 Dec 2024 16:14:34 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Y6F390kLwz2K7ZyH;
	Mon,  9 Dec 2024 16:12:37 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 9 Dec 2024 16:14:32 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <guohua.yan@unisoc.com>,
        <ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: [RFC PATCH] cpufreq: userspace: Add fast-switch support for userspace
Date: Mon, 9 Dec 2024 16:14:29 +0800
Message-ID: <20241209081429.1871-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 4B98EYk9052216

Now, the userspace governor does not support userspace,
if the driver only use the fast-switch and not add target_index(),
it will cause uerspace not work.
So add fast-switch support for userspace governor.

Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/cpufreq/cpufreq_userspace.c | 35 +++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index 2c42fee76daa..3a99197246ed 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -21,6 +21,30 @@ struct userspace_policy {
 	struct mutex mutex;
 };
 
+static int cpufreq_userspace_target_freq(struct cpufreq_policy *policy,
+			unsigned int target_freq, unsigned int relation)
+{
+	int ret;
+
+	if (policy->fast_switch_enabled) {
+		unsigned int idx;
+
+		target_freq = clamp_val(target_freq, policy->min, policy->max);
+
+		if (!policy->freq_table)
+			return target_freq;
+
+		idx = cpufreq_frequency_table_target(policy, target_freq, relation);
+		policy->cached_resolved_idx = idx;
+		policy->cached_target_freq = target_freq;
+		ret = !cpufreq_driver_fast_switch(policy, policy->freq_table[idx].frequency);
+	} else {
+		ret = __cpufreq_driver_target(policy, target_freq, relation);
+	}
+
+	return ret;
+}
+
 /**
  * cpufreq_set - set the CPU frequency
  * @policy: pointer to policy struct where freq is being set
@@ -41,7 +65,7 @@ static int cpufreq_set(struct cpufreq_policy *policy, unsigned int freq)
 
 	userspace->setspeed = freq;
 
-	ret = __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
+	ret = cpufreq_userspace_target_freq(policy, freq, CPUFREQ_RELATION_L);
  err:
 	mutex_unlock(&userspace->mutex);
 	return ret;
@@ -62,6 +86,8 @@ static int cpufreq_userspace_policy_init(struct cpufreq_policy *policy)
 
 	mutex_init(&userspace->mutex);
 
+	cpufreq_enable_fast_switch(policy);
+
 	policy->governor_data = userspace;
 	return 0;
 }
@@ -72,6 +98,7 @@ static int cpufreq_userspace_policy_init(struct cpufreq_policy *policy)
  */
 static void cpufreq_userspace_policy_exit(struct cpufreq_policy *policy)
 {
+	cpufreq_disable_fast_switch(policy);
 	kfree(policy->governor_data);
 	policy->governor_data = NULL;
 }
@@ -112,13 +139,13 @@ static void cpufreq_userspace_policy_limits(struct cpufreq_policy *policy)
 		 policy->cpu, policy->min, policy->max, policy->cur, userspace->setspeed);
 
 	if (policy->max < userspace->setspeed)
-		__cpufreq_driver_target(policy, policy->max,
+		cpufreq_userspace_target_freq(policy, policy->max,
 					CPUFREQ_RELATION_H);
 	else if (policy->min > userspace->setspeed)
-		__cpufreq_driver_target(policy, policy->min,
+		cpufreq_userspace_target_freq(policy, policy->min,
 					CPUFREQ_RELATION_L);
 	else
-		__cpufreq_driver_target(policy, userspace->setspeed,
+		cpufreq_userspace_target_freq(policy, userspace->setspeed,
 					CPUFREQ_RELATION_L);
 
 	mutex_unlock(&userspace->mutex);
-- 
2.25.1


