Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CECA179257
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 19:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbfG2RnK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 13:43:10 -0400
Received: from mout.gmx.net ([212.227.15.15]:56223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387731AbfG2RnJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 13:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564422139;
        bh=qNdMiiXHqllRvqvxDwWTThTceo0oHJHWqFHI79Z6uC8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GBIaAupzyNnDjehhzBxXQlAtnvmvRetwsmvNU6hZAYY37mWDMtTYVAmHC0bJTfPIU
         xQHRMiA/p7l9p08hMHzEKDQgl2EGfqI0Kip/Pt2EJ0E03fcSNHHBDTSqZcA/V6nr15
         TtDtNS9mYBg2RhKtHSvcKbXREbz0X9+ryj3dy4WE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([185.76.97.79]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LcBBl-1iHH8I0Kgf-00jbCk; Mon, 29 Jul 2019 19:42:19 +0200
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
Subject: [PATCH v3 03/10] rtc: mt6397: move some common definitions into rtc.h
Date:   Mon, 29 Jul 2019 19:41:47 +0200
Message-Id: <20190729174154.4335-4-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729174154.4335-1-frank-w@public-files.de>
References: <20190729174154.4335-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:XMa6wxfWSzWhCnhua7hhr4idtdRPBvgDLLK/YtTTdVfl1qoX8wl
 nSZvPJN/Hz34E1qkJ9ecCx0LqvE2em5TN9ckoWjWC9xjhe1pjBdWJiMVGwdnEIHRER0u/lY
 FflhsGfQJMmG8GmYpmRAEJIQa05wM/HQeuz9/42jRd1sXYLGQcJagMbf6XB+mmC9JGV3tJj
 TPcqAONrKZLzGtATWXWuA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QAvRqiJU4jM=:xDnSThfWgdB88F7tPxg7ya
 WJuc44gAo+tnUznHS4QV/Cfztl/kQxlDeQ2pc/rprS2swyy2QUVvFzbhh/5pjiq8eT9MeH1Je
 H+r+M0uT3ti6rm2mxMBNQtrFahGA2bZ6b4jdNut2yXm6v2KycNgYdwAG3jpzQuwnjV8RozZ+o
 6Nn+zUpfB/uSBZF64DQuHcm6PP8eIoMsOMqC/gYB2I7/Gxz5Th8q3P66Yr/1SOf4zLmWmo0Kj
 L+a70jAQ6DnnmG1nS0sFxNtKpVSO/p41X34/35t0uhVWPzHXH1h0Wuo+5PYKApRJ5i4eLXZq5
 u2Q/hekxypcsRXPKZ+GrnfvsZacTcyzbTKYAQm7zLyZh7ZGzXdZeM2/HHb7uwLdxkXyKL3A3I
 VdoMkHNdaIwLx/2A07VYC3cVv74X1/Sk4/cNASyUw6XNICPu09D1BXgI+gr1NL7sjrAX9G/r9
 GCPbAzBGqesm7tW7iaOLomYY/QtgZBg40gXAxY5fyCrEgGqifIHYY93kprsjZiBrQTd/cTz7P
 UuCoEHtJIjcZn5We3Pc2HsAZ2H221NaAnycRmqc273I/iXZy72+f0ltu8JQpdi8BvoPf+0lS5
 H4ZSGB4suqwi8U3elxDCZegCN27CVtyWCi5G3KUUXj2BLLNHKmJEcq8ooPgNKHXoC4py0kwlY
 mIIezfcbkeAOU6Ceg4qOttYtMMkimHrf+aYFaJ/Glffu6Cam50Rgm4y0V58IHCI7ljX74EYeW
 GDBarHs/7RyyEQ2KeceKTl7SoMVee3gr76TahVpmvFiPOo9aABmbJxVZyJQpQ4vhWZw20SEJv
 TU4Uv8N0B11bgZFRuwCwx4gUpdXt9I2v9tGO78quBn0LUlni5JoWpCJ9lRCnEft8CD4+S3wXH
 R8uf2GrHb9Rv0kWvNKevOvrjjMXw+Qltc/xu0X1RKwxusaujPERI+Z6/tG5Rgt96UEvNNF9cU
 DCDzrCY69UHqpM2YYVJQdlU9aoIn6gD9+SP8/8MRIfqOSLztiaqh5jRXC492nQF8EnHl0SEXF
 /QzgXErVLx9/VY/IMrRPVZMpZyGI6+jL/yM8bJPZuK2dbMHU9G95dV/9oI/ZSuR2L3KggCcei
 YBVe5BDpqUP9dk=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

move code to separate header-file to reuse definitions later
in poweroff-driver (drivers/power/reset/mt6323-poweroff.c)

changes since v2: add missing commit-message

Suggested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 drivers/rtc/rtc-mt6397.c       | 55 +-------------------------
 include/linux/mfd/mt6397/rtc.h | 71 ++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 54 deletions(-)
 create mode 100644 include/linux/mfd/mt6397/rtc.h

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index b46ed4dc7015..c08ee5edf865 100644
=2D-- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -9,60 +9,7 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
-#include <linux/irqdomain.h>
-#include <linux/platform_device.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/io.h>
-#include <linux/mfd/mt6397/core.h>
-
-#define RTC_BBPU		0x0000
-#define RTC_BBPU_CBUSY		BIT(6)
-
-#define RTC_WRTGR		0x003c
-
-#define RTC_IRQ_STA		0x0002
-#define RTC_IRQ_STA_AL		BIT(0)
-#define RTC_IRQ_STA_LP		BIT(3)
-
-#define RTC_IRQ_EN		0x0004
-#define RTC_IRQ_EN_AL		BIT(0)
-#define RTC_IRQ_EN_ONESHOT	BIT(2)
-#define RTC_IRQ_EN_LP		BIT(3)
-#define RTC_IRQ_EN_ONESHOT_AL	(RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
-
-#define RTC_AL_MASK		0x0008
-#define RTC_AL_MASK_DOW		BIT(4)
-
-#define RTC_TC_SEC		0x000a
-/* Min, Hour, Dom... register offset to RTC_TC_SEC */
-#define RTC_OFFSET_SEC		0
-#define RTC_OFFSET_MIN		1
-#define RTC_OFFSET_HOUR		2
-#define RTC_OFFSET_DOM		3
-#define RTC_OFFSET_DOW		4
-#define RTC_OFFSET_MTH		5
-#define RTC_OFFSET_YEAR		6
-#define RTC_OFFSET_COUNT	7
-
-#define RTC_AL_SEC		0x0018
-
-#define RTC_PDN2		0x002e
-#define RTC_PDN2_PWRON_ALARM	BIT(4)
-
-#define RTC_MIN_YEAR		1968
-#define RTC_BASE_YEAR		1900
-#define RTC_NUM_YEARS		128
-#define RTC_MIN_YEAR_OFFSET	(RTC_MIN_YEAR - RTC_BASE_YEAR)
-
-struct mt6397_rtc {
-	struct device		*dev;
-	struct rtc_device	*rtc_dev;
-	struct mutex		lock;
-	struct regmap		*regmap;
-	int			irq;
-	u32			addr_base;
-};
+#include <linux/mfd/mt6397/rtc.h>

 static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
 {
diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rtc=
.h
new file mode 100644
index 000000000000..b702c29e8c74
=2D-- /dev/null
+++ b/include/linux/mfd/mt6397/rtc.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2014-2018 MediaTek Inc.
+ *
+ * Author: Tianping.Fang <tianping.fang@mediatek.com>
+ *        Sean Wang <sean.wang@mediatek.com>
+ */
+
+#ifndef _LINUX_MFD_MT6397_RTC_H_
+#define _LINUX_MFD_MT6397_RTC_H_
+
+#include <linux/jiffies.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/rtc.h>
+
+#define RTC_BBPU               0x0000
+#define RTC_BBPU_CBUSY         BIT(6)
+#define RTC_BBPU_KEY            (0x43 << 8)
+
+#define RTC_WRTGR              0x003c
+
+#define RTC_IRQ_STA            0x0002
+#define RTC_IRQ_STA_AL         BIT(0)
+#define RTC_IRQ_STA_LP         BIT(3)
+
+#define RTC_IRQ_EN             0x0004
+#define RTC_IRQ_EN_AL          BIT(0)
+#define RTC_IRQ_EN_ONESHOT     BIT(2)
+#define RTC_IRQ_EN_LP          BIT(3)
+#define RTC_IRQ_EN_ONESHOT_AL  (RTC_IRQ_EN_ONESHOT | RTC_IRQ_EN_AL)
+
+#define RTC_AL_MASK            0x0008
+#define RTC_AL_MASK_DOW                BIT(4)
+
+#define RTC_TC_SEC             0x000a
+/* Min, Hour, Dom... register offset to RTC_TC_SEC */
+#define RTC_OFFSET_SEC         0
+#define RTC_OFFSET_MIN         1
+#define RTC_OFFSET_HOUR                2
+#define RTC_OFFSET_DOM         3
+#define RTC_OFFSET_DOW         4
+#define RTC_OFFSET_MTH         5
+#define RTC_OFFSET_YEAR                6
+#define RTC_OFFSET_COUNT       7
+
+#define RTC_AL_SEC             0x0018
+
+#define RTC_PDN2               0x002e
+#define RTC_PDN2_PWRON_ALARM   BIT(4)
+
+#define RTC_MIN_YEAR           1968
+#define RTC_BASE_YEAR          1900
+#define RTC_NUM_YEARS          128
+#define RTC_MIN_YEAR_OFFSET    (RTC_MIN_YEAR - RTC_BASE_YEAR)
+
+#define MTK_RTC_POLL_DELAY_US  10
+#define MTK_RTC_POLL_TIMEOUT   (jiffies_to_usecs(HZ))
+
+struct mt6397_rtc {
+	struct device           *dev;
+	struct rtc_device       *rtc_dev;
+
+	/* Protect register access from multiple tasks */
+	struct mutex            lock;
+	struct regmap           *regmap;
+	int                     irq;
+	u32                     addr_base;
+};
+
+#endif /* _LINUX_MFD_MT6397_RTC_H_ */
=2D-
2.17.1

