Return-Path: <linux-pm+bounces-20607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D38D1A14D51
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 11:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E12B188BDA0
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 10:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF961FC0EC;
	Fri, 17 Jan 2025 10:15:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9001FA8D1;
	Fri, 17 Jan 2025 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108904; cv=none; b=VxBX4awuybyAiVLlKFKNCxFeKbWwyt5prQ0TIjVB+wL0vJoOHZZoGSLLSkbiyhYXdmM8BNW00vT4/Ur6FYGoGAU0HT3xNn8fHr4wy/OKF7weTTFbMuP+n/EIFtKkihKStRo/8gNjYZRZ5tM3mRl7FuvaSRFlNz8kK0HoUH4PIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108904; c=relaxed/simple;
	bh=oOivdbj1G72RSxv9WxStP7iE+V1FTJGx5EKT0qrr9Ds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1JvcnSdh6/m3UC11gyr56E9APn2YJ8Daup+1FbYLtammPNGDpMYnWVP2GnWEvybE2Cf5enbCwzbf+Pf/vO7OElz1GynxYXcZ3aqrK8OSvd41CCmURXJMn+gYQRnRARsMPucupl4Z9xgsfU2bO4fKg0yXjGz1COvgxWULM60/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YZFqs3MTDzjYBX;
	Fri, 17 Jan 2025 18:11:05 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2413018006C;
	Fri, 17 Jan 2025 18:14:59 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jan 2025 18:14:58 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v2 1/4] cpufreq: Fix re-boost issue after hotplugging a cpu
Date: Fri, 17 Jan 2025 18:14:54 +0800
Message-ID: <20250117101457.1530653-2-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
References: <20250117101457.1530653-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh100008.china.huawei.com (7.202.181.93)

It turns out that cpuX will stay on the base frequency after performing
these operations:

1. boost all cpus: echo 1 > /sys/devices/system/cpu/cpufreq/boost

2. offline the cpu: echo 0 > /sys/devices/system/cpu/cpuX/online

3. deboost all cpus: echo 0 > /sys/devices/system/cpu/cpufreq/boost

4. online the cpu: echo 1 > /sys/devices/system/cpu/cpuX/online

5. boost all cpus again: echo 1 > /sys/devices/system/cpu/cpufreq/boost

This is because max_freq_req of the policy is not updated during the online
process, and the value of max_freq_req before the last offline is retained.
When the CPU is boosted again, freq_qos_update_request() will do nothing
because the old value is the same as the new one. This causes the CPU stay
on the base frequency. Update max_freq_req  in cpufreq_online() will solve
this problem.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1a4cae54a01b..5882d7f5e3c1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1475,6 +1475,10 @@ static int cpufreq_online(unsigned int cpu)
 
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
+	} else {
+		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
+		if (ret < 0)
+			goto out_destroy_policy;
 	}
 
 	if (cpufreq_driver->get && has_target()) {
-- 
2.33.0


