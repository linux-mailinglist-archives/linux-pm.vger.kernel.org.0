Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D4E314DD2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 12:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhBILFA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 06:05:00 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:60449 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhBILDA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 06:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612868579; x=1644404579;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W9uQIBmMbhOJI5EB5t0XL0RgU8AIWyZX4YDNWFP3Br4=;
  b=Dsd2a74E2/LKAgCeJ/BYrL8vYxyo1/Bk9tqf22kULvLOtXDAxF6DoaIN
   2/9x0aXzJ2hfZMcAoeOsOxWJjDgGJ6m0akmjpc4X1NZbt1WBtzGsOqS3S
   AzTeQsJB1kIRuDpG0NvTTHt/fNSjiNbmo45swW2Oc23FS6Rypfwj1sDUJ
   9saLzOTL2NBvw3+tX3fAOgqxDwxaMEka3kxR2/NpwKyCs/aGeMObmP7dn
   vm38SKF4D789MTE+mOwOndDe80Y95DQSE/Z+JlZMynS6kEOl2pEKKAFqc
   5ABKQO4fW8sQt8PVbyRpxYogWEGyof/vGQ7P/tuVP85WkuQY759tLOJi+
   A==;
IronPort-SDR: vV5/rJCZXvsBr1YtRxaK2d5GX2y09KEhs46aIHJFKUfM5olZXcpqPGjc2vmfX0kg+Ifer557wP
 /f6g+yX92+4BDmI67vA4W+gzol6NSYPyU0MrmY1Mv9YsLVMeWCqWWl8XWNunpFrvXezjYe8vda
 hKes3RxgysrwwxybcO4nJ8PFejY4NIE11dxp9pSJw2nYodjnPZuT/dLUF4+YCmsb29r91+EhV9
 A5Atw1kfTLbZIr68PlqEheGc5O2qC0gy6NHtraXu463DfS8yRrkLoNvzNTIIp89mV3Hg56TEBe
 ZOc=
X-IronPort-AV: E=Sophos;i="5.81,164,1610434800"; 
   d="scan'208";a="105958094"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2021 04:01:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 9 Feb 2021 04:01:43 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 9 Feb 2021 04:01:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <sre@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        kernel test robot <lkp@intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Subject: [PATCH] power: reset: at91-reset: free resources on exit path
Date:   Tue, 9 Feb 2021 13:01:09 +0200
Message-ID: <20210209110109.906034-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Free resources on exit path (failure path of probe and remove).

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 3ff9d93a5226..2ff7833153b6 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -206,7 +206,8 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 			if (!reset->ramc_base[idx]) {
 				dev_err(&pdev->dev, "Could not map ram controller address\n");
 				of_node_put(np);
-				return -ENODEV;
+				ret = -ENODEV;
+				goto unmap;
 			}
 			idx++;
 		}
@@ -218,13 +219,15 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 	reset->args = (u32)match->data;
 
 	reset->sclk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(reset->sclk))
-		return PTR_ERR(reset->sclk);
+	if (IS_ERR(reset->sclk)) {
+		ret = PTR_ERR(reset->sclk);
+		goto unmap;
+	}
 
 	ret = clk_prepare_enable(reset->sclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not enable slow clock\n");
-		return ret;
+		goto unmap;
 	}
 
 	platform_set_drvdata(pdev, reset);
@@ -239,21 +242,33 @@ static int __init at91_reset_probe(struct platform_device *pdev)
 	ret = register_restart_handler(&reset->nb);
 	if (ret) {
 		clk_disable_unprepare(reset->sclk);
-		return ret;
+		goto unmap;
 	}
 
 	at91_reset_status(pdev, reset->rstc_base);
 
 	return 0;
+
+unmap:
+	iounmap(reset->rstc_base);
+	for (idx = 0; idx < ARRAY_SIZE(reset->ramc_base); idx++)
+		iounmap(reset->ramc_base[idx]);
+
+	return ret;
 }
 
 static int __exit at91_reset_remove(struct platform_device *pdev)
 {
 	struct at91_reset *reset = platform_get_drvdata(pdev);
+	int idx;
 
 	unregister_restart_handler(&reset->nb);
 	clk_disable_unprepare(reset->sclk);
 
+	iounmap(reset->rstc_base);
+	for (idx = 0; idx < ARRAY_SIZE(reset->ramc_base); idx++)
+		iounmap(reset->ramc_base[idx]);
+
 	return 0;
 }
 
-- 
2.25.1

