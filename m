Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D004B38C3
	for <lists+linux-pm@lfdr.de>; Sun, 13 Feb 2022 01:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiBMAKJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Feb 2022 19:10:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiBMAKI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Feb 2022 19:10:08 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F185FF3E
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 16:10:01 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f41so16422082lfv.12
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 16:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=16BSjPER2+Fx4r/zqGdb2GDd0w3jwsyHCVporHCCAEY=;
        b=xTpo5XToZwya+y8Q6mXfTRppeBMt5ZEELg2Z+iHY6vXgv3+0t6TaLx21/puCf/sQlT
         rh2gsinTJQdPbhHY9Vo9Oi7TQlvzYDvNX+olWiFSvGlO7EWfSUjahIetVJG5Mfe7GnEK
         qHW+ERWOAf+LvwM6RFaOH4PWmRfYH97lOIpHNB031nfKpEv1DQdbyirpiqBEIE62cXhl
         eHwUPENVA8HGv5YCB+sGumN8K2n2Wy+IR1/6kj8z5wBWxicd78rG7lYTrxQZYLp1ZACM
         NtBqBQy4OD3ZM5QzU8Do2u7kgyrmdGvMxzNXgoWx7DAEVUfRonbQKC9v1jBjWOehS486
         eoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=16BSjPER2+Fx4r/zqGdb2GDd0w3jwsyHCVporHCCAEY=;
        b=K37EXTjcd2jfxjctB/koV6Qt6Pi+4VFOlmvyTGsNGkGZn/NHFcpdcho87H6gUqq1LX
         NEoVE96HCcf5UqlFhfkbn/xo8E9Y2/uSbIZBknwIFd1l1pZaTxrKIote0nE+yAU19Khr
         NOHz7HO6fZZca9p+5LFgPcyIrA2IXxnr9nSy5wMaNuLQtV8TByV2gM98IoCvpqLZcgoX
         VyQw03ZQosmMawtzuEjXMswklDs4OFx1OOYgM+gl7W3zlTtoVWwBPPbHtsUT+rxLHffI
         MCW2KelYwj8ZE+O4BSNyAwLTycDXhJ2tJefff1AZ6s9ASpa5u+JKE8Wl5BamHlSqQ7Ds
         p6/w==
X-Gm-Message-State: AOAM532BFy0hF+eYIgYYuGJ52mIz0o8Zte/I73eLBcdfqTdBfc6gLg/J
        5xkJuO/GDHfJ9DKkdUKCX7ELFA==
X-Google-Smtp-Source: ABdhPJyOyMKOVMqEbh6D4Uds0JCGImK2IhWPpl3gC5L9K735VK/85wXSTLAI3WPbTCqWOlwEbbQRzA==
X-Received: by 2002:a05:6512:3984:: with SMTP id j4mr5691504lfu.388.1644710999624;
        Sat, 12 Feb 2022 16:09:59 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id g30sm382292lja.39.2022.02.12.16.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:09:59 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6/6 v2] power: supply: Static data for Samsung batteries
Date:   Sun, 13 Feb 2022 01:07:03 +0100
Message-Id: <20220213000703.772673-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220213000703.772673-1-linus.walleij@linaro.org>
References: <20220213000703.772673-1-linus.walleij@linaro.org>
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

If we detect a Samsung SDI battery, we return a static
struct power_supply_battery_info and avoid looking further.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Bump tolerance to 40% on all BTI resistances
- Change config option to bool, as we are calling OUT from
  the supply core this cannot be compiled into a module
- Augment data to support low/high temperature charge current
  and voltages. Sadly the vendor tree just provide one and the
  same current and voltage for all of these.
---
 drivers/power/supply/Kconfig               |   6 +
 drivers/power/supply/Makefile              |   1 +
 drivers/power/supply/power_supply_core.c   |  28 +-
 drivers/power/supply/samsung-sdi-battery.c | 686 +++++++++++++++++++++
 drivers/power/supply/samsung-sdi-battery.h |  13 +
 5 files changed, 724 insertions(+), 10 deletions(-)
 create mode 100644 drivers/power/supply/samsung-sdi-battery.c
 create mode 100644 drivers/power/supply/samsung-sdi-battery.h

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 6815e5a4c0bd..e9df4151f2e0 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -181,6 +181,12 @@ config BATTERY_OLPC
 	help
 	  Say Y to enable support for the battery on the OLPC laptop.
 
+config BATTERY_SAMSUNG_SDI
+	bool "Samsung SDI batteries"
+	help
+	  Say Y to enable support for Samsung SDI battery data.
+	  These batteries are used in Samsung mobile phones.
+
 config BATTERY_TOSA
 	tristate "Sharp SL-6000 (tosa) battery"
 	depends on MACH_TOSA && MFD_TC6393XB && TOUCHSCREEN_WM97XX
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 2c1b264b2046..ebcd2f5fe26d 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_BATTERY_GOLDFISH)	+= goldfish_battery.o
 obj-$(CONFIG_BATTERY_LEGO_EV3)	+= lego_ev3_battery.o
 obj-$(CONFIG_BATTERY_PMU)	+= pmu_battery.o
 obj-$(CONFIG_BATTERY_OLPC)	+= olpc_battery.o
+obj-$(CONFIG_BATTERY_SAMSUNG_SDI)	+= samsung-sdi-battery.o
 obj-$(CONFIG_BATTERY_TOSA)	+= tosa_battery.o
 obj-$(CONFIG_BATTERY_COLLIE)	+= collie_battery.o
 obj-$(CONFIG_BATTERY_INGENIC)	+= ingenic-battery.o
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 1c0b1be22067..43c66214bedf 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -23,6 +23,7 @@
 #include <linux/thermal.h>
 #include <linux/fixp-arith.h>
 #include "power_supply.h"
