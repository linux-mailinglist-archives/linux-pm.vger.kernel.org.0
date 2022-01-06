Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5795486371
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jan 2022 12:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiAFLGN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jan 2022 06:06:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238263AbiAFLGN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jan 2022 06:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641467172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zcO6TrtvqNyZ5nzPZpQ6zYxJyCqEOIOr5GEZ2eAC3BQ=;
        b=H+mwiXGhee8eqP0y6W7Hy4M7WLnOgksGEdwr/ro7gloKqK2cC/xUTLcxdEOP8wt++68iHF
        zWYS1CZl1hZlVfby8rjlXKu15EavmitCNB1l4siA2CXa9t8XvrfR3vGq2nvv7qOA9NwfHV
        OadIoT8hxUDL6ohLC46NySIJifptdGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-8vNtK2z_PTyn-REzekrywg-1; Thu, 06 Jan 2022 06:06:11 -0500
X-MC-Unique: 8vNtK2z_PTyn-REzekrywg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6106A804305;
        Thu,  6 Jan 2022 11:06:10 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92B8B752B0;
        Thu,  6 Jan 2022 11:06:09 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 1/7] power: supply: axp288_fuel_gauge: Add dev helper var to probe()
Date:   Thu,  6 Jan 2022 12:06:02 +0100
Message-Id: <20220106110608.66231-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a dev local variable to probe() as shortcut for &pdev->dev, this is
a preparation change for making more use of devm managed resources.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index c1da217fdb0e..1495402f440c 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -622,16 +622,17 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		[BAT_D_CURR] = "axp288-chrg-d-curr",
 		[BAT_VOLT] = "axp288-batt-volt",
 	};
+	struct device *dev = &pdev->dev;
 	unsigned int val;
 
 	if (dmi_check_system(axp288_no_battery_list))
 		return -ENODEV;
 
-	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	info->dev = &pdev->dev;
+	info->dev = dev;
 	info->regmap = axp20x->regmap;
 	info->regmap_irqc = axp20x->regmap_irqc;
 	info->status = POWER_SUPPLY_STATUS_UNKNOWN;
@@ -651,8 +652,7 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 			iio_channel_get(NULL, iio_chan_name[i]);
 		if (IS_ERR(info->iio_channel[i])) {
 			ret = PTR_ERR(info->iio_channel[i]);
-			dev_dbg(&pdev->dev, "error getting iiochan %s: %d\n",
-				iio_chan_name[i], ret);
+			dev_dbg(dev, "error getting iiochan %s: %d\n", iio_chan_name[i], ret);
 			/* Wait for axp288_adc to load */
 			if (ret == -ENODEV)
 				ret = -EPROBE_DEFER;
@@ -722,10 +722,10 @@ static int axp288_fuel_gauge_probe(struct platform_device *pdev)
 		goto out_free_iio_chan;
 
 	psy_cfg.drv_data = info;
-	info->bat = power_supply_register(&pdev->dev, &fuel_gauge_desc, &psy_cfg);
+	info->bat = power_supply_register(dev, &fuel_gauge_desc, &psy_cfg);
 	if (IS_ERR(info->bat)) {
 		ret = PTR_ERR(info->bat);
-		dev_err(&pdev->dev, "failed to register battery: %d\n", ret);
+		dev_err(dev, "failed to register battery: %d\n", ret);
 		goto out_free_iio_chan;
 	}
 
-- 
2.33.1

