Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640DB5FF2ED
	for <lists+linux-pm@lfdr.de>; Fri, 14 Oct 2022 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJNRYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Oct 2022 13:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJNRYr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2022 13:24:47 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3D02034C
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2022 10:24:45 -0700 (PDT)
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 66C2484E06;
        Fri, 14 Oct 2022 19:24:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1665768282;
        bh=K2k5df5lZclEJ1dGj4cIudVKupk1fZ4v4yq/yYhJEsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCVdXEFO5imgHhfEoc4Vy3yAZKCkPQx0gQnZ6glftwZuJJ+j37fS4SZFuKmmXPAVN
         UNNGGWbVFQbk/ZfdbJnfagBX1QIBhZk3L2ifiFDgCgwFhLwFPRZo7FH5EapvistFp/
         q2T7/e6QeVY0hrw7vLI1SkebdDEi7w9tiERWZK9h9M9HIpNfvnw7j3s8JQwm1IQBTI
         WAGRDMi+VKL1DS8JXarG5OYyU8IGlwfP8QLlPnctRHYPs7ktbZz0mQhvOi3ESF6IXV
         n3mxmpYzXCGlEIQ1NcOC5qKX/BVLYV1KPGpczj385ArT3z821Fcusi/Nb2Rz9JcdpS
         t7tDiNjJN+ovA==
From:   Marek Vasut <marex@denx.de>
To:     linux-pm@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v2 6/7] power: supply: bq25890: Add get_voltage support to Vbus regulator
Date:   Fri, 14 Oct 2022 19:24:26 +0200
Message-Id: <20221014172427.128512-6-marex@denx.de>
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
V2: Simplify the Vbus regulator registration, quoting Hans:
    "
    AFAIK if the Vboost regulator is not referenced in dt because
    it is controller through the usb-phy framework then valid_ops_mask
    will be empty, so the 2 sets of ops + 2 descs are not necessary
    I believe.
    So I believe this can be simplified to just adding
    bq25890_vbus_get_voltage to the ops, dropping .fixed_uV and
    .n_voltages from the desc, and just completely dropping
    the IS_ERR_OR_NULL(bq->usb_phy) check.
    "
---
 drivers/power/supply/bq25890_charger.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index dad98b782a2f8..ad5811304f88a 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1095,10 +1095,18 @@ static int bq25890_vbus_is_enabled(struct regulator_dev *rdev)
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
 	.enable = bq25890_vbus_enable,
 	.disable = bq25890_vbus_disable,
 	.is_enabled = bq25890_vbus_is_enabled,
+	.get_voltage = bq25890_vbus_get_voltage,
 };
 
 static const struct regulator_desc bq25890_vbus_desc = {
@@ -1107,8 +1115,6 @@ static const struct regulator_desc bq25890_vbus_desc = {
 	.type = REGULATOR_VOLTAGE,
 	.owner = THIS_MODULE,
 	.ops = &bq25890_vbus_ops,
-	.fixed_uV = 5000000,
-	.n_voltages = 1,
 };
 
 static int bq25890_register_regulator(struct bq25890_device *bq)
@@ -1120,9 +1126,6 @@ static int bq25890_register_regulator(struct bq25890_device *bq)
 	};
 	struct regulator_dev *reg;
 
-	if (!IS_ERR_OR_NULL(bq->usb_phy))
-		return 0;
-
 	if (pdata)
 		cfg.init_data = pdata->regulator_init_data;
 
-- 
2.35.1

