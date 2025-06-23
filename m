Return-Path: <linux-pm+bounces-29336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 898C3AE448D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7763B95F9
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3080B2566DF;
	Mon, 23 Jun 2025 13:34:15 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37ECA253F30;
	Mon, 23 Jun 2025 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685655; cv=none; b=EdyGR2v/PhWKVvmgUEj8mRD9eI6ULsvoKUBLAB8O5DHLRka6XmS3h63hvcEL8qXh74Wnh6uUMLHhUXwTjuS9tAaW/hIyfcq0DJjl8A5AAzaUpJerLShQX63zBClYhJSElBz4MWpaJ67SS4BY4ukrGIPxC7I9K9aMHr6kR3qhyjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685655; c=relaxed/simple;
	bh=joFxsYCC6faUzY7yWeUR1R4xjeuO+x1xGhAFHeU9a+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pq/1eehk6pmg4VEQnrqKiw6aQH28q18Fa058OHZAsGInePhPsRH3unTh9ZKupADZAmaCTnnEN8qmV33c7yKbgFZr9iesTl82fXjztrPQA0Ni0/ChWSi+S1zclEPJWh/oDtGiVr6ZLSdqLYTkvXPfz4WXrdislrjYgGtbT5YL+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bQppN0Mshz10XJ2;
	Mon, 23 Jun 2025 21:29:32 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 8912514027D;
	Mon, 23 Jun 2025 21:34:08 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemh100008.china.huawei.com (7.202.181.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 21:34:07 +0800
From: Lifeng Zheng <zhenglifeng1@huawei.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>,
	<zhenglifeng1@huawei.com>
Subject: [PATCH 1/7] cpufreq: Disable cpufreq-based invariance when fail to register driver
Date: Mon, 23 Jun 2025 21:33:56 +0800
Message-ID: <20250623133402.3120230-2-zhenglifeng1@huawei.com>
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

The cpufreq-based invariance is enabled in cpufreq_register_driver(), but
never disabled after that when fail. Add a
static_branch_disable_cpuslocked() to do that as
cpufreq_unregister_driver() does.

Fixes: 874f63531064 ("cpufreq: report whether cpufreq supports Frequency Invariance (FI)")
Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d7426e1d8bdd..1bc665b5bba8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2991,6 +2991,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 err_boost_unreg:
 	remove_boost_sysfs_file();
 err_null_driver:
+	static_branch_disable_cpuslocked(&cpufreq_freq_invariance);
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver = NULL;
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
-- 
2.33.0


