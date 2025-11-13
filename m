Return-Path: <linux-pm+bounces-37930-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E629C5680D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 10:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9F0D3598C4
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A6F33436F;
	Thu, 13 Nov 2025 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NtjW5dhB"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E383346AB
	for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2025 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024169; cv=none; b=ITk+VKxwFvww6IkJMWVoozAIRJDHNyiAvyKyBZuwirQdJSHq9PwlyxtpY0NUZEd0rJCN4SMwiiuhbpJys3XSxIHEYH2scKArguYNNdsFn5rUNohVj6se6wGLP/a22p9gH7U5RZ1pDPg1LtVk1z8MnSltljGjO5TDYbVa4K1nXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024169; c=relaxed/simple;
	bh=kCoYiDIEJXTWnJJ91GW2oTmv8V4l5uFRK1MDrMzowAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFQUKt7NtuVoC707Ye3w7zZFY14ddVXC2MZaMJRmu3KvSlS7xVhbZOV12bxu/MKuYP3ubXTavAmaTZy2tBEc8Myaw6cZhJCHKfXvzsT1Ft6172RtLtRWC2jUMldvLVWktY5ODaJ1krvb3KgaQaP8A4CjlwLVVfsrwtjUv/QyKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NtjW5dhB; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 13 Nov 2025 10:55:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763024162; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=p369BFLcTOxfBLF5WSAZbvmk0j4GSSLyZhaVjj9+fw4=;
	b=NtjW5dhBE+QtShoFsEa6nwg/IHnuO+cvqddx2rjbz8yj6qs08nD0XPJRu2C6AcviL7FKf0
	ugCDTE9TSFQqEdKd4hAhe4YshhfaC6+d57RrFnmnhLQS01Z/EO+RRFWaKzVyrAIb2sPtci
	P/03tWdAWK7kb73MzxqdWHmk33OemR0=
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
Subject: [PATCH v4 15/16] power: supply: bd71828-power: Support ROHM BD72720
Message-ID: <4c83dd363ad493446bdb2c0a6e8add05bd62a0cb.1763022807.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1763022807.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c2fj4v70nTXxzG3/"
Content-Disposition: inline
In-Reply-To: <cover.1763022807.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--c2fj4v70nTXxzG3/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The ROHM BD72720 is a power management IC with a charger and coulomb
counter block which is closely related to the charger / coulomb counter
found from the BD71815, BD71828, BD71879 which are all supported by the
bd71828-power driver. Due to the similarities it makes sense to support
also the BD72720 with the same driver.

Add basic support for the charger logic on ROHM BD72720.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
 v2 =3D> :
 - No changes

 RFCv1 =3D> v2:
 - Support using 9-bit register addresses (offset of 0x100) with the
   BD72720
 - Simplify probe and IC data as we don't need two regmaps
 - Drop two BD72720 specific functions as we no longer need different
   regmap for it.

Note: This patch depends on the series: "power: supply: add charger for
BD71828" by Andreas:
https://lore.kernel.org/all/20250918-bd71828-charger-v5-0-851164839c28@kemn=
ade.info/

NOTE: Fuel-gauging is not supported. You can find an unmaintained
downstream reference-driver with a fuel-gauge example from:
https://github.com/RohmSemiconductor/Linux-Kernel-PMIC-Drivers/releases/tag=
/bd72720-reference-driver-v1
---
 drivers/power/supply/bd71828-power.c | 134 +++++++++++++++++++++++----
 1 file changed, 116 insertions(+), 18 deletions(-)

diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd=
71828-power.c
index ce73c0f48397..438e220a9cb7 100644
--- a/drivers/power/supply/bd71828-power.c
+++ b/drivers/power/supply/bd71828-power.c
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd71815.h>
 #include <linux/mfd/rohm-bd71828.h>
+#include <linux/mfd/rohm-bd72720.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
@@ -51,12 +52,14 @@ struct pwr_regs {
 	unsigned int chg_state;
 	unsigned int bat_temp;
 	unsigned int dcin_stat;
+	unsigned int dcin_online_mask;
 	unsigned int dcin_collapse_limit;
 	unsigned int chg_set1;
 	unsigned int chg_en;
 	unsigned int vbat_alm_limit_u;
 	unsigned int conf;
 	unsigned int vdcin;
+	unsigned int vdcin_himask;
 };
