Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420B440350E
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349291AbhIHHPi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 03:15:38 -0400
Received: from mx20.baidu.com ([111.202.115.85]:60866 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348919AbhIHHPh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 03:15:37 -0400
Received: from BC-Mail-Ex20.internal.baidu.com (unknown [172.31.51.14])
        by Forcepoint Email with ESMTPS id 09C5F97CD86EBF3CC402;
        Wed,  8 Sep 2021 15:14:28 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex20.internal.baidu.com (172.31.51.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 15:14:27 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 15:14:27 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-pm@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] soc: bcm63xx-power: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 15:14:16 +0800
Message-ID: <20210908071417.494-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908071417.494-1-caihuoqing@baidu.com>
References: <20210908071417.494-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/soc/bcm/bcm63xx/bcm63xx-power.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/bcm/bcm63xx/bcm63xx-power.c b/drivers/soc/bcm/bcm63xx/bcm63xx-power.c
index 515fe182dc34..aa72e13d5d0e 100644
--- a/drivers/soc/bcm/bcm63xx/bcm63xx-power.c
+++ b/drivers/soc/bcm/bcm63xx/bcm63xx-power.c
@@ -91,7 +91,6 @@ static int bcm63xx_power_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct resource *res;
 	const struct bcm63xx_power_data *entry, *table;
 	struct bcm63xx_power *power;
 	unsigned int ndom;
@@ -102,8 +101,7 @@ static int bcm63xx_power_probe(struct platform_device *pdev)
 	if (!power)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	power->base = devm_ioremap_resource(&pdev->dev, res);
+	power->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(power->base))
 		return PTR_ERR(power->base);
 
-- 
2.25.1

