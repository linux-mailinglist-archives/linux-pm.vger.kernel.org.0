Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9334B38C2
	for <lists+linux-pm@lfdr.de>; Sun, 13 Feb 2022 01:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiBMAKE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Feb 2022 19:10:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiBMAKE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Feb 2022 19:10:04 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC75FF3E
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 16:09:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id k13so23572146lfg.9
        for <linux-pm@vger.kernel.org>; Sat, 12 Feb 2022 16:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GVr839NWsAXEMrPVEjeXsHn2voWhC3kNeZIru1gWT9M=;
        b=TRFCfbna03MvH2RoD9ccwyJBnBN9WTQylNn1C76b0si9VirhbqHI8lA5/hC0DgNKR1
         cIvl47FNkEX8coZ/6jvkkv7rHvW8pepR6apgjD7gRRKR9lZx9IVcjRNV70I+hI2cxJAZ
         Kp2wSaW2FRxcvp1hlAs5wl4HOVvEEkF5H4aKj9bLFKi5mlI4YdNtJ4ZUWeBiIbSW85n7
         g70PKX7kfd4Sw+55A5tgX3gZ1b+IkXpPruBu/ZJ8VeI/Wf/CGXp5G4Hf8UjF42njfsx9
         4gmDKlPW4OOWVVr7CxcSiZVvPF5iCmMeM/ZRo7BXybWA1HvkkdPmgejcN/Dx4Maw3w3V
         ZYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GVr839NWsAXEMrPVEjeXsHn2voWhC3kNeZIru1gWT9M=;
        b=DXqZd38zYPGHQaw7wA0y5lBz7K5Zgp05yR6ie6AQAbOYb4OBval6yk4DDAghiOwAo/
         kfhsaQEBdsAH6x3ralbkohtxtdzgx4n+rKm09YI80uY/gPacujYTiDdSyYvguDBmrTZq
         FQ5qTu9j8m1W3obFx6cZIKq7Od6JLMKDDVh0Rs/UAK7o8ciHVyhmq+RgAQDthICOuZl9
         /qWJf0CTR79FXtIRWvVWrG34NyJp/kWhU5qoUfPVa9k+X5vzu004wpSamE8sSgvoxvWR
         cBKENtgMjLjgqG+qsbJ8XSoC+pR5NyTL//yGmr1jKzk6wPioVoRymK5z7HHoZuDM8v+c
         2iIA==
X-Gm-Message-State: AOAM5329J0bvMIhjdZX2bsFi5KhA6C5dpFkmYM9f0H/S4raOxxTNIL+v
        /lkMfED7Ww28Abymf3yl9Vhgdg==
X-Google-Smtp-Source: ABdhPJyogH8wb9FIHfxkeJ0l6Ho8lkkiCiaqJGIKov3XBBc+ZIKLvZZvdHzFWN8gxbfIKY2nlxHFDg==
X-Received: by 2002:a05:6512:1697:: with SMTP id bu23mr5759347lfb.556.1644710998080;
        Sat, 12 Feb 2022 16:09:58 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id g30sm382292lja.39.2022.02.12.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:09:57 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/6 v2] power: supply: ab8500_fg: Use VBAT-to-Ri if possible
Date:   Sun, 13 Feb 2022 01:07:02 +0100
Message-Id: <20220213000703.772673-6-linus.walleij@linaro.org>
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

Augment the AB8500 fuel gauge to use the VBAT-to-Ri method of
estimating the internal resistance if possible. Else fall back
to using the temperature-to-Ri or just the default Ri.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
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

