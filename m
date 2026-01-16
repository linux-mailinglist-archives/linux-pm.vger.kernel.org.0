Return-Path: <linux-pm+bounces-40983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3E7D2EFD9
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 10:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B764630486A0
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0966535C18E;
	Fri, 16 Jan 2026 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yGTx1woF"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B103A303A07;
	Fri, 16 Jan 2026 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556762; cv=none; b=iFz/XfXTxXfx2jU+G1FocJnKKVQIcHVwnxamR6ck7yqYaweqCDaS+enn/YWymR1HHsDkqdULO5Dqt2KumQb5EFc8XryZ87gaF4sE/74Au8fF7uB/eRL14YGY/bfmW4qu9j2ILjezwNH1YJedLXR3hZOlbEoFiM6ZpLbLn5C8tbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556762; c=relaxed/simple;
	bh=m421hIYQP+yfxRdrQflIbJiXC3dU4Q1BQPDfFggy3ro=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I7fNCfR5K888MLewdQis24xC1CkENGr/hvQ0+Luq+SqIKJGMiMK0xtQfsWRjzu+y4k/tLsQ9VJZ2cQeMXRZucdocRl/SeADM1wda/fjqOGwIcajx3LzlrWbZdD6kTHSjlEAORa6nTF8ZLl7tq2s0PENsXrbIGOuDnZGSkz0MmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yGTx1woF; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QF7zU4hJWyAMbYXRHGLRiurL79EX5KOCS0CC1Z22cyM=;
	b=yGTx1woFTEn6ph6cZ3Jtzl5W3cI1TSp+fgsYiDRggHuuJBuwwECUUlNr6d0hwRHnGqmZG30ru
	TeX4yMuHX+mFc0W13FQ22t+mrE8M/+wFIOdoQl5U1EQdVZQBe13iCbA+ZtnPn37iSKBsJkPE0Tq
	FTGW1G6BrpJAn09bwh/jImQ=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dsvzQ1XvXz12LDt;
	Fri, 16 Jan 2026 17:42:58 +0800 (CST)
Received: from kwepemr200004.china.huawei.com (unknown [7.202.195.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 438A8201E9;
	Fri, 16 Jan 2026 17:45:57 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemr200004.china.huawei.com
 (7.202.195.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Jan
 2026 17:45:56 +0800
From: Pengjie Zhang <zhangpengjie2@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>
Subject: [PATCH] cpufreq: cppc: Use lowest_nonlinear_perf as a soft minimum limit
Date: Fri, 16 Jan 2026 17:45:55 +0800
Message-ID: <20260116094555.2978887-1-zhangpengjie2@huawei.com>
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
 kwepemr200004.china.huawei.com (7.202.195.241)

The ACPI 6.5 specification describes "Lowest Performance" as the absolute
lowest performance level of the platform. It notes:

"Selecting a performance level lower than the lowest nonlinear performance
level may actually cause an efficiency penalty, but should reduce the
instantaneous power consumption of the processor. In traditional terms,
this represents the T-state range of performance levels."

Currently, the cpufreq core initializes the minimum QoS request to 0.
While this allows userspace to modify limits, it causes the CPU frequency
to drop below lowest_nonlinear_perf by default. This hurts performance with
negligible power savings.

To fix this, implement a "soft" limit in cppc_verify_policy(). If the
policy minimum is still the default (0), it is clamped to
lowest_nonlinear_perf. However, if userspace has explicitly set a lower
limit, that configuration takes precedence.

Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 9eac77c4f294..59aa1721438b 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -301,9 +301,23 @@ static unsigned int cppc_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	return target_freq;
 }
 
-static int cppc_verify_policy(struct cpufreq_policy_data *policy)
+static int cppc_verify_policy(struct cpufreq_policy_data *policy_data)
 {
-	cpufreq_verify_within_cpu_limits(policy);
+	if (policy_data->min == FREQ_QOS_MIN_DEFAULT_VALUE) {
+		struct cpufreq_policy *policy __free(put_cpufreq_policy) =
+					      cpufreq_cpu_get(policy_data->cpu);
+		struct cppc_cpudata *cpu_data;
+
+		if (!policy)
+			return -EINVAL;
+
+		cpu_data = policy->driver_data;
+		policy_data->min = cppc_perf_to_khz(&cpu_data->perf_caps,
+			cpu_data->perf_caps.lowest_nonlinear_perf);
+	}
+
+	cpufreq_verify_within_cpu_limits(policy_data);
+
 	return 0;
 }
 
-- 
2.33.0


