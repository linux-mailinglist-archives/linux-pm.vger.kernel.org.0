Return-Path: <linux-pm+bounces-37923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8E1C56753
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 10:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 98309357470
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 08:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEEA3346A7;
	Thu, 13 Nov 2025 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wIBawhA1"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784233372E
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024018; cv=none; b=hej5fWKWpJ/Rp3XOX/JatXiRRNkwmjH711rNH6oO2HeIv1Jaqdc3S0541IH/qaE5fu99dCd0yu9AOZZx1k43gmwbMVzG2wcMagZwi1MqX1fP5foLQcXL3h55Hn5MfTjCRMYeNfO/LiYiTIRzJO2SVrziFLUMzs8f/INJIpskzrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024018; c=relaxed/simple;
	bh=1Pvtu/oG1IwO6pNDUEr4DZKzfVjmB1WsT2uBYbFWWZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lE3abNBk3K1czKEpzrNkOlqvCCkKv1WSUTKdZcPRiHk0Y8CYBUwkb8Hj/ulAlvOyvRu9ghmHRzPUCIqWfhtmrGFder8nTs86j7qmRivg1NKW0g4A2gOqY4rXaUcpLc7c6YXg184aZACkGmjDzSjsmGSGTCNKq+TQf/tsqDPdL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wIBawhA1; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Nov 2025 10:53:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763024011; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=EqrJsT22dA5H0fGpcMf4K6Icr7GfCoIfPVxfe0+5Y6w=;
	b=wIBawhA1KKOMOaEvpMr5B2al02/ihZIOsaKMlbAxiUUDo99jTWuB2ypxXn7KMv4oQVCdUR
	iD1SAmyopAM0JIjWsPaDx39HW1KG+nqCEi5Fn1HvW3wUY86adU3b43PR7utrb5LvOTl3Br
	bGRmymjA27hmTPq5T2tWBIq54rWKtqY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-rtc@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 08/16] mfd: bd71828: Support ROHM BD72720
Message-ID: <5606b91f57e2b31b0a3550bd251e7bbd971d7932.1763022807.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q4UAlAKKKSth4iSH"
Content-Disposition: inline
In-Reply-To: <cover.1763022807.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--Q4UAlAKKKSth4iSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The ROHM BD72720 is a power management IC which continues the BD71828
family of PMICs. Similarly to the BD71815 and BD71828, the BD72720
integrates regulators, charger, RTC, clock gate and GPIOs.

The main difference to the earlier PMICs is that the BD72720 has two
different I2C slave addresses. In addition to the registers behind the
'main I2C address', most of the charger (and to some extent LED) control
is done via registers behind a 'secondary I2C slave address', 0x4c.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v2 =3D>:
 - no changes

 RFCv1 =3D> v2: (Mostly addressed comments from Lee and Andreas)
 - Use stacked regmaps to avoid platform data and the tango with
   multiple regmaps in the power-supply driver
 - Use regmap_reg_range()
 - make it clear bd72720_irq_type_base is an array
 - tab-out definitions in the bd72720 header
 - minor styling

Note: This patch depends on the series: "power: supply: add charger for
BD71828" by Andreas:
https://lore.kernel.org/all/20250918-bd71828-charger-v5-0-851164839c28@kemn=
ade.info/

There are some new variants being planned. Most notably, the BD73900
should be almost identical to the BD72720 - for everything else except
the charger block.
---
 drivers/mfd/Kconfig              |  18 +-
 drivers/mfd/rohm-bd71828.c       | 488 +++++++++++++++++++++++-
 include/linux/mfd/rohm-bd72720.h | 634 +++++++++++++++++++++++++++++++
 include/linux/mfd/rohm-generic.h |   1 +
 4 files changed, 1126 insertions(+), 15 deletions(-)
 create mode 100644 include/linux/mfd/rohm-bd72720.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6cec1858947b..61e238b316f4 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2211,20 +2211,22 @@ config MFD_ROHM_BD718XX
 	  and emergency shut down as well as 32,768KHz clock output.
=20
 config MFD_ROHM_BD71828
-	tristate "ROHM BD71828 and BD71815 Power Management IC"
+	tristate "ROHM BD718[15/28/79], BD72720 and BD73900 PMICs"
 	depends on I2C=3Dy
 	depends on OF
 	select REGMAP_I2C
 	select REGMAP_IRQ
 	select MFD_CORE
 	help
-	  Select this option to get support for the ROHM BD71828 and BD71815
-	  Power Management ICs. BD71828GW and BD71815AGW are single-chip power
-	  management ICs mainly for battery-powered portable devices.
-	  The BD71828 integrates 7 buck converters and 7 LDOs. The BD71815
-	  has 5 bucks, 7 LDOs, and a boost for driving LEDs. Both ICs provide
-	  also a single-cell linear charger, a Coulomb counter, a real-time
-	  clock (RTC), GPIOs and a 32.768 kHz clock gate.
+	  Select this option to get support for the ROHM BD71815, BD71828,
+	  BD71879, BD72720 and BD73900 Power Management ICs. These are
+	  single-chip power management ICs mainly for battery-powered portable
+	  devices.
+	  The BD71815 has 5 bucks, 7 LDOs, and a boost for driving LEDs.
+	  The BD718[28/79] have 7 buck converters and 7 LDOs.
+	  The BD72720 and the BD73900 have 10 bucks and 11 LDOs.
+	  All ICs provide a single-cell linear charger, a Coulomb counter,
+	  a real-time clock (RTC), GPIOs and a 32.768 kHz clock gate.
=20
 config MFD_ROHM_BD957XMUF
 	tristate "ROHM BD9576MUF and BD9573MUF Power Management ICs"
diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 2a43005b67ee..2e546aa60ffd 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -2,7 +2,7 @@
 //
 // Copyright (C) 2019 ROHM Semiconductors
 //
-// ROHM BD71828/BD71815 PMIC driver
+// ROHM BD718[15/28/79] and BD72720 PMIC driver
=20
 #include <linux/gpio_keys.h>
 #include <linux/i2c.h>
@@ -13,12 +13,29 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/rohm-bd71815.h>
 #include <linux/mfd/rohm-bd71828.h>
+#include <linux/mfd/rohm-bd72720.h>
 #include <linux/mfd/rohm-generic.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
=20
+#define BD72720_TYPED_IRQ_REG(_irq, _stat_offset, _mask, _type_offset)    =
 \
+	[_irq] =3D {							   \
+		.reg_offset =3D (_stat_offset),				   \
+		.mask =3D (_mask),					   \
+		{							   \
+			.type_reg_offset =3D (_type_offset),		   \
+			.type_reg_mask =3D BD72720_GPIO_IRQ_TYPE_MASK,	   \
+			.type_rising_val =3D BD72720_GPIO_IRQ_TYPE_RISING,   \
+			.type_falling_val =3D BD72720_GPIO_IRQ_TYPE_FALLING, \
+			.type_level_low_val =3D BD72720_GPIO_IRQ_TYPE_LOW,   \
+			.type_level_high_val =3D BD72720_GPIO_IRQ_TYPE_HIGH, \
+			.types_supported =3D IRQ_TYPE_EDGE_BOTH |		   \
+				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW,  \
+		},							   \
+	}
+
 static struct gpio_keys_button button =3D {
 	.code =3D KEY_POWER,
 	.gpio =3D -1,
@@ -43,6 +60,12 @@ static const struct resource bd71828_rtc_irqs[] =3D {
 	DEFINE_RES_IRQ_NAMED(BD71828_INT_RTC2, "bd70528-rtc-alm-2"),
 };
=20
+static const struct resource bd72720_rtc_irqs[] =3D {
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_RTC0, "bd70528-rtc-alm-0"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_RTC1, "bd70528-rtc-alm-1"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_RTC2, "bd70528-rtc-alm-2"),
+};
+
 static const struct resource bd71815_power_irqs[] =3D {
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_DCIN_RMV, "bd71815-dcin-rmv"),
 	DEFINE_RES_IRQ_NAMED(BD71815_INT_CLPS_OUT, "bd71815-dcin-clps-out"),
@@ -156,6 +179,74 @@ static struct mfd_cell bd71828_mfd_cells[] =3D {
 	},
 };
