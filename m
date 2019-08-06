Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDFD836DE
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2019 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387949AbfHFQ3E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 12:29:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:58799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387916AbfHFQ3C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Aug 2019 12:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565108889;
        bh=JOUQ+oPDKcgPIIjUYlOez/IGFEXhWH3PKrXpZ/Nj0Pw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iZL6rIKkgpSRvIyMJ7yrjA1AvAGWJeQUirgBbXGAm2djIScT7P1VbcGWwAYsyjJVX
         /Ou8ir8pEc6TsXU+9CPn+sk0JaVDzBPqENOVYqoCIbnYfvZQf5wXsmyEinlA5s75VD
         ux5tlFXELueinyIkBF7heHsH/HCMBOOJO52dfs1Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.153.94]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MS5jy-1hkbwp1SOo-00TGKh; Tue, 06 Aug 2019 18:28:09 +0200
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
Subject: [PATCH v4 04/10] rtc: mt6397: improvements of rtc driver
Date:   Tue,  6 Aug 2019 18:27:39 +0200
Message-Id: <20190806162745.8414-5-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806162745.8414-1-frank-w@public-files.de>
References: <20190806162745.8414-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:Fo7b1eCTmtbEceNwBLDjCvbnWHtd4rgJki9dQjNxSmpo7n+DzFO
 6t+DoUaDcg1ZnqfqkptI6EYT1AkV9a+JcNZFDn6akif1zuOloZoIuqUcOEvJE+xc6IpmC69
 yul5ZHuc/3dJYrkQyZHwfAIJg9NM/OdUBNNLJWh0anxKOOf3rT10idQ/mJD2y6zQOyAtMew
 egld+N2kVA/30bFa7BObg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AbPc73zCr+k=:tTtvNHVMujzgME3Cq+L3Gt
 cQgc4Xk9AOFahoyHHEqmUkzRr2E2p91APx2A/Ib0UKADE0t1zG/dZZkH8WjQRtEszbQ49aX2u
 c6Jq3vI2g3FjnANQ/197dcqwTJ0oaU+0NGOsGuGeG45ClWTovd/Ju0QaUCiUinAraUJjk+6o2
 lOm6PMIXslC3t9xqLhtOh8lRxKPfeixR4i3GLKkucXoToW6E2MJpwE2szKwB6rA+Ucl/JGsu4
 VrsbmX5C/EfRnLGgYfSv4JR2itePj4WdKfNXQA0viVYYOLWkxs7z0YT6B3cZTAwJVm14ocbGC
 KSUUtLIVKQWqDQ/hBAqr3FguJ+pTlaZoabYrgslHBvbeytGaQJEngFhsZZqM+rZbCCOcUfzGi
 KGpGAyYgMlLyIhu+XX3lscrwRYuHW9yTotsHQA1W2nA7Vtlf0x9mOfcPtH8rYsFPfh+cDZ78E
 P3njoqHFBXaOm5jPEwkvtANw6Us2cTcHEMfSI4XSUv0IJTfaukLbunpItOEZr0IlYDwwgSWCn
 o66/NYiWQ9uUmMWUSurpaBnSkyHepr88eh54D9+YlcjElK4usnwDswjVxOjZVJzN6DKzrEe53
 r6z2itizisGr7ZYQRgDd1KX7jo29ei7N03HSI5xpGm2n1x7EwNVycim2lpzAV+7z4gRiNuNx3
 5GkrioMqExCxUDkDZMqapJXzcPriFEXU9KYA2pUHB1TKbQJAlpDS8oeBeYHHggpH5qYoDxJU6
 slzQZOPoWLmG60y9lFklbWjDfNgsBH/iTN9ymDgkhegRyYIOvDRsXshnbo++c3OIoBh0aYdrh
 NubfVq5LGHFue4fQL9Ys8RxwdnNYIC5GsXe199Mp/NkmZMVuMhv7cR3pVoVR8dVCFreyWFiAq
 qplgDMZ24R+uovA37Rm0YWABHLWz3pH84P86liMg5nh+/TQXpVTw9OJ5S8wlT3tF1cfaFJZAG
 epEPr6kykVOLm3dgy4d8wWRXDC5/X7W17XRZ9UDMY28fPyt6v64FHSwA4V2puBnpQvC0XmoPG
 UE07pbFu2E+vfMQyz94yIWdI0MPY9U8Q1BqAozNN5ubluhZCjWc55K+ZE4A32ayDCb0V2STln
 9VagosHuyciUb65sEFfPOgLKGw1HMFX3xXQ94VcYcBH2nDsXOxVm3/pNA==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

- use regmap_read_poll_timeout to drop while-loop
- use devm-api to drop remove-callback

Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
changes since v3: none
changes since v2:
- fix allocation after irq-request
- compatible for mt6323 in separate commit =3D> part 5

 drivers/rtc/rtc-mt6397.c | 51 +++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index c08ee5edf865..9370b7fc9f81 100644
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
@@ -266,19 +263,19 @@ static int mtk_rtc_probe(struct platform_device *pde=
v)
 		return rtc->irq;

 	rtc->regmap =3D mt6397_chip->regmap;
-	rtc->dev =3D &pdev->dev;
 	mutex_init(&rtc->lock);

 	platform_set_drvdata(pdev, rtc);

-	rtc->rtc_dev =3D devm_rtc_allocate_device(rtc->dev);
+	rtc->rtc_dev =3D devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtc_dev))
 		return PTR_ERR(rtc->rtc_dev);

-	ret =3D request_threaded_irq(rtc->irq, NULL,
-				   mtk_rtc_irq_handler_thread,
-				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
-				   "mt6397-rtc", rtc);
+	ret =3D devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
+					mtk_rtc_irq_handler_thread,
+					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+					"mt6397-rtc", rtc);
+
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			rtc->irq, ret);
@@ -302,15 +299,6 @@ static int mtk_rtc_probe(struct platform_device *pdev=
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
@@ -349,7 +337,6 @@ static struct platform_driver mtk_rtc_driver =3D {
 		.pm =3D &mt6397_pm_ops,
 	},
 	.probe	=3D mtk_rtc_probe,
-	.remove =3D mtk_rtc_remove,
 };

 module_platform_driver(mtk_rtc_driver);
=2D-
2.17.1

