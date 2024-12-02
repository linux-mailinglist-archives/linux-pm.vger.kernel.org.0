Return-Path: <linux-pm+bounces-18389-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53379E0E09
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 22:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92EA9B2BEF5
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 21:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C8B1DF745;
	Mon,  2 Dec 2024 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VaaKdBD0"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24F31DF254;
	Mon,  2 Dec 2024 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174127; cv=none; b=hEsJrQ5loqBUvqf9iyJTmlzGnHW9Jm2ziZQvK5Pm3qpGWFTdPM9ZY6gkt0Von+yoPKp7v7DF6JeiKoBZCgl7gTQHTyGm+U/djf2IIGOTo5/gVqDFtvCyKAv4x/c/25FTh1v6p8/HPbgXcFtpffzm1euEYD5NZDebh9jhOhpsNV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174127; c=relaxed/simple;
	bh=5xBRl6LYJX84sBYDQoMlNHxrwFZvRBjU54HJ4TDu9v0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iY2xEib41ddbV7FcH7KC8WnH5cmnGNcj3PGXrmCtynES1bomN8Q4TVoMRYZVJ6gVXCYW+EjKVSt9+yID3pHqK3pgQ8lqPboZdrvntDrRay1Q9G0poV4AsVBzSNYzhRSc+DNx0PB73EJL5MHkLeLBhW101rY2EOJKn2JbhuO67dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VaaKdBD0; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B2LFL7T1522484
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 2 Dec 2024 15:15:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733174121;
	bh=n22cYySdwX9dZAn+uyVPdwYnc8ISC4OTsUIj22ELFlU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VaaKdBD0Gw8VJmuXm2GzC4PF/mqKsqQzG+W1pK+j21Q5A4t0aAV/JyjciEm4W92j1
	 aMH5uGT95NsNdw2tAo//DqRGoPP/EQj1cnh1ozROcygDOuKp/HKX2I36n1j4jtrCE3
	 NPO96LbWZP+2Fv5Ne2QBwRvP7uofBfm+SqOgqHG0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B2LFLhe121625;
	Mon, 2 Dec 2024 15:15:21 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Dec 2024 15:15:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Dec 2024 15:15:21 -0600
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B2LFKgs099805;
	Mon, 2 Dec 2024 15:15:21 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 5/5] power: supply: ds2782: Use devm_delayed_work_autocancel() helper
Date: Mon, 2 Dec 2024 15:15:19 -0600
Message-ID: <20241202211519.199635-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241202211519.199635-1-afd@ti.com>
References: <20241202211519.199635-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Use the device lifecycle managed work init function. This helps prevent
mistakes like canceling out of order in cleanup functions and
forgetting to canceling on error paths.

Note we move this to after the registering the power supply so that
the cancel is called before unregistering.

This was the last thing the .remove() function did, so remove that too.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/ds2782_battery.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
index ea687b9703314..cae95d35d3980 100644
--- a/drivers/power/supply/ds2782_battery.c
+++ b/drivers/power/supply/ds2782_battery.c
@@ -11,6 +11,7 @@
  * UEvent sending added by Evgeny Romanov <romanov@neurosoft.ru>
  */
 
+#include <linux/devm-helpers.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -310,13 +311,6 @@ static void ds278x_power_supply_init(struct power_supply_desc *battery)
 	battery->external_power_changed	= NULL;
 }
 
-static void ds278x_battery_remove(struct i2c_client *client)
-{
-	struct ds278x_info *info = i2c_get_clientdata(client);
-
-	cancel_delayed_work_sync(&info->bat_work);
-}
-
 #ifdef CONFIG_PM_SLEEP
 
 static int ds278x_suspend(struct device *dev)
@@ -412,18 +406,19 @@ static int ds278x_battery_probe(struct i2c_client *client)
 	info->capacity = 100;
 	info->status = POWER_SUPPLY_STATUS_FULL;
 
-	INIT_DELAYED_WORK(&info->bat_work, ds278x_bat_work);
-
 	info->battery = devm_power_supply_register(&client->dev,
 						   &info->battery_desc,
 						   &psy_cfg);
 	if (IS_ERR(info->battery)) {
 		dev_err(&client->dev, "failed to register battery\n");
 		return PTR_ERR(info->battery);
-	} else {
-		schedule_delayed_work(&info->bat_work, DS278x_DELAY);
 	}
 
+	ret = devm_delayed_work_autocancel(&client->dev, &info->bat_work, ds278x_bat_work);
+	if (ret)
+		return ret;
+	schedule_delayed_work(&info->bat_work, DS278x_DELAY);
+
 	return 0;
 }
 
@@ -440,7 +435,6 @@ static struct i2c_driver ds278x_battery_driver = {
 		.pm	= &ds278x_battery_pm_ops,
 	},
 	.probe		= ds278x_battery_probe,
-	.remove		= ds278x_battery_remove,
 	.id_table	= ds278x_id,
 };
 module_i2c_driver(ds278x_battery_driver);
-- 
2.39.2


