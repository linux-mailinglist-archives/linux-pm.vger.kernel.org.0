Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA7403503
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 09:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348316AbhIHHOp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 03:14:45 -0400
Received: from mx21.baidu.com ([220.181.3.85]:59666 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349461AbhIHHO1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 03:14:27 -0400
Received: from BC-Mail-Ex26.internal.baidu.com (unknown [172.31.51.20])
        by Forcepoint Email with ESMTPS id 1724936B923A9696DCF6;
        Wed,  8 Sep 2021 15:13:18 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex26.internal.baidu.com (172.31.51.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 8 Sep 2021 15:13:17 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:13:17 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH 1/3] soc: ti: k3-ringacc: Make use of the helper function devm_platform_ioremap_resource_byname()
Date:   Wed, 8 Sep 2021 15:13:07 +0800
Message-ID: <20210908071310.432-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/soc/ti/k3-ringacc.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 573be88f8191..0474257735f3 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -1353,7 +1353,6 @@ static int k3_ringacc_init(struct platform_device *pdev,
 	const struct soc_device_attribute *soc;
 	void __iomem *base_fifo, *base_rt;
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	int ret, i;
 
 	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
@@ -1374,24 +1373,19 @@ static int k3_ringacc_init(struct platform_device *pdev,
 		ringacc->dma_ring_reset_quirk = soc_data->dma_ring_reset_quirk;
 	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rt");
-	base_rt = devm_ioremap_resource(dev, res);
+	base_rt = devm_platform_ioremap_resource_byname(pdev, "rt");
 	if (IS_ERR(base_rt))
 		return PTR_ERR(base_rt);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "fifos");
-	base_fifo = devm_ioremap_resource(dev, res);
+	base_fifo = devm_platform_ioremap_resource_byname(pdev, "fifos");
 	if (IS_ERR(base_fifo))
 		return PTR_ERR(base_fifo);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "proxy_gcfg");
-	ringacc->proxy_gcfg = devm_ioremap_resource(dev, res);
+	ringacc->proxy_gcfg = devm_platform_ioremap_resource_byname(pdev, "proxy_gcfg");
 	if (IS_ERR(ringacc->proxy_gcfg))
 		return PTR_ERR(ringacc->proxy_gcfg);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-					   "proxy_target");
-	ringacc->proxy_target_base = devm_ioremap_resource(dev, res);
+	ringacc->proxy_target_base = devm_platform_ioremap_resource_byname(pdev, "proxy_target");
 	if (IS_ERR(ringacc->proxy_target_base))
 		return PTR_ERR(ringacc->proxy_target_base);
 
@@ -1459,7 +1453,6 @@ struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct k3_ringacc *ringacc;
 	void __iomem *base_rt;
-	struct resource *res;
 	int i;
 
 	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
@@ -1474,8 +1467,7 @@ struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
 
 	mutex_init(&ringacc->req_lock);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ringrt");
-	base_rt = devm_ioremap_resource(dev, res);
+	base_rt = devm_platform_ioremap_resource_byname(pdev, "ringrt");
 	if (IS_ERR(base_rt))
 		return ERR_CAST(base_rt);
 
-- 
2.25.1

