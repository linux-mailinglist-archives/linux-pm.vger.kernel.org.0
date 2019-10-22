Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423E3E011E
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 11:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfJVJuR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 05:50:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:52665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbfJVJuR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Oct 2019 05:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571737790;
        bh=OE/0MVT0jwdzZZXVDP3ALcBpFIqz2P+d6POGuGMFRDY=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=Y78YX+aZjnPYPJGYXgg9E9WDr/o71f9xVzjw4w0Fb5u40zkwc/kJp3Lv/hx28MIqz
         Gl1C0msgglfINc9wyGEH3FCzmqTNaV4oSPbSHZG551Smpwjb2WuePRHOqgr14VcqVF
         sr4nU08T94aigvDi2nq1osHmLuTANbcyYscIyTRQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-bq ([185.75.73.113]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mFi-1hszdC0mD6-01335A; Tue, 22
 Oct 2019 11:49:50 +0200
Date:   Tue, 22 Oct 2019 11:49:47 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190910070446.639-3-frank-w@public-files.de>
References: <20190910070446.639-1-frank-w@public-files.de> <20190910070446.639-3-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/7] rtc: mt6397: move some common definitions into rtc.h
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org
CC:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-pm@vger.kernel.org, Josef Friedl <josef.friedl@speed.at>,
        linux-kernel@vger.kernel.org,
        Tianping Fang <tianping.fang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <D5C0F601-D71C-40DC-BF89-5C167DB004A1@public-files.de>
X-Provags-ID: V03:K1:IDQ6Jwwc7LHNhDz0snpL9KvZ48Wwi3GQfUWLY3C+qRfc+xCLK16
 VIpVqXjm0vosezYP0lKD6q1a3Ykm8DY1U1sI7Bzgslu6NVi/00Gc8ftSzoSI3DohyGHzk6K
 YLisBIsWGAhnS+1mr95nVB3M2m7Z/RaHwT6BEaaQjhKAM67qKcylpx6isItv2H5Nnw93gLf
 TwUjRIpjNUSgdx9+zniTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:soT82Ffej2w=:7rJfWtDTS3SX+upAw34teJ
 pdr/VwAVmlNWPBFT+zyNEb940CW5sHe5qMrGextya3JYDZUHekANpzUbAgv8aO+vybIsFeqXR
 R6MZcr6F+OgckblbB3u7N5ICw8XyRtcY8hlZkRHehl9harQdgQLjrwxZ9B16tH5D5CGpiUYxA
 q8JAdZPeKp1CsTgMlO67nkvifvR1I6tFtMpzq9Hx90A+4/uL3asUaJD6X70IOwXpqIcGNv8qI
 VLIQqrOFG0xAPvH5jvV0HWkXvh6WV9IkTfPnydZChYrPnJFhZlMMU1R8miBROuw6drjokgKcA
 XP2g15U4CKOSdkabJQplRsWZrpe/AQ+jBU61Mk+ZXmew2zyji+VJu5zJFvt8359UdHEFE9SzM
 Mm6OBKstduSagtt4WWcbo9dQ9oQ9hTua5YBevroOjwiTScbvJ56o34ae416OvceYIQ8rIz4xf
 HmTH7hiwTzGwX2ON9e3pCSRy9ymDLZxTK6q+ooM62DmRHckHLJOoa3ZC5gsDBC0YzdZszBaeU
 5tzTPxnCmmCfkyL3tCBo+oRRkU2sooS0mmKnhABR9IqsQLTu07y7ISES3XCNQvaYhnbh9wINR
 zp38LkQNSblDgvP9prNoYRxJvUpV/DVvXWQLiHwJrO5COcyHN4CtvhRTtg44jHo20cLHckZwt
 lKQo50s9aZVVH8MiVsatzX+JgxPQmuRwPQzImub3MA2ysd4xrEipjqUTenwpeQAs1Yg1f56H5
 8aC0iCh3qLvPiUbvH9A5BTu1gA2dZ8btBLHC4Q2qwBNrwhnD11DLeORmjureVXmoTGP0eH1AL
 2/m/Ki8Q3lJc8CDTcH46hw3ZqRcoJVCZ1iSjqny+bN/nopDrp3oMD0OxndZJ7XGqCdFlEAc/v
 iwUwEmlMUOlFA82ljsSH8LMU3lA9a7uLdmKE569XQ1bs2MN0tgK+0y3Iigy7NucB6+5o4upMU
 LBCyr0lCIxBTFpVS06+X+39uAxEsGCunhTCnbW+HFQQ3g+I5vv+Sk345oaDNoPZjfMUL7T2o7
 SX5E8oNwpO1JycXSeBzU45dGG4TFNpm+g2ReNE3NgNoOuiZYUZ1MEthAkg+rwjEvxNws/7r/r
 fkKymykZ8OgDWXWlvULE2NXmdw7sTuTXlRNm1klfApr8OrDGoC8ctbVzinKbtCDLEG4tQcUH/
 ZA2K2Z2igjLGuW4F37RK0xDesjF44vU6WB5r/DkRXfxR68TVN7iopaGvFJy5e6nc1fNpc0BDq
 aHf2osz2ZrW8yuWYogMPdqeQ/2uKCIXXQTDxZV+ucRjLJygJxfp4lG+p3u1I=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Is it ok now? It seems not yet merged to next=2E Other code is based on thi=
