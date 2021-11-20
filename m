Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E738457F1E
	for <lists+linux-pm@lfdr.de>; Sat, 20 Nov 2021 16:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237290AbhKTP6s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 20 Nov 2021 10:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhKTP6s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Nov 2021 10:58:48 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EE2C061574
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:44 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id l22so57834840lfg.7
        for <linux-pm@vger.kernel.org>; Sat, 20 Nov 2021 07:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOE19IUuZkgFZuqkdts/eH574SyOmJ6ioX0OCgMi7OI=;
        b=Y8UoZatRTzSw4MWsz7PTqRYEOq0cvDJJwUG26tcieF2KYeiDWEZnSLnwBYCxQUnyAm
         /nxnSDE84tptXZLjDOwGYKBCeD6P0/5teV2stVmfwKfSBnzkuAkYfwvgNEALgyG0eats
         q1+ZrQmYaO9f3/fqULlVsqJcHrns3yKGlCOVSlo9Y4CDdqYVz+YpqADvP4xkuZ9w3ceN
         Uh75/Wp+1SUwGcprz0XSHvukQcDSnWtx7RzA7lKe1HHgZIc9HX/kQ30+K+cjYwPFcJmO
         UWJ8ESDJbOLj8YqAAWjdhtWxk6qxRf3NhuAPYzqoiTrBWxKKDP5KXekV/WrpIYlTYlip
         5hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOE19IUuZkgFZuqkdts/eH574SyOmJ6ioX0OCgMi7OI=;
        b=lDaX00+kE2b5F0H1gLDHBwWbo7IJ7ss1S5htFce/tynSJ1RuLFQgPdp3EPZzI6ZboJ
         PVSfT2OynQ8oZ2odfXOmzzwj15oq/dfLM0CvbfKhC5cMVnSobeajG5HB4rFB4aNO6Fsm
         higxlppu9DQ1aH8fEfEkFeLNmqw/B3D3sdLvySPeYK4h+lRedjKifl+LQnB1jbhNiPY+
         HRmK/kH0WnYipxxm0s8RldqIGKkDrTu68f/589h0TtEfB/d1HhDmTXhBz0Of2MXzYE0t
         8F10ZhuFEN6oU6p3BumzqRHe/WHFnHXsJmcE2aB41uc0GboU69z9WGnRLx/xNwTRriJz
         m8WQ==
X-Gm-Message-State: AOAM532C6FgliqtRKn4fB/djkNdmGUF7dbe16lvuD2/56dxYDdN+jnkX
        V0QkHOiKoW77HHWG2bY7tXd5SjFc1TU0gQ==
X-Google-Smtp-Source: ABdhPJxISKS0GF5RK47JVZeKF2GirshVjsHDp8DyfA7Mk3bR0KgjW8xnfjGcMlZHuogZc7NC5WsOuQ==
X-Received: by 2002:a2e:918e:: with SMTP id f14mr34340011ljg.109.1637423742897;
        Sat, 20 Nov 2021 07:55:42 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t12sm280922ljg.63.2021.11.20.07.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 07:55:41 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 02/16] power: supply: ab8500: Sink current tables into charger code
