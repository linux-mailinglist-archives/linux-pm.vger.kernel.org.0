Return-Path: <linux-pm+bounces-31569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D4B157CA
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 05:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E993BC00D
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 03:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073E01D63DD;
	Wed, 30 Jul 2025 03:23:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516C67082F;
	Wed, 30 Jul 2025 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753845800; cv=none; b=RM/5QJysnA55bM2SvLrKtMHQYOcGjFG2Tza5fi9OokTha4FCVvv2NOfH/VdtUrNQJbJtjtEcjoFWEO+R0i+M7BwCKNv5Zssg7v3wRNxlOxx6ecIQxMHW0susy8LspFPNgLPdL7QOT5vhnFQoG+K0CuXaUDMi7pJbyi6HgjSosQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753845800; c=relaxed/simple;
	bh=tzCNHp0ESR+PV5haOei97I13pxR2/0b/4S413xF/154=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoLJ6VgWKaCCPDVeZkdzhf3xTrLFX4LKOqXqD22WkuU9dUGkBMu2wdTnDOnKuUmIyUC1xtfUuWIA180DtCD1RMForitEn+eKGvlFduIiKxlHAu4tOPNkLEYQXRq9BaylyoBp2n32XEpDNPCfHeOeQvoQD5c3lHZYn85EGC5k1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bsHVs3W9fzphCC;
	Wed, 30 Jul 2025 11:19:01 +0800 (CST)
Received: from kwepemk500012.china.huawei.com (unknown [7.202.194.97])
	by mail.maildlp.com (Postfix) with ESMTPS id A555B18005F;
	Wed, 30 Jul 2025 11:23:14 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500012.china.huawei.com (7.202.194.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Jul 2025 11:23:14 +0800
From: Bowen Yu <yubowen8@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<yubowen8@huawei.com>
Subject: [PATCH 2/2] cpufreq: CPPC: Fix error handling in cppc_scale_freq_workfn()
Date: Wed, 30 Jul 2025 11:23:12 +0800
Message-ID: <20250730032312.167062-3-yubowen8@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250730032312.167062-1-yubowen8@huawei.com>
References: <20250730032312.167062-1-yubowen8@huawei.com>
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

From: Jie Zhan <zhanjie9@hisilicon.com>

Perf counters could be 0 if the cpu is in a low-power idle state. Just try
it again next time and update the frequency scale when the cpu is active
and perf counters successfully return.

Also, remove the FIE source on an actual failure.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 904006027df2..e95844d3d366 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -78,12 +78,23 @@ static void cppc_scale_freq_workfn(struct kthread_work *work)
 	struct cppc_cpudata *cpu_data;
 	unsigned long local_freq_scale;
 	u64 perf;
+	int ret;
 
 	cppc_fi = container_of(work, struct cppc_freq_invariance, work);
 	cpu_data = cppc_fi->cpu_data;
 
-	if (cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs)) {
+	ret = cppc_get_perf_ctrs(cppc_fi->cpu, &fb_ctrs);
+	/*
+	 * Perf counters could be 0 if the cpu is in a low-power idle state.
+	 * Just try it again next time.
+	 */
+	if (ret == -EFAULT)
+		return;
+
+	if (ret) {
 		pr_warn("%s: failed to read perf counters\n", __func__);
+		topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_CPPC,
+						 cpu_data->shared_cpu_map);
 		return;
 	}
 
-- 
2.33.0


