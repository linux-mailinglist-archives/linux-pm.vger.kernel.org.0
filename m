Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8A519ECBB
	for <lists+linux-pm@lfdr.de>; Sun,  5 Apr 2020 18:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgDEQvj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Apr 2020 12:51:39 -0400
Received: from mout.web.de ([212.227.17.12]:47043 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgDEQvj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 5 Apr 2020 12:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586105441;
        bh=0YkSt5BcPX9ZJY8/TNdXEE7Js5ClyUIYnLeTWxyJu/Y=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=H6dpbL4NJlpbw1+XZb+6L/eGOman52ihDO/AIarLK0MtETnB8q5WFWzHHImwj0WSk
         Ih26agawpGTRQFDoKCZ14NYfjK4xK31f+jaGdkWOuettOhLJYYi7gA2eRt1EfHaKqU
         pNeq29ypL2mvTSX/Jbtos5WFq/+ela1HeknA6nbA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.99.70]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPHKO-1jPYKf28rg-004Vck; Sun, 05
 Apr 2020 18:50:41 +0200
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-omap@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Allison Randal <allison@lohutok.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Clark Williams <williams@redhat.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Keerthy <j-keerthy@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Pascal Paillet <p.paillet@st.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] thermal: Delete an error message in four functions
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <05f49ae7-5cc7-d6a0-fc3d-abaf2a0b373c@web.de>
Date:   Sun, 5 Apr 2020 18:50:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9ZhlZktT91pfbtbXRm+mTr0dzyW0rFCf8ipUz74Hg6LrC70wyT3
 lgjget/+5B+v9e+XtCQhsiEWa3oYKGUxLwy/+16UFw9QBT7VDwPxyM6dCiB1jioWi3d4Dun
 ML0SUPIN7MIt4nv1gt3EZ8XCxPkEg46lkgVeLOb6MWzJTeAhBrn8nYSpEZW5GnakmEhF5Yp
 huyo983s7iSI3UbIrdpJw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:m0U7kNMqr14=:dv3CgYtVpGQVFYuC0r/Vx5
 YNeBV5WDA756pnx2kjt5nIWU8boJcoOjypBLmzLgJTpy9mXm4PEJRAG4QN6/pxXQyRnTbZSbI
 A0NSZmwTFCfOnYC5iYQSnZWrbaEpzfjZhgUf/SZ0mDMXS4ftkKTTuatf2RSzQCZFoejdz9Hw8
 cm6OaB28hgMvLG4tUDaMEMutfixS6P/ohSg7ugLasRdUx8kzm/Qrg3soCoPVwSTIXgo2iKwHi
 F8VRVy11ZkhsPDlAjl0ERPVu/YuAcvrs3kT9PbnJ7lyeHyuc9vOwXoEbAR0fgA429xEpM7pT3
 oTRQbKPsbkhQzwj0k7dsk9Wz16j4qoG9QbkEiMg/h9WuP16Nm4j852KFaCSCKia4GdEbwVbeE
 7N6ZUupaAuDHaFevdBcdsg8tJviighjDxUA96PREW8pypalaTO1nUACHvnnpDdHH1W6POTp+o
 r6Cjyqc9Twwm58iRfnlhU366rzje1enGS4siPXJszpwIlNry/qatNplAW+2evmNgtQBSIOT9B
 B4uqQ11pfJMX/1ROnA93I247aT/Kdktt9Vc2DJG3CK9yGV0kfvkeDCKjfdmR7cfpglWmysTKv
 xeIaEVjFjvXRdVtRRkEl4Riqh24X01nSyLTFfmklc6e6JeE0qAe9wzNHxZbFKG8UJk9wLDc0R
 dMO/hDizFjqHSLvI19DJhyuxEpP83mXnL78A92I26CE4vNimkhLgN+8tfJUyGpYA8TPxU08bH
 bHlenCrSNcdXdsKJxb/stLj7AX5SW17uIGmUY3ItFgPtX/2STeKclMhWil+oPbWNVQqtJPpwJ
 guIxLqK89gBeAOme1CdIksGr5p96h8EBBJh0KKLhfu7MhwRaodqgMW3hluCGas/J+aTEE3ktM
 G1acyNfb7eYn7tA6M56GOEVNqLaelktdgauk+cioS9P84pnjpI1YvktbcWUk9h8ke6izj+3RU
 SmAc4OCmJXgIy0fLtxrJQ2Nr/TTJnV2sTWTLV6XJwpxtpbKGwmP2I+65/T+OLVteWFzOqFTaP
 JnrI6EoSiuyIQvefCzps9lmScsgMoYBfJ/S206lHv+yGItg20lsqCBlN1h+neJANSlWNdlwug
 ALnBiWq29KkDZZkosMSV2GIdN/k45SSWZ96K7cj+JNsF0+WJHI1nVzHAKHdkL3TSPejo6s9Ig
 RdWFZvEaXDMhGoiYr9Xt7O0bDcrkWglBcPV/Em/29BmGbYm+uRs25qy3T7eW1nZQfz3lUYmMg
 EuHOTflLBO5PdtXHm
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 5 Apr 2020 18:35:16 +0200

