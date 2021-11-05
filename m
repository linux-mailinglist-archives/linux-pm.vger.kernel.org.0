Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0C6445D0C
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 01:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhKEAfR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 20:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKEAfQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Nov 2021 20:35:16 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4647C061714
        for <linux-pm@vger.kernel.org>; Thu,  4 Nov 2021 17:32:37 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a10so4819439ljk.13
        for <linux-pm@vger.kernel.org>; Thu, 04 Nov 2021 17:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n9FT2OPeKjYm1+cl0IT+zevMfge61wgb/Jr/AMXOTgY=;
        b=Perhv4X+PLD47FvriFJsOX4BM3NjRhyCBBb4M86CpBYZ01zab7bm4dAven7EbEDaso
         7TlVfv4heSvECRi7k5zgSJpFcmABtOCrm4zqbyLSV3Iii9Brp2Evq6jXvinWVFD0OjUN
         /3H3tjrMJe0KDpIh8yk1rHjHyTpuIhUqkJYUl9ZY1TGM278e8tnvapsOO12GOOmSvCdT
         uYKK8mhQhDu/pS5TINXz8trQO8orBmuAaDIUB+cOo/TRboCbBlIBLu8Tb420qer3ca1C
         jxPNZ92cnGG3kdXAPTWD9odQe+Rzp7R22hoe0+amWPTXmF9o80hdNFOCnnpVR45d044/
         gp8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n9FT2OPeKjYm1+cl0IT+zevMfge61wgb/Jr/AMXOTgY=;
        b=Bx/CYhhYy18kzOD9jshVcayzBxnSrfrZ2ZXxN9Sznr1nBtuZ8z9VV6me12F4t8Q+sa
         tdIP4/K+QbEKr3lbux6Vb09Jj3qiKrnV5QDaMAk8to4M5Xa62J6+IcnBuuc4pSmaTpbj
         hwG4gd7XZN7VHv34+eKLnn9xGfz3GtCeiI0fvklRQQGZB82I33B15/F/3wLU43J4j11o
         pDHb8jnY+tFShlpw+V560GNn69sFvN7Ad4WuQCl+buzrI5MqUWEFEZWv5SzKWDR8VM/2
         SoOxA4jJl+0yXEFWpqTaSbB2tL2qcUBrq8lQStuTjW5wGNLMpjGApZVkROcGip0YdG90
         16Bg==
X-Gm-Message-State: AOAM5302YP+Lo7n39lJ7pN42J7ihZmUfq5+YH+ottc2m87xeaYZaQVuG
        vugtbUvQctmm/UU+nIIcIMn0/QJGqlkafQ==
X-Google-Smtp-Source: ABdhPJyyap5V0CkUG6k9n0AcB9ti4PsYFKEHtzGq4KMSRDh6Paxwb7+fm2/DljQ1/7qG3G5aiuTaeA==
X-Received: by 2002:a2e:9b41:: with SMTP id o1mr53797639ljj.499.1636072355988;
        Thu, 04 Nov 2021 17:32:35 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j12sm635197lfr.226.2021.11.04.17.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 17:32:35 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] power: supply: core: Add kerneldoc to battery struct
Date:   Fri,  5 Nov 2021 01:30:26 +0100
Message-Id: <20211105003026.970184-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This complements the struct power_supply_battery_info with
extensive kerneldoc explaining the different semantics of the
fields, including an overview of the CC/CV charging concepts
implicit in some of the struct members.

