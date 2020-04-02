Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E50B19C010
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 13:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388048AbgDBLUy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 07:20:54 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:3376 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgDBLUy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 07:20:54 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Apr 2020 07:20:53 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25e85c83fd76-5dedb; Thu, 02 Apr 2020 19:10:55 +0800 (CST)
X-RM-TRANSID: 2ee25e85c83fd76-5dedb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25e85c83e3b8-b6312;
        Thu, 02 Apr 2020 19:10:55 +0800 (CST)
X-RM-TRANSID: 2ee25e85c83e3b8-b6312
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] power:supply:88pm860x_battery:use platform_get_irq_optional()
Date:   Thu,  2 Apr 2020 19:12:22 +0800
Message-Id: <20200402111222.15204-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to simply code,because platform_get_irq() already has
dev_err() message.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/power/supply/88pm860x_battery.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
index 5ca047b3f..960d408d4 100644
--- a/drivers/power/supply/88pm860x_battery.c
+++ b/drivers/power/supply/88pm860x_battery.c
@@ -918,13 +918,13 @@ static int pm860x_battery_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
-	info->irq_cc = platform_get_irq(pdev, 0);
+	info->irq_cc = platform_get_irq_optional(pdev, 0);
 	if (info->irq_cc <= 0) {
 		dev_err(&pdev->dev, "No IRQ resource!\n");
 		return -EINVAL;
 	}
 
-	info->irq_batt = platform_get_irq(pdev, 1);
+	info->irq_batt = platform_get_irq_optional(pdev, 1);
 	if (info->irq_batt <= 0) {
 		dev_err(&pdev->dev, "No IRQ resource!\n");
 		return -EINVAL;
-- 
2.20.1.windows.1



