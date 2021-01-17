Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260282F95B0
	for <lists+linux-pm@lfdr.de>; Sun, 17 Jan 2021 22:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbhAQV7b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 16:59:31 -0500
Received: from sender11-of-o51.zoho.eu ([31.186.226.237]:21128 "EHLO
        sender11-of-o51.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730185AbhAQV7X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 16:59:23 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1610919720; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=T6ZiSJEnKAgD1fHvgi9+5OBGTROu7NvHycmmlw7UvMeOPw4EVzFyCrfdA5HZTtFdFH+b0d2Y1UE2T+EI7FoVYCNiomhvy1yXYv92Vn6LHP7Fi/eXH3KaJf3wIVHA7MFUBtSOcfyqLzEiqnUBRPnWQi9WdkaV3RvfFQRucinDCXY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1610919720; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=oya5WPtN116hQHLGQkYpVddhzhK3tPiR8VPGqrDlLac=; 
        b=U+4FG+fY8t05ED6tIRPav8b0t+sTJTkCT0lWwK2wLf0DZp7sM/V2HjWDcZGpBu8go/oSevB3Wsn+O3havb0CRUHz0SrTuISs3PS3mxQvTMyhLLUISNreAwY6wpPZ/Dm7b5uwSwQXiaCOSEGunjFA6nsDZkIuzNaYQKtspwySVuI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=philipp@uvos.xyz;
        dmarc=pass header.from=<philipp@uvos.xyz> header.from=<philipp@uvos.xyz>
Received: from localhost.localdomain (ip-95-222-215-9.hsi15.unitymediagroup.de [95.222.215.9]) by mx.zoho.eu
        with SMTPS id 1610919718953679.2994000138575; Sun, 17 Jan 2021 22:41:58 +0100 (CET)
Date:   Sun, 17 Jan 2021 22:41:58 +0100
From:   Carl Philipp Klemm <philipp@uvos.xyz>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/5] power: supply: cpcap-charger: get the battery inserted
 infomation from cpcap-battery
Message-Id: <20210117224158.f0ac792da5f480a660ff3c89@uvos.xyz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This avoids reimplementing the detection logic twice and removes the
possibility of activating charging with 500mA even if a battery is not
detected.

Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
---
 drivers/power/supply/cpcap-charger.c | 41 ++++++++++++++--------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 823d666f09e0..152090faf5b2 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -26,8 +26,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/usb/phy_companion.h>
 #include <linux/phy/omap_usb.h>
-#include <linux/usb/otg.h>
 #include <linux/iio/consumer.h>
+#include <linux/usb/otg.h>
 #include <linux/mfd/motorola-cpcap.h>
 
 /*
@@ -173,23 +173,6 @@ static enum power_supply_property cpcap_charger_props[] = {
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 };
 
-/* No battery always shows temperature of -40000 */
-static bool cpcap_charger_battery_found(struct cpcap_charger_ddata *ddata)
-{
-	struct iio_channel *channel;
-	int error, temperature;
-
-	channel = ddata->channels[CPCAP_CHARGER_IIO_BATTDET];
-	error = iio_read_channel_processed(channel, &temperature);
-	if (error < 0) {
-		dev_warn(ddata->dev, "%s failed: %i\n", __func__, error);
-
-		return false;
-	}
-
-	return temperature > -20000 && temperature < 60000;
-}
-
 static int cpcap_charger_get_charge_voltage(struct cpcap_charger_ddata *ddata)
 {
 	struct iio_channel *channel;
@@ -696,11 +679,29 @@ static void cpcap_usb_detect(struct work_struct *work)
 
 	if (!ddata->feeding_vbus && cpcap_charger_vbus_valid(ddata) &&
 	    s.chrgcurr1) {
-		int max_current = 532000;
+		int max_current;
 		int vchrg, ichrg;
+		union power_supply_propval val;
+		struct power_supply *battery;
 
-		if (cpcap_charger_battery_found(ddata))
+		battery = power_supply_get_by_phandle(ddata->dev->of_node, "battery");
+		if (IS_ERR_OR_NULL(battery)) {
+			dev_err(ddata->dev, "battery described by phandle not available %li\n",
+					PTR_ERR(battery));
+			return;
+		}
+
+		error = power_supply_get_property(battery, POWER_SUPPLY_PROP_PRESENT, &val);
+		power_supply_put(battery);
+		if (error)
+			goto out_err;
+
+		if (val.intval) {
 			max_current = 1596000;
+		} else {
+			dev_info(ddata->dev, "battery not inserted charging disabled\n");
+			max_current = 0;
+		}
 
 		if (max_current > ddata->limit_current)
 			max_current = ddata->limit_current;
-- 
2.29.2


