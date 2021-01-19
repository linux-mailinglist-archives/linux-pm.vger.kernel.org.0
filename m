Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004E02FC268
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbhASVeg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:34:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbhASV2L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 16:28:11 -0500
Date:   Tue, 19 Jan 2021 21:27:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611091648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwHULTeYR9W4/tnb7Ba43vDJre/OdT1Q2IcjFYcK3VY=;
        b=hFj1z9fosM9SrWI/H0zMzNmjk+lLgl9FoWkFvPOsC/knlHwATzWSCeu5+5citvJ6DHlcDG
        9e93GQmhuplGVdps2K0sxwJlVVM7wIboFY+OQK1jlE891GpVdS52s0f1DMqe2ehUv1h0uT
        j4qzcQKRfGRxWp14rbGpYvLrcJ60r58TAr+59eeVMFXUHfuKngvxebyKKofXuB4Klzhp2L
        QInTPYfb+UPse3CN04tDYudIgFg6qEPhKYIjBYncFa3ARpQX4e01oeNC+Rz1p5BpNFUhmQ
        5Jv5A3qskinU+jQh7L3zrk4viJ/D0BvoTiGWS1ueukKhqzBhyMWb41+G8yiVPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611091648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwHULTeYR9W4/tnb7Ba43vDJre/OdT1Q2IcjFYcK3VY=;
        b=HiYa7fvg1hMAmHfpTN6Pbo7ARkpVORtLPZ9SGoE8ZEZ+WGTr58yT07EqVCuhUAmUPa5KS6
        umPcCF20bs/yfCAw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/acpi: Use hot and critical ops
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201210121514.25760-3-daniel.lezcano@linaro.org>
References: <20201210121514.25760-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161109164757.414.15779969442983899331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     a73cb2024caa3480263a009dce91fa581b3748bf
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a73cb2024caa3480263a009dce91fa581b3748bf
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Thu, 10 Dec 2020 13:15:12 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 07 Jan 2021 17:48:55 +01:00

thermal/drivers/acpi: Use hot and critical ops

The acpi driver wants to do a netlink notification in case of a hot or
critical trip point. Implement the corresponding ops to be used for
the thermal zone and use them instead of the notify ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20201210121514.25760-3-daniel.lezcano@linaro.org
---
 drivers/acpi/thermal.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 12c0ece..b5e4bc9 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -677,27 +677,24 @@ static int thermal_get_trend(struct thermal_zone_device *thermal,
 	return 0;
 }
 
-
-static int thermal_notify(struct thermal_zone_device *thermal, int trip,
-			   enum thermal_trip_type trip_type)
+static void acpi_thermal_zone_device_hot(struct thermal_zone_device *thermal)
 {
-	u8 type = 0;
 	struct acpi_thermal *tz = thermal->devdata;
 
-	if (trip_type == THERMAL_TRIP_CRITICAL)
-		type = ACPI_THERMAL_NOTIFY_CRITICAL;
-	else if (trip_type == THERMAL_TRIP_HOT)
-		type = ACPI_THERMAL_NOTIFY_HOT;
-	else
-		return 0;
-
 	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
-					dev_name(&tz->device->dev), type, 1);
+					dev_name(&tz->device->dev),
+					ACPI_THERMAL_NOTIFY_HOT, 1);
+}
 
-	if (trip_type == THERMAL_TRIP_CRITICAL && nocrt)
-		return 1;
+static void acpi_thermal_zone_device_critical(struct thermal_zone_device *thermal)
+{
+	struct acpi_thermal *tz = thermal->devdata;
 
-	return 0;
+	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
+					dev_name(&tz->device->dev),
+					ACPI_THERMAL_NOTIFY_CRITICAL, 1);
+
+	thermal_zone_device_critical(thermal);
 }
 
 static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
@@ -812,7 +809,8 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
 	.get_trip_temp = thermal_get_trip_temp,
 	.get_crit_temp = thermal_get_crit_temp,
 	.get_trend = thermal_get_trend,
-	.notify = thermal_notify,
+	.hot = acpi_thermal_zone_device_hot,
+	.critical = acpi_thermal_zone_device_critical,
 };
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
