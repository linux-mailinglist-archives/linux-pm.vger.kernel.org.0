Return-Path: <linux-pm+bounces-20608-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDB7A14D53
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 11:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2331C7A13C0
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 10:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5503B1FC7D8;
	Fri, 17 Jan 2025 10:15:05 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2781F8905;
	Fri, 17 Jan 2025 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737108905; cv=none; b=VDlQFv4UjYaz/fWXb5KukxtUxcOq9AorP8/KsnQAkCS55WtlZPb30GvYpJiDLt48EHHNUMEQVR1qrhhLVmrlX/j7vb1CIR2Cctm85b79CUBzjKYeW5dez+BFNUWsY4+csQlf+pS6URAlXrRrLrKomNgJBZr5VYBGPLke2Ixt/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737108905; c=relaxed/simple;
	bh=LoqxX1ES3YlmPAaT44/WLkSGKgYTJ7BOoyv5Nh9KMZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDZ/BuGmZ0ti3gYg+3kmtKEMEEbtMXtTRk6kavCqM2bfnRWhURU4BoBUR+E7EDslS5QrhJa+0r+KcUElxvIbnuDfGb4BvjIk1/cYudXkOFbscDyxOml8WwIn80KO3CIpPQJuPCqUoy4tgCswz4uJ1mjbVE81dL5plLztc93ml0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YZFrq3DRDzbnsr;
	Fri, 17 Jan 2025 18:11:55 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id EA0F8180217;
	Fri, 17 Jan 2025 18:14:59 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Jan 2025 18:14:59 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <zhenglifeng1@huawei.com>,
	<fanghao11@huawei.com>
Subject: [PATCH v2 3/4] cpufreq: CPPC: Fix wrong max_freq in policy initialization
Date: Fri, 17 Jan 2025 18:14:56 +0800
Message-ID: <20250117101457.1530653-4-zhenglifeng1@huawei.com>
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

In policy initialization, policy->max and policy->cpuinfo.max_freq always
set to the value calculated from caps->nominal_perf. This will cause the
frequency stay on base frequency even if the policy is already boosted when
a CPU is going online. Fix this by using policy->boost_enabled to determine
which value should be set.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bd8f75accfa0..7fa89b601d2a 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -611,7 +611,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
 	 */
 	policy->min = cppc_perf_to_khz(caps, caps->lowest_nonlinear_perf);
-	policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
+	policy->max = cppc_perf_to_khz(caps, policy->boost_enabled ?
+						caps->highest_perf : caps->nominal_perf);
 
 	/*
 	 * Set cpuinfo.min_freq to Lowest to make the full range of performance
@@ -619,7 +620,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * nonlinear perf
 	 */
 	policy->cpuinfo.min_freq = cppc_perf_to_khz(caps, caps->lowest_perf);
-	policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
+	policy->cpuinfo.max_freq = policy->max;
 
 	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
 	policy->shared_type = cpu_data->shared_type;
-- 
2.33.0


