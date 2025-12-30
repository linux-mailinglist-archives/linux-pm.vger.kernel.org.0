Return-Path: <linux-pm+bounces-40026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CA2CE8F57
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 09:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EA7D300B91E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 08:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB4E3009EC;
	Tue, 30 Dec 2025 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aE3iYEWs"
X-Original-To: linux-pm@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3011A2C11
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767081709; cv=none; b=cMhPh/kkdh3/iBmQ/e5xmVr7RkN5x3EIaSL3aupwr77VDAThiSK1y2DJLHGjMTzWTt6Zm3xRc7aDWao3iBu9Gc+7MyvF4AclNOB+asEuYa+Ds2VANxF1aIGGLWCIWU8r3BwUD2af7jzluTbuYpSIH6mjqp0mRuatJrO26waUsNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767081709; c=relaxed/simple;
	bh=uxfP11+MZU+vIESyhkyEfqi8TUP1Fu/y4zFC+xWUMW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWPnHcui3ctjIPy1OkHanxfXRGYip00ihhBTPY8SZsMMGMi6StAihhm/OV0SgQgCEqFurkXPxxiDJZDSrcHuFJQqR4Q3+pMYzLYOVGuz4eOyoxSfct+spPICEIBFQt64iyzJ/8+pTEF8HA136SoNlOqR5Z+YfVOEQUVX3BIkEi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aE3iYEWs; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EiRo2myiYsGL0vC800AcJnG0E+P5nDcFnXM7nhjgx8w=;
	b=aE3iYEWsrukDJdHTsm5F3U0BG0CkscDR8AvH4B49og8XDkOE7aGwkBvwkz8mJ88Z6/h/4gUIG
	VjvwINobaXvtz7pizwuxHJTicsk3T95b41UscyGbHz0XYp+ha3jNyCD8oqYhSzGZvADwd3X+fR4
	Q67H5sXrRNUTxnlxDYsQ/Zk=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dgQSl40bvzLlSy;
	Tue, 30 Dec 2025 15:58:31 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 6CD97402AB;
	Tue, 30 Dec 2025 16:01:41 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemf200001.china.huawei.com (7.202.181.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Dec 2025 16:01:40 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <sudeep.holla@arm.com>,
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>, <beata.michalska@arm.com>,
	<ionela.voinescu@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<vincent.guittot@linaro.org>, <zhanjie9@hisilicon.com>,
	<lihuisong@huawei.com>, <yubowen8@huawei.com>, <zhangpengjie2@huawei.com>,
	<wangzhi12@huawei.com>, <linhongye@h-partners.com>, <zhenglifeng1@huawei.com>
Subject: [REPOST PATCH v6 2/3] cpufreq: Add new helper function returning cpufreq policy
Date: Tue, 30 Dec 2025 16:01:14 +0800
Message-ID: <20251230080115.2120612-3-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251230080115.2120612-1-zhenglifeng1@huawei.com>
References: <20251230080115.2120612-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200001.china.huawei.com (7.202.181.227)

cpufreq_cpu_get_raw() gets cpufreq policy only if the CPU is in
policy->cpus mask, which means the CPU is already online. But in some
cases, the policy is needed before the CPU is added to cpus mask. Add a
function to get the policy in these cases.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/cpufreq/cpufreq.c | 6 ++++++
 include/linux/cpufreq.h   | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50dde2980f1b..a7a69f4d7675 100644
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
index 0465d1e6f72a..cc894fc38971 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -203,6 +203,7 @@ struct cpufreq_freqs {
 
 #ifdef CONFIG_CPU_FREQ
 struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu);
+struct cpufreq_policy *cpufreq_cpu_policy(unsigned int cpu);
 struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);
 void cpufreq_cpu_put(struct cpufreq_policy *policy);
 #else
@@ -210,6 +211,10 @@ static inline struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu)
 {
 	return NULL;
 }
+static inline struct cpufreq_policy *cpufreq_cpu_policy(unsigned int cpu)
+{
+	return NULL;
+}
 static inline struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 {
 	return NULL;
-- 
2.33.0


