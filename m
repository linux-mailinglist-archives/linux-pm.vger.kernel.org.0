Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57F2C12FB8A
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 18:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgACRYs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jan 2020 12:24:48 -0500
Received: from mout.gmx.net ([212.227.17.22]:33617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgACRYs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Jan 2020 12:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578072274;
        bh=r09Xj+78lYwDfvj01i5hNYjP7fkU9rpgonPkcnvu9JM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=e1YwBqwIUc9ivQMXB5REV187qxtJqWPCci+0c1R8vTyVfrzVKRcJyqOXd4WDcYSQY
         mDhxvFhAjwYP5NCCvuadYPql8gGG83Djsu6AnvxlUwk27EwfeAe11Ubp0oWIcR0GPI
         iwG5I0Xu/pevzld13w6J56ECm1UW8qHhnjNQY/p4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.154]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MYeR1-1jHHkI3uVf-00Vjmh; Fri, 03 Jan 2020 18:24:34 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 2/4] thermal: Add BCM2711 thermal driver
Date:   Fri,  3 Jan 2020 18:23:54 +0100
Message-Id: <1578072236-31820-3-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578072236-31820-1-git-send-email-wahrenst@gmx.net>
References: <1578072236-31820-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:6ePOyJUrk5JV2zTq4BfKQAKGAA0YxTo9xsTJFdzdoWQAz8BBFnF
 nqMhCq7DhXM4/ZlN0bW9fs4HMf8A2f7M6UB9omliavyfYQFmIPEDm4dALM9IELPKuv7KzE3
 BtnN/6iQuO6aHCRXQLK9UCEj0vK4WIsPRfmYYwzORcTWc+36vYVwdWqpWe72yyBM7+i4vrZ
 bGntXCfkbo1q0hJKhzWXA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vu0uosQJcvE=:7eCosITtZG9uOitnLMPvAA
 1h2zzLW+qqRR+OwREWel6+wP/1N5pJoTcaORJ4wGArLgeI3TGo0k30xbN5snoDZfIMGQehJfK
 okT89NttTsgAN1ug6+ZS3/3S1c+dyEfbKZcAbrC/P9NTvhAwXfAtR5+dvYLJbmvBEQu5kWkoh
 ZxPIrijmLt6mPO6VrXfCr0LcWTStXacJxGyvpP00Z5er/GGeIGWKkUtwQ6H5o+5yDRqKXtQRI
 V0rBRbHPkihP7JuG4TGj1B949y8ZhgwwOL5GRKkKt33UdLUTK9UJUZxUJgG5yxQgiO6mIX9Dv
 KQtKs0BjRQ2/NEhjeL9PjS7bqDwurk4ROamO1ENP9PFZ55aK4wqA8OqvWfq0NUWiMgw5ZD42O
 YeO9ULNWe810jUWJjRFqNIXkuvxgJmtzULTtrOIj1id4OvFfx9/7+fmaxe50aDAddfw0cc6hx
 KLjqTH8XMQg0v8czGwWaLWrf8u/vidRsDolTngXf3ieYXCs4k4ngfpwHWE9wjTwAw6kIdzeHQ
 1DQirkV03pHuO9bJiroo5h5eugLZ52thOukzqIH8kGSJedppIRH6or0dysLGHKbL0CAWYZSai
 Xe0SUDchrD3Bo+mVXlXMF6+cLQdmAwd2vEaQWo4DSz1YEa1XPeaNxepQy6cIW62RxWxF3IRCS
 1QQintREEUomOrojsUjxU1GRiBY1cF0fdkG5V1v1dX1UH+RC8Yxt7lWYZftdCI5a1utVbugfD
 Nfi0ZrX2JOzTk2Kk+r4r2f16tvgTZxa6WZzzoCN2HnCMMkwXxRuZdgK99tuyqv+vG84q5pJhT
 gYDrZqGErb2Kt7tIYSfQQowNrJdXt2xFTLpn3voo85mDjzih7+XrZpDGqT4F5ucOiYKzd+044
 sK1K0jt7Y1nFOkfRwcCMVkg25A0BJs4nFU8Eb2u3OG/C7v1fs39b7dSqfT3tGj2aAAwvYZRdu
 EvG5LPwLG7Zvn+jGRKrGbERylVmKSRiu1f1essi9wsVNgDpNZIFY6g9a3/d8ylPapogkr5D46
 nS/Skw7iUpC/TKuvL338tjHDAE2Elqsu/3f60w7ez4o/71Z65MCj3G5gSg3Icr/DqNK/j3tse
 v/7XWunqoEQQpnfN9WKsxrZolpiGhy6gIibXg0NiQG4GzqvOeuh7U0yBmH2GSjQIpbE8XHh5W
 3BN/7Tuiur6mgtjc6j8n6mwyQxTWnGmlaQGY8XVpg/JYDHdB26EAoQRKbflYOojXAYBw5S8Rm
 r+dAfPxGxhLCYxfjQwqCNVce0b7K4Qo2Y9bgzXg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds the thermal sensor driver for the Broadcom BCM2711 SoC,
which is placed on the Raspberry Pi 4. The driver only provides
SoC temperature reading so far.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/thermal/broadcom/Kconfig           |   7 ++
 drivers/thermal/broadcom/Makefile          |   1 +
 drivers/thermal/broadcom/bcm2711_thermal.c | 129 ++++++++++++++++++++++++=
