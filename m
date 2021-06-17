Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2973AACD7
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFQHBC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 03:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQHBC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 03:01:02 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D42FC061574;
        Wed, 16 Jun 2021 23:58:55 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e33so4178609pgm.3;
        Wed, 16 Jun 2021 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qqPSmP1VauP+iAm5x1G74wuovcizK1vH1Sz+B4/XUO4=;
        b=sL7r7oDnTtvXel4wV1v370+rIM6U+LSM8qQpztldDomfJAxfScd3GENmbwD/eNARUw
         1enIq9P2zxy2Eus4nHtOiKyXuyXYRSboLm090ejoEpERQROKOaTVYKkPSfD9e9/Gj36b
         YrdojY50emfBBwzJOE6LKjMpe3U4UFv1PjJCqQLdmp4/n5KMX603mZceFlVlZS2K7NK1
         8BYlWbFgJ21vX1dooQAOcoVBLxXeCw/Hl5/ayMrh2vAGSE+5Lj2iHIUVwsflnmfRhTra
         d0OZLn31scxnnCqj/DSTn7AanYrqzzgTFGBEIPmmzRrojP+xBVbgmKN/6eMdLiKAd+AP
         qULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qqPSmP1VauP+iAm5x1G74wuovcizK1vH1Sz+B4/XUO4=;
        b=c2xLiIC/yEoItRkrMYFI1HesdNFKsKBDDCza6f5F5YcZpNAbrvesB/jJTaGiDDQlPv
         qJFhN0enD5Ssf+o2kfxf+ZNhygo6b5/f+3JKZQAnmV6+ROLvN2j2IU96R1oFJPvwr5/k
         o4BXUPzRrqjLHlHzyJVO0440ylSlFuhFticjlmtNhOSid64J7fdAqHa7V/OLAndlvJyd
         pdm1E2aPJay9yqhtXHHeoS0moPga9k06OUrLfFv28yvotDGZkKk9zjWM+EonZ/tr1afE
         MytxevOvak2WTYb08k7JGzPL1Xza2kNvgcHRP274/JjZFWUo48ScSu70D64vqAoFS1Jj
         mXsg==
X-Gm-Message-State: AOAM530PBEOc1VTWJoOgkuvbabyMFAvPxZMaBoa35wF/LYyFJLz8SvCm
        VSoABpn4JxpqCO2+Uc9xgk4=
X-Google-Smtp-Source: ABdhPJxM1M9m9Pc86vQDPtUfe0YK6qy5EN6R3KoRs3+aEJy9k65buqEwgM3wmif2tUa4gHq4b8J9ZA==
X-Received: by 2002:aa7:8681:0:b029:2ee:10c9:17c0 with SMTP id d1-20020aa786810000b02902ee10c917c0mr3698978pfo.56.1623913134508;
        Wed, 16 Jun 2021 23:58:54 -0700 (PDT)
Received: from localhost ([223.184.24.109])
        by smtp.gmail.com with ESMTPSA id gg8sm1584195pjb.15.2021.06.16.23.58.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jun 2021 23:58:54 -0700 (PDT)
