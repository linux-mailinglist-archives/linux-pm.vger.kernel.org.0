Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA0D4035AB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 09:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351076AbhIHHsc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 03:48:32 -0400
Received: from mx21.baidu.com ([220.181.3.85]:39770 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350866AbhIHHsP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 03:48:15 -0400
Received: from BC-Mail-Ex29.internal.baidu.com (unknown [172.31.51.23])
        by Forcepoint Email with ESMTPS id 66B6284F64A0AA0F179C;
        Wed,  8 Sep 2021 15:47:06 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex29.internal.baidu.com (172.31.51.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 15:47:05 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:47:05 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Niklas Cassel <nks@flawful.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/6] soc: qcom: rpmh-rsc: Make use of the helper function devm_platform_ioremap_resource_byname()
Date:   Wed, 8 Sep 2021 15:46:51 +0800
Message-ID: <20210908074651.1025-4-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908074651.1025-1-caihuoqing@baidu.com>
References: <20210908074651.1025-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex09.internal.baidu.com (172.31.51.49) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the devm_platform_ioremap_resource_byname() helper instead of
calling platform_get_resource_byname() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: Fix typo 'dri_id'->'drv_id'
 drivers/soc/qcom/rpmh-rsc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index e749a2b285d8..2834c6efc16b 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -910,7 +910,6 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 {
 	struct device_node *dn = pdev->dev.of_node;
 	struct rsc_drv *drv;
-	struct resource *res;
 	char drv_id[10] = {0};
 	int ret, irq;
 	u32 solver_config;
@@ -941,8 +940,7 @@ static int rpmh_rsc_probe(struct platform_device *pdev)
 		drv->name = dev_name(&pdev->dev);
 
 	snprintf(drv_id, ARRAY_SIZE(drv_id), "drv-%d", drv->id);
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, drv_id);
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource_byname(pdev, drv_id);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.25.1

