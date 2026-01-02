Return-Path: <linux-pm+bounces-40139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F047CEF27A
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 19:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A995303A028
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 18:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE90308F05;
	Fri,  2 Jan 2026 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="IPmpkBed";
	dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b="kgSJBa8g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578742EAB6E;
	Fri,  2 Jan 2026 18:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767377028; cv=pass; b=Vb3BEckMw+N1gvf5dvzuWR9RjoFMzn64aEh6xjW9IO1TitpY+emu5pjkiUG7gnNox7QPAFHOaRWpLCNaSoz7z+UWuYwxNB/7MloomzkClvzEiSr6mnuy/1xpDtipfG1/fU5uvinplGFgElfZ4TG6s9QbGBNVS512iV1idwHZFjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767377028; c=relaxed/simple;
	bh=9LDYGWmBVbvk3/wnVyVLD7AdS4IhA/Z2Zm0d3Eyemc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hYAe+vjtX/5gkkg3rNPSgego7VRlbTdc/D/PzFFyqvKLXf9zNcJ/vm+WDFxXqWIbCqVgWayd6nw+v5WsFkhpMS4gJ6Zw9hPOnK7XhpSohlLv+R0IJza6EIi7iiURN+v1SHwqgoC4plhHoR0iE5TnMShQSIMMWC3kyF/vPG9aPx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu; spf=none smtp.mailfrom=jm0.eu; dkim=pass (2048-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=IPmpkBed; dkim=permerror (0-bit key) header.d=jm0.eu header.i=@jm0.eu header.b=kgSJBa8g; arc=pass smtp.client-ip=81.169.146.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jm0.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jm0.eu
ARC-Seal: i=1; a=rsa-sha256; t=1767376840; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bpkUvJ1ttMvQpswwBTHfb1g1+IGSG1G1uYBaeYVhDax8xrpjukpdkctwD7AwleirGl
    gw2wLa87RhZhhmf/d4DLriAm47LpCKyC2PlM8U9S+lUBiq6AWKUhkIFi/JYvkttZ/GtX
    FanQLOnjGDRPr3VLk8JiPVmqBOASOObdAZdMlgyJhSQgP4mIlygXGh9ow7+KxjTzvJSZ
    kznu3E1cY9LcgIH6N8ZGzSzrVI6ut//S0//z93K4jERT11vRhMNCxH3qAsn1b9UDKzUI
    7NMP1kWhNGdIJ3Grk0s2FWZvdjzygHkmOiQF2qmn8t7xuc9/2uIynrxoaiasO5awR31H
    ++1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767376840;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=cdsRG53+MfpkA0In14GuBnrMa+IkJh25l65pJ1Sq7UE=;
    b=hBBceFWDbEDhjI2MeL68+hi0xnZm/du88dE2jitPmvy+FiYj9KvT69HzqemU2zHB5o
    S+N9R/DGXiNcmESUk4ViA1eGK7pTMEFGZ9z3cFfJAG8JI36zeAuMhJl/UD8oExKiCYp3
    HwgmL2Ysamf/wp0gHCsC7Aw5DznvHFlxZn6Uvok4HMxC5KezUuhGj0YfgR+2FBegk3ts
    XqZuKJf6+8Wkk+2YDbuHeHjj9+IwaR5X2XBrajMY/RiSVuDcWVTXJ8jRg7cxw+pTWPAf
    B81E4CU3xQN7Ej/vQpXM/OUqIVUjqYtxmcLPlAZKdvmcrlL2vTAMnlvKBhvuZWjCFpua
    Bxtg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767376840;
    s=strato-dkim-0002; d=jm0.eu;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=cdsRG53+MfpkA0In14GuBnrMa+IkJh25l65pJ1Sq7UE=;
    b=IPmpkBedYXxRP8KaFF3rLMKqs3JXQos4/H7PtJ93KW2TGxhLO+aEJIFxOjW5CYjtYX
    DeWZNK/RtjN/B3RWvPE1LHJKU1EOSKS9IloJoX1F+/w8wZITDrELYybRau2YWPwAWtjX
    epfKOVgpLmoUK0V17pbXsZiM/IkAYmYOSZ5bb65SEwtGrzwUb6H3clp66PWPFwtConyQ
    +r9A6bCcjJl2lmYmeisFRr5ktGTAES1mSETGVfw+Mwy5T6BvkCvg2NKQgaUTNWb66B3G
    JZjkrARJJuNuYQ3R60f+MwbL5XCRXuzi4YwhmB2egAkKeXTXgS8050Id7XYDhn/69J+h
    5ppg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767376840;
    s=strato-dkim-0003; d=jm0.eu;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=cdsRG53+MfpkA0In14GuBnrMa+IkJh25l65pJ1Sq7UE=;
    b=kgSJBa8g7By62VnqIEP/E6n0X/1/9ueHINHJDd7NlRmzS+AntWr2vMpPEkWMmYKv/L
    RBrUiaQ6tE9hv7W36xCQ==
X-RZG-AUTH: ":JmMXYEHmdv4HaV2cbPh7iS0wbr/uKIfGM0EPTeoCaRth8YQivJ4sfKeu9QyRDNI="
Received: from Wablet.localdomain
    by smtp.strato.de (RZmta 54.1.0 DYNA|AUTH)
    with ESMTPSA id z0d4ec202I0dEUB
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 2 Jan 2026 19:00:39 +0100 (CET)
From: Josua Mayer <josua.mayer@jm0.eu>
Date: Fri, 02 Jan 2026 19:00:32 +0100
Subject: [PATCH 3/4] power: supply: add battery driver for netronix ec
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-kobo-aura-battery-v1-3-501f2a8fa575@jm0.eu>
References: <20260102-kobo-aura-battery-v1-0-501f2a8fa575@jm0.eu>
In-Reply-To: <20260102-kobo-aura-battery-v1-0-501f2a8fa575@jm0.eu>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
 Lee Jones <lee@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Josua Mayer <josua.mayer@jm0.eu>
X-Mailer: b4 0.13.0

Implement a simple battery driver for monitoring voltage with the
netronix embedded controller found in certain ebook readers.

Signed-off-by: Josua Mayer <josua.mayer@jm0.eu>
---
 drivers/power/supply/Kconfig         |   9 ++++
 drivers/power/supply/Makefile        |   1 +
 drivers/power/supply/ntxec-battery.c | 101 +++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 92f9f7aae92f..0f944c10e50b 100644
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
+	  characteristics are read from device-tree if available.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 4b79d5abc49a..db6fc815f9da 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -128,3 +128,4 @@ obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
 obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_smbx.o
 obj-$(CONFIG_FUEL_GAUGE_MM8013)	+= mm8013.o
+obj-$(CONFIG_BATTERY_NTXEC)	+= ntxec-battery.o
diff --git a/drivers/power/supply/ntxec-battery.c b/drivers/power/supply/ntxec-battery.c
new file mode 100644
index 000000000000..f49f0966d18d
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
2.43.0


