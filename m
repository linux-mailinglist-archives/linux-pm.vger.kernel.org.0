Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFCE2DFEF6
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 18:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLURYi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 12:24:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:32906 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgLURYi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 12:24:38 -0500
Received: from 36-229-229-222.dynamic-ip.hinet.net ([36.229.229.222] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1krOuU-0003TV-7K; Mon, 21 Dec 2020 17:23:51 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     andrzej.p@collabora.com, mjg59@google.com,
        srinivas.pandruvada@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] thermal: int340x: Fix unexpected shutdown at critical temperature
Date:   Tue, 22 Dec 2020 01:23:43 +0800
Message-Id: <20201221172345.36976-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We are seeing thermal shutdown on Intel based mobile workstations, the
shutdown happens during the first trip handle in
thermal_zone_device_register():
kernel: thermal thermal_zone15: critical temperature reached (101 C), shutting down

However, we shouldn't do a thermal shutdown here, since
1) We may want to use a dedicated daemon, Intel's thermald in this case,
to handle thermal shutdown.

2) For ACPI based system, _CRT doesn't mean shutdown unless it's inside
ThermalZone namespace. ACPI Spec, 11.4.4 _CRT (Critical Temperature):
"... If this object it present under a device, the device’s driver
evaluates this object to determine the device’s critical cooling
temperature trip point. This value may then be used by the device’s
driver to program an internal device temperature sensor trip point."

So a "critical trip" here merely means we should take a more aggressive
cooling method.

As int340x device isn't present under ACPI ThermalZone, override the
default .critical callback to prevent surprising thermal shutdown.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Amend subject.
 - Remove int3400 device.

 .../thermal/intel/int340x_thermal/int340x_thermal_zone.c    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index 6e479deff76b..d1248ba943a4 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -146,12 +146,18 @@ static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
 	return 0;
 }
 
+static void int340x_thermal_critical(struct thermal_zone_device *zone)
+{
+	dev_dbg(&zone->device, "%s: critical temperature reached\n", zone->type);
+}
+
 static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
 	.get_temp       = int340x_thermal_get_zone_temp,
 	.get_trip_temp	= int340x_thermal_get_trip_temp,
 	.get_trip_type	= int340x_thermal_get_trip_type,
 	.set_trip_temp	= int340x_thermal_set_trip_temp,
 	.get_trip_hyst =  int340x_thermal_get_trip_hyst,
+	.critical	= int340x_thermal_critical,
 };
 
 static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
-- 
2.29.2

