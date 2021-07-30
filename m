Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163E03DB67F
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jul 2021 11:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbhG3J40 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Jul 2021 05:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238089AbhG3J40 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jul 2021 05:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627638981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WGqluPgr2LjM8dqyoPp3jr62gnepJ6fl22cr3iF8/4g=;
        b=PUvCwYxFofVOWw2jgb7qBGhVLGT8FcNAuxEjeOQM9vnZEWeQ/jUqKKLS4z4aE8MJdq9cLr
        YO0nz3Pup+y4IbzzhnTf0D8KN8bDrnVWNaq7zbKkWyAilA/pNqbMwkN3xl4s0pxmEpLzJL
        toASI8qRFR/nbNmykfSC9zfVn3twJ/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-WoPGqBpBO2CC3tx_6i_cYw-1; Fri, 30 Jul 2021 05:56:19 -0400
X-MC-Unique: WoPGqBpBO2CC3tx_6i_cYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C3F7107B7C3;
        Fri, 30 Jul 2021 09:56:18 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E3EA399;
        Fri, 30 Jul 2021 09:56:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Andrejus Basovas <cpp@gcc.lt>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 06/10] power: supply: axp288_fuel_gauge: Store struct device pointer in axp288_fg_info
Date:   Fri, 30 Jul 2021 11:56:03 +0200
Message-Id: <20210730095607.57541-7-hdegoede@redhat.com>
In-Reply-To: <20210730095607.57541-1-hdegoede@redhat.com>
References: <20210730095607.57541-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Directly store the struct device pointer in axp288_fg_info, rather then
storing a pointer to the struct platform_device there and then using
"&info->pdev->dev" everywhere.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 59 ++++++++++--------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index d58a1f81fcea..1366027edf49 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -102,7 +102,7 @@ enum {
 };
 
 struct axp288_fg_info {
-	struct platform_device *pdev;
+	struct device *dev;
 	struct regmap *regmap;
 	struct regmap_irq_chip_data *regmap_irqc;
 	int irq[AXP288_FG_INTR_NUM];
@@ -136,7 +136,7 @@ static int fuel_gauge_reg_readb(struct axp288_fg_info *info, int reg)
 
 	ret = regmap_read(info->regmap, reg, &val);
 	if (ret < 0) {
-		dev_err(&info->pdev->dev, "Error reading reg 0x%02x err: %d\n", reg, ret);
+		dev_err(info->dev, "Error reading reg 0x%02x err: %d\n", reg, ret);
 		return ret;
 	}
 
@@ -150,7 +150,7 @@ static int fuel_gauge_reg_writeb(struct axp288_fg_info *info, int reg, u8 val)
 	ret = regmap_write(info->regmap, reg, (unsigned int)val);
 
 	if (ret < 0)
-		dev_err(&info->pdev->dev, "Error writing reg 0x%02x err: %d\n", reg, ret);
+		dev_err(info->dev, "Error writing reg 0x%02x err: %d\n", reg, ret);
 
 	return ret;
 }
@@ -162,15 +162,13 @@ static int fuel_gauge_read_15bit_word(struct axp288_fg_info *info, int reg)
 
 	ret = regmap_bulk_read(info->regmap, reg, buf, 2);
 	if (ret < 0) {
-		dev_err(&info->pdev->dev, "Error reading reg 0x%02x err: %d\n",
-			reg, ret);
+		dev_err(info->dev, "Error reading reg 0x%02x err: %d\n", reg, ret);
 		return ret;
 	}
 
 	ret = get_unaligned_be16(buf);
 	if (!(ret & FG_15BIT_WORD_VALID)) {
-		dev_err(&info->pdev->dev, "Error reg 0x%02x contents not valid\n",
-			reg);
+		dev_err(info->dev, "Error reg 0x%02x contents not valid\n", reg);
 		return -ENXIO;
 	}
 
@@ -184,8 +182,7 @@ static int fuel_gauge_read_12bit_word(struct axp288_fg_info *info, int reg)
 
 	ret = regmap_bulk_read(info->regmap, reg, buf, 2);
 	if (ret < 0) {
-		dev_err(&info->pdev->dev, "Error reading reg 0x%02x err: %d\n",
-			reg, ret);
+		dev_err(info->dev, "Error reading reg 0x%02x err: %d\n", reg, ret);
 		return ret;
 	}
 
@@ -199,8 +196,7 @@ static void fuel_gauge_get_status(struct axp288_fg_info *info)
 
 	pwr_stat = fuel_gauge_reg_readb(info, AXP20X_PWR_INPUT_STATUS);
 	if (pwr_stat < 0) {
-		dev_err(&info->pdev->dev,
-			"PWR STAT read failed:%d\n", pwr_stat);
+		dev_err(info->dev, "PWR STAT read failed: %d\n", pwr_stat);
 		return;
 	}
 
@@ -210,7 +206,7 @@ static void fuel_gauge_get_status(struct axp288_fg_info *info)
 
 	fg_res = fuel_gauge_reg_readb(info, AXP20X_FG_RES);
 	if (fg_res < 0) {
-		dev_err(&info->pdev->dev, "FG RES read failed: %d\n", fg_res);
+		dev_err(info->dev, "FG RES read failed: %d\n", fg_res);
 		return;
 	}
 	if (!(fg_res & FG_REP_CAP_VALID))
