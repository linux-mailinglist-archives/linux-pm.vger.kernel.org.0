Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EED26B6CE0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2019 21:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbfIRTnl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Sep 2019 15:43:41 -0400
Received: from mout.web.de ([212.227.15.14]:47617 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731705AbfIRTnk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Sep 2019 15:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568835802;
        bh=E0svCMJ1DK/Q5hYX654ALNgjGijno+n7obX1zo/Eot0=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=TXtlgF2sIiEP9EdcwA9dItnursi/fygmE5W35g7UFJBpbSK5zV7gcMtpoaKX4jGZk
         y1xacTqBazxWkLzltRj/GkUaflvciGXjmqh9JXqNa8pw2q9J+GcLOYErVZXQqudvqw
         /+1JnUOOLMPyXmaDHeGUc1c9Sa889ts6tslwT2Jo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.2.101]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mcnuz-1iScLg3B4r-00Huj3; Wed, 18
 Sep 2019 21:43:21 +0200
To:     linux-pm@vger.kernel.org, Allison Randal <allison@lohutok.net>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] thermal: st: Use devm_platform_ioremap_resource() in
 st_mmap_regmap_init()
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Message-ID: <27c67867-d39e-a5c1-12aa-a1e6ba6e7c32@web.de>
Date:   Wed, 18 Sep 2019 21:43:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fggeegn92OE1SbN4Q1lG9tzVWLlY/yEyMREpZZ7UtXIxBuG6ofK
 PGGm2j9mgNOs6l5M2Q0oyVr6rKly+1LgJ1/pOfDwTXYmIHJLb3aDhVZNpa8EcyQI+Iqz5qn
 d2yOh+SNA9KHiMROA4KWhY60qXgeX5QRV9msZnM9Kd+lo/0d0ubHmUV2wE5jBqYxpIdrBfM
 g9tRKTWpj8QIVSU3ng5Qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:owLeBtYLVX4=:jaFv51TcnigLxwRRuLckSn
 iPoFzriSFNOkxK4Q/PLHevAC3G3n7RM68HmgF6cDc9wG1zUz4ymTbMPYRlVCLA8py5YGrRDxb
 5FUgNEtThKoG1J05vGgA6E+HtVYUfrFO7RPgm+2+xBESCGCwcXPHez+wn8ETa+TliCdLqx3sR
 VxNP1eJ9PznyDVAlQPxn/AOUb0gus8DZi/mgJQrU7ngh3ygOnqAlyV2GLnahNQxGoTa5LD9Hs
 dWNdowVc3/S4gYlxtfj+8BnEGUFAfQsv6+uQkGUNd7Jp3ONkMOdNc+rCuraSjo3UEm8pTJlRX
 WWhdQuXk3sFl+QWsn761NsMxnl/Aq3PxzX0/kxSPBcso9neKGWbmkpd3ezqiURcMSsiI2eqDS
 fl0HPmKJNgXzxFcKF/hCPdg4OTiAjyuaOlZ0VK3o9MxFnwN/AE3x1A5iHDBlrEqWE5pBZ+xCI
 td8oYWiyIXfBY6PPd71wHPO5Mwgq+nMED9/Reu8HSfPPbFR7SrI7QKDv0QuJPAoTxh+61Hlnk
 FGZ895xnLAq5tYrZdhd4h7LIRyqre0IfiyellaWVEerOJ9oSaKpniA4BKP6EMcTf49i1VhE+T
 f134UWYTdu3sHBp3ugBSrH0SmzaUUtS1TM3oIvWKW6axRO44E6NLeQeab9FCZTa/g7VhuSt7x
 7INY3FhvNw9kW4Q2l8L8KHQ13I+P0O2f28l+3aorm61o7vLX6/8yHm+ACw8yvCUxroVqwqbmt
 wvNa1Sk+so5ejYCZ4JEGgydc4G1o9jh4xk1nSuVOvabzChPayO/lmK5YaR8B3h0/KA7BXAytf
 g4GRJiE8pLOOaKD+6vCYq5qPnGPR5ourbiyfT9IUNEYYmVzLVN/sfA5ujREKK+FVALynsFPXk
 2tZPHjh1hq/3DUDpMq21UZpbMBUzpdDwYbKiFI77gCdDy0MSgEckjK19GUPfU8Gvc2xqJvpVZ
 iIkhYize4R7cYK6ib3SK3juaGVA8TBqV1AeuleHTwpw1QtAu7b1+90uiByOqcfpWewUO7VYmE
 zE9FJYSxWKmeXlQa31/l8GL4O9dCm91jiYgXSUSawPEkDnL5rCQi6W65GiIt0M+Z1WIZDcCDS
 JkWqNUjp+sn3hO+XaZxUy4+wWAHgp9RYokFlVB+Z6ziRc63jvoBVkeO5wSkUAExQE8F4+OfMh
 xtlNk5at/MuUfoKlSd5VQdai0vC1ZqvbkS0iDIm8Djh7aMTrYnHrfO/6nCSwyQ6IrZRt3M1iU
 9hrYVbt+yvIjmzIDKwYq7qmVOA4cV7/rHd9qE3cRoEsib9SJL8BjK9O+4cn0=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2019 21:32:14 +0200

Simplify this function implementation by using a known wrapper function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/thermal/st/st_thermal_memmap.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/s=
t_thermal_memmap.c
index a824b78dabf8..d8ff46abd8eb 100644
=2D-- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -121,15 +121,8 @@ static int st_mmap_regmap_init(struct st_thermal_sens=
or *sensor)
 {
 	struct device *dev =3D sensor->dev;
 	struct platform_device *pdev =3D to_platform_device(dev);
-	struct resource *res;

-	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(dev, "no memory resources defined\n");
-		return -ENODEV;
-	}
-
-	sensor->mmio_base =3D devm_ioremap_resource(dev, res);
+	sensor->mmio_base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sensor->mmio_base)) {
 		dev_err(dev, "failed to remap IO\n");
 		return PTR_ERR(sensor->mmio_base);
=2D-
2.23.0