=20
+static const struct resource bd72720_power_irqs[] =3D {
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VBUS_RMV, "bd72720_int_vbus_rmv"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VBUS_DET, "bd72720_int_vbus_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VBUS_MON_RES, "bd72720_int_vbus_mon_res"=
),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VBUS_MON_DET, "bd72720_int_vbus_mon_det"=
),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VSYS_MON_RES, "bd72720_int_vsys_mon_res"=
),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VSYS_MON_DET, "bd72720_int_vsys_mon_det"=
),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VSYS_UV_RES, "bd72720_int_vsys_uv_res"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VSYS_UV_DET, "bd72720_int_vsys_uv_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VSYS_LO_RES, "bd72720_int_vsys_lo_res"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VSYS_LO_DET, "bd72720_int_vsys_lo_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VSYS_OV_RES, "bd72720_int_vsys_ov_res"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VSYS_OV_DET, "bd72720_int_vsys_ov_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_BAT_ILIM, "bd72720_int_bat_ilim"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_CHG_DONE, "bd72720_int_chg_done"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_EXTEMP_TOUT, "bd72720_int_extemp_tout"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_CHG_WDT_EXP, "bd72720_int_chg_wdt_exp"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_BAT_MNT_OUT, "bd72720_int_bat_mnt_out"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_BAT_MNT_IN, "bd72720_int_bat_mnt_in"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_CHG_TRNS, "bd72720_int_chg_trns"),
+
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VBAT_MON_RES, "bd72720_int_vbat_mon_res"=
),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VBAT_MON_DET, "bd72720_int_vbat_mon_det"=
),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VBAT_SHT_RES, "bd72720_int_vbat_sht_res"=
),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VBAT_SHT_DET, "bd72720_int_vbat_sht_det"=
),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VBAT_LO_RES, "bd72720_int_vbat_lo_res"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VBAT_LO_DET, "bd72720_int_vbat_lo_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VBAT_OV_RES, "bd72720_int_vbat_ov_res"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_VBAT_OV_DET, "bd72720_int_vbat_ov_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_BAT_RMV, "bd72720_int_bat_rmv"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_BAT_DET, "bd72720_int_bat_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_DBAT_DET, "bd72720_int_dbat_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_BAT_TEMP_TRNS, "bd72720_int_bat_temp_trn=
s"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_LOBTMP_RES, "bd72720_int_lobtmp_res"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_LOBTMP_DET, "bd72720_int_lobtmp_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_OVBTMP_RES, "bd72720_int_ovbtmp_res"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_OVBTMP_DET, "bd72720_int_ovbtmp_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_OCUR1_RES, "bd72720_int_ocur1_res"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_OCUR1_DET, "bd72720_int_ocur1_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_OCUR2_RES, "bd72720_int_ocur2_res"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_OCUR2_DET, "bd72720_int_ocur2_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_OCUR3_RES, "bd72720_int_ocur3_res"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_OCUR3_DET, "bd72720_int_ocur3_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_CC_MON1_DET, "bd72720_int_cc_mon1_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_CC_MON2_DET, "bd72720_int_cc_mon2_det"),
+	DEFINE_RES_IRQ_NAMED(BD72720_INT_CC_MON3_DET, "bd72720_int_cc_mon3_det"),
+};
+
+static const struct mfd_cell bd72720_mfd_cells[] =3D {
+	{ .name =3D "bd72720-pmic", },
+	{ .name =3D "bd72720-gpio", },
+	{ .name =3D "bd72720-led", },
+	{ .name =3D "bd72720-clk", },
+	{
+		.name =3D "bd72720-power",
+		.resources =3D bd72720_power_irqs,
+		.num_resources =3D ARRAY_SIZE(bd72720_power_irqs),
+	}, {
+		.name =3D "bd72720-rtc",
+		.resources =3D bd72720_rtc_irqs,
+		.num_resources =3D ARRAY_SIZE(bd72720_rtc_irqs),
+	}, {
+		.name =3D "gpio-keys",
+		.platform_data =3D &bd71828_powerkey_data,
+		.pdata_size =3D sizeof(bd71828_powerkey_data),
+	},
+};
+
 static const struct regmap_range bd71815_volatile_ranges[] =3D {
 	regmap_reg_range(BD71815_REG_SEC, BD71815_REG_YEAR),
 	regmap_reg_range(BD71815_REG_CONF, BD71815_REG_BAT_TEMP),
@@ -180,6 +271,87 @@ static const struct regmap_range bd71828_volatile_rang=
es[] =3D {
 	regmap_reg_range(BD71828_REG_INT_MAIN, BD71828_REG_IO_STAT),
 };
=20
+static const struct regmap_range bd72720_volatile_ranges_4b[] =3D {
+	regmap_reg_range(BD72720_REG_RESETSRC_1, BD72720_REG_RESETSRC_2),
+	regmap_reg_range(BD72720_REG_POWER_STATE, BD72720_REG_POWER_STATE),
+	/* The state indicator bit changes when new state is reached */
+	regmap_reg_range(BD72720_REG_PS_CTRL_1, BD72720_REG_PS_CTRL_1),
+	regmap_reg_range(BD72720_REG_RCVNUM, BD72720_REG_RCVNUM),
+	regmap_reg_range(BD72720_REG_CONF, BD72720_REG_HALL_STAT),
+	regmap_reg_range(BD72720_REG_RTC_SEC, BD72720_REG_RTC_YEAR),
+	regmap_reg_range(BD72720_REG_INT_LVL1_STAT, BD72720_REG_INT_ETC2_SRC),
+};
+
+static const struct regmap_range bd72720_precious_ranges_4b[] =3D {
+	regmap_reg_range(BD72720_REG_INT_LVL1_STAT, BD72720_REG_INT_ETC2_STAT),
+};
+
+/*
+ * The BD72720 is an odd beast in that it contains two separate sets of
+ * registers, both starting from address 0x0. The twist is that these "pag=
es"
+ * are behind different I2C slave addresses. Most of the registers are beh=
ind
+ * a slave address 0x4b, which will be used as the "main" address for this
+ * device.
+ * Most of the charger related registers are located behind slave address =
0x4c.
+ * It is tempting to push the dealing with the charger registers and the e=
xtra
+ * 0x4c device in power-supply driver - but perhaps it's better for the sa=
ke of
+ * the cleaner re-use to deal with setting up all of the regmaps here.
+ * Furthermore, the LED stuff may need access to both of these devices.
+ *
+ * Instead of providing one of the regmaps to sub-devices in MFD platform =
data,
+ * we create one more 'wrapper regmap' with custom read/write operations. =
These
+ * custom accessors will select which of the 'real' regmaps to use, based =
on
+ * the register address.
+ * The register addresses are 8-bit, so we add offset 0x100 to the address=
es
+ * behind the secondary slave 0x4c. The 'wrapper' regmap can then detect t=
he
+ * correct slave address based on the register address and call regmap_wri=
te()
+ * and regmap_read() using correct 'real' regmap. This way the registers of
+ * both of the slaves can be accessed using one 'wrapper' regmap.
+ *
+ * NOTE: The added offsets mean that the defined addresses for slave 0x4c =
must
+ * be used through the 'wrapper' regmap because the offset must be stripped
+ * from the register addresses. The 0x4b can be accessed both indirectly u=
sing
+ * the 'wrapper' regmap, and directly using the 'real' regmap.
+ */
+#define BD72720_SECONDARY_I2C_SLAVE 0x4c
+
+struct bd72720_regmaps {
+	struct regmap *map1_4b;
+	struct regmap *map2_4c;
+};
+
+/* Translate the slave 0x4c wrapper register address to a real one */
+#define BD72720_REG_UNWRAP(reg) ((reg) - 0x100)
+
+/* Ranges given to 'real' 0x4c regmap must use unwrapped addresses. */
+#define BD72720_UNWRAP_REG_RANGE(startreg, endreg)					\
+	regmap_reg_range(BD72720_REG_UNWRAP(startreg), BD72720_REG_UNWRAP(endreg))
+static const struct regmap_range bd72720_volatile_ranges_4c[] =3D {
+	/* Status information */
+	BD72720_UNWRAP_REG_RANGE(BD72720_REG_CHG_STATE, BD72720_REG_CHG_EN),
+	/*
+	 * Under certain circumstances, write to some bits may be
+	 * ignored
+	 */
+	BD72720_UNWRAP_REG_RANGE(BD72720_REG_CHG_CTRL, BD72720_REG_CHG_CTRL),
+	/*
+	 * TODO: Ensure this is used to advertise state, not (only?) to
+	 * control it.
+	 */
+	BD72720_UNWRAP_REG_RANGE(BD72720_REG_VSYS_STATE_STAT, BD72720_REG_VSYS_ST=
ATE_STAT),
+	/* Measured data */
+	BD72720_UNWRAP_REG_RANGE(BD72720_REG_VM_VBAT_U, BD72720_REG_VM_VF_L),
+	/* Self clearing bits */
+	BD72720_UNWRAP_REG_RANGE(BD72720_REG_VM_VSYS_SA_MINMAX_CTRL,
+				 BD72720_REG_VM_VSYS_SA_MINMAX_CTRL),
+	/* Counters, self clearing bits */
+	BD72720_UNWRAP_REG_RANGE(BD72720_REG_CC_CURCD_U, BD72720_REG_CC_CTRL),
+	/* Self clearing bits */
+	BD72720_UNWRAP_REG_RANGE(BD72720_REG_CC_CCNTD_CTRL, BD72720_REG_CC_CCNTD_=
CTRL),
+	/* Self clearing bits */
+	BD72720_UNWRAP_REG_RANGE(BD72720_REG_IMPCHK_CTRL, BD72720_REG_IMPCHK_CTRL=
),
+};
+
 static const struct regmap_access_table bd71815_volatile_regs =3D {
 	.yes_ranges =3D &bd71815_volatile_ranges[0],
 	.n_yes_ranges =3D ARRAY_SIZE(bd71815_volatile_ranges),
@@ -190,6 +362,21 @@ static const struct regmap_access_table bd71828_volati=
le_regs =3D {
 	.n_yes_ranges =3D ARRAY_SIZE(bd71828_volatile_ranges),
 };
=20
+static const struct regmap_access_table bd72720_volatile_regs_4b =3D {
+	.yes_ranges =3D &bd72720_volatile_ranges_4b[0],
+	.n_yes_ranges =3D ARRAY_SIZE(bd72720_volatile_ranges_4b),
+};
+
+static const struct regmap_access_table bd72720_precious_regs_4b =3D {
+	.yes_ranges =3D &bd72720_precious_ranges_4b[0],
+	.n_yes_ranges =3D ARRAY_SIZE(bd72720_precious_ranges_4b),
+};
+
+static const struct regmap_access_table bd72720_volatile_regs_4c =3D {
+	.yes_ranges =3D &bd72720_volatile_ranges_4c[0],
+	.n_yes_ranges =3D ARRAY_SIZE(bd72720_volatile_ranges_4c),
+};
+
 static const struct regmap_config bd71815_regmap =3D {
 	.reg_bits =3D 8,
 	.val_bits =3D 8,
@@ -206,10 +393,79 @@ static const struct regmap_config bd71828_regmap =3D {
 	.cache_type =3D REGCACHE_MAPLE,
 };
=20
+static int regmap_write_wrapper(void *context, unsigned int reg, unsigned =
int val)
+{
+	struct bd72720_regmaps *maps =3D context;
+
+	if (reg < 0x100)
+		return regmap_write(maps->map1_4b, reg, val);
+
+	reg =3D BD72720_REG_UNWRAP(reg);
+
+	return regmap_write(maps->map2_4c, reg, val);
+}
+
+static int regmap_read_wrapper(void *context, unsigned int reg, unsigned i=
nt *val)
+{
+	struct bd72720_regmaps *maps =3D context;
+
+	if (reg < 0x100)
+		return regmap_read(maps->map1_4b, reg, val);
+
+	reg =3D BD72720_REG_UNWRAP(reg);
+
+	return regmap_read(maps->map2_4c, reg, val);
+}
+
+static const struct regmap_config bd72720_wrapper_map_config =3D {
+	.name =3D "wrap-map",
+	.reg_bits =3D 9,
+	.val_bits =3D 8,
+	.max_register =3D BD72720_REG_IMPCHK_CTRL,
+	/*
+	 * We don't want to duplicate caches. It would be a bit faster to
+	 * have the cache in this 'wrapper regmap', and not in the 'real
+	 * regmaps' bd72720_regmap_4b and bd72720_regmap_4c below. This would
+	 * require all the subdevices to use the wrapper-map in order to be
+	 * able to benefit from the cache.
+	 * Currently most of the sub-devices use only the same slave-address
+	 * as this MFD driver. Now, because we don't add the offset to the
+	 * registers belonging to this slave, those devices can use either the
+	 * wrapper map, or the bd72720_regmap_4b directly. This means majority
+	 * of our sub devices don't need to care which regmap they get using
+	 * the dev_get_regmap(). This unifies the code between the BD72720 and
+	 * those variants which don't have this 'multiple slave addresses'
+	 * -hassle.
+	 * So, for a small performance penalty, we simplify the code for the
+	 * sub-devices by having the caches in the wrapped regmaps and not here.
+	 */
+	.cache_type =3D REGCACHE_NONE,
+	.reg_write =3D regmap_write_wrapper,
+	.reg_read =3D regmap_read_wrapper,
+};
+
+static const struct regmap_config bd72720_regmap_4b =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.volatile_table =3D &bd72720_volatile_regs_4b,
+	.precious_table =3D &bd72720_precious_regs_4b,
+	.max_register =3D BD72720_REG_INT_ETC2_SRC,
+	.cache_type =3D REGCACHE_MAPLE,
+};
+
+static const struct regmap_config bd72720_regmap_4c =3D {
+	.reg_bits =3D 8,
+	.val_bits =3D 8,
+	.volatile_table =3D &bd72720_volatile_regs_4c,
+	.max_register =3D BD72720_REG_UNWRAP(BD72720_REG_IMPCHK_CTRL),
+	.cache_type =3D REGCACHE_MAPLE,
+};
+
 /*
  * Mapping of main IRQ register bits to sub-IRQ register offsets so that w=
e can
  * access corect sub-IRQ registers based on bits that are set in main IRQ
- * register. BD71815 and BD71828 have same sub-register-block offests.
+ * register. BD71815 and BD71828 have same sub-register-block offests, the
+ * BD72720 has a different one.
  */
=20
 static unsigned int bit0_offsets[] =3D {11};		/* RTC IRQ */
@@ -221,6 +477,15 @@ static unsigned int bit5_offsets[] =3D {3};		/* VSYS I=
RQ */
 static unsigned int bit6_offsets[] =3D {1, 2};		/* DCIN IRQ */
 static unsigned int bit7_offsets[] =3D {0};		/* BUCK IRQ */
=20
+static unsigned int bd72720_bit0_offsets[] =3D {0, 1};	/* PS1 and PS2 */
+static unsigned int bd72720_bit1_offsets[] =3D {2, 3};	/* DVS1 and DVS2 */
+static unsigned int bd72720_bit2_offsets[] =3D {4};	/* VBUS */
+static unsigned int bd72720_bit3_offsets[] =3D {5};	/* VSYS */
+static unsigned int bd72720_bit4_offsets[] =3D {6};	/* CHG */
+static unsigned int bd72720_bit5_offsets[] =3D {7, 8};	/* BAT1 and BAT2 */
+static unsigned int bd72720_bit6_offsets[] =3D {9};	/* IBAT */
+static unsigned int bd72720_bit7_offsets[] =3D {10, 11};	/* ETC1 and ETC2 =
*/
+
 static const struct regmap_irq_sub_irq_map bd718xx_sub_irq_offsets[] =3D {
 	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),
 	REGMAP_IRQ_MAIN_REG_OFFSET(bit1_offsets),
@@ -232,6 +497,17 @@ static const struct regmap_irq_sub_irq_map bd718xx_sub=
_irq_offsets[] =3D {
 	REGMAP_IRQ_MAIN_REG_OFFSET(bit7_offsets),
 };
=20
+static const struct regmap_irq_sub_irq_map bd72720_sub_irq_offsets[] =3D {
+	REGMAP_IRQ_MAIN_REG_OFFSET(bd72720_bit0_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bd72720_bit1_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bd72720_bit2_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bd72720_bit3_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bd72720_bit4_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bd72720_bit5_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bd72720_bit6_offsets),
+	REGMAP_IRQ_MAIN_REG_OFFSET(bd72720_bit7_offsets),
+};
+
 static const struct regmap_irq bd71815_irqs[] =3D {
 	REGMAP_IRQ_REG(BD71815_INT_BUCK1_OCP, 0, BD71815_INT_BUCK1_OCP_MASK),
 	REGMAP_IRQ_REG(BD71815_INT_BUCK2_OCP, 0, BD71815_INT_BUCK2_OCP_MASK),
@@ -405,6 +681,117 @@ static const struct regmap_irq bd71828_irqs[] =3D {
 	REGMAP_IRQ_REG(BD71828_INT_RTC2, 11, BD71828_INT_RTC2_MASK),
 };
=20
+static const struct regmap_irq bd72720_irqs[] =3D {
+	REGMAP_IRQ_REG(BD72720_INT_LONGPUSH, 0, BD72720_INT_LONGPUSH_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_MIDPUSH, 0, BD72720_INT_MIDPUSH_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_SHORTPUSH, 0, BD72720_INT_SHORTPUSH_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_PUSH, 0, BD72720_INT_PUSH_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_HALL_DET, 0, BD72720_INT_HALL_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_HALL_TGL, 0, BD72720_INT_HALL_TGL_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_WDOG, 0, BD72720_INT_WDOG_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_SWRESET, 0, BD72720_INT_SWRESET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_SEQ_DONE, 1, BD72720_INT_SEQ_DONE_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_PGFAULT, 1, BD72720_INT_PGFAULT_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BUCK1_DVS, 2, BD72720_INT_BUCK1_DVS_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BUCK2_DVS, 2, BD72720_INT_BUCK2_DVS_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BUCK3_DVS, 2, BD72720_INT_BUCK3_DVS_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BUCK4_DVS, 2, BD72720_INT_BUCK4_DVS_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BUCK5_DVS, 2, BD72720_INT_BUCK5_DVS_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BUCK6_DVS, 2, BD72720_INT_BUCK6_DVS_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BUCK7_DVS, 2, BD72720_INT_BUCK7_DVS_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BUCK8_DVS, 2, BD72720_INT_BUCK8_DVS_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BUCK9_DVS, 3, BD72720_INT_BUCK9_DVS_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BUCK10_DVS, 3, BD72720_INT_BUCK10_DVS_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_LDO1_DVS, 3, BD72720_INT_LDO1_DVS_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_LDO2_DVS, 3, BD72720_INT_LDO2_DVS_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_LDO3_DVS, 3, BD72720_INT_LDO3_DVS_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_LDO4_DVS, 3, BD72720_INT_LDO4_DVS_MASK),
+
+	REGMAP_IRQ_REG(BD72720_INT_VBUS_RMV, 4, BD72720_INT_VBUS_RMV_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_VBUS_DET, 4, BD72720_INT_VBUS_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_VBUS_MON_RES, 4, BD72720_INT_VBUS_MON_RES_MASK=
),
+	REGMAP_IRQ_REG(BD72720_INT_VBUS_MON_DET, 4, BD72720_INT_VBUS_MON_DET_MASK=
),
+	REGMAP_IRQ_REG(BD72720_INT_VSYS_MON_RES, 5, BD72720_INT_VSYS_MON_RES_MASK=
),
+	REGMAP_IRQ_REG(BD72720_INT_VSYS_MON_DET, 5, BD72720_INT_VSYS_MON_DET_MASK=
),
+	REGMAP_IRQ_REG(BD72720_INT_VSYS_UV_RES, 5, BD72720_INT_VSYS_UV_RES_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_VSYS_UV_DET, 5, BD72720_INT_VSYS_UV_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_VSYS_LO_RES, 5, BD72720_INT_VSYS_LO_RES_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_VSYS_LO_DET, 5, BD72720_INT_VSYS_LO_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_VSYS_OV_RES, 5, BD72720_INT_VSYS_OV_RES_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_VSYS_OV_DET, 5, BD72720_INT_VSYS_OV_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BAT_ILIM, 6, BD72720_INT_BAT_ILIM_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_CHG_DONE, 6, BD72720_INT_CHG_DONE_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_EXTEMP_TOUT, 6, BD72720_INT_EXTEMP_TOUT_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_CHG_WDT_EXP, 6, BD72720_INT_CHG_WDT_EXP_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BAT_MNT_OUT, 6, BD72720_INT_BAT_MNT_OUT_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BAT_MNT_IN, 6, BD72720_INT_BAT_MNT_IN_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_CHG_TRNS, 6, BD72720_INT_CHG_TRNS_MASK),
+
+	REGMAP_IRQ_REG(BD72720_INT_VBAT_MON_RES, 7, BD72720_INT_VBAT_MON_RES_MASK=
),
+	REGMAP_IRQ_REG(BD72720_INT_VBAT_MON_DET, 7, BD72720_INT_VBAT_MON_DET_MASK=
),
+	REGMAP_IRQ_REG(BD72720_INT_VBAT_SHT_RES, 7, BD72720_INT_VBAT_SHT_RES_MASK=
),
+	REGMAP_IRQ_REG(BD72720_INT_VBAT_SHT_DET, 7, BD72720_INT_VBAT_SHT_DET_MASK=
),
+	REGMAP_IRQ_REG(BD72720_INT_VBAT_LO_RES, 7, BD72720_INT_VBAT_LO_RES_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_VBAT_LO_DET, 7, BD72720_INT_VBAT_LO_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_VBAT_OV_RES, 7, BD72720_INT_VBAT_OV_RES_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_VBAT_OV_DET, 7, BD72720_INT_VBAT_OV_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BAT_RMV, 8, BD72720_INT_BAT_RMV_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BAT_DET, 8, BD72720_INT_BAT_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_DBAT_DET, 8, BD72720_INT_DBAT_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_BAT_TEMP_TRNS, 8, BD72720_INT_BAT_TEMP_TRNS_MA=
SK),
+	REGMAP_IRQ_REG(BD72720_INT_LOBTMP_RES, 8, BD72720_INT_LOBTMP_RES_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_LOBTMP_DET, 8, BD72720_INT_LOBTMP_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_OVBTMP_RES, 8, BD72720_INT_OVBTMP_RES_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_OVBTMP_DET, 8, BD72720_INT_OVBTMP_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_OCUR1_RES, 9, BD72720_INT_OCUR1_RES_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_OCUR1_DET, 9, BD72720_INT_OCUR1_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_OCUR2_RES, 9, BD72720_INT_OCUR2_RES_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_OCUR2_DET, 9, BD72720_INT_OCUR2_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_OCUR3_RES, 9, BD72720_INT_OCUR3_RES_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_OCUR3_DET, 9, BD72720_INT_OCUR3_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_CC_MON1_DET, 10, BD72720_INT_CC_MON1_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_CC_MON2_DET, 10, BD72720_INT_CC_MON2_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_CC_MON3_DET, 10, BD72720_INT_CC_MON3_DET_MASK),
+/*
+ * The GPIO1_IN and GPIO2_IN IRQs are generated from the PMIC's GPIO1 and =
GPIO2
+ * pins. Eg, they may be wired to other devices which can then use the PMI=
C as
+ * an interrupt controller. The GPIO1 and GPIO2 can have the IRQ type
+ * specified. All of the types (falling, rising, and both edges as well as=
 low
+ * and high levels) are supported.
+ */
+	BD72720_TYPED_IRQ_REG(BD72720_INT_GPIO1_IN, 10, BD72720_INT_GPIO1_IN_MASK=
, 0),
+	BD72720_TYPED_IRQ_REG(BD72720_INT_GPIO2_IN, 10, BD72720_INT_GPIO2_IN_MASK=
, 1),
+	REGMAP_IRQ_REG(BD72720_INT_VF125_RES, 11, BD72720_INT_VF125_RES_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_VF125_DET, 11, BD72720_INT_VF125_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_VF_RES, 11, BD72720_INT_VF_RES_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_VF_DET, 11, BD72720_INT_VF_DET_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_RTC0, 11, BD72720_INT_RTC0_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_RTC1, 11, BD72720_INT_RTC1_MASK),
+	REGMAP_IRQ_REG(BD72720_INT_RTC2, 11, BD72720_INT_RTC2_MASK),
+};
+
+static int bd72720_set_type_config(unsigned int **buf, unsigned int type,
+				   const struct regmap_irq *irq_data,
+				   int idx, void *irq_drv_data)
+{
+	const struct regmap_irq_type *t =3D &irq_data->type;
+
+	/*
+	 * The regmap IRQ ecpects IRQ_TYPE_EDGE_BOTH to be written to register
+	 * as logical OR of the type_falling_val and type_rising_val. This is
+	 * not how the BD72720 implements this configuration, hence we need
+	 * to handle this specific case separately.
+	 */
+	if (type =3D=3D IRQ_TYPE_EDGE_BOTH) {
+		buf[0][idx] &=3D ~t->type_reg_mask;
+		buf[0][idx] |=3D BD72720_GPIO_IRQ_TYPE_BOTH;
+
+		return 0;
+	}
+
+	return regmap_irq_set_type_config_simple(buf, type, irq_data, idx, irq_dr=
v_data);
+}
+
 static const struct regmap_irq_chip bd71828_irq_chip =3D {
 	.name =3D "bd71828_irq",
 	.main_status =3D BD71828_REG_INT_MAIN,
@@ -437,6 +824,28 @@ static const struct regmap_irq_chip bd71815_irq_chip =
=3D {
 	.irq_reg_stride =3D 1,
 };
=20
+static const unsigned int bd72720_irq_type_base[] =3D {BD72720_REG_GPIO1_C=
TRL};
+
+static const struct regmap_irq_chip bd72720_irq_chip =3D {
+	.name =3D "bd72720_irq",
+	.main_status =3D BD72720_REG_INT_LVL1_STAT,
+	.irqs =3D &bd72720_irqs[0],
+	.num_irqs =3D ARRAY_SIZE(bd72720_irqs),
+	.status_base =3D BD72720_REG_INT_PS1_STAT,
+	.unmask_base =3D BD72720_REG_INT_PS1_EN,
+	.config_base =3D &bd72720_irq_type_base[0],
+	.num_config_bases =3D 1,
+	.num_config_regs =3D 2,
+	.set_type_config =3D bd72720_set_type_config,
+	.ack_base =3D BD72720_REG_INT_PS1_STAT,
+	.init_ack_masked =3D true,
+	.num_regs =3D 12,
+	.num_main_regs =3D 1,
+	.sub_reg_offsets =3D &bd72720_sub_irq_offsets[0],
+	.num_main_status_bits =3D 8,
+	.irq_reg_stride =3D 1,
+};
+
 static int set_clk_mode(struct device *dev, struct regmap *regmap,
 			int clkmode_reg)
 {
@@ -483,11 +892,40 @@ static void bd71828_remove_poweroff(void *data)
 	pm_power_off =3D NULL;
 }
=20
+static struct regmap *bd72720_do_regmaps(struct i2c_client *i2c)
+{
+	struct bd72720_regmaps *maps;
+	struct i2c_client *secondary_i2c;
+
+	secondary_i2c =3D devm_i2c_new_dummy_device(&i2c->dev, i2c->adapter,
+						  BD72720_SECONDARY_I2C_SLAVE);
+	if (IS_ERR(secondary_i2c)) {
+		dev_err_probe(&i2c->dev, PTR_ERR(secondary_i2c),
+			      "Failed to get secondary I2C\n");
+
+		return (struct regmap *)secondary_i2c;
+	}
+
+	maps =3D devm_kzalloc(&i2c->dev, sizeof(*maps), GFP_KERNEL);
+	if (!maps)
+		return ERR_PTR(-ENOMEM);
+
+	maps->map1_4b =3D devm_regmap_init_i2c(i2c, &bd72720_regmap_4b);
+	if (IS_ERR(maps->map1_4b))
+		return maps->map1_4b;
+
+	maps->map2_4c =3D devm_regmap_init_i2c(secondary_i2c, &bd72720_regmap_4c);
+	if (IS_ERR(maps->map2_4c))
+		return maps->map2_4c;
+
+	return devm_regmap_init(&i2c->dev, NULL, maps, &bd72720_wrapper_map_confi=
g);
+}
+
 static int bd71828_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_irq_chip_data *irq_data;
 	int ret;
-	struct regmap *regmap;
+	struct regmap *regmap =3D NULL;
 	const struct regmap_config *regmap_config;
 	const struct regmap_irq_chip *irqchip;
 	unsigned int chip_type;
@@ -495,6 +933,7 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
 	int cells;
 	int button_irq;
 	int clkmode_reg;
+	int main_lvl_mask_reg =3D 0, main_lvl_val =3D 0;
=20
 	if (!i2c->irq) {
 		dev_err(&i2c->dev, "No IRQ configured\n");
@@ -526,16 +965,34 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
 		 */
 		button_irq =3D 0;
 		break;
+	case ROHM_CHIP_TYPE_BD72720:
+	{
+		mfd =3D bd72720_mfd_cells;
+		cells =3D ARRAY_SIZE(bd72720_mfd_cells);
+
+		regmap =3D bd72720_do_regmaps(i2c);
+		if (IS_ERR(regmap))
+			return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
+				     "Failed to initialize Regmap\n");
+
+		irqchip =3D &bd72720_irq_chip;
+		clkmode_reg =3D BD72720_REG_OUT32K;
+		button_irq =3D BD72720_INT_SHORTPUSH;
+		main_lvl_mask_reg =3D BD72720_REG_INT_LVL1_EN;
+		main_lvl_val =3D BD72720_MASK_LVL1_EN_ALL;
+		break;
+	}
 	default:
 		dev_err(&i2c->dev, "Unknown device type");
 		return -EINVAL;
 	}
=20
-	regmap =3D devm_regmap_init_i2c(i2c, regmap_config);
-	if (IS_ERR(regmap))
-		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
+	if (!regmap) {
+		regmap =3D devm_regmap_init_i2c(i2c, regmap_config);
+		if (IS_ERR(regmap))
+			return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
 				     "Failed to initialize Regmap\n");
-
+	}
 	ret =3D devm_regmap_add_irq_chip(&i2c->dev, regmap, i2c->irq,
 				       IRQF_ONESHOT, 0, irqchip, &irq_data);
 	if (ret)
@@ -545,6 +1002,20 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
 	dev_dbg(&i2c->dev, "Registered %d IRQs for chip\n",
 		irqchip->num_irqs);
=20
+	/*
+	 * On some ICs the main IRQ register has corresponding mask register.
+	 * This is not handled by the regmap IRQ. Let's enable all the main
+	 * level IRQs here. Further writes to the main level MASK is not
+	 * needed because masking is handled by the per IRQ 2.nd level MASK
+	 * registers. 2.nd level masks are handled by the regmap IRQ.
+	 */
+	if (main_lvl_mask_reg) {
+		ret =3D regmap_write(regmap, main_lvl_mask_reg, main_lvl_val);
+		if (ret) {
+			return dev_err_probe(&i2c->dev, ret,
+					"Failed to enable main level IRQs\n");
+		}
+	}
 	if (button_irq) {
 		ret =3D regmap_irq_get_virq(irq_data, button_irq);
 		if (ret < 0)
@@ -586,6 +1057,9 @@ static const struct of_device_id bd71828_of_match[] =
=3D {
 	}, {
 		.compatible =3D "rohm,bd71815",
 		.data =3D (void *)ROHM_CHIP_TYPE_BD71815,
+	}, {
+		.compatible =3D "rohm,bd72720",
+		.data =3D (void *)ROHM_CHIP_TYPE_BD72720,
 	 },
 	{ },
 };
diff --git a/include/linux/mfd/rohm-bd72720.h b/include/linux/mfd/rohm-bd72=
720.h
new file mode 100644
index 000000000000..42fcf8f81b2f
--- /dev/null
+++ b/include/linux/mfd/rohm-bd72720.h
@@ -0,0 +1,634 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright 2024 ROHM Semiconductors.
+ *
+ * Author: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+ */
+
+#ifndef _MFD_BD72720_H
+#define _MFD_BD72720_H
+
+#include <linux/regmap.h>
+
+enum {
+	BD72720_BUCK1,
+	BD72720_BUCK2,
+	BD72720_BUCK3,
+	BD72720_BUCK4,
+	BD72720_BUCK5,
+	BD72720_BUCK6,
+	BD72720_BUCK7,
+	BD72720_BUCK8,
+	BD72720_BUCK9,
+	BD72720_BUCK10,
+	BD72720_BUCK11,
+	BD72720_LDO1,
+	BD72720_LDO2,
+	BD72720_LDO3,
+	BD72720_LDO4,
+	BD72720_LDO5,
+	BD72720_LDO6,
+	BD72720_LDO7,
+	BD72720_LDO8,
+	BD72720_LDO9,
+	BD72720_LDO10,
+	BD72720_LDO11,
+	BD72720_REGULATOR_AMOUNT,
+};
+
+/* BD72720 interrupts */
+#define BD72720_INT_LONGPUSH_MASK	BIT(0)
+#define BD72720_INT_MIDPUSH_MASK	BIT(1)
+#define BD72720_INT_SHORTPUSH_MASK	BIT(2)
+#define BD72720_INT_PUSH_MASK		BIT(3)
+#define BD72720_INT_HALL_DET_MASK	BIT(4)
+#define BD72720_INT_HALL_TGL_MASK	BIT(5)
+#define BD72720_INT_WDOG_MASK		BIT(6)
+#define BD72720_INT_SWRESET_MASK	BIT(7)
+#define BD72720_INT_SEQ_DONE_MASK	BIT(0)
+#define BD72720_INT_PGFAULT_MASK	BIT(4)
+#define BD72720_INT_BUCK1_DVS_MASK	BIT(0)
+#define BD72720_INT_BUCK2_DVS_MASK	BIT(1)
+#define BD72720_INT_BUCK3_DVS_MASK	BIT(2)
+#define BD72720_INT_BUCK4_DVS_MASK	BIT(3)
+#define BD72720_INT_BUCK5_DVS_MASK	BIT(4)
+#define BD72720_INT_BUCK6_DVS_MASK	BIT(5)
+#define BD72720_INT_BUCK7_DVS_MASK	BIT(6)
+#define BD72720_INT_BUCK8_DVS_MASK	BIT(7)
+#define BD72720_INT_BUCK9_DVS_MASK	BIT(0)
+#define BD72720_INT_BUCK10_DVS_MASK	BIT(1)
+#define BD72720_INT_LDO1_DVS_MASK	BIT(4)
+#define BD72720_INT_LDO2_DVS_MASK	BIT(5)
+#define BD72720_INT_LDO3_DVS_MASK	BIT(6)
+#define BD72720_INT_LDO4_DVS_MASK	BIT(7)
+#define BD72720_INT_VBUS_RMV_MASK	BIT(0)
+#define BD72720_INT_VBUS_DET_MASK	BIT(1)
+#define BD72720_INT_VBUS_MON_RES_MASK	BIT(2)
+#define BD72720_INT_VBUS_MON_DET_MASK	BIT(3)
+#define BD72720_INT_VSYS_MON_RES_MASK	BIT(0)
+#define BD72720_INT_VSYS_MON_DET_MASK	BIT(1)
+#define BD72720_INT_VSYS_UV_RES_MASK	BIT(2)
+#define BD72720_INT_VSYS_UV_DET_MASK	BIT(3)
+#define BD72720_INT_VSYS_LO_RES_MASK	BIT(4)
+#define BD72720_INT_VSYS_LO_DET_MASK	BIT(5)
+#define BD72720_INT_VSYS_OV_RES_MASK	BIT(6)
+#define BD72720_INT_VSYS_OV_DET_MASK	BIT(7)
+#define BD72720_INT_BAT_ILIM_MASK	BIT(0)
+#define BD72720_INT_CHG_DONE_MASK	BIT(1)
+#define BD72720_INT_EXTEMP_TOUT_MASK	BIT(2)
+#define BD72720_INT_CHG_WDT_EXP_MASK	BIT(3)
+#define BD72720_INT_BAT_MNT_OUT_MASK	BIT(4)
+#define BD72720_INT_BAT_MNT_IN_MASK	BIT(5)
+#define BD72720_INT_CHG_TRNS_MASK	BIT(7)
+#define BD72720_INT_VBAT_MON_RES_MASK	BIT(0)
+#define BD72720_INT_VBAT_MON_DET_MASK	BIT(1)
+#define BD72720_INT_VBAT_SHT_RES_MASK	BIT(2)
+#define BD72720_INT_VBAT_SHT_DET_MASK	BIT(3)
+#define BD72720_INT_VBAT_LO_RES_MASK	BIT(4)
+#define BD72720_INT_VBAT_LO_DET_MASK	BIT(5)
+#define BD72720_INT_VBAT_OV_RES_MASK	BIT(6)
+#define BD72720_INT_VBAT_OV_DET_MASK	BIT(7)
+#define BD72720_INT_BAT_RMV_MASK	BIT(0)
+#define BD72720_INT_BAT_DET_MASK	BIT(1)
+#define BD72720_INT_DBAT_DET_MASK	BIT(2)
+#define BD72720_INT_BAT_TEMP_TRNS_MASK	BIT(3)
+#define BD72720_INT_LOBTMP_RES_MASK	BIT(4)
+#define BD72720_INT_LOBTMP_DET_MASK	BIT(5)
+#define BD72720_INT_OVBTMP_RES_MASK	BIT(6)
+#define BD72720_INT_OVBTMP_DET_MASK	BIT(7)
+#define BD72720_INT_OCUR1_RES_MASK	BIT(0)
+#define BD72720_INT_OCUR1_DET_MASK	BIT(1)
+#define BD72720_INT_OCUR2_RES_MASK	BIT(2)
+#define BD72720_INT_OCUR2_DET_MASK	BIT(3)
+#define BD72720_INT_OCUR3_RES_MASK	BIT(4)
+#define BD72720_INT_OCUR3_DET_MASK	BIT(5)
+#define BD72720_INT_CC_MON1_DET_MASK	BIT(0)
+#define BD72720_INT_CC_MON2_DET_MASK	BIT(1)
+#define BD72720_INT_CC_MON3_DET_MASK	BIT(2)
+#define BD72720_INT_GPIO1_IN_MASK	BIT(4)
+#define BD72720_INT_GPIO2_IN_MASK	BIT(5)
+#define BD72720_INT_VF125_RES_MASK	BIT(0)
+#define BD72720_INT_VF125_DET_MASK	BIT(1)
+#define BD72720_INT_VF_RES_MASK		BIT(2)
+#define BD72720_INT_VF_DET_MASK		BIT(3)
+#define BD72720_INT_RTC0_MASK		BIT(4)
+#define BD72720_INT_RTC1_MASK		BIT(5)
+#define BD72720_INT_RTC2_MASK		BIT(6)
+
+enum {
+	/*
+	 * The IRQs excluding GPIO1 and GPIO2 are ordered in a same way as the
+	 * respective IRQ bits in status and mask registers are ordered.
+	 *
+	 * The BD72720_INT_GPIO1_IN and BD72720_INT_GPIO2_IN are IRQs which can
+	 * be used by other devices. Let's have  GPIO1 and GPIO2 as first IRQs
+	 * here so we can use the regmap-IRQ with standard device tree xlate
+	 * while devices connected to the BD72720 IRQ input pins can refer to
+	 * the first two interrupt numbers in their device tree. If we placed
+	 * BD72720_INT_GPIO1_IN and BD72720_INT_GPIO2_IN after the CC_MON_DET
+	 * interrupts (like they are in the registers), the devices using
+	 * BD72720 as an IRQ parent should refer the interrupts starting with
+	 * an offset which might not be trivial to understand.
+	 */
+	BD72720_INT_GPIO1_IN,
+	BD72720_INT_GPIO2_IN,
+	BD72720_INT_LONGPUSH,
+	BD72720_INT_MIDPUSH,
+	BD72720_INT_SHORTPUSH,
+	BD72720_INT_PUSH,
+	BD72720_INT_HALL_DET,
+	BD72720_INT_HALL_TGL,
+	BD72720_INT_WDOG,
+	BD72720_INT_SWRESET,
+	BD72720_INT_SEQ_DONE,
+	BD72720_INT_PGFAULT,
+	BD72720_INT_BUCK1_DVS,
+	BD72720_INT_BUCK2_DVS,
+	BD72720_INT_BUCK3_DVS,
+	BD72720_INT_BUCK4_DVS,
+	BD72720_INT_BUCK5_DVS,
+	BD72720_INT_BUCK6_DVS,
+	BD72720_INT_BUCK7_DVS,
+	BD72720_INT_BUCK8_DVS,
+	BD72720_INT_BUCK9_DVS,
+	BD72720_INT_BUCK10_DVS,
+	BD72720_INT_LDO1_DVS,
+	BD72720_INT_LDO2_DVS,
+	BD72720_INT_LDO3_DVS,
+	BD72720_INT_LDO4_DVS,
+	BD72720_INT_VBUS_RMV,
+	BD72720_INT_VBUS_DET,
+	BD72720_INT_VBUS_MON_RES,
+	BD72720_INT_VBUS_MON_DET,
+	BD72720_INT_VSYS_MON_RES,
+	BD72720_INT_VSYS_MON_DET,
+	BD72720_INT_VSYS_UV_RES,
+	BD72720_INT_VSYS_UV_DET,
+	BD72720_INT_VSYS_LO_RES,
+	BD72720_INT_VSYS_LO_DET,
+	BD72720_INT_VSYS_OV_RES,
+	BD72720_INT_VSYS_OV_DET,
+	BD72720_INT_BAT_ILIM,
+	BD72720_INT_CHG_DONE,
+	BD72720_INT_EXTEMP_TOUT,
+	BD72720_INT_CHG_WDT_EXP,
+	BD72720_INT_BAT_MNT_OUT,
+	BD72720_INT_BAT_MNT_IN,
+	BD72720_INT_CHG_TRNS,
+	BD72720_INT_VBAT_MON_RES,
+	BD72720_INT_VBAT_MON_DET,
+	BD72720_INT_VBAT_SHT_RES,
+	BD72720_INT_VBAT_SHT_DET,
+	BD72720_INT_VBAT_LO_RES,
+	BD72720_INT_VBAT_LO_DET,
+	BD72720_INT_VBAT_OV_RES,
+	BD72720_INT_VBAT_OV_DET,
+	BD72720_INT_BAT_RMV,
+	BD72720_INT_BAT_DET,
+	BD72720_INT_DBAT_DET,
+	BD72720_INT_BAT_TEMP_TRNS,
+	BD72720_INT_LOBTMP_RES,
+	BD72720_INT_LOBTMP_DET,
+	BD72720_INT_OVBTMP_RES,
+	BD72720_INT_OVBTMP_DET,
+	BD72720_INT_OCUR1_RES,
+	BD72720_INT_OCUR1_DET,
+	BD72720_INT_OCUR2_RES,
+	BD72720_INT_OCUR2_DET,
+	BD72720_INT_OCUR3_RES,
+	BD72720_INT_OCUR3_DET,
+	BD72720_INT_CC_MON1_DET,
+	BD72720_INT_CC_MON2_DET,
+	BD72720_INT_CC_MON3_DET,
+	BD72720_INT_VF125_RES,
+	BD72720_INT_VF125_DET,
+	BD72720_INT_VF_RES,
+	BD72720_INT_VF_DET,
+	BD72720_INT_RTC0,
+	BD72720_INT_RTC1,
+	BD72720_INT_RTC2,
+};
+
+/*
+ * BD72720 Registers:
+ * The BD72720 has two sets of registers behind two different I2C slave
+ * addresses. "Common" registers being behind 0x4b, the charger registers
+ * being behind 0x4c.
+ */
+/* Registers behind I2C slave 0x4b */
+enum {
+	BD72720_REG_PRODUCT_ID,
+	BD72720_REG_MANUFACTURER_ID,
+	BD72720_REG_PMIC_REV_NUM,
+	BD72720_REG_NVM_REV_NUM,
+	BD72720_REG_BOOTSRC		=3D 0x10,
+	BD72720_REG_RESETSRC_1,
+	BD72720_REG_RESETSRC_2,
+	BD72720_REG_RESETSRC_3,
+	BD72720_REG_RESETSRC_4,
+	BD72720_REG_RESETSRC_5,
+	BD72720_REG_RESETSRC_6,
+	BD72720_REG_RESETSRC_7,
+	BD72720_REG_POWER_STATE,
+	BD72720_REG_PS_CFG,
+	BD72720_REG_PS_CTRL_1,
+	BD72720_REG_PS_CTRL_2,
+	BD72720_REG_RCVCFG,
+	BD72720_REG_RCVNUM,
+	BD72720_REG_CRDCFG,
+	BD72720_REG_REX_CTRL,
+
+	BD72720_REG_BUCK1_ON,
+	BD72720_REG_BUCK1_MODE,
+	/* Deep idle vsel */
+	BD72720_REG_BUCK1_VSEL_DI,
+	/* Idle vsel */
+	BD72720_REG_BUCK1_VSEL_I,
+	/* Suspend vsel */
+	BD72720_REG_BUCK1_VSEL_S,
+	/* Run boot vsel */
+	BD72720_REG_BUCK1_VSEL_RB,
+	/* Run0 ... run3 vsel */
+	BD72720_REG_BUCK1_VSEL_RB0,
+	BD72720_REG_BUCK1_VSEL_RB1,
+	BD72720_REG_BUCK1_VSEL_RB2,
+	BD72720_REG_BUCK1_VSEL_RB3,
+
+	BD72720_REG_BUCK2_ON,
+	BD72720_REG_BUCK2_MODE,
+	BD72720_REG_BUCK2_VSEL_DI,
+	BD72720_REG_BUCK2_VSEL_I,
+	BD72720_REG_BUCK2_VSEL_S,
+	/* Run vsel */
+	BD72720_REG_BUCK2_VSEL_R,
+
+	BD72720_REG_BUCK3_ON,
+	BD72720_REG_BUCK3_MODE,
+	BD72720_REG_BUCK3_VSEL_DI,
+	BD72720_REG_BUCK3_VSEL_I,
+	BD72720_REG_BUCK3_VSEL_S,
+	BD72720_REG_BUCK3_VSEL_R,
+
+	BD72720_REG_BUCK4_ON,
+	BD72720_REG_BUCK4_MODE,
+	BD72720_REG_BUCK4_VSEL_DI,
+	BD72720_REG_BUCK4_VSEL_I,
+	BD72720_REG_BUCK4_VSEL_S,
+	BD72720_REG_BUCK4_VSEL_R,
+
+	BD72720_REG_BUCK5_ON,
+	BD72720_REG_BUCK5_MODE,
+	BD72720_REG_BUCK5_VSEL,
+
+	BD72720_REG_BUCK6_ON,
+	BD72720_REG_BUCK6_MODE,
+	BD72720_REG_BUCK6_VSEL,
+
+	BD72720_REG_BUCK7_ON,
+	BD72720_REG_BUCK7_MODE,
+	BD72720_REG_BUCK7_VSEL,
+
+	BD72720_REG_BUCK8_ON,
+	BD72720_REG_BUCK8_MODE,
+	BD72720_REG_BUCK8_VSEL,
+
+	BD72720_REG_BUCK9_ON,
+	BD72720_REG_BUCK9_MODE,
+	BD72720_REG_BUCK9_VSEL,
+
+	BD72720_REG_BUCK10_ON,
+	BD72720_REG_BUCK10_MODE,
+	BD72720_REG_BUCK10_VSEL,
+
+	BD72720_REG_LDO1_ON,
+	BD72720_REG_LDO1_MODE1,
+	BD72720_REG_LDO1_MODE2,
+	BD72720_REG_LDO1_VSEL_DI,
+	BD72720_REG_LDO1_VSEL_I,
+	BD72720_REG_LDO1_VSEL_S,
+	BD72720_REG_LDO1_VSEL_RB,
+	BD72720_REG_LDO1_VSEL_R0,
+	BD72720_REG_LDO1_VSEL_R1,
+	BD72720_REG_LDO1_VSEL_R2,
+	BD72720_REG_LDO1_VSEL_R3,
+
+	BD72720_REG_LDO2_ON,
+	BD72720_REG_LDO2_MODE,
+	BD72720_REG_LDO2_VSEL_DI,
+	BD72720_REG_LDO2_VSEL_I,
+	BD72720_REG_LDO2_VSEL_S,
+	BD72720_REG_LDO2_VSEL_R,
+
+	BD72720_REG_LDO3_ON,
+	BD72720_REG_LDO3_MODE,
+	BD72720_REG_LDO3_VSEL_DI,
+	BD72720_REG_LDO3_VSEL_I,
+	BD72720_REG_LDO3_VSEL_S,
+	BD72720_REG_LDO3_VSEL_R,
+
+	BD72720_REG_LDO4_ON,
+	BD72720_REG_LDO4_MODE,
+	BD72720_REG_LDO4_VSEL_DI,
+	BD72720_REG_LDO4_VSEL_I,
+	BD72720_REG_LDO4_VSEL_S,
+	BD72720_REG_LDO4_VSEL_R,
+
+	BD72720_REG_LDO5_ON,
+	BD72720_REG_LDO5_MODE,
+	BD72720_REG_LDO5_VSEL,
+
+	BD72720_REG_LDO6_ON,
+	BD72720_REG_LDO6_MODE,
+	BD72720_REG_LDO6_VSEL,
+
+	BD72720_REG_LDO7_ON,
+	BD72720_REG_LDO7_MODE,
+	BD72720_REG_LDO7_VSEL,
+
+	BD72720_REG_LDO8_ON,
+	BD72720_REG_LDO8_MODE,
+	BD72720_REG_LDO8_VSEL,
+
+	BD72720_REG_LDO9_ON,
+	BD72720_REG_LDO9_MODE,
+	BD72720_REG_LDO9_VSEL,
+
+	BD72720_REG_LDO10_ON,
+	BD72720_REG_LDO10_MODE,
+	BD72720_REG_LDO10_VSEL,
+
+	BD72720_REG_LDO11_ON,
+	BD72720_REG_LDO11_MODE,
+	BD72720_REG_LDO11_VSEL,
+
+	BD72720_REG_GPIO1_ON		=3D 0x8b,
+	BD72720_REG_GPIO2_ON,
+	BD72720_REG_GPIO3_ON,
+	BD72720_REG_GPIO4_ON,
+	BD72720_REG_GPIO5_ON,
+
+	BD72720_REG_GPIO1_CTRL,
+	BD72720_REG_GPIO2_CTRL,
+#define BD72720_GPIO_IRQ_TYPE_MASK	GENMASK(6, 4)
+#define BD72720_GPIO_IRQ_TYPE_FALLING	0x0
+#define BD72720_GPIO_IRQ_TYPE_RISING	0x1
+#define BD72720_GPIO_IRQ_TYPE_BOTH	0x2
+#define BD72720_GPIO_IRQ_TYPE_HIGH	0x3
+#define BD72720_GPIO_IRQ_TYPE_LOW	0x4
+	BD72720_REG_GPIO3_CTRL,
+	BD72720_REG_GPIO4_CTRL,
+	BD72720_REG_GPIO5_CTRL,
+#define BD72720_GPIO_DRIVE_MASK		BIT(1)
+#define BD72720_GPIO_HIGH		BIT(0)
+
+	BD72720_REG_EPDEN_CTRL,
+	BD72720_REG_GATECNT_CTRL,
+	BD72720_REG_LED_CTRL,
+
+	BD72720_REG_PWRON_CFG1,
+	BD72720_REG_PWRON_CFG2,
+
+	BD72720_REG_OUT32K,
+	BD72720_REG_CONF,
+	BD72720_REG_HALL_STAT,
+
+	BD72720_REG_RTC_SEC		=3D 0xa0,
+#define BD72720_REG_RTC_START		BD72720_REG_RTC_SEC
+	BD72720_REG_RTC_MIN,
+	BD72720_REG_RTC_HOUR,
+	BD72720_REG_RTC_WEEK,
+	BD72720_REG_RTC_DAY,
+	BD72720_REG_RTC_MON,
+	BD72720_REG_RTC_YEAR,
+
+	BD72720_REG_RTC_ALM0_SEC,
+#define BD72720_REG_RTC_ALM_START	BD72720_REG_RTC_ALM0_SEC
+	BD72720_REG_RTC_ALM0_MIN,
+	BD72720_REG_RTC_ALM0_HOUR,
+	BD72720_REG_RTC_ALM0_WEEK,
+	BD72720_REG_RTC_ALM0_MON,
+	BD72720_REG_RTC_ALM0_YEAR,
+
+	BD72720_REG_RTC_ALM1_SEC,
+	BD72720_REG_RTC_ALM1_MIN,
+	BD72720_REG_RTC_ALM1_HOUR,
+	BD72720_REG_RTC_ALM1_WEEK,
+	BD72720_REG_RTC_ALM1_MON,
+	BD72720_REG_RTC_ALM1_YEAR,
+
+	BD72720_REG_RTC_ALM0_EN,
+	BD72720_REG_RTC_ALM1_EN,
+	BD72720_REG_RTC_ALM2,
+
+	BD72720_REG_INT_LVL1_EN		=3D 0xc0,
+#define BD72720_MASK_LVL1_EN_ALL	GENMASK(7, 0)
+	BD72720_REG_INT_PS1_EN,
+	BD72720_REG_INT_PS2_EN,
+	BD72720_REG_INT_DVS1_EN,
+	BD72720_REG_INT_DVS2_EN,
+	BD72720_REG_INT_VBUS_EN,
+	BD72720_REG_INT_VSYS_EN,
+	BD72720_REG_INT_CHG_EN,
+	BD72720_REG_INT_BAT1_EN,
+	BD72720_REG_INT_BAT2_EN,
+	BD72720_REG_INT_IBAT_EN,
+	BD72720_REG_INT_ETC1_EN,
+	BD72720_REG_INT_ETC2_EN,
+
+	/*
+	 * The _STAT registers inform IRQ line state, and are used to ack IRQ.
+	 * The _SRC registers below indicate current state of the function
+	 * connected to the line.
+	 */
+	BD72720_REG_INT_LVL1_STAT,
+	BD72720_REG_INT_PS1_STAT,
+	BD72720_REG_INT_PS2_STAT,
+	BD72720_REG_INT_DVS1_STAT,
+	BD72720_REG_INT_DVS2_STAT,
+	BD72720_REG_INT_VBUS_STAT,
+	BD72720_REG_INT_VSYS_STAT,
+	BD72720_REG_INT_CHG_STAT,
+	BD72720_REG_INT_BAT1_STAT,
+	BD72720_REG_INT_BAT2_STAT,
+	BD72720_REG_INT_IBAT_STAT,
+	BD72720_REG_INT_ETC1_STAT,
+	BD72720_REG_INT_ETC2_STAT,
+
+	BD72720_REG_INT_LVL1_SRC,
+	BD72720_REG_INT_PS1_SRC,
+	BD72720_REG_INT_PS2_SRC,
+	BD72720_REG_INT_DVS1_SRC,
+	BD72720_REG_INT_DVS2_SRC,
+	BD72720_REG_INT_VBUS_SRC,
+#define BD72720_MASK_DCIN_DET	BIT(1)
+	BD72720_REG_INT_VSYS_SRC,
+	BD72720_REG_INT_CHG_SRC,
+	BD72720_REG_INT_BAT1_SRC,
+	BD72720_REG_INT_BAT2_SRC,
+	BD72720_REG_INT_IBAT_SRC,
+	BD72720_REG_INT_ETC1_SRC,
+	BD72720_REG_INT_ETC2_SRC,
+};
+
+/* Register masks */
+#define BD72720_MASK_DEEP_IDLE_EN	BIT(0)
+#define BD72720_MASK_IDLE_EN		BIT(1)
+#define BD72720_MASK_SUSPEND_EN		BIT(2)
+#define BD72720_MASK_RUN_B_EN		BIT(3)
+#define BD72720_MASK_RUN_0_EN		BIT(4)
+#define BD72720_MASK_RUN_1_EN		BIT(5)
+#define BD72720_MASK_RUN_2_EN		BIT(6)
+#define BD72720_MASK_RUN_3_EN		BIT(7)
+
+#define BD72720_MASK_RAMP_UP_DELAY	GENMASK(7, 6)
+#define BD72720_MASK_BUCK_VSEL		GENMASK(7, 0)
+#define BD72720_MASK_LDO12346_VSEL	GENMASK(6, 0)
+#define BD72720_MASK_LDO_VSEL		GENMASK(7, 0)
+
+#define BD72720_I2C4C_ADDR_OFFSET	0x100
+
+/* Registers behind I2C slave 0x4c */
+enum {
+	BD72720_REG_CHG_STATE =3D BD72720_I2C4C_ADDR_OFFSET,
+	BD72720_REG_CHG_LAST_STATE,
+	BD72720_REG_CHG_VBUS_STAT,
+	BD72720_REG_CHG_VSYS_STAT,
+	BD72720_REG_CHG_BAT_TEMP_STAT,
+	BD72720_REG_CHG_WDT_STAT,
+	BD72720_REG_CHG_ILIM_STAT,
+	BD72720_REG_CHG_CHG_STAT,
+	BD72720_REG_CHG_EN,
+	BD72720_REG_CHG_INIT,
+	BD72720_REG_CHG_CTRL,
+	BD72720_REG_CHG_SET_1,
+	BD72720_REG_CHG_SET_2,
+	BD72720_REG_CHG_SET_3,
+	BD72720_REG_CHG_VPRE,
+	BD72720_REG_CHG_VBAT_1,
+	BD72720_REG_CHG_VBAT_2,
+	BD72720_REG_CHG_VBAT_3,
+	BD72720_REG_CHG_VBAT_4,
+	BD72720_REG_CHG_BAT_SET_1,
+	BD72720_REG_CHG_BAT_SET_2,
+	BD72720_REG_CHG_BAT_SET_3,
+	BD72720_REG_CHG_IPRE,
+	BD72720_REG_CHG_IFST_TERM,
+	BD72720_REG_CHG_VSYS_REG,
+	BD72720_REG_CHG_VBUS_SET,
+	BD72720_REG_CHG_WDT_PRE,
+	BD72720_REG_CHG_WDT_FST,
+	BD72720_REG_CHG_LED_CTRL,
+	BD72720_REG_CHG_CFG_1,
+	BD72720_REG_CHG_IFST_1,
+	BD72720_REG_CHG_IFST_2,
+	BD72720_REG_CHG_IFST_3,
+	BD72720_REG_CHG_IFST_4,
+	BD72720_REG_CHG_S_CFG_1,
+	BD72720_REG_CHG_S_CFG_2,
+	BD72720_REG_RS_VBUS,
+	BD72720_REG_RS_IBUS,
+	BD72720_REG_RS_VSYS,
+	BD72720_REG_VSYS_STATE_STAT,	/* 0x27 + offset*/
+
+	BD72720_REG_VM_VBAT_U		=3D BD72720_I2C4C_ADDR_OFFSET + 0x30,
+	BD72720_REG_VM_VBAT_L,
+	BD72720_REG_VM_OCV_PRE_U,
+	BD72720_REG_VM_OCV_PRE_L,
+	BD72720_REG_VM_OCV_PST_U,
+	BD72720_REG_VM_OCV_PST_L,
+	BD72720_REG_VM_OCV_PWRON_U,
+	BD72720_REG_VM_OCV_PWRON_L,
+	BD72720_REG_VM_DVBAT_IMP_U,
+	BD72720_REG_VM_DVBAT_IMP_L,
+	BD72720_REG_VM_SA_VBAT_U,
+	BD72720_REG_VM_SA_VBAT_L,
+	BD72720_REG_VM_SA_VBAT_MIN_U,
+	BD72720_REG_VM_SA_VBAT_MIN_L,
+	BD72720_REG_VM_SA_VBAT_MAX_U,
+	BD72720_REG_VM_SA_VBAT_MAX_L,
+	BD72720_REG_REX_SA_VBAT_U,
+	BD72720_REG_REX_SA_VBAT_L,
+	BD72720_REG_VM_VSYS_U,
+	BD72720_REG_VM_VSYS_L,
+	BD72720_REG_VM_SA_VSYS_U,
+	BD72720_REG_VM_SA_VSYS_L,
+	BD72720_REG_VM_SA_VSYS_MIN_U,
+	BD72720_REG_VM_SA_VSYS_MIN_L,
+	BD72720_REG_VM_SA_VSYS_MAX_U,
+	BD72720_REG_VM_SA_VSYS_MAX_L,
+	BD72720_REG_VM_SA2_VSYS_U,
+	BD72720_REG_VM_SA2_VSYS_L,
+	BD72720_REG_VM_VBUS_U,
+#define BD72720_MASK_VDCIN_U	GENMASK(3, 0)
+	BD72720_REG_VM_VBUS_L,
+	BD72720_REG_VM_BATID_U,
+	BD72720_REG_VM_BATID_L,
+	BD72720_REG_VM_BATID_NOLOAD_U,
+	BD72720_REG_VM_BATID_NOLOAD_L,
+	BD72720_REG_VM_BATID_OFS_U,
+	BD72720_REG_VM_BATID_OFS_L,
+	BD72720_REG_VM_VTH_U,
+	BD72720_REG_VM_VTH_L,
+	BD72720_REG_VM_VTH_CORR_U,
+	BD72720_REG_VM_VTH_CORR_L,
+	BD72720_REG_VM_BTMP_U,
+	BD72720_REG_VM_BTMP_L,
+	BD72720_REG_VM_BTMP_IMP_U,
+	BD72720_REG_VM_BTMP_IMP_L,
+	BD72720_REG_VM_VF_U,
+	BD72720_REG_VM_VF_L,
+	BD72720_REG_VM_BATID_TH_U,
+	BD72720_REG_VM_BATID_TH_L,
+	BD72720_REG_VM_BTMP_OV_THR,
+	BD72720_REG_VM_BTMP_OV_DUR,
+	BD72720_REG_VM_BTMP_LO_THR,
+	BD72720_REG_VM_BTMP_LO_DUR,
+	BD72720_REG_ALM_VBAT_TH_U,
+	BD72720_REG_ALM_VBAT_TH_L,
+	BD72720_REG_ALM_VSYS_TH,
+	BD72720_REG_ALM_VBUS_TH,
+	BD72720_REG_ALM_VF_TH,
+	BD72720_REG_VSYS_MAX,
+	BD72720_REG_VSYS_MIN,
+	BD72720_REG_VM_VSYS_SA_MINMAX_CTRL,
+	BD72720_REG_VM_SA_CFG,		/* 0x6c + offset*/
+
+	BD72720_REG_CC_CURCD_U		=3D BD72720_I2C4C_ADDR_OFFSET + 0x70,
+	BD72720_REG_CC_CURCD_L,
+	BD72720_REG_CC_CURCD_IMP_U,
+	BD72720_REG_CC_CURCD_IMP_L,
+	BD72720_REG_CC_SA_CURCD_U,
+	BD72720_REG_CC_SA_CURCD_L,
+	BD72720_REG_CC_OCUR_MON,
+	BD72720_REG_CC_CCNTD_3,
+	BD72720_REG_CC_CCNTD_2,
+	BD72720_REG_CC_CCNTD_1,
+	BD72720_REG_CC_CCNTD_0,
+	BD72720_REG_REX_CCNTD_3,
+	BD72720_REG_REX_CCNTD_2,
+	BD72720_REG_REX_CCNTD_1,
+	BD72720_REG_REX_CCNTD_0,
+	BD72720_REG_FULL_CCNTD_3,
+	BD72720_REG_FULL_CCNTD_2,
+	BD72720_REG_FULL_CCNTD_1,
+	BD72720_REG_FULL_CCNTD_0,
+	BD72720_REG_CCNTD_CHG_3,
+	BD72720_REG_CCNTD_CHG_2,
+	BD72720_REG_CC_STAT,
+	BD72720_REG_CC_CTRL,
+	BD72720_REG_CC_OCUR_THR_1,
+	BD72720_REG_CC_OCUR_THR_2,
+	BD72720_REG_CC_OCUR_THR_3,
+	BD72720_REG_REX_CURCD_TH,
+	BD72720_REG_CC_BATCAP1_TH_U,
+	BD72720_REG_CC_BATCAP1_TH_L,
+	BD72720_REG_CC_BATCAP2_TH_U,
+	BD72720_REG_CC_BATCAP2_TH_L,
+	BD72720_REG_CC_BATCAP3_TH_U,
+	BD72720_REG_CC_BATCAP3_TH_L,
+	BD72720_REG_CC_CCNTD_CTRL,
+	BD72720_REG_CC_SA_CFG,		/* 0x92 + offset*/
+	BD72720_REG_IMPCHK_CTRL		=3D BD72720_I2C4C_ADDR_OFFSET + 0xa0,
+};
+
+#endif /* __LINUX_MFD_BD72720_H */
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-gene=
ric.h
index 579e8dcfcca4..0a284919a6c3 100644
--- a/include/linux/mfd/rohm-generic.h
+++ b/include/linux/mfd/rohm-generic.h
@@ -16,6 +16,7 @@ enum rohm_chip_type {
 	ROHM_CHIP_TYPE_BD71828,
 	ROHM_CHIP_TYPE_BD71837,
 	ROHM_CHIP_TYPE_BD71847,
+	ROHM_CHIP_TYPE_BD72720,
 	ROHM_CHIP_TYPE_BD96801,
 	ROHM_CHIP_TYPE_BD96802,
 	ROHM_CHIP_TYPE_BD96805,
--=20
2.51.1


--Q4UAlAKKKSth4iSH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkVnIQACgkQeFA3/03a
ocXzSwf9F6pBeTakhgbnTxxxyoic6ZU12m0oheN/yHmGEksXlObnhL7I2cG7yLXn
XUlVFjyjBmZiJA8qSafKa/WcYftgyuv3KTCLMkGY5uUtJJpFls1oUHIO3gQ6FBo9
jnwLRTr6iqludS+ach3oTSXXkAVUOU1u1TsULJcDoMIRV62zbgvob6JGERb3VA9L
AP0mWetU1C2DCLUzOUHJZrkvaP/qqn/I6PVtvH2ydhi9RL8PHFT/avTWArEQCzCW
b+I7xxnIOgv95rMexi3K+gRBtiloVANx4LEcZhKKGsegB8gmvctU82ty2oSkik4G
8UPKRebLZjcNDOS48C2IsqhETVaX9g==
=wTVc
-----END PGP SIGNATURE-----

--Q4UAlAKKKSth4iSH--

