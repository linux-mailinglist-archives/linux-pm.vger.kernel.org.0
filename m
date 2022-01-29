Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D94A2AB1
	for <lists+linux-pm@lfdr.de>; Sat, 29 Jan 2022 01:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbiA2Avn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 19:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344610AbiA2Avj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 19:51:39 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3243C061714
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:38 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bu18so15047205lfb.5
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 16:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fuXHDiPRXJ0dAPnxqpVBk9I/lCTC+3tmLbDpfjNFbRc=;
        b=onAIi8VQzpD62w/BAeE+0SBDVOXBlQpULjAbev+4+9uECMxPuWYJ+DoQ88JFcPQyc2
         ThSFIhsSGVAQ7qkFKfAOvblzlizdTJddIspvirQumTNMu3HqJ0Eaw1it/xbdIAC0vMrq
         4MYS8qsLaPxC58rXIRY4OfaF699YZmBuUsKCwKdmVNfyTRxd9cN59C34EI9I/nTRKbFm
         iWy76Y/PjXNU1VV0IP53Afgru8z7oFav3DGFm/eybTfXjwvpNHl5cU4UvTKhDjr8UNMy
         4spl0yduy5xMEaQJ3raDL3tu2kEZQgAzmPB2E9EbIt93t1yWougfKI+r7bkgCQEH15Oh
         yDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fuXHDiPRXJ0dAPnxqpVBk9I/lCTC+3tmLbDpfjNFbRc=;
        b=bqzwmjwZnple03tm71OVSSQfKxq/mCNSiU1+gnJ4KHyFPenuUMwi2A/L6Z37hIZFBa
         VwTgNfBUWfIkQ0cibk2vaF+BBYotH2DwOm0cAW26TiZ0XA/pZ44zVe57jRC4VeecEe07
         gL/ufyat/Mr54kUTBWSjJL+BoPbPFChE19UGvOjCnYG/C/NvrkKOQZjH2eJ2JZGnKakr
         BNqNXeUyr8Zcm6O8R9QX+ScBjQ1I4TO3pnPnTi1p5Y/OfBiva/n8ok+i21GfmKfX64CG
         F2JZLjDzGhPez3Xk4x1hZRnVNhoZReqIcqN5PP81eD/Fhuv4sfYBm9x7xA2ayVg/MbPS
         hRww==
X-Gm-Message-State: AOAM533pjFEYzqa5z8wKF854qpZ6vaJZ1ytiqRPb5cuGAqNKPYClfSLf
        yIJuKiN4aNcXX6NdKAgK5dK1xM5a46kI9g==
X-Google-Smtp-Source: ABdhPJw35SLFEgHf0Dlq6zSJeTT8QzL5vaEYXudUg07x6Ap3HB/DagYb9zQdjXzaRNB3OiTYkAoUkw==
X-Received: by 2002:a05:6512:ac3:: with SMTP id n3mr7733272lfu.379.1643417497091;
        Fri, 28 Jan 2022 16:51:37 -0800 (PST)
Received: from localhost.localdomain ([92.34.204.253])
        by smtp.gmail.com with ESMTPSA id m17sm2232903lfr.24.2022.01.28.16.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 16:51:36 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 01/11 v2] power: supply: ab8500: Drop BATCTRL thermal mode
Date:   Sat, 29 Jan 2022 01:49:15 +0100
Message-Id: <20220129004925.639684-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129004925.639684-1-linus.walleij@linaro.org>
References: <20220129004925.639684-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The BATCTRL mode reads the temperature of the battery by
enabling a certain probing current (7-20 mA) and then measure
the voltage of the NTC mounted inside the battery.

None of the AB8500 product or the reference designs use this
mode. What we use is the so-called BATTEMP mode which enables
an internal 230 kOhm pull-up to 1.8 V to the external NTC on
pin BatTemp (N16) and then measures the voltage over the NTC
using the ADC:

        1.8V (VTVOUT)
         |
        [ ] 230 kOhm
         |
BatTemp  +---------------- ADC
Pin N16  | _
         |/
        [/] NTC
       _/|
         |
        GND

Cut out the BATCTRL code to clear the forest and stop
maintaining code we can never test.

