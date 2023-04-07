Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0306DB071
	for <lists+linux-pm@lfdr.de>; Fri,  7 Apr 2023 18:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjDGQSj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Apr 2023 12:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjDGQSf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2023 12:18:35 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352F1BB88
        for <linux-pm@vger.kernel.org>; Fri,  7 Apr 2023 09:18:34 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-177b78067ffso46130127fac.7
        for <linux-pm@vger.kernel.org>; Fri, 07 Apr 2023 09:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680884313; x=1683476313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OslxPRuT1jN8xzsMOjAhHVX9+QsHV7uV5JNRh8zxvzc=;
        b=PR7qC8Ce9mF0MEHMohvoUr4s9IL9TLvzTjRDYFpteEbUHVY85z0JIzfvF3slAprzOf
         sVKhUbiq11n3QmTbdcO3KWgaC9d3rdy+L0Y0/t1KNIR82S+ODhHsPrB0HCh7jvSUmRwK
         LwpP3rvPO5xZXns7JGpAPfGd5xYRaQBbhsFvzPV9sd4kIIFhfaQkv9b2lbjwXTqG/J8d
         ZLVFRW+3/2A+kRqpUfJdjerpNUVphZWY+vz2SkaO07iTrQMVTuiGuSD3T/KtqaTS/rmW
         OBLezDKe8cT8NFnDfyuizzh8JRW8dveZ9mav4cHU5eHUe/vvBF5uPBZTzNERBMQSxYAD
         CHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680884313; x=1683476313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OslxPRuT1jN8xzsMOjAhHVX9+QsHV7uV5JNRh8zxvzc=;
        b=2KlTwyO9s9jxoou9Jyve0TOKSno9mgYvWSrhlehCbqukRHg9qodxYjER1V9P8AZc7S
         +/++UvraFUmkc2Uf8FLFngnSE73DwgFnURq4lc6kX9kbOouzHmkUhfuInckDiG1E9xT2
         ffsN0Eks1zDfatR1m/9aIfRIm9cZ7gp/5+m541+heazbR3GVRPHXicWoSVOIjlzbSio/
         BwIO6CqH2dFhBtJUF+AbNkRG8e6lIfoSZlkGgzWabrLf1IAJ1or3OFgtmVjp5p1BmV7H
         ibNu38G0uvYC9h1jtkbqzRvbN03xdNzOzCmpkMJRP7zqWVtpcAdRLHBLfCjCAymBXtqA
         gBNQ==
X-Gm-Message-State: AAQBX9fbZ/UUxt6kCwZ1Y2wICMk44MldoUGGN5L1Q7Ql/rZ6afviOu9v
        n0EaDRkzYIPREs6eDL+qR8CxhuLKZNM=
X-Google-Smtp-Source: AKy350ZipsZKBhCb/MVITFuz0rJz/T6p+gaiZI2MnPIVs3eeSNtQGMIFIkKNFwvvLHLTsjZKYC9p9w==
X-Received: by 2002:a05:6870:b28f:b0:183:cc50:f771 with SMTP id c15-20020a056870b28f00b00183cc50f771mr1866493oao.25.1680884313358;
        Fri, 07 Apr 2023 09:18:33 -0700 (PDT)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id zj18-20020a0568716c9200b00183f77dcdadsm1369212oab.33.2023.04.07.09.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:18:33 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     maccraft123mc@gmail.com, lee@kernel.org,
        jiapeng.chong@linux.alibaba.com, sre@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 2/2] power: supply: Fix low SOC bugs in rk817 driver
Date:   Fri,  7 Apr 2023 11:18:27 -0500
Message-Id: <20230407161827.127473-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407161827.127473-1-macroalpha82@gmail.com>
References: <20230407161827.127473-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

When the SOC approaches zero, an integer overflows in the columb
counter causing the driver to react poorly. This makes the driver
think it's at (above) the fully charged capacity when in fact it's
zero. It would then write this full capacity to NVRAM which would be
used on boot if the device remained off for less than 5 hours and
not plugged in.

