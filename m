Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B4C2AB7E7
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 13:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgKIMLR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 07:11:17 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:36774 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727303AbgKIMLR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 07:11:17 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09605445|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0380702-0.0163614-0.945568;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.IuVJ-Tc_1604923868;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IuVJ-Tc_1604923868)
          by smtp.aliyun-inc.com(10.147.40.44);
          Mon, 09 Nov 2020 20:11:12 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     sre@kernel.org, wens@csie.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, tiny.windzz@gmail.com
Cc:     Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH 2/3] power: supply: axp20x_usb_power: Use power efficient workqueue for debounce
Date:   Mon,  9 Nov 2020 20:11:04 +0800
Message-Id: <20201109121104.18201-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

The debounce timeout is generally quite long and the work not performance
critical so allow the scheduler to run the work anywhere rather than in
the normal per-CPU workqueue.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/power/supply/axp20x_usb_power.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 3b4fd710347d..70b28b699a80 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -92,7 +92,7 @@ static irqreturn_t axp20x_usb_power_irq(int irq, void *devid)
 
 	power_supply_changed(power->supply);
 
-	mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
+	mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
 
 	return IRQ_HANDLED;
 }
@@ -117,7 +117,7 @@ static void axp20x_usb_power_poll_vbus(struct work_struct *work)
 
 out:
 	if (axp20x_usb_vbus_needs_polling(power))
-		mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
+		mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
 }
 
 static int axp20x_get_current_max(struct axp20x_usb_power *power, int *val)
@@ -525,7 +525,7 @@ static int axp20x_usb_power_resume(struct device *dev)
 	while (i < power->num_irqs)
 		enable_irq(power->irqs[i++]);
 
-	mod_delayed_work(system_wq, &power->vbus_detect, DEBOUNCE_TIME);
+	mod_delayed_work(system_power_efficient_wq, &power->vbus_detect, DEBOUNCE_TIME);
 
 	return 0;
 }
@@ -647,7 +647,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 
 	INIT_DELAYED_WORK(&power->vbus_detect, axp20x_usb_power_poll_vbus);
 	if (axp20x_usb_vbus_needs_polling(power))
-		queue_delayed_work(system_wq, &power->vbus_detect, 0);
+		queue_delayed_work(system_power_efficient_wq, &power->vbus_detect, 0);
 
 	return 0;
 }
-- 
2.28.0

