Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9269C79263
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 19:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfG2Rn0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 13:43:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:59429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387732AbfG2RnJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 13:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564422140;
        bh=cz5syvrpEDjPh6mN9CRnHY7eSpKXvEo/1iVYs0MU7/k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UE3QZ/HI3AuxnxPTzLZelV5IijhJqrgwLxXXJkr+dlV4xblqDMaJY+guBXhyNJKbM
         9QnaAgyh5xUDXTP7E+hYhm6UHwREebq74n78zy6mqVOwOJ0o3t+FV0y3vUu2QolNPH
         CeFLmAV2pHKyC1n7wf99v/CtoHVAYsI5boGZ+j4o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([185.76.97.79]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MIuzJ-1hpfcb12fR-002bUc; Mon, 29 Jul 2019 19:42:20 +0200
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
Subject: [PATCH v3 04/10] rtc: mt6397: improvements of rtc driver
Date:   Mon, 29 Jul 2019 19:41:48 +0200
Message-Id: <20190729174154.4335-5-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729174154.4335-1-frank-w@public-files.de>
References: <20190729174154.4335-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:rzp9FkJr7EadzfJs3aGYSULhKPhkKTUFIps4gv1ZB118If5DGcc
 oN7ccU4JkKglYIafUY5Iw4R21eEKa+ARpT5mTm+1UY5nfJxJtUidwjMw7Me9ShjbhuGg820
 txw6meSqZlpmuTchydkn2WT3Mdc43ViwlwE3stQGtFUHvdWzf/L1IYGPhoxljJIK2Rib6kM
 VVYfP2iDIuT1BPSH5RPAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:b+GGDEa6JdU=:kzWlCHr/edMNuIhJ4Un504
 UxAyYga9K0wAFFieJVzKKo+oAj7WPsIvUkpF7/HHokmY3b5QBL9K/+qh0nO3Ic85U2VEj3eL6
 bvYX55k3BqtB7Z0qOWvOQM9TvFm1XljcVIgesqWghZFKZ4lJog/Ow0JbWhSOkVp6PZTwrfA9e
 QUaJvWW3bXkVB7ymmTzubDb7hzNhUfOrpnUTU8syihLVbTdPKdRJpQJbDxtidsjHCljzTLfRt
 CWfoLN3FdQ1R4VDVBlP6CxxprjvQnLl9dtaEvn2OkXviPleYfYfEnDLSzyGU9Nj04Z6rBGSrw
 K8ibuv/7ao2rQ2x8k56JgF+hArKRKD9hHG1O61u7mVOLVZOwXtl3rI08Br90bCgXUXUcSWThL
 VwiN8KfVPTJAkqGNHH9aNd3L6Or9csNzHFKEg/LG7CwGEMPkF/3L936W2eZuA9FdyKu19osZb
 09JIq9UmF3TcyO8vhl2YYWtPufP2JF1K4iWkowHqVyNcvwwT/akyHvDvEDn5c+gciYTHsF3kN
 IhucGCaAKmZEbqUy/B7rrooqX3iWFI3S97W0+tzyJlvwxg6rIBNxjuQ2e2ZxJfZsO+ALZrBBt
 Nrp3MoSLxIbyEClZr5kzyDYYfw8su95YaF3WnBcTsL5fsAh2Jn/oNzGxdBIhctHujNxrxCx7P
 pmlTRiRGCAA2O25031jAILBcqqbG4PMEigbX/A49ZnJjXrr+L7lCoLdlt24RBEl+N6XypqiGu
 XuqiVn00LB+Or4wLkgUlO3FlW4vqrJBdhl0dk3tk+YJ0/QF79afQcHgKhG9qCstxX4va+BDoj
 HZNbLFlQOxbFlTiqXyrCJVcEwKsA0aOo8iMT5JBb77jGNjWVA8k21Qg53KKchpYIunnlH6rDh
 0LqJYMNEBbJ8IfcXvGPdKemItCliPdbyYVnd1FsqPAC+wizNfH3CJ5Je7iBup12xF67hUbsXZ
 I2+0H7Hw9BuvOmHPc5JwoWJvf20ol6iC7KuozF4VrCw+WzrcfnZQNOQmWRL+l0q/wr05GdHsI
 o6gceydIY9pVM9gnexm7XPu9gLxxlKs/Sqf6ub6FnXNjqqtL2IwVQFmFOsZgHauNmzl85W55o
 Cmw4BiAgb2g8nY=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

- use regmap_read_poll_timeout to drop while-loop
- use devm-api to drop remove-callback

changes since v2:

- fix allocation after irq-request
- compatible for mt6323 in separate commit =3D> part 5

Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
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

