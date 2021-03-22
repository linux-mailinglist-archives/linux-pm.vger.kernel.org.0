Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA1E343F96
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 12:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhCVLXf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 07:23:35 -0400
Received: from m12-14.163.com ([220.181.12.14]:49311 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhCVLXO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Mar 2021 07:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=wB68+CyVPyDWhl9O4d
        ZeU9hVVE2ad/rS8YLHzypn1qY=; b=fA2lV0q5Bgw4QZWlJ7SkLEsSOSGYbxqlPF
        2HMIvbaUt4c7eQfIZCTAW5sKwUc/DOWi9JAnTyO/EmLxgMHUryEiqTMaJcVhKZr/
        RWmCExVjm1v7iDnE3QliNsj8QStJLjPGyzDO45mqQZBvIGmFOYfPl0nIGBA4p5hO
        vykBoeIpo=
Received: from bf-rmnj-02.ccdomain.com (unknown [218.94.48.178])
        by smtp10 (Coremail) with SMTP id DsCowAAnNVHqfVhgfZ+hqg--.21114S2;
        Mon, 22 Mar 2021 19:22:24 +0800 (CST)
From:   Jian Dong <dj0227@163.com>
To:     milo.kim@ti.com, sre@kernel.org
Cc:     huyue2@yulong.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dongjian <dongjian@yulong.com>
Subject: [PATCH] power-supply: Use IRQF_ONESHOT
Date:   Mon, 22 Mar 2021 19:21:33 +0800
Message-Id: <1616412093-144386-1-git-send-email-dj0227@163.com>
X-Mailer: git-send-email 1.9.1
X-CM-TRANSID: DsCowAAnNVHqfVhgfZ+hqg--.21114S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1DGw48Aw1fKrWxtr4xZwb_yoW5AF4Upa
        95AF93ArWYgayUJF1DKayUGFy5Kay5AFy5CrWxt345Z3W3Z3yvqr1UKFW3Gry7JrW3XF4S
        qa4aqw4IqF13GrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFv38UUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: dgmqjjqx6rljoofrz/1tbiOxBd3VXlrfgrxgAAsj
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: dongjian <dongjian@yulong.com>

Fixes coccicheck error:

drivers/power/supply/pm2301_charger.c:1089:7-27: ERROR:
drivers/power/supply/lp8788-charger.c:502:8-28: ERROR:
drivers/power/supply/tps65217_charger.c:239:8-33: ERROR:
drivers/power/supply/tps65090-charger.c:303:8-33: ERROR:

Threaded IRQ with no primary handler requested without IRQF_ONESHOT

Signed-off-by: dongjian <dongjian@yulong.com>
---
 drivers/power/supply/lp8788-charger.c   | 2 +-
 drivers/power/supply/pm2301_charger.c   | 2 +-
 drivers/power/supply/tps65090-charger.c | 2 +-
 drivers/power/supply/tps65217_charger.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index e7931ff..397e5a0 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -501,7 +501,7 @@ static int lp8788_set_irqs(struct platform_device *pdev,
 
 		ret = request_threaded_irq(virq, NULL,
 					lp8788_charger_irq_thread,
-					0, name, pchg);
+					IRQF_ONESHOT, name, pchg);
 		if (ret)
 			break;
 	}
diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply/pm2301_charger.c
index ac06ecf..a3bfb96 100644
--- a/drivers/power/supply/pm2301_charger.c
+++ b/drivers/power/supply/pm2301_charger.c
@@ -1089,7 +1089,7 @@ static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
 	ret = request_threaded_irq(gpio_to_irq(pm2->pdata->gpio_irq_number),
 				NULL,
 				pm2xxx_charger_irq[0].isr,
-				pm2->pdata->irq_type,
+				pm2->pdata->irq_type | IRQF_ONESHOT,
 				pm2xxx_charger_irq[0].name, pm2);
 
 	if (ret != 0) {
diff --git a/drivers/power/supply/tps65090-charger.c b/drivers/power/supply/tps65090-charger.c
index 6b0098e..0990b2f 100644
--- a/drivers/power/supply/tps65090-charger.c
+++ b/drivers/power/supply/tps65090-charger.c
@@ -301,7 +301,7 @@ static int tps65090_charger_probe(struct platform_device *pdev)
 
 	if (irq != -ENXIO) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-			tps65090_charger_isr, 0, "tps65090-charger", cdata);
+			tps65090_charger_isr, IRQF_ONESHOT, "tps65090-charger", cdata);
 		if (ret) {
 			dev_err(cdata->dev,
 				"Unable to register irq %d err %d\n", irq,
diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 814c2b8..ba33d16 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -238,7 +238,7 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	for (i = 0; i < NUM_CHARGER_IRQS; i++) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq[i], NULL,
 						tps65217_charger_irq,
-						0, "tps65217-charger",
+						IRQF_ONESHOT, "tps65217-charger",
 						charger);
 		if (ret) {
 			dev_err(charger->dev,
-- 
1.9.1


