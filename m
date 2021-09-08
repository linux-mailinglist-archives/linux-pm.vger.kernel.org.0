Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04DB4035A5
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 09:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350907AbhIHHsa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 03:48:30 -0400
Received: from mx20.baidu.com ([111.202.115.85]:39710 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350882AbhIHHsO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 03:48:14 -0400
Received: from BC-Mail-Ex30.internal.baidu.com (unknown [172.31.51.24])
        by Forcepoint Email with ESMTPS id B40E8237F5AD43106F45;
        Wed,  8 Sep 2021 15:47:04 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex30.internal.baidu.com (172.31.51.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 15:47:03 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:47:03 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Niklas Cassel <nks@flawful.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/6] soc: qcom-geni-se: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 15:46:50 +0800
Message-ID: <20210908074651.1025-3-caihuoqing@baidu.com>
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

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 7d649d2cf31e..28a8c0dda66c 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -871,7 +871,6 @@ EXPORT_SYMBOL(geni_icc_disable);
 static int geni_se_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct geni_wrapper *wrapper;
 	int ret;
 
@@ -880,8 +879,7 @@ static int geni_se_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	wrapper->dev = dev;
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wrapper->base = devm_ioremap_resource(dev, res);
+	wrapper->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(wrapper->base))
 		return PTR_ERR(wrapper->base);
 
-- 
2.25.1

