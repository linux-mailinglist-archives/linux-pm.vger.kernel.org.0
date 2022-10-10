Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE105FA6D2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 23:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJJVDv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 17:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJJVDd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 17:03:33 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A70DAE
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 14:03:31 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 84F7084EEF;
        Mon, 10 Oct 2022 23:03:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665435809;
        bh=mRQdk3brbGeJf1K73bMiGjfa32rDqapFN3g/wg0cYmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RapKxzwwwTfL/hFrxysAhh0qZfLRyS1PAQ0gMzoLiJRsE5GunWYRjJECy+RQOe5oe
         Eu2zL4YGABnx9o7t7Ycd/JjwuR5WVO4pac1QknBA6Oz9I9Xs8a9mSVZqN6pWylD5KJ
         uNvRB27f3q+lFxU0ErpLvRbNBFZtGTfsKG8GgbyKQFEI5LpqU6Ns1sl4mJ/a1v+GHt
         R2oomQvIwORdjCTg2qebHd+5UB/msuOXGgWceiGUctNnC0jJrOLhSNbcwWXX3hDJv1
         qD1TK4DRnn0b6zbN5JgDnCTDNW8IjUsxQBYglBv1ywO5+ZLVPmQhkJZpWyhu8A3xup
         jbsJt6ZLd1HQQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5/7] power: supply: bq25890: Factor out regulator registration code
Date:   Mon, 10 Oct 2022 23:03:08 +0200
Message-Id: <20221010210310.165461-5-marex@denx.de>
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

Pull the regulator registration code into separate function, so it can
be extended to register more regulators later. Currently this is only
moving ifdeffery into one place and other preparatory changes. The
dev_err_probe() output string is changed to explicitly list vbus
regulator failure, so that once more regulators are registered, it
would be clear which one failed.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org
---
 drivers/power/supply/bq25890_charger.c | 51 ++++++++++++++++++--------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 6cc3c23cd8853..7ab27a9dce14a 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1114,6 +1114,36 @@ static const struct regulator_desc bq25890_vbus_desc = {
 	.fixed_uV = 5000000,
 	.n_voltages = 1,
 };
+
+static int bq25890_register_regulator(struct bq25890_device *bq)
+{
+	struct bq25890_platform_data *pdata = dev_get_platdata(bq->dev);
+	struct regulator_config cfg = {
+		.dev = bq->dev,
+		.driver_data = bq,
+	};
+	struct regulator_dev *reg;
+
+	if (!IS_ERR_OR_NULL(bq->usb_phy))
+		return 0;
+
+	if (pdata)
+		cfg.init_data = pdata->regulator_init_data;
+
+	reg = devm_regulator_register(bq->dev, &bq25890_vbus_desc, &cfg);
+	if (IS_ERR(reg)) {
+		return dev_err_probe(bq->dev, PTR_ERR(reg),
+				     "registering vbus regulator");
+	}
+
+	return 0;
+}
+#else
+static inline int
+bq25890_register_regulator(struct bq25890_device *bq)
+{
+	return 0
+}
 #endif
 
 static int bq25890_get_chip_version(struct bq25890_device *bq)
@@ -1309,27 +1339,16 @@ static int bq25890_probe(struct i2c_client *client,
 
 	/* OTG reporting */
 	bq->usb_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+
+	ret = bq25890_register_regulator(bq);
+	if (ret)
+		return ret;
+
 	if (!IS_ERR_OR_NULL(bq->usb_phy)) {
 		INIT_WORK(&bq->usb_work, bq25890_usb_work);
 		bq->usb_nb.notifier_call = bq25890_usb_notifier;
 		usb_register_notifier(bq->usb_phy, &bq->usb_nb);
 	}
-#ifdef CONFIG_REGULATOR
-	else {
-		struct bq25890_platform_data *pdata = dev_get_platdata(dev);
-		struct regulator_config cfg = { };
-		struct regulator_dev *reg;
-
-		cfg.dev = dev;
-		cfg.driver_data = bq;
-		if (pdata)
-			cfg.init_data = pdata->regulator_init_data;
-
-		reg = devm_regulator_register(dev, &bq25890_vbus_desc, &cfg);
-		if (IS_ERR(reg))
-			return dev_err_probe(dev, PTR_ERR(reg), "registering regulator");
-	}
-#endif
 
 	ret = bq25890_power_supply_init(bq);
 	if (ret < 0) {
-- 
2.35.1

