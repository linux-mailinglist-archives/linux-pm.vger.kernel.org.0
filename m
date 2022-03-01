Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BC04C7F4A
	for <lists+linux-pm@lfdr.de>; Tue,  1 Mar 2022 01:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiCAAdH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Feb 2022 19:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiCAAdG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Feb 2022 19:33:06 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3267A0BE4
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 16:32:26 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id t14so19688445ljh.8
        for <linux-pm@vger.kernel.org>; Mon, 28 Feb 2022 16:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MMcrbRJzTpSO6nt2X4LAxSWGHZczllOZhS4vz9AMz8=;
        b=W2vFgjn2EbSFWqjLzpRr51O2FSwLl21KJRTeYOYXA7M8pNDm0f2zw1iLtKeJj74Wf+
         3s3KR2gsHqPiScDgaoaVXqv+KWQA5pTU2F537hfbta8p2/CLcjeDnvcobnRfFcoBgS0S
         cjd5xhAwxoQv2RTdMAy+V6nU1WWpl6gMvXZMGnzPvY1852tky0q1ceAMRTkzczHK9zqx
         gSlAIAEnGGxnElGHwKunS0Yk4eyAtfrqp1mAEck8GibGeTE+Cckq6aG22hYIrytFalLM
         7Ygq7yCL+/g0yAe8V5DT6eEre1J3Bv1+EAyR56M5BskWY2gFs3Nll4PDR5XRzLBUoo4p
         eepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8MMcrbRJzTpSO6nt2X4LAxSWGHZczllOZhS4vz9AMz8=;
        b=FyeGIgSCYGGML3toRg5aY526JdpPXgST0JF5VNCN0nkGBYW5+54kx64fthHFFcYxEm
         3mqbKtj5W6b+6v/8xcPMptkLBfiTCi616SehOkvs8jLPIla+XqUz7M4rFZSa/sUsaJEO
         ktD0x3Ws8BNB3rIDZXY3w41e4TwV1zkpfn7mjdc9TZjPQVG7w2lcv2Hn838EUpAeIp1+
         8secxZg2Oapf5mcJSH9XDBbLFdPrMUDBUL6PVzd47rn5/vXP9hYzO2KiLZhZ4yka6jqG
         T7/AYvpGisM+T8HbpFJhZ6Hw3MNdCbRxuxGkiJBR2TcrhYPMl2K9n8C7irf/+iIVy0ZJ
         kVqg==
X-Gm-Message-State: AOAM532qrRIb4BBZM1XcYO/USbt5+vnVoXw/m3coeASY7o6M1hxlX1n6
        Tl76o1a3N2MKNiNx3vjLxUhJNQmcWquOm21G
X-Google-Smtp-Source: ABdhPJwcExaUStqXavzXtMGlwXbNi9DqkH7eLBGco5a8FcIc+mMN8i0KQW1wYa/TtRgR2dPoMjZYtQ==
X-Received: by 2002:a2e:780f:0:b0:246:376d:952c with SMTP id t15-20020a2e780f000000b00246376d952cmr15416926ljc.349.1646094745005;
        Mon, 28 Feb 2022 16:32:25 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id y22-20020a05651c021600b0024608599f1esm1625769ljn.86.2022.02.28.16.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 16:32:24 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] power: supply: Fix static batteries
Date:   Tue,  1 Mar 2022 01:30:20 +0100
Message-Id: <20220301003020.2308835-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The code for looking up static battery data was erroneously
rebased and assumed we were only using device tree, but we have
added fwnode support.

Augment the code properly to just pass in a compatible as a
string when looking up a static Samsung battery, also move
the fwnode parsing code up so we can still check this before
we move on to simple-battery and start allocating stuff.

Fixes: ffb983d31519 ("power: supply: Static data for Samsung batteries")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/power_supply_core.c   | 63 +++++++++++-----------
 drivers/power/supply/samsung-sdi-battery.c |  5 +-
 drivers/power/supply/samsung-sdi-battery.h |  4 +-
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 44816d41b4ec..ea02c8dcd748 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -579,16 +579,42 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	const __be32 *list;
 	u32 min_max[2];
 