Date:   Thu, 17 Jun 2021 12:28:47 +0530
From:   Shubhankar Kuranagatti <shubhankarvk@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanjanasrinidhi1810@gmail.com
Subject: [PATCH] drivers: power: supply: ab8500_fg.c: Remove space before tabs
Message-ID: <20210617065847.tnam7phjhdyhd64l@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Removed extra space before tabs
Removed extra space before ','
Added blank line after declaration
Aligned subsequent lines of multi-line comment using *
Removed repetition of the word 'is' inside comment block

Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
---
 drivers/power/supply/ab8500_fg.c | 147 ++++++++++++++++---------------
 1 file changed, 76 insertions(+), 71 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 06ff42c71f24..86c8cc30f6fd 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -183,7 +183,7 @@ struct inst_curr_result_list {
  * @avg_cap:		Average capacity filter
  * @parent:		Pointer to the struct ab8500
  * @main_bat_v:		ADC channel for the main battery voltage
- * @bm:           	Platform specific battery management information
+ * @bm:			Platform specific battery management information
  * @fg_psy:		Structure that holds the FG specific battery properties
  * @fg_wq:		Work queue for running the FG algorithm
  * @fg_periodic_work:	Work to run the FG algorithm periodically
@@ -269,70 +269,70 @@ static enum power_supply_property ab8500_fg_props[] = {
  * Values taken from the UM0836
  */
 static int ab8500_fg_lowbat_voltage_map[] = {
-	2300 ,
-	2325 ,
-	2350 ,
-	2375 ,
-	2400 ,
-	2425 ,
-	2450 ,
-	2475 ,
-	2500 ,
-	2525 ,
-	2550 ,
-	2575 ,
-	2600 ,
-	2625 ,
-	2650 ,
-	2675 ,
-	2700 ,
-	2725 ,
-	2750 ,
-	2775 ,
-	2800 ,
-	2825 ,
-	2850 ,
-	2875 ,
-	2900 ,
-	2925 ,
-	2950 ,
-	2975 ,
-	3000 ,
-	3025 ,
-	3050 ,
-	3075 ,
-	3100 ,
-	3125 ,
-	3150 ,
-	3175 ,
-	3200 ,
-	3225 ,
-	3250 ,
-	3275 ,
-	3300 ,
-	3325 ,
-	3350 ,
-	3375 ,
-	3400 ,
-	3425 ,
-	3450 ,
-	3475 ,
-	3500 ,
-	3525 ,
-	3550 ,
-	3575 ,
-	3600 ,
-	3625 ,
-	3650 ,
-	3675 ,
-	3700 ,
-	3725 ,
-	3750 ,
-	3775 ,
-	3800 ,
-	3825 ,
-	3850 ,
-	3850 ,
+	2300,
+	2325,
+	2350,
+	2375,
+	2400,
+	2425,
+	2450,
+	2475,
+	2500,
+	2525,
+	2550,
+	2575,
+	2600,
+	2625,
+	2650,
+	2675,
+	2700,
+	2725,
+	2750,
+	2775,
+	2800,
+	2825,
+	2850,
+	2875,
+	2900,
+	2925,
+	2950,
+	2975,
+	3000,
+	3025,
+	3050,
+	3075,
+	3100,
+	3125,
+	3150,
+	3175,
+	3200,
+	3225,
+	3250,
+	3275,
+	3300,
+	3325,
+	3350,
+	3375,
+	3400,
+	3425,
+	3450,
+	3475,
+	3500,
+	3525,
+	3550,
+	3575,
+	3600,
+	3625,
+	3650,
+	3675,
+	3700,
+	3725,
+	3750,
+	3775,
+	3800,
+	3825,
+	3850,
+	3850,
 };
 
 static u8 ab8500_volt_to_regval(int voltage)
@@ -409,7 +409,7 @@ static int ab8500_fg_add_cap_sample(struct ab8500_fg *di, int sample)
  * ab8500_fg_clear_cap_samples() - Clear average filter
  * @di:		pointer to the ab8500_fg structure
  *
- * The capacity filter is is reset to zero.
+ * The capacity filter is reset to zero.
  */
 static void ab8500_fg_clear_cap_samples(struct ab8500_fg *di)
 {
@@ -464,10 +464,12 @@ static void ab8500_fg_fill_cap_sample(struct ab8500_fg *di, int sample)
 static int ab8500_fg_coulomb_counter(struct ab8500_fg *di, bool enable)
 {
 	int ret = 0;
+
 	mutex_lock(&di->cc_lock);
 	if (enable) {
 		/* To be able to reprogram the number of samples, we have to
-		 * first stop the CC and then enable it again */
+		 * first stop the CC and then enable it again
+		 */
 		ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
 			AB8500_RTC_CC_CONF_REG, 0x00);
 		if (ret)
@@ -1875,10 +1877,10 @@ static void ab8500_fg_low_bat_work(struct work_struct *work)
 			dev_warn(di->dev, "Shut down pending...\n");
 		} else {
 			/*
-			* Else we need to re-schedule this check to be able to detect
-			* if the voltage increases again during charging or
-			* due to decreasing load.
-			*/
+			 * Else we need to re-schedule this check to be able to detect
+			 * if the voltage increases again during charging or
+			 * due to decreasing load.
+			 */
 			di->low_bat_cnt--;
 			dev_warn(di->dev, "Battery voltage still LOW\n");
 			queue_delayed_work(di->fg_wq, &di->fg_low_bat_work,
@@ -1979,6 +1981,7 @@ static void ab8500_fg_instant_work(struct work_struct *work)
 static irqreturn_t ab8500_fg_cc_data_end_handler(int irq, void *_di)
 {
 	struct ab8500_fg *di = _di;
+
 	if (!di->nbr_cceoc_irq_cnt) {
 		di->nbr_cceoc_irq_cnt++;
 		complete(&di->ab8500_fg_started);
@@ -1999,6 +2002,7 @@ static irqreturn_t ab8500_fg_cc_data_end_handler(int irq, void *_di)
 static irqreturn_t ab8500_fg_cc_int_calib_handler(int irq, void *_di)
 {
 	struct ab8500_fg *di = _di;
+
 	di->calib_state = AB8500_FG_CALIB_END;
 	queue_delayed_work(di->fg_wq, &di->fg_periodic_work, 0);
 	return IRQ_HANDLED;
@@ -2181,6 +2185,7 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 	/* Go through all properties for the psy */
 	for (j = 0; j < ext->desc->num_properties; j++) {
 		enum power_supply_property prop;
+
 		prop = ext->desc->properties[j];
 
 		if (power_supply_get_property(ext, prop, &ret))
-- 
2.17.1

