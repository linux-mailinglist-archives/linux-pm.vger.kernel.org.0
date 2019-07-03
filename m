Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC245E98C
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 18:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfGCQtn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 12:49:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:48097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfGCQtl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 12:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562172514;
        bh=/9xBDfa8MmyCEGy9lts4eV0fUCDWP2vWjFBrUMAHZIw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=NJL6u9vCVUAcj0aiV9JL+ahQq/Z3X+rRu6afSaN6dMYm+Evbul46DCtz365/Naq2f
         RSTEGdTVeueXpiveIakMux/69G0mtdqLpPiDN3f+KIueDJAgt0jB0lZ8ej6mdwiwDD
         9bB2mbSEgwKIQ4a0M/fu/pfntvqwrENfhrz9JTj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.158.204]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M42jK-1hiiQr3zXc-0001fV; Wed, 03 Jul 2019 18:48:34 +0200
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
Subject: [PATCH v2 2/7] rtc: mt6397: move some common definitions into rtc.h
Date:   Wed,  3 Jul 2019 18:48:17 +0200
Message-Id: <20190703164822.17924-3-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703164822.17924-1-frank-w@public-files.de>
References: <20190703164822.17924-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:eNTAGak/khtebF18hP1o00uJHTFlKw0xrt738upulxWk1z31acU
 PoB2U9jBsL3a67ozQdB+gG5Tq5CJQPDRj0dNh3mKEH1ReCjxe96SLWjYx9mEeCzDeIYs1eE
 BYo7WMGYd5CUSfhSLvOqR02xzohVYND0/oRHlhR7xCxaVLxuHJxze47sRzK2taMUN5K6QHZ
 IPFfX9BTpN8nR4lpP3t7A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hrXaNRx2yJU=:n8xY8hWfUEOQNncyM2MDfb
 hgyC4lTVSopY06MROwkDrLATI7KOf4BREy8UbjkvevcUbP4bo5sS3X0ccBpwv+LSxbLvv2bT6
 ttpL9s26RLDTYq8XPNI+DfEz7fk1JIYwyXVfjrahDo9t1gymXebc8+AL1yiURT7SSPQkPa6Om
 8jweZxjKExbRyKfcakJOQvSXiI2DzhVePFsHbb0NpOEaLjVHCHnUvoghqrbAhc5TBDMYk507J
 3aT6AJSgAJYTEbLRUCmEWBoyZ7bG5BCi1UBDegmje2IxGOOLPndIrZ2M1qioBdm2K5RU1v1Ta
 II8QrtGmItpLyoOIciLHCgn+6gZ0r7zBAM94DjgmIFZRPvOq2uxzUNJ0+JPlN65XF0wkSRbKm
 wStGGr9H6EF7GdUlejbBJ28BX0apwmU/ZlH0kR2nGczm4sp08ZQgEV7dv8d9N4kDu9J2+r6xv
 PZaqWYe32TkeI+lAoQqVhDKzr8i5lKPWTgFcn94Rnr3FaoiNE6VPHupq7vpXHGhef5CwwHVK9
 j+uBjgyExZ1pBjLO6X9rx3KW5j1FiCE6GHSKtZt7wz5feqYEV8pd5ohXSqiBanx+hbVH7byQG
 ua39EHS9jirtv1JtXBFl1QW8JO5Ui4KxuMElsaYCeHwdV00Mt/D1wj0aXg6zocC+zwerw5uJ5
 djRwYqlIyr91G7i1qRFAP2KDvPX42lK1LWpXXICoyT3onns0k302e1vFS+PxlDzC9VMn2kLci
 aASSswHtFmYPuFBbGQE417bNLH8vXTPQR+nlCzqING608uUxya3ZCRlZKY53FI2jjC6tI/oiD
 0UGtZyTCaK5x5ftWGdUWavLNF8rB8RnJDxVTm3jyne4C7mNDJ+AyDIb1orvJw0Bbb8aZUopFo
 2MTz+ca155ddzmrY6Tt9lOqy3xNc23yrzbBEt4ERl1lodvnfJgNTmhhi3dgD6XspcD9fZEpNA
 RHRxfcrtVMGMXiuVkzDwhND9BsB2vtj5EoX3YcG0k3vlg0iL66fApiWnXBIkKFyKWUr/pciph
 ayZcEgOAUcqfyrLmvtHT2OotSl4rfNSzdwjgu0Zs7bk+R6tPNt3kCSrSF2z9UmgHLM/l9r6p2
 vYvFnzLNIXh0Nc=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

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

