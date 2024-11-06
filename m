Return-Path: <linux-pm+bounces-17040-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DDA9BDAD2
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 02:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5E41C22EBF
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2024 01:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F3717E015;
	Wed,  6 Nov 2024 01:01:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4673C17F4F2;
	Wed,  6 Nov 2024 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854901; cv=none; b=e8h+NZsovPYtsclINBkpuA3zVWaVD+IcGvz2ebXeuYpDVp0tdDhnQdy6JoraZ5eljTuU4YcV5Ybli2GhkTvkQlHIfZJ/rQibScn/E0dSG+SydK+GoOTTU5uXnIYvbTM2DLVx22XxQvrbkW9zVHWbl4j0eKqW3a2/gh8lOCPz1ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854901; c=relaxed/simple;
	bh=1t9TMw2SgXI7sUlPyzY+L1hKWpWbHsOM8itTqn1tf8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CxOCQLLZumn7qruFvpymYJTdA3DApGueqPIiP0WcxUwQC6bebjWxX7RC/0SiScJHnCywmuxKVuLlz3qUs3zFnxwfRfqKk53z9RBlVbNZTdXog3ezC2g4Yp0pedY87wcZoHAtflqejVO1XetphuyRHue0T/Arh3LQz1vHKyT7+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xjn013rd9zfdcs;
	Wed,  6 Nov 2024 08:58:57 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 385DE18007C;
	Wed,  6 Nov 2024 09:01:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 6 Nov
 2024 09:01:33 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ruanjinjie@huawei.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <qperret@google.com>
Subject: [PATCH -next] cpufreq: CPPC: Fix wrong return value in cppc_get_cpu_power()
Date: Wed, 6 Nov 2024 09:01:11 +0800
Message-ID: <20241106010111.2404387-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200008.china.huawei.com (7.202.181.35)

cppc_get_cpu_power() return 0 if the policy is NULL. Then in
em_create_perf_table(), the later zero check for power is not valid
as power is uninitialized. As Quentin pointed out, kernel energy model
core check the return value of active_power() first, so if the callback
failed it should tell the core. So return -EINVAL to fix it.

Fixes: a78e72075642 ("cpufreq: CPPC: Fix possible null-ptr-deref for cpufreq_cpu_get_raw()")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Quentin Perret <qperret@google.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index cdc569cf7743..bd8f75accfa0 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -405,7 +405,7 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
 
 	policy = cpufreq_cpu_get_raw(cpu_dev->id);
 	if (!policy)
-		return 0;
+		return -EINVAL;
 
 	cpu_data = policy->driver_data;
 	perf_caps = &cpu_data->perf_caps;
-- 
2.34.1


