Return-Path: <linux-pm+bounces-29333-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543FFAE4430
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2EC162C1D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F7D2550CF;
	Mon, 23 Jun 2025 13:34:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F9252903;
	Mon, 23 Jun 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685654; cv=none; b=DXKmKhctZKJBC+FW5Ha/sNJK3goNoBggzaPAwmIarji1Ma0tTAAZ/T2cfnSXpaaaAhRSAUhB179kW6xmsxM2meMVip+GNQgsMNpHHVEA1dHT7G0AS5SrOPPNNAfVKw21n/k0hf7h0VvhsdIdzPPK8io4k950dDGK3+Hh2z8MmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685654; c=relaxed/simple;
	bh=l/KiLKDUrKKoN6SbfCY3rO8y/+cn3dSOneFbm10HWCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMDsU8BqPiGrZYDKHEmo274J0WFHe3suZruAR4W7k9j4kDDvIbQoBOJv8xeB0UXckiQeoIwliApW1L/GhPxKntLPvkb5VSMIWZwiO59tUhuHXlprb5LHfStrtr7/Z9CbSbwtSaheM5VLaHU42kx/hqdsCkADsk1wTdZl3f802xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bQptP1VZlztSfF;
	Mon, 23 Jun 2025 21:33:01 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AB5218006C;
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
Subject: [PATCH 6/7] cpufreq: Refactor code about starting governor in cpufreq_set_policy()
Date: Mon, 23 Jun 2025 21:34:01 +0800
Message-ID: <20250623133402.3120230-7-zhenglifeng1@huawei.com>
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

Refactor code about starting governor without functional change in
cpufreq_set_policy() to make it more readable.

Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9b2578b905a5..7b82ffb50283 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2698,15 +2698,19 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	/* start new governor */
 	policy->governor = new_gov;
 	ret = cpufreq_init_governor(policy);
-	if (!ret) {
-		ret = cpufreq_start_governor(policy);
-		if (!ret) {
-			pr_debug("governor change\n");
-			return 0;
-		}
+	if (ret)
+		goto start_old_gov;
+
+	ret = cpufreq_start_governor(policy);
+	if (ret) {
 		cpufreq_exit_governor(policy);
+		goto start_old_gov;
 	}
 
+	pr_debug("governor change\n");
+	return 0;
+
+start_old_gov:
 	/* new governor failed, so re-start old one */
 	pr_debug("starting governor %s failed\n", policy->governor->name);
 	if (old_gov) {
-- 
2.33.0