+	if (psy->of_node) {
+		battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
+		if (!battery_np)
+			return -ENODEV;
+
+		fwnode = fwnode_handle_get(of_fwnode_handle(battery_np));
+	} else {
+		err = fwnode_property_get_reference_args(
+					dev_fwnode(psy->dev.parent),
+					"monitored-battery", NULL, 0, 0, &args);
+		if (err)
+			return err;
+
+		fwnode = args.fwnode;
+	}
+
+	err = fwnode_property_read_string(fwnode, "compatible", &value);
+	if (err)
+		goto out_put_node;
+
+
 	/* Try static batteries first */
-	err = samsung_sdi_battery_get_info(&psy->dev, battery_np, &info);
-	if (!err) {
-		*info_out = info;
-		return err;
+	err = samsung_sdi_battery_get_info(&psy->dev, value, &info);
+	if (!err)
+		goto out_ret_pointer;
+
+	if (strcmp("simple-battery", value)) {
+		err = -ENODEV;
+		goto out_put_node;
 	}
 
 	info = devm_kmalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
+	if (!info) {
+		err = -ENOMEM;
+		goto out_put_node;
+	}
 
 	info->technology                     = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 	info->energy_full_design_uwh         = -EINVAL;
@@ -625,31 +651,6 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		info->ocv_table_size[index]  = -EINVAL;
 	}
 
-	if (psy->of_node) {
-		battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
-		if (!battery_np)
-			return -ENODEV;
-
-		fwnode = fwnode_handle_get(of_fwnode_handle(battery_np));
-	} else {
-		err = fwnode_property_get_reference_args(
-					dev_fwnode(psy->dev.parent),
-					"monitored-battery", NULL, 0, 0, &args);
-		if (err)
-			return err;
-
-		fwnode = args.fwnode;
-	}
-
-	err = fwnode_property_read_string(fwnode, "compatible", &value);
-	if (err)
-		goto out_put_node;
-
-	if (strcmp("simple-battery", value)) {
-		err = -ENODEV;
-		goto out_put_node;
-	}
-
 	/* The property and field names below must correspond to elements
 	 * in enum power_supply_property. For reasoning, see
 	 * Documentation/power/power_supply_class.rst.
diff --git a/drivers/power/supply/samsung-sdi-battery.c b/drivers/power/supply/samsung-sdi-battery.c
index 64ec34a41c5b..9d59f277f519 100644
--- a/drivers/power/supply/samsung-sdi-battery.c
+++ b/drivers/power/supply/samsung-sdi-battery.c
@@ -10,7 +10,6 @@
  * the BTI resistance with a multimeter on the battery.
  */
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/power_supply.h>
 #include "samsung-sdi-battery.h"
 
@@ -895,7 +894,7 @@ static struct samsung_sdi_battery samsung_sdi_batteries[] = {
 };
 
 int samsung_sdi_battery_get_info(struct device *dev,
-				 struct device_node *np,
+				 const char *compatible,
 				 struct power_supply_battery_info **info)
 {
 	struct samsung_sdi_battery *batt;
@@ -903,7 +902,7 @@ int samsung_sdi_battery_get_info(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(samsung_sdi_batteries); i++) {
 		batt = &samsung_sdi_batteries[i];
-		if (of_device_is_compatible(np, batt->compatible))
+		if (!strcmp(compatible, batt->compatible))
 			break;
 	}
 
diff --git a/drivers/power/supply/samsung-sdi-battery.h b/drivers/power/supply/samsung-sdi-battery.h
index 08783847dfcb..365ab6e85b26 100644
--- a/drivers/power/supply/samsung-sdi-battery.h
+++ b/drivers/power/supply/samsung-sdi-battery.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #if IS_ENABLED(CONFIG_BATTERY_SAMSUNG_SDI)
 extern int samsung_sdi_battery_get_info(struct device *dev,
-				struct device_node *np,
+				const char *compatible,
 				struct power_supply_battery_info **info);
 #else
 static inline int samsung_sdi_battery_get_info(struct device *dev,
-				struct device_node *np,
+				const char *compatible,
 				struct power_supply_battery_info **info)
 {
 	return -ENODEV;
-- 
2.34.1

