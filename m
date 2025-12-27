Return-Path: <linux-pm+bounces-39964-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 937DBCDFF2A
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 17:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F4D3300D482
	for <lists+linux-pm@lfdr.de>; Sat, 27 Dec 2025 16:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CF323ABB0;
	Sat, 27 Dec 2025 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="CYk4T6ac";
	dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="H9o1l0TG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A45617B425;
	Sat, 27 Dec 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766853089; cv=pass; b=V1MIOaHJyjX6qwCiWmQ7cCoeMKEW7N0bnJDJMKS+5yQB+J9uEneBhjrtk57sz9juKtGlfx58bPc8JwL7s3T9yABNAG+eDFYSTlHGDw8b3SSPg5UKDewLa+DdqzvTAjKxrWSJfyb6zlq+ylt8vBZnM9iU8UD6AsFfOFPe0ZrytS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766853089; c=relaxed/simple;
	bh=EYTouuIKOAbasllfMMkwGify64wGdcuvMBTq9IQ0nag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMkNZmkBOwMvi4V+wardOOZMDMEUIsJGrkJDioVSh+CIxQurf/QJ4dz7JtAjRb+9HIi0wceBro7cPmMnFRk7GN9S7S7Tn8LBCHzeIo4iIhp3UEp/Vh1tqJ5sgTJ+2Bt7jKtTgewrBlfaUttTd2v8RSdBP56vkfnBTp99TZknvOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu; spf=none smtp.mailfrom=jm0.eu; dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=CYk4T6ac; dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=H9o1l0TG; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jm0.eu
ARC-Seal: i=1; a=rsa-sha256; t=1766852904; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pqy6mqROcxf1G/JG9se5DF+UkWnYtkSm+EqkpsxBPWFuiXVg+rVykipdg+itBR310h
    LXsNRF9Be3yDCaO1bcjawQwn3ZjhxfKTu2S5cOSEFeOziKUISaofNJ7gBIMwPXxvtlgO
    dpLOE4R1bSXDkYNLu5UZjHW86NntKEm1rj+MSXTSttmRKZfIor/H6LMmFLBmhXtXoOwF
    WfHK/TODMFNDtHuVqUJoZEiCj3SdNIm9tDjNsqBfaAd8pG3/GjmWF6Bph72Qzqa3Uf9O
    5f4dpoQRRQH94JzlN7Stb37NxyD5REjqq3Oni31UdeVR+DywzFUhuVG22k8tV+aPdGN4
    +xHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1766852904;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=oBoh6hY3yJ4owxWQx6sgt/gcf5XerqfPpIM1LTdUQis=;
    b=o/hSiqjmceS4YHXvms+r++w0H1UnlaUo10zdxkSrIMRiniOvgYj0ePrbj64GiWAXIm
    yFqUuquM8XYuX5fs0qIpSkd7B9SfZq9SC5c8YBKhZ6felz4PCUYQJcqbB2EXfxPoZE+w
    Na54AOd3mhIofaFeLERn6xvtq10DpOF0+ly3eCrBZkrCeNniE2F+y2gdBsMaMm+GQVJ2
    K7injbmOm0IaFY1MUHUMVtqMIj9oWYcthd1DzqaQwLueDXYpCYKLOrt4OpthkkdxQCDF
    W3LEYscGslh0uAgXPxTQ+eFWmERnpeD5hBelPBVTJez3OIVcUsukJMXRBeH2pHM3hN/S
    4lxA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1766852904;
    s=strato-dkim-0002; d=jm0.eu;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=oBoh6hY3yJ4owxWQx6sgt/gcf5XerqfPpIM1LTdUQis=;
    b=CYk4T6acNEEB6i53/NeTkcrkzFlKUgiCUkTso4ASy49j1yRpP40RrtC6O7sJWLAnlp
    pUpxuCAHROZXRKaGLWrKZ7Kp3MLGNHqYmTEcCuZSQomz66+BV3GAi4H4cZOaajdqWTIw
    UxAFKB+NsJ/aIxj/VF5jJhBJB8mcdLAgVsjS/Avpi+6Vi149p3fmIKobbnTNzlZ9eI3g
    Pb9fUEZpMrRUl8I7Xp/OAF7UTVLw/dBC2TC8KwvDhAcXrFBYVCR1ONx+laOED2dau2SS
    /TpAtDXay5UETEiKgU/lWaA00EGQNNP59ayKNAcw5FPVRvHGY3pPGW7+dR/JUFW1rjBn
    0VgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1766852904;
    s=strato-dkim-0003; d=jm0.eu;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=oBoh6hY3yJ4owxWQx6sgt/gcf5XerqfPpIM1LTdUQis=;
    b=H9o1l0TGDq7W0PnemiPm+6e5jWMG32qaTil1P94FhVUlOfbyIJuBCR/BY020epbW+2
    D6Y4qI8JM70bNl3YxBAg==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPTeoCaRth8YQvpoIkZXd2bnfIrOV7Mbk="