@@ -232,7 +228,7 @@ static void fuel_gauge_get_status(struct axp288_fg_info *info)
 
 	ret = iio_read_channel_raw(info->iio_channel[BAT_D_CURR], &curr);
 	if (ret < 0) {
-		dev_err(&info->pdev->dev, "FG get current failed: %d\n", ret);
+		dev_err(info->dev, "FG get current failed: %d\n", ret);
 		return;
 	}
 	if (curr == 0) {
@@ -355,8 +351,7 @@ static int fuel_gauge_get_property(struct power_supply *ps,
 			goto fuel_gauge_read_err;
 
 		if (!(ret & FG_REP_CAP_VALID))
-			dev_err(&info->pdev->dev,
-				"capacity measurement not valid\n");
+			dev_err(info->dev, "capacity measurement not valid\n");
 		val->intval = (ret & FG_REP_CAP_VAL_MASK);
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
@@ -455,35 +450,31 @@ static irqreturn_t fuel_gauge_thread_handler(int irq, void *dev)
 	}
 
 	if (i >= AXP288_FG_INTR_NUM) {
-		dev_warn(&info->pdev->dev, "spurious interrupt!!\n");
+		dev_warn(info->dev, "spurious interrupt!!\n");
 		return IRQ_NONE;
 	}
 
 	switch (i) {
 	case QWBTU_IRQ:
-		dev_info(&info->pdev->dev,
-			"Quit Battery under temperature in work mode IRQ (QWBTU)\n");
+		dev_info(info->dev, "Quit Battery under temperature in work mode IRQ (QWBTU)\n");
 		break;
 	case WBTU_IRQ:
-		dev_info(&info->pdev->dev,
-			"Battery under temperature in work mode IRQ (WBTU)\n");
+		dev_info(info->dev, "Battery under temperature in work mode IRQ (WBTU)\n");
 		break;
 	case QWBTO_IRQ:
-		dev_info(&info->pdev->dev,
-			"Quit Battery over temperature in work mode IRQ (QWBTO)\n");
+		dev_info(info->dev, "Quit Battery over temperature in work mode IRQ (QWBTO)\n");
 		break;
 	case WBTO_IRQ:
-		dev_info(&info->pdev->dev,
-			"Battery over temperature in work mode IRQ (WBTO)\n");
+		dev_info(info->dev, "Battery over temperature in work mode IRQ (WBTO)\n");
 		break;
 	case WL2_IRQ:
-		dev_info(&info->pdev->dev, "Low Batt Warning(2) INTR\n");
+		dev_info(info->dev, "Low Batt Warning(2) INTR\n");
 		break;
 	case WL1_IRQ:
-		dev_info(&info->pdev->dev, "Low Batt Warning(1) INTR\n");
+		dev_info(info->dev, "Low Batt Warning(1) INTR\n");
 		break;
 	default:
-		dev_warn(&info->pdev->dev, "Spurious Interrupt!!!\n");
+		dev_warn(info->dev, "Spurious Interrupt!!!\n");
 	}
 
 	power_supply_changed(info->bat);
@@ -508,16 +499,15 @@ static const struct power_supply_desc fuel_gauge_desc = {
 	.external_power_changed	= fuel_gauge_external_power_changed,
 };
 
-static void fuel_gauge_init_irq(struct axp288_fg_info *info)
+static void fuel_gauge_init_irq(struct axp288_fg_info *info, struct platform_device *pdev)
 {
 	int ret, i, pirq;
 
 	for (i = 0; i < AXP288_FG_INTR_NUM; i++) {
-		pirq = platform_get_irq(info->pdev, i);
+		pirq = platform_get_irq(pdev, i);
 		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
 		if (info->irq[i] < 0) {
-			dev_warn(&info->pdev->dev,
-				"regmap_irq get virq failed for IRQ %d: %d\n",
+			dev_warn(info->dev, "regmap_irq get virq failed for IRQ %d: %d\n",
 				pirq, info->irq[i]);
 			info->irq[i] = -1;
 			goto intr_failed;
@@ -526,8 +516,7 @@ static void fuel_gauge_init_irq(struct axp288_fg_info *info)
 				NULL, fuel_gauge_thread_handler,
 				IRQF_ONESHOT, DEV_NAME, info);
 		if (ret) {
-			dev_warn(&info->pdev->dev,
-				"request irq failed for IRQ %d: %d\n",
+			dev_warn(info->dev, "request irq failed for IRQ %d: %d\n",
 				pirq, info->irq[i]);
 			info->irq[i] = -1;
 			goto intr_failed;
@@ -649,7 +638,7 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 
-	info->pdev = pdev;
+	info->dev = &pdev->dev;
 	info->regmap = axp20x->regmap;
 	info->regmap_irqc = axp20x->regmap_irqc;
 	info->status = POWER_SUPPLY_STATUS_UNKNOWN;
@@ -714,7 +703,7 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		goto out_free_iio_chan;
 	}
 
-	fuel_gauge_init_irq(info);
+	fuel_gauge_init_irq(info, pdev);
 
 	return 0;
 
-- 
2.31.1

