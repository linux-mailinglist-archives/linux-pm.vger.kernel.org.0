Return-Path: <linux-pm+bounces-17012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E31349BC3C5
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 04:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208A41C20DA0
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2024 03:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACB8183CC7;
	Tue,  5 Nov 2024 03:21:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C417E8E2;
	Tue,  5 Nov 2024 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730776880; cv=none; b=Kz8EZuS8OErKy1rQz0Oa2jEYcXLVIRUpJOcY6ERBqbPXyl4bGuCohJTLpmvAUCKzcZMN6d6A9s8yujNj5LMr+EGxEEcjnzRhC8xQ45OgMikH/SdwWFQIrZE+eV3qUXLuVLJf06BniZEEl/apPcT1mUwRR3Q3oCbGEGfQzoZ61+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730776880; c=relaxed/simple;
	bh=SNf6bj4IuP11IUy0pr5668iteAnZRDRRS76fMqHsNeY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pr3o2kLvV/n6JtqaLGs6DMIApcuNXZQkRIw2cUycpA1S3HPmC97UDLTRADvQP6vENT9j14+GDvR3NRosDDhHoSpicx3in/RxTXG28+d0kPNM2f2O3YKbrOxmI/FHGNUaMhKluNAuyI5lehZLMLxmTrPNHXphe6U+Hry9bzbemPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XjD5Q0JwDz1JB9H;
	Tue,  5 Nov 2024 11:16:42 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id B799D140361;
	Tue,  5 Nov 2024 11:21:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 5 Nov
 2024 11:21:16 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <chenhuacai@kernel.org>, <kernel@xen0n.name>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <zhoubinbin@loongson.cn>,
	<loongarch@lists.linux.dev>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] cpufreq: loongson3: Check error for devm_mutex_init()
Date: Tue, 5 Nov 2024 11:20:53 +0800
Message-ID: <20241105032053.1782082-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)

devm_mutex_init() may return error, and the avoidance of checking
the error code from devm_mutex_init() call diminishes the point of
using devm variant of it. Add the missed check.

Fixes: ccf51454145b ("cpufreq: Add Loongson-3 CPUFreq driver support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/cpufreq/loongson3_cpufreq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index 6b5e6798d9a2..a923e196ec86 100644
--- a/drivers/cpufreq/loongson3_cpufreq.c
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -346,8 +346,11 @@ static int loongson3_cpufreq_probe(struct platform_device *pdev)
 {
 	int i, ret;
 
-	for (i = 0; i < MAX_PACKAGES; i++)
-		devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
+	for (i = 0; i < MAX_PACKAGES; i++) {
+		ret = devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
+		if (ret)
+			return ret;
+	}
 
 	ret = do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
 	if (ret <= 0)
-- 
2.34.1