Date:   Sat, 20 Nov 2021 16:53:12 +0100
Message-Id: <20211120155326.2891664-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120155326.2891664-1-linus.walleij@linaro.org>
References: <20211120155326.2891664-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The two tables for input and output current translation from
register values does not need to be passed around from the
battery manager data. Just push it down into the charger code
where it is used, like other tables in that code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase on the other patches
---
 drivers/power/supply/ab8500-bm.h      |  8 ------
 drivers/power/supply/ab8500_bmdata.c  | 22 ----------------
 drivers/power/supply/ab8500_charger.c | 38 ++++++++++++++++++---------
 3 files changed, 25 insertions(+), 43 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 33c7e15f5d96..bcb054810290 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -484,10 +484,6 @@ struct ab8500_bm_charger_parameters {
  * @interval_not_charging charge alg cycle period time when not charging (sec)
  * @temp_hysteresis	temperature hysteresis
  * @gnd_lift_resistance	Battery ground to phone ground resistance (mOhm)
- * @n_chg_out_curr		number of elements in array chg_output_curr
- * @n_chg_in_curr		number of elements in array chg_input_curr
- * @chg_output_curr	charger output current level map
- * @chg_input_curr		charger input current level map
  * @maxi		maximization parameters
  * @cap_levels		capacity in percent for the different capacity levels
  * @bat_type		table of supported battery types
@@ -519,10 +515,6 @@ struct ab8500_bm_data {
 	int interval_not_charging;
 	int temp_hysteresis;
 	int gnd_lift_resistance;
-	int n_chg_out_curr;
-	int n_chg_in_curr;
-	int *chg_output_curr;
-	int *chg_input_curr;
 	const struct ab8500_maxim_parameters *maxi;
 	const struct ab8500_bm_capacity_levels *cap_levels;
 	struct ab8500_battery_type *bat_type;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index a515dfad4c3f..6f6865c46926 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -436,24 +436,6 @@ static const struct ab8500_bm_charger_parameters chg = {
 	.ac_curr_max		= 1500,
 };
 
-/*
- * This array maps the raw hex value to charger output current used by the
- * AB8500 values
- */
-static int ab8500_charge_output_curr_map[] = {
-        100,    200,    300,    400,    500,    600,    700,    800,
-        900,    1000,   1100,   1200,   1300,   1400,   1500,   1500,
-};
-
-/*
- * This array maps the raw hex value to charger input current used by the
- * AB8500 values
- */
-static int ab8500_charge_input_curr_map[] = {
-        50,     98,     193,    290,    380,    450,    500,    600,
-        700,    800,    900,    1000,   1100,   1300,   1400,   1500,
-};
-
 struct ab8500_bm_data ab8500_bm_data = {
 	.temp_under             = 3,
 	.temp_low               = 8,
@@ -479,13 +461,9 @@ struct ab8500_bm_data ab8500_bm_data = {
 	.interval_not_charging  = 120,
 	.temp_hysteresis        = 3,
 	.gnd_lift_resistance    = 34,
-	.chg_output_curr        = ab8500_charge_output_curr_map,
-	.n_chg_out_curr         = ARRAY_SIZE(ab8500_charge_output_curr_map),
 	.maxi                   = &ab8500_maxi_params,
 	.chg_params             = &chg,
 	.fg_params              = &fg,
-        .chg_input_curr         = ab8500_charge_input_curr_map,
-        .n_chg_in_curr          = ARRAY_SIZE(ab8500_charge_input_curr_map),
 };
 
 int ab8500_bm_of_probe(struct power_supply *psy,
diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 59ca9c0b8012..32c2046ea6bb 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -1025,21 +1025,33 @@ static int ab8500_voltage_to_regval(int voltage)
 		return -1;
 }
 
+/* This array maps the raw register value to charger input current */
+static int ab8500_charge_input_curr_map[] = {
+	50, 98, 193, 290, 380, 450, 500, 600,
+	700, 800, 900, 1000, 1100, 1300, 1400, 1500,
+};
+
+/* This array maps the raw register value to charger output current */
+static int ab8500_charge_output_curr_map[] = {
+	100, 200, 300, 400, 500, 600, 700, 800,
+	900, 1000, 1100, 1200, 1300, 1400, 1500, 1500,
+};
+
 static int ab8500_current_to_regval(struct ab8500_charger *di, int curr)
 {
 	int i;
 
-	if (curr < di->bm->chg_output_curr[0])
+	if (curr < ab8500_charge_output_curr_map[0])
 		return 0;
 
-	for (i = 0; i < di->bm->n_chg_out_curr; i++) {
-		if (curr < di->bm->chg_output_curr[i])
+	for (i = 0; i < ARRAY_SIZE(ab8500_charge_output_curr_map); i++) {
+		if (curr < ab8500_charge_output_curr_map[i])
 			return i - 1;
 	}
 
 	/* If not last element, return error */
-	i = di->bm->n_chg_out_curr - 1;
-	if (curr == di->bm->chg_output_curr[i])
+	i =  ARRAY_SIZE(ab8500_charge_output_curr_map) - 1;
+	if (curr == ab8500_charge_output_curr_map[i])
 		return i;
 	else
 		return -1;
@@ -1049,17 +1061,17 @@ static int ab8500_vbus_in_curr_to_regval(struct ab8500_charger *di, int curr)
 {
 	int i;
 
-	if (curr < di->bm->chg_input_curr[0])
+	if (curr < ab8500_charge_input_curr_map[0])
 		return 0;
 
-	for (i = 0; i < di->bm->n_chg_in_curr; i++) {
-		if (curr < di->bm->chg_input_curr[i])
+	for (i = 0; i < ARRAY_SIZE(ab8500_charge_input_curr_map); i++) {
+		if (curr < ab8500_charge_input_curr_map[i])
 			return i - 1;
 	}
 
 	/* If not last element, return error */
-	i = di->bm->n_chg_in_curr - 1;
-	if (curr == di->bm->chg_input_curr[i])
+	i =  ARRAY_SIZE(ab8500_charge_input_curr_map) - 1;
+	if (curr == ab8500_charge_input_curr_map[i])
 		return i;
 	else
 		return -1;
@@ -2673,7 +2685,7 @@ static void ab8500_charger_vbus_drop_end_work(struct work_struct *work)
 		return;
 	}
 
-	curr = di->bm->chg_input_curr[
+	curr = ab8500_charge_input_curr_map[
 		reg_value >> AUTO_VBUS_IN_CURR_LIM_SHIFT];
 
 	if (di->max_usb_in_curr.calculated_max != curr) {
@@ -3503,7 +3515,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->ac_chg.max_out_volt = ab8500_charger_voltage_map[
 		ARRAY_SIZE(ab8500_charger_voltage_map) - 1];
 	di->ac_chg.max_out_curr =
-		di->bm->chg_output_curr[di->bm->n_chg_out_curr - 1];
+		ab8500_charge_output_curr_map[ARRAY_SIZE(ab8500_charge_output_curr_map) - 1];
 	di->ac_chg.wdt_refresh = CHG_WD_INTERVAL;
 	/*
 	 * The AB8505 only supports USB charging. If we are not the
@@ -3524,7 +3536,7 @@ static int ab8500_charger_probe(struct platform_device *pdev)
 	di->usb_chg.max_out_volt = ab8500_charger_voltage_map[
 		ARRAY_SIZE(ab8500_charger_voltage_map) - 1];
 	di->usb_chg.max_out_curr =
-		di->bm->chg_output_curr[di->bm->n_chg_out_curr - 1];
+		ab8500_charge_output_curr_map[ARRAY_SIZE(ab8500_charge_output_curr_map) - 1];
 	di->usb_chg.wdt_refresh = CHG_WD_INTERVAL;
 	di->usb_chg.external = false;
 	di->usb_state.usb_current = -1;
-- 
2.31.1

