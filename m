Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECB2FFDDE
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2019 06:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfKRFZV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Nov 2019 00:25:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:57491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbfKRFZV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Nov 2019 00:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574054705;
        bh=NeILx/T8Pik6D58S7boVuKRO6cRhdtSWxt4CpQ4nwtI=;
        h=X-UI-Sender-Class:From:To:Subject:Reply-to:Date;
        b=ZaA+xVOoVptG3MF6ItV3dME5y1McB3ltyNA4iksR5E64OkpudyLhn0Dy5KmQ6Bzll
         f/AFtRygnpvjegM0RlHMgvQeu9RgxXOfs7+R+U+Amg1YCKm1caP2Fn7Y8EYbMmXGtn
         sQQ1ieV1yUhQHRvTnHQ3U0yTyS3aU/TB8sc783j4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.103]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MBlxW-1iidHZ1KG4-00CCje; Mon, 18 Nov 2019 06:25:05 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
        id D729B6E85603; Sun, 17 Nov 2019 21:24:13 -0800 (PST)
From:   schaecsn <schaecsn@gmx.net>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: rockchip: enable hwmon
Reply-to: schaecsn@gmx.net
Message-Id: <20191118052413.D729B6E85603@corona.crabdance.com>
Date:   Sun, 17 Nov 2019 21:24:13 -0800 (PST)
X-Provags-ID: V03:K1:rf6ZT//QgeDRxJTewZdp6iIroYeR77NdAr53keY7G26v9Tauz/b
 4ynhW4A/BDenlnipormdiNH3mwQWqduogyanwbLTn/nX8wj0Cfl0nq0/zwcCekhKaCodCvr
 d6JCiH+ExU8Ev+0HF1SDJfFuuLtlI0HAJ7+jSO/TQsbr5lm/PI0PWaiUEbAbSSef9F7BM2T
 64Dl7e8frlYvklivVS9IA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PNxcuapc1o4=:vsP2qi5hr37JrUDFqLq0dg
 mQrLo6kMZbPX45t0Bo3AMXcSIcRzlDDG3FpxPiukKNDZ076ErTQ6pryG/pQowOjZZzjsQbwcy
 KU4+ErxHpeenNTZIC/dDcO25xR0jygCdOPqmFGZCFcKmy70oPCH7nOJ+X1V0c8BH/W/SNwmNx
 B1LVlo6jYabIWbk3X7cfzcfKMkb3Je3lTyzRsISFziqs4AREnoAbqnvGB+y3affkdJpmnJD+Z
 pxSUAs1ZwGFjR1eVPboGa8CDwIuycVtIBwNRssa+ydEbEdNy3/sIsbZT4oQ0hLi+t1FCoDLoR
 mtDtvAfiqpVHYreMh+8yhM1tuglE1dJMX3/FjdJlXsiD0UZJFTXSlrzAJfeiHGi8feQ/GVJKp
 lzE4DIoMfDsa5IZnX49Rw4JuRDzxGZiFJuygfpiCJyBcCFywo4BKMZWCT8WlwA2ON4Bnx2j0o
 QIaAucvFJw2f+rXO4asnrbJKJScMsu4rzHTZdUBdUhBb5gEhKyeMkohZOJLb2uS4lAM6+m8js
 i0xTOo4yDnMiqonaYpsMg40WCwYOK2MmprlaStxwVwwY0cVs0z4syQyCCIrI91eM2Vc1uCb/9
 0P1/Utb9Lot6iIqqyHnDm9JRfatnMtNk0ZFiO9ky8heNr0afSXkRn7Fom6TYFjmyylgwAE3Uh
 w4SLaI7M06Uy5sqfZHhWQZwCr7iM42WHx2QI2CYcjJON6NJ7NJOoYNLTmEjRP18YyHemsIoSQ
 QFrncFWlFgtV9LwsTGSTSbfUo/KEdf13DlrhHZ+zcq3aNLjWCD7gHPj7U09dHT/xMBqjNJyF/
 18FfPWGjqbZIGFvfLXLIZHHxUkugaUprv4OTKwRTEcLnykP4WFibkEJCaU8muDaJlFkDyuFOi
 QQeuM4xpXdRtv3BiZwdLMsNHNh+QDCSk5Wdw0u8aKKSsSb5Odd2Vg3mXgNQcK0saoU1Fw2oUy
 MkBuu2uHkxV9ANp399vApd7iaUGZnONlrWn9R/eiDR989o9LG1+qKdGzz43glM4dl4LBn5RsW
 oSJzo5vEBjHNC8Ge46ccDKc6zrWBlFhNi8e6ONZKaNv4Ys6KVr22LqFUD0drWRW02JWbCqAj1
 a6zJKZrSchEoJD4WPs/EhcUO542u21RTgQMHDzOwaHsLxuPAtVCsKd31AA2w9xDQ73BhnziEe
 TQgLbsGFz7T5RNd2+RekltKn2WS7ngHX56rnzjMdlvjpGKX4TDTiejG+DJM7aDzRUywBRgi8a
 Y/D/nUpjfVoqMFeR0f8yE6SrkU2fBLXOSKer5IQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Enable hwmon for the soc and gpu temperature sensors.

Signed-off-by: Stefan Schaeckeler <schaecsn@gmx.net>

=2D--
 drivers/thermal/rockchip_thermal.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip=
_thermal.c
index 343c2f5c5a25..e47c60010259 100644
=2D-- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -19,6 +19,8 @@
 #include <linux/mfd/syscon.h>
 #include <linux/pinctrl/consumer.h>

+#include "thermal_hwmon.h"
+
 /**
  * If the temperature over a period of time High,
  * the resulting TSHUT gave CRU module,let it reset the entire chip,
@@ -1321,8 +1323,15 @@ static int rockchip_thermal_probe(struct platform_d=
evice *pdev)

 	thermal->chip->control(thermal->regs, true);

-	for (i =3D 0; i < thermal->chip->chn_num; i++)
+	for (i =3D 0; i < thermal->chip->chn_num; i++) {
 		rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
+		thermal->sensors[i].tzd->tzp->no_hwmon =3D false;
+		error =3D thermal_add_hwmon_sysfs(thermal->sensors[i].tzd);
+		if (error)
+			dev_warn(&pdev->dev,
+				 "failed to register sensor %d with hwmon: %d\n",
+				 i, error);
+	}

 	platform_set_drvdata(pdev, thermal);

@@ -1344,6 +1353,7 @@ static int rockchip_thermal_remove(struct platform_d=
evice *pdev)
 	for (i =3D 0; i < thermal->chip->chn_num; i++) {
 		struct rockchip_thermal_sensor *sensor =3D &thermal->sensors[i];

+		thermal_remove_hwmon_sysfs(sensor->tzd);
 		rockchip_thermal_toggle_sensor(sensor, false);
 	}

=2D-
2.24.0

