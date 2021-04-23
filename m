Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A182736929A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Apr 2021 15:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhDWNBx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Apr 2021 09:01:53 -0400
Received: from sender11-of-o51.zoho.eu ([31.186.226.237]:21195 "EHLO
        sender11-of-o51.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242540AbhDWNBw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Apr 2021 09:01:52 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 09:01:51 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1619182859; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Xhtbc+XTfak7Fd+bd2fi+E7APArH6SvomV9WJfCt0z27NrdnUrYwtKT7KBPr/DyL6piGJFUDJgp4h3rOz55yeIiTdEiT2U9hSB+sE4D9tQ1pftS4tbIMl4YRAe5uQP3qoYEJzI3hpdnMjbkDesnL9+PuMGSkwMTdrm3vD7uwHPo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1619182859; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=/Www13c1RRjJyZQ2ij29U6Ef95VskP+Y2GPW+4P6PrI=; 
        b=Ya1p4d+CCeTcPNNT6qDlI80/bFDXrAu4+JbdrUDu2wo4K1gqTWAmNJsjrMntUQDqBjh5TnZVwxBiTF9cwJolW60QjI5fPGgzMfx5VLH3T2YmV0L6rAZ+4rvbEd9WLaJBMgRRyZwu8AHAFTrcPovCqPRyTGV3GN4ey4EIwqM+zOY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=philipp@uvos.xyz;
        dmarc=pass header.from=<philipp@uvos.xyz> header.from=<philipp@uvos.xyz>
Received: from UVOSLinux (ip-95-222-215-151.hsi15.unitymediagroup.de [95.222.215.151]) by mx.zoho.eu
        with SMTPS id 1619182858059347.3495751384486; Fri, 23 Apr 2021 15:00:58 +0200 (CEST)
Date:   Fri, 23 Apr 2021 15:00:57 +0200
From:   Carl Philipp Klemm <philipp@uvos.xyz>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v2] power: supply: cpcap-charger: get the battery inserted
 infomation from cpcap-battery
Message-Id: <20210423150057.97e0a2b43f20fdc3513f4fea@uvos.xyz>
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
 drivers/power/supply/cpcap-charger.c | 39 ++++++++++++++--------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index 641dcad1133f..a5983365b81a 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
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
@@ -697,11 +680,29 @@ static void cpcap_usb_detect(struct work_struct *work)
 
 	if (!ddata->feeding_vbus && cpcap_charger_vbus_valid(ddata) &&
 	    s.chrgcurr1) {
-		int max_current = 532000;
+		int max_current;
 		int vchrg, ichrg;
+		union power_supply_propval val;
+		struct power_supply *battery;
 
-		if (cpcap_charger_battery_found(ddata))
+		battery = power_supply_get_by_name("battery");
+		if (IS_ERR_OR_NULL(battery)) {
+			dev_err(ddata->dev, "battery power_supply not available %li\n",
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
2.31.0


