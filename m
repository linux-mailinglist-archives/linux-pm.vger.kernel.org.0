Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96371D1E30
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390403AbgEMS4g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:56:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51900 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390381AbgEMS4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 4724A2A0188
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7203A480103; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 05/19] power: supply: sbs-battery: Add TI BQ20Z65 support
Date:   Wed, 13 May 2020 20:56:01 +0200
Message-Id: <20200513185615.508236-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for BQ20Z65 manufacturer data to the sbs-battery
driver. Implementation has been verified using the public TRM
available from [0] and tested using a GE Flex 3S2P battery.

[0] http://www.ti.com/lit/pdf/sluu386

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/power/supply/sbs_sbs-battery.txt     |  1 +
 drivers/power/supply/sbs-battery.c                | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
index 4e78e51018eb..fa5a8b516dbf 100644
--- a/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt
@@ -6,6 +6,7 @@ Required properties :
      part number compatible string might be used in order to take care of
      vendor specific registers.
      Known <vendor>,<part-number>:
+       ti,bq20z65
        ti,bq20z75
 
 Optional properties :
diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 6acd242eed48..a15783802ef8 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -149,8 +149,8 @@ static enum power_supply_property sbs_properties[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME
 };
 
-/* Supports special manufacturer commands from TI BQ20Z75 IC. */
-#define SBS_FLAGS_TI_BQ20Z75		BIT(0)
+/* Supports special manufacturer commands from TI BQ20Z65 and BQ20Z75 IC. */
+#define SBS_FLAGS_TI_BQ20ZX5		BIT(0)
 
 struct sbs_info {
 	struct i2c_client		*client;
@@ -626,7 +626,7 @@ static int sbs_get_property(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
 	case POWER_SUPPLY_PROP_HEALTH:
-		if (chip->flags & SBS_FLAGS_TI_BQ20Z75)
+		if (chip->flags & SBS_FLAGS_TI_BQ20ZX5)
 			ret = sbs_get_ti_battery_presence_and_health(client,
 								     psp, val);
 		else
@@ -950,7 +950,7 @@ static int sbs_suspend(struct device *dev)
 	if (chip->poll_time > 0)
 		cancel_delayed_work_sync(&chip->work);
 
-	if (chip->flags & SBS_FLAGS_TI_BQ20Z75) {
+	if (chip->flags & SBS_FLAGS_TI_BQ20ZX5) {
 		/* Write to manufacturer access with sleep command. */
 		ret = sbs_write_word_data(client,
 					  sbs_data[REG_MANUFACTURER_DATA].addr,
@@ -970,6 +970,7 @@ static SIMPLE_DEV_PM_OPS(sbs_pm_ops, sbs_suspend, NULL);
 #endif
 
 static const struct i2c_device_id sbs_id[] = {
+	{ "bq20z65", 0 },
 	{ "bq20z75", 0 },
 	{ "sbs-battery", 1 },
 	{}
@@ -978,9 +979,13 @@ MODULE_DEVICE_TABLE(i2c, sbs_id);
 
 static const struct of_device_id sbs_dt_ids[] = {
 	{ .compatible = "sbs,sbs-battery" },
+	{
+		.compatible = "ti,bq20z65",
+		.data = (void *)SBS_FLAGS_TI_BQ20ZX5,
+	},
 	{
 		.compatible = "ti,bq20z75",
-		.data = (void *)SBS_FLAGS_TI_BQ20Z75,
+		.data = (void *)SBS_FLAGS_TI_BQ20ZX5,
 	},
 	{ }
 };
-- 
2.26.2

