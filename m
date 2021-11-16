Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70514453C60
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 23:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhKPWtc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 17:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhKPWtb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Nov 2021 17:49:31 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D6AC061570
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 14:46:34 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 13so1677400ljj.11
        for <linux-pm@vger.kernel.org>; Tue, 16 Nov 2021 14:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJ3RiX0AQ9ZdBBLtc/ZuES9jzu72cbYd4UBlLEWBLhs=;
        b=s5CQkAZlHavJpj8CtwR2oYNKbtj9/f5JowZQuZ8U0fL5x7iZ4GRpLtMlYpkmPr8oBe
         qsFJzZad9prsZcyEEFmq0jwjb7rJaiLPbCzXL6ewiIyKv0aGTNdJCfOADRQ/pLRymQI3
         6yo9IoPLfZvYIvJpWsP5WzYAgvdrfTnvGjb/npHQV7hFyMZl39Q4qzpRDf4x/e2lQGWf
         oFRmFRS24RKWN+m+MJDMFILS+yvhYdhLeTnwha/ux99Sq05L8bt2UPHBZJiUasWll1dJ
         8NBZITfAHH3A5Mr3lhFGwpEs7o57HEb3lyDPlMfzTYesNY0JSk0mN4A5oCyxpj8UpxK6
         GboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJ3RiX0AQ9ZdBBLtc/ZuES9jzu72cbYd4UBlLEWBLhs=;
        b=L3iOT18pQj0z/3v8TK6yMXDcBA5IZnKrJma738lAzWVOfe1lZEVn2KM1CvBHpsWMsN
         CaMkz/n1aAmug+GecRHLKKs9PdzJwrNr1XD38HHXJNwGy5dJSBusQGf59TAD4S6X5TSX
         +haGLoQJPsTqirkDW3pU9o/dcNB4ZdcgrcRoENh4dO15cYSHEvjHcdw9scliGisjPhL/
         GwjEyFp1AmmpHHTTQR/jFH5SNszOMpUJiQvDkA8KrLf1H3Wep3LdL2I+VagVu2/VvQgg
         1ntUOYlLedqoqncFiz9YmfaPpezt7xxLm5xeHO22Fku6i+rBuMdTU9E1WxSR3v6rno1o
         Dkug==
X-Gm-Message-State: AOAM530KPTXFciHlBWzVIgwKViuYbJgYlDTKmdVqYFbK4sv/d5NJc0RE
        cD9CXZE1VJ9L5XCZMhWDWdTbR/XaTA+0dA==
X-Google-Smtp-Source: ABdhPJwj8UZ70uLJUiAdGgCWgPcA8uYYb3BkpiNcBsoSKr6nEGkYbRpx0Bgmm/plONwcz3JQSl/3QQ==
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr2916589ljp.353.1637102792262;
        Tue, 16 Nov 2021 14:46:32 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t9sm1906447lfe.88.2021.11.16.14.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 14:46:31 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: [PATCH v4] power: supply: core: Add kerneldoc to battery struct
Date:   Tue, 16 Nov 2021 23:44:28 +0100
Message-Id: <20211116224428.2157735-1-linus.walleij@linaro.org>
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

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Make the precharge phase explicitly reference the CC phase.
- Fix up the text about the resist table to be more accurate.
- Collect Matti's Review tag.
ChangeLog v2->v3:
- After reading the Rohm bd99954 I realized I put the trickle
  charging at the end of the phase (as I like it to be) but
  the one driver using it is putting it before pre-charge,
  so we adapt to this fact. I will add new properties for
  "maintenance charging" that happen after CV instead.