The function =E2=80=9Cplatform_get_irq=E2=80=9D can log an error already.
Thus omit redundant messages for the exception handling in the
calling functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/thermal/rockchip_thermal.c          | 4 +---
 drivers/thermal/st/st_thermal_memmap.c      | 4 +---
 drivers/thermal/st/stm_thermal.c            | 4 +---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 5 ++---
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip=
_thermal.c
index 7c1a8bccdcba..15a71ecc916c 100644
=2D-- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1241,10 +1241,8 @@ static int rockchip_thermal_probe(struct platform_d=
evice *pdev)
 		return -ENXIO;

 	irq =3D platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
+	if (irq < 0)
 		return -EINVAL;
-	}

 	thermal =3D devm_kzalloc(&pdev->dev, sizeof(struct rockchip_thermal_data=
),
 			       GFP_KERNEL);
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/s=
t_thermal_memmap.c
index a824b78dabf8..a0114452d11f 100644
=2D-- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -94,10 +94,8 @@ static int st_mmap_register_enable_irq(struct st_therma=
l_sensor *sensor)
 	int ret;

 	sensor->irq =3D platform_get_irq(pdev, 0);
-	if (sensor->irq < 0) {
-		dev_err(dev, "failed to register IRQ\n");
+	if (sensor->irq < 0)
 		return sensor->irq;
-	}

 	ret =3D devm_request_threaded_irq(dev, sensor->irq,
 					NULL, st_mmap_thermal_trip_handler,
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_the=
rmal.c
index 9314e3df6a42..331e2b768df5 100644
=2D-- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -385,10 +385,8 @@ static int stm_register_irq(struct stm_thermal_sensor=
 *sensor)
 	int ret;

 	sensor->irq =3D platform_get_irq(pdev, 0);
-	if (sensor->irq < 0) {
-		dev_err(dev, "%s: Unable to find IRQ\n", __func__);
+	if (sensor->irq < 0)
 		return sensor->irq;
-	}

 	ret =3D devm_request_threaded_irq(dev, sensor->irq,
 					NULL,
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal=
/ti-soc-thermal/ti-bandgap.c
index 263b0420fbe4..ab19ceff6e2a 100644
=2D-- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -772,10 +772,9 @@ static int ti_bandgap_talert_init(struct ti_bandgap *=
bgp,
 	int ret;

 	bgp->irq =3D platform_get_irq(pdev, 0);
-	if (bgp->irq < 0) {
-		dev_err(&pdev->dev, "get_irq failed\n");
+	if (bgp->irq < 0)
 		return bgp->irq;
-	}
+
 	ret =3D request_threaded_irq(bgp->irq, NULL,
 				   ti_bandgap_talert_irq_handler,
 				   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
=2D-
2.26.0

