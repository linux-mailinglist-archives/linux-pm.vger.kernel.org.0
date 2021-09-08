Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA534035D4
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 10:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347922AbhIHIDv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 04:03:51 -0400
Received: from mx21.baidu.com ([220.181.3.85]:56512 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235106AbhIHIDs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 04:03:48 -0400
Received: from BC-Mail-EX08.internal.baidu.com (unknown [172.31.51.48])
        by Forcepoint Email with ESMTPS id 4D62C717629375A3B364;
        Wed,  8 Sep 2021 16:02:32 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-EX08.internal.baidu.com (172.31.51.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 16:02:32 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 16:02:31 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Niklas Cassel <nks@flawful.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/6] soc: qcom_gsbi: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 16:02:15 +0800
Message-ID: <20210908080216.1301-5-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908080216.1301-1-caihuoqing@baidu.com>
References: <20210908080216.1301-1-caihuoqing@baidu.com>
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

 drivers/soc/qcom/qcom_gsbi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/qcom_gsbi.c b/drivers/soc/qcom/qcom_gsbi.c
index 304afc223a58..290bdefbf28a 100644
--- a/drivers/soc/qcom/qcom_gsbi.c
+++ b/drivers/soc/qcom/qcom_gsbi.c
@@ -127,7 +127,6 @@ static int gsbi_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *tcsr_node;
 	const struct of_device_id *match;
-	struct resource *res;
 	void __iomem *base;
 	struct gsbi_info *gsbi;
 	int i, ret;
@@ -139,8 +138,7 @@ static int gsbi_probe(struct platform_device *pdev)
 	if (!gsbi)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.25.1

