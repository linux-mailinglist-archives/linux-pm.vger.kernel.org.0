Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8AB119C517
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 16:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388764AbgDBO5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 10:57:25 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:39629 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388823AbgDBO5F (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:57:05 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR3z3DK4zwy;
        Thu,  2 Apr 2020 16:57:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839423; bh=7bziPBmLgN03w+As65y0di/xcEI1r2q/jImfIySQxjY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=evQzZzAPENuWhwsb5RJM9WMUYr5N7yFedykWzkdn0f4KnOPWDO3PtZ2Z/xcjpKQfG
         d1sq9a/M29+/d11ArpffiBp3qUbzz9S0Vnt2V54P+A7KPqml4LUlCF78FGdTPO9kxQ
         KeJKye1AzXETRDl3Em54jXjFmVefJ6wsxsJ4BlFtSR2JjFpc/NX0N4b0B26A5UpnXJ
         zjgyFYNFxdbqojbhDC9lnY9yDBqv4STq3zMOsbGUPSJxqgJOpxISo4IIgRuBLB2wPx
         3jRePJz/gzLuh3O77rCakHQXfHAR4wTjWWlbbq8YsbydwwIBOJTgqVuMoVviGBmwvR
         supR66xMmB6XQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:57:03 +0200
Message-Id: <9dc504550be598dd333ebf41d28484b886ffd7c0.1585837575.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 4/7] power: supply: core: hide unused HWMON labels
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently HWMON emulation shows all labels (temp and ambient temp)
regardless if power supply supports reading the values. Check that at
least one property is enabled for each label.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/power_supply_hwmon.c | 43 +++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
index 83318a21fb52..118d73a2ab4a 100644
--- a/drivers/power/supply/power_supply_hwmon.c
+++ b/drivers/power/supply/power_supply_hwmon.c
@@ -103,6 +103,40 @@ static bool power_supply_hwmon_is_a_label(enum hwmon_sensor_types type,
 	return type == hwmon_temp && attr == hwmon_temp_label;
 }
 
+static bool power_supply_hwmon_has_property(
+	const struct power_supply_hwmon *psyhw,
+	enum hwmon_sensor_types type, u32 attr, int channel)
+{
+	int prop = power_supply_hwmon_to_property(type, attr, channel);
+
+	return prop >= 0 && test_bit(prop, psyhw->props);
+}
+
+static bool power_supply_hwmon_has_input(
+	const struct power_supply_hwmon *psyhw,
+	enum hwmon_sensor_types type, int channel)
+{
+	static const enum hwmon_temp_attributes temp_attrs[] = {
+		hwmon_temp_input,
+		hwmon_temp_min, hwmon_temp_max,
+		hwmon_temp_min_alarm, hwmon_temp_max_alarm,
+	};
+	size_t i;
+
+	switch (type) {
+	case hwmon_temp:
+		for (i = 0; i < ARRAY_SIZE(temp_attrs); ++i)
+			if (power_supply_hwmon_has_property(psyhw, type,
+					temp_attrs[i], channel))
+				return true;
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
+
 static bool power_supply_hwmon_is_writable(enum hwmon_sensor_types type,
 					   u32 attr)
 {
@@ -129,9 +163,12 @@ static umode_t power_supply_hwmon_is_visible(const void *data,
 	const struct power_supply_hwmon *psyhw = data;
 	int prop;
 
-
-	if (power_supply_hwmon_is_a_label(type, attr))
-		return 0444;
+	if (power_supply_hwmon_is_a_label(type, attr)) {
+		if (power_supply_hwmon_has_input(psyhw, type, channel))
+			return 0444;
+		else
+			return 0;
+	}
 
 	prop = power_supply_hwmon_to_property(type, attr, channel);
 	if (prop < 0 || !test_bit(prop, psyhw->props))
-- 
2.20.1

