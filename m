Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE13210CF
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 07:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhBVGWG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 01:22:06 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:43155 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhBVGV7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2021 01:21:59 -0500
X-Greylist: delayed 630 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Feb 2021 01:21:55 EST
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee160334ad88ef-da1cd; Mon, 22 Feb 2021 14:10:32 +0800 (CST)
X-RM-TRANSID: 2ee160334ad88ef-da1cd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee560334ad53d8-bb2a8;
        Mon, 22 Feb 2021 14:10:32 +0800 (CST)
X-RM-TRANSID: 2ee560334ad53d8-bb2a8
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     glaroque@baylibre.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] thermal: amlogic: Omit superfluous error message in amlogic_thermal_probe()
Date:   Mon, 22 Feb 2021 14:11:05 +0800
Message-Id: <20210222061105.6008-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function devm_platform_ioremap_resource has already contains error
message, so remove the redundant dev_err here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/thermal/amlogic_thermal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index ccb1fe18e..bba9f3b14 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -253,10 +253,8 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pdata);
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base)) {
-		dev_err(dev, "failed to get io address\n");
+	if (IS_ERR(base))
 		return PTR_ERR(base);
-	}
 
 	pdata->regmap = devm_regmap_init_mmio(dev, base,
 					      pdata->data->regmap_config);
-- 
2.20.1.windows.1



