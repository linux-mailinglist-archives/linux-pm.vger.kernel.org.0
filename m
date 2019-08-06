Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF13A836D1
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 18:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbfHFQ3C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 12:29:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:34005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387911AbfHFQ3B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 12:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565108891;
        bh=8gcB2Y1P8SSH9aDUi/qMuaH1abxfVQO9b3fZW4tMYTQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=U7td5nPFbcCHuXvafAlc/iOM2+O7JofTOjmK7Lu3GcH5PehobU8I8GkjyFaAKjJYM
         AdWrQBGOOqYwlze+ynLrPHD4RusRIpT/zlPpQ2+StLkihSn3H1RkqHq3e355+3XKT5
         fgp15x6ygO+0/qNZodycQOhQ9qCQxV+x6NFgTApI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.153.94]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0ML6XF-1hulKt3KJl-000H3o; Tue, 06 Aug 2019 18:28:11 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>
Cc:     Josef Friedl <josef.friedl@speed.at>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v4 05/10] mfd: mt6323: some improvements of mt6397-core
Date:   Tue,  6 Aug 2019 18:27:40 +0200
Message-Id: <20190806162745.8414-6-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806162745.8414-1-frank-w@public-files.de>
References: <20190806162745.8414-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:+iJfjBRFYOn5WAoXepUrh13Q4VN8x0Pn6CZbVyyfzp1nlJk7Eaa
 fM00X5uVPvHuR4yEfqQDwItl0Vq6mGkZ8HXTDNzO1DxpZ5TOmjBS68h2tdCVMzWB0rCamWd
 GZu1q2wvYM8TWMa6FA0QC1GxIrP05tZ9Q2bfZM0goxn8B7BbrS6Na9xJiZQ8JaV4QodItIZ
 jLT+LxQppzWiatoHlqbwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:MJvW8qc5hm4=:lAYxn4cfPwTASX+zg1i74R
 qpKmfVTZRA8Cp/vTqoiid//1VOohTVi7PgWw7HLPBit/6gKWLq1zewIgVi8PvbhlNqXksEeRF
 kR0PDqn90h1UyJ8Ddvzrr24cvOKg/yzDctRdyCKRTf3/cNBriT3qlTHSeWE1oCYHa3IsTvEwL
 EHkMM3lKR99zdE7Cg2Afg8aqiFb1diaNlnWYN9CasXGfZ9xQZGGSHlFoyWyzBy1D9dE5MpEFO
 MUXXa0L+nbx4Tl3A2r2RBSTKuIm/t+frimTBgXAkD+5G/bHncXcCOouuZs3l5NKlOVzq9usFn
 hhYF6PayadlaA05xSx4PXxN72Abu5JgcA725vIvFffHaHPkdV9u1chCJfDh2Gg8jlQeCLOKCD
 iIooGX5qwY2Y3cVnfcSmUiD+YFQWvmvSnUx81SHQqvgQ7jC0XIIeMRHpUYicB5ErmKOiD/2f2
 j50kiQ4ikevgIM9tLZnnL1zdg7cdEl+uhFxeWJE9VfWHnIuglf3pb6eZ2ELWhTfID0j5WFa2+
 ukBjvv4u0VoNGZPC/UV1WrI0i7Qdv8ScSZL14H48UC0EbjpPjcDCTLoVPzzTPS+aYpxvXW0sf
 GxIStdBGfyG4Tp6R9wOynwuqCKWYbhZJNswvd+Q0aQXQzEvQKoXRosYWpfi1Nbrh3/ny0L7uZ
 G9hhbydgP12VvugoCG37qKWFysRCuMKxSuVrUw/sb3Ny9mWF5FA9f2/TNerVjRcyhoKsH0uBx
 kwlx8HzY47m6iCjHSO9Bx2Ic0ANI58L89kCGcWuY+XQYTP3nSzpksAPumhUvftf8dfdfigfQU
 W/9b353G9V1xiBXSJSA8mj2zhdYIUbsjEyGRLdYuYjm+2wINq2tkHhUqoI/NMhZ+ypH5dGU2R
 Yy1ewQQcnul2tpZkYThqdfjp3quPWbB1ORvud6PDCO6xtCmXnF4/HcAMYkdtRRRQYv+jguOtV
 tRksqUX2O0SfcM666SL4SP8slFKtCvkwyg5N+rCR9n/Ad/GSOGSdfnbpcJT12k6KeX8tWkbPa
 3XMuY6/sc/tWVgC8vNV1dUCJm1SBviIx1WHp9XQCZhMmU/KtwT/l0imJf3t7tQxUip5O2xJ1c
 FKBF2n1uI8v7ObMTJH9SxLsWYnF7YgMMF6koDCcbY0+/obmf/Tbk3CArw==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

simplyfications (resource definitions my DEFINE_RES_* macros)

Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
changes since v3: moved part 6 forward to let compatible and driver be tog=
ether
changes since v2: splitted v2 part 4 into 6+7

 drivers/mfd/mt6397-core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 337bcccdb914..5f7070267c9a 100644
=2D-- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2014 MediaTek Inc.
+ * Copyright (c) 2014-2018 MediaTek Inc.
  * Author: Flora Fu, MediaTek
  */

 #include <linux/interrupt.h>
+#include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
@@ -23,16 +24,8 @@
 #define MT6397_CID_CODE		0x97

 static const struct resource mt6397_rtc_resources[] =3D {
-	{
-		.start =3D MT6397_RTC_BASE,
-		.end   =3D MT6397_RTC_BASE + MT6397_RTC_SIZE,
-		.flags =3D IORESOURCE_MEM,
-	},
-	{
-		.start =3D MT6397_IRQ_RTC,
-		.end   =3D MT6397_IRQ_RTC,
-		.flags =3D IORESOURCE_IRQ,
-	},
+	DEFINE_RES_MEM(MT6397_RTC_BASE, MT6397_RTC_SIZE),
+	DEFINE_RES_IRQ(MT6397_IRQ_RTC),
 };

 static const struct resource mt6323_keys_resources[] =3D {
=2D-
2.17.1

