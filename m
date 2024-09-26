Return-Path: <linux-pm+bounces-14763-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D02986AAA
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 03:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00F01C216D4
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 01:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF7E179967;
	Thu, 26 Sep 2024 01:40:17 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF41537CE
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 01:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727314817; cv=none; b=Wgvo+j4jiMMHn/EGzb0vuBDZsNR4GiqlcavcCcwhv0E3vWbPZPaEQptTjT0rQEhnmFUvvdTe3IhdHCc5FfOPhCtcYuydLT/ckfoamgC0kMix/QI/x29STEZLjSPO32dEZ9IshRRXF4+CqpuleQgPeWDWN/kYw4hQL5oYhYZZkwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727314817; c=relaxed/simple;
	bh=U9yNyutIQF5EZuE2z0zL+zWFUbgAMqNrfaJZdnxzyi4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1gCSF+U8mgV/OpUrOWD7A9NAHsRDC8Mjy5mLUFp3CuxOpd0Mz/RMDJT1VU9yeNeqByvBhsaBL8RTduBD8Xle1jl18hVs469W84hLhwojYOXsTrt6LWtq6E1F92Wsgvpvgf2/C8rTnjHBUf9csjJ3vzPohvWBuUvifbLEYN4c/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XDbqZ2bJQz1SBt6;
	Thu, 26 Sep 2024 09:39:22 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 16DC21400D5;
	Thu, 26 Sep 2024 09:40:11 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Sep
 2024 09:40:10 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
	<ulf.hansson@linaro.org>, <linux-pm@vger.kernel.org>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [RESEND PATCH v2 2/2] pmdomain: ti-sci: Use scope based of_node_put() to simplify code.
Date: Thu, 26 Sep 2024 09:25:51 +0800
Message-ID: <20240926012551.31712-3-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240926012551.31712-1-zhangzekun11@huawei.com>
References: <20240926012551.31712-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Use scope based of_node_put() to simplify the code logic, and we don't
need to call of_node_put(). Besides, put of_parse_phandle_with_args() in
the while loop to make code more simple.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 0df3eb7ff09a..83729bc52c09 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -131,9 +131,8 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ti_sci_genpd_provider *pd_provider;
 	struct ti_sci_pm_domain *pd;
-	struct device_node *np;
+	struct device_node *np __free(device_node) = NULL;
 	struct of_phandle_args args;
-	int ret;
 	u32 max_id = 0;
 	int index;
 
@@ -153,12 +152,9 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 	for_each_node_with_property(np, "power-domains") {
 		index = 0;
 
-		while (1) {
-			ret = of_parse_phandle_with_args(np, "power-domains",
-							 "#power-domain-cells",
-							 index, &args);
-			if (ret)
-				break;
+		while (!of_parse_phandle_with_args(np, "power-domains",
+						   "#power-domain-cells",
+						   index, &args)) {
 
 			if (args.args_count >= 1 && args.np == dev->of_node) {
 				of_node_put(args.np);
@@ -172,18 +168,14 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 				}
 
 				pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
-				if (!pd) {
-					of_node_put(np);
+				if (!pd)
 					return -ENOMEM;
-				}
 
 				pd->pd.name = devm_kasprintf(dev, GFP_KERNEL,
 							     "pd:%d",
 							     args.args[0]);
-				if (!pd->pd.name) {
-					of_node_put(np);
+				if (!pd->pd.name)
 					return -ENOMEM;
-				}
 
 				pd->pd.power_off = ti_sci_pd_power_off;
 				pd->pd.power_on = ti_sci_pd_power_on;
-- 
2.17.1


