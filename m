Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86775E998
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 18:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfGCQt5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 12:49:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:34623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbfGCQtr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 12:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562172517;
        bh=FYPoJLHu+kLCtWhSyoQqK0wSUyhdckRPerDAqwIXB5c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=G0q81dSU2nsJt4KWWwdvJ6iuq4nItbX9Ao6DXDU4JL8k+46BUF3R64i4Zt9wsLoaG
         yIpw0I19Q+aqWIkWRAY/NXRoOcGNge72o11jAvKApMT5minRHDoU0nfpEvMVvFm9ZM
         DkkzexOvoZZwaQn74hfFkqAuX/MDtpAGTvJywUYU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.158.204]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MbAcs-1iFZHQ3reS-00bYLZ; Wed, 03 Jul 2019 18:48:37 +0200
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
Subject: [PATCH v2 5/7] power: reset: add driver for mt6323 poweroff
Date:   Wed,  3 Jul 2019 18:48:20 +0200
Message-Id: <20190703164822.17924-6-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703164822.17924-1-frank-w@public-files.de>
References: <20190703164822.17924-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:gdDgvKlW8Sm9gNmKtGMkuW55LkelpJPP0Pu8TtsWrmVdWT+06b9
 ODLkHjuVpbcK6QkjMouhOSatVh9X9w6QshI7F5VYBtF47336ITJHAgFaIeucSUHktwZZKKk
 7sRvhuVIUY224YacBdCOrHXPx2Zt+qJquchaohcZWqqBHXucVKlFFk8pX/ks2GwwZYHg7Gx
 zFLzyBEAcqT/cjCjVnnRQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hc+szzbz1YQ=:5qEd8DXbexZP8hpZ2owlA0
 e804rvNLdJZQNN5LOZxCaTFYroAXeDlijhgszblJlxaZxOSWMnvvUOkAkWOyg8h0ylmC0rrqw
 nLikIkNTGOyizTavLtnkjPKdl9HBe+8zz7YDe98s0oqJzluUmBOYahj4ck6rczWbrzxR9dm/G
 T88JbvkYZzubE4cyHnEx1I3OmAg+8a08MMJTyYiOlTLY5Zi0jaMfrkngdFj2m14VUJnSl3LF3
 W33aZCAWfJPflaP+MJeZgBjXMohvRAYViM4iO4ObdKwz9+JmCDERIkdCRO8SS+4W/Mg5Sr6QI
 4LM7ug6v4Hb/QKHg1mipCLSu2XsjaKNx91jVR7OL0+xtrfJI6JfaUEynHQPCdNGeRhg7kkp1w
 JB4dRTPd9eJELcX25Of2/vootDeXmxlJbZFeE7zSHZ3U70GZxZIPt9CbRMCim/P52C5bzSX0x
 zZ/W1SJxPUVRlK+47vQwv5hAU3BZLpO4FLpoBTcXuZ35BC49/FNN4r+GMEdNfP9ZFGKPhhrPS
 CitKx9IiBWBL4m2UMt1wQTx4zwLg8sKoTpgR7LPFyKZaiRNxJTR9jMM+wqpbf8siaulITxNfJ
 Wrxiw/8kQOhmMrG6RsNS2J7LO3GL2eonqB8yLkww75yIF4FychaUWMR7gvlp/l6Ivtv2uWOhF
 PDHFwrsNWFyJiAc5Lo7I9ey8sEJM6MFXFuj1cfq8o+NQoI3ngzB5KDtB4hHCXaHVXdqJYAY1I
 VQCK27aUau373AgKJ8rIVE5wn39nG8llq0b47Nk0RpgNyZy94Opp5ZmtjgWFd296Wa3j1IIaz
 Eg2lAXr1TPuQMeHKxjd2VfaE66sCiz0AkYdXIQuBXdm0Aux/C+BHlNvI5S5KE3aioZY/Hc4aH
 nXR0YBHMfFbKzqRrSMaPxJFwvi5vBUEKgDQoWNpukZJbftx9hp2QIQXBV0BX6p/u5WbAdRuLY
 XsIjjSPXGfcHLtJ+wBskFws2q6nwE31keunV1/iClZL2HaZxJnz38Qz9jWyCR/uJbxDuyfgRy
 maUUzL71yMrvwIqbqeTwKrU2q1MB8aSqbz8Hk+CZaY4iVrF9tYFsgn6Yd6enlaQpHQr5NYiwm
 mdKsQqhVLCLcB4=
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
 drivers/power/reset/Kconfig           | 10 +++
 drivers/power/reset/Makefile          |  1 +
 drivers/power/reset/mt6323-poweroff.c | 97 +++++++++++++++++++++++++++
 include/linux/mfd/mt6397/core.h       |  2 +
 4 files changed, 110 insertions(+)
 create mode 100644 drivers/power/reset/mt6323-poweroff.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 980951dff834..492678e22088 100644
=2D-- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -140,6 +140,16 @@ config POWER_RESET_LTC2952
 	  This driver supports an external powerdown trigger and board power
 	  down via the LTC2952. Bindings are made in the device tree.