Received: from localhost.localdomain
    by smtp.strato.de (RZmta 54.1.0 DYNA|AUTH)
    with ESMTPSA id z0d4ec1BRGSOtuI
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 27 Dec 2025 17:28:24 +0100 (CET)
From: Josua Mayer <josua.mayer@jm0.eu>
Date: Sat, 27 Dec 2025 17:28:13 +0100
Subject: [PATCH 1/3] power: supply: add battery driver for netronix ec
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-kobo-aura-battery-v1-1-328a90ef5122@jm0.eu>
References: <20251227-kobo-aura-battery-v1-0-328a90ef5122@jm0.eu>
In-Reply-To: <20251227-kobo-aura-battery-v1-0-328a90ef5122@jm0.eu>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua.mayer@jm0.eu>
X-Mailer: b4 0.14.3

Implement a simple battery driver for monitoring voltage with the
netronix embedded controller found in certain ebook readers.

Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
 drivers/mfd/ntxec.c                  |   1 +
 drivers/power/supply/Kconfig         |   9 ++++
 drivers/power/supply/Makefile        |   1 +
 drivers/power/supply/ntxec-battery.c | 101 +++++++++++++++++++++++++++++++++++
 4 files changed, 112 insertions(+)

diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
index 08c68de0f01bc..d5059b8862aa8 100644
--- a/drivers/mfd/ntxec.c
+++ b/drivers/mfd/ntxec.c
@@ -139,6 +139,7 @@ static const struct regmap_config regmap_config = {
 static const struct mfd_cell ntxec_subdev[] = {
 	{ .name = "ntxec-rtc" },
 	{ .name = "ntxec-pwm" },
+	{ .name = "ntxec-battery" },
 };
 
 static const struct mfd_cell ntxec_subdev_pwm[] = {
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 92f9f7aae92f2..5674a23ba7bd6 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -1132,4 +1132,13 @@ config FUEL_GAUGE_MM8013
 	  the state of charge, temperature, cycle count, actual and design
 	  capacity, etc.
 
+config BATTERY_NTXEC
+	tristate "Battery driver for Netronix embedded controller"
+	depends on MFD_NTXEC
+	help
+	  Say yes here to enable netronix ec battery monitoring driver.
+	  It enables the monitoring battery voltage on certain e-book readers
+	  using an embedded controller by ODM Netronix. Battery design
+	  characteristics are read from Firmware Tables if available.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 4b79d5abc49a7..db6fc815f9da2 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -128,3 +128,4 @@ obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
 obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_smbx.o
 obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
+obj-$(CONFIG_BATTERY_NTXEC)	+= ntxec-battery.o
diff --git a/drivers/power/supply/ntxec-battery.c b/drivers/power/supply/ntxec-battery.c
new file mode 100644
index 0000000000000..f49f0966d18dd
--- /dev/null
+++ b/drivers/power/supply/ntxec-battery.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The Netronix embedded controller is a microcontroller found in some
+ * e-book readers designed by the original design manufacturer Netronix, Inc.
+ * It contains RTC, battery monitoring, system power management, and PWM
+ * functionality.
+ *
+ * This driver implements battery monitoring.
+ *
+ * Copyright 2021 Josua Mayer <josua.mayer@jm0.eu>
+ */
+
+#include <linux/mfd/ntxec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+static const enum power_supply_property ntxec_battery_properties[] = {
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
+struct ntxec_battery {
+	struct ntxec *ec;
+};
+
+#define NTXEC_REG_READ_BATTERY	0x41
+
+static int ntxec_battery_get_property(struct power_supply *psy,
+				     enum power_supply_property psp,
+				     union power_supply_propval *val)
+{
+	struct ntxec_battery *priv = power_supply_get_drvdata(psy);
+	int ret;
+	unsigned int value;
+
+	switch (psp) {
+		case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+			ret = regmap_read(priv->ec->regmap, NTXEC_REG_READ_BATTERY, &value);
+			if (ret < 0)
+				return ret;
+
+			/* ec value to microvolt conversion:
+			 * vendor kernel source suggests linear behaviour from 3V to 4.2V
+			 * with readings 767 to 1023; each increment represents 4687,5uV.
+			 * adjust 3V boundary slightly to report exactly 4.2V when full.
+			 */
+			val->intval = 2999872 + (value - 767) * 4688;
+			break;
+		default:
+			dev_err(&psy->dev, "%s: invalid property %u\n", __func__, psp);
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct power_supply_desc ntxec_battery_desc = {
+	.name = "ec-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = ntxec_battery_properties,
+	.get_property = ntxec_battery_get_property,
+	.num_properties = ARRAY_SIZE(ntxec_battery_properties),
+};
+
+static int ntxec_battery_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ntxec *ec = dev_get_drvdata(dev->parent);
+	struct power_supply_config psy_cfg = {};
+	struct ntxec_battery *priv;
+	struct power_supply *psy;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->ec = ec;
+	psy_cfg.drv_data = priv;
+	psy_cfg.fwnode = dev_fwnode(dev->parent);
+	psy_cfg.no_wakeup_source = true;
+	psy = devm_power_supply_register(dev, &ntxec_battery_desc, &psy_cfg);
+	if (IS_ERR(psy))
+		return PTR_ERR(psy);
+
+	return 0;
+}
+
+static struct platform_driver ntxec_battery_driver = {
+	.driver = {
+		.name = "ntxec-battery",
+	},
+	.probe = ntxec_battery_probe,
+};
+module_platform_driver(ntxec_battery_driver);
+
+MODULE_AUTHOR("Josua Mayer <josua.mayer@jm0.eu>");
+MODULE_DESCRIPTION("Battery driver for Netronix EC");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ntxec-battery");

-- 
2.51.0


