Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB4C4035D0
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 10:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347769AbhIHIDk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 04:03:40 -0400
Received: from mx21.baidu.com ([220.181.3.85]:56242 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234163AbhIHIDf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 04:03:35 -0400
Received: from BC-Mail-Ex06.internal.baidu.com (unknown [172.31.51.46])
        by Forcepoint Email with ESMTPS id 02EF1479C868322207E6;
        Wed,  8 Sep 2021 16:02:24 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex06.internal.baidu.com (172.31.51.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 16:02:23 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 16:02:23 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Niklas Cassel <nks@flawful.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/6] PM: AVS: qcom-cpr: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 16:02:11 +0800
Message-ID: <20210908080216.1301-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex11.internal.baidu.com (172.31.51.51) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: [PATCH 6/6] Fix typo 'dri_id'->'drv_id'
v2->v3: Just send it as a series

 drivers/soc/qcom/cpr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/cpr.c b/drivers/soc/qcom/cpr.c
index 4ce8e816154f..1d818a8ba208 100644
--- a/drivers/soc/qcom/cpr.c
+++ b/drivers/soc/qcom/cpr.c
@@ -1614,7 +1614,6 @@ static void cpr_debugfs_init(struct cpr_drv *drv)
 
 static int cpr_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	struct cpr_drv *drv;
 	int irq, ret;
@@ -1648,8 +1647,7 @@ static int cpr_probe(struct platform_device *pdev)
 	if (IS_ERR(drv->tcsr))
 		return PTR_ERR(drv->tcsr);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	drv->base = devm_ioremap_resource(dev, res);
+	drv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(drv->base))
 		return PTR_ERR(drv->base);
 
-- 
2.25.1

