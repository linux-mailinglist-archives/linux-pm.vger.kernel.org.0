Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B343B5E99D
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 18:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfGCQtn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 12:49:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:57979 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfGCQtl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 12:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562172516;
        bh=M6PWi+AqvzIHnI2kv34DphxxV8F7xx3ycFGzciNTHis=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=bTC6pznWnKuM2Q7ikYhEDEtVB6XrMQF7C4D3fmIQN5OPnhNjXYqhISarRoFWzzyJr
         nEO4RH6SMtjdWb90eSUniAUT6Qeagsf/SPn8grFddGBfDgaXgriQOZrTPjf9Hw4bno
         SHQ16P83037cSeXYO0ANMgqtI/zfdFvKIAs3c42I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.158.204]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N9MpS-1iccR545rg-015Lm9; Wed, 03 Jul 2019 18:48:36 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Cc:     Josef Friedl <josef.friedl@speed.at>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v2 4/7] mfd: mt6323: some improvements of mt6397-core
Date:   Wed,  3 Jul 2019 18:48:19 +0200
Message-Id: <20190703164822.17924-5-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703164822.17924-1-frank-w@public-files.de>
References: <20190703164822.17924-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:kuKrBJnTtq4b2/NjZPE2sfV/tuwmiaGxoDx1uz7jDmUZFdXJVqu
 E4J9a9ArB0XhOnjqVPn9Cu6pWThn9Rc4Ycy9O/xTrDtTUbdjiP6n3jveMUnYXxd/LZoUaHC
 icVc9kVck5MVdwiejAlltqlLU4JXl/0y71LTFKNGIBY6HUo8mbA+IAYxC0dnEYrwYWuCT0G
 jeD99AauMluP8+kc1Xv8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4y2AIBRbDu8=:pkbnQbe2JaaQmEjD1zX2hU
 +fISZlmmLjLuHjAe/k+og7KqE72m4C11dZwxNHNmzlNQChXlOsWgmhEcJfdJFKKb9+Zef4PMs
 fIQ1wa9Ce7miKBDE+8SzGAI9G+IrLDItZsihBUu0RfbNFk93kb98az9yvjL1gpX4gt0EoGueI
 SptkfiDCO4mc9UF9YMFnckzibtyDEU5/Z+V2T2vck3duPxHx23YIzet6ms/zeFSbE4VcrkwIF
 zwfwIlmfE5TJzlQYIxNGfgqnruP//rXCJUiMKWwra92M9+2RBjkHCU/E10MhSuGIjustYcPR2
 8f7t5Wr8CGA93gDSp55ZawCLT1/fHLqfCrPuHQcNZ+Izzs9A7gN7T663ATT1ZSJuZA9FdYxjv
 8uD7JWovO9+Tp76rNqhoEmXeHIugmcdy2j+Vbm/6sIwfIeXxtEyqi+NRNOLLuGtZnsloyesGd
 bEqyYtf89JOccjcwYvU/5MqY4rDTq3YvrZ4ZJBLMb7vCd/SujVPMR2AedI6WFXwgO7HiLyv4b
 6Gb2TM8DOBZ6TK5ctswVnukVAzc8ZUe86QZ8a+vu702qsoceLahkTvnE28ETw0ZzIfYdJgtiO
 4Q5zQdzGZgekbKsF7LCBwrLrzsOt3Vod+NeQiK1f1L/nbdjZ8WQFIpPBXJ4nGJfR8E4w7K3Rv
 /JjRf8ZsH4ef1iptYd5agp1zQO6uQZK6DP+0TGZLpRN/JvO1Lg3okL2ShQQtJFHw1Nk1GCTgu
 02NeYOJOZb3xhZn3KeSN4p2VbZrrnWj0s9TQon0C6wJywiTYCDtO9MXp5nFVwFeNIeho+k5WL
 LioKrfN+Suic2pv3IN6TMqcM2r5iVjcC468O7wmv/aV/bKeqNYO5T4FspIcLlZ1tYHQlLiSAU
 iOJkbPLUhGeiq7JoCdiVHxLq548UdL9MVl0ICMunu89tc2oPm0mjwCzrkxVOO9oGheruWFJr7
 O5t3EaJR1WwF/+PMPtjIaMsHcx9TdjcE58OcRxGrnv+jRwmroHSI1cME9wDv/kweyIseNK8v3
 XXhSPUus/34aUQRfIqnyrsUERQdU9Mm3g8ttDbgeJSdm20NHgT0FzXuZ6Qi5sPqikl0L6hVga
 FEsTdQsGIxFBs0=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

- simplyfications (resource definitions my DEFINE_RES_* macros)
- add mt6323 rtc+pwrc

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 drivers/mfd/mt6397-core.c | 40 ++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 337bcccdb914..a4abce00f156 100644
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
@@ -15,24 +16,27 @@
 #include <linux/mfd/mt6397/registers.h>
 #include <linux/mfd/mt6323/registers.h>

+#define MT6323_RTC_BASE		0x8000
+#define MT6323_RTC_SIZE		0x40
+
 #define MT6397_RTC_BASE		0xe000
 #define MT6397_RTC_SIZE		0x3e

+#define MT6323_PWRC_BASE	0x8000
+#define MT6323_PWRC_SIZE	0x40
+
 #define MT6323_CID_CODE		0x23
 #define MT6391_CID_CODE		0x91
 #define MT6397_CID_CODE		0x97

+static const struct resource mt6323_rtc_resources[] =3D {
+	DEFINE_RES_MEM(MT6323_RTC_BASE, MT6323_RTC_SIZE),
+	DEFINE_RES_IRQ(MT6323_IRQ_STATUS_RTC),
+};
+
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
@@ -45,8 +49,17 @@ static const struct resource mt6397_keys_resources[] =
=3D {
 	DEFINE_RES_IRQ(MT6397_IRQ_HOMEKEY),
 };

+static const struct resource mt6323_pwrc_resources[] =3D {
+	DEFINE_RES_MEM(MT6323_PWRC_BASE, MT6323_PWRC_SIZE),
+};
+
 static const struct mfd_cell mt6323_devs[] =3D {
 	{
+		.name =3D "mt6323-rtc",
+		.num_resources =3D ARRAY_SIZE(mt6323_rtc_resources),
+		.resources =3D mt6323_rtc_resources,
+		.of_compatible =3D "mediatek,mt6323-rtc",
+	}, {
 		.name =3D "mt6323-regulator",
 		.of_compatible =3D "mediatek,mt6323-regulator"
 	}, {
@@ -57,6 +70,11 @@ static const struct mfd_cell mt6323_devs[] =3D {
 		.num_resources =3D ARRAY_SIZE(mt6323_keys_resources),
 		.resources =3D mt6323_keys_resources,
 		.of_compatible =3D "mediatek,mt6323-keys"
+	}, {
+		.name =3D "mt6323-pwrc",
+		.num_resources =3D ARRAY_SIZE(mt6323_pwrc_resources),
+		.resources =3D mt6323_pwrc_resources,
+		.of_compatible =3D "mediatek,mt6323-pwrc"
 	},
 };

=2D-
2.17.1