=20
 static const struct pwr_regs pwr_regs_bd71828 =3D {
@@ -67,12 +70,14 @@ static const struct pwr_regs pwr_regs_bd71828 =3D {
 	.chg_state =3D BD71828_REG_CHG_STATE,
 	.bat_temp =3D BD71828_REG_BAT_TEMP,
 	.dcin_stat =3D BD71828_REG_DCIN_STAT,
+	.dcin_online_mask =3D BD7182x_MASK_DCIN_DET,
 	.dcin_collapse_limit =3D BD71828_REG_DCIN_CLPS,
 	.chg_set1 =3D BD71828_REG_CHG_SET1,
 	.chg_en   =3D BD71828_REG_CHG_EN,
 	.vbat_alm_limit_u =3D BD71828_REG_ALM_VBAT_LIMIT_U,
 	.conf =3D BD71828_REG_CONF,
 	.vdcin =3D BD71828_REG_VDCIN_U,
+	.vdcin_himask =3D BD7182x_MASK_VDCIN_U,
 };
=20
 static const struct pwr_regs pwr_regs_bd71815 =3D {
@@ -85,6 +90,7 @@ static const struct pwr_regs pwr_regs_bd71815 =3D {
 	.chg_state =3D BD71815_REG_CHG_STATE,
 	.bat_temp =3D BD71815_REG_BAT_TEMP,
 	.dcin_stat =3D BD71815_REG_DCIN_STAT,
+	.dcin_online_mask =3D BD7182x_MASK_DCIN_DET,
 	.dcin_collapse_limit =3D BD71815_REG_DCIN_CLPS,
 	.chg_set1 =3D BD71815_REG_CHG_SET1,
 	.chg_en   =3D BD71815_REG_CHG_SET1,
@@ -92,6 +98,31 @@ static const struct pwr_regs pwr_regs_bd71815 =3D {
 	.conf =3D BD71815_REG_CONF,
=20
 	.vdcin =3D BD71815_REG_VM_DCIN_U,
+	.vdcin_himask =3D BD7182x_MASK_VDCIN_U,
+};
+
+static struct pwr_regs pwr_regs_bd72720 =3D {
+	.vbat_avg =3D BD72720_REG_VM_SA_VBAT_U,
+	.ibat =3D BD72720_REG_CC_CURCD_U,
+	.ibat_avg =3D BD72720_REG_CC_SA_CURCD_U,
+	.btemp_vth =3D BD72720_REG_VM_BTMP_U,
+	/*
+	 * Note, state 0x40 IMP_CHK. not documented
+	 * on other variants but was still handled in
+	 * existing code. No memory traces as to why.
+	 */
+	.chg_state =3D BD72720_REG_CHG_STATE,
+	.bat_temp =3D BD72720_REG_CHG_BAT_TEMP_STAT,
+	.dcin_stat =3D BD72720_REG_INT_VBUS_SRC,
+	.dcin_online_mask =3D BD72720_MASK_DCIN_DET,
+	.dcin_collapse_limit =3D -1, /* Automatic. Setting not supported */
+	.chg_set1 =3D BD72720_REG_CHG_SET_1,
+	.chg_en =3D BD72720_REG_CHG_EN,
+	/* 15mV note in data-sheet */
+	.vbat_alm_limit_u =3D BD72720_REG_ALM_VBAT_TH_U,
+	.conf =3D BD72720_REG_CONF, /* o XSTB, only PON. Seprate slave addr */
+	.vdcin =3D BD72720_REG_VM_VBUS_U, /* 10 bits not 11 as with other ICs */
+	.vdcin_himask =3D BD72720_MASK_VDCIN_U,
 };
=20
 struct bd71828_power {
@@ -298,7 +329,7 @@ static int get_chg_online(struct bd71828_power *pwr, in=
t *chg_online)
 		dev_err(pwr->dev, "Failed to read DCIN status\n");
 		return ret;
 	}
-	*chg_online =3D ((r & BD7182x_MASK_DCIN_DET) !=3D 0);
+	*chg_online =3D ((r & pwr->regs->dcin_online_mask) !=3D 0);
=20
 	return 0;
 }
@@ -329,8 +360,8 @@ static int bd71828_bat_inserted(struct bd71828_power *p=
wr)
 	ret =3D val & BD7182x_MASK_CONF_PON;
=20
 	if (ret)
-		regmap_update_bits(pwr->regmap, pwr->regs->conf,
-				   BD7182x_MASK_CONF_PON, 0);
+		if (regmap_update_bits(pwr->regmap, pwr->regs->conf, BD7182x_MASK_CONF_P=
ON, 0))
+			dev_err(pwr->dev, "Failed to write CONF register\n");
=20
 	return ret;
 }
@@ -358,11 +389,13 @@ static int bd71828_init_hardware(struct bd71828_power=
 *pwr)
 	int ret;
=20
 	/* TODO: Collapse limit should come from device-tree ? */
-	ret =3D regmap_write(pwr->regmap, pwr->regs->dcin_collapse_limit,
-			   BD7182x_DCIN_COLLAPSE_DEFAULT);
-	if (ret) {
-		dev_err(pwr->dev, "Failed to write DCIN collapse limit\n");
-		return ret;
+	if (pwr->regs->dcin_collapse_limit !=3D (unsigned int)-1) {
+		ret =3D regmap_write(pwr->regmap, pwr->regs->dcin_collapse_limit,
+				   BD7182x_DCIN_COLLAPSE_DEFAULT);
+		if (ret) {
+			dev_err(pwr->dev, "Failed to write DCIN collapse limit\n");
+			return ret;
+		}
 	}
=20
 	ret =3D pwr->bat_inserted(pwr);
@@ -419,7 +452,7 @@ static int bd71828_charger_get_property(struct power_su=
pply *psy,
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret =3D bd7182x_read16_himask(pwr, pwr->regs->vdcin,
-					    BD7182x_MASK_VDCIN_U, &tmp);
+					    pwr->regs->vdcin_himask, &tmp);
 		if (ret)
 			return ret;
=20
@@ -630,6 +663,9 @@ BD_ISR_AC(dcin_ovp_det, "DCIN OVER VOLTAGE", true)
 BD_ISR_DUMMY(dcin_mon_det, "DCIN voltage below threshold")
 BD_ISR_DUMMY(dcin_mon_res, "DCIN voltage above threshold")
=20
+BD_ISR_DUMMY(vbus_curr_limit, "VBUS current limited")
+BD_ISR_DUMMY(vsys_ov_res, "VSYS over-voltage cleared")
+BD_ISR_DUMMY(vsys_ov_det, "VSYS over-voltage")
 BD_ISR_DUMMY(vsys_uv_res, "VSYS under-voltage cleared")
 BD_ISR_DUMMY(vsys_uv_det, "VSYS under-voltage")
 BD_ISR_DUMMY(vsys_low_res, "'VSYS low' cleared")
@@ -878,6 +914,51 @@ static int bd7182x_get_irqs(struct platform_device *pd=
ev,
 		BDIRQ("bd71828-temp-125-over", bd71828_temp_vf125_det),
 		BDIRQ("bd71828-temp-125-under", bd71828_temp_vf125_res),
 	};
+	static const struct bd7182x_irq_res bd72720_irqs[] =3D {
+		BDIRQ("bd72720_int_vbus_rmv", BD_ISR_NAME(dcin_removed)),
+		BDIRQ("bd72720_int_vbus_det", bd7182x_dcin_detected),
+		BDIRQ("bd72720_int_vbus_mon_res", BD_ISR_NAME(dcin_mon_res)),
+		BDIRQ("bd72720_int_vbus_mon_det", BD_ISR_NAME(dcin_mon_det)),
+		BDIRQ("bd72720_int_vsys_mon_res", BD_ISR_NAME(vsys_mon_res)),
+		BDIRQ("bd72720_int_vsys_mon_det", BD_ISR_NAME(vsys_mon_det)),
+		BDIRQ("bd72720_int_vsys_uv_res", BD_ISR_NAME(vsys_uv_res)),
+		BDIRQ("bd72720_int_vsys_uv_det", BD_ISR_NAME(vsys_uv_det)),
+		BDIRQ("bd72720_int_vsys_lo_res", BD_ISR_NAME(vsys_low_res)),
+		BDIRQ("bd72720_int_vsys_lo_det", BD_ISR_NAME(vsys_low_det)),
+		BDIRQ("bd72720_int_vsys_ov_res", BD_ISR_NAME(vsys_ov_res)),
+		BDIRQ("bd72720_int_vsys_ov_det", BD_ISR_NAME(vsys_ov_det)),
+		BDIRQ("bd72720_int_bat_ilim", BD_ISR_NAME(vbus_curr_limit)),
+		BDIRQ("bd72720_int_chg_done", bd718x7_chg_done),
+		BDIRQ("bd72720_int_extemp_tout", BD_ISR_NAME(chg_wdg_temp)),
+		BDIRQ("bd72720_int_chg_wdt_exp", BD_ISR_NAME(chg_wdg)),
+		BDIRQ("bd72720_int_bat_mnt_out", BD_ISR_NAME(rechg_res)),
+		BDIRQ("bd72720_int_bat_mnt_in", BD_ISR_NAME(rechg_det)),
+		BDIRQ("bd72720_int_chg_trns", BD_ISR_NAME(chg_state_changed)),
+
+		BDIRQ("bd72720_int_vbat_mon_res", BD_ISR_NAME(bat_mon_res)),
+		BDIRQ("bd72720_int_vbat_mon_det", BD_ISR_NAME(bat_mon)),
+		BDIRQ("bd72720_int_vbat_sht_res", BD_ISR_NAME(bat_short_res)),
+		BDIRQ("bd72720_int_vbat_sht_det", BD_ISR_NAME(bat_short)),
+		BDIRQ("bd72720_int_vbat_lo_res", BD_ISR_NAME(bat_low_res)),
+		BDIRQ("bd72720_int_vbat_lo_det", BD_ISR_NAME(bat_low)),
+		BDIRQ("bd72720_int_vbat_ov_res", BD_ISR_NAME(bat_ov_res)),
+		BDIRQ("bd72720_int_vbat_ov_det", BD_ISR_NAME(bat_ov)),
+		BDIRQ("bd72720_int_bat_rmv", BD_ISR_NAME(bat_removed)),
+		BDIRQ("bd72720_int_bat_det", BD_ISR_NAME(bat_det)),
+		BDIRQ("bd72720_int_dbat_det", BD_ISR_NAME(bat_dead)),
+		BDIRQ("bd72720_int_bat_temp_trns", BD_ISR_NAME(temp_transit)),
+		BDIRQ("bd72720_int_lobtmp_res", BD_ISR_NAME(temp_bat_low_res)),
+		BDIRQ("bd72720_int_lobtmp_det", BD_ISR_NAME(temp_bat_low)),
+		BDIRQ("bd72720_int_ovbtmp_res", BD_ISR_NAME(temp_bat_hi_res)),
+		BDIRQ("bd72720_int_ovbtmp_det", BD_ISR_NAME(temp_bat_hi)),
+		BDIRQ("bd72720_int_ocur1_res", BD_ISR_NAME(bat_oc1_res)),
+		BDIRQ("bd72720_int_ocur1_det", BD_ISR_NAME(bat_oc1)),
+		BDIRQ("bd72720_int_ocur2_res", BD_ISR_NAME(bat_oc2_res)),
+		BDIRQ("bd72720_int_ocur2_det", BD_ISR_NAME(bat_oc2)),
+		BDIRQ("bd72720_int_ocur3_res", BD_ISR_NAME(bat_oc3_res)),
+		BDIRQ("bd72720_int_ocur3_det", BD_ISR_NAME(bat_oc3)),
+		BDIRQ("bd72720_int_cc_mon2_det", BD_ISR_NAME(bat_cc_mon)),
+	};
 	int num_irqs;
 	const struct bd7182x_irq_res *irqs;
=20
@@ -890,6 +971,10 @@ static int bd7182x_get_irqs(struct platform_device *pd=
ev,
 		irqs =3D &bd71815_irqs[0];
 		num_irqs =3D ARRAY_SIZE(bd71815_irqs);
 		break;
+	case ROHM_CHIP_TYPE_BD72720:
+		irqs =3D &bd72720_irqs[0];
+		num_irqs =3D ARRAY_SIZE(bd72720_irqs);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -958,21 +1043,27 @@ static int bd71828_power_probe(struct platform_devic=
e *pdev)
 	struct power_supply_config ac_cfg =3D {};
 	struct power_supply_config bat_cfg =3D {};
 	int ret;
-	struct regmap *regmap;
-
-	regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
-	if (!regmap) {
-		dev_err(&pdev->dev, "No parent regmap\n");
-		return -EINVAL;
-	}
=20
 	pwr =3D devm_kzalloc(&pdev->dev, sizeof(*pwr), GFP_KERNEL);
 	if (!pwr)
 		return -ENOMEM;
=20
-	pwr->regmap =3D regmap;
-	pwr->dev =3D &pdev->dev;
+	/*
+	 * The BD72720 MFD device registers two regmaps. Power-supply driver
+	 * uses the "wrap-map", which provides access to both of the I2C slave
+	 * addresses used by the BD72720
+	 */
 	pwr->chip_type =3D platform_get_device_id(pdev)->driver_data;
+	if (pwr->chip_type !=3D ROHM_CHIP_TYPE_BD72720)
+		pwr->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
+	else
+		pwr->regmap =3D dev_get_regmap(pdev->dev.parent, "wrap-map");
+	if (!pwr->regmap) {
+		dev_err(&pdev->dev, "No parent regmap\n");
+		return -EINVAL;
+	}
+
+	pwr->dev =3D &pdev->dev;
=20
 	switch (pwr->chip_type) {
 	case ROHM_CHIP_TYPE_BD71828:
@@ -985,6 +1076,12 @@ static int bd71828_power_probe(struct platform_device=
 *pdev)
 		pwr->get_temp =3D bd71815_get_temp;
 		pwr->regs =3D &pwr_regs_bd71815;
 		break;
+	case ROHM_CHIP_TYPE_BD72720:
+		pwr->bat_inserted =3D bd71828_bat_inserted;
+		pwr->regs =3D &pwr_regs_bd72720;
+		pwr->get_temp =3D bd71828_get_temp;
+		dev_dbg(pwr->dev, "Found ROHM BD72720\n");
+		break;
 	default:
 		dev_err(pwr->dev, "Unknown PMIC\n");
 		return -EINVAL;
@@ -1030,6 +1127,7 @@ static int bd71828_power_probe(struct platform_device=
 *pdev)
 static const struct platform_device_id bd71828_charger_id[] =3D {
 	{ "bd71815-power", ROHM_CHIP_TYPE_BD71815 },
 	{ "bd71828-power", ROHM_CHIP_TYPE_BD71828 },
+	{ "bd72720-power", ROHM_CHIP_TYPE_BD72720 },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, bd71828_charger_id);
--=20
2.51.1


--c2fj4v70nTXxzG3/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkVnRsACgkQeFA3/03a
ocW+cAf+O9clxhkaaHMPxeclC9tdvVlH/U3sbTghLqGGCHLwlP/FH2KAqVcNnjde
ciye21jnFoYliw4mKW7Ymw+Kr9hEI8p8gPqJYtICfDnwGPl0gFoDkj/8sVjlvryX
QCbsjIVjWXxecFHYvOz3mAAI3nZ4m+H2lBLCWsmhwB1kyGWVW3B18R9PjVeGeCGN
QO638P/WnxLR4ac9DnMFVkl1VBV7oAahtQYZ0XqewBIFempWplYgD1aoOQujh7oJ
IaIct92rJVZTO4P9cYSUchOTiR7SA2owK5ab+5LjSOVXWbe9DQjod0pY6FFqjpAW
P0A8k6kzyy0pOnd4TR24fxn+/xO0Jg==
=QhAN
-----END PGP SIGNATURE-----

--c2fj4v70nTXxzG3/--