+config POWER_RESET_MT6323
+       bool "MediaTek MT6323 power-off driver"
+       depends on MFD_MT6397
+       help
+         The power-off driver is responsible for externally shutdown down
+         the power of a remote MediaTek SoC MT6323 is connected to throug=
h
+         controlling a tiny circuit BBPU inside MT6323 RTC.
+
+         Say Y if you have a board where MT6323 could be found.
+
 config POWER_RESET_QNAP
 	bool "QNAP power-off driver"
 	depends on OF_GPIO && PLAT_ORION
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 0aebee954ac1..94eaceb01d66 100644
=2D-- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_POWER_RESET_GPIO) +=3D gpio-poweroff.o
 obj-$(CONFIG_POWER_RESET_GPIO_RESTART) +=3D gpio-restart.o
 obj-$(CONFIG_POWER_RESET_HISI) +=3D hisi-reboot.o
 obj-$(CONFIG_POWER_RESET_MSM) +=3D msm-poweroff.o
+obj-$(CONFIG_POWER_RESET_MT6323) +=3D mt6323-poweroff.o
 obj-$(CONFIG_POWER_RESET_QCOM_PON) +=3D qcom-pon.o
 obj-$(CONFIG_POWER_RESET_OCELOT_RESET) +=3D ocelot-reset.o
 obj-$(CONFIG_POWER_RESET_PIIX4_POWEROFF) +=3D piix4-poweroff.o
diff --git a/drivers/power/reset/mt6323-poweroff.c b/drivers/power/reset/m=
t6323-poweroff.c
new file mode 100644
index 000000000000..1caf43d9e46d
=2D-- /dev/null
+++ b/drivers/power/reset/mt6323-poweroff.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Power off through MediaTek PMIC
+ *
+ * Copyright (C) 2018 MediaTek Inc.
+ *
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/mt6397/core.h>
+#include <linux/mfd/mt6397/rtc.h>
+
+struct mt6323_pwrc {
+	struct device *dev;
+	struct regmap *regmap;
+	u32 base;
+};
+
+static struct mt6323_pwrc *mt_pwrc;
+
+static void mt6323_do_pwroff(void)
+{
+	struct mt6323_pwrc *pwrc =3D mt_pwrc;
+	unsigned int val;
+	int ret;
+
+	regmap_write(pwrc->regmap, pwrc->base + RTC_BBPU, RTC_BBPU_KEY);
+	regmap_write(pwrc->regmap, pwrc->base + RTC_WRTGR, 1);
+
+	ret =3D regmap_read_poll_timeout(pwrc->regmap,
+					pwrc->base + RTC_BBPU, val,
+					!(val & RTC_BBPU_CBUSY),
+					MTK_RTC_POLL_DELAY_US,
+					MTK_RTC_POLL_TIMEOUT);
+	if (ret)
+		dev_err(pwrc->dev, "failed to write BBPU: %d\n", ret);
+
+	/* Wait some time until system down, otherwise, notice with a warn */
+	mdelay(1000);
+
+	WARN_ONCE(1, "Unable to power off system\n");
+}
+
+static int mt6323_pwrc_probe(struct platform_device *pdev)
+{
+	struct mt6397_chip *mt6397_chip =3D dev_get_drvdata(pdev->dev.parent);
+	struct mt6323_pwrc *pwrc;
+	struct resource *res;
+
+	pwrc =3D devm_kzalloc(&pdev->dev, sizeof(*pwrc), GFP_KERNEL);
+	if (!pwrc)
+		return -ENOMEM;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pwrc->base =3D res->start;
+	pwrc->regmap =3D mt6397_chip->regmap;
+	pwrc->dev =3D &pdev->dev;
+	mt_pwrc =3D pwrc;
+
+	pm_power_off =3D &mt6323_do_pwroff;
+
+	return 0;
+}
+
+static int mt6323_pwrc_remove(struct platform_device *pdev)
+{
+	if (pm_power_off =3D=3D &mt6323_do_pwroff)
+		pm_power_off =3D NULL;
+
+	return 0;
+}
+
+static const struct of_device_id mt6323_pwrc_dt_match[] =3D {
+	{ .compatible =3D "mediatek,mt6323-pwrc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mt6323_pwrc_dt_match);
+
+static struct platform_driver mt6323_pwrc_driver =3D {
+	.probe          =3D mt6323_pwrc_probe,
+	.remove         =3D mt6323_pwrc_remove,
+	.driver         =3D {
+		.name   =3D "mt6323-pwrc",
+		.of_match_table =3D mt6323_pwrc_dt_match,
+	},
+};
+
+module_platform_driver(mt6323_pwrc_driver);
+
+MODULE_DESCRIPTION("Poweroff driver for MT6323 PMIC");
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/mt6397/core.h b/include/linux/mfd/mt6397/co=
re.h
index 25a95e72179b..652da61e3711 100644
=2D-- a/include/linux/mfd/mt6397/core.h
+++ b/include/linux/mfd/mt6397/core.h
@@ -7,6 +7,8 @@
 #ifndef __MFD_MT6397_CORE_H__
 #define __MFD_MT6397_CORE_H__

+#include <linux/mutex.h>
+
 enum mt6397_irq_numbers {
 	MT6397_IRQ_SPKL_AB =3D 0,
 	MT6397_IRQ_SPKR_AB,
=2D-
2.17.1