s=2E

Am 10=2E September 2019 09:04:41 MESZ schrieb Frank Wunderlich <frank-w@pu=
blic-files=2Ede>:
>From: Josef Friedl <josef=2Efriedl@speed=2Eat>
>
>move code to separate header-file to reuse definitions later
>in poweroff-driver (drivers/power/reset/mt6323-poweroff=2Ec)
>
>Suggested-by: Frank Wunderlich <frank-w@public-files=2Ede>
>Signed-off-by: Josef Friedl <josef=2Efriedl@speed=2Eat>
>Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>Acked-by: Alexandre Belloni <alexandre=2Ebelloni@bootlin=2Ecom>
>Acked-for-MFD-by: Lee Jones <lee=2Ejones@linaro=2Eorg>
>---
>changes since v6: updated copyright
>changes since v5: none
>changes since v4: none
>changes since v3: none
>changes since v2: add missing commit-message
>---
> drivers/rtc/rtc-mt6397=2Ec       | 55 +-------------------------
> include/linux/mfd/mt6397/rtc=2Eh | 71 ++++++++++++++++++++++++++++++++++
> 2 files changed, 72 insertions(+), 54 deletions(-)
> create mode 100644 include/linux/mfd/mt6397/rtc=2Eh
>
>diff --git a/drivers/rtc/rtc-mt6397=2Ec b/drivers/rtc/rtc-mt6397=2Ec
>index b46ed4dc7015=2E=2Ec08ee5edf865 100644
>--- a/drivers/rtc/rtc-mt6397=2Ec
>+++ b/drivers/rtc/rtc-mt6397=2Ec
>@@ -9,60 +9,7 @@
> #include <linux/module=2Eh>
> #include <linux/regmap=2Eh>
> #include <linux/rtc=2Eh>
>-#include <linux/irqdomain=2Eh>
>-#include <linux/platform_device=2Eh>
>-#include <linux/of_address=2Eh>
>-#include <linux/of_irq=2Eh>
>-#include <linux/io=2Eh>
>-#include <linux/mfd/mt6397/core=2Eh>
>-
>-#define RTC_BBPU		0x0000
>-#define RTC_BBPU_CBUSY		BIT(6)
>-
>-#define RTC_WRTGR		0x003c
>-
>-#define RTC_IRQ_STA		0x0002
>-#define RTC_IRQ_STA_AL		BIT(0)
>-#define RTC_IRQ_STA_LP		BIT(3)
>-
>-#define RTC_IRQ_EN		0x0004
>-#define RTC_IRQ_EN_AL		BIT(0)
>-#define RTC_IRQ_EN_ONESHOT	BIT(2)
>-#define RTC_IRQ_EN_LP		BIT(3)
>-#define RTC_IRQ_EN_ONESHOT_AL	(RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
>-
>-#define RTC_AL_MASK		0x0008
>-#define RTC_AL_MASK_DOW		BIT(4)
>-
>-#define RTC_TC_SEC		0x000a
>-/* Min, Hour, Dom=2E=2E=2E register offset to RTC_TC_SEC */
>-#define RTC_OFFSET_SEC		0
>-#define RTC_OFFSET_MIN		1
>-#define RTC_OFFSET_HOUR		2
>-#define RTC_OFFSET_DOM		3
>-#define RTC_OFFSET_DOW		4
>-#define RTC_OFFSET_MTH		5
>-#define RTC_OFFSET_YEAR		6
>-#define RTC_OFFSET_COUNT	7
>-
>-#define RTC_AL_SEC		0x0018
>-
>-#define RTC_PDN2		0x002e
>-#define RTC_PDN2_PWRON_ALARM	BIT(4)
>-
>-#define RTC_MIN_YEAR		1968
>-#define RTC_BASE_YEAR		1900
>-#define RTC_NUM_YEARS		128
>-#define RTC_MIN_YEAR_OFFSET	(RTC_MIN_YEAR - RTC_BASE_YEAR)
>-
>-struct mt6397_rtc {
>-	struct device		*dev;
>-	struct rtc_device	*rtc_dev;
>-	struct mutex		lock;
>-	struct regmap		*regmap;
>-	int			irq;
>-	u32			addr_base;
>-};
>+#include <linux/mfd/mt6397/rtc=2Eh>
>=20
> static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
> {
>diff --git a/include/linux/mfd/mt6397/rtc=2Eh
>b/include/linux/mfd/mt6397/rtc=2Eh
>new file mode 100644
>index 000000000000=2E=2Ef84b9163c0ee
>--- /dev/null
>+++ b/include/linux/mfd/mt6397/rtc=2Eh
>@@ -0,0 +1,71 @@
>+/* SPDX-License-Identifier: GPL-2=2E0 */
>+/*
>+ * Copyright (C) 2014-2019 MediaTek Inc=2E
>+ *
>+ * Author: Tianping=2EFang <tianping=2Efang@mediatek=2Ecom>
>+ *        Sean Wang <sean=2Ewang@mediatek=2Ecom>
>+ */
>+
>+#ifndef _LINUX_MFD_MT6397_RTC_H_
>+#define _LINUX_MFD_MT6397_RTC_H_
>+
>+#include <linux/jiffies=2Eh>
>+#include <linux/mutex=2Eh>
>+#include <linux/regmap=2Eh>
>+#include <linux/rtc=2Eh>
>+
>+#define RTC_BBPU               0x0000
>+#define RTC_BBPU_CBUSY         BIT(6)
>+#define RTC_BBPU_KEY            (0x43 << 8)
>+
>+#define RTC_WRTGR              0x003c
>+
>+#define RTC_IRQ_STA            0x0002
>+#define RTC_IRQ_STA_AL         BIT(0)
>+#define RTC_IRQ_STA_LP         BIT(3)
>+
>+#define RTC_IRQ_EN             0x0004
>+#define RTC_IRQ_EN_AL          BIT(0)
>+#define RTC_IRQ_EN_ONESHOT     BIT(2)
>+#define RTC_IRQ_EN_LP          BIT(3)
>+#define RTC_IRQ_EN_ONESHOT_AL  (RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
>+
>+#define RTC_AL_MASK            0x0008
>+#define RTC_AL_MASK_DOW                BIT(4)
>+
>+#define RTC_TC_SEC             0x000a
>+/* Min, Hour, Dom=2E=2E=2E register offset to RTC_TC_SEC */
>+#define RTC_OFFSET_SEC         0
>+#define RTC_OFFSET_MIN         1
>+#define RTC_OFFSET_HOUR                2
>+#define RTC_OFFSET_DOM         3
>+#define RTC_OFFSET_DOW         4
>+#define RTC_OFFSET_MTH         5
>+#define RTC_OFFSET_YEAR                6
>+#define RTC_OFFSET_COUNT       7
>+
>+#define RTC_AL_SEC             0x0018
>+
>+#define RTC_PDN2               0x002e
>+#define RTC_PDN2_PWRON_ALARM   BIT(4)
>+
>+#define RTC_MIN_YEAR           1968
>+#define RTC_BASE_YEAR          1900
>+#define RTC_NUM_YEARS          128
>+#define RTC_MIN_YEAR_OFFSET    (RTC_MIN_YEAR - RTC_BASE_YEAR)
>+
>+#define MTK_RTC_POLL_DELAY_US  10
>+#define MTK_RTC_POLL_TIMEOUT   (jiffies_to_usecs(HZ))
>+
>+struct mt6397_rtc {
>+	struct device           *dev;
>+	struct rtc_device       *rtc_dev;
>+
>+	/* Protect register access from multiple tasks */
>+	struct mutex            lock;
>+	struct regmap           *regmap;
>+	int                     irq;
>+	u32                     addr_base;
>+};
>+
>+#endif /* _LINUX_MFD_MT6397_RTC_H_ */