+++++
 3 files changed, 137 insertions(+)
 create mode 100644 drivers/thermal/broadcom/bcm2711_thermal.c

diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/K=
config
index cf43e15..061f1db 100644
=2D-- a/drivers/thermal/broadcom/Kconfig
+++ b/drivers/thermal/broadcom/Kconfig
@@ -1,4 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config BCM2711_THERMAL
+	tristate "Broadcom AVS RO thermal sensor driver"
+	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on THERMAL_OF && MFD_SYSCON
+	help
+	  Support for thermal sensors on Broadcom BCM2711 SoCs.
+
 config BCM2835_THERMAL
 	tristate "Thermal sensors on bcm2835 SoC"
 	depends on ARCH_BCM2835 || COMPILE_TEST
diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom/=
Makefile
index 490ab1f..c917b24 100644
=2D-- a/drivers/thermal/broadcom/Makefile
+++ b/drivers/thermal/broadcom/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_BCM2711_THERMAL)		+=3D bcm2711_thermal.o
 obj-$(CONFIG_BCM2835_THERMAL)		+=3D bcm2835_thermal.o
 obj-$(CONFIG_BRCMSTB_THERMAL)		+=3D brcmstb_thermal.o
 obj-$(CONFIG_BCM_NS_THERMAL)		+=3D ns-thermal.o
diff --git a/drivers/thermal/broadcom/bcm2711_thermal.c b/drivers/thermal/=
broadcom/bcm2711_thermal.c
new file mode 100644
index 0000000..1d55b87
=2D-- /dev/null
+++ b/drivers/thermal/broadcom/bcm2711_thermal.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Broadcom AVS RO thermal sensor driver
+ *
+ * based on brcmstb_thermal
+ *
+ * Copyright (C) 2020 Stefan Wahren
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/thermal.h>
+
+#include "../thermal_hwmon.h"
+
+#define AVS_RO_TEMP_STATUS		0x200
+ #define AVS_RO_TEMP_STATUS_valid_msk	(BIT(16) | BIT(10))
+ #define AVS_RO_TEMP_STATUS_data_msk	GENMASK(9, 0)
+
+struct bcm2711_thermal_priv {
+	struct regmap *regmap;
+	struct device *dev;
+	struct thermal_zone_device *thermal;
+};
+
+static int bcm2711_get_temp(void *data, int *temp)
+{
+	struct bcm2711_thermal_priv *priv =3D data;
+	int slope =3D thermal_zone_get_slope(priv->thermal);
+	int offset =3D thermal_zone_get_offset(priv->thermal);
+	u32 val;
+	int ret;
+	long t;
+
+	ret =3D regmap_read(priv->regmap, AVS_RO_TEMP_STATUS, &val);
+	if (ret)
+		return ret;
+
+	if (!(val & AVS_RO_TEMP_STATUS_valid_msk)) {
+		dev_err(priv->dev, "reading not valid\n");
+		return -EIO;
+	}
+
+	val &=3D AVS_RO_TEMP_STATUS_data_msk;
+
+	/* Convert a HW code to a temperature reading (millidegree celsius) */
+	t =3D slope * val + offset;
+	if (t < 0)
+		*temp =3D 0;
+	else
+		*temp =3D t;
+
+	return 0;
+}
+
+static const struct thermal_zone_of_device_ops bcm2711_thermal_of_ops =3D=
 {
+	.get_temp	=3D bcm2711_get_temp,
+};
+
+static const struct of_device_id bcm2711_thermal_id_table[] =3D {
+	{ .compatible =3D "brcm,bcm2711-thermal" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bcm2711_thermal_id_table);
+
+static int bcm2711_thermal_probe(struct platform_device *pdev)
+{
+	struct thermal_zone_device *thermal;
+	struct bcm2711_thermal_priv *priv;
+	struct device *dev =3D &pdev->dev;
+	struct device_node *parent;
+	struct regmap *regmap;
+	int ret;
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* get regmap from syscon node */
+	parent =3D of_get_parent(dev->of_node); /* parent should be syscon node =
*/
+	regmap =3D syscon_node_to_regmap(parent);
+	of_node_put(parent);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "failed to get regmap (error %ld)\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+	priv->regmap =3D regmap;
+	priv->dev =3D dev;
+
+	thermal =3D devm_thermal_zone_of_sensor_register(dev, 0, priv,
+						       &bcm2711_thermal_of_ops);
+	if (IS_ERR(thermal)) {
+		ret =3D PTR_ERR(thermal);
+		dev_err(dev, "could not register sensor: %d\n", ret);
+		return ret;
+	}
+
+	priv->thermal =3D thermal;
+
+	thermal->tzp->no_hwmon =3D false;
+	ret =3D thermal_add_hwmon_sysfs(thermal);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static struct platform_driver bcm2711_thermal_driver =3D {
+	.probe =3D bcm2711_thermal_probe,
+	.driver =3D {
+		.name =3D "bcm2711_thermal",
+		.of_match_table =3D bcm2711_thermal_id_table,
+	},
+};
+module_platform_driver(bcm2711_thermal_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Stefan Wahren");
+MODULE_DESCRIPTION("Broadcom AVS RO thermal sensor driver");
=2D-
2.7.4

