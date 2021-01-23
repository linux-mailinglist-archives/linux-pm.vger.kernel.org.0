Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B0F3018A8
	for <lists+linux-pm@lfdr.de>; Sat, 23 Jan 2021 23:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbhAWWUG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 23 Jan 2021 17:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWWUF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 23 Jan 2021 17:20:05 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C820DC061793
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:24 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id x23so10766956lji.7
        for <linux-pm@vger.kernel.org>; Sat, 23 Jan 2021 14:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jrbOmmhAhnkN+8R3UIrmGuRyjfELrcl48HCspjRBcUk=;
        b=tnMCKsA6n0KYNMZ2TzKO756ORSZMio2QFh7s/wCJDKmeS+Hx6qaLax0tI0HJkvT/6I
         l+wWC2bB+P+ZzUeGWVnXRJXH55T7EVHb20l7tVvz9oBuM8mWOWD+BOMKSb3+LF/gZfvM
         WmWOSmjnETC9MEA6dzuFLm1q4AnYEJpfxhUSf6O7EEDR8kVb8DzkVDo/xuwNfdUXEfBE
         1TNurX7AriuHMNpNnG4qDAdFEHDm/o5JScFPRbwupq4Otemg7QwvjG7GP0G02KmFE3Ed
         0xShRAv1k0xMuJprVIR6YyAlMa4ZZ2piXG6DwrnVwLPltioGYeEZxAr2D0zPg2TWGOZE
         UDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jrbOmmhAhnkN+8R3UIrmGuRyjfELrcl48HCspjRBcUk=;
        b=ekPCe9XeJ9Knc/s35KBSD6RDCBHZjcM9zLvXSjTocT+NXsPFZSBesqR81wPHWlguMa
         iPFXT7iVpRyQhayIRWa84uy2cLN/y76DuS08Cir/0xlOzplh82XaWM4F2KqN3vp0dKLx
         nRZ+kBWLhJpJzIKweVtj9ya9xn5wlQjb0d69VyaPU7nOw9ZL0uDtT7qRtg7z046T0SsT
         BOwTtNGyahzlPBkp/DzdzKxzh/2Ap7Uot/OItDIRDn83GDqF7VE1OEMrgrweVQTJ861Z
         XK5JFr95qH6RIWlL2tDZThquHXz4LZq8RGNWlS1ACmzMyN2ELmIVLXZxe4Lo3kSIx9UO
         Es3A==
X-Gm-Message-State: AOAM5315vdFsg3lD4RHmypj/989cKMHRvhC75K9bZKHx9yHHw0gjjLk3
        Uy+XjUD7iPpMRmEZNmzfucG60Q==
X-Google-Smtp-Source: ABdhPJwOsldwzheLDxrgrkiUe1oiR1yQE1rabZe2ncWeDREHCah6q0N7ZHoSz6OcrvZSFUK6OypZUg==
X-Received: by 2002:a2e:8297:: with SMTP id y23mr105479ljg.177.1611440363116;
        Sat, 23 Jan 2021 14:19:23 -0800 (PST)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x17sm1313956lfg.0.2021.01.23.14.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jan 2021 14:19:22 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/10] power: supply: ab8500: Push data to power supply code
Date:   Sat, 23 Jan 2021 23:19:02 +0100
Message-Id: <20210123221908.2993388-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210123221908.2993388-1-linus.walleij@linaro.org>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is a slew of defines, structs and enums and even a
function call only relevant for the charging code that
still lives in <linux/mfd/abx500.h>. Push it down to the
"ab8500-bm.h" header in the power supply subsystem where
it is actually used.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/power/supply/ab8500-bm.h | 278 ++++++++++++++++++++++++++++++-
 include/linux/mfd/abx500.h       | 276 ------------------------------
 2 files changed, 274 insertions(+), 280 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index a1b31c971a45..41c69a4f2a1f 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -4,7 +4,6 @@
 #define _AB8500_CHARGER_H_
 
 #include <linux/kernel.h>
