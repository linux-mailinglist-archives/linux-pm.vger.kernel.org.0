Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB416648541
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiLIP1M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiLIP0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC220900F3
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:35 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFxNBpS+rcdZMBperhlr5fJyXqsHjuELgK1J+F2xU1w=;
        b=0/CXSrpW6OOKeEYtjcebfV0hAyeIJNXVL7HZUeGwwL4BbMAopl/XE5H6puqyFvLfb9dhYc
        qCrElPzo8tReBtHWnfDzS8Vdc58krl0H/4atnpdPDBy3c0pss6mIBYmzbGPu01IW8QwreJ
        DUkS6mAUqjmRqKJtqCrTITuXfWn/HKHqnIwrr9+G7HqLkZyXLvL9Fx/BIDykFIwpYLnxQK
        riMXMLv7XcTUEwnJChxz5lT9Pm9F4Zr5/l/9o5EFm2UUOsgbxcZcuPek1wbUP5MBWGtuHu
        ZiaOvFBY/D6dIACwFM91hBsF/gjbIa097+Mjr4cuGcMfcacGBOGoqfL6f/Iokg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFxNBpS+rcdZMBperhlr5fJyXqsHjuELgK1J+F2xU1w=;
        b=7wKTk58iBBMCQyKpvD5tAbS74+KrN75ypETKHIodv9KtMZ56pogKRgXGrLeEK8z9TDT2Wd
        wqU7cWndEwBgmEDQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/acerhdf: Use generic
 thermal_zone_get_trip() function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>, peter@piie.net,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20221003092602.1323944-27-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-27-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959252.4906.14417203206144066988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     38a61992756676f7789bea9b9dcb09a357191344
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//38a61992756676f7789bea9b9dcb09a357191344
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:59 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

thermal/drivers/acerhdf: Use generic thermal_zone_get_trip() function

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Peter K=C3=A4stle <peter@piie.net>
Link: https://lore.kernel.org/r/20221003092602.1323944-27-daniel.lezcano@lina=
ro.org
---
 drivers/platform/x86/acerhdf.c | 73 +++++++++++----------------------
 1 file changed, 26 insertions(+), 47 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index d2c0fc3..1956469 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -46,6 +46,8 @@
  * measured by the on-die thermal monitor are within 0 <=3D Tj <=3D 90. So,
  * assume 89=C2=B0C is critical temperature.
  */
+#define ACERHDF_DEFAULT_TEMP_FANON 60000
+#define ACERHDF_DEFAULT_TEMP_FANOFF 53000
 #define ACERHDF_TEMP_CRIT 89000
 #define ACERHDF_FAN_OFF 0
 #define ACERHDF_FAN_AUTO 1
@@ -70,8 +72,8 @@ static int kernelmode;
 #endif
=20
 static unsigned int interval =3D 10;
-static unsigned int fanon =3D 60000;
-static unsigned int fanoff =3D 53000;
+static unsigned int fanon =3D ACERHDF_DEFAULT_TEMP_FANON;
+static unsigned int fanoff =3D ACERHDF_DEFAULT_TEMP_FANOFF;
 static unsigned int verbose;
 static unsigned int list_supported;
 static unsigned int fanstate =3D ACERHDF_FAN_AUTO;
@@ -137,6 +139,15 @@ struct ctrl_settings {
 	int mcmd_enable;
 };
=20
+static struct thermal_trip trips[] =3D {
+	[0] =3D { .temperature =3D ACERHDF_DEFAULT_TEMP_FANON,
+		.hysteresis =3D ACERHDF_DEFAULT_TEMP_FANON - ACERHDF_DEFAULT_TEMP_FANOFF,
+		.type =3D THERMAL_TRIP_ACTIVE },
+
+	[1] =3D { .temperature =3D ACERHDF_TEMP_CRIT,
+		.type =3D THERMAL_TRIP_CRITICAL }
+};
+
 static struct ctrl_settings ctrl_cfg __read_mostly;
=20
 /* Register addresses and values for different BIOS versions */
@@ -326,6 +337,15 @@ static void acerhdf_check_param(struct thermal_zone_devi=
ce *thermal)
 		fanon =3D ACERHDF_MAX_FANON;
 	}
=20
+	if (fanon < fanoff) {
+		pr_err("fanoff temperature (%d) is above fanon temperature (%d), clamping =
to %d\n",
+		       fanoff, fanon, fanon);
+		fanoff =3D fanon;
+	};
+
+	trips[0].temperature =3D fanon;
+	trips[0].hysteresis  =3D fanon - fanoff;
+
 	if (kernelmode && prev_interval !=3D interval) {
 		if (interval > ACERHDF_MAX_INTERVAL) {
 			pr_err("interval too high, set to %d\n",
@@ -424,43 +444,6 @@ static int acerhdf_change_mode(struct thermal_zone_devic=
e *thermal,
 	return 0;
 }
=20
-static int acerhdf_get_trip_type(struct thermal_zone_device *thermal, int tr=
ip,
-				 enum thermal_trip_type *type)
-{
-	if (trip =3D=3D 0)
-		*type =3D THERMAL_TRIP_ACTIVE;
-	else if (trip =3D=3D 1)
-		*type =3D THERMAL_TRIP_CRITICAL;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
-static int acerhdf_get_trip_hyst(struct thermal_zone_device *thermal, int tr=
ip,
-				 int *temp)
-{
-	if (trip !=3D 0)
-		return -EINVAL;
-
-	*temp =3D fanon - fanoff;
-
-	return 0;
-}
-
-static int acerhdf_get_trip_temp(struct thermal_zone_device *thermal, int tr=
ip,
-				 int *temp)
-{
-	if (trip =3D=3D 0)
-		*temp =3D fanon;
-	else if (trip =3D=3D 1)
-		*temp =3D ACERHDF_TEMP_CRIT;
-	else
-		return -EINVAL;
-
-	return 0;
-}
-
 static int acerhdf_get_crit_temp(struct thermal_zone_device *thermal,
 				 int *temperature)
 {
@@ -474,13 +457,9 @@ static struct thermal_zone_device_ops acerhdf_dev_ops =
=3D {
 	.unbind =3D acerhdf_unbind,
 	.get_temp =3D acerhdf_get_ec_temp,
 	.change_mode =3D acerhdf_change_mode,
-	.get_trip_type =3D acerhdf_get_trip_type,
-	.get_trip_hyst =3D acerhdf_get_trip_hyst,
-	.get_trip_temp =3D acerhdf_get_trip_temp,
 	.get_crit_temp =3D acerhdf_get_crit_temp,
 };
=20
-
 /*
  * cooling device callback functions
  * get maximal fan cooling state
@@ -710,10 +689,10 @@ static int __init acerhdf_register_thermal(void)
 	if (IS_ERR(cl_dev))
 		return -EINVAL;
=20
-	thz_dev =3D thermal_zone_device_register("acerhdf", 2, 0, NULL,
-					      &acerhdf_dev_ops,
-					      &acerhdf_zone_params, 0,
-					      (kernelmode) ? interval*1000 : 0);
+	thz_dev =3D thermal_zone_device_register_with_trips("acerhdf", trips, ARRAY=
_SIZE(trips),
+							  0, NULL, &acerhdf_dev_ops,
+							  &acerhdf_zone_params, 0,
+							  (kernelmode) ? interval*1000 : 0);
 	if (IS_ERR(thz_dev))
 		return -EINVAL;
=20
