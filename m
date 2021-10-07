Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68455424D08
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 08:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbhJGGGT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 02:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240230AbhJGGGS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 02:06:18 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B4DC061746;
        Wed,  6 Oct 2021 23:04:24 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t63so233512qkf.1;
        Wed, 06 Oct 2021 23:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wsvYgeVVG8SKskfDqOgobykv3cFchIXrq53qABMEo18=;
        b=MS8H6zdX/Crn0whvsYNGYfUbv8DlUtJPT+afbHg2KH8nNgv2Bv2Wn0Ae5aQB3OdJK5
         FajFWQ6YESOlL6WiVDxb68h4gegNpZkFziLvBj1dyEbvY8oYVc98iGY5helXP8F3S+Mf
         180ABjO/nHDXxC9JwizM1SMy9la2x4+r12EMh4JzgBvRmdyVQj+T/4T/IwF9X3mOQ6YF
         +wteucJwYREsDQ8dO68HKkUxvcsk8EICxbI3JPn6DndLgMQ4XUvAfG5yhMtzT1DqYFS0
         3we8KVbZG6JnKpRtCW77+0O1xx3UgJf3/nUT7xwpUftVBBI5oxXtVajSD/lNZd2Rf6TR
         fViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wsvYgeVVG8SKskfDqOgobykv3cFchIXrq53qABMEo18=;
        b=vRZe2wqvyolRCohhjlIBHBRdT6nOU+QexbVZ28zbt1YL1l/CI092OrFAWvp/Roy1nT
         Q06BRccLMHWV3Z3St+cFlYPf/BBk2cEwOxIBKWTJ64DJRl0NHM3f7Dn594Usibc4dmBq
         B3qj5499lk53cH79dYTyu9TnmLN09enNUNGZXmzJOOTeapZCQ6259vyyTOmuCyIFcMUg
         TGoutYVigXFGz7cGk99R2U5GkulGTI/oP2Jy0IhPIOD4BgnTal7VoKTAyUk0gVTR5arQ
         BjgFHJeMAtGnD/z/avpqZM/XoaTIikofjWhynoaA9+MFCfg7e0P/NmMv6TKft9gf2Z9H
         +Nng==
X-Gm-Message-State: AOAM5328MwKdjmwfl00ZIuj/o3AOY5qd4xCJhdSZaSqMl4hY6mCX8YS4
        Dma5KHTDuxiLRPlKfk5tFBY=
X-Google-Smtp-Source: ABdhPJx8dKDtb4TjLhT2xUji03vrz94GkdJV8nQC+MJjqJX/fJEsb/kOv1ObSmQl+mQqIQ/G7lcWwQ==
X-Received: by 2002:a37:670d:: with SMTP id b13mr1812482qkc.420.1633586664072;
        Wed, 06 Oct 2021 23:04:24 -0700 (PDT)
Received: from localhost.localdomain (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.gmail.com with ESMTPSA id x79sm13235042qkb.65.2021.10.06.23.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 23:04:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v1 4/6] mfd: max77620: Use power off call chain API
Date:   Thu,  7 Oct 2021 09:02:51 +0300
Message-Id: <20211007060253.17049-5-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211007060253.17049-1-digetx@gmail.com>
References: <20211007060253.17049-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use new power off call chain API which allows multiple power off handlers
to coexist. Nexus 7 Android tablet can be powered off using MAX77663 PMIC
and using a special bootloader command. At first the bootloader option
should be tried, it will have a higher priority than the PMIC.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mfd/max77620.c       | 22 +++++++++++++++-------
 include/linux/mfd/max77620.h |  2 ++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index fec2096474ad..ad40eed1f0c6 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -31,11 +31,10 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-static struct max77620_chip *max77620_scratch;
-
 static const struct resource gpio_resources[] = {
 	DEFINE_RES_IRQ(MAX77620_IRQ_TOP_GPIO),
 };
@@ -483,13 +482,17 @@ static int max77620_read_es_version(struct max77620_chip *chip)
 	return ret;
 }
 
-static void max77620_pm_power_off(void)
+static int max77620_pm_power_off(struct notifier_block *nb,
+				 unsigned long reboot_mode, void *data)
 {
-	struct max77620_chip *chip = max77620_scratch;
+	struct max77620_chip *chip = container_of(nb, struct max77620_chip,
+						  pm_off_nb);
 
 	regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG1,
 			   MAX77620_ONOFFCNFG1_SFT_RST,
 			   MAX77620_ONOFFCNFG1_SFT_RST);
+
+	return NOTIFY_DONE;
 }
 
 static int max77620_probe(struct i2c_client *client,
@@ -566,9 +569,14 @@ static int max77620_probe(struct i2c_client *client,
 	}
 
 	pm_off = of_device_is_system_power_controller(client->dev.of_node);
-	if (pm_off && !pm_power_off) {
-		max77620_scratch = chip;
-		pm_power_off = max77620_pm_power_off;
+	if (pm_off) {
+		chip->pm_off_nb.notifier_call = max77620_pm_power_off;
+		chip->pm_off_nb.priority = 128;
+
+		ret = devm_register_poweroff_handler(chip->dev, &chip->pm_off_nb);
+		if (ret < 0)
+			dev_err(chip->dev,
+				"Failed to register poweroff handler: %d\n", ret);
 	}
 
 	return 0;
diff --git a/include/linux/mfd/max77620.h b/include/linux/mfd/max77620.h
index f552ef5b1100..99de4f8c9cbf 100644
--- a/include/linux/mfd/max77620.h
+++ b/include/linux/mfd/max77620.h
@@ -8,6 +8,7 @@
 #ifndef _MFD_MAX77620_H_
 #define _MFD_MAX77620_H_
 
+#include <linux/notifier.h>
 #include <linux/types.h>
 
 /* GLOBAL, PMIC, GPIO, FPS, ONOFFC, CID Registers */
@@ -327,6 +328,7 @@ enum max77620_chip_id {
 struct max77620_chip {
 	struct device *dev;
 	struct regmap *rmap;
+	struct notifier_block pm_off_nb;
 
 	int chip_irq;
 
-- 
2.32.0

