Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9DB486375
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jan 2022 12:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbiAFLGq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 06:06:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238255AbiAFLGq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 06:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641467205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LtBF37Z6xOlz7tstlK4eaDChnhL1qPCfKX0po7EsvoY=;
        b=MdcGPXm0tOLcLM20JsjO6mXgmNHLN6LYtqd6epZ3Adqe7bCISwIInAB2jBzaxeReRc/Pq+
        qhqAzbkkmybkYRpIhQW6QOuEl6RQ14IBAhhMz1SvsKOyeHPgIkCEEUuZxnYgS5X5sW0tyI
        /qIXVkuo4XAZ52g8NlCTKIYZcvQNaIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-_QN63KABNsuOYOdDhOok-w-1; Thu, 06 Jan 2022 06:06:42 -0500
X-MC-Unique: _QN63KABNsuOYOdDhOok-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB1601006AA3;
        Thu,  6 Jan 2022 11:06:41 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FBB367C99;
        Thu,  6 Jan 2022 11:06:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 5/7] power: supply: axp288_fuel_gauge: Refactor IRQ initialization
Date:   Thu,  6 Jan 2022 12:06:06 +0100
Message-Id: <20220106110608.66231-5-hdegoede@redhat.com>
In-Reply-To: <20220106110608.66231-1-hdegoede@redhat.com>
References: <20220106110608.66231-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Refactor the IRQ initialization code:

* Move the looking up of the vIRQs to the beginning of probe(), failing
  probe early if this fails
* Do the actual requesting of IRQs inline in probe() and properly abort
  probe() on errors
* Use devm_request_threaded_irq(), completing the conversion of probe() to
  only use devm managed resources and remove the remove() driver function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 66 ++++++------------------
 1 file changed, 17 insertions(+), 49 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index cefde85e3309..f7dce029266a 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -107,7 +107,6 @@ enum {
 struct axp288_fg_info {
 	struct device *dev;
 	struct regmap *regmap;
-	struct regmap_irq_chip_data *regmap_irqc;
 	int irq[AXP288_FG_INTR_NUM];
 	struct iio_channel *iio_channel[IIO_CHANNEL_NUM];
 	struct power_supply *bat;
@@ -502,38 +501,6 @@ static const struct power_supply_desc fuel_gauge_desc = {
 	.external_power_changed	= fuel_gauge_external_power_changed,
 };
 
-static void fuel_gauge_init_irq(struct axp288_fg_info *info, struct platform_device *pdev)
-{
-	int ret, i, pirq;
-
-	for (i = 0; i < AXP288_FG_INTR_NUM; i++) {
-		pirq = platform_get_irq(pdev, i);
-		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
-		if (info->irq[i] < 0) {
-			dev_warn(info->dev, "regmap_irq get virq failed for IRQ %d: %d\n",
-				pirq, info->irq[i]);
-			info->irq[i] = -1;
-			goto intr_failed;
-		}
-		ret = request_threaded_irq(info->irq[i],
-				NULL, fuel_gauge_thread_handler,
-				IRQF_ONESHOT, DEV_NAME, info);
-		if (ret) {
-			dev_warn(info->dev, "request irq failed for IRQ %d: %d\n",
-				pirq, info->irq[i]);
-			info->irq[i] = -1;
-			goto intr_failed;
-		}
-	}
-	return;
-
-intr_failed:
-	for (; i > 0; i--) {
-		free_irq(info->irq[i - 1], info);
-		info->irq[i - 1] = -1;
-	}
-}
-
 /*
  * Some devices have no battery (HDMI sticks) and the axp288 battery's
  * detection reports one despite it not being there.
@@ -678,7 +645,6 @@ static void axp288_fuel_gauge_release_iio_chans(void *data)
 
 static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 {
-	int i, ret = 0;
 	struct axp288_fg_info *info;
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config psy_cfg = {};
@@ -688,6 +654,7 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		[BAT_VOLT] = "axp288-batt-volt",
 	};
 	struct device *dev = &pdev->dev;
+	int i, pirq, ret;
 
 	if (dmi_check_system(axp288_no_battery_list))
 		return -ENODEV;
@@ -698,7 +665,6 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 
 	info->dev = dev;
 	info->regmap = axp20x->regmap;
-	info->regmap_irqc = axp20x->regmap_irqc;
 	info->status = POWER_SUPPLY_STATUS_UNKNOWN;
 	info->valid = 0;
 
@@ -706,6 +672,15 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 
 	mutex_init(&info->lock);
 
+	for (i = 0; i < AXP288_FG_INTR_NUM; i++) {
+		pirq = platform_get_irq(pdev, i);
+		ret = regmap_irq_get_virq(axp20x->regmap_irqc, pirq);
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "getting vIRQ %d\n", pirq);
+
+		info->irq[i] = ret;
+	}
+
 	for (i = 0; i < IIO_CHANNEL_NUM; i++) {
 		/*
 		 * Note cannot use devm_iio_channel_get because x86 systems
@@ -747,7 +722,13 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	fuel_gauge_init_irq(info, pdev);
+	for (i = 0; i < AXP288_FG_INTR_NUM; i++) {
+		ret = devm_request_threaded_irq(dev, info->irq[i], NULL,
+						fuel_gauge_thread_handler,
+						IRQF_ONESHOT, DEV_NAME, info);
+		if (ret)
+			return dev_err_probe(dev, ret, "requesting IRQ %d\n", info->irq[i]);
+	}
 
 	return 0;
 }
@@ -758,21 +739,8 @@ static const struct platform_device_id axp288_fg_id_table[] = {
 };
 MODULE_DEVICE_TABLE(platform, axp288_fg_id_table);
 
-static int axp288_fuel_gauge_remove(struct platform_device *pdev)
-{
-	struct axp288_fg_info *info = platform_get_drvdata(pdev);
-	int i;
-
-	for (i = 0; i < AXP288_FG_INTR_NUM; i++)
-		if (info->irq[i] >= 0)
-			free_irq(info->irq[i], info);
-
-	return 0;
-}
-
 static struct platform_driver axp288_fuel_gauge_driver = {
 	.probe = axp288_fuel_gauge_probe,
-	.remove = axp288_fuel_gauge_remove,
 	.id_table = axp288_fg_id_table,
 	.driver = {
 		.name = DEV_NAME,
-- 
2.33.1