The current inducing method is still used to probe for the
battery type using the internal BTI (battery type indicator)
on the BatCtrl (C3) pin in a separate code path.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Resending with other patches, no changes.
---
 drivers/power/supply/ab8500-bm.h     |  16 --
 drivers/power/supply/ab8500_bmdata.c |   2 -
 drivers/power/supply/ab8500_btemp.c  | 263 +++------------------------
 3 files changed, 24 insertions(+), 257 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index 56a5aaf9a27a..3bc6fd9337d2 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -260,18 +260,6 @@ enum bup_vch_sel {
 #define BUS_PP_PRECHG_CURRENT_MASK		0x0E
 #define BUS_POWER_PATH_PRECHG_ENA		0x01
 
-/*
- * ADC for the battery thermistor.
- * When using the AB8500_ADC_THERM_BATCTRL the battery ID resistor is combined
- * with a NTC resistor to both identify the battery and to measure its
- * temperature. Different phone manufactures uses different techniques to both
- * identify the battery and to read its temperature.
- */
-enum ab8500_adc_therm {
-	AB8500_ADC_THERM_BATCTRL,
-	AB8500_ADC_THERM_BATTEMP,
-};
-
 /**
  * struct ab8500_res_to_temp - defines one point in a temp to res curve. To
  * be used in battery packs that combines the identification resistor with a
@@ -423,7 +411,6 @@ struct ab8500_bm_charger_parameters {
  * @bkup_bat_i		current which we charge the backup battery with
  * @no_maintenance	indicates that maintenance charging is disabled
  * @capacity_scaling    indicates whether capacity scaling is to be used
- * @ab8500_adc_therm	placement of thermistor, batctrl or battemp adc
  * @chg_unknown_bat	flag to enable charging of unknown batteries
  * @enable_overshoot	flag to enable VBAT overshoot control
  * @auto_trig		flag to enable auto adc trigger
@@ -431,7 +418,6 @@ struct ab8500_bm_charger_parameters {
  * @interval_charging	charge alg cycle period time when charging (sec)
  * @interval_not_charging charge alg cycle period time when not charging (sec)
  * @temp_hysteresis	temperature hysteresis
- * @gnd_lift_resistance	Battery ground to phone ground resistance (mOhm)
  * @maxi		maximization parameters
  * @cap_levels		capacity in percent for the different capacity levels
  * @bat_type		table of supported battery types
@@ -452,12 +438,10 @@ struct ab8500_bm_data {
 	bool chg_unknown_bat;
 	bool enable_overshoot;
 	bool auto_trig;
-	enum ab8500_adc_therm adc_therm;
 	int fg_res;
 	int interval_charging;
 	int interval_not_charging;
 	int temp_hysteresis;
-	int gnd_lift_resistance;
 	const struct ab8500_maxim_parameters *maxi;
 	const struct ab8500_bm_capacity_levels *cap_levels;
 	struct ab8500_battery_type *bat_type;
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 7ae95f537580..7133cce6a25a 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -150,7 +150,6 @@ struct ab8500_bm_data ab8500_bm_data = {
 	.bkup_bat_i             = BUP_ICH_SEL_150UA,
 	.no_maintenance         = false,
 	.capacity_scaling       = false,
-	.adc_therm              = AB8500_ADC_THERM_BATCTRL,
 	.chg_unknown_bat        = false,
 	.enable_overshoot       = false,
 	.fg_res                 = 100,
@@ -158,7 +157,6 @@ struct ab8500_bm_data ab8500_bm_data = {
 	.bat_type               = &bat_type_thermistor_unknown,
 	.interval_charging      = 5,
 	.interval_not_charging  = 120,
-	.gnd_lift_resistance    = 34,
 	.maxi                   = &ab8500_maxi_params,
 	.chg_params             = &chg,
 	.fg_params              = &fg,
diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index cc33c5187fbb..a5ca09124c93 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -135,8 +135,6 @@ static LIST_HEAD(ab8500_btemp_list);
 static int ab8500_btemp_batctrl_volt_to_res(struct ab8500_btemp *di,
 	int v_batctrl, int inst_curr)
 {
-	int rbs;
-
 	if (is_ab8500_1p1_or_earlier(di->parent)) {
 		/*
 		 * For ABB cut1.0 and 1.1 BAT_CTRL is internally
@@ -145,23 +143,11 @@ static int ab8500_btemp_batctrl_volt_to_res(struct ab8500_btemp *di,
 		return (450000 * (v_batctrl)) / (1800 - v_batctrl);
 	}
 
-	if (di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL) {
-		/*
-		 * If the battery has internal NTC, we use the current
-		 * source to calculate the resistance.
-		 */
-		rbs = (v_batctrl * 1000
-		       - di->bm->gnd_lift_resistance * inst_curr)
-		      / di->curr_source;
-	} else {
-		/*
-		 * BAT_CTRL is internally
-		 * connected to 1.8V through a 80k resistor
-		 */
-		rbs = (80000 * (v_batctrl)) / (1800 - v_batctrl);
-	}
-
-	return rbs;
+	/*
+	 * BAT_CTRL is internally
+	 * connected to 1.8V through a 80k resistor
+	 */
+	return (80000 * (v_batctrl)) / (1800 - v_batctrl);
 }
 
 /**
@@ -186,155 +172,6 @@ static int ab8500_btemp_read_batctrl_voltage(struct ab8500_btemp *di)
 	return vbtemp;
 }
 
-/**
- * ab8500_btemp_curr_source_enable() - enable/disable batctrl current source
- * @di:		pointer to the ab8500_btemp structure
- * @enable:	enable or disable the current source
- *
- * Enable or disable the current sources for the BatCtrl AD channel
- */
-static int ab8500_btemp_curr_source_enable(struct ab8500_btemp *di,
-	bool enable)
-{
-	int curr;
-	int ret = 0;
-
-	/*
-	 * BATCTRL current sources are included on AB8500 cut2.0
-	 * and future versions
-	 */
-	if (is_ab8500_1p1_or_earlier(di->parent))
-		return 0;
-
-	/* Only do this for batteries with internal NTC */
-	if (di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL && enable) {
-
-		if (di->curr_source == BTEMP_BATCTRL_CURR_SRC_7UA)
-			curr = BAT_CTRL_7U_ENA;
-		else
-			curr = BAT_CTRL_20U_ENA;
-
-		dev_dbg(di->dev, "Set BATCTRL %duA\n", di->curr_source);
-
-		ret = abx500_mask_and_set_register_interruptible(di->dev,
-			AB8500_CHARGER, AB8500_BAT_CTRL_CURRENT_SOURCE,
-			FORCE_BAT_CTRL_CMP_HIGH, FORCE_BAT_CTRL_CMP_HIGH);
-		if (ret) {
-			dev_err(di->dev, "%s failed setting cmp_force\n",
-				__func__);
-			return ret;
-		}
-
-		/*
-		 * We have to wait one 32kHz cycle before enabling
-		 * the current source, since ForceBatCtrlCmpHigh needs
-		 * to be written in a separate cycle
-		 */
-		udelay(32);
-
-		ret = abx500_set_register_interruptible(di->dev,
-			AB8500_CHARGER, AB8500_BAT_CTRL_CURRENT_SOURCE,
-			FORCE_BAT_CTRL_CMP_HIGH | curr);
-		if (ret) {
-			dev_err(di->dev, "%s failed enabling current source\n",
-				__func__);
-			goto disable_curr_source;
-		}
-	} else if (di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL && !enable) {
-		dev_dbg(di->dev, "Disable BATCTRL curr source\n");
-
-		/* Write 0 to the curr bits */
-		ret = abx500_mask_and_set_register_interruptible(
-			di->dev,
-			AB8500_CHARGER, AB8500_BAT_CTRL_CURRENT_SOURCE,
-			BAT_CTRL_7U_ENA | BAT_CTRL_20U_ENA,
-			~(BAT_CTRL_7U_ENA | BAT_CTRL_20U_ENA));
-
-		if (ret) {
-			dev_err(di->dev, "%s failed disabling current source\n",
-				__func__);
-			goto disable_curr_source;
-		}
-
-		/* Enable Pull-Up and comparator */
-		ret = abx500_mask_and_set_register_interruptible(di->dev,
-			AB8500_CHARGER,	AB8500_BAT_CTRL_CURRENT_SOURCE,
-			BAT_CTRL_PULL_UP_ENA | BAT_CTRL_CMP_ENA,
-			BAT_CTRL_PULL_UP_ENA | BAT_CTRL_CMP_ENA);
-		if (ret) {
-			dev_err(di->dev, "%s failed enabling PU and comp\n",
-				__func__);
-			goto enable_pu_comp;
-		}
-
-		/*
-		 * We have to wait one 32kHz cycle before disabling
-		 * ForceBatCtrlCmpHigh since this needs to be written
-		 * in a separate cycle
-		 */
-		udelay(32);
-
-		/* Disable 'force comparator' */
-		ret = abx500_mask_and_set_register_interruptible(di->dev,
-			AB8500_CHARGER, AB8500_BAT_CTRL_CURRENT_SOURCE,
-			FORCE_BAT_CTRL_CMP_HIGH, ~FORCE_BAT_CTRL_CMP_HIGH);
-		if (ret) {
-			dev_err(di->dev, "%s failed disabling force comp\n",
-				__func__);
-			goto disable_force_comp;
-		}
-	}
-	return ret;
-
-	/*
-	 * We have to try unsetting FORCE_BAT_CTRL_CMP_HIGH one more time
-	 * if we got an error above
-	 */
-disable_curr_source:
-	/* Write 0 to the curr bits */
-	ret = abx500_mask_and_set_register_interruptible(di->dev,
-		AB8500_CHARGER, AB8500_BAT_CTRL_CURRENT_SOURCE,
-		BAT_CTRL_7U_ENA | BAT_CTRL_20U_ENA,
-		~(BAT_CTRL_7U_ENA | BAT_CTRL_20U_ENA));
-
-	if (ret) {
-		dev_err(di->dev, "%s failed disabling current source\n",
-			__func__);
-		return ret;
-	}
-enable_pu_comp:
-	/* Enable Pull-Up and comparator */
-	ret = abx500_mask_and_set_register_interruptible(di->dev,
-		AB8500_CHARGER,	AB8500_BAT_CTRL_CURRENT_SOURCE,
-		BAT_CTRL_PULL_UP_ENA | BAT_CTRL_CMP_ENA,
-		BAT_CTRL_PULL_UP_ENA | BAT_CTRL_CMP_ENA);
-	if (ret) {
-		dev_err(di->dev, "%s failed enabling PU and comp\n",
-			__func__);
-		return ret;
-	}
-
-disable_force_comp:
-	/*
-	 * We have to wait one 32kHz cycle before disabling
-	 * ForceBatCtrlCmpHigh since this needs to be written
-	 * in a separate cycle
-	 */
-	udelay(32);
-
-	/* Disable 'force comparator' */
-	ret = abx500_mask_and_set_register_interruptible(di->dev,
-		AB8500_CHARGER, AB8500_BAT_CTRL_CURRENT_SOURCE,
-		FORCE_BAT_CTRL_CMP_HIGH, ~FORCE_BAT_CTRL_CMP_HIGH);
-	if (ret) {
-		dev_err(di->dev, "%s failed disabling force comp\n",
-			__func__);
-		return ret;
-	}
-
-	return ret;
-}
-
 /**
  * ab8500_btemp_get_batctrl_res() - get battery resistance
  * @di:		pointer to the ab8500_btemp structure
@@ -350,16 +187,6 @@ static int ab8500_btemp_get_batctrl_res(struct ab8500_btemp *di)
 	int inst_curr;
 	int i;
 
-	/*
-	 * BATCTRL current sources are included on AB8500 cut2.0
-	 * and future versions
-	 */
-	ret = ab8500_btemp_curr_source_enable(di, true);
-	if (ret) {
-		dev_err(di->dev, "%s curr source enabled failed\n", __func__);
-		return ret;
-	}
-
 	if (!di->fg)
 		di->fg = ab8500_fg_get();
 	if (!di->fg) {
@@ -395,12 +222,6 @@ static int ab8500_btemp_get_batctrl_res(struct ab8500_btemp *di)
 
 	res = ab8500_btemp_batctrl_volt_to_res(di, batctrl, inst_curr);
 
-	ret = ab8500_btemp_curr_source_enable(di, false);
-	if (ret) {
-		dev_err(di->dev, "%s curr source disable failed\n", __func__);
-		return ret;
-	}
-
 	dev_dbg(di->dev, "%s batctrl: %d res: %d inst_curr: %d samples: %d\n",
 		__func__, batctrl, res, inst_curr, i);
 
@@ -451,47 +272,28 @@ static int ab8500_btemp_res_to_temp(struct ab8500_btemp *di,
  */
 static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
 {
-	struct power_supply_battery_info *bi = di->bm->bi;
 	int temp, ret;
 	static int prev;
-	int rbat, rntc, vntc;
-
-	if ((di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL) &&
-	    (bi && (bi->technology == POWER_SUPPLY_TECHNOLOGY_UNKNOWN))) {
-
-		rbat = ab8500_btemp_get_batctrl_res(di);
-		if (rbat < 0) {
-			dev_err(di->dev, "%s get batctrl res failed\n",
-				__func__);
-			/*
-			 * Return out-of-range temperature so that
-			 * charging is stopped
-			 */
-			return BTEMP_THERMAL_LOW_LIMIT;
-		}
-
-		temp = ab8500_btemp_res_to_temp(di,
-			di->bm->bat_type->r_to_t_tbl,
-			di->bm->bat_type->n_temp_tbl_elements, rbat);
-	} else {
-		ret = iio_read_channel_processed(di->btemp_ball, &vntc);
-		if (ret < 0) {
-			dev_err(di->dev,
-				"%s ADC conversion failed,"
-				" using previous value\n", __func__);
-			return prev;
-		}
-		/*
-		 * The PCB NTC is sourced from VTVOUT via a 230kOhm
-		 * resistor.
-		 */
-		rntc = 230000 * vntc / (VTVOUT_V - vntc);
+	int rntc, vntc;
 
-		temp = ab8500_btemp_res_to_temp(di,
-			di->bm->bat_type->r_to_t_tbl,
-			di->bm->bat_type->n_temp_tbl_elements, rntc);
-		prev = temp;
+	ret = iio_read_channel_processed(di->btemp_ball, &vntc);
+	if (ret < 0) {
+		dev_err(di->dev,
+			"%s ADC conversion failed,"
+			" using previous value\n", __func__);
+		return prev;
 	}
+	/*
+	 * The PCB NTC is sourced from VTVOUT via a 230kOhm
+	 * resistor.
+	 */
+	rntc = 230000 * vntc / (VTVOUT_V - vntc);
+
+	temp = ab8500_btemp_res_to_temp(di,
+		di->bm->bat_type->r_to_t_tbl,
+		di->bm->bat_type->n_temp_tbl_elements, rntc);
+	prev = temp;
+
 	dev_dbg(di->dev, "Battery temperature is %d\n", temp);
 	return temp;
 }
@@ -519,11 +321,9 @@ static int ab8500_btemp_id(struct ab8500_btemp *di)
 
 	if ((res <= di->bm->bat_type->resis_high) &&
 	    (res >= di->bm->bat_type->resis_low)) {
-		dev_info(di->dev, "Battery detected on %s"
+		dev_info(di->dev, "Battery detected on BATTEMP"
 			 " low %d < res %d < high: %d"
 			 " index: %d\n",
-			 di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL ?
-			 "BATCTRL" : "BATTEMP",
 			 di->bm->bat_type->resis_low, res,
 			 di->bm->bat_type->resis_high, i);
 	} else {
@@ -532,21 +332,6 @@ static int ab8500_btemp_id(struct ab8500_btemp *di)
 		return -ENXIO;
 	}
 
-	/*
-	 * We only have to change current source if the
-	 * detected type is Type 1 (LIPO) resis_high = 53407, resis_low = 12500
-	 * if someone hacks this in.
-	 *
-	 * FIXME: make sure this is done automatically for the batteries
-	 * that need it.
-	 */
-	if ((di->bm->adc_therm == AB8500_ADC_THERM_BATCTRL) &&
-	    (di->bm->bi && (di->bm->bi->technology == POWER_SUPPLY_TECHNOLOGY_LIPO)) &&
-	    (res <= 53407) && (res >= 12500)) {
-		dev_dbg(di->dev, "Set BATCTRL current source to 20uA\n");
-		di->curr_source = BTEMP_BATCTRL_CURR_SRC_20UA;
-	}
-
 	return 0;
 }
 
-- 
2.34.1

