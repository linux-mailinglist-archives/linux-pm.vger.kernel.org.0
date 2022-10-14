Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F6D5FF2EC
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 19:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJNRYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Oct 2022 13:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJNRYr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 13:24:47 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DAB15A29
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 10:24:43 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1BE3484D60;
        Fri, 14 Oct 2022 19:24:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665768282;
        bh=TciFiHLuOGZpwS92HXKexR058loqiznd2zZrc8W2vyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUvK4rYg+HPri3V4X5ptgEVJVTA47xqvm4F7a4mqRXADf6yX6JQIyJ5IwbB7lZ/bx
         /ersFbIP6h0lJeWygpGTDooGJxpUQus/xC/I/1bqoRxvuQIkQVqN96GEOOGwGsb/qb
         WOjejfW2R66y8N+4zx1TlWTtFJfUcb1jQd9XZwi73b+w30Jw9MbsZW2mEfQFiXNSlF
         +tvOjd7sxnUnbAwzTGSr8Oyp5nPzA2A7ptbrkJM+Ed7GXh86Iw4mw+Wubfupf9sFFS
         NjzJftKlVUNUSB7pVcogDPGK2EkfNYiTe+7SNHbH+0K3CWzBtX8ASLk9akgSR2v4+t
         q3sXUrDam7m8w==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 5/7] power: supply: bq25890: Factor out regulator registration code
Date:   Fri, 14 Oct 2022 19:24:25 +0200
Message-Id: <20221014172427.128512-5-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221014172427.128512-1-marex@denx.de>
References: <20221014172427.128512-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org
---
V2: - Add the missing semicolon past return 0 in bq25890_register_regulator()
      in negative REGULATOR macro check branch
    - Add RB from Hans
---
 drivers/power/supply/bq25890_charger.c | 51 ++++++++++++++++++--------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 95803157ac4af..dad98b782a2f8 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1110,6 +1110,36 @@ static const struct regulator_desc bq25890_vbus_desc = {
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
+	return 0;
+}
 #endif
 
 static int bq25890_get_chip_version(struct bq25890_device *bq)
@@ -1305,27 +1335,16 @@ static int bq25890_probe(struct i2c_client *client,
 
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

