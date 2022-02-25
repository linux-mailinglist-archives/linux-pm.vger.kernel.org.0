Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCE14C5218
	for <lists+linux-pm@lfdr.de>; Sat, 26 Feb 2022 00:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239433AbiBYXbL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Feb 2022 18:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239434AbiBYXbI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Feb 2022 18:31:08 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D21119F46D
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 15:30:34 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j7so11860059lfu.6
        for <linux-pm@vger.kernel.org>; Fri, 25 Feb 2022 15:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UA8R2LFEhf2Y+8DFX3dyw367vtbvKF6B0Y9QLNF8IMs=;
        b=KBvQ6HDwadQMXp+yhzXUXi//XdpRRI1m9+HOilyrBJj5yxaFn+Cd+Jrh297bu31lj+
         4ZiFdK7Uu+bDVRw2sl0zVrXXtGf3HsUOfcDvxUZZikJbtU0hQnIW5j6gViCK565aTmyq
         XJ0mPB3r8HMMSX/C5xpK/Kg4ZvUUboSkcldKdxxvHqbalyv7yqosYYl798WCOEnHJ+Cn
         kXMJuHhjm+l+ClDg7wWHtdPLgIvPqDtJc02hr4frfPXg68gc36SD3oDGnh4HT7e+4xD2
         Bwistc+kktt+M/fK9S51PYq1RhqGfBoS7XpH43QuNVVms4ZjryilRRd+hNMKshJGbOZa
         5MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UA8R2LFEhf2Y+8DFX3dyw367vtbvKF6B0Y9QLNF8IMs=;
        b=Lbz7bEdeWp8KhHbf4GJpBB30jT3gSoiYiIGV+1DuduWkql1dnSpLDjJtUsEyymX00L
         0NJvmZzHhNk9OT7KtBemow978gRWZUx1NJ+uzfxTFRP03ExhRZyaXDJw+PKm5PdTJa+o
         h1RwDC63xyCphXnyzYftQ1/vW9TPWNgoQKU2nBQZaf7ZxhxJ/3jcO34dATNMF4CQVJwJ
         0rrcE2AIvIcoEUWDUI6uxrfxmf1k8PVO4522yG2UwQRPpk0mUhTsqecXxFifoTmt9OyY
         4bFlI9EFUb7FjiorsO+owMH35BMwAH9USt7LidQO+XueFMBbbHB79OWkQ1F37gof35vl
         vfRQ==
X-Gm-Message-State: AOAM531U2GFCTb6xkkmSh2lnTxohXtrh4oNF2hiBdRnlIM1Hjp4cZYEE
        trt9tRY3VyGL+a8xC9b0eQ/scD+75Jrxg696
X-Google-Smtp-Source: ABdhPJwJE5U2lfce1zI97xI+qQoQYynqXUzZCDaXXqMTUbEoArrkOgrARMjvwnLnIEftLc76lOSgsw==
X-Received: by 2002:a05:6512:48c:b0:443:3d4f:e559 with SMTP id v12-20020a056512048c00b004433d4fe559mr6185030lfq.309.1645831832989;
        Fri, 25 Feb 2022 15:30:32 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id u9-20020ac251c9000000b00443dc755dfdsm313524lfm.215.2022.02.25.15.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 15:30:32 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/6 v4] power: supply: ab8500_fg: Use VBAT-to-Ri if possible
Date:   Sat, 26 Feb 2022 00:27:59 +0100
Message-Id: <20220225232800.2021909-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220225232800.2021909-1-linus.walleij@linaro.org>
References: <20220225232800.2021909-1-linus.walleij@linaro.org>
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
ChangeLog v3->v4:
- Rebase on Sebastians linux-power-supply tree.
ChangeLog v2->v3:
- No changes
ChangeLog v1->v2:
- No changes
---
 drivers/power/supply/ab8500_fg.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index f2ff3103e0d0..1abe10c7ff2a 100644
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