- Matti, please check this so I don't make any more mistakes.
ChangeLog v1->v2:
- Fix some spelling error etc.
---
 include/linux/power_supply.h | 215 +++++++++++++++++++++++++++++++----
 1 file changed, 192 insertions(+), 23 deletions(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 9ca1f120a211..b5079109ac00 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -342,37 +342,206 @@ struct power_supply_resistance_temp_table {
 
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
+ *   battery is completely empty and we need to carefully trickle in some
+ *   charge until we reach the precharging voltage.
+ * @precharge_current_ua: current to use in the precharge phase in microamperes,
+ *   the precharge rate is limited by limiting the current to this value.
+ * @precharge_voltage_max_uv: the maximum voltage allowed when precharging in
+ *   microvolts. When we pass this voltage we will nominally switch over to the
+ *   CC (constant current) charging phase defined by constant_charge_current_ua
+ *   and constant_charge_voltage_max_uv.
+ * @charge_term_current_ua: when the current in the CV (constant voltage)
+ *   charging phase drops below this value in microamperes the charging will
+ *   terminate completely and not restart until the voltage over the battery
+ *   poles reach charge_restart_voltage_uv unless we use maintenance charging.
+ * @charge_restart_voltage_uv: when the battery has been fully charged by
+ *   CC/CV charging and charging has been disabled, and the voltage subsequently
+ *   drops below this value in microvolts, the charging will be restarted
+ *   (typically using CV charging).
+ * @overvoltage_limit_uv: If the voltage exceeds the nominal voltage
+ *   voltage_max_design_uv and we reach this voltage level, all charging must
+ *   stop and emergency procedures take place, such as shutting down the system
+ *   in some cases.
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
+ *   temperature indices. This is an array of temperatures in degrees Celsius
+ *   indicating which capacity table to use for a certain temperature, since
+ *   the capacity for reasons of chemistry will be different at different
+ *   temperatures. Determining capacity is a multivariate problem and the
+ *   temperature is the first variable we determine.
+ * @temp_ambient_alert_min: the battery will go outside of operating conditions
+ *   when the ambient temperature goes below this temperature in degrees
+ *   Celsius.
+ * @temp_ambient_alert_max: the battery will go outside of operating conditions
+ *   when the ambient temperature goes above this temperature in degrees
+ *   Celsius.
+ * @temp_alert_min: the battery should issue an alert if the internal
+ *   temperature goes below this temperature in degrees Celsius.
+ * @temp_alert_max: the battery should issue an alert if the internal
+ *   temperature goes above this temperature in degrees Celsius.
+ * @temp_min: the battery will go outside of operating conditions when
+ *   the internal temperature goes below this temperature in degrees Celsius.
+ *   Normally this means the system should shut down.
+ * @temp_max: the battery will go outside of operating conditions when
+ *   the internal temperature goes above this temperature in degrees Celsius.
+ *   Normally this means the system should shut down.
+ * @ocv_table: for each entry in ocv_temp there is a corresponding entry in
+ *   ocv_table and a size for each entry in ocv_table_size. These arrays
+ *   determine the capacity in percent in relation to the voltage in microvolts
+ *   at the indexed temperature.
+ * @ocv_table_size: for each entry in ocv_temp this array is giving the size of
+ *   each entry in the array of capacity arrays in ocv_table.
+ * @resist_table: this is a table that correlates a battery temperature to the
+ *   expected internal resistance at this temperature. The resistance is given
+ *   as a percentage of factory_internal_resistance_uohm. Knowing the
+ *   resistance of the battery is usually necessary for calculating the open
+ *   circuit voltage (OCV) that is then used with the ocv_table to calculate
+ *   the capacity of the battery. The resist_table must be ordered descending
+ *   by temperature: highest temperature with lowest resistance first, lowest
+ *   temperature with highest resistance last.
+ * @resist_table_size: the number of items in the resist_table.
+ *
  * This is the recommended struct to manage static battery parameters,
  * populated by power_supply_get_battery_info(). Most platform drivers should
  * use these for consistency.
+ *
  * Its field names must correspond to elements in enum power_supply_property.
  * The default field value is -EINVAL.
- * Power supply class itself doesn't use this.
+ *
+ * The charging parameters here assume a CC/CV charging scheme. This method
+ * is most common with Lithium Ion batteries (other methods are possible) and
+ * looks as follows:
+ *
+ * ^ Battery voltage
+ * |                                               --- overvoltage_limit_uv
+ * |
+ * |                    ...................................................
+ * |                 .. constant_charge_voltage_max_uv
+ * |              ..
+ * |             .
+ * |            .
+ * |           .
+ * |          .
+ * |         .
+ * |     .. precharge_voltage_max_uv
+ * |  ..
+ * |. (trickle charging)
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
+ * |    ... precharge_current_ua       .......  charge_term_current_ua
+ * |    .                                    .
+ * |    .                                    .
+ * |.... tricklecharge_current_ua            .
+ * |                                         .
+ * +-----------------------------------------------------------------> time
+ *
+ * These diagrams are synchronized on time and the voltage and current
+ * follow each other.
+ *
+ * With CC/CV charging commence over time like this for an empty battery:
+ *
+ * 1. When the battery is completely empty it may need to be charged with
+ *    an especially small current so that electrons just "trickle in",
+ *    this is the tricklecharge_current_ua.
+ *
+ * 2. Next a small initial pre-charge current (precharge_current_ua)
+ *    is applied if the voltage is below precharge_voltage_max_uv until we
+ *    reach precharge_voltage_max_uv. CAUTION: in some texts this is referred
+ *    to as "trickle charging" but the use in the Linux kernel is different
+ *    see below!
+ *
+ * 3. Then the main charging current is applied, which is called the constant
+ *    current (CC) phase. A current regulator is set up to allow
+ *    constant_charge_current_max_ua of current to flow into the battery.
+ *    The chemical reaction in the battery will make the voltage go up as
+ *    charge goes into the battery. This current is applied until we reach
+ *    the constant_charge_voltage_max_uv voltage.
+ *
+ * 4. At this voltage we switch over to the constant voltage (CV) phase. This
+ *    means we allow current to go into the battery, but we keep the voltage
+ *    fixed. This current will continue to charge the battery while keeping
+ *    the voltage the same. A chemical reaction in the battery goes on
+ *    storing energy without affecting the voltage. Over time the current
+ *    will slowly drop and when we reach charge_term_current_ua we will
+ *    end the constant voltage phase.
+ *
+ * After this the battery is fully charged, and if we do not support maintenance
+ * charging, the charging will not restart until power dissipation makes the
+ * voltage fall so that we reach charge_restart_voltage_uv and at this point
+ * we restart charging at the appropriate phase, usually this will be inside
+ * the CV phase.
+ *
+ * If we support maintenance charging the voltage is however kept high after
+ * the CV phase with a very low current. This is meant to let the same charge
+ * go in for usage while the charger is still connected, mainly for
+ * dissipation for the power consuming entity while connected to the
+ * charger.
+ *
+ * All charging MUST terminate if the overvoltage_limit_uv is ever reached.
+ * Overcharging Lithium Ion cells can be DANGEROUS and lead to fire or
+ * explosions.
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

