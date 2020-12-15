Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BE52DB392
	for <lists+linux-pm@lfdr.de>; Tue, 15 Dec 2020 19:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgLOSSt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Dec 2020 13:18:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34060 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbgLOSSd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2020 13:18:33 -0500
Date:   Tue, 15 Dec 2020 18:17:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608056269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQ+D9PtCi/TMVDtFTefX3DYz+x3qUYwRM+K1SFbRSVQ=;
        b=1gzza8yg1i51BBeOf9C/pxQe5ntHVXl4+XYCudV55Ps2DUOI0l0XHPhEvk802s7iagNdm3
        OqW04lNx5l6EIrpUp6c6UMjbeiI6l1cKPSQrxN7ha9CjfvvOxg694dP1zUYfYQQye/GyA9
        sO6SsOgCra9df2X7mHfqewI87BjH2TDRTEmrRZtDWEqf4aY9+PYto+BA+ZsODss6JQCmUF
        ZISVzj49dqbK+wyiGHRznTmq7vFf8sZhqmLkjzqXSq0You3tr7ssGWK/GYCZgTpt383Thk
        2CPobd0VxfbhdkIMzxMZV78bPWQTodzDwKYXkfnRCx3wsfpko0AjKY3AINwA8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608056269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQ+D9PtCi/TMVDtFTefX3DYz+x3qUYwRM+K1SFbRSVQ=;
        b=+9M8hUxSyaCnm+j6H17W2jf7/zQCjCEuoGrUFOKgtUefjqf+0wuf3eJqeW1brSKCcUz8E4
        ZXGW4XuQ8fQWL/AQ==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rcar: Remove notification usage
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        niklas.soderlund+renesas@ragnatech.se, rui.zhang@intel.com,
        amitk@kernel.org
In-Reply-To: <20201210121514.25760-4-daniel.lezcano@linaro.org>
References: <20201210121514.25760-4-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <160805626913.3364.9619486188372337301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     1fa34e49e4b7e66214a1d15261c0224d60366eec
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//1fa34e49e4b7e66214a1d15261c0224d60366eec
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Thu, 10 Dec 2020 13:15:13 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 15 Dec 2020 17:01:55 +01:00

thermal/drivers/rcar: Remove notification usage

The ops is only showing a trace telling a critical trip point is
crossed. The same information is given by the thermal framework.

This is redundant, remove the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20201210121514.25760-4-daniel.lezcano@linaro.=
org
---
 drivers/thermal/rcar_thermal.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 6ae757d..b49f04d 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -323,24 +323,6 @@ static int rcar_thermal_get_trip_temp(struct thermal_zon=
e_device *zone,
 	return 0;
 }
=20
-static int rcar_thermal_notify(struct thermal_zone_device *zone,
-			       int trip, enum thermal_trip_type type)
-{
-	struct rcar_thermal_priv *priv =3D rcar_zone_to_priv(zone);
-	struct device *dev =3D rcar_priv_to_dev(priv);
-
-	switch (type) {
-	case THERMAL_TRIP_CRITICAL:
-		/* FIXME */
-		dev_warn(dev, "Thermal reached to critical temperature\n");
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
 static const struct thermal_zone_of_device_ops rcar_thermal_zone_of_ops =3D {
 	.get_temp	=3D rcar_thermal_of_get_temp,
 };
@@ -349,7 +331,6 @@ static struct thermal_zone_device_ops rcar_thermal_zone_o=
ps =3D {
 	.get_temp	=3D rcar_thermal_get_temp,
 	.get_trip_type	=3D rcar_thermal_get_trip_type,
 	.get_trip_temp	=3D rcar_thermal_get_trip_temp,
-	.notify		=3D rcar_thermal_notify,
 };
=20
 /*
