Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A9781EFC
	for <lists+linux-pm@lfdr.de>; Sun, 20 Aug 2023 19:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjHTRQU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Aug 2023 13:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjHTRQQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Aug 2023 13:16:16 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43D841BC0;
        Sun, 20 Aug 2023 10:11:57 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,188,1684767600"; 
   d="scan'208";a="173400515"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2023 02:11:56 +0900
Received: from localhost.localdomain (unknown [10.226.92.18])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2B3C440062AF;
        Mon, 21 Aug 2023 02:11:53 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 2/2 RESEND] power: supply: sbs-battery: Convert enum->pointer for data in the match tables
Date:   Sun, 20 Aug 2023 18:11:45 +0100
Message-Id: <20230820171145.82662-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230820171145.82662-1-biju.das.jz@bp.renesas.com>
References: <20230820171145.82662-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert enum->pointer for data in the match tables, so that
device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
bus type match support added to it and it returns NULL for non-match.

Therefore it is better to convert enum->pointer for data match and extend
match support for both ID and OF tables using i2c_get_match_data() by
adding struct sbs_data with flags variable and replacing flags->data in
struct sbs_info.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/power/supply/sbs-battery.c | 42 ++++++++++++++++++------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 50b11b6df1b3..06df188c9229 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -201,6 +201,10 @@ static const enum power_supply_property string_properties[] = {
 
 #define NR_STRING_BUFFERS	ARRAY_SIZE(string_properties)
 
+struct sbs_data {
+	u32 flags;
+};
+
 struct sbs_info {
 	struct i2c_client		*client;
 	struct power_supply		*power_supply;
@@ -213,7 +217,7 @@ struct sbs_info {
 	u32				poll_retry_count;
 	struct delayed_work		work;
 	struct mutex			mode_lock;
-	u32				flags;
+	const struct sbs_data		*data;
 	int				technology;
 	char				strings[NR_STRING_BUFFERS][I2C_SMBUS_BLOCK_MAX + 1];
 };
@@ -579,7 +583,7 @@ static int sbs_get_battery_presence_and_health(
 	struct sbs_info *chip = i2c_get_clientdata(client);
 	int ret;
 
-	if (chip->flags & SBS_FLAGS_TI_BQ20ZX5)
+	if (chip->data->flags & SBS_FLAGS_TI_BQ20ZX5)
 		return sbs_get_ti_battery_presence_and_health(client, psp, val);
 
 	/* Dummy command; if it succeeds, battery is present. */
@@ -1135,7 +1139,7 @@ static int sbs_probe(struct i2c_client *client)
 	if (!chip)
 		return -ENOMEM;
 
-	chip->flags = (u32)(uintptr_t)device_get_match_data(&client->dev);
+	chip->data = i2c_get_match_data(client);
 	chip->client = client;
 	psy_cfg.of_node = client->dev.of_node;
 	psy_cfg.drv_data = chip;
@@ -1233,7 +1237,7 @@ static int sbs_suspend(struct device *dev)
 	if (chip->poll_time > 0)
 		cancel_delayed_work_sync(&chip->work);
 
-	if (chip->flags & SBS_FLAGS_TI_BQ20ZX5) {
+	if (chip->data->flags & SBS_FLAGS_TI_BQ20ZX5) {
 		/* Write to manufacturer access with sleep command. */
 		ret = sbs_write_word_data(client,
 					  sbs_data[REG_MANUFACTURER_DATA].addr,
@@ -1252,24 +1256,30 @@ static SIMPLE_DEV_PM_OPS(sbs_pm_ops, sbs_suspend, NULL);
 #define SBS_PM_OPS NULL
 #endif
 
+static const struct sbs_data bq20z65 = {
+	.flags = SBS_FLAGS_TI_BQ20ZX5,
+};
+
+static const struct sbs_data bq20z75 = {
+	.flags = SBS_FLAGS_TI_BQ20ZX5,
+};
+
+static const struct sbs_data sbs_battery = {
+	.flags = 0,
+};
+
 static const struct i2c_device_id sbs_id[] = {
-	{ "bq20z65", SBS_FLAGS_TI_BQ20ZX5 },
-	{ "bq20z75", SBS_FLAGS_TI_BQ20ZX5 },
-	{ "sbs-battery", 0 },
+	{ "bq20z65", (kernel_ulong_t)&bq20z65 },
+	{ "bq20z75", (kernel_ulong_t)&bq20z75 },
+	{ "sbs-battery", (kernel_ulong_t)&sbs_battery },
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, sbs_id);
 
 static const struct of_device_id sbs_dt_ids[] = {
-	{ .compatible = "sbs,sbs-battery" },
-	{
-		.compatible = "ti,bq20z65",
-		.data = (void *)SBS_FLAGS_TI_BQ20ZX5,
-	},
-	{
-		.compatible = "ti,bq20z75",
-		.data = (void *)SBS_FLAGS_TI_BQ20ZX5,
-	},
+	{ .compatible = "sbs,sbs-battery", .data = &sbs_battery },
+	{ .compatible = "ti,bq20z65", .data = &bq20z65 },
+	{ .compatible = "ti,bq20z75", .data = &bq20z75 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sbs_dt_ids);
-- 
2.25.1

