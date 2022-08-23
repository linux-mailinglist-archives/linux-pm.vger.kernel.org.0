Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF8959E6FD
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 18:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbiHWQWi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 12:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239989AbiHWQWR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 12:22:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A975216D2FE
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2022 05:43:05 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:43:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661258583;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cttd387qSUjSGsdiPZnUrVGkZmvBx76p5qfPyiDa0iI=;
        b=DT41Dv0FpRX9raZVU/lIIH0KBYvnOAUWkCcl5WgLXQgzi54xeEMTKQusToUaAMLzhXIJnL
        kWIjedkW2AbdCgCddrYpmC7WFOxpUt24+63HiOwifopFw4bWEQ3saZFvjMzIO2ckoHBx8Q
        /q/WISEQlf6db2eCDyYAihLT3L429AWce2Y8SKSQGcJAvr/ZVlDjwl3KQY00DvIZFTOXiB
        QsmY8qcMwpsQrezDojiKUYRoODIuQwtzMtqdhTaZFOhxpULGTO07zYDy82QeosH+2iVLQu
        RTekIpBIp2ANRxutAe3675Dm3q5IIard2ResVWSC4YqP3W0DsYuALoVRczizBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661258583;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cttd387qSUjSGsdiPZnUrVGkZmvBx76p5qfPyiDa0iI=;
        b=L4FKc/19JMqlfP9rku/8qRBGy4D/omMqqon+EI0gx0Ev2M0vY/MEySHeKyMCOICNgwXoz9
        W0yauJ8MkuGxhWCA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rcar: Switch to new of API
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        niklas.soderlund+renesas@ragnatech.se,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220804224349.1926752-18-daniel.lezcano@linexp.org>
References: <20220804224349.1926752-18-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Message-ID: <166125858255.401.12112479491655913093.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     2ebd4f2f2ecfde86ce490f02b28b3282d93aa405
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//2ebd4f2f2ecfde86ce490f02b28b3282d93aa405
Author:        Daniel Lezcano <daniel.lezcano@linexp.org>
AuthorDate:    Fri, 05 Aug 2022 00:43:33 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 17 Aug 2022 14:09:38 +02:00

thermal/drivers/rcar: Switch to new of API

The thermal OF code has a new API allowing to migrate the OF
initialization to a simpler approach. The ops are no longer device
tree specific and are the generic ones provided by the core code.

Convert the ops to the thermal_zone_device_ops format and use the new
API to register the thermal zone with these generic ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
Tested-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20220804224349.1926752-18-daniel.lezcano@line=
xp.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/rcar_gen3_thermal.c | 16 ++++++++--------
 drivers/thermal/rcar_thermal.c      | 13 +++----------
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index cda7c52..4c1c6f8 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -164,9 +164,9 @@ static int rcar_gen3_thermal_round(int temp)
 	return result * RCAR3_THERMAL_GRAN;
 }
=20
-static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
+static int rcar_gen3_thermal_get_temp(struct thermal_zone_device *tz, int *t=
emp)
 {
-	struct rcar_gen3_thermal_tsc *tsc =3D devdata;
+	struct rcar_gen3_thermal_tsc *tsc =3D tz->devdata;
 	int mcelsius, val;
 	int reg;
=20
@@ -203,9 +203,9 @@ static int rcar_gen3_thermal_mcelsius_to_temp(struct rcar=
_gen3_thermal_tsc *tsc,
 	return INT_FIXPT(val);
 }
=20
-static int rcar_gen3_thermal_set_trips(void *devdata, int low, int high)
+static int rcar_gen3_thermal_set_trips(struct thermal_zone_device *tz, int l=
ow, int high)
 {
-	struct rcar_gen3_thermal_tsc *tsc =3D devdata;
+	struct rcar_gen3_thermal_tsc *tsc =3D tz->devdata;
 	u32 irqmsk =3D 0;
=20
 	if (low !=3D -INT_MAX) {
@@ -225,7 +225,7 @@ static int rcar_gen3_thermal_set_trips(void *devdata, int=
 low, int high)
 	return 0;
 }
=20
-static struct thermal_zone_of_device_ops rcar_gen3_tz_of_ops =3D {
+static struct thermal_zone_device_ops rcar_gen3_tz_of_ops =3D {
 	.get_temp	=3D rcar_gen3_thermal_get_temp,
 	.set_trips	=3D rcar_gen3_thermal_set_trips,
 };
@@ -508,8 +508,8 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 	for (i =3D 0; i < priv->num_tscs; i++) {
 		struct rcar_gen3_thermal_tsc *tsc =3D priv->tscs[i];
=20
-		zone =3D devm_thermal_zone_of_sensor_register(dev, i, tsc,
-							    &rcar_gen3_tz_of_ops);
+		zone =3D devm_thermal_of_zone_register(dev, i, tsc,
+						     &rcar_gen3_tz_of_ops);
 		if (IS_ERR(zone)) {
 			dev_err(dev, "Sensor %u: Can't register thermal zone\n", i);
 			ret =3D PTR_ERR(zone);
@@ -560,7 +560,7 @@ static int __maybe_unused rcar_gen3_thermal_resume(struct=
 device *dev)
=20
 		priv->thermal_init(tsc);
 		if (zone->ops->set_trips)
-			rcar_gen3_thermal_set_trips(tsc, zone->prev_low_trip,
+			rcar_gen3_thermal_set_trips(zone, zone->prev_low_trip,
 						    zone->prev_high_trip);
 	}
=20
diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 1d729ed..4df42d7 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -271,13 +271,6 @@ static int rcar_thermal_get_current_temp(struct rcar_the=
rmal_priv *priv,
 	return 0;
 }
=20
-static int rcar_thermal_of_get_temp(void *data, int *temp)
-{
-	struct rcar_thermal_priv *priv =3D data;
-
-	return rcar_thermal_get_current_temp(priv, temp);
-}
-
 static int rcar_thermal_get_temp(struct thermal_zone_device *zone, int *temp)
 {
 	struct rcar_thermal_priv *priv =3D rcar_zone_to_priv(zone);
@@ -323,8 +316,8 @@ static int rcar_thermal_get_trip_temp(struct thermal_zone=
_device *zone,
 	return 0;
 }
=20
-static const struct thermal_zone_of_device_ops rcar_thermal_zone_of_ops =3D {
-	.get_temp	=3D rcar_thermal_of_get_temp,
+static struct thermal_zone_device_ops rcar_thermal_zone_of_ops =3D {
+	.get_temp	=3D rcar_thermal_get_temp,
 };
=20
 static struct thermal_zone_device_ops rcar_thermal_zone_ops =3D {
@@ -534,7 +527,7 @@ static int rcar_thermal_probe(struct platform_device *pde=
v)
 			goto error_unregister;
=20
 		if (chip->use_of_thermal) {
-			priv->zone =3D devm_thermal_zone_of_sensor_register(
+			priv->zone =3D devm_thermal_of_zone_register(
 						dev, i, priv,
 						&rcar_thermal_zone_of_ops);
 		} else {
