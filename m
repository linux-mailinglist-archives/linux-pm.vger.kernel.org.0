Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5C45FF2EE
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 19:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJNRYu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Oct 2022 13:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiJNRYr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 13:24:47 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8AF20356
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 10:24:45 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B407384EA8;
        Fri, 14 Oct 2022 19:24:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665768282;
        bh=MwkRKajwC9OjsHcqszKSG7RdYaNHhDBu9jjx3tOZ8vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cnZfB++qNyCKJ5Lb/SR8NLUHe43pnnfFiAPODTtlcXNpbxpG3U9K58de89EM/HFj9
         oqSUOxAGpPbckgemiB4yB6uw0CDcwL1aCNjwv9cXcom5Hi5uTwhAGn5zYbrC/O4LiR
         fhijz0sDybi+8YCSuGrz4HHOiW+7p8Q/H1ldiaGYGQxhrXADZp2vCPbZrbGwelhgRY
         84RksGIZHxsnI6WOgUVF1J6gZGJY31O9QweyhwCKxXoTTMk3HnhYygbCYEjbSjD+BW
         eErR1auysQvQqKjOfWKeiH1e0y4gks17jTja2prvZ+LgwhkhRHtu2XjbR9zPjSyvhu
         5wcqB91+nVwBw==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 7/7] power: supply: bq25890: Add Vsys regulator
Date:   Fri, 14 Oct 2022 19:24:27 +0200
Message-Id: <20221014172427.128512-7-marex@denx.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221014172427.128512-1-marex@denx.de>
References: <20221014172427.128512-1-marex@denx.de>
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

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-pm@vger.kernel.org
---
V2: Add RB from Hans
---
 drivers/power/supply/bq25890_charger.c | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index ad5811304f88a..f0362dcb935e9 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1102,6 +1102,20 @@ static int bq25890_vbus_get_voltage(struct regulator_dev *rdev)
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
 	.enable = bq25890_vbus_enable,
 	.disable = bq25890_vbus_disable,
@@ -1117,6 +1131,18 @@ static const struct regulator_desc bq25890_vbus_desc = {
 	.ops = &bq25890_vbus_ops,
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
@@ -1135,6 +1161,12 @@ static int bq25890_register_regulator(struct bq25890_device *bq)
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