This is done to first establish semantics before I can
add more charging methods by breaking out the CC/CV parameters
to its own struct.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/linux/power_supply.h | 209 +++++++++++++++++++++++++++++++----
 1 file changed, 186 insertions(+), 23 deletions(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9ca1f120a211..671730c5279f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -342,37 +342,200 @@ struct power_supply_resistance_temp_table {
 
 #define POWER_SUPPLY_OCV_TEMP_MAX 20
 
-/*
+/**
+ * struct power_supply_battery_info - information about batteries
+ * @technology: from the POWER_SUPPLY_TECHNOLOGY_* enum
+ * @energy_full_design_uwh: energy content when fully charged in microwatt
+ *   hours
+ * @charge_full_design_uah: charge content when fully charged in microampere
+ *   hours
+ * @voltage_min_design_uv: minimum voltage across the poles when the battery
+ *   is at minimum voltage level in microvolts. If the voltage drops below this
+ *   level the battery will need precharging when using CC/CV charging.
+ * @voltage_max_design_uv: voltage across the poles when the battery is fully
+ *   charged in microvolts. This is the "nominal voltage" i.e. the voltage
+ *   printed on the label of the battery.
+ * @tricklecharge_current_ua: the tricklecharge current used when trickle
+ *   charging the battery in microamperes. This is the charging phase when the
+ *   battery is fully charged and we just trickle in some current to keep the
+ *   voltage up between constant_charge_voltage_max_uv and overvoltage_limit_uv.
+ * @precharge_current_ua: current to use in the precharge phase in microamperes,
+ *   the precharge rate is limited by limiting the current to this value.
+ * @precharge_voltage_max_uv: the maximum voltage allowed when precharging in
+ *   microvolts. When we pass this voltage we will nominally switch over to the
+ *   next charging phase defined by constant_charge_current_ua and
+ *   constant_charge_voltage_max_uv.
+ * @charge_term_current_ua: when the current in the CV (constant voltage)
+ *   charging phase drops below this value in microamperes the charging will
+ *   terminate completely and not restart until the voltage over the battery
+ *   poles reach charge_restart_voltage_uv unless we use trickle charging.
+ * @charge_restart_voltage_uv: when the battery has been fully charged by
+ *   CC/CV charging and charging has been disabled, and the voltage subsequently
+ *   drops below this value in microvolts, the charging will be restarted
+ *   (typically using CV charging).
+ * @overvoltage_limit_uv: when tricklecharging the battery can temporarily
+ *   exceed the nominal voltage voltage_max_design_uv. The tricklecharginging
+ *   must stop when we reach this value, not to restart unless we get back
+ *   down to constant_charge_voltage_max_uv.
+ * @constant_charge_current_max_ua: current in microamperes to use in the CC
+ *   (constant current) charging phase. The charging rate is limited
+ *   by this current. This is the main charging phase and as the current is
+ *   constant into the battery the voltage slowly ascends to
+ *   constant_charge_voltage_max_uv.
+ * @constant_charge_voltage_max_uv: voltage in microvolts signifying the end of
+ *   the CC (constant current) charging phase and the beginning of the CV
+ *   (constant voltage) charging phase.
+ * @factory_internal_resistance_uohm: the internal resistance of the battery
+ *   at fabrication time, expressed in microohms. This resistance will vary
+ *   depending on the lifetime and charge of the battery, so this is just a
+ *   nominal ballpark figure.
+ * @ocv_temp: array indicating the open circuit voltage (OCV) capacity
+ *   temperature indices. This is an array of temperatures in degrees celsius
+ *   indicating which capacity table to used for a certain temperature, since
+ *   the capacity for reasons of chemistry will be different at different
+ *   temperatures. Determining capacity is a multivariate problem and the
+ *   temperature is the first variable we determine.
+ * @temp_ambient_alert_min: the battery will go outside of operating conditions
+ *   when the ambient temperature goes below this temperature in degrees
+ *   celsius.
+ * @temp_ambient_alert_max: the battery will go outside of operating conditions
+ *   when the ambient temperature goes above this temperature in degrees
+ *   celsius.
+ * @temp_alert_min: the battery should issue an alert if the internal
+ *   temperature goes below this temperature in degrees celsius.
+ * @temp_alert_max: the battery should issue an alert if the internal
+ *   temperature goes above this temperature in degrees celsius.
+ * @temp_min: the battery will go outside of operating conditions when
+ *   the internal temperature goes below this temperature in degrees celsius.
+ *   Normally this means the system should shut down.
+ * @temp_max: the battery will go outside of operating conditions when
+ *   the internal temperature goes above this temperature in degrees celsius.
+ *   Normally this means the system should shut down.
+ * @ocv_table: for each entry in ocv_temp there is a corresponding entry in
+ *   ocv_table and a size for each entry in ocv_table_size. These arrays
+ *   determine the capacity in percent in relation to the voltage in microvolts
+ *   at the indexed temperature.
+ * @ocv_table_size: for each entry in ocv_temp this array is giving the size of
+ *   each entry in the array of capacity arrays in ocv_table.
+ * @resist_table: this is a table that correlates a resistance to an internal
+ *   temperature of a battery. This can be achieved by a separate thermistor to
+ *   supply voltage on a third terminal on a battery which is the most
+ *   reliable. An external thermistor can also be used sometimes.
+ * @resist_table_size: the number of items in the resist table.
+ *
  * This is the recommended struct to manage static battery parameters,
  * populated by power_supply_get_battery_info(). Most platform drivers should
  * use these for consistency.
+ *
  * Its field names must correspond to elements in enum power_supply_property.
  * The default field value is -EINVAL.
- * Power supply class itself doesn't use this.
+ *
+ * The charging parameters here assumes a CC/CV charging scheme. This method
+ * is most common with Lithium Ion batteries (other methods are possible) and
+ * looks as follows:
+ *
+ * ^ Battery voltage
+ * |                                                   overvoltage_limit_uv
+ * |                                                    ..          ..
+ * |                    ................................  ....   ..   ..
+ * |                 .. constant_charge_voltage_max_uv        ...
+ * |              ..
+ * |             .
+ * |            .
+ * |           .
+ * |          .
+ * |         .
+ * |     .. precharge_voltage_max_uv
+ * |  ..
+ * |.
+ * +------------------------------------------------------------------> time
+ *
+ * ^ Current into the battery
+ * |
+ * |      ............. constant_charge_current_max_ua
+ * |      .            .
+ * |      .             .
+ * |      .              .
+ * |      .               .
+ * |      .                ..
+ * |      .                  ....
+ * |      .                       .....
+ * |      .                            .......  charge_term_current_ua
+ * |      .                                   ..........
+ * |....... precharge_current_ua                       . tricklecharge_current_ua
+ * |                                                   ...      ....
+ * |                                                     .      .  .
+ * +-----------------------------------------------------------------> time
+ *
+ * These diagrams are synchronized on time and the voltage and current
+ * follow each other.
+ *
+ * With CC/CV charging commence over time like this for an empty battery:
+ *
+ * 1. First a small initial pre-charge current (precharge_current_ua)
+ *    is applied if the voltage is below precharge_voltage_max_uv until we
+ *    reach precharge_voltage_max_uv. CATION: in some text this is referred
+ *    to as "trickle charging" but the use in the Linux kernel is differen
+ *    see below!
+ *
+ * 2. Then the main charging current is applied, which is called the constant
+ *    current (CC) phase. A current regulator is set up to allow
+ *    constant_charge_current_max_ua of current to flow into the battery.
+ *    The chemical reaction in the battery will make the voltage go up as
+ *    charge goes into the battery. This current is applied until we reach
+ *    the constant_charge_voltage_max_uv voltage.
+ *
+ * 3. At this voltage we switch over to the constant voltage (CV) phase. This
+ *    means we allow current to go into the battery, but we keep the voltage
+ *    fixed. This current will continue to charge the battery while keeping
+ *    the voltage the same. A chemical reaction in the battery goes on
+ *    storing energy without affecting the voltage. Over time the current
+ *    will slowly drop and when we reach charge_term_current_ua we will
+ *    end the constant voltage phase.
+ *
+ * After this the battery is fully charged, and if we do not support trickle
+ * charging, the charging will not restart until power dissapation make the
+ * voltage fall so that we reach charge_restart_voltage_uv and at this point
+ * we restart charging at the appropriate phase, usually this will be inside
+ * the CV phase.
+ *
+ * If we support trickle charging the voltage is however kept high after
+ * the CV phase with a very low current. This is meant to let some charge
+ * "trickle in" for usage while the charger is still connected, mainly for
+ * dissipation for the power consuming entity while connected to the
+ * charger. We allow extra charge to trickle in so that the voltage can
+ * occasionally rise up to overvoltage_limit_uv, and if this happens even
+ * trickle charging is disabled and no current goes into the battery.
+ *
+ * Trickle- and any other charging MUST terminate if the overvoltage_limit_uv
+ * is ever reached. Overcharging Lithium Ion cells can be DANGEROUS and lead
+ * to fire or explosions.
+ *
+ * The power supply class itself doesn't use this struct as of now.
  */
 
 struct power_supply_battery_info {
-	unsigned int technology;	    /* from the enum above */
-	int energy_full_design_uwh;	    /* microWatt-hours */
-	int charge_full_design_uah;	    /* microAmp-hours */
-	int voltage_min_design_uv;	    /* microVolts */
-	int voltage_max_design_uv;	    /* microVolts */
-	int tricklecharge_current_ua;	    /* microAmps */
-	int precharge_current_ua;	    /* microAmps */
-	int precharge_voltage_max_uv;	    /* microVolts */
-	int charge_term_current_ua;	    /* microAmps */
-	int charge_restart_voltage_uv;	    /* microVolts */
-	int overvoltage_limit_uv;	    /* microVolts */
-	int constant_charge_current_max_ua; /* microAmps */
-	int constant_charge_voltage_max_uv; /* microVolts */
-	int factory_internal_resistance_uohm;   /* microOhms */
-	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];/* celsius */
-	int temp_ambient_alert_min;             /* celsius */
-	int temp_ambient_alert_max;             /* celsius */
-	int temp_alert_min;                     /* celsius */
-	int temp_alert_max;                     /* celsius */
-	int temp_min;                           /* celsius */
-	int temp_max;                           /* celsius */
+	unsigned int technology;
+	int energy_full_design_uwh;
+	int charge_full_design_uah;
+	int voltage_min_design_uv;
+	int voltage_max_design_uv;
+	int tricklecharge_current_ua;
+	int precharge_current_ua;
+	int precharge_voltage_max_uv;
+	int charge_term_current_ua;
+	int charge_restart_voltage_uv;
+	int overvoltage_limit_uv;
+	int constant_charge_current_max_ua;
+	int constant_charge_voltage_max_uv;
+	int factory_internal_resistance_uohm;
+	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];
+	int temp_ambient_alert_min;
+	int temp_ambient_alert_max;
+	int temp_alert_min;
+	int temp_alert_max;
+	int temp_min;
+	int temp_max;
 	struct power_supply_battery_ocv_table *ocv_table[POWER_SUPPLY_OCV_TEMP_MAX];
 	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
 	struct power_supply_resistance_temp_table *resist_table;
-- 
2.31.1

