Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB7A11C5E2
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 07:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfLLGR5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 01:17:57 -0500
Received: from mout.gmx.net ([212.227.15.15]:54087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbfLLGR5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Dec 2019 01:17:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576131461;
        bh=KL73YRrT7LLHVsznmPTHt/klCRSoc1CVMKSMBDmBo6I=;
        h=X-UI-Sender-Class:From:To:Subject:Reply-to:Date;
        b=Tpc3ARXxO+7BOveLypF/SVr8mN0m+AgXaOl5a/zuwIZlfLxkuOvwxPmPNtZTI8OmQ
         nDRZjvPdrzU/X4npI+hF0EyGJwd5ehZq1GlZxO5AxGFBzuVzlmxWmnPGmnlGHdYwb1
         HYnuKO8tdTiqRXa1KWzBzRHzBv9dUZucJV/kZpbQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.20]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MKbgE-1iQujo3OOq-00KwkB; Thu, 12 Dec 2019 07:17:41 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
        id BFE2D6E85603; Wed, 11 Dec 2019 22:17:02 -0800 (PST)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] thermal: rockchip: enable hwmon
Content-Type: text/plain
Reply-to: schaecsn@gmx.net
Message-Id: <20191212061702.BFE2D6E85603@corona.crabdance.com>
Date:   Wed, 11 Dec 2019 22:17:02 -0800 (PST)
X-Provags-ID: V03:K1:kW48YWv2at+CtoZ29KlwFzvfojnYn+Z2kTPJCrfxCVA5Rh90eXV
 aM0gPv8hwKLUJ2iDVrZbWVOWIqDS4KVTl38TNMvJV32rVUullnP6dlrbKMYeIcndtHucyom
 MSUCZDZU+Xu4+kEiA13utXDD/2NBQynNtjXJeU09nBD+OkbsLck4KpO2RGz+HrIqDiZSCgj
 fKIBwKd4KkB87Z94yizRg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:8lU53RZXNGc=:sHRJzAdIaFHRXzs8mtVvzs
 f6InwGCn/l5BZMSCxMyTXAhaoZ7dS9F6qxUBsgCvr3SSROiqGwCvMl5Qe9plRrS0XFICiO4lr
 dyCIIF/Qk0ByJPzjOC/m+CA203m/i2Qu0Qve5T9s/k/MCXqsov2QFvZ6na17H1rYprH91OSe8
 g68xOoJIFDDEJDGSI4v8DA3hg0MbacLSrkpP4GUeJEOpXWFUT9NAIyHSa+iIIH+SCUQn/doqy
 BZzt4R6NvLndpk3bNnjgYWOgVqUakjsPdsacPEQOQk10BpQhiqYwi+lMIITxLyty2F/v0Y/Ww
 rnnobEPvXAZsbYJV3e9j5dpWQCCOeAqIGeKbgavxyNXA8DP+gIodRZc05eoovlGpaHXuAza82
 fyhnX9zAg3YvOPcYglyMFHBlGytIgwyKBIPld5+cqtUJ0HH5vQF1JQKwHSQSEX0zBIEQO/rdB
 4dKC3BWAkssdJrJXpRsAR0Dil7A3WBWpxtsBdRy4t04OuhlBKAnmdh6cjHwR5pWTDPIt7zWYU
 v1CQwY1XY15Cu+upIUnbPmxEx+DCYxYwr5xn++HpuCvY5w/bukbqw/S0k66g1icYQm/seM0Fa
 3ziE1uH00dSP1q7pQ/3MQ5NvPyMEFGQSQMBt4ZtHb6ByFABsEAK+pRD8a7YtkI7P+IxDkK9d5
 IFpBK4OryV0yYSWKuqxS3y6aoTYOKN8Qi36v3Ji9dGZiwOf5e9fxwvnHbBADNqd6LclyTRrVJ
 svdqUX0ikEm9/aCN/mGbnzEunSwrd2m0EX0z6taP58gWYUqJ5WWSl3RSDW28B5FUB+A4pbR5i
 U7d9h33aiVTOG/ffx3xnq8skbj9jCt2VVwk7i1OXlFXD0Dt0532yR//0rifOqE5bp3h89p5BC
 WeB2dzdi/yFIfVfUaSMhB8h9M48KK9D/IKtiUKaIxBA6tTVKzSwHk7NucxKfoI70T0p5QUfho
 obCWmGjdX/KP25fo3T3fFJXPQqyn6ERXmeToAhWnq1s+GgT77LuWVWRuXuSWbJCTWTB6bdI97
 HI7hCrFDAhnhgJJ9bjjD7/qMnBpk5/GjlNuzPZBOQpIgZCx85l7Fm58MU+aViFSzB4fcP9glY
 uftxD3KXeknjou9mPmBr3Xbg3xsY+mb0fN1zgs5z1VzvJhIVAja8gZernjZ/rNZk9jsg4bD5B
 vG+uAdgqho/YkxhO6smQ4268B3zsB2vUx5EXqIBVHhrpZ+0fs9WmbFoWTI3nF9EbwivaZZq7A
 tRfztC7BrfN3WKncCMrtszSwpEAy4cdLGOJFu0nXcrIKT+YanoRLnHNl8dNk=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

By default, of-based thermal drivers do not enable hwmon.
Explicitly enable hwmon for both, the soc and gpu temperature
sensor.

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

