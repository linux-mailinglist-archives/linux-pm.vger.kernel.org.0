Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9153E8EF6
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 12:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhHKKta (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 06:49:30 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:64269 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbhHKKt3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 06:49:29 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb6113ab13b89-63aae; Wed, 11 Aug 2021 18:48:53 +0800 (CST)
X-RM-TRANSID: 2eeb6113ab13b89-63aae
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6113ab10ded-3a9d4;
        Wed, 11 Aug 2021 18:48:52 +0800 (CST)
X-RM-TRANSID: 2eea6113ab10ded-3a9d4
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     sre@kernel.org, wens@csie.org, hdegoede@redhat.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] power: supply: axp288_charger: Use the defined variable to clean code
Date:   Wed, 11 Aug 2021 18:49:29 +0800
Message-Id: <20210811104929.24608-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the defined variable "dev" to make the code cleaner.

Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/power/supply/axp288_charger.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index a4df1ea92..b9553be9b 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -813,7 +813,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	if (val == 0)
 		return -ENODEV;
 
-	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
@@ -823,7 +823,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 
 	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
 	if (info->cable.edev == NULL) {
-		dev_dbg(&pdev->dev, "%s is not ready, probe deferred\n",
+		dev_dbg(dev, "%s is not ready, probe deferred\n",
 			AXP288_EXTCON_DEV_NAME);
 		return -EPROBE_DEFER;
 	}
@@ -834,8 +834,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
 			return -EPROBE_DEFER;
 		}
-		dev_info(&pdev->dev,
-			 "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
+		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
 	}
 
 	platform_set_drvdata(pdev, info);
@@ -874,7 +873,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
 	info->otg.id_nb.notifier_call = axp288_charger_handle_otg_evt;
 	if (info->otg.cable) {
-		ret = devm_extcon_register_notifier(&pdev->dev, info->otg.cable,
+		ret = devm_extcon_register_notifier(dev, info->otg.cable,
 					EXTCON_USB_HOST, &info->otg.id_nb);
 		if (ret) {
 			dev_err(dev, "failed to register EXTCON_USB_HOST notifier\n");
@@ -899,7 +898,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 					NULL, axp288_charger_irq_thread_handler,
 					IRQF_ONESHOT, info->pdev->name, info);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to request interrupt=%d\n",
+			dev_err(dev, "failed to request interrupt=%d\n",
 								info->irq[i]);
 			return ret;
 		}
-- 
2.20.1.windows.1



