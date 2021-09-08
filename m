Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CF34035D6
	for <lists+linux-pm@lfdr.de>; Wed,  8 Sep 2021 10:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347928AbhIHID4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Sep 2021 04:03:56 -0400
Received: from mx21.baidu.com ([220.181.3.85]:56430 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347679AbhIHIDk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Sep 2021 04:03:40 -0400
Received: from BC-Mail-Ex03.internal.baidu.com (unknown [172.31.51.43])
        by Forcepoint Email with ESMTPS id 2A04356DD1AA7803C776;
        Wed,  8 Sep 2021 16:02:30 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex03.internal.baidu.com (172.31.51.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Wed, 8 Sep 2021 16:02:29 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 8 Sep 2021 16:02:29 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Niklas Cassel <nks@flawful.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/6] soc: qcom_aoss: Make use of the helper function devm_platform_ioremap_resource()
Date:   Wed, 8 Sep 2021 16:02:14 +0800
Message-ID: <20210908080216.1301-4-caihuoqing@baidu.com>
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

 drivers/soc/qcom/qcom_aoss.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index 536c3e4114fb..c42b80ee3920 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -521,7 +521,6 @@ static void qmp_cooling_devices_remove(struct qmp *qmp)
 
 static int qmp_probe(struct platform_device *pdev)
 {
-	struct resource *res;
 	struct qmp *qmp;
 	int irq;
 	int ret;
@@ -534,8 +533,7 @@ static int qmp_probe(struct platform_device *pdev)
 	init_waitqueue_head(&qmp->event);
 	mutex_init(&qmp->tx_lock);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	qmp->msgram = devm_ioremap_resource(&pdev->dev, res);
+	qmp->msgram = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(qmp->msgram))
 		return PTR_ERR(qmp->msgram);
 
-- 
2.25.1

