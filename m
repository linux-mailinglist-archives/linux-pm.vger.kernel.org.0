Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667E44C3A34
	for <lists+linux-pm@lfdr.de>; Fri, 25 Feb 2022 01:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiBYAQE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 19:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiBYAQD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 19:16:03 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084E32692F8
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 16:15:32 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id bn33so5232023ljb.6
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 16:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=van0GZu2Hw5Wh2Og/fehUOeDRqMGuyBvE9y7yh8MAC8=;
        b=D59vPuomOzz8z3OfX6mZwWQTEBC9h5OKo4qWj2Mp0jjeHi+anUTA4Ctnp3WbmexS/v
         GRqlYL0co1UEfd+Jx61LRB2ZRpAQvVv8ZD1NjZHcj9LrGm7A8S//DobEG7E6hRLH6mQM
         yhjel/C6Ee3sTybgDvVArZXK6ec3c94rJG2sOpI4EDK2Pap/GkuYae/Kv5Pg0Bh336+N
         xRanC6vRN6i0OVFl+hOH6ECNo6OgdvTDP4MLk9RGz56LAsZn61RFKIDZXyUhwKhtnW9q
         9d5oDwt5MHXzgAHbJ8GXidLQMmeIzMV4FLsm1XCjJg81MyK4wTOMCdmNkBXcBYSPrK3h
         7T0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=van0GZu2Hw5Wh2Og/fehUOeDRqMGuyBvE9y7yh8MAC8=;
        b=0fzt6vSDqXCnHuW0dekn9NibyIrrB0oT5sWlCXAyu/S4aQbLao9jWlcDCGrul8fXRz
         x9IWSVvXLTJdYrGnXXkQZFgNhH2rVtReZRU0gc+hIT8xOm97lO0upe3r8lbcEIsKOEkx
         cm/7lGIMTtikNmZY01mB4vo/qrYRfiUoOEdyd4Qqin+dLn19vResH5vvpMWeinRtE/5e
         wDOtV0Vo27lL4HpOnillGOKUyqaMFD0jMcxW/kuonQH8EYxwc1PGqCRymH+45akdJxsh
         au7s1GQEjR2tqD8Kg+X8la+8kN9eS+hSY6N7dmHF+Bkj4BXxMx3olAx5x1T7aj8AKf9q
         yzXg==
X-Gm-Message-State: AOAM533bRPfPUkudXBQmnrSYb4uK42G5YXsk9nLe+G7lPZljqpskm/t7
        a1RHElj35KN7N7gyX/qsoKyzCw==
X-Google-Smtp-Source: ABdhPJwJz7Jqn+X0gxRuUe7WMTk3Tg8zfC+7lNzFMw1zjQw/HVgf0F8KbMy914o6+uU9rp6rZhT8vw==
X-Received: by 2002:a2e:8890:0:b0:244:d635:b4af with SMTP id k16-20020a2e8890000000b00244d635b4afmr3396821lji.33.1645748130359;
        Thu, 24 Feb 2022 16:15:30 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id 16-20020ac25f10000000b00443890bd84asm55859lfq.114.2022.02.24.16.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:15:29 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/6 v3] power: supply: ab8500_fg: Use VBAT-to-Ri if possible
Date:   Fri, 25 Feb 2022 01:13:13 +0100
Message-Id: <20220225001314.1881549-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225001314.1881549-1-linus.walleij@linaro.org>
References: <20220225001314.1881549-1-linus.walleij@linaro.org>
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

Augment the AB8500 fuel gauge to use the VBAT-to-Ri method of
estimating the internal resistance if possible. Else fall back
to using the temperature-to-Ri or just the default Ri.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No changes
ChangeLog v1->v2:
- No changes
---
 drivers/power/supply/ab8500_fg.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 39c7e6b0be52..e735ba74d1c3 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -877,27 +877,38 @@ static int ab8500_fg_uncomp_volt_to_capacity(struct ab8500_fg *di)
 /**
  * ab8500_fg_battery_resistance() - Returns the battery inner resistance
  * @di:		pointer to the ab8500_fg structure
+ * @vbat_uncomp_uv: Uncompensated VBAT voltage
  *
  * Returns battery inner resistance added with the fuel gauge resistor value
  * to get the total resistance in the whole link from gnd to bat+ node
  * in milliohm.
  */
-static int ab8500_fg_battery_resistance(struct ab8500_fg *di)
+static int ab8500_fg_battery_resistance(struct ab8500_fg *di, int vbat_uncomp_uv)
 {
 	struct power_supply_battery_info *bi = di->bm->bi;
 	int resistance_percent = 0;
 	int resistance;
 
-	resistance_percent = power_supply_temp2resist_simple(bi->resist_table,
-						 bi->resist_table_size,
-						 di->bat_temp / 10);
 	/*
-	 * We get a percentage of factory resistance here so first get
-	 * the factory resistance in milliohms then calculate how much
-	 * resistance we have at this temperature.
+	 * Determine the resistance at this voltage. First try VBAT-to-Ri else
+	 * just infer it from the surrounding temperature, if nothing works just
+	 * use the internal resistance.
 	 */
-	resistance = (bi->factory_internal_resistance_uohm / 1000);
-	resistance = resistance * resistance_percent / 100;
+	if (power_supply_supports_vbat2ri(bi)) {
+		resistance = power_supply_vbat2ri(bi, vbat_uncomp_uv, di->flags.charging);
+		/* Convert to milliohm */
+		resistance = resistance / 1000;
+	} else if (power_supply_supports_temp2ri(bi)) {
+		resistance_percent = power_supply_temp2resist_simple(bi->resist_table,
+								     bi->resist_table_size,
+								     di->bat_temp / 10);
+		/* Convert to milliohm */
+		resistance = bi->factory_internal_resistance_uohm / 1000;
+		resistance = resistance * resistance_percent / 100;
+	} else {
+		/* Last fallback */
+		resistance = bi->factory_internal_resistance_uohm / 1000;
+	}
 
 	dev_dbg(di->dev, "%s Temp: %d battery internal resistance: %d"
 	    " fg resistance %d, total: %d (mOhm)\n",
@@ -955,7 +966,7 @@ static int ab8500_load_comp_fg_bat_voltage(struct ab8500_fg *di, bool always)
 	vbat_uv = vbat_uv / i;
 
 	/* Next we apply voltage compensation from internal resistance */
-	rcomp = ab8500_fg_battery_resistance(di);
+	rcomp = ab8500_fg_battery_resistance(di, vbat_uv);
 	vbat_uv = vbat_uv - (di->inst_curr_ua * rcomp) / 1000;
 
 	/* Always keep this state at latest measurement */
-- 
2.34.1