This can be fixed and guarded against by doing the following:
 - Changing the type of tmp in rk817_read_or_set_full_charge_on_boot()
   to be an int instead of a u32. That way we can account for negative
   numbers.
 - Guard against negative values for the full charge on boot by setting
   the charge to 0 if the system charge reports less than 0.
 - Catch scenarios where the battery voltage is below the design
   minimum voltage and set the system SOC to 0 at that time and update
   the columb counter with a charge level of 0.
 - Change the off time value from 5 hours to 30 minutes before we
   recalculate the current capacity based on the OCV tables.

These changes allow the driver to operate better at low voltage/low
capacity conditions.

Fixes: 3268a4d9b0b8 ("power: supply: rk817: Fix unsigned comparison with less than zero")
Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/rk817_charger.c | 35 ++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index eba9a17d991b..8c977d5987f3 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -335,6 +335,22 @@ static int rk817_bat_calib_cap(struct rk817_charger *charger)
 			charger->fcc_mah * 1000);
 	}
 
+	/*
+	 * Set the SOC to 0 if we are below the minimum system voltage.
+	 */
+	if (volt_avg <= charger->bat_voltage_min_design_uv) {
+		charger->soc = 0;
+		charge_now_adc = CHARGE_TO_ADC(0,
+					       charger->res_div);
+		put_unaligned_be32(charge_now_adc, bulk_reg);
+		regmap_bulk_write(rk808->regmap,
+				  RK817_GAS_GAUGE_Q_INIT_H3,
+				  bulk_reg, 4);
+		dev_warn(charger->dev,
+			 "Battery voltage %d below minimum voltage %d\n",
+			 volt_avg, charger->bat_voltage_min_design_uv);
+		}
+
 	rk817_record_battery_nvram_values(charger);
 
 	return 0;
@@ -710,9 +726,10 @@ static int rk817_read_battery_nvram_values(struct rk817_charger *charger)
 
 	/*
 	 * Read the nvram for state of charge. Sanity check for values greater
-	 * than 100 (10000). If the value is off it should get corrected
-	 * automatically when the voltage drops to the min (soc is 0) or when
-	 * the battery is full (soc is 100).
+	 * than 100 (10000) or less than 0, because other things (BSP kernels,
+	 * U-Boot, or even i2cset) can write to this register. If the value is
+	 * off it should get corrected automatically when the voltage drops to
+	 * the min (soc is 0) or when the battery is full (soc is 100).
 	 */
 	ret = regmap_bulk_read(charger->rk808->regmap,
 			       RK817_GAS_GAUGE_BAT_R1, bulk_reg, 3);
@@ -721,6 +738,8 @@ static int rk817_read_battery_nvram_values(struct rk817_charger *charger)
 	charger->soc = get_unaligned_le24(bulk_reg);
 	if (charger->soc > 10000)
 		charger->soc = 10000;
+	if (charger->soc < 0)
+		charger->soc = 0;
 
 	return 0;
 }
@@ -731,8 +750,8 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 {
 	struct rk808 *rk808 = charger->rk808;
 	u8 bulk_reg[4];
-	u32 boot_voltage, boot_charge_mah, tmp;
-	int ret, reg, off_time;
+	u32 boot_voltage, boot_charge_mah;
+	int ret, reg, off_time, tmp;
 	bool first_boot;
 
 	/*
@@ -785,10 +804,12 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
 				 bulk_reg, 4);
 		tmp = get_unaligned_be32(bulk_reg);
+		if (tmp < 0)
+			tmp = 0;
 		boot_charge_mah = ADC_TO_CHARGE_UAH(tmp,
 						    charger->res_div) / 1000;
 		/*
-		 * Check if the columb counter has been off for more than 300
+		 * Check if the columb counter has been off for more than 30
 		 * minutes as it tends to drift downward. If so, re-init soc
 		 * with the boot voltage instead. Note the unit values for the
 		 * OFF_CNT register appear to be in decaminutes and stops
@@ -799,7 +820,7 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
 		 * than 0 on a reboot anyway.
 		 */
 		regmap_read(rk808->regmap, RK817_GAS_GAUGE_OFF_CNT, &off_time);
-		if (off_time >= 30) {
+		if (off_time >= 3) {
 			regmap_bulk_read(rk808->regmap,
 					 RK817_GAS_GAUGE_PWRON_VOL_H,
 					 bulk_reg, 2);
-- 
2.34.1

