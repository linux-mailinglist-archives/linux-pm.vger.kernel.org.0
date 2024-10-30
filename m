Return-Path: <linux-pm+bounces-16707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9015D9B5DC7
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 09:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540D9284570
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0DE1E1301;
	Wed, 30 Oct 2024 08:25:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CBB1E1302;
	Wed, 30 Oct 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276724; cv=none; b=t/0xFiUHmjmts+krSBq+SrRV6F8pJyVHnluHCMTSCzMov428PwxOvytBcAZNbM+iK98TA5UTWYwUUQrE4khhouOvccjMReGfqStAK76IJ9qQov+A3xwsQknaJd3aybqqB1eimv2J1goLMCOOSCv3QyljcM6h2gBsrVcQ0PTLjQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276724; c=relaxed/simple;
	bh=hLyCM5XhFjDsLAnrJbD8LQ+pkt2xuRAIzJSeR30EK1U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KqdQulP4VB9bubar51JTIbYyO2CJGScwx4wzHPG3amZH2wIrX38RkcK2TC5+oNixxjlo0AKlPud6JtBqc7XliU/9sOUK5Om8GZ9RJlUMkDkHKQTAE5AKSfc+Hl504aFMDZBKWUZr2W49wjEI39YeeSUVim6C/XCBWsKyn1sfAyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XdgBT4Qs7z1jw9K;
	Wed, 30 Oct 2024 16:23:45 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AE4F180019;
	Wed, 30 Oct 2024 16:25:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 30 Oct
 2024 16:25:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <Pierre.Gondois@arm.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] cpufreq: CPPC: Fix possible null-ptr-deref for cppc_get_cpu_cost()
Date: Wed, 30 Oct 2024 16:24:49 +0800
Message-ID: <20241030082449.2629861-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200008.china.huawei.com (7.202.181.35)

cpufreq_cpu_get_raw() may return NULL if the cpu is not in
policy->cpus cpu mask and it will cause null pointer dereference,
so check NULL for cppc_get_cpu_cost().

Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 2b8708475ac7..67fa97bbeae7 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -487,6 +487,9 @@ static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
 	int step;
 
 	policy = cpufreq_cpu_get_raw(cpu_dev->id);
+	if (!policy)
+		return 0;
+
 	cpu_data = policy->driver_data;
 	perf_caps = &cpu_data->perf_caps;
 	max_cap = arch_scale_cpu_capacity(cpu_dev->id);
-- 
2.34.1


