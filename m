Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B2C5FA6CE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiJJVDt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 17:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJJVDh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 17:03:37 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AD7C34
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 14:03:34 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CB8C284EF3;
        Mon, 10 Oct 2022 23:03:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665435810;
        bh=40XmUzEUh5WZYYjvosGCjuzdtvinXauh/WTQ7N4WaG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHdRbIKK95IdIkXxxQUtfAduaSd8oq46Zx+oeTLNH0IyPJXdvqxw2IoDgPpo31TEk
         TaXKuo+0HpqA9kELivnhSj3vZGS+oWLXQ3jJKf+q3TNkTjO1mKS0a09N6eloME7E2M
         ADrHtQ2fLxhEOR+iabe1ajc5mKitwqQd9eDVgENDMwEdiyEDlzh6ez+YpNZXWSWsRR
         kiBErv2IXXs0Aeyeftq8f50RqkpIbDjb5f+9pqLDnJr0qa9VCZ+Fi5tECfyAILuO7T
         uc2bp/eSo3rzdL9W8FXzPvvrgZgDVYPfewuIvZcr/cBgCXZT6jMPrP1TC8cN6KwQAn
         6A2K3pWAHJSGw==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6/7] power: supply: bq25890: Add get_voltage support to Vbus regulator
Date:   Mon, 10 Oct 2022 23:03:09 +0200
Message-Id: <20221010210310.165461-6-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221010210310.165461-1-marex@denx.de>
References: <20221010210310.165461-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The chip is capable of reporting Vbus voltage, add .get_voltage
implementation to Vbus regulator to report current Vbus voltage.
This requires for the Vbus regulator to be registered always
instead of the current state where the regulator is registered
only in case USB PHY is not found.

Do not provide Vbus regulator enable/disable ops in case USB PHY
is present, as they would race with USB PHY notifier which is also
used to toggle OTG boost mode.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org
---
 drivers/power/supply/bq25890_charger.c | 33 ++++++++++++++++++++------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 7ab27a9dce14a..2be5861cfcb66 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1099,38 +1099,57 @@ static int bq25890_vbus_is_enabled(struct regulator_dev *rdev)
 	return bq25890_field_read(bq, F_OTG_CFG);
 }
 
+static int bq25890_vbus_get_voltage(struct regulator_dev *rdev)
+{
+	struct bq25890_device *bq = rdev_get_drvdata(rdev);
+
+	return bq25890_get_vbus_voltage(bq);
+}
+
 static const struct regulator_ops bq25890_vbus_ops = {
+	.get_voltage = bq25890_vbus_get_voltage,
+};
+
+static const struct regulator_desc bq25890_vbus_desc = {
+	.name = "usb_otg_vbus",
+	.of_match = "usb-otg-vbus",
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &bq25890_vbus_ops,
+};
+
+static const struct regulator_ops bq25890_vbus_boost_ops = {
 	.enable = bq25890_vbus_enable,
 	.disable = bq25890_vbus_disable,
 	.is_enabled = bq25890_vbus_is_enabled,
+	.get_voltage = bq25890_vbus_get_voltage,
 };
 
-static const struct regulator_desc bq25890_vbus_desc = {
+static const struct regulator_desc bq25890_vbus_boost_desc = {
 	.name = "usb_otg_vbus",
 	.of_match = "usb-otg-vbus",
 	.type = REGULATOR_VOLTAGE,
 	.owner = THIS_MODULE,
-	.ops = &bq25890_vbus_ops,
-	.fixed_uV = 5000000,
-	.n_voltages = 1,
+	.ops = &bq25890_vbus_boost_ops,
 };
 
 static int bq25890_register_regulator(struct bq25890_device *bq)
 {
 	struct bq25890_platform_data *pdata = dev_get_platdata(bq->dev);
+	const struct regulator_desc *desc;
 	struct regulator_config cfg = {
 		.dev = bq->dev,
 		.driver_data = bq,
 	};
 	struct regulator_dev *reg;
 
-	if (!IS_ERR_OR_NULL(bq->usb_phy))
-		return 0;
+	desc = IS_ERR_OR_NULL(bq->usb_phy) ?
+	       &bq25890_vbus_boost_desc : &bq25890_vbus_desc;
 
 	if (pdata)
 		cfg.init_data = pdata->regulator_init_data;
 
-	reg = devm_regulator_register(bq->dev, &bq25890_vbus_desc, &cfg);
+	reg = devm_regulator_register(bq->dev, desc, &cfg);
 	if (IS_ERR(reg)) {
 		return dev_err_probe(bq->dev, PTR_ERR(reg),
 				     "registering vbus regulator");
-- 
2.35.1

