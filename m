Return-Path: <linux-pm+bounces-14547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C78A97E4BD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 04:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E9FB20804
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 02:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFCE391;
	Mon, 23 Sep 2024 02:02:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED37A184
	for <linux-pm@vger.kernel.org>; Mon, 23 Sep 2024 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727056963; cv=none; b=qvHVnUlVpJjPKkUh538Uv70vaAUFMVLRntLNdWeP0g0D6gxyAhXwyje7KKgRP3EeNdcSyyusA5kr1nTr8ELIufdqBSNb7WnrjSqPtH5kS6t2K7/W/GQrMiVUDld/bc8cSENwX9TAX5snLMXLLdWqLvPc6SYFE4gw7YvCcxpMpjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727056963; c=relaxed/simple;
	bh=U9yNyutIQF5EZuE2z0zL+zWFUbgAMqNrfaJZdnxzyi4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWDlE81HnqDdwM9ajixnUsfoSo0SJT+UEuxdnY8N/5hMV1V8saWTaAER5SQpAQ+EKspz0zztW52yyyEcJ+5oBZoxd+CLJft/1JY0kSf6t0NGW0UIa1BlP7LQ268fAjxCdolBKQsqFa/AOSe0f51Rd7wBJkDipTZl9US/OPKoXbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XBmSh18Y4zySGL;
	Mon, 23 Sep 2024 10:01:40 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C0F7180087;
	Mon, 23 Sep 2024 10:02:38 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 23 Sep
 2024 10:02:37 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
	<ulf.hansson@linaro.or>, <linux-pm@vger.kernel.org>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH v2 2/2] pmdomain: ti-sci: Use scope based of_node_put() to simplify code.
Date: Mon, 23 Sep 2024 09:48:25 +0800
Message-ID: <20240923014825.85176-3-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240923014825.85176-1-zhangzekun11@huawei.com>
References: <20240923014825.85176-1-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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


