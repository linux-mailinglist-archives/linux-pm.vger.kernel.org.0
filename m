Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F49948C034
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jan 2022 09:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351737AbiALIro (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jan 2022 03:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbiALIro (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jan 2022 03:47:44 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0835C06173F
        for <linux-pm@vger.kernel.org>; Wed, 12 Jan 2022 00:47:43 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id x6so5619560lfa.5
        for <linux-pm@vger.kernel.org>; Wed, 12 Jan 2022 00:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGTJ0YMWlqsV3o/hYwnScYAWcVImYPc9SsDEYcGH0Ug=;
        b=ADBQq7N3EXaLvFKxY/X34A3KQ45an1rLGJ7URyi5cOejvdXZJ9MapCueFQMk+hw5rR
         YUhUu2HI8v3JXzmMuSLwE3pVfNYj4hTxlCrYOkVOg9ljYoRuaGxAdvu2TmhK4AjEFP9w
         3yIqfy1GiwCr1WZtdtGnciAyITCDGjRJMaw3dQHZaXVUth8y2CLzqOpeVPLAWfARUu+Q
         +ppDjEGxBEnm4QeOgxGKbqMIk876Sn3No4MyGZKN2FwUZDMOto6UBTLNtTtLvdFu1hKO
         WgcrXwK41gxL7sI00HRXcgjXUmPju5LZVjd+wC40cSr1oyDthtbn1OdQBw3zExgVZnAC
         xmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gGTJ0YMWlqsV3o/hYwnScYAWcVImYPc9SsDEYcGH0Ug=;
        b=LbjlE2uNnDptAP0oe41IGBJAF7bHN5rxWVejeIFWnrSgByz12QAdvLZdScT4g288Q8
         vCrTgS1KJlVTu5QCD/cEeY3FXgWwiJm7zFAjvtAwbnpFF+v6QCBAzufaI74c5cZMHVqj
         3HoGo+W2vF9nm76t+ueHH1w38gL1Is7JuamZKEFRmK0DJu+NxYp5uhgUH9Ia30vKNzTD
         DivclCpx382WvJDwbQutZ3fM/JopBD6XQ71mddC4xofM9k8CQhOzv7zW5z/MXh6eCrj8
         ZKpMslZi8EcJGsCvLMH4EvEbwaXETzA4pGCEmbX9HRScaFH/dxrzQ4okm1dxC32R9x7G
         V/5w==
X-Gm-Message-State: AOAM531YD2XFwP2Wv4DxJz8RsE2vpK/4MC3IoJARPyGzhgfLLG/8iCSI
        B822W1UTc3hs9KcCypO5wVofSg==
X-Google-Smtp-Source: ABdhPJzqoGgt17edI0+HwJNjn5IVWxVZvqTMXCeuiVyMJ6dXr2R/e6qf9BB+6rBoD2/Bl3YXs0Vc0A==
X-Received: by 2002:a2e:90f:: with SMTP id 15mr125948ljj.263.1641977262068;
        Wed, 12 Jan 2022 00:47:42 -0800 (PST)
Received: from boger-laptop.lan (81.5.110.253.dhcp.mipt-telecom.ru. [81.5.110.253])
        by smtp.gmail.com with ESMTPSA id bq10sm1573741lfb.199.2022.01.12.00.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 00:47:41 -0800 (PST)
From:   Evgeny Boger <boger@wirenboard.com>
To:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        Quentin Schulz <foss@0leil.net>
Cc:     Evgeny Boger <boger@wirenboard.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Subject: [PATCH v2] power: supply: axp20x_battery: properly report current when discharging
Date:   Wed, 12 Jan 2022 11:47:27 +0300
Message-Id: <20220112084727.131053-1-boger@wirenboard.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As stated in [1], negative current values are used for discharging
batteries.

AXP PMICs internally have two different ADC channels for shunt current
measurement: one used during charging and one during discharging.
The values reported by these ADCs are unsigned.
While the driver properly selects ADC channel to get the data from,
it doesn't apply negative sign when reporting discharging current.

[1] Documentation/ABI/testing/sysfs-class-power

Signed-off-by: Evgeny Boger <boger@wirenboard.com>
---
Changes from v1:
 * fix formatting, no other changes

 drivers/power/supply/axp20x_battery.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 5d197141f476..9106077c0dbb 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -186,7 +186,6 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 				   union power_supply_propval *val)
 {
 	struct axp20x_batt_ps *axp20x_batt = power_supply_get_drvdata(psy);
-	struct iio_channel *chan;
 	int ret = 0, reg, val1;
 
 	switch (psp) {
@@ -266,12 +265,12 @@ static int axp20x_battery_get_prop(struct power_supply *psy,
 		if (ret)
 			return ret;
 
-		if (reg & AXP20X_PWR_STATUS_BAT_CHARGING)
-			chan = axp20x_batt->batt_chrg_i;
-		else
-			chan = axp20x_batt->batt_dischrg_i;
-
-		ret = iio_read_channel_processed(chan, &val->intval);
+		if (reg & AXP20X_PWR_STATUS_BAT_CHARGING) {
+			ret = iio_read_channel_processed(axp20x_batt->batt_chrg_i, &val->intval);
+		} else {
+			ret = iio_read_channel_processed(axp20x_batt->batt_dischrg_i, &val1);
+			val->intval = -val1;
+		}
 		if (ret)
 			return ret;
 
-- 
2.25.1
