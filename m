Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B8C3AE668
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jun 2021 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhFUJtV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Jun 2021 05:49:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43326 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhFUJtE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jun 2021 05:49:04 -0400
Date:   Mon, 21 Jun 2021 09:46:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624268806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xcdqkN+zo6UeiTvw9SxJKHaIY956GpIe3W36qL5IIlM=;
        b=ewSis+5VnUHIFOckOfDma6pUCLAnckI5cICAJTIWSQazODZpM6xoMagfkk2NpZRAnDCHkH
        arjGotYdH+bp9Ctiob6J6jfjeYH0pNC+xUbqW4HdzlobIuc12WakkDe9XMfEbjKyD1vyDL
        YQpM6JwrS7+t4mVWQPv7X1xrW03gPDbHq7+85Od36VAz8aTpY3odb/B7Mij83PvkFGfs+E
        Phi45OF1FrLMvq6rkQWyJDfCgEZd+U9jO7GevOPpePku8CZblXh7ydEQV20j41ojLXI/Js
        OGBern29m8Gds19ov0SDrGTZk2AkNDMg4bvj0pMj8brS1hk4CeVDfR/4rd0ARg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624268806;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xcdqkN+zo6UeiTvw9SxJKHaIY956GpIe3W36qL5IIlM=;
        b=z4Y3yPVZWeqWHo/mRQBe4G+sNnSNx/C8Rp+vuNhFfymrZHgKXx7icNbw4JAJoV/SCDzvjK
        vdLMRTulFajJYQCg==
From:   "thermal-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/rcar_gen3_thermal: Do not
 shadow rcar_gen3_ths_tj_1
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        niklas.soderlund+renesas@ragnatech.se,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: =?utf-8?q?=3C9ea7e65d0331daba96f9a7925cb3d12d2170efb1=2E16230?=
 =?utf-8?q?76804=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C9ea7e65d0331daba96f9a7925cb3d12d2170efb1=2E162307?=
 =?utf-8?q?6804=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
MIME-Version: 1.0
Message-ID: <162426880610.395.2356144191953656208.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     3ae5950db617d1cc3eb4eb55750fa9d138529b49
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//3ae5950db617d1cc3eb4eb55750fa9d138529b49
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Mon, 07 Jun 2021 16:41:20 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 14 Jun 2021 19:05:01 +02:00

thermal/drivers/rcar_gen3_thermal: Do not shadow rcar_gen3_ths_tj_1

With -Wshadow:

    drivers/thermal/rcar_gen3_thermal.c: In function =E2=80=98rcar_gen3_therm=
al_probe=E2=80=99:
    drivers/thermal/rcar_gen3_thermal.c:310:13: warning: declaration of =E2=
=80=98rcar_gen3_ths_tj_1=E2=80=99 shadows a global declaration [-Wshadow]
      310 |  const int *rcar_gen3_ths_tj_1 =3D of_device_get_match_data(dev);
	  |             ^~~~~~~~~~~~~~~~~~
    drivers/thermal/rcar_gen3_thermal.c:246:18: note: shadowed declaration is=
 here
      246 | static const int rcar_gen3_ths_tj_1 =3D 126;
	  |                  ^~~~~~~~~~~~~~~~~~

To add to the confusion, the local variable has a different type.

Fix the shadowing by renaming the local variable to ths_tj_1.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/9ea7e65d0331daba96f9a7925cb3d12d2170efb1.1623=
076804.git.geert+renesas@glider.be
---
 drivers/thermal/rcar_gen3_thermal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_=
thermal.c
index 1a60adb..fdf16aa 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -307,7 +307,7 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 {
 	struct rcar_gen3_thermal_priv *priv;
 	struct device *dev =3D &pdev->dev;
-	const int *rcar_gen3_ths_tj_1 =3D of_device_get_match_data(dev);
+	const int *ths_tj_1 =3D of_device_get_match_data(dev);
 	struct resource *res;
 	struct thermal_zone_device *zone;
 	int ret, i;
@@ -352,8 +352,7 @@ static int rcar_gen3_thermal_probe(struct platform_device=
 *pdev)
 		priv->tscs[i] =3D tsc;
=20
 		priv->thermal_init(tsc);
-		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcodes[i],
-					     *rcar_gen3_ths_tj_1);
+		rcar_gen3_thermal_calc_coefs(tsc, ptat, thcodes[i], *ths_tj_1);
=20
 		zone =3D devm_thermal_zone_of_sensor_register(dev, i, tsc,
 							    &rcar_gen3_tz_of_ops);
