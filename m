Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A966F37A406
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 11:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhEKJur (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 May 2021 05:50:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2484 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhEKJur (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 May 2021 05:50:47 -0400
Received: from dggeml701-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FfY402HwbzYk9j;
        Tue, 11 May 2021 17:47:12 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggeml701-chm.china.huawei.com (10.3.17.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 17:49:24 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 17:49:24 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Sebastian Reichel <sre@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] power: reset: at91-sama5d2_shdwc: Remove redundant error printing in at91_shdwc_probe()
Date:   Tue, 11 May 2021 17:49:19 +0800
Message-ID: <20210511094919.4885-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When devm_ioremap_resource() fails, a clear enough error message will be
printed by its subfunction __devm_ioremap_resource(). The error
information contains the device name, failure cause, and possibly resource
information.

Therefore, remove the error printing here to simplify code and reduce the
binary size.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 125e592af445e32..d8ecffe72f165cb 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -351,10 +351,8 @@ static int __init at91_shdwc_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	at91_shdwc->shdwc_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(at91_shdwc->shdwc_base)) {
-		dev_err(&pdev->dev, "Could not map reset controller address\n");
+	if (IS_ERR(at91_shdwc->shdwc_base))
 		return PTR_ERR(at91_shdwc->shdwc_base);
-	}
 
 	match = of_match_node(at91_shdwc_of_match, pdev->dev.of_node);
 	at91_shdwc->rcfg = match->data;
-- 
2.26.0.106.g9fadedd


