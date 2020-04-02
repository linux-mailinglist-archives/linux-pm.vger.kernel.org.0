Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6BA19C53B
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbgDBO7E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:59:04 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:58435 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389039AbgDBO6e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:58:34 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR5g68HZz1qr;
        Thu,  2 Apr 2020 16:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839511; bh=YIDfMUMGzJXrR0o8/w9xvesAyrjX19dF5+drN1MGEM8=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=CwqCA3gOMW4H5jNO4XJq9mvy+p1zklcf96jTPFBeHrSL2a1WNX2PHManYfsea/Hpi
         19uFmkYfihkIiRdpg7MFWSandOAufCg7HhjxUUrXE6k+FnnToenwQk/NycXnNOtGbd
         NLsczVYpti+lIGMDRmANxEO/DPn8nAmxPkTF2yXPfXNmlC6cKqLT4AZlrjz9atw1Xx
         GiG8O4PXi0XNg9vYP7CZMDxQHOWckcgEO1BbM3NUbiULV5OHU5yebPUZJslH9Z/8kH
         pClKAqW1Kl2tKYlX1aqIkNR2VTQPrZeXy0RjZD4KIP1cGUqIDkxvuSQaceSs56Q2kL
         6cLyTJeYWKkLg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:58:31 +0200
Message-Id: <a1275df1b8de5112d81e4f0b57f34af34a4a0942.1585838678.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585838678.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 05/14] power: supply: bq25890: fix ADC mode configuration
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Datasheet describes two modes for reading ADC measurements:
1. continuous, 1 Hz - enabled and started by CONV_RATE bit
2. one-shot - triggered by CONV_START bit

In continuous mode, CONV_START is read-only and signifies an ongoing
conversion.

Change the code to follow the datasheet and really disable continuous
mode for power saving.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/bq25890_charger.c | 33 ++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 9339e216651f..3b02fa80aedd 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -126,6 +126,7 @@ static const struct regmap_access_table bq25890_writeable_regs = {
 
 static const struct regmap_range bq25890_volatile_reg_ranges[] = {
 	regmap_reg_range(0x00, 0x00),
+	regmap_reg_range(0x02, 0x02),
 	regmap_reg_range(0x09, 0x09),
 	regmap_reg_range(0x0b, 0x14),
 };
@@ -374,18 +375,40 @@ enum bq25890_chrg_fault {
 	CHRG_FAULT_TIMER_EXPIRED,
 };
 
+static bool bq25890_is_adc_property(enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_OUTPUT_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return true;
+
+	default:
+		return false;
+	}
+}
+
 static int bq25890_power_supply_get_property(struct power_supply *psy,
 					     enum power_supply_property psp,
 					     union power_supply_propval *val)
 {
-	int ret;
 	struct bq25890_device *bq = power_supply_get_drvdata(psy);
 	struct bq25890_state state;
+	bool do_adc_conv;
+	int ret;
 
 	mutex_lock(&bq->lock);
 	state = bq->state;
+	do_adc_conv = !state.online && bq25890_is_adc_property(psp);
+	if (do_adc_conv)
+		bq25890_field_write(bq, F_CONV_START, 1);
 	mutex_unlock(&bq->lock);
 
+	if (do_adc_conv)
+		regmap_field_read_poll_timeout(bq->rmap_fields[F_CONV_START],
+			ret, !ret, 25000, 1000000);
+
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		if (!state.online)
@@ -623,8 +646,8 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 		}
 	}
 
-	/* Configure ADC for continuous conversions. This does not enable it. */
-	ret = bq25890_field_write(bq, F_CONV_RATE, 1);
+	/* Configure ADC for continuous conversions when charging */
+	ret = bq25890_field_write(bq, F_CONV_RATE, !!bq->state.online);
 	if (ret < 0) {
 		dev_dbg(bq->dev, "Config ADC failed %d\n", ret);
 		return ret;
@@ -966,7 +989,7 @@ static int bq25890_suspend(struct device *dev)
 	 * If charger is removed, while in suspend, make sure ADC is diabled
 	 * since it consumes slightly more power.
 	 */
-	return bq25890_field_write(bq, F_CONV_START, 0);
+	return bq25890_field_write(bq, F_CONV_RATE, 0);
 }
 
 static int bq25890_resume(struct device *dev)
@@ -982,7 +1005,7 @@ static int bq25890_resume(struct device *dev)
 
 	/* Re-enable ADC only if charger is plugged in. */
 	if (bq->state.online) {
-		ret = bq25890_field_write(bq, F_CONV_START, 1);
+		ret = bq25890_field_write(bq, F_CONV_RATE, 1);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.20.1

