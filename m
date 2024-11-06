Return-Path: <linux-pm+bounces-17041-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312839BDB05
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 02:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D416D1F232F0
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 01:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BFF17F4F6;
	Wed,  6 Nov 2024 01:13:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F017E015;
	Wed,  6 Nov 2024 01:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855591; cv=none; b=jRx7f00PUO1uz6aUrqk2aMiDBfKc45fWJ8eBPYEzZwjypAQ1U4iKSHU7JJqaf6RbCMEXH5OvsViaDNIwGfecc1AoajEAFUnu9owteSPoEo0FMPLg6/q0xYPGOQmliL9qGTmDu/E0r5MmOVMH6HtZoMhhBlQyG+qsfTi4P7VLdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855591; c=relaxed/simple;
	bh=ikL5huFq2NOcJ6EBTw42nabn5i/Xih/2D+cLnu6GtcU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QcuZkHDPS3No6ll/ZvCFz31yH83vVXjPJX70c3+kH7eIJhsBmJuSZR67RgHzJV9t6H0L9s2XbCiukFg2/smQzENxAMuhBvKsbEPBu3caVLUZru8SrIigP/9LK91S3lMVHQqeq6OGEjXN/tnPVm3ztUpSvF0Oje84Vg5wXAKcSYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XjnFd2ds4z1T7vQ;
	Wed,  6 Nov 2024 09:10:45 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id C869D140155;
	Wed,  6 Nov 2024 09:13:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 6 Nov
 2024 09:13:04 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <qperret@google.com>, <ruanjinjie@huawei.com>
Subject: [PATCH -next] cpufreq: CPPC: Fix wrong return value in cppc_get_cpu_cost()
Date: Wed, 6 Nov 2024 09:12:38 +0800
Message-ID: <20241106011238.2407104-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)

cppc_get_cpu_cost() return 0 if the policy is NULL. Then in
em_compute_costs(), the later zero check for cost is not valid
as cost is uninitialized. As Quentin pointed out, kernel energy model
core check the return value of get_cost() first, so if the callback
failed it should tell the core. Return -EINVAL to fix it.

Fixes: 1a1374bb8c59 ("cpufreq: CPPC: Fix possible null-ptr-deref for cppc_get_cpu_cost()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/c4765377-7830-44c2-84fa-706b6e304e10@stanley.mountain/
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Quentin Perret <qperret@google.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index aa5dd194fc5b..cdc569cf7743 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -475,7 +475,7 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
 
 	policy = cpufreq_cpu_get_raw(cpu_dev->id);
 	if (!policy)
-		return 0;
+		return -EINVAL;
 
 	cpu_data = policy->driver_data;
 	perf_caps = &cpu_data->perf_caps;
-- 
2.34.1


