Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A7E4A89EF
	for <lists+linux-pm@lfdr.de>; Thu,  3 Feb 2022 18:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbiBCR0F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Feb 2022 12:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352818AbiBCR0E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Feb 2022 12:26:04 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F338C061401
        for <linux-pm@vger.kernel.org>; Thu,  3 Feb 2022 09:26:04 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a25so4884026lji.9
        for <linux-pm@vger.kernel.org>; Thu, 03 Feb 2022 09:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/aK4jarL59rmOvYhhZfqTswvWecPmWLJppgsHuWhJ4=;
        b=SVk9BdMNkxhxKPTxOOZuwT2kq981nIwDB6js98s2+DH5M+16wP8ycdd05XDhlozRAe
         /q8eDZh6W+/Zh6Mju5wGNiTmVVxl0ABj5Bg9/rgILaE0iMTfRK3nvX653VadHzrnIkLz
         7vHFj+l2PLzL2ATBJi7ENdMZxi/V/XKXG2H/RBvJyI/33qsICiSSdRWewFSL1p9d5jmV
         MwfaYJ5W/5Ln/k6670abDoihFbrQrpfpvg5k3bQ4PAv4GpdIF2B2DTUlhWq4cZnxxQpi
         tlTRrjvJTxC0Te347aIHEJ9kFbrZe703D8d5Mj67+NgMr8FKYO0SwaxBIxAdIOUJmWKq
         U1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/aK4jarL59rmOvYhhZfqTswvWecPmWLJppgsHuWhJ4=;
        b=Z+NRrNe1HR6y/uDBuFvK1iGvBlfvPSvU/3r9ISx1EbPrIjeNkbu/fUWvO0exQOJhC7
         U8PDLvHvkNuGGhreuKqaFk6kcc/MEt3+DXs7YerjkW8te416t0Yw8krfdqbH81vrT5pF
         KjdwsTrpYTCUpCDkB6bYwcq5nLh6wHBTyESZE7jgujFezDgczlainJvJQajNdn6tfCqV
         IkZ+Nv1UACtUsyLU4yKMrJvvzzrBgI8w+rZ6g6Wy1XRL3Q6y8Z53y6fI8Z5V4dQXmCaH
         ucwJsbardExzfgVN2E6ovuVI+DgvA24V9K9frduYrpiWITXGnrN3uZc0wpLDtGoxtGow
         Y8rg==
X-Gm-Message-State: AOAM531M2xSePKRb0aNXZ+Fvg77jreG/LQSUAhnAuAICfzHD7nsSbwq2
        BKHdd5vUoikWtgDWGaWoIDdERQ==
X-Google-Smtp-Source: ABdhPJwSYDgvGzirQWfTIxNsI35/AXo52QrfSbGEBVcb+ivV6qmloynnKTZCOJjEZ1GGoZyEuDAGSQ==
X-Received: by 2002:a05:651c:1a08:: with SMTP id by8mr23521114ljb.325.1643909162637;
        Thu, 03 Feb 2022 09:26:02 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id b13sm1640699lff.240.2022.02.03.09.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:26:02 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/6] power: supply: ab8500_fg: Use VBAT-to-Ri if possible
Date:   Thu,  3 Feb 2022 18:16:32 +0100
Message-Id: <20220203171633.183828-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203171633.183828-1-linus.walleij@linaro.org>
References: <20220203171633.183828-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Augment the AB8500 fuel gauge to use the VBAT-to-Ri method of
estimating the internal resistance if possible. Else fall back
to using the temperature-to-Ri or just the default Ri.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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

