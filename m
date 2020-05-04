Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216A11C4740
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 21:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgEDTrt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 15:47:49 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:27580 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgEDTrs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 May 2020 15:47:48 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49GD0d4Zw6zHm;
        Mon,  4 May 2020 21:47:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1588621665; bh=EbSm5+gnAl+lSmHRWVgxHCpfZGr2FXjwGmT2W8WyfjU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=ZWE2zh27y2h7FAcDCYKF15bYDiS7+dzmZa8zkxNUy+q6KS0z+Bp3cPky7Qn0cZ55z
         sevtnwo7Ma/EZw/zHLlQdFTxikyCKLJ73tmbxaa2+vag0xV7avoitCJsxPZm8G5yG9
         whZMtJ4LWLRSpGYbt2kG7TZdmU3NBbeC1OcsqCKcVEr9R+lqBl3BY/m5jqthZxDy4h
         L3Pl8vYZRNvMErVPVJPY8wC9krRGZq4UEjezMCupmGVsFbPVfj/UmIV3cS7ql1XX64
         83RbS5Bcv1li2xtv6Ol7dbe47aCy3wvFXDW9hz+lu7QNN7J7qEm9jjt6zljmOXAjxv
         tLICRYp9KbsiA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 04 May 2020 21:47:45 +0200
Message-Id: <e898499881c3a95daf11c117ac16de49bab9ea73.1588621247.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
References: <cover.1588621247.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 2/8] power: bq25890: fix ADC mode configuration
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Angus Ainslie <angus@akkea.ca>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
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
v3: drop dependency on new input/output properties
---
 drivers/power/supply/bq25890_charger.c | 31 +++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 70ecc38fe772..325fdd1b1d23 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -126,6 +126,7 @@ static const struct regmap_access_table bq25890_writeable_regs = {
 
 static const struct regmap_range bq25890_volatile_reg_ranges[] = {
 	regmap_reg_range(0x00, 0x00),
+	regmap_reg_range(0x02, 0x02),
 	regmap_reg_range(0x09, 0x09),
 	regmap_reg_range(0x0b, 0x14),
 };
@@ -374,18 +375,38 @@ enum bq25890_chrg_fault {
 	CHRG_FAULT_TIMER_EXPIRED,
 };
 
+static bool bq25890_is_adc_property(enum power_supply_property psp)
+{
+	switch (psp) {
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
@@ -623,8 +644,8 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 		}
 	}
 
-	/* Configure ADC for continuous conversions. This does not enable it. */
-	ret = bq25890_field_write(bq, F_CONV_RATE, 1);
+	/* Configure ADC for continuous conversions when charging */
+	ret = bq25890_field_write(bq, F_CONV_RATE, !!bq->state.online);
 	if (ret < 0) {
 		dev_dbg(bq->dev, "Config ADC failed %d\n", ret);
 		return ret;
@@ -966,7 +987,7 @@ static int bq25890_suspend(struct device *dev)
 	 * If charger is removed, while in suspend, make sure ADC is diabled
 	 * since it consumes slightly more power.
 	 */
-	return bq25890_field_write(bq, F_CONV_START, 0);
+	return bq25890_field_write(bq, F_CONV_RATE, 0);
 }
 
 static int bq25890_resume(struct device *dev)
@@ -982,7 +1003,7 @@ static int bq25890_resume(struct device *dev)
 
 	/* Re-enable ADC only if charger is plugged in. */
 	if (bq->state.online) {
-		ret = bq25890_field_write(bq, F_CONV_START, 1);
+		ret = bq25890_field_write(bq, F_CONV_RATE, 1);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.20.1

