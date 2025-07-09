Return-Path: <linux-pm+bounces-30447-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ACBAFE630
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 12:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863DB547CE2
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBA12980A5;
	Wed,  9 Jul 2025 10:42:03 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11272951BA;
	Wed,  9 Jul 2025 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057723; cv=none; b=ow3jkI2Ao632SZwTe++FIVbPrkiRsJiupyqdWHUiTUB9Jff2Pb4LDWI3sli7T82SZb4d1uR9jLKPRqS7D1GU71ntyvsIKDdhxjFWpUCdOSka+qbQA3Ci9nDeEjhiX3i5ZDLPAHBJCiK0hx5QL7W5xPzncd3WQX774lIwGe56fAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057723; c=relaxed/simple;
	bh=Q8dzJtRwoGAms35MU2OrgpE4DVsdeE9HVSREh7i9vI4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFAUpyY0r1DDzNp1/6cpIrYk8dDUYUM1RAqLbtvFad4zyZkaugji4PkXHtOmUFHjiwzGpZ41I+/tYkXsi8MACm13WJXpDA0EXABUEciburQHE//BWoVSv3Zz9FXy4oJW/qtwCEiZQKaKEHSEq3HK7gB4gsRmxOQhfzhd4lem0m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bcZJN09rzztSmc;
	Wed,  9 Jul 2025 18:40:52 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 885D2180B64;
	Wed,  9 Jul 2025 18:41:58 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 18:41:57 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhenglifeng1@huawei.com>
Subject: [PATCH v2 3/4] cpufreq: Move the check of cpufreq_driver->get into cpufreq_verify_current_freq()
Date: Wed, 9 Jul 2025 18:41:44 +0800
Message-ID: <20250709104145.2348017-4-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250709104145.2348017-1-zhenglifeng1@huawei.com>
References: <20250709104145.2348017-1-zhenglifeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Move the check of cpufreq_driver->get into cpufreq_verify_current_freq() in
case of calling it without check.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2175d2df95b6..84f175a55fc5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1800,6 +1800,9 @@ static unsigned int cpufreq_verify_current_freq(struct cpufreq_policy *policy, b
 {
 	unsigned int new_freq;
 
+	if (!cpufreq_driver->get)
+		return 0;
+
 	new_freq = cpufreq_driver->get(policy->cpu);
 	if (!new_freq)
 		return 0;
@@ -1922,10 +1925,7 @@ unsigned int cpufreq_get(unsigned int cpu)
 
 	guard(cpufreq_policy_read)(policy);
 
-	if (cpufreq_driver->get)
-		return __cpufreq_get(policy);
-
-	return 0;
+	return __cpufreq_get(policy);
 }
 EXPORT_SYMBOL(cpufreq_get);
 
@@ -2479,8 +2479,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
 
-	if (cpufreq_driver->get)
-		cpufreq_verify_current_freq(policy, false);
+	cpufreq_verify_current_freq(policy, false);
 
 	if (policy->governor->start) {
 		ret = policy->governor->start(policy);
-- 
2.33.0


