Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA95FA6CF
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJJVDt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 17:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJJVDh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 17:03:37 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8D1D74
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 14:03:34 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 18AD084EF5;
        Mon, 10 Oct 2022 23:03:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665435810;
        bh=hQ6dxFTvjUuGsBkXzbyUMAxYR2mdPX3HxHMDMIq1Jus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpvIslr70G7ZdYSziDVWWGY1cWOIFRJzlFkFIhbzRTF51sDQx4jEJ7aYnFynmXXY1
         ebTT3QOdiLejX3OKJ/VlmwRq2jOVLjhwjys/B3aBCAEvJBqdXg2IkR//QojLY4lEpY
         8ZgcYixzclTZ8R9ZwYGGjW4AHjMaO69TFejSg9iXUqUw8jY6/2qhtC6tyYXuhiUwiN
         v+WEG3F0YuB62Nmadtv/l6+yOdR6U1KF1oh5iK+1Ro9uQ1J5LT5Ojjjs0L7HEg5hcW
         dz3UdvLnv5yLyni5I1tw8XanRkbojTHKu5+MvKm9P8E/BEwz3YHxqwEfa1ki/5NviY
         tYLhWoC2LNh/Q==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 7/7] power: supply: bq25890: Add Vsys regulator
Date:   Mon, 10 Oct 2022 23:03:10 +0200
Message-Id: <20221010210310.165461-7-marex@denx.de>
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

The chip is capable of reporting Vsys voltage supplied to the system.
Add regulator which represents the Vsys supply. This can be used e.g.
as a supply for system PMIC input.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org
---
 drivers/power/supply/bq25890_charger.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 2be5861cfcb66..d8c39a0d6c965 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1106,6 +1106,20 @@ static int bq25890_vbus_get_voltage(struct regulator_dev *rdev)
 	return bq25890_get_vbus_voltage(bq);
 }
 
+static int bq25890_vsys_get_voltage(struct regulator_dev *rdev)
+{
+	struct bq25890_device *bq = rdev_get_drvdata(rdev);
+	int ret;
+
+	/* Should be some output voltage ? */
+	ret = bq25890_field_read(bq, F_SYSV); /* read measured value */
+	if (ret < 0)
+		return ret;
+
+	/* converted_val = 2.304V + ADC_val * 20mV (table 10.3.15) */
+	return 2304000 + ret * 20000;
+}
+
 static const struct regulator_ops bq25890_vbus_ops = {
 	.get_voltage = bq25890_vbus_get_voltage,
 };
@@ -1133,6 +1147,18 @@ static const struct regulator_desc bq25890_vbus_boost_desc = {
 	.ops = &bq25890_vbus_boost_ops,
 };
 
+static const struct regulator_ops bq25890_vsys_ops = {
+	.get_voltage = bq25890_vsys_get_voltage,
+};
+
+static const struct regulator_desc bq25890_vsys_desc = {
+	.name = "vsys",
+	.of_match = "vsys",
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &bq25890_vsys_ops,
+};
+
 static int bq25890_register_regulator(struct bq25890_device *bq)
 {
 	struct bq25890_platform_data *pdata = dev_get_platdata(bq->dev);
@@ -1155,6 +1181,12 @@ static int bq25890_register_regulator(struct bq25890_device *bq)
 				     "registering vbus regulator");
 	}
 
+	reg = devm_regulator_register(bq->dev, &bq25890_vsys_desc, &cfg);
+	if (IS_ERR(reg)) {
+		return dev_err_probe(bq->dev, PTR_ERR(reg),
+				     "registering vsys regulator");
+	}
+
 	return 0;
 }
 #else
-- 
2.35.1