-#include <linux/mfd/abx500.h>
 
 /*
  * System control 2 register offsets.
@@ -268,6 +267,277 @@ enum bup_vch_sel {
 #define BUS_PP_PRECHG_CURRENT_MASK		0x0E
 #define BUS_POWER_PATH_PRECHG_ENA		0x01
 
+/*
+ * ADC for the battery thermistor.
+ * When using the ABx500_ADC_THERM_BATCTRL the battery ID resistor is combined
+ * with a NTC resistor to both identify the battery and to measure its
+ * temperature. Different phone manufactures uses different techniques to both
+ * identify the battery and to read its temperature.
+ */
+enum abx500_adc_therm {
+	ABx500_ADC_THERM_BATCTRL,
+	ABx500_ADC_THERM_BATTEMP,
+};
+
+/**
+ * struct abx500_res_to_temp - defines one point in a temp to res curve. To
+ * be used in battery packs that combines the identification resistor with a
+ * NTC resistor.
+ * @temp:			battery pack temperature in Celsius
+ * @resist:			NTC resistor net total resistance
+ */
+struct abx500_res_to_temp {
+	int temp;
+	int resist;
+};
+
+/**
+ * struct abx500_v_to_cap - Table for translating voltage to capacity
+ * @voltage:		Voltage in mV
+ * @capacity:		Capacity in percent
+ */
+struct abx500_v_to_cap {
+	int voltage;
+	int capacity;
+};
+
+/* Forward declaration */
+struct abx500_fg;
+
+/**
+ * struct abx500_fg_parameters - Fuel gauge algorithm parameters, in seconds
+ * if not specified
+ * @recovery_sleep_timer:	Time between measurements while recovering
+ * @recovery_total_time:	Total recovery time
+ * @init_timer:			Measurement interval during startup
+ * @init_discard_time:		Time we discard voltage measurement at startup
+ * @init_total_time:		Total init time during startup
+ * @high_curr_time:		Time current has to be high to go to recovery
+ * @accu_charging:		FG accumulation time while charging
+ * @accu_high_curr:		FG accumulation time in high current mode
+ * @high_curr_threshold:	High current threshold, in mA
+ * @lowbat_threshold:		Low battery threshold, in mV
+ * @overbat_threshold:		Over battery threshold, in mV
+ * @battok_falling_th_sel0	Threshold in mV for battOk signal sel0
+ *				Resolution in 50 mV step.
+ * @battok_raising_th_sel1	Threshold in mV for battOk signal sel1
+ *				Resolution in 50 mV step.
+ * @user_cap_limit		Capacity reported from user must be within this
+ *				limit to be considered as sane, in percentage
+ *				points.
+ * @maint_thres			This is the threshold where we stop reporting
+ *				battery full while in maintenance, in per cent
+ * @pcut_enable:			Enable power cut feature in ab8505
+ * @pcut_max_time:		Max time threshold
+ * @pcut_flag_time:		Flagtime threshold
+ * @pcut_max_restart:		Max number of restarts
+ * @pcut_debounce_time:		Sets battery debounce time
+ */
+struct abx500_fg_parameters {
+	int recovery_sleep_timer;
+	int recovery_total_time;
+	int init_timer;
+	int init_discard_time;
+	int init_total_time;
+	int high_curr_time;
+	int accu_charging;
+	int accu_high_curr;
+	int high_curr_threshold;
+	int lowbat_threshold;
+	int overbat_threshold;
+	int battok_falling_th_sel0;
+	int battok_raising_th_sel1;
+	int user_cap_limit;
+	int maint_thres;
+	bool pcut_enable;
+	u8 pcut_max_time;
+	u8 pcut_flag_time;
+	u8 pcut_max_restart;
+	u8 pcut_debounce_time;
+};
+
+/**
+ * struct abx500_charger_maximization - struct used by the board config.
+ * @use_maxi:		Enable maximization for this battery type
+ * @maxi_chg_curr:	Maximum charger current allowed
+ * @maxi_wait_cycles:	cycles to wait before setting charger current
+ * @charger_curr_step	delta between two charger current settings (mA)
+ */
+struct abx500_maxim_parameters {
+	bool ena_maxi;
+	int chg_curr;
+	int wait_cycles;
+	int charger_curr_step;
+};
+
+/**
+ * struct abx500_battery_type - different batteries supported
+ * @name:			battery technology
+ * @resis_high:			battery upper resistance limit
+ * @resis_low:			battery lower resistance limit
+ * @charge_full_design:		Maximum battery capacity in mAh
+ * @nominal_voltage:		Nominal voltage of the battery in mV
+ * @termination_vol:		max voltage upto which battery can be charged
+ * @termination_curr		battery charging termination current in mA
+ * @recharge_cap		battery capacity limit that will trigger a new
+ *				full charging cycle in the case where maintenan-
+ *				-ce charging has been disabled
+ * @normal_cur_lvl:		charger current in normal state in mA
+ * @normal_vol_lvl:		charger voltage in normal state in mV
+ * @maint_a_cur_lvl:		charger current in maintenance A state in mA
+ * @maint_a_vol_lvl:		charger voltage in maintenance A state in mV
+ * @maint_a_chg_timer_h:	charge time in maintenance A state
+ * @maint_b_cur_lvl:		charger current in maintenance B state in mA
+ * @maint_b_vol_lvl:		charger voltage in maintenance B state in mV
+ * @maint_b_chg_timer_h:	charge time in maintenance B state
+ * @low_high_cur_lvl:		charger current in temp low/high state in mA
+ * @low_high_vol_lvl:		charger voltage in temp low/high state in mV'
+ * @battery_resistance:		battery inner resistance in mOhm.
+ * @n_r_t_tbl_elements:		number of elements in r_to_t_tbl
+ * @r_to_t_tbl:			table containing resistance to temp points
+ * @n_v_cap_tbl_elements:	number of elements in v_to_cap_tbl
+ * @v_to_cap_tbl:		Voltage to capacity (in %) table
+ * @n_batres_tbl_elements	number of elements in the batres_tbl
+ * @batres_tbl			battery internal resistance vs temperature table
+ */
+struct abx500_battery_type {
+	int name;
+	int resis_high;
+	int resis_low;
+	int charge_full_design;
+	int nominal_voltage;
+	int termination_vol;
+	int termination_curr;
+	int recharge_cap;
+	int normal_cur_lvl;
+	int normal_vol_lvl;
+	int maint_a_cur_lvl;
+	int maint_a_vol_lvl;
+	int maint_a_chg_timer_h;
+	int maint_b_cur_lvl;
+	int maint_b_vol_lvl;
+	int maint_b_chg_timer_h;
+	int low_high_cur_lvl;
+	int low_high_vol_lvl;
+	int battery_resistance;
+	int n_temp_tbl_elements;
+	const struct abx500_res_to_temp *r_to_t_tbl;
+	int n_v_cap_tbl_elements;
+	const struct abx500_v_to_cap *v_to_cap_tbl;
+	int n_batres_tbl_elements;
+	const struct batres_vs_temp *batres_tbl;
+};
+
+/**
+ * struct abx500_bm_capacity_levels - abx500 capacity level data
+ * @critical:		critical capacity level in percent
+ * @low:		low capacity level in percent
+ * @normal:		normal capacity level in percent
+ * @high:		high capacity level in percent
+ * @full:		full capacity level in percent
+ */
+struct abx500_bm_capacity_levels {
+	int critical;
+	int low;
+	int normal;
+	int high;
+	int full;
+};
+
+/**
+ * struct abx500_bm_charger_parameters - Charger specific parameters
+ * @usb_volt_max:	maximum allowed USB charger voltage in mV
+ * @usb_curr_max:	maximum allowed USB charger current in mA
+ * @ac_volt_max:	maximum allowed AC charger voltage in mV
+ * @ac_curr_max:	maximum allowed AC charger current in mA
+ */
+struct abx500_bm_charger_parameters {
+	int usb_volt_max;
+	int usb_curr_max;
+	int ac_volt_max;
+	int ac_curr_max;
+};
+
+/**
+ * struct abx500_bm_data - abx500 battery management data
+ * @temp_under		under this temp, charging is stopped
+ * @temp_low		between this temp and temp_under charging is reduced
+ * @temp_high		between this temp and temp_over charging is reduced
+ * @temp_over		over this temp, charging is stopped
+ * @temp_now		present battery temperature
+ * @temp_interval_chg	temperature measurement interval in s when charging
+ * @temp_interval_nochg	temperature measurement interval in s when not charging
+ * @main_safety_tmr_h	safety timer for main charger
+ * @usb_safety_tmr_h	safety timer for usb charger
+ * @bkup_bat_v		voltage which we charge the backup battery with
+ * @bkup_bat_i		current which we charge the backup battery with
+ * @no_maintenance	indicates that maintenance charging is disabled
+ * @capacity_scaling    indicates whether capacity scaling is to be used
+ * @abx500_adc_therm	placement of thermistor, batctrl or battemp adc
+ * @chg_unknown_bat	flag to enable charging of unknown batteries
+ * @enable_overshoot	flag to enable VBAT overshoot control
+ * @auto_trig		flag to enable auto adc trigger
+ * @fg_res		resistance of FG resistor in 0.1mOhm
+ * @n_btypes		number of elements in array bat_type
+ * @batt_id		index of the identified battery in array bat_type
+ * @interval_charging	charge alg cycle period time when charging (sec)
+ * @interval_not_charging charge alg cycle period time when not charging (sec)
+ * @temp_hysteresis	temperature hysteresis
+ * @gnd_lift_resistance	Battery ground to phone ground resistance (mOhm)
+ * @n_chg_out_curr		number of elements in array chg_output_curr
+ * @n_chg_in_curr		number of elements in array chg_input_curr
+ * @chg_output_curr	charger output current level map
+ * @chg_input_curr		charger input current level map
+ * @maxi		maximization parameters
+ * @cap_levels		capacity in percent for the different capacity levels
+ * @bat_type		table of supported battery types
+ * @chg_params		charger parameters
+ * @fg_params		fuel gauge parameters
+ */
+struct abx500_bm_data {
+	int temp_under;
+	int temp_low;
+	int temp_high;
+	int temp_over;
+	int temp_now;
+	int temp_interval_chg;
+	int temp_interval_nochg;
+	int main_safety_tmr_h;
+	int usb_safety_tmr_h;
+	int bkup_bat_v;
+	int bkup_bat_i;
+	bool autopower_cfg;
+	bool ac_enabled;
+	bool usb_enabled;
+	bool no_maintenance;
+	bool capacity_scaling;
+	bool chg_unknown_bat;
+	bool enable_overshoot;
+	bool auto_trig;
+	enum abx500_adc_therm adc_therm;
+	int fg_res;
+	int n_btypes;
+	int batt_id;
+	int interval_charging;
+	int interval_not_charging;
+	int temp_hysteresis;
+	int gnd_lift_resistance;
+	int n_chg_out_curr;
+	int n_chg_in_curr;
+	int *chg_output_curr;
+	int *chg_input_curr;
+	const struct abx500_maxim_parameters *maxi;
+	const struct abx500_bm_capacity_levels *cap_levels;
+	struct abx500_battery_type *bat_type;
+	const struct abx500_bm_charger_parameters *chg_params;
+	const struct abx500_fg_parameters *fg_params;
+};
+
+enum {
+	NTC_EXTERNAL = 0,
+	NTC_INTERNAL,
+};
+
 /**
  * struct res_to_temp - defines one point in a temp to res curve. To
  * be used in battery packs that combines the identification resistor with a
@@ -447,9 +717,6 @@ struct ab8500_bm_data {
 	const struct ab8500_fg_parameters *fg_params;
 };
 
-struct ab8500_btemp;
-struct ab8500_fg;
-
 extern struct abx500_bm_data ab8500_bm_data;
 
 void ab8500_charger_usb_state_changed(u8 bm_usb_state, u16 mA);
@@ -459,5 +726,8 @@ int ab8500_fg_inst_curr_start(struct ab8500_fg *di);
 int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *res);
 int ab8500_fg_inst_curr_started(struct ab8500_fg *di);
 int ab8500_fg_inst_curr_done(struct ab8500_fg *di);
+int ab8500_bm_of_probe(struct device *dev,
+		       struct device_node *np,
+		       struct abx500_bm_data *bm);
 
 #endif /* _AB8500_CHARGER_H_ */
