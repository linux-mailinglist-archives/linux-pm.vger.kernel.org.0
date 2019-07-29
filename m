Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5919B79277
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfG2Rnm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 13:43:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:45503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387689AbfG2RnI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 13:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564422143;
        bh=uoSEstO7wh+z/Yh5O4xemCJ/Lip8M0+P7e9/vs/uBqg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LUYzoyK7AqrnAmb+JoOAKe6C62uiFNbkaRfz9LRBUHcaNbbLwpnqwttQbQqmpkF0g
         1s5F7KynXRT58c+oaT13Z00UfOq508HvgXf1m/0a3GjtNfxaztYxmi4OqNLm/cGMrW
         pgmIqMjUdc91tSN5wzB6dCI7EX0oaPwGws0aV0Lk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([185.76.97.79]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LzskF-1iV71A2pwh-014xXw; Mon, 29 Jul 2019 19:42:23 +0200
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
Subject: [PATCH v3 07/10] mfd: mt6323: add mt6323 rtc+pwrc
Date:   Mon, 29 Jul 2019 19:41:51 +0200
Message-Id: <20190729174154.4335-8-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729174154.4335-1-frank-w@public-files.de>
References: <20190729174154.4335-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:/8/fLbWdSh3bVNpxmnpL3FPeT0+linP7Us78MAvnUZuQdGm5VkG
 JCpRlGkofnBlmrzQndWukonLRDLXi08x0zDn1J2XNV36jNGQW6hd1+5DfsE/9deZ0bsiaMA
 edVYQT2hdUbxeDb60rreTPNXvSJK/NOu196puTcD6SRN/wJAMbc4VxPi0BzC0WTQRF39r0X
 WD1BP0vy+5EW/qzQ+Ojwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dq3eJEN+210=:q2LebVnxWDyoNhAxtkTf2Y
 +9IwdSRG7/gRTn22h/ok2pRBgVfTwU1TmELeJPQmoQ0DGqMI6NaFOLyCrVgT2bcnId+G1Ft7i
 IXtNiOHfaM06LuVwQUAZCoEZENr90Lmd9aymi9DMhDjetx+F1fno4vKDOPaKiUlcmOaUbQNN3
 YCH/EoVoPOoGuvhaPvEtfSGKARshmEWVmFEGagr8Yze9qNWluOmMDyQ6NpXvS3g1gQHfHZwli
 PcpMOeKLdtvStE0x03reIA8Ma2Q6wTX3AqILxFpMUOksLsh8QxEJUHGlf/2L5P/YmDlAVESsN
 FoLWBu9zxex0dQUtlS60C+ha1FuczC1xntVCPw+qwbYE3HDnp4Lvn7ZiA8qQmyTeqoASOjDPO
 Naz0f0rVc57ItsDJFjAprh3obonT9WHtmuQc3017/DQoCx4O/GPS/TJgs4/mfL18WMcMf8vN8
 S3b8egTFabdqYWUu0wRTiSrlxc1zsppxQHaB4NeTylh1IRdxYo07C9NbcNOyxFpPg0bGbOMNS
 PhEfxl6jJ1EafnbxDo5wMcSEBFl58hcWTu8Z78VDhPWEJvkqC62Zf/juxT5KlRE4cVm6WYs+e
 qfiMQyD9Xa1vqC87EAQNNRVtjI8wVHUwwGvl4RkCV6xhL155YxdfCRGM65WVvC9x2u1vcSlw9
 NRpHOknBYtHL067Vu5gRVBXKwBdHAVLGwEF+vxW0J3XNLRwLlQOf8a274YXJyvrRZAKk1afTg
 roSQmVKesVkl9U8RHuvYQbMO/AEVYvYrbj6sRFVOHe1eWk6gROBBXWqCdfddYpTqHNCraQCyU
 G1MbEO4OUyqttPWApGg1LUptcoa3RqkPbPc2FCd0rftFqVmiJ1+fePbfLoL0L6ShvaapudN6q
 Ux7VPUnCNkVgtMMUWiymUuoOx8V9OYDoODl7RgW0WxXPvQ3q64qJ/5GCAPuAhvyRfvR3EGKvm
 6lvgR5z6trDR4Nc9YarQW//4jsXvJvmzkv5BgJ8EYi8HSI11p0QHJUBz6oZkGMmtAKVWtmsTh
 LKWtjGkcFuYwZVXx/JQ8GEOkHl98NLAExD5GiQOjWuSoQNo9gf6mGICPQaL0iRtJtD18PDOHi
 /MMfS1tSjmIsqI=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

add entry for rtc and power-controller to mt6323

changes since v2: only splitting, second part of v2 part 4

Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 drivers/mfd/mt6397-core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 5f7070267c9a..a4abce00f156 100644
=2D-- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -16,13 +16,24 @@
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
 	DEFINE_RES_MEM(MT6397_RTC_BASE, MT6397_RTC_SIZE),
 	DEFINE_RES_IRQ(MT6397_IRQ_RTC),
@@ -38,8 +49,17 @@ static const struct resource mt6397_keys_resources[] =
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
@@ -50,6 +70,11 @@ static const struct mfd_cell mt6323_devs[] =3D {
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

