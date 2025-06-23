Return-Path: <linux-pm+bounces-29337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B33AE4495
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6592D443F4C
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 13:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978A32571A5;
	Mon, 23 Jun 2025 13:34:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298A25486D;
	Mon, 23 Jun 2025 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685655; cv=none; b=LjD4jmHtyvmr3OG70CZljpHuofwfQhRxvchUHpONHnQT9nZqwGryoIyiL0HBFGjSYhrTQ1FAKh/c0E0T9IUsO2xWUh4svVKUuMlxUcoRPExZVlRB16I/Yh7bNkw4TBITpckB31H95cl6ZIRdjvtdndlJKDSpEvucuSdywolLZPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685655; c=relaxed/simple;
	bh=I4j90nIvS+36ELpcNLDkF27lo+PEoOZZJOU0bx2PPJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7cdbWbTayNpcSgatHapuKgl0NflVQRZp/KiI6K3WrYgidycW1OS2OD+G7q+5Xu1Rag24P899pQ8tjMaPCwEXHrM62E0BaebYvEPGWlrxUkI1LJanUy2SK7Ct0VEajBM8220py34y3sD+SHK1PZ4AfdaUP8Q8y7DVfWxjxsZyW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bQprv0fwyz1W3Rl;
	Mon, 23 Jun 2025 21:31:43 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2634D1A0188;
	Mon, 23 Jun 2025 21:34:10 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 21:34:09 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhenglifeng1@huawei.com>
Subject: [PATCH 5/7] cpufreq: Move the check of cpufreq_driver->get into cpufreq_verify_current_freq()
Date: Mon, 23 Jun 2025 21:34:00 +0800
Message-ID: <20250623133402.3120230-6-zhenglifeng1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com>
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

Move the check of cpufreq_driver->get into cpufreq_verify_current_freq() in
case of calling it without check.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c4891bf5dc84..9b2578b905a5 100644
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