diff --git a/include/linux/mfd/abx500.h b/include/linux/mfd/abx500.h
index 23040b6f1615..7f07cfe44753 100644
--- a/include/linux/mfd/abx500.h
+++ b/include/linux/mfd/abx500.h
@@ -28,282 +28,6 @@ struct abx500_init_settings {
 	u8 setting;
 };
 
-/* Battery driver related data */
-/*
- * ADC for the battery thermistor.
- * When using the ABx500_ADC_THERM_BATCTRL the battery ID resistor is combined
- * with a NTC resistor to both identify the battery and to measure its
- * temperature. Different phone manufactures uses different techniques to both
- * identify the battery and to read its temperature.
- */
-enum abx500_adc_therm {
-	ABx500_ADC_THERM_BATCTRL,
-	ABx500_ADC_THERM_BATTEMP,
-};
-
-/**
- * struct abx500_res_to_temp - defines one point in a temp to res curve. To
- * be used in battery packs that combines the identification resistor with a
- * NTC resistor.
- * @temp:			battery pack temperature in Celsius
- * @resist:			NTC resistor net total resistance
- */
-struct abx500_res_to_temp {
-	int temp;
-	int resist;
-};
-
-/**
- * struct abx500_v_to_cap - Table for translating voltage to capacity
- * @voltage:		Voltage in mV
- * @capacity:		Capacity in percent
- */
-struct abx500_v_to_cap {
-	int voltage;
-	int capacity;
-};
-
-/* Forward declaration */
-struct abx500_fg;
-
-/**
- * struct abx500_fg_parameters - Fuel gauge algorithm parameters, in seconds
- * if not specified
- * @recovery_sleep_timer:	Time between measurements while recovering
- * @recovery_total_time:	Total recovery time
- * @init_timer:			Measurement interval during startup
- * @init_discard_time:		Time we discard voltage measurement at startup
- * @init_total_time:		Total init time during startup
- * @high_curr_time:		Time current has to be high to go to recovery
- * @accu_charging:		FG accumulation time while charging
- * @accu_high_curr:		FG accumulation time in high current mode
- * @high_curr_threshold:	High current threshold, in mA
- * @lowbat_threshold:		Low battery threshold, in mV
- * @overbat_threshold:		Over battery threshold, in mV
- * @battok_falling_th_sel0	Threshold in mV for battOk signal sel0
- *				Resolution in 50 mV step.
- * @battok_raising_th_sel1	Threshold in mV for battOk signal sel1
- *				Resolution in 50 mV step.
- * @user_cap_limit		Capacity reported from user must be within this
- *				limit to be considered as sane, in percentage
- *				points.
- * @maint_thres			This is the threshold where we stop reporting
- *				battery full while in maintenance, in per cent
- * @pcut_enable:			Enable power cut feature in ab8505
- * @pcut_max_time:		Max time threshold
- * @pcut_flag_time:		Flagtime threshold
- * @pcut_max_restart:		Max number of restarts
- * @pcut_debounce_time:		Sets battery debounce time
- */
-struct abx500_fg_parameters {
-	int recovery_sleep_timer;
-	int recovery_total_time;
-	int init_timer;
-	int init_discard_time;
-	int init_total_time;
-	int high_curr_time;
-	int accu_charging;
-	int accu_high_curr;
-	int high_curr_threshold;
-	int lowbat_threshold;
-	int overbat_threshold;
-	int battok_falling_th_sel0;
-	int battok_raising_th_sel1;
-	int user_cap_limit;
-	int maint_thres;
-	bool pcut_enable;
-	u8 pcut_max_time;
-	u8 pcut_flag_time;
-	u8 pcut_max_restart;
-	u8 pcut_debounce_time;
-};
-
-/**
- * struct abx500_charger_maximization - struct used by the board config.
- * @use_maxi:		Enable maximization for this battery type
- * @maxi_chg_curr:	Maximum charger current allowed
- * @maxi_wait_cycles:	cycles to wait before setting charger current
- * @charger_curr_step	delta between two charger current settings (mA)
- */
-struct abx500_maxim_parameters {
-	bool ena_maxi;
-	int chg_curr;
-	int wait_cycles;
-	int charger_curr_step;
-};
-
-/**
- * struct abx500_battery_type - different batteries supported
- * @name:			battery technology
- * @resis_high:			battery upper resistance limit
- * @resis_low:			battery lower resistance limit
- * @charge_full_design:		Maximum battery capacity in mAh
- * @nominal_voltage:		Nominal voltage of the battery in mV
- * @termination_vol:		max voltage upto which battery can be charged
- * @termination_curr		battery charging termination current in mA
- * @recharge_cap		battery capacity limit that will trigger a new
- *				full charging cycle in the case where maintenan-
- *				-ce charging has been disabled
- * @normal_cur_lvl:		charger current in normal state in mA
- * @normal_vol_lvl:		charger voltage in normal state in mV
- * @maint_a_cur_lvl:		charger current in maintenance A state in mA
- * @maint_a_vol_lvl:		charger voltage in maintenance A state in mV
- * @maint_a_chg_timer_h:	charge time in maintenance A state
- * @maint_b_cur_lvl:		charger current in maintenance B state in mA
- * @maint_b_vol_lvl:		charger voltage in maintenance B state in mV
- * @maint_b_chg_timer_h:	charge time in maintenance B state
- * @low_high_cur_lvl:		charger current in temp low/high state in mA
- * @low_high_vol_lvl:		charger voltage in temp low/high state in mV'
- * @battery_resistance:		battery inner resistance in mOhm.
- * @n_r_t_tbl_elements:		number of elements in r_to_t_tbl
- * @r_to_t_tbl:			table containing resistance to temp points
- * @n_v_cap_tbl_elements:	number of elements in v_to_cap_tbl
- * @v_to_cap_tbl:		Voltage to capacity (in %) table
- * @n_batres_tbl_elements	number of elements in the batres_tbl
- * @batres_tbl			battery internal resistance vs temperature table
- */
-struct abx500_battery_type {
-	int name;
-	int resis_high;
-	int resis_low;
-	int charge_full_design;
-	int nominal_voltage;
-	int termination_vol;
-	int termination_curr;
-	int recharge_cap;
-	int normal_cur_lvl;
-	int normal_vol_lvl;
-	int maint_a_cur_lvl;
-	int maint_a_vol_lvl;
-	int maint_a_chg_timer_h;
-	int maint_b_cur_lvl;
-	int maint_b_vol_lvl;
-	int maint_b_chg_timer_h;
-	int low_high_cur_lvl;
-	int low_high_vol_lvl;
-	int battery_resistance;
-	int n_temp_tbl_elements;
-	const struct abx500_res_to_temp *r_to_t_tbl;
-	int n_v_cap_tbl_elements;
-	const struct abx500_v_to_cap *v_to_cap_tbl;
-	int n_batres_tbl_elements;
-	const struct batres_vs_temp *batres_tbl;
-};
-
-/**
- * struct abx500_bm_capacity_levels - abx500 capacity level data
- * @critical:		critical capacity level in percent
- * @low:		low capacity level in percent
- * @normal:		normal capacity level in percent
- * @high:		high capacity level in percent
- * @full:		full capacity level in percent
- */
-struct abx500_bm_capacity_levels {
-	int critical;
-	int low;
-	int normal;
-	int high;
-	int full;
-};
-
-/**
- * struct abx500_bm_charger_parameters - Charger specific parameters
- * @usb_volt_max:	maximum allowed USB charger voltage in mV
- * @usb_curr_max:	maximum allowed USB charger current in mA
- * @ac_volt_max:	maximum allowed AC charger voltage in mV
- * @ac_curr_max:	maximum allowed AC charger current in mA
- */
-struct abx500_bm_charger_parameters {
-	int usb_volt_max;
-	int usb_curr_max;
-	int ac_volt_max;
-	int ac_curr_max;
-};
-
-/**
- * struct abx500_bm_data - abx500 battery management data
- * @temp_under		under this temp, charging is stopped
- * @temp_low		between this temp and temp_under charging is reduced
- * @temp_high		between this temp and temp_over charging is reduced
- * @temp_over		over this temp, charging is stopped
- * @temp_now		present battery temperature
- * @temp_interval_chg	temperature measurement interval in s when charging
- * @temp_interval_nochg	temperature measurement interval in s when not charging
- * @main_safety_tmr_h	safety timer for main charger
- * @usb_safety_tmr_h	safety timer for usb charger
- * @bkup_bat_v		voltage which we charge the backup battery with
- * @bkup_bat_i		current which we charge the backup battery with
- * @no_maintenance	indicates that maintenance charging is disabled
- * @capacity_scaling    indicates whether capacity scaling is to be used
- * @abx500_adc_therm	placement of thermistor, batctrl or battemp adc
- * @chg_unknown_bat	flag to enable charging of unknown batteries
- * @enable_overshoot	flag to enable VBAT overshoot control
- * @auto_trig		flag to enable auto adc trigger
- * @fg_res		resistance of FG resistor in 0.1mOhm
- * @n_btypes		number of elements in array bat_type
- * @batt_id		index of the identified battery in array bat_type
- * @interval_charging	charge alg cycle period time when charging (sec)
- * @interval_not_charging charge alg cycle period time when not charging (sec)
- * @temp_hysteresis	temperature hysteresis
- * @gnd_lift_resistance	Battery ground to phone ground resistance (mOhm)
- * @n_chg_out_curr		number of elements in array chg_output_curr
- * @n_chg_in_curr		number of elements in array chg_input_curr
- * @chg_output_curr	charger output current level map
- * @chg_input_curr		charger input current level map
- * @maxi		maximization parameters
- * @cap_levels		capacity in percent for the different capacity levels
- * @bat_type		table of supported battery types
- * @chg_params		charger parameters
- * @fg_params		fuel gauge parameters
- */
-struct abx500_bm_data {
-	int temp_under;
-	int temp_low;
-	int temp_high;
-	int temp_over;
-	int temp_now;
-	int temp_interval_chg;
-	int temp_interval_nochg;
-	int main_safety_tmr_h;
-	int usb_safety_tmr_h;
-	int bkup_bat_v;
-	int bkup_bat_i;
-	bool autopower_cfg;
-	bool ac_enabled;
-	bool usb_enabled;
-	bool no_maintenance;
-	bool capacity_scaling;
-	bool chg_unknown_bat;
-	bool enable_overshoot;
-	bool auto_trig;
-	enum abx500_adc_therm adc_therm;
-	int fg_res;
-	int n_btypes;
-	int batt_id;
-	int interval_charging;
-	int interval_not_charging;
-	int temp_hysteresis;
-	int gnd_lift_resistance;
-	int n_chg_out_curr;
-	int n_chg_in_curr;
-	int *chg_output_curr;
-	int *chg_input_curr;
-	const struct abx500_maxim_parameters *maxi;
-	const struct abx500_bm_capacity_levels *cap_levels;
-	struct abx500_battery_type *bat_type;
-	const struct abx500_bm_charger_parameters *chg_params;
-	const struct abx500_fg_parameters *fg_params;
-};
-
-enum {
-	NTC_EXTERNAL = 0,
-	NTC_INTERNAL,
-};
-
-int ab8500_bm_of_probe(struct device *dev,
-		       struct device_node *np,
-		       struct abx500_bm_data *bm);
-
 int abx500_set_register_interruptible(struct device *dev, u8 bank, u8 reg,
 	u8 value);
 int abx500_get_register_interruptible(struct device *dev, u8 bank, u8 reg,
-- 
2.29.2

