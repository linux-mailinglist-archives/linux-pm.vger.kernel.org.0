Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6494E132E2B
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 19:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgAGSQX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 13:16:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:58353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728430AbgAGSQX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Jan 2020 13:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578420965;
        bh=4mbXLn8R9HTqHSqjDYTVnf33y1TLbPgq1QZsQUXuORI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JbSBDGbsT0C/YiJLKHHclDX+IekngU601r/NZUXbm7pEwIYsEG9Fpom2kM2knFKu6
         P8bgl9yGKGMF3bKRLNYwPzCNgXdBIDyzI8MsZOrBpZG4jgG62ofrIuBWMuCDJ2if7S
         9nt5L4RoIxNX7cPNA8tE7jX2d15dzT534YUlWCzQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.154]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M7sDg-1il3eJ1VuE-0053xL; Tue, 07 Jan 2020 19:16:05 +0100
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
Subject: [PATCH V3 2/4] thermal: Add BCM2711 thermal driver
Date:   Tue,  7 Jan 2020 19:15:55 +0100
Message-Id: <1578420957-32229-3-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578420957-32229-1-git-send-email-wahrenst@gmx.net>
References: <1578420957-32229-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:yFvB7JDgtfyjUut8k1Chkrb/ErSVsg3EvQyWqLPXb8cBJL7dcQK
 dsv56Ee8bmn70zRFQcp+ZxoKnJOLsQX8yr4SSStLpZInOQB1eFljwNlqO1yvOMTchBW9aNV
 8K/3K5y1XYvkIucOrqA4mcg/Abn6C2HRj+YX30kIzWXSZJYVPfGO7BlReGxXXeOS3RN/0+v
 AxjdzIeF7ITk0B2E8IlXg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jTzlGkSo9bo=:dlU7pPc0rf9QUy9ZULoDP9
 8GSLL1VdjzaySpcK+jGdXJmnrTtTdrwOVCM13Yj+OFiXY9BhB02v3Y1/GACb0zByQF6m5R+HY
 E9rP1h/ZotZ106drpf22Cq8qEcdAIN5naIaEYooguO0tmeziCzo2zdEeRvJQpiw0XPxJzNMRM
 6r/2TRXgeXb53bBysAa4tCjXgXGwqtbF0WKTAsWBjogBF/6lwK2AgGFC8X4mY7XOv8GZOq+EO
 eCr92WcgDG5MIwJF7G+Q/SWbTCV+S7Fs8D52Iy3YYtdNKYJa8Mq2PmZs+zx2feLAmwfSxGctw
 EuEMw9cv1bA2tVzuUn7GiFQYGlJpxGvvCrxvU6F99yw9ECI3c3zIOHKmsXPlWMBQo9AuD/0rF
 P//MLHaS7rzJds2En+JKdP/bAR2XxC/qCtHnF7VIxMkbrXUU69CYWVTAz5gaxFv5CtBY5kqmi
 /AkDqAJimergmP6IIVtmEpgO5aE2KcbFFWtqt8e+OshhR/JDJ6JP8+kZUnbV9e0nY2cUJQqeT
 n30n/BPVfHDvMlXeHpI//Eo90SBCEVY9BRd90Q/9tmyRckXcLt+mK9USdZAkyrq7X+eXNlB2b
 QPHkn7XPbEso/0K2GzZCEO+kh5IKoYf4o53VM++6q7SDY48oU7MGG29P36RlK40W4wxgYcnbQ
 G6ofOpVasFvQlsfoWZAy3tMP3h7pzSXTMzfb+oBl+20O/5R32GpSWt/jO/Rfhyk+Ho+MGiQwA
 TqHZK+xG6BWesd9jIKv+A0n/NnxbHfylDpSRa0x4Al27WH1GQcN70HE+B91a58+3NmNd8cl1u
 nR++5B6h+UhxHjwY3mJFn6JaJE9tzHZYUcYYH6JeUq03cFXZC9Fxdns96ofekPi24KiO9T49q
 byceV+B8w4shzosvTwbuExqTP6JvIQU0VGVNzFhWlFvoMardYHn0PWKlIy16TPVaRXEL7yl2U
 +TRzGy2pXi4g1TkFMGGmRU17UYWsREIKw3+RqOSuq8riGSWZrUgVbk2wJLp/0kS4pLMUzaF/a
 QMemNPTBJfdX15J9IiNHnOMDGmEdpRucbFs9HYRn4HhWDMl1TskP5nyUiG8p+7ET3PLjS+r4K
 IFzT7g2tghwbdcDkMOjwK1CFXVblw2fUa5gjZoLCAb+psUornL0pyskLONpUQDgX+FONMdu5C
 gXIa+nu2CgDmi+mxoDIx4hSim5yfx1eGeryexRr5UiX4wdT0jXDx3nyfK+z9DTgBbIwY0D0qM
 gN5jbjyZRfDrlBl1cMJHAWyDEdL42xvNhWkeV0Q==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This adds the thermal sensor driver for the Broadcom BCM2711 SoC,
which is placed on the Raspberry Pi 4. The driver only provides
SoC temperature reading so far.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
index 0000000..b1d3c4d
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
+		ret =3D PTR_ERR(regmap);
+		dev_err(dev, "failed to get regmap: %d\n", ret);
+		return ret;
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

