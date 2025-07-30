Return-Path: <linux-pm+bounces-31567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32764B157B7
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 05:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6788554724D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 03:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4912A174EE4;
	Wed, 30 Jul 2025 03:06:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE34813C8EA;
	Wed, 30 Jul 2025 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753844817; cv=none; b=X0SYOW4DEYjtAH8TxqVAanLsjvFCZZM9GiBIJl2QkwwTq1eSRWWcbu21Y+goxG64u9xPpuMzqIVtDxCTRA1+bdE/+z3+oNzxw9/xF5tUVns9U/2JpyNrkbYRKRXDFh94er2RE9hYYtd4cCj4a+yoSUQ/k6rMuXBB7/NKy4BEu/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753844817; c=relaxed/simple;
	bh=Aagab7gg5BIDVgKuHhsCNAhAFJ50a4FvrAVmXv53GF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TvFLKg/VCCu7JDTyiFdUNh5q9W88/9WclSrxCvnGEzRMLzzNzOaP07z9jSQ3llTPrCwSBzDLpoihDOOcr49vP2V018M7b10Rh7u8Jjqy1me3dTTD8CpGOZN2zGBTMXZkhwNicWQVKALyZk32lMLFLThjA1ixqZagDWLgIyzoVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bsHG01tzZz27j5K;
	Wed, 30 Jul 2025 11:07:52 +0800 (CST)
Received: from kwepemk500012.china.huawei.com (unknown [7.202.194.97])
	by mail.maildlp.com (Postfix) with ESMTPS id C302018005F;
	Wed, 30 Jul 2025 11:06:50 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500012.china.huawei.com (7.202.194.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Jul 2025 11:06:50 +0800
From: BowenYu <yubowen8@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<yubowen8@huawei.com>
Subject: [PATCH] cpufreq: Remove unused parameter in cppc_perf_from_fbctrs()
Date: Wed, 30 Jul 2025 11:06:49 +0800
Message-ID: <20250730030649.151272-1-yubowen8@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500012.china.huawei.com (7.202.194.97)

Remove the unused parameter cppc_cpudata* cpu_data in 
cppc_perf_from_fbctrs().

Signed-off-by: BowenYu <yubowen8@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index b7c688a5659c..c58e548ec491 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -58,8 +58,7 @@ struct cppc_freq_invariance {
 static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
 static struct kthread_worker *kworker_fie;
 
-static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
-				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
+static int cppc_perf_from_fbctrs(struct cppc_perf_fb_ctrs *fb_ctrs_t0,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t1);
 
 /**
@@ -95,8 +94,7 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
 		return;
 	}
 
-	perf = cppc_perf_from_fbctrs(cpu_data, &cppc_fi->prev_perf_fb_ctrs,
-				     &fb_ctrs);
+	perf = cppc_perf_from_fbctrs(&cppc_fi->prev_perf_fb_ctrs, &fb_ctrs);
 	if (!perf)
 		return;
 
@@ -699,8 +697,7 @@ static inline u64 get_delta(u64 t1, u64 t0)
 	return (u32)t1 - (u32)t0;
 }
 
-static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
-				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
+static int cppc_perf_from_fbctrs(struct cppc_perf_fb_ctrs *fb_ctrs_t0,
 				 struct cppc_perf_fb_ctrs *fb_ctrs_t1)
 {
 	u64 delta_reference, delta_delivered;
@@ -762,8 +759,7 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 			return 0;
 	}
 
-	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
-					       &fb_ctrs_t1);
+	delivered_perf = cppc_perf_from_fbctrs(&fb_ctrs_t0, &fb_ctrs_t1);
 	if (!delivered_perf)
 		goto out_invalid_counters;
 
-- 
2.33.0


