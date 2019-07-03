Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB25E98A
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfGCQtj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 12:49:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:48639 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfGCQtj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 12:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562172515;
        bh=Q4SNzBfUgmUaXEsp2/EkbHDrGPVnZzLCOAAZMoTbLHU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dUAq2zu8k0rxZvBIT5mcoE2t0sC3jCT+ju9g6JRkYtSp4RB6PavjpCfVuJ3uQRRag
         PtBvoecXZuNbglZNIfhDtks5YMtnk0+OSSOMgQzm+6QDyPXudrub7GdWqXzZqIxp28
         vaAJLRKY6+Bm2vyaA7kTXQhbVzwli2iBr3QLmayg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.158.204]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MbirE-1iF1363taI-00dD2d; Wed, 03 Jul 2019 18:48:35 +0200
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
Subject: [PATCH v2 3/7] rtc: mt6397: improvements of rtc driver
Date:   Wed,  3 Jul 2019 18:48:18 +0200
Message-Id: <20190703164822.17924-4-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703164822.17924-1-frank-w@public-files.de>
References: <20190703164822.17924-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:Doz5m2szHD54xebFCDZtFG1jkMhZkLcvMGXvCyriCBWcdSKa3Po
 9pNHVGegXnLoqrAeDO7HXgCEhNeUReGWchhh3UVvXcsL6dD65KFzYJ1tAzs8YKkI2gMYAJW
 LC9Evz9eFQO1eF3akk3EL0bT7PfbiTi5oaw4VaP8f9vPXewf09C2JHPqAcdg9iEdYErjHpu
 1VcNABzfFOtmGkWQ3WBeA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XzjbtNDDVBI=:6fPDOhc3ib1mIDPeODXkCM
 sGi1yA24Th45Cti4r6Y/VVlK7UWP/BLhd4poItsbr+IxQhAowvs6NNYsbHW3GH455oJZvioNF
 Iz9au5ndpJA27wKgIKRuGvhb+0p59VDjdfiVFTfduF+yiu4c+G+S7rrqVatiaGL1nAucT4yel
 1JiS4o0cD/oOP58flHAPTxmJkMw0e93hr94qBZRn9BCNdG69zTFZkd7xpHZsp5uNOq7L3uKIU
 yHj60ZWItxffMb4qH/X7ERxbLhEQwIY02T+NQtnZg4v2259rR5do7Upvh1RRUcolMeM7vGTYH
 mgCAy2IOu53hldt6Q3fRSXGaI3OqMbu3WeoBN/RK1DPRzEDEdIYwAYr9BOdAr5VoUSQhzOjvj
 qSjwMlr4ryLFhTrnOEqtJ6X0Xop8NoGrWRlf1jnVB9CTiqe3716CRqhlsNdaEVhghXX3dQjol
 CGpdKc6iw9xvxM0zJz9l6x7g7GxkistvOnle7SMPISNaZwZER8Rza8QR9K1ZEfCGrSgVwihbE
 e9Czk22vy05sRHcKC5Ke8nYPvGyskoGRZREhurmrTgSJBvVVymfKkSVH+FRux18hLEN25W0zA
 47AKfruN7OYXdawFTDu43VqZgGSe9KllIEO3TbTgAS3Idocr9sBaBWxDj7Hh9ALIi0qpMnjIR
 o48+7naGWINRsknUz/s/qsc7S3ZEObFHqWKMKE8PHSCCOWLskDGq9tnr111598PVD7bldVS4F
 mAAuPrrA+wagXuvlmZ5ZlYv13TTbALqZkA7i6sn+Pd1AMWo+FJfdpIUs9LUWBhnn9Lhp0uDI9
 zodNRadZvE4BtssJmsUzNk3dfiD9vJssjxxPSrRx9P3DYOxchAu6Q1MbvuSSuFRES+fw2bgrn
 7wzeLS0IVG4/PofxgGy6FXVLzjjhnWUXj32h+vCPDiLKKMz/xZKW8CpWawz/b61VF+RAmqcRg
 MsZPvcSJ4LR/1YfWdlAh7cX9Gwv6OzpVyFO3ZpiPobgO76SIKO4GKVKkiqEywfTOsnfZ+TOhc
 ICjiGClrvXeiYyaHpfKONdnWyaH04Bbd0pCM/LW68c68SC8JSKo/kekPE6uBRNiLMkzjrYJyS
 sfAoazhD4roxRs=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