+#include "samsung-sdi-battery.h"
 
 /* exported for the APM Power driver, APM emulation */
 struct class *power_supply_class;
@@ -573,6 +574,23 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	int err, len, index;
 	const __be32 *list;
 
+	if (!psy->of_node) {
+		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
+			 __func__);
+		return -ENXIO;
+	}
+
+	battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
+	if (!battery_np)
+		return -ENODEV;
+
+	/* Try static batteries first */
+	err = samsung_sdi_battery_get_info(&psy->dev, battery_np, &info);
+	if (!err) {
+		*info_out = info;
+		return err;
+	}
+
 	info = devm_kmalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
@@ -612,16 +630,6 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		info->ocv_table_size[index]  = -EINVAL;
 	}
 
-	if (!psy->of_node) {
-		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
-			 __func__);
-		return -ENXIO;
-	}
-
-	battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
-	if (!battery_np)
-		return -ENODEV;
-
 	err = of_property_read_string(battery_np, "compatible", &value);
 	if (err)
 		goto out_put_node;
diff --git a/drivers/power/supply/samsung-sdi-battery.c b/drivers/power/supply/samsung-sdi-battery.c
new file mode 100644
index 000000000000..c4e26a140042
--- /dev/null
+++ b/drivers/power/supply/samsung-sdi-battery.c
@@ -0,0 +1,686 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Battery data and characteristics for Samsung SDI (Samsung Digital Interface)
+ * batteries. The data is retrieved automatically into drivers using
+ * the power_supply_get_battery_info() call.
+ *
+ * The BTI (battery type indicator) resistance in the code drops was very
+ * unreliable. The resistance listed here was obtained by simply measuring
+ * the BTI resistance with a multimeter on the battery.
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/power_supply.h>
+#include "samsung-sdi-battery.h"
+
+struct samsung_sdi_battery {
+	char *compatible;
+	char *name;
+	struct power_supply_battery_info info;
+};
+
+/*
+ * Voltage to internal resistance tables. The internal resistance varies
+ * depending on the VBAT voltage, so look this up from a table. Different
+ * tables apply depending on whether we are charging or not.
+ */
+
+struct power_supply_vbat_ri_table samsung_vbat2res_charging_eb585157lu[] = {
+	{ .vbat_uv = 4071000, .ri_uohm = 158000 },
+	{ .vbat_uv = 4019000, .ri_uohm = 187000 },
+	{ .vbat_uv = 3951000, .ri_uohm = 191000 },
+	{ .vbat_uv = 3901000, .ri_uohm = 193000 },
+	{ .vbat_uv = 3850000, .ri_uohm = 273000 },
+	{ .vbat_uv = 3800000, .ri_uohm = 305000 },
+	{ .vbat_uv = 3750000, .ri_uohm = 205000 },
+	{ .vbat_uv = 3700000, .ri_uohm = 290000 },
+	{ .vbat_uv = 3650000, .ri_uohm = 262000 },
+	{ .vbat_uv = 3618000, .ri_uohm = 290000 },
+	{ .vbat_uv = 3505000, .ri_uohm = 235000 },
+	{ .vbat_uv = 3484000, .ri_uohm = 253000 },
+	{ .vbat_uv = 3413000, .ri_uohm = 243000 },
+	{ .vbat_uv = 3393000, .ri_uohm = 285000 },
+	{ .vbat_uv = 3361000, .ri_uohm = 281000 },
+	{ .vbat_uv = 3302000, .ri_uohm = 286000 },
+	{ .vbat_uv = 3280000, .ri_uohm = 250000 },
+};
+
+struct power_supply_vbat_ri_table samsung_vbat2res_discharging_eb585157lu[] = {
+	{ .vbat_uv = 4190000, .ri_uohm = 214000 },
+	{ .vbat_uv = 4159000, .ri_uohm = 252000 },
+	{ .vbat_uv = 4121000, .ri_uohm = 245000 },
+	{ .vbat_uv = 4069000, .ri_uohm = 228000 },
+	{ .vbat_uv = 4046000, .ri_uohm = 229000 },
+	{ .vbat_uv = 4026000, .ri_uohm = 233000 },
+	{ .vbat_uv = 4007000, .ri_uohm = 240000 },
+	{ .vbat_uv = 3982000, .ri_uohm = 291000 },
+	{ .vbat_uv = 3945000, .ri_uohm = 276000 },
+	{ .vbat_uv = 3924000, .ri_uohm = 266000 },
+	{ .vbat_uv = 3910000, .ri_uohm = 258000 },
+	{ .vbat_uv = 3900000, .ri_uohm = 271000 },
+	{ .vbat_uv = 3844000, .ri_uohm = 279000 },
+	{ .vbat_uv = 3772000, .ri_uohm = 217000 },
+	{ .vbat_uv = 3673000, .ri_uohm = 208000 },
+	{ .vbat_uv = 3571000, .ri_uohm = 208000 },
+	{ .vbat_uv = 3510000, .ri_uohm = 228000 },
+};
+
+struct power_supply_vbat_ri_table samsung_vbat2res_discharging_1500mah[] = {
+	{ .vbat_uv = 4240000, .ri_uohm = 160000 },
+	{ .vbat_uv = 4210000, .ri_uohm = 179000 },
+	{ .vbat_uv = 4180000, .ri_uohm = 183000 },
+	{ .vbat_uv = 4160000, .ri_uohm = 184000 },
+	{ .vbat_uv = 4140000, .ri_uohm = 191000 },
+	{ .vbat_uv = 4120000, .ri_uohm = 204000 },
+	{ .vbat_uv = 4080000, .ri_uohm = 200000 },
+	{ .vbat_uv = 4027000, .ri_uohm = 202000 },
+	{ .vbat_uv = 3916000, .ri_uohm = 221000 },
+	{ .vbat_uv = 3868000, .ri_uohm = 209000 },
+	{ .vbat_uv = 3818000, .ri_uohm = 276000 },
+	{ .vbat_uv = 3780000, .ri_uohm = 275000 },
+	{ .vbat_uv = 3746000, .ri_uohm = 230000 },
+	{ .vbat_uv = 3717000, .ri_uohm = 247000 },
+	{ .vbat_uv = 3695000, .ri_uohm = 263000 },
+	{ .vbat_uv = 3675000, .ri_uohm = 272000 },
+	{ .vbat_uv = 3667000, .ri_uohm = 285000 },
+	{ .vbat_uv = 3658000, .ri_uohm = 276000 },
+	{ .vbat_uv = 3647000, .ri_uohm = 263000 },
+	{ .vbat_uv = 3629000, .ri_uohm = 236000 },
+	{ .vbat_uv = 3618000, .ri_uohm = 229000 },
+	{ .vbat_uv = 3588000, .ri_uohm = 275000 },
+	{ .vbat_uv = 3503000, .ri_uohm = 341000 },
+	{ .vbat_uv = 3400000, .ri_uohm = 269000 },
+	{ .vbat_uv = 3360000, .ri_uohm = 328000 },
+	{ .vbat_uv = 3330000, .ri_uohm = 305000 },
+	{ .vbat_uv = 3300000, .ri_uohm = 339000 },
+};
+
+struct power_supply_vbat_ri_table samsung_vbat2res_charging_1500mah[] = {
+	{ .vbat_uv = 4302000, .ri_uohm = 200000 },
+	{ .vbat_uv = 4258000, .ri_uohm = 206000 },
+	{ .vbat_uv = 4200000, .ri_uohm = 231000 },
+	{ .vbat_uv = 4150000, .ri_uohm = 198000 },
+	{ .vbat_uv = 4100000, .ri_uohm = 205000 },
+	{ .vbat_uv = 4077000, .ri_uohm = 261000 },
+	{ .vbat_uv = 4039000, .ri_uohm = 238000 },
+	{ .vbat_uv = 4004000, .ri_uohm = 264000 },
+	{ .vbat_uv = 3975000, .ri_uohm = 287000 },
+	{ .vbat_uv = 3917000, .ri_uohm = 295000 },
+	{ .vbat_uv = 3891000, .ri_uohm = 298000 },
+	{ .vbat_uv = 3873000, .ri_uohm = 293000 },
+	{ .vbat_uv = 3854000, .ri_uohm = 277000 },
+	{ .vbat_uv = 3851000, .ri_uohm = 291000 },
+	{ .vbat_uv = 3788000, .ri_uohm = 286000 },
+	{ .vbat_uv = 3758000, .ri_uohm = 230000 },
+	{ .vbat_uv = 3750000, .ri_uohm = 177000 },
+	{ .vbat_uv = 3712000, .ri_uohm = 164000 },
+	{ .vbat_uv = 3674000, .ri_uohm = 161000 },
+	{ .vbat_uv = 3590000, .ri_uohm = 164000 },
+};
+
+struct power_supply_vbat_ri_table samsung_vbat2res_discharging_2000mah[] = {
+	{ .vbat_uv = 4194000, .ri_uohm = 121000 },
+	{ .vbat_uv = 4169000, .ri_uohm = 188000 },
+	{ .vbat_uv = 4136000, .ri_uohm = 173000 },
+	{ .vbat_uv = 4108000, .ri_uohm = 158000 },
+	{ .vbat_uv = 4064000, .ri_uohm = 143000 },
+	{ .vbat_uv = 3956000, .ri_uohm = 160000 },
+	{ .vbat_uv = 3847000, .ri_uohm = 262000 },
+	{ .vbat_uv = 3806000, .ri_uohm = 280000 },
+	{ .vbat_uv = 3801000, .ri_uohm = 266000 },
+	{ .vbat_uv = 3794000, .ri_uohm = 259000 },
+	{ .vbat_uv = 3785000, .ri_uohm = 234000 },
+	{ .vbat_uv = 3779000, .ri_uohm = 227000 },
+	{ .vbat_uv = 3772000, .ri_uohm = 222000 },
+	{ .vbat_uv = 3765000, .ri_uohm = 221000 },
+	{ .vbat_uv = 3759000, .ri_uohm = 216000 },
+	{ .vbat_uv = 3754000, .ri_uohm = 206000 },
+	{ .vbat_uv = 3747000, .ri_uohm = 212000 },
+	{ .vbat_uv = 3743000, .ri_uohm = 208000 },
+	{ .vbat_uv = 3737000, .ri_uohm = 212000 },
+	{ .vbat_uv = 3733000, .ri_uohm = 200000 },
+	{ .vbat_uv = 3728000, .ri_uohm = 203000 },
+	{ .vbat_uv = 3722000, .ri_uohm = 207000 },
+	{ .vbat_uv = 3719000, .ri_uohm = 208000 },
+	{ .vbat_uv = 3715000, .ri_uohm = 209000 },
+	{ .vbat_uv = 3712000, .ri_uohm = 211000 },
+	{ .vbat_uv = 3709000, .ri_uohm = 210000 },
+	{ .vbat_uv = 3704000, .ri_uohm = 216000 },
+	{ .vbat_uv = 3701000, .ri_uohm = 218000 },
+	{ .vbat_uv = 3698000, .ri_uohm = 222000 },
+	{ .vbat_uv = 3694000, .ri_uohm = 218000 },
+	{ .vbat_uv = 3692000, .ri_uohm = 215000 },
+	{ .vbat_uv = 3688000, .ri_uohm = 224000 },
+	{ .vbat_uv = 3686000, .ri_uohm = 224000 },
+	{ .vbat_uv = 3683000, .ri_uohm = 228000 },
+	{ .vbat_uv = 3681000, .ri_uohm = 228000 },
+	{ .vbat_uv = 3679000, .ri_uohm = 229000 },
+	{ .vbat_uv = 3676000, .ri_uohm = 232000 },
+	{ .vbat_uv = 3675000, .ri_uohm = 229000 },
+	{ .vbat_uv = 3673000, .ri_uohm = 229000 },
+	{ .vbat_uv = 3672000, .ri_uohm = 223000 },
+	{ .vbat_uv = 3669000, .ri_uohm = 224000 },
+	{ .vbat_uv = 3666000, .ri_uohm = 224000 },
+	{ .vbat_uv = 3663000, .ri_uohm = 221000 },
+	{ .vbat_uv = 3660000, .ri_uohm = 218000 },
+	{ .vbat_uv = 3657000, .ri_uohm = 215000 },
+	{ .vbat_uv = 3654000, .ri_uohm = 212000 },
+	{ .vbat_uv = 3649000, .ri_uohm = 215000 },
+	{ .vbat_uv = 3644000, .ri_uohm = 215000 },
+	{ .vbat_uv = 3636000, .ri_uohm = 215000 },
+	{ .vbat_uv = 3631000, .ri_uohm = 206000 },
+	{ .vbat_uv = 3623000, .ri_uohm = 205000 },
+	{ .vbat_uv = 3616000, .ri_uohm = 193000 },
+	{ .vbat_uv = 3605000, .ri_uohm = 193000 },
+	{ .vbat_uv = 3600000, .ri_uohm = 198000 },
+	{ .vbat_uv = 3597000, .ri_uohm = 198000 },
+	{ .vbat_uv = 3592000, .ri_uohm = 203000 },
+	{ .vbat_uv = 3591000, .ri_uohm = 188000 },
+	{ .vbat_uv = 3587000, .ri_uohm = 188000 },
+	{ .vbat_uv = 3583000, .ri_uohm = 177000 },
+	{ .vbat_uv = 3577000, .ri_uohm = 170000 },
+	{ .vbat_uv = 3568000, .ri_uohm = 135000 },
+	{ .vbat_uv = 3552000, .ri_uohm = 54000 },
+	{ .vbat_uv = 3526000, .ri_uohm = 130000 },
+	{ .vbat_uv = 3501000, .ri_uohm = 48000 },
+	{ .vbat_uv = 3442000, .ri_uohm = 183000 },
+	{ .vbat_uv = 3326000, .ri_uohm = 372000 },
+	{ .vbat_uv = 3161000, .ri_uohm = 452000 },
+};
+
+struct power_supply_vbat_ri_table samsung_vbat2res_charging_2000mah[] = {
+	{ .vbat_uv = 4360000, .ri_uohm = 128000 },
+	{ .vbat_uv = 4325000, .ri_uohm = 130000 },
+	{ .vbat_uv = 4316000, .ri_uohm = 148000 },
+	{ .vbat_uv = 4308000, .ri_uohm = 162000 },
+	{ .vbat_uv = 4301000, .ri_uohm = 162000 },
+	{ .vbat_uv = 4250000, .ri_uohm = 162000 },
+	{ .vbat_uv = 4230000, .ri_uohm = 164000 },
+	{ .vbat_uv = 4030000, .ri_uohm = 164000 },
+	{ .vbat_uv = 4000000, .ri_uohm = 193000 },
+	{ .vbat_uv = 3950000, .ri_uohm = 204000 },
+	{ .vbat_uv = 3850000, .ri_uohm = 210000 },
+	{ .vbat_uv = 3800000, .ri_uohm = 230000 },
+	{ .vbat_uv = 3790000, .ri_uohm = 240000 },
+	{ .vbat_uv = 3780000, .ri_uohm = 311000 },
+	{ .vbat_uv = 3760000, .ri_uohm = 420000 },
+	{ .vbat_uv = 3700000, .ri_uohm = 504000 },
+	{ .vbat_uv = 3600000, .ri_uohm = 565000 },
+};
+
+/*
+ * Temperature to internal resistance scaling tables.
+ *
+ * "resistance" is the percentage of the resistance determined from the voltage
+ * so this represents the capacity ratio at different temperatures.
+ *
+ * FIXME: the proper table is missing: Samsung does not provide the necessary
+ * temperature compensation tables so we just state 100% for every temperature.
+ * If you have the datasheets, please provide these tables.
+ */
+static struct power_supply_resistance_temp_table samsung_temp2res[] = {
+	{ .temp = 50, .resistance = 100 },
+	{ .temp = 40, .resistance = 100 },
+	{ .temp = 30, .resistance = 100 },
+	{ .temp = 20, .resistance = 100 },
+	{ .temp = 10, .resistance = 100 },
+	{ .temp = 00, .resistance = 100 },
+	{ .temp = -10, .resistance = 100 },
+	{ .temp = -20, .resistance = 100 },
+};
+
+/*
+ * Capacity tables for different Open Circuit Voltages (OCV).
+ * These must be sorted by falling OCV value.
+ */
+
+static struct power_supply_battery_ocv_table samsung_ocv_cap_eb585157lu[] = {
+	{ .ocv = 4178000, .capacity = 100},
+	{ .ocv = 4148000, .capacity = 99},
+	{ .ocv = 4105000, .capacity = 95},
+	{ .ocv = 4078000, .capacity = 92},
+	{ .ocv = 4057000, .capacity = 89},
+	{ .ocv = 4013000, .capacity = 85},
+	{ .ocv = 3988000, .capacity = 82},
+	{ .ocv = 3962000, .capacity = 77},
+	{ .ocv = 3920000, .capacity = 70},
+	{ .ocv = 3891000, .capacity = 65},
+	{ .ocv = 3874000, .capacity = 62},
+	{ .ocv = 3839000, .capacity = 59},
+	{ .ocv = 3816000, .capacity = 55},
+	{ .ocv = 3798000, .capacity = 50},
+	{ .ocv = 3778000, .capacity = 40},
+	{ .ocv = 3764000, .capacity = 30},
+	{ .ocv = 3743000, .capacity = 25},
+	{ .ocv = 3711000, .capacity = 20},
+	{ .ocv = 3691000, .capacity = 18},
+	{ .ocv = 3685000, .capacity = 15},
+	{ .ocv = 3680000, .capacity = 12},
+	{ .ocv = 3662000, .capacity = 10},
+	{ .ocv = 3638000, .capacity = 9},
+	{ .ocv = 3593000, .capacity = 7},
+	{ .ocv = 3566000, .capacity = 6},
+	{ .ocv = 3497000, .capacity = 4},
+	{ .ocv = 3405000, .capacity = 2},
+	{ .ocv = 3352000, .capacity = 1},
+	{ .ocv = 3300000, .capacity = 0},
+};
+
+static struct power_supply_battery_ocv_table samsung_ocv_cap_1500mah[] = {
+	{ .ocv = 4328000, .capacity = 100},
+	{ .ocv = 4299000, .capacity = 99},
+	{ .ocv = 4281000, .capacity = 98},
+	{ .ocv = 4241000, .capacity = 95},
+	{ .ocv = 4183000, .capacity = 90},
+	{ .ocv = 4150000, .capacity = 87},
+	{ .ocv = 4116000, .capacity = 84},
+	{ .ocv = 4077000, .capacity = 80},
+	{ .ocv = 4068000, .capacity = 79},
+	{ .ocv = 4058000, .capacity = 77},
+	{ .ocv = 4026000, .capacity = 75},
+	{ .ocv = 3987000, .capacity = 72},
+	{ .ocv = 3974000, .capacity = 69},
+	{ .ocv = 3953000, .capacity = 66},
+	{ .ocv = 3933000, .capacity = 63},
+	{ .ocv = 3911000, .capacity = 60},
+	{ .ocv = 3900000, .capacity = 58},
+	{ .ocv = 3873000, .capacity = 55},
+	{ .ocv = 3842000, .capacity = 52},
+	{ .ocv = 3829000, .capacity = 50},
+	{ .ocv = 3810000, .capacity = 45},
+	{ .ocv = 3793000, .capacity = 40},
+	{ .ocv = 3783000, .capacity = 35},
+	{ .ocv = 3776000, .capacity = 30},
+	{ .ocv = 3762000, .capacity = 25},
+	{ .ocv = 3746000, .capacity = 20},
+	{ .ocv = 3739000, .capacity = 18},
+	{ .ocv = 3715000, .capacity = 15},
+	{ .ocv = 3700000, .capacity = 12},
+	{ .ocv = 3690000, .capacity = 10},
+	{ .ocv = 3680000, .capacity = 9},
+	{ .ocv = 3670000, .capacity = 7},
+	{ .ocv = 3656000, .capacity = 5},
+	{ .ocv = 3634000, .capacity = 4},
+	{ .ocv = 3614000, .capacity = 3},
+	{ .ocv = 3551000, .capacity = 2},
+	{ .ocv = 3458000, .capacity = 1},
+	{ .ocv = 3300000, .capacity = 0},
+};
+
+static struct power_supply_battery_ocv_table samsung_ocv_cap_1700mah[] = {
+	{ .ocv = 4269000, .capacity = 100},
+	{ .ocv = 4227000, .capacity = 99},
+	{ .ocv = 4174000, .capacity = 95},
+	{ .ocv = 4139000, .capacity = 92},
+	{ .ocv = 4106000, .capacity = 89},
+	{ .ocv = 4062000, .capacity = 85},
+	{ .ocv = 4029000, .capacity = 82},
+	{ .ocv = 3958000, .capacity = 75},
+	{ .ocv = 3908000, .capacity = 70},
+	{ .ocv = 3872000, .capacity = 66},
+	{ .ocv = 3820000, .capacity = 60},
+	{ .ocv = 3798000, .capacity = 57},
+	{ .ocv = 3774000, .capacity = 53},
+	{ .ocv = 3757000, .capacity = 50},
+	{ .ocv = 3735000, .capacity = 45},
+	{ .ocv = 3716000, .capacity = 40},
+	{ .ocv = 3701000, .capacity = 35},
+	{ .ocv = 3689000, .capacity = 30},
+	{ .ocv = 3678000, .capacity = 25},
+	{ .ocv = 3658000, .capacity = 20},
+	{ .ocv = 3646000, .capacity = 18},
+	{ .ocv = 3619000, .capacity = 15},
+	{ .ocv = 3589000, .capacity = 12},
+	{ .ocv = 3578000, .capacity = 10},
+	{ .ocv = 3568000, .capacity = 9},
+	{ .ocv = 3545000, .capacity = 7},
+	{ .ocv = 3509000, .capacity = 5},
+	{ .ocv = 3485000, .capacity = 4},
+	{ .ocv = 3449000, .capacity = 3},
+	{ .ocv = 3403000, .capacity = 2},
+	{ .ocv = 3348000, .capacity = 1},
+	{ .ocv = 3300000, .capacity = 0},
+};
+
+static struct power_supply_battery_ocv_table samsung_ocv_cap_2000mah[] = {
+	{ .ocv = 4320000, .capacity = 100},
+	{ .ocv = 4296000, .capacity = 99},
+	{ .ocv = 4283000, .capacity = 98},
+	{ .ocv = 4245000, .capacity = 95},
+	{ .ocv = 4185000, .capacity = 90},
+	{ .ocv = 4152000, .capacity = 87},
+	{ .ocv = 4119000, .capacity = 84},
+	{ .ocv = 4077000, .capacity = 80},
+	{ .ocv = 4057000, .capacity = 78},
+	{ .ocv = 4048000, .capacity = 77},
+	{ .ocv = 4020000, .capacity = 74},
+	{ .ocv = 4003000, .capacity = 72},
+	{ .ocv = 3978000, .capacity = 69},
+	{ .ocv = 3955000, .capacity = 66},
+	{ .ocv = 3934000, .capacity = 63},
+	{ .ocv = 3912000, .capacity = 60},
+	{ .ocv = 3894000, .capacity = 58},
+	{ .ocv = 3860000, .capacity = 55},
+	{ .ocv = 3837000, .capacity = 52},
+	{ .ocv = 3827000, .capacity = 50},
+	{ .ocv = 3806000, .capacity = 45},
+	{ .ocv = 3791000, .capacity = 40},
+	{ .ocv = 3779000, .capacity = 35},
+	{ .ocv = 3770000, .capacity = 30},
+	{ .ocv = 3758000, .capacity = 25},
+	{ .ocv = 3739000, .capacity = 20},
+	{ .ocv = 3730000, .capacity = 18},
+	{ .ocv = 3706000, .capacity = 15},
+	{ .ocv = 3684000, .capacity = 13},
+	{ .ocv = 3675000, .capacity = 10},
+	{ .ocv = 3673000, .capacity = 9},
+	{ .ocv = 3665000, .capacity = 7},
+	{ .ocv = 3649000, .capacity = 5},
+	{ .ocv = 3628000, .capacity = 4},
+	{ .ocv = 3585000, .capacity = 3},
+	{ .ocv = 3525000, .capacity = 2},
+	{ .ocv = 3441000, .capacity = 1},
+	{ .ocv = 3300000, .capacity = 0},
+};
+
+struct power_supply_maintenance_charge_table samsung_maint_charge_table[] = {
+	{
+		/* Maintenance charging phase A, 60 hours */
+		.charge_current_max_ua = 600000,
+		.charge_voltage_max_uv = 4150000,
+		.charge_safety_timer_minutes = 60*60,
+	},
+	{
+		/* Maintenance charging phase B, 200 hours */
+		.charge_current_max_ua = 600000,
+		.charge_voltage_max_uv = 4100000,
+		.charge_safety_timer_minutes = 200*60,
+	}
+};
+
+struct samsung_sdi_battery samsung_sdi_batteries[] = {
+	{
+		/*
+		 * Used in Samsung GT-I8190 "Golden"
+		 * Data from vendor boardfile board-golden-bm.c
+		 */
+		.compatible = "samsung,eb-l1m7flu",
+		.name = "EB-L1M7FLU",
+		.info = {
+			.charge_full_design_uah = 1500000,
+			.technology = POWER_SUPPLY_TECHNOLOGY_LION,
+			.factory_internal_resistance_uohm = 100000,
+			.factory_internal_resistance_charging_uohm = 200000,
+			/* If you have data on this fix the min_design_uv */
+			.voltage_min_design_uv = 3300000,
+			.voltage_max_design_uv = 4350000,
+			.overvoltage_limit_uv = 4500000,
+			.constant_charge_current_max_ua = 900000,
+			.constant_charge_voltage_max_uv = 4340000,
+			.charge_term_current_ua = 200000,
+			.maintenance_charge = samsung_maint_charge_table,
+			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
+			.alert_low_temp_charge_current_ua = 300000,
+			.alert_low_temp_charge_voltage_uv = 4000000,
+			.alert_high_temp_charge_current_ua = 300000,
+			.alert_high_temp_charge_voltage_uv = 4000000,
+			.temp_min = -5,
+			.temp_alert_min = 0,
+			.temp_alert_max = 40,
+			.temp_max = 60,
+			.resist_table = samsung_temp2res,
+			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
+			/* If you have tables for more temperatures, add them */
+			.ocv_temp[0] = 25,
+			.ocv_table[0] = samsung_ocv_cap_1500mah,
+			.ocv_table_size[0] = ARRAY_SIZE(samsung_ocv_cap_1500mah),
+			.vbat2ri_discharging = samsung_vbat2res_discharging_1500mah,
+			.vbat2ri_discharging_size = ARRAY_SIZE(samsung_vbat2res_discharging_1500mah),
+			.vbat2ri_charging = samsung_vbat2res_charging_1500mah,
+			.vbat2ri_charging_size = ARRAY_SIZE(samsung_vbat2res_charging_1500mah),
+			.bti_resistance_ohm = 2400,
+			.bti_resistance_tolerance = 40,
+		},
+	},
+	{
+		/*
+		 * Used in Samsung SGH-T599 "Codina TMO" and SGH-I407 "Kyle"
+		 * Data from vendor boardfile board-kyle-bm.c
+		 */
+		.compatible = "samsung,eb425161la",
+		.name = "EB425161LA",
+		.info = {
+			.charge_full_design_uah = 1500000,
+			.technology = POWER_SUPPLY_TECHNOLOGY_LION,
+			.factory_internal_resistance_uohm = 136000,
+			.factory_internal_resistance_charging_uohm = 200000,
+			/* If you have data on this fix the min_design_uv */
+			.voltage_min_design_uv = 3300000,
+			.voltage_max_design_uv = 4350000,
+			.overvoltage_limit_uv = 4500000,
+			.constant_charge_current_max_ua = 900000,
+			.constant_charge_voltage_max_uv = 4340000,
+			.charge_term_current_ua = 200000,
+			.maintenance_charge = samsung_maint_charge_table,
+			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
+			.alert_low_temp_charge_current_ua = 300000,
+			.alert_low_temp_charge_voltage_uv = 4000000,
+			.alert_high_temp_charge_current_ua = 300000,
+			.alert_high_temp_charge_voltage_uv = 4000000,
+			.temp_min = -5,
+			.temp_alert_min = 0,
+			.temp_alert_max = 40,
+			.temp_max = 60,
+			.resist_table = samsung_temp2res,
+			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
+			/* If you have tables for more temperatures, add them */
+			.ocv_temp[0] = 25,
+			.ocv_table[0] = samsung_ocv_cap_1500mah,
+			.ocv_table_size[0] = ARRAY_SIZE(samsung_ocv_cap_1500mah),
+			.vbat2ri_discharging = samsung_vbat2res_discharging_1500mah,
+			.vbat2ri_discharging_size = ARRAY_SIZE(samsung_vbat2res_discharging_1500mah),
+			.vbat2ri_charging = samsung_vbat2res_charging_1500mah,
+			.vbat2ri_charging_size = ARRAY_SIZE(samsung_vbat2res_charging_1500mah),
+			.bti_resistance_ohm = 2400,
+			.bti_resistance_tolerance = 40,
+		},
+	},
+	{
+		/*
+		 * Used in Samsung GT-I8160 "Codina"
+		 * Data from vendor boardfile board-codina-bm.c
+		 */
+		.compatible = "samsung,eb425161lu",
+		.name = "EB425161LU",
+		.info = {
+			.charge_full_design_uah = 1500000,
+			.technology = POWER_SUPPLY_TECHNOLOGY_LION,
+			.factory_internal_resistance_uohm = 100000,
+			.factory_internal_resistance_charging_uohm = 200000,
+			/* If you have data on this fix the min_design_uv */
+			.voltage_min_design_uv = 3300000,
+			.voltage_max_design_uv = 4350000,
+			.overvoltage_limit_uv = 4500000,
+			.constant_charge_current_max_ua = 900000,
+			.constant_charge_voltage_max_uv = 4340000,
+			.charge_term_current_ua = 200000,
+			.maintenance_charge = samsung_maint_charge_table,
+			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
+			.alert_low_temp_charge_current_ua = 300000,
+			.alert_low_temp_charge_voltage_uv = 4000000,
+			.alert_high_temp_charge_current_ua = 300000,
+			.alert_high_temp_charge_voltage_uv = 4000000,
+			.temp_min = -5,
+			.temp_alert_min = 0,
+			.temp_alert_max = 40,
+			.temp_max = 60,
+			.resist_table = samsung_temp2res,
+			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
+			/* If you have tables for more temperatures, add them */
+			.ocv_temp[0] = 25,
+			.ocv_table[0] = samsung_ocv_cap_1500mah,
+			.ocv_table_size[0] = ARRAY_SIZE(samsung_ocv_cap_1500mah),
+			.vbat2ri_discharging = samsung_vbat2res_discharging_1500mah,
+			.vbat2ri_discharging_size = ARRAY_SIZE(samsung_vbat2res_discharging_1500mah),
+			.vbat2ri_charging = samsung_vbat2res_charging_1500mah,
+			.vbat2ri_charging_size = ARRAY_SIZE(samsung_vbat2res_charging_1500mah),
+			.bti_resistance_ohm = 2400,
+			.bti_resistance_tolerance = 40,
+		},
+	},
+	{
+		/*
+		 * Used in Samsung GT-S7710 "Skomer"
+		 * Data from vendor boardfile board-skomer-bm.c
+		 */
+		.compatible = "samsung,eb485159lu",
+		.name = "EB485159LU",
+		.info = {
+			.charge_full_design_uah = 1700000,
+			.technology = POWER_SUPPLY_TECHNOLOGY_LION,
+			.factory_internal_resistance_uohm = 100000,
+			.factory_internal_resistance_charging_uohm = 200000,
+			/* If you have data on this fix the min_design_uv */
+			.voltage_min_design_uv = 3300000,
+			.voltage_max_design_uv = 4350000,
+			.overvoltage_limit_uv = 4500000,
+			.constant_charge_current_max_ua = 900000,
+			.constant_charge_voltage_max_uv = 4340000,
+			.charge_term_current_ua = 200000,
+			.maintenance_charge = samsung_maint_charge_table,
+			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
+			.alert_low_temp_charge_current_ua = 300000,
+			.alert_low_temp_charge_voltage_uv = 4000000,
+			.alert_high_temp_charge_current_ua = 300000,
+			.alert_high_temp_charge_voltage_uv = 4000000,
+			.temp_min = -5,
+			.temp_alert_min = 0,
+			.temp_alert_max = 40,
+			.temp_max = 60,
+			.resist_table = samsung_temp2res,
+			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
+			/* If you have tables for more temperatures, add them */
+			.ocv_temp[0] = 25,
+			.ocv_table[0] = samsung_ocv_cap_1700mah,
+			.ocv_table_size[0] = ARRAY_SIZE(samsung_ocv_cap_1700mah),
+			/* CHECKME: vendor uses the 1500 mAh table, check against datasheet */
+			.vbat2ri_discharging = samsung_vbat2res_discharging_1500mah,
+			.vbat2ri_discharging_size = ARRAY_SIZE(samsung_vbat2res_discharging_1500mah),
+			.vbat2ri_charging = samsung_vbat2res_charging_1500mah,
+			.vbat2ri_charging_size = ARRAY_SIZE(samsung_vbat2res_charging_1500mah),
+			.bti_resistance_ohm = 2400,
+			.bti_resistance_tolerance = 40,
+		},
+	},
+	{
+		/*
+		 * Used in Samsung GT-I9070 "Janice"
+		 * Data from vendor boardfile board-janice-bm.c
+		 */
+		.compatible = "samsung,eb535151vu",
+		.name = "EB535151VU",
+		.info = {
+			.charge_full_design_uah = 1500000,
+			.technology = POWER_SUPPLY_TECHNOLOGY_LION,
+			.factory_internal_resistance_uohm = 100000,
+			.factory_internal_resistance_charging_uohm = 200000,
+			/* If you have data on this fix the min_design_uv */
+			.voltage_min_design_uv = 3300000,
+			.voltage_max_design_uv = 4180000,
+			.overvoltage_limit_uv = 4500000,
+			.constant_charge_current_max_ua = 900000,
+			.constant_charge_voltage_max_uv = 4200000,
+			.charge_term_current_ua = 200000,
+			.maintenance_charge = samsung_maint_charge_table,
+			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
+			.alert_low_temp_charge_current_ua = 300000,
+			.alert_low_temp_charge_voltage_uv = 4000000,
+			.alert_high_temp_charge_current_ua = 300000,
+			.alert_high_temp_charge_voltage_uv = 4000000,
+			.temp_min = -5,
+			.temp_alert_min = 0,
+			.temp_alert_max = 40,
+			.temp_max = 60,
+			.resist_table = samsung_temp2res,
+			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
+			/* If you have tables for more temperatures, add them */
+			.ocv_temp[0] = 25,
+			.ocv_table[0] = samsung_ocv_cap_eb585157lu,
+			.ocv_table_size[0] = ARRAY_SIZE(samsung_ocv_cap_eb585157lu),
+			.vbat2ri_discharging = samsung_vbat2res_discharging_eb585157lu,
+			.vbat2ri_discharging_size = ARRAY_SIZE(samsung_vbat2res_discharging_eb585157lu),
+			.vbat2ri_charging = samsung_vbat2res_charging_eb585157lu,
+			.vbat2ri_charging_size = ARRAY_SIZE(samsung_vbat2res_charging_eb585157lu),
+			.bti_resistance_ohm = 1500,
+			.bti_resistance_tolerance = 40,
+		},
+	},
+	{
+		/*
+		 * Used in Samsung GT-I8530 "Gavini"
+		 * Data from vendor boardfile board-gavini-bm.c
+		 */
+		.compatible = "samsung,eb585157lu",
+		.name = "EB585157LU",
+		.info = {
+			.charge_full_design_uah = 2000000,
+			.technology = POWER_SUPPLY_TECHNOLOGY_LION,
+			.factory_internal_resistance_uohm = 105000,
+			.factory_internal_resistance_charging_uohm = 160000,
+			/* If you have data on this fix the min_design_uv */
+			.voltage_min_design_uv = 3300000,
+			.voltage_max_design_uv = 4320000,
+			.overvoltage_limit_uv = 4500000,
+			.constant_charge_current_max_ua = 1500000,
+			.constant_charge_voltage_max_uv = 4350000,
+			.charge_term_current_ua = 120000,
+			.maintenance_charge = samsung_maint_charge_table,
+			.maintenance_charge_size = ARRAY_SIZE(samsung_maint_charge_table),
+			.alert_low_temp_charge_current_ua = 300000,
+			.alert_low_temp_charge_voltage_uv = 4000000,
+			.alert_high_temp_charge_current_ua = 300000,
+			.alert_high_temp_charge_voltage_uv = 4000000,
+			.temp_min = -5,
+			.temp_alert_min = 0,
+			.temp_alert_max = 40,
+			.temp_max = 60,
+			.resist_table = samsung_temp2res,
+			.resist_table_size = ARRAY_SIZE(samsung_temp2res),
+			/* If you have tables for more temperatures, add them */
+			.ocv_temp[0] = 25,
+			.ocv_table[0] = samsung_ocv_cap_2000mah,
+			.ocv_table_size[0] = ARRAY_SIZE(samsung_ocv_cap_2000mah),
+			.vbat2ri_discharging = samsung_vbat2res_discharging_2000mah,
+			.vbat2ri_discharging_size = ARRAY_SIZE(samsung_vbat2res_discharging_2000mah),
+			.vbat2ri_charging = samsung_vbat2res_charging_2000mah,
+			.vbat2ri_charging_size = ARRAY_SIZE(samsung_vbat2res_charging_2000mah),
+			.bti_resistance_ohm = 2400,
+			.bti_resistance_tolerance = 40,
+		},
+	},
+};
+
+int samsung_sdi_battery_get_info(struct device *dev,
+				 struct device_node *np,
+				 struct power_supply_battery_info **info)
+{
+	struct samsung_sdi_battery *batt;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(samsung_sdi_batteries); i++) {
+		batt = &samsung_sdi_batteries[i];
+		if (of_device_is_compatible(np, batt->compatible))
+			break;
+	}
+
+	if (i == ARRAY_SIZE(samsung_sdi_batteries))
+		return -ENODEV;
+
+	*info = &batt->info;
+	dev_info(dev, "Samsung SDI %s battery %d mAh\n",
+		 batt->name, batt->info.charge_full_design_uah / 1000);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(samsung_sdi_battery_get_info);
diff --git a/drivers/power/supply/samsung-sdi-battery.h b/drivers/power/supply/samsung-sdi-battery.h
new file mode 100644
index 000000000000..08783847dfcb
--- /dev/null
+++ b/drivers/power/supply/samsung-sdi-battery.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if IS_ENABLED(CONFIG_BATTERY_SAMSUNG_SDI)
+extern int samsung_sdi_battery_get_info(struct device *dev,
+				struct device_node *np,
+				struct power_supply_battery_info **info);
+#else
+static inline int samsung_sdi_battery_get_info(struct device *dev,
+				struct device_node *np,
+				struct power_supply_battery_info **info)
+{
+	return -ENODEV;
+}
+#endif
-- 
2.34.1

