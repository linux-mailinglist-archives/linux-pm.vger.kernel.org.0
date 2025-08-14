Return-Path: <linux-pm+bounces-32370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71334B25D91
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 09:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6952B61F70
	for <lists+linux-pm@lfdr.de>; Thu, 14 Aug 2025 07:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14809268C40;
	Thu, 14 Aug 2025 07:29:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E425D1E5;
	Thu, 14 Aug 2025 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156567; cv=none; b=igTwGpUnNv6p+3O4KYGDl4x4FLcKC57oJ/UDkPTEIyrpr6KQABXDwF4dSdg3Iuyli2PIgn4h3ddt2IzQwzDWGb0Gailz52XgqmH2QjP62tDm5xEOFXnGudZzDOIohNkpWsTgJ9poVGbalIhiKvwswljaaWvAUSk5/fHloSqmhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156567; c=relaxed/simple;
	bh=YKlfA2kI1t7LleRS1MTQtANevuawktIsdGIZOeMvcRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VE83hZNv5XjcMj9qV8b28H5uVLd3lIAfIOVzUxdGM+6tdXeX5y5o1QpWpd1qw7Avj8AnqCftcJ7opXi06Bf935moxZCU9H42m1MYuOp43F4VaGW/Jy06PNQS/j3JeSS8vqVowojo8gJRao+mWVyjIEp4Y63chQ8j4ZJ31pfW/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c2cKf4V59ztTLn;
	Thu, 14 Aug 2025 15:28:22 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FF37140275;
	Thu, 14 Aug 2025 15:29:22 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 15:29:21 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <beata.michalska@arm.com>, <sudeep.holla@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <vincent.guittot@linaro.org>,
	<yangyicong@hisilicon.com>, <zhanjie9@hisilicon.com>, <lihuisong@huawei.com>,
	<yubowen8@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [PATCH v4 2/3] cpufreq: Add a new function to get cpufreq policy without checking if the CPU is online
Date: Thu, 14 Aug 2025 15:28:52 +0800
Message-ID: <20250814072853.3426386-3-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250814072853.3426386-1-zhenglifeng1@huawei.com>
References: <20250814072853.3426386-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh100008.china.huawei.com (7.202.181.93)

cpufreq_cpu_get_raw() gets cpufreq policy only if the CPU is in
policy->cpus mask, which means the CPU is already online. But in some
cases, the policy is needed before the CPU is added to cpus mask. Add a
function to get the policy in these cases.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 6 ++++++
 include/linux/cpufreq.h   | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fc7eace8b65b..78ca68ea754d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -198,6 +198,12 @@ struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_get_raw);
 
+struct cpufreq_policy *cpufreq_cpu_policy(unsigned int cpu)
+{
+	return per_cpu(cpufreq_cpu_data, cpu);
+}
+EXPORT_SYMBOL_GPL(cpufreq_cpu_policy);
+
 unsigned int cpufreq_generic_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 95f3807c8c55..f135edeef925 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -205,6 +205,7 @@ struct cpufreq_freqs {
 
 #ifdef CONFIG_CPU_FREQ
 struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
+struct cpufreq_policy *cpufreq_cpu_policy(unsigned int cpu);
 struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);
 void cpufreq_cpu_put(struct cpufreq_policy *policy);
 #else
-- 
2.33.0


