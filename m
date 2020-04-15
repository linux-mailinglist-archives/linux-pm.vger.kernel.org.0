Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572D21A91F3
	for <lists+linux-pm@lfdr.de>; Wed, 15 Apr 2020 06:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388806AbgDOE0A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Apr 2020 00:26:00 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:5121 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgDOEZ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 00:25:59 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5e968cc87ac-6198a; Wed, 15 Apr 2020 12:25:44 +0800 (CST)
X-RM-TRANSID: 2eec5e968cc87ac-6198a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95e968cc5044-63201;
        Wed, 15 Apr 2020 12:25:44 +0800 (CST)
X-RM-TRANSID: 2ee95e968cc5044-63201
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     sre@kernel.org, wens@csie.org, hdegoede@redhat.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] power: supply: axp288_charger: Omit superfluous error message
Date:   Wed, 15 Apr 2020 12:27:27 +0800
Message-Id: <20200415042727.13496-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In the axp288_charger_probe(), when get irq failed, the function
platform_get_irq() logs an error message, so remove redundant
message here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
---
 drivers/power/supply/axp288_charger.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 1bbba6bba..16fb4ae1c 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -825,10 +825,9 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	/* Register charger interrupts */
 	for (i = 0; i < CHRG_INTR_END; i++) {
 		pirq = platform_get_irq(info->pdev, i);
-		if (pirq < 0) {
-			dev_err(&pdev->dev, "Failed to get IRQ: %d\n", pirq);
+		if (pirq < 0)
 			return pirq;
-		}
+
 		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
 		if (info->irq[i] < 0) {
 			dev_warn(&info->pdev->dev,
-- 
2.20.1.windows.1



