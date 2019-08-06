Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526CA836D6
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 18:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbfHFQ3C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 12:29:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:44867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387905AbfHFQ3B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 12:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565108894;
        bh=pEU670PIz00v8crp3rxuN1fi0Dt458xswIDV8ulcPJg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Qvg07LNJbzW/kNS1rCrgTigz45K9KSekRUIrJZT/LhvYe5xQw0lW292FTSqXDwwg5
         /9aPnhc29E7nDm1+hHt2p0ysX9GzXsm9xbcfo+bcl7jtqbR8pjHT+MsgycEgJUVAMg
         ibW4whT79YFw/WvpMUVO3G/9cKlkTV+JLqFHMBgI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.153.94]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MOOJl-1i0Hdo3EOb-005nMq; Tue, 06 Aug 2019 18:28:13 +0200
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
Subject: [PATCH v4 07/10] mfd: mt6323: add mt6323 rtc+pwrc
Date:   Tue,  6 Aug 2019 18:27:42 +0200
Message-Id: <20190806162745.8414-8-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806162745.8414-1-frank-w@public-files.de>
References: <20190806162745.8414-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:Os+hN2QnhF0iBkyzWFfYWOZ/foZamI6qBMXAngptIHU47UjTWnb
 1G1VH82f39MDlQhnXgpKOJyjBNr3cmU78rclGXnwKIQW6g7a/ZGORHUDbkwut3VEwAkyDS1
 uV87Tw7Hnynpa0Sztv2ReCtXOGa8S/mpUC4N9+MD+X2YDUYCNig/7weu4o7bM/c5/hLlE6g
 PmlrRq4wKlyzdd1A/QpeA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C6S9T1mcc3w=:wZ1vAXXk0wjMf9cSlhYbKL
 NAT6kDU7oL1dS5Z/3WjhBBNyLifPnUCO6R5/hQAdVopCn+1nZdUgXx+GHFpE5xtl0SVTXyhKa
 /NfE2QUAVHG1Yy4Esi346cZuXmbAFkfb03du+dXFaahSC7ntJonyQd790/ok/3nWRG2e+P+n+
 5BaCS0BUZzVZpcKxhW0WjWIz7Y7EPWUZF9e9pVZaf0hiMapyY8eMqOOVtcB7J0Ftsmk58aQRa
 vQBsevAAy9CRWLPg/yKAK6CPABax5v7Cj4Nkcx6z+2BKYPCVFrAQQ0x4HWGsgnMKskDnm+Wwy
 y44We2ws06/rAm0H+XJ/4kuAaOPVZr8C7q9ySoBA6M5I/zUvrxgdM1z5EciDQVKo6DaRgYFqd
 e/e7hO6ccVCElb/lZ7py/AfU5W8FkMylsVEfiGQEcNeNeQGwM5Yeum+cJ+974CB23klw1QG3B
 FXP6+FRuBCwRfF4LGOIO1PCZW7jNsuYQBfcs2Rt9yE9YuZzhZkMZAKmGP9WZ7RQqG3EcYjaM4
 fjD0zqDHHan3o24UxtnSe+imJvpAGvxgV8TV8zkMN4xbwK3VOE0ls0oUWfyadOSH7bTjL/uyb
 9+F4Wud/AigsDiMeOUq6EAwMoms+YdPqblkFgY0k3ZBRba1QupT/pk/Q8AsS6E0Er+ikndnRR
 4uxym6L+7cIXNGCQwNnJcNpz4xxvUzD1fAL6gFMt1CakxzQEHZkEsdj6IUWs18c2jdrEX+jXa
 dN1QXX2nvNjmNEAvT6vjuclfLxNkbIovRiKiPS/Dh0bp/gEhhmp5iZlRADg3iHs/o+J0POcfW
 8qPAswbIzLBF0n8lVBKTprR81QGg2TK6aUNAps1v9vSRl+d/8P/2EFy59JwxhX75IDfXjp/EW
 rlMMwLCVgWQQxaACdI1ISu1IgW3C/RPCiZIOtlDx3KaKYck4rZnaE+L0Eto4dWxMS/tJ5wr2z
 rT7jySsXH4dnrEkjEfIv65kvyFisdXJt+3uS9s5gwr5pNUFD7hCf+eliNXTrg8zGvVaPTzJW7
 x/YUosrZYVV8Om1+GCPpLXGOkjs9kVZZ99+RgeSj7Tq4IbNBHIjfG2XQqQadAnBSA8UjfUP/w
 neKBKOtEKcYHct6EEqov/GkxFRABtX7S0a+/SreowZxEpB+tFqOOcWrOA==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

add entry for rtc and power-controller to mt6323

Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
changes since v3: none
changes since v2: only splitting, second part of v2 part 4

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