- use regmap_read_poll_timeout to drop while-loop
- use devm-api to drop remove-callback
- add new compatible for mt6323

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 drivers/rtc/rtc-mt6397.c | 55 ++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index c08ee5edf865..e5ddf0d0b6f1 100644
=2D-- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -4,16 +4,19 @@
 * Author: Tianping.Fang <tianping.fang@mediatek.com>
 */

-#include <linux/delay.h>
-#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/mt6397/core.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/mfd/mt6397/rtc.h>
+#include <linux/mod_devicetable.h>

 static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
 {
-	unsigned long timeout =3D jiffies + HZ;
 	int ret;
 	u32 data;

@@ -21,19 +24,13 @@ static int mtk_rtc_write_trigger(struct mt6397_rtc *rt=
c)
 	if (ret < 0)
 		return ret;

-	while (1) {
-		ret =3D regmap_read(rtc->regmap, rtc->addr_base + RTC_BBPU,
-				  &data);
-		if (ret < 0)
-			break;
-		if (!(data & RTC_BBPU_CBUSY))
-			break;
-		if (time_after(jiffies, timeout)) {
-			ret =3D -ETIMEDOUT;
-			break;
-		}
-		cpu_relax();
-	}
+	ret =3D regmap_read_poll_timeout(rtc->regmap,
+					rtc->addr_base + RTC_BBPU, data,
+					!(data & RTC_BBPU_CBUSY),
+					MTK_RTC_POLL_DELAY_US,
+					MTK_RTC_POLL_TIMEOUT);
+	if (ret < 0)
+		dev_err(rtc->dev, "failed to write WRTGE: %d\n", ret);

 	return ret;
 }
@@ -271,14 +268,11 @@ static int mtk_rtc_probe(struct platform_device *pde=
v)

 	platform_set_drvdata(pdev, rtc);

-	rtc->rtc_dev =3D devm_rtc_allocate_device(rtc->dev);
-	if (IS_ERR(rtc->rtc_dev))
-		return PTR_ERR(rtc->rtc_dev);
+	ret =3D devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
+					mtk_rtc_irq_handler_thread,
+					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+					"mt6397-rtc", rtc);

-	ret =3D request_threaded_irq(rtc->irq, NULL,
-				   mtk_rtc_irq_handler_thread,
-				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
-				   "mt6397-rtc", rtc);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			rtc->irq, ret);
@@ -287,6 +281,10 @@ static int mtk_rtc_probe(struct platform_device *pdev=
)

 	device_init_wakeup(&pdev->dev, 1);

+	rtc->rtc_dev =3D devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
 	rtc->rtc_dev->ops =3D &mtk_rtc_ops;

 	ret =3D rtc_register_device(rtc->rtc_dev);
@@ -302,15 +300,6 @@ static int mtk_rtc_probe(struct platform_device *pdev=
)
 	return ret;
 }

-static int mtk_rtc_remove(struct platform_device *pdev)
-{
-	struct mt6397_rtc *rtc =3D platform_get_drvdata(pdev);
-
-	free_irq(rtc->irq, rtc);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int mt6397_rtc_suspend(struct device *dev)
 {
@@ -337,6 +326,7 @@ static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_sus=
pend,
 			mt6397_rtc_resume);

 static const struct of_device_id mt6397_rtc_of_match[] =3D {
+	{ .compatible =3D "mediatek,mt6323-rtc", },
 	{ .compatible =3D "mediatek,mt6397-rtc", },
 	{ }
 };
@@ -349,7 +339,6 @@ static struct platform_driver mtk_rtc_driver =3D {
 		.pm =3D &mt6397_pm_ops,
 	},
 	.probe	=3D mtk_rtc_probe,
-	.remove =3D mtk_rtc_remove,
 };

 module_platform_driver(mtk_rtc_driver);
=2D-
2.17.1

