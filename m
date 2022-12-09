Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742F364854A
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLIP1S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiLIP0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ACB9075D
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:37 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QuBe/E1lrKKo3GxSsOL/6NngrA/Gt8YKoKmulATdTb8=;
        b=XFCdcBsrvR9gVe0kPro2GqqNqdRQPIIO+uI63qEOD4iFr3wNiVKhrYhFU8zYq4Wymz3tyG
        t97m998JaHrzEuj3YvDKOLIzgR0hPivoPfP8PbrooFpXm4nFIv41aVW3jLs1J/8Z7rRr5C
        XEuW+3B/S8PX0SL8BZ9j7RPLcxtx1fr5CUUMFE4oFXzUyXUa6iG0+ee0LcZ/wqCpy0r500
        OshsUoIB7E9vIhNZynw61yfPrntZPPePqpZpvSwmpqGIMwxev/LwincPy3YPO5J0OveMSd
        rssO0iz85MlJKLZSOAf+iGxg768cmcZ0bShDlGvuKnPvMj3jfeVK0+0Nw6zADg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QuBe/E1lrKKo3GxSsOL/6NngrA/Gt8YKoKmulATdTb8=;
        b=z705NnRU2XJw1/7YmRjPrANAC9rn/CrroBmM9f32fdD+pYknc6lN7JUipDCww73HkfsopZ
        DyEsBGZ9HVcKf8DA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rcar: Use generic
 thermal_zone_get_trip() function
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        niklas.soderlund+renesas@ragnatech.se, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20221003092602.1323944-23-daniel.lezcano@linaro.org>
References: <20221003092602.1323944-23-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <167059959318.4906.876054996043939185.tip-bot2@tip-bot2>
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

Commit-ID:     552ad4e4c2a5a59d55e64307e7fbdbe8e5e4e1b3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//552ad4e4c2a5a59d55e64307e7fbdbe8e5e4e1b3
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 03 Oct 2022 11:25:55 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Thu, 08 Dec 2022 14:30:43 +01:00

thermal/drivers/rcar: Use generic thermal_zone_get_trip() function

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20221003092602.1323944-23-daniel.lezcano@lina=
ro.org
---
 drivers/thermal/rcar_thermal.c | 53 +++------------------------------
 1 file changed, 6 insertions(+), 47 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 61c2b88..436f5f9 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -278,52 +278,12 @@ static int rcar_thermal_get_temp(struct thermal_zone_de=
vice *zone, int *temp)
 	return rcar_thermal_get_current_temp(priv, temp);
 }
=20
-static int rcar_thermal_get_trip_type(struct thermal_zone_device *zone,
-				      int trip, enum thermal_trip_type *type)
-{
-	struct rcar_thermal_priv *priv =3D rcar_zone_to_priv(zone);
-	struct device *dev =3D rcar_priv_to_dev(priv);
-
-	/* see rcar_thermal_get_temp() */
-	switch (trip) {
-	case 0: /* +90 <=3D temp */
-		*type =3D THERMAL_TRIP_CRITICAL;
-		break;
-	default:
-		dev_err(dev, "rcar driver trip error\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int rcar_thermal_get_trip_temp(struct thermal_zone_device *zone,
-				      int trip, int *temp)
-{
-	struct rcar_thermal_priv *priv =3D rcar_zone_to_priv(zone);
-	struct device *dev =3D rcar_priv_to_dev(priv);
-
-	/* see rcar_thermal_get_temp() */
-	switch (trip) {
-	case 0: /* +90 <=3D temp */
-		*temp =3D MCELSIUS(90);
-		break;
-	default:
-		dev_err(dev, "rcar driver trip error\n");
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static const struct thermal_zone_device_ops rcar_thermal_zone_of_ops =3D {
+static struct thermal_zone_device_ops rcar_thermal_zone_ops =3D {
 	.get_temp	=3D rcar_thermal_get_temp,
 };
=20
-static struct thermal_zone_device_ops rcar_thermal_zone_ops =3D {
-	.get_temp	=3D rcar_thermal_get_temp,
-	.get_trip_type	=3D rcar_thermal_get_trip_type,
-	.get_trip_temp	=3D rcar_thermal_get_trip_temp,
+static struct thermal_trip trips[] =3D {
+	{ .type =3D THERMAL_TRIP_CRITICAL, .temperature =3D 90000 }
 };
=20
 /*
@@ -529,11 +489,10 @@ static int rcar_thermal_probe(struct platform_device *p=
dev)
 		if (chip->use_of_thermal) {
 			priv->zone =3D devm_thermal_of_zone_register(
 						dev, i, priv,
-						&rcar_thermal_zone_of_ops);
+						&rcar_thermal_zone_ops);
 		} else {
-			priv->zone =3D thermal_zone_device_register(
-						"rcar_thermal",
-						1, 0, priv,
+			priv->zone =3D thermal_zone_device_register_with_trips(
+				"rcar_thermal", trips, ARRAY_SIZE(trips), 0, priv,
 						&rcar_thermal_zone_ops, NULL, 0,
 						idle);
=20
