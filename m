Return-Path: <linux-pm+bounces-30446-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075DFAFE62B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 12:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C33561942
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 10:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C72957C1;
	Wed,  9 Jul 2025 10:42:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE4228DF0F;
	Wed,  9 Jul 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057721; cv=none; b=jPDx4E6HhpV7TRk8JtxcCD1nc9omHUr3VERBnPCzzIfUTTRg5Ehc1VLX4ILG8kGGPplsINY6hX+2dKcAbWVvWr5itZ/u73kY/eK+6pG0JTTcHW0j8KEnBpzq7yHipIKcZUM0IEkMIqngKL+C0SCLfJyjoqB7ZNYJblXA33Uo8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057721; c=relaxed/simple;
	bh=1H+J8U5h8cpezyFExfmPP9y/qJdNuO+Eu5DsumkDTE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWqmrF6wWDRU1KDrf9H38RCTQezIox2reEBS0rBcLBecqrnO2FA7iaA3XhqARnUDZydnCaIE2PEl4OWXwUv9vUh16nY3Rl/0Eip4VplCS8ALV8Yl9ML5iRl2kkusdIArhIYfHXwCozQjzUgHnr2XKCgtp4iN7t4lW0z7weP00xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bcZLl2rx0z16TJ2;
	Wed,  9 Jul 2025 18:42:55 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id A65B5140276;
	Wed,  9 Jul 2025 18:41:57 +0800 (CST)
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
Subject: [PATCH v2 1/4] cpufreq: Move cpufreq-based invariance initialization to where all other initializations have been successfully done in cpufreq_register_driver()
Date: Wed, 9 Jul 2025 18:41:42 +0800
Message-ID: <20250709104145.2348017-2-zhenglifeng1@huawei.com>
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

The cpufreq-based invariance is enabled in cpufreq_register_driver(), but
never disabled after registration fails. Move the invariance initialization
to where all other initializations have been successfully done to solve
this problem.

Fixes: 874f63531064 ("cpufreq: report whether cpufreq supports Frequency Invariance (FI)")
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6ea39181e832..eb713d116c34 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2940,15 +2940,6 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	cpufreq_driver = driver_data;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	/*
-	 * Mark support for the scheduler's frequency invariance engine for
-	 * drivers that implement target(), target_index() or fast_switch().
-	 */
-	if (!cpufreq_driver->setpolicy) {
-		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
-		pr_debug("supports frequency invariance");
-	}
-
 	if (driver_data->setpolicy)
 		driver_data->flags |= CPUFREQ_CONST_LOOPS;
 
@@ -2979,6 +2970,15 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	hp_online = ret;
 	ret = 0;
 
+	/*
+	 * Mark support for the scheduler's frequency invariance engine for
+	 * drivers that implement target(), target_index() or fast_switch().
+	 */
+	if (!cpufreq_driver->setpolicy) {
+		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
+		pr_debug("supports frequency invariance");
+	}
+
 	pr_debug("driver %s up and running\n", driver_data->name);
 	goto out;
 
-- 
2.33.0


