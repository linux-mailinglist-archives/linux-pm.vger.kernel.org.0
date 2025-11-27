Return-Path: <linux-pm+bounces-38787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01293C8E03E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 12:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E189F3B1BF5
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304C832C948;
	Thu, 27 Nov 2025 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FSgbghVE"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC330E0D3;
	Thu, 27 Nov 2025 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764242383; cv=none; b=B4/gmbOET0vX5jVP+ht60qfymsnW1eGzaElGhp2sFpLQp6zveTzEDIiiUK9h3ex0UEUZdx32LpU723zwg0/b5ghjtxSJolPudLYYgrZxuSfHK3aTDToRlOTO43zPivIG7k+Qwu1IvMjw5jTVRBw1cszIhrLxNOW5LkwzFQoZ6dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764242383; c=relaxed/simple;
	bh=605ZsD0eg0zq89jP81J0FpBM3WqoZh8CvubZga7X2xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB3MZExSNas0Et87XV3ysckrqT55IFCOadhmZkfKr0hRYyL2F9af1oKw5w3c0oFhdvvw2XwLmj1WQR+vwyoi18MDz2jxeH3FI+8+q31z3+n6knhh4X7V6Si9X8LEcqj81ot06FUjANAz/qIde/PJDIqnj0Q+qW46WYL4PnXcCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FSgbghVE; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Nov 2025 13:19:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764242377; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=OE7iy5cfZ6k6v+wb3aZj+KOYsUQYDzWQirwhIp4Y+Bs=;
	b=FSgbghVE3M602lrrI18mrI/ooebK6Bn7IYe9LFw8H71VUCGBXt8VjHnSEBpxQYg1CjPyFV
	VcB81+B4YtgSf4xmlfA2a6RxdeX2Rdb2hSNqD/gD9CAuc+chukLv9ba5hwPKBhMinvmyAM
	ThjzM88YX/tGF6xMVlUUJUO2ZVtaGWQ=
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
Subject: [PATCH v6 11/17] regulator: bd71828: Support ROHM BD72720
Message-ID: <648638a188e1cc6712686310213457c781d840cd.1764241265.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1764241265.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+SoK6pZw+b2bzInr"
Content-Disposition: inline
In-Reply-To: <cover.1764241265.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT


--+SoK6pZw+b2bzInr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

ROHM BD72720 is a power management IC which integrates 10 buck and 11 LDO
regulators. This PMIC has plenty of commonalities with the BD71828 and
BD71879.

The BD72720 does also have similar 'run-level'-concept as the BD71828 had.
It allows controlling the regulator's 'en masse', although only BUCK1
and LDO1 can utilize this in BD72720. Similar to BD71828, this 'en
masse' -control is not supported by this driver.

Support the voltage and enable/disable state control for the BD72720.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Mark Brown <broonie@kernel.org>

---
Revision history:
 v3 =3D>:
 - No changes

 v2 =3D> v3:
 - The ldon-head dt-property was changed to microvolts. Adapt the driver
   to that
 RFCv1 =3D> v2:
 - No changes

There are some new variants planned. Most notably, the BD73900 should be
similar to the BD72720 what comes to the regulator control logic.

If the run-level control is needed, there are some downstream extensions
available at:
https://rohmsemiconductor.github.io/Linux-Kernel-PMIC-Drivers/BD72720/
---
 drivers/regulator/Kconfig             |   8 +-
 drivers/regulator/bd71828-regulator.c | 993 +++++++++++++++++++++++++-
 2 files changed, 992 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index d84f3d054c59..660863f096e3 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -241,13 +241,13 @@ config REGULATOR_BD71815
 	  will be called bd71815-regulator.
=20
 config REGULATOR_BD71828
-	tristate "ROHM BD71828 Power Regulator"
+	tristate "ROHM BD71828, BD72720 and BD73900 Power Regulators"
 	depends on MFD_ROHM_BD71828
 	select REGULATOR_ROHM
 	help
-	  This driver supports voltage regulators on ROHM BD71828 PMIC.
-	  This will enable support for the software controllable buck
-	  and LDO regulators.
+	  This driver supports voltage regulators on ROHM BD71828,
+	  BD71879, BD72720 and BD73900 PMICs. This will enable
+	  support for the software controllable buck and LDO regulators.
=20
 	  This driver can also be built as a module. If so, the module
 	  will be called bd71828-regulator.
diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71=
828-regulator.c
index 3d18dbfdb84e..ba16671ece42 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -3,12 +3,15 @@
 // bd71828-regulator.c ROHM BD71828GW-DS1 regulator driver
 //
=20
+#include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd71828.h>
+#include <linux/mfd/rohm-bd72720.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -16,6 +19,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
=20
+#define BD72720_MASK_LDON_HEAD GENMASK(2, 0)
 struct reg_init {
 	unsigned int reg;
 	unsigned int mask;
@@ -64,6 +68,26 @@ static const struct reg_init bd71828_buck7_inits[] =3D {
 	},
 };
=20
+#define BD72720_MASK_DVS_BUCK1_CTRL BIT(4)
+#define BD72720_MASK_DVS_LDO1_CTRL BIT(5)
+
+static const struct reg_init bd72720_buck1_inits[] =3D {
+	{
+		.reg =3D BD72720_REG_PS_CTRL_2,
+		.mask =3D BD72720_MASK_DVS_BUCK1_CTRL,
+		.val =3D 0, /* Disable "run-level" control */
+	},
+};
+
+static const struct reg_init bd72720_ldo1_inits[] =3D {
+	{
+		.reg =3D BD72720_REG_PS_CTRL_2,
+		.mask =3D BD72720_MASK_DVS_LDO1_CTRL,
+		.val =3D 0, /* Disable "run-level" control */
+	},
+};
+
+/* BD71828 Buck voltages */
 static const struct linear_range bd71828_buck1267_volts[] =3D {
 	REGULATOR_LINEAR_RANGE(500000, 0x00, 0xef, 6250),
 	REGULATOR_LINEAR_RANGE(2000000, 0xf0, 0xff, 0),
@@ -84,13 +108,79 @@ static const struct linear_range bd71828_buck5_volts[]=
 =3D {
 	REGULATOR_LINEAR_RANGE(3300000, 0x10, 0x1f, 0),
 };
=20
+/* BD71828 LDO voltages */
 static const struct linear_range bd71828_ldo_volts[] =3D {
 	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x31, 50000),
 	REGULATOR_LINEAR_RANGE(3300000, 0x32, 0x3f, 0),
 };
=20
+/* BD72720 Buck voltages */
+static const struct linear_range bd72720_buck1234_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0xc0, 6250),
+	REGULATOR_LINEAR_RANGE(1700000, 0xc1, 0xff, 0),
+};
+
+static const struct linear_range bd72720_buck589_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0x78, 10000),
+	REGULATOR_LINEAR_RANGE(1700000, 0x79, 0xff, 0),
+};
+
+static const struct linear_range bd72720_buck67_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(1500000, 0x00, 0xb4, 10000),
+	REGULATOR_LINEAR_RANGE(3300000, 0xb5, 0xff, 0),
+};
+
+/*
+ * The BUCK10 on BD72720 has two modes of operation, depending on a LDON_H=
EAD
+ * setting. When LDON_HEAD is 0x0, the behaviour is as with other bucks, e=
g.
+ * voltage can be set to a values indicated below using the VSEL register.
+ *
+ * However, when LDON_HEAD is set to 0x1 ... 0x7, BUCK 10 voltage is, acco=
rding
+ * to the data-sheet, "automatically adjusted following LDON_HEAD setting =
and
+ * clamped to BUCK10_VID setting".
+ *
+ * Again, reading the data-sheet shows a "typical connection" where the BU=
CK10
+ * is used to supply the LDOs 1-4. My assumption is that in practice, this
+ * means that the BUCK10 voltage will be adjusted based on the maximum out=
put
+ * of the LDO 1-4 (to minimize power loss). This makes sense.
+ *
+ * Auto-adjusting regulators aren't something I really like to model in the
+ * driver though - and, if the auto-adjustment works as intended, then the=
re
+ * should really be no need to software to care about the buck10 voltages.
+ * If enable/disable control is still needed, we can implement buck10 as a
+ * regulator with only the enable/disable ops - and device-tree can be used
+ * to model the supply-relations. I believe this could allow the regulator
+ * framework to automagically disable the BUCK10 if all LDOs that are being
+ * supplied by it are disabled.
+ */
+static const struct linear_range bd72720_buck10_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0xc0, 6250),
+	REGULATOR_LINEAR_RANGE(1700000, 0xc1, 0xff, 0),
+};
+
+/* BD72720 LDO voltages */
+static const struct linear_range bd72720_ldo1234_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0x50, 6250),
+	REGULATOR_LINEAR_RANGE(1000000, 0x51, 0x7f, 0),
+};
+
+static const struct linear_range bd72720_ldo57891011_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(750000, 0x00, 0xff, 10000),
+};
+
+static const struct linear_range bd72720_ldo6_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x78, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0x79, 0x7f, 0),
+};
+
 static const unsigned int bd71828_ramp_delay[] =3D { 2500, 5000, 10000, 20=
000 };
=20
+/*
+ * BD72720 supports setting both the ramp-up and ramp-down values
+ * separately. Do we need to support ramp-down setting?
+ */
+static const unsigned int bd72720_ramp_delay[] =3D { 5000, 7500, 10000, 12=
500 };
+
 static int buck_set_hw_dvs_levels(struct device_node *np,
 				  const struct regulator_desc *desc,
 				  struct regulator_config *cfg)
@@ -171,6 +261,24 @@ static const struct regulator_ops bd71828_ldo6_ops =3D=
 {
 	.is_enabled =3D regulator_is_enabled_regmap,
 };
=20
+static const struct regulator_ops bd72720_regulator_ops =3D {
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.list_voltage =3D regulator_list_voltage_linear_range,
+	.set_voltage_sel =3D regulator_set_voltage_sel_regmap,
+	.get_voltage_sel =3D regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel =3D regulator_set_voltage_time_sel,
+	.set_ramp_delay =3D regulator_set_ramp_delay_regmap,
+};
+
+static const struct regulator_ops bd72720_buck10_ldon_head_op =3D {
+	.enable =3D regulator_enable_regmap,
+	.disable =3D regulator_disable_regmap,
+	.is_enabled =3D regulator_is_enabled_regmap,
+	.set_ramp_delay =3D regulator_set_ramp_delay_regmap,
+};
+
 static const struct bd71828_regulator_data bd71828_rdata[] =3D {
 	{
 		.desc =3D {
@@ -677,22 +785,890 @@ static const struct bd71828_regulator_data bd71828_r=
data[] =3D {
 	},
 };
=20
+#define BD72720_BUCK10_DESC_INDEX 10
+#define BD72720_NUM_BUCK_VOLTS 0x100
+#define BD72720_NUM_LDO_VOLTS 0x100
+#define BD72720_NUM_LDO12346_VOLTS 0x80
+
+static const struct bd71828_regulator_data bd72720_rdata[] =3D {
+	{
+		.desc =3D {
+			.name =3D "buck1",
+			.of_match =3D of_match_ptr("buck1"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_BUCK1,
+			.type =3D REGULATOR_VOLTAGE,
+
+			/*
+			 * The BD72720 BUCK1 and LDO1 support GPIO toggled
+			 * sub-RUN states called RUN0, RUN1, RUN2 and RUN3.
+			 * The "operating mode" (sub-RUN states or normal)
+			 * can be changed by a register.
+			 *
+			 * When the sub-RUN states are used, the voltage and
+			 * enable state depend on a state specific
+			 * configuration. The voltage and enable configuration
+			 * for BUCK1 and LDO1 can be defined for each sub-RUN
+			 * state using BD72720_REG_[BUCK,LDO]1_VSEL_R[0,1,2,3]
+			 * voltage selection registers and the bits
+			 * BD72720_MASK_RUN_[0,1,2,3]_EN in the enable registers.
+			 * The PMIC will change both the BUCK1 and LDO1 voltages
+			 * to the states defined in these registers when
+			 * "DVS GPIOs" are toggled.
+			 *
+			 * If RUN 0 .. RUN 4 states are to be used, the normal
+			 * voltage configuration mechanisms do not apply
+			 * and we should overwrite the ops and ignore the
+			 * voltage setting/getting registers which are setup
+			 * here. This is not supported for now. If you need
+			 * this functionality, you may try merging functionality
+			 * from a downstream driver:
+			 * https://rohmsemiconductor.github.io/Linux-Kernel-PMIC-Drivers/BD7272=
0/
+			 */
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_buck1234_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_buck1234_volts),
+			.n_voltages =3D BD72720_NUM_BUCK_VOLTS,
+			.enable_reg =3D BD72720_REG_BUCK1_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_BUCK1_VSEL_RB,
+			.vsel_mask =3D BD72720_MASK_BUCK_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_BUCK1_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR, /* Deep idle in data-sheet */
+			.run_reg =3D BD72720_REG_BUCK1_VSEL_RB,
+			.run_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_reg =3D BD72720_REG_BUCK1_VSEL_I,
+			.idle_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_reg =3D BD72720_REG_BUCK1_VSEL_S,
+			.suspend_mask =3D BD72720_MASK_BUCK_VSEL,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_reg =3D BD72720_REG_BUCK1_VSEL_DI,
+			.lpsr_mask =3D BD72720_MASK_BUCK_VSEL,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+		.reg_inits =3D bd72720_buck1_inits,
+		.reg_init_amnt =3D ARRAY_SIZE(bd72720_buck1_inits),
+	}, {
+		.desc =3D {
+			.name =3D "buck2",
+			.of_match =3D of_match_ptr("buck2"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_BUCK2,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_buck1234_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_buck1234_volts),
+			.n_voltages =3D BD72720_NUM_BUCK_VOLTS,
+			.enable_reg =3D BD72720_REG_BUCK2_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_BUCK2_VSEL_R,
+			.vsel_mask =3D BD72720_MASK_BUCK_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_BUCK2_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_BUCK2_VSEL_R,
+			.run_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_reg =3D BD72720_REG_BUCK2_VSEL_I,
+			.idle_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_reg =3D BD72720_REG_BUCK2_VSEL_S,
+			.suspend_mask =3D BD72720_MASK_BUCK_VSEL,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_reg =3D BD72720_REG_BUCK2_VSEL_DI,
+			.lpsr_mask =3D BD72720_MASK_BUCK_VSEL,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck3",
+			.of_match =3D of_match_ptr("buck3"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_BUCK3,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_buck1234_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_buck1234_volts),
+			.n_voltages =3D BD72720_NUM_BUCK_VOLTS,
+			.enable_reg =3D BD72720_REG_BUCK3_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_BUCK3_VSEL_R,
+			.vsel_mask =3D BD72720_MASK_BUCK_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_BUCK3_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_BUCK3_VSEL_R,
+			.run_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_reg =3D BD72720_REG_BUCK3_VSEL_I,
+			.idle_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_reg =3D BD72720_REG_BUCK3_VSEL_S,
+			.suspend_mask =3D BD72720_MASK_BUCK_VSEL,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_reg =3D BD72720_REG_BUCK3_VSEL_DI,
+			.lpsr_mask =3D BD72720_MASK_BUCK_VSEL,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck4",
+			.of_match =3D of_match_ptr("buck4"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_BUCK4,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_buck1234_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_buck1234_volts),
+			.n_voltages =3D BD72720_NUM_BUCK_VOLTS,
+			.enable_reg =3D BD72720_REG_BUCK4_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_BUCK4_VSEL_R,
+			.vsel_mask =3D BD72720_MASK_BUCK_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_BUCK4_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_BUCK4_VSEL_R,
+			.run_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_reg =3D BD72720_REG_BUCK4_VSEL_I,
+			.idle_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_reg =3D BD72720_REG_BUCK4_VSEL_S,
+			.suspend_mask =3D BD72720_MASK_BUCK_VSEL,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_reg =3D BD72720_REG_BUCK4_VSEL_DI,
+			.lpsr_mask =3D BD72720_MASK_BUCK_VSEL,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck5",
+			.of_match =3D of_match_ptr("buck5"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_BUCK5,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_buck589_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_buck589_volts),
+			.n_voltages =3D BD72720_NUM_BUCK_VOLTS,
+			.enable_reg =3D BD72720_REG_BUCK5_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_BUCK5_VSEL,
+			.vsel_mask =3D BD72720_MASK_BUCK_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_BUCK5_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_BUCK5_VSEL,
+			.run_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck6",
+			.of_match =3D of_match_ptr("buck6"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_BUCK6,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_buck67_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_buck67_volts),
+			.n_voltages =3D BD72720_NUM_BUCK_VOLTS,
+			.enable_reg =3D BD72720_REG_BUCK6_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_BUCK6_VSEL,
+			.vsel_mask =3D BD72720_MASK_BUCK_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_BUCK6_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_BUCK6_VSEL,
+			.run_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck7",
+			.of_match =3D of_match_ptr("buck7"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_BUCK7,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_buck67_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_buck67_volts),
+			.n_voltages =3D BD72720_NUM_BUCK_VOLTS,
+			.enable_reg =3D BD72720_REG_BUCK7_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_BUCK7_VSEL,
+			.vsel_mask =3D BD72720_MASK_BUCK_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_BUCK7_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_BUCK7_VSEL,
+			.run_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck8",
+			.of_match =3D of_match_ptr("buck8"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_BUCK8,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_buck589_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_buck589_volts),
+			.n_voltages =3D BD72720_NUM_BUCK_VOLTS,
+			.enable_reg =3D BD72720_REG_BUCK8_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_BUCK8_VSEL,
+			.vsel_mask =3D BD72720_MASK_BUCK_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_BUCK8_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_BUCK8_VSEL,
+			.run_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck9",
+			.of_match =3D of_match_ptr("buck9"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_BUCK9,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_buck589_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_buck589_volts),
+			.n_voltages =3D BD72720_NUM_BUCK_VOLTS,
+			.enable_reg =3D BD72720_REG_BUCK9_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_BUCK9_VSEL,
+			.vsel_mask =3D BD72720_MASK_BUCK_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_BUCK9_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_BUCK9_VSEL,
+			.run_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck10",
+			.of_match =3D of_match_ptr("buck10"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_BUCK10,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_buck10_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_buck10_volts),
+			.n_voltages =3D BD72720_NUM_BUCK_VOLTS,
+			.enable_reg =3D BD72720_REG_BUCK10_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_BUCK10_VSEL,
+			.vsel_mask =3D BD72720_MASK_BUCK_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_BUCK10_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_BUCK10_VSEL,
+			.run_mask =3D BD72720_MASK_BUCK_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo1",
+			.of_match =3D of_match_ptr("ldo1"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_LDO1,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_ldo1234_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_ldo1234_volts),
+			.n_voltages =3D BD72720_NUM_LDO12346_VOLTS,
+			.enable_reg =3D BD72720_REG_LDO1_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_LDO1_VSEL_RB,
+			.vsel_mask =3D BD72720_MASK_LDO12346_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_LDO1_MODE1,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_LDO1_VSEL_RB,
+			.run_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.idle_reg =3D BD72720_REG_LDO1_VSEL_I,
+			.idle_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_reg =3D BD72720_REG_LDO1_VSEL_S,
+			.suspend_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_reg =3D BD72720_REG_LDO1_VSEL_DI,
+			.lpsr_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+		.reg_inits =3D bd72720_ldo1_inits,
+		.reg_init_amnt =3D ARRAY_SIZE(bd72720_ldo1_inits),
+	}, {
+		.desc =3D {
+			.name =3D "ldo2",
+			.of_match =3D of_match_ptr("ldo2"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_LDO2,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_ldo1234_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_ldo1234_volts),
+			.n_voltages =3D BD72720_NUM_LDO12346_VOLTS,
+			.enable_reg =3D BD72720_REG_LDO2_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_LDO2_VSEL_R,
+			.vsel_mask =3D BD72720_MASK_LDO12346_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_LDO2_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_LDO2_VSEL_R,
+			.run_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.idle_reg =3D BD72720_REG_LDO2_VSEL_I,
+			.idle_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_reg =3D BD72720_REG_LDO2_VSEL_S,
+			.suspend_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_reg =3D BD72720_REG_LDO2_VSEL_DI,
+			.lpsr_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo3",
+			.of_match =3D of_match_ptr("ldo3"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_LDO3,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_ldo1234_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_ldo1234_volts),
+			.n_voltages =3D BD72720_NUM_LDO12346_VOLTS,
+			.enable_reg =3D BD72720_REG_LDO3_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_LDO3_VSEL_R,
+			.vsel_mask =3D BD72720_MASK_LDO12346_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_LDO3_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_LDO3_VSEL_R,
+			.run_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.idle_reg =3D BD72720_REG_LDO3_VSEL_I,
+			.idle_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_reg =3D BD72720_REG_LDO3_VSEL_S,
+			.suspend_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_reg =3D BD72720_REG_LDO3_VSEL_DI,
+			.lpsr_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo4",
+			.of_match =3D of_match_ptr("ldo4"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_LDO4,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_ldo1234_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_ldo1234_volts),
+			.n_voltages =3D BD72720_NUM_LDO12346_VOLTS,
+			.enable_reg =3D BD72720_REG_LDO4_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_LDO4_VSEL_R,
+			.vsel_mask =3D BD72720_MASK_LDO12346_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_LDO4_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_LDO4_VSEL_R,
+			.run_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.idle_reg =3D BD72720_REG_LDO4_VSEL_I,
+			.idle_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_reg =3D BD72720_REG_LDO4_VSEL_S,
+			.suspend_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_reg =3D BD72720_REG_LDO4_VSEL_DI,
+			.lpsr_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo5",
+			.of_match =3D of_match_ptr("ldo5"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_LDO5,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_ldo57891011_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_ldo57891011_volts),
+			.n_voltages =3D BD72720_NUM_LDO_VOLTS,
+			.enable_reg =3D BD72720_REG_LDO5_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_LDO5_VSEL,
+			.vsel_mask =3D BD72720_MASK_LDO_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_LDO5_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_LDO5_VSEL,
+			.run_mask =3D BD72720_MASK_LDO_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo6",
+			.of_match =3D of_match_ptr("ldo6"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_LDO6,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_ldo6_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_ldo6_volts),
+			.n_voltages =3D BD72720_NUM_LDO12346_VOLTS,
+			.enable_reg =3D BD72720_REG_LDO6_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_LDO6_VSEL,
+			.vsel_mask =3D BD72720_MASK_LDO12346_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_LDO6_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_LDO6_VSEL,
+			.run_mask =3D BD72720_MASK_LDO12346_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo7",
+			.of_match =3D of_match_ptr("ldo7"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_LDO7,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_ldo57891011_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_ldo57891011_volts),
+			.n_voltages =3D BD72720_NUM_LDO_VOLTS,
+			.enable_reg =3D BD72720_REG_LDO7_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_LDO7_VSEL,
+			.vsel_mask =3D BD72720_MASK_LDO_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_LDO7_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_LDO7_VSEL,
+			.run_mask =3D BD72720_MASK_LDO_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo8",
+			.of_match =3D of_match_ptr("ldo8"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_LDO8,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_ldo57891011_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_ldo57891011_volts),
+			.n_voltages =3D BD72720_NUM_LDO_VOLTS,
+			.enable_reg =3D BD72720_REG_LDO8_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_LDO8_VSEL,
+			.vsel_mask =3D BD72720_MASK_LDO_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_LDO8_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_LDO8_VSEL,
+			.run_mask =3D BD72720_MASK_LDO_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo9",
+			.of_match =3D of_match_ptr("ldo9"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_LDO9,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_ldo57891011_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_ldo57891011_volts),
+			.n_voltages =3D BD72720_NUM_LDO_VOLTS,
+			.enable_reg =3D BD72720_REG_LDO9_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_LDO9_VSEL,
+			.vsel_mask =3D BD72720_MASK_LDO_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_LDO9_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_LDO9_VSEL,
+			.run_mask =3D BD72720_MASK_LDO_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo10",
+			.of_match =3D of_match_ptr("ldo10"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_LDO10,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_ldo57891011_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_ldo57891011_volts),
+			.n_voltages =3D BD72720_NUM_LDO_VOLTS,
+			.enable_reg =3D BD72720_REG_LDO10_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_LDO10_VSEL,
+			.vsel_mask =3D BD72720_MASK_LDO_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_LDO10_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_LDO10_VSEL,
+			.run_mask =3D BD72720_MASK_LDO_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	}, {
+		.desc =3D {
+			.name =3D "ldo11",
+			.of_match =3D of_match_ptr("ldo11"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD72720_LDO11,
+			.type =3D REGULATOR_VOLTAGE,
+			.ops =3D &bd72720_regulator_ops,
+			.linear_ranges =3D bd72720_ldo57891011_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd72720_ldo57891011_volts),
+			.n_voltages =3D BD72720_NUM_LDO_VOLTS,
+			.enable_reg =3D BD72720_REG_LDO11_ON,
+			.enable_mask =3D BD72720_MASK_RUN_B_EN,
+			.vsel_reg =3D BD72720_REG_LDO11_VSEL,
+			.vsel_mask =3D BD72720_MASK_LDO_VSEL,
+
+			.ramp_delay_table =3D bd72720_ramp_delay,
+			.n_ramp_values =3D ARRAY_SIZE(bd72720_ramp_delay),
+			.ramp_reg =3D BD72720_REG_LDO11_MODE,
+			.ramp_mask =3D BD72720_MASK_RAMP_UP_DELAY,
+			.owner =3D THIS_MODULE,
+			.of_parse_cb =3D buck_set_hw_dvs_levels,
+		},
+		.dvs =3D {
+			.level_map =3D ROHM_DVS_LEVEL_RUN | ROHM_DVS_LEVEL_IDLE |
+				     ROHM_DVS_LEVEL_SUSPEND |
+				     ROHM_DVS_LEVEL_LPSR,
+			.run_reg =3D BD72720_REG_LDO11_VSEL,
+			.run_mask =3D BD72720_MASK_LDO_VSEL,
+			.idle_on_mask =3D BD72720_MASK_IDLE_EN,
+			.suspend_on_mask =3D BD72720_MASK_SUSPEND_EN,
+			.lpsr_on_mask =3D BD72720_MASK_DEEP_IDLE_EN,
+		},
+	},
+};
+
+static int bd72720_buck10_ldon_head_mode(struct device *dev,
+					 struct device_node *npreg,
+					 struct regmap *regmap,
+					 struct regulator_desc *buck10_desc)
+{
+	struct device_node *np __free(device_node) =3D
+		of_get_child_by_name(npreg, "buck10");
+	uint32_t ldon_head;
+	int ldon_val;
+	int ret;
+
+	if (!np) {
+		dev_err(dev, "failed to find buck10 regulator node\n");
+		return -ENODEV;
+	}
+
+	ret =3D of_property_read_u32(np, "rohm,ldon-head-microvolt", &ldon_head);
+	if (ret =3D=3D -EINVAL)
+		return 0;
+	if (ret)
+		return ret;
+
+	/*
+	 * LDON_HEAD mode means the BUCK10 is used to supply LDOs 1-4 and
+	 * the BUCK 10 voltage is automatically set to follow LDO 1-4
+	 * settings. Thus the BUCK10 should not allow voltage [g/s]etting.
+	 */
+	buck10_desc->ops =3D &bd72720_buck10_ldon_head_op;
+
+	ldon_val =3D ldon_head / 50000 + 1;
+	if (ldon_head > 300000) {
+		dev_warn(dev, "Unsupported LDON_HEAD, clamping to 300 mV\n");
+		ldon_val =3D 7;
+	}
+
+	return regmap_update_bits(regmap, BD72720_REG_LDO1_MODE2,
+				  BD72720_MASK_LDON_HEAD, ldon_val);
+}
+
+static int bd72720_dt_parse(struct device *dev,
+			    struct regulator_desc *buck10_desc,
+			    struct regmap *regmap)
+{
+	struct device_node *nproot __free(device_node) =3D
+		of_get_child_by_name(dev->parent->of_node, "regulators");
+
+	if (!nproot) {
+		dev_err(dev, "failed to find regulators node\n");
+		return -ENODEV;
+	}
+
+	return bd72720_buck10_ldon_head_mode(dev, nproot, regmap, buck10_desc);
+}
+
 static int bd71828_probe(struct platform_device *pdev)
 {
-	int i, j, ret;
+	int i, j, ret, num_regulators;
 	struct regulator_config config =3D {
 		.dev =3D pdev->dev.parent,
 	};
+	enum rohm_chip_type chip =3D platform_get_device_id(pdev)->driver_data;
+	struct bd71828_regulator_data *rdata;
=20
 	config.regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
 	if (!config.regmap)
 		return -ENODEV;
=20
-	for (i =3D 0; i < ARRAY_SIZE(bd71828_rdata); i++) {
+	switch (chip) {
+	case ROHM_CHIP_TYPE_BD72720:
+		rdata =3D devm_kmemdup(&pdev->dev, bd72720_rdata,
+				     sizeof(bd72720_rdata), GFP_KERNEL);
+		if (!rdata)
+			return -ENOMEM;
+
+		ret =3D bd72720_dt_parse(&pdev->dev, &rdata[BD72720_BUCK10_DESC_INDEX].d=
esc,
+				       config.regmap);
+		if (ret)
+			return ret;
+
+		num_regulators =3D ARRAY_SIZE(bd72720_rdata);
+		break;
+
+	case ROHM_CHIP_TYPE_BD71828:
+		rdata =3D devm_kmemdup(&pdev->dev, bd71828_rdata,
+				     sizeof(bd71828_rdata), GFP_KERNEL);
+		if (!rdata)
+			return -ENOMEM;
+
+		num_regulators =3D ARRAY_SIZE(bd71828_rdata);
+
+		break;
+	default:
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Unsupported device\n");
+	}
+
+	for (i =3D 0; i < num_regulators; i++) {
 		struct regulator_dev *rdev;
-		const struct bd71828_regulator_data *rd;
+		struct bd71828_regulator_data *rd;
+
+		rd =3D &rdata[i];
=20
-		rd =3D &bd71828_rdata[i];
+		config.driver_data =3D rd;
 		rdev =3D devm_regulator_register(&pdev->dev,
 					       &rd->desc, &config);
 		if (IS_ERR(rdev))
@@ -714,12 +1690,20 @@ static int bd71828_probe(struct platform_device *pde=
v)
 	return 0;
 }
=20
+static const struct platform_device_id bd71828_pmic_id[] =3D {
+	{ "bd71828-pmic", ROHM_CHIP_TYPE_BD71828 },
+	{ "bd72720-pmic", ROHM_CHIP_TYPE_BD72720 },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, bd71828_pmic_id);
+
 static struct platform_driver bd71828_regulator =3D {
 	.driver =3D {
 		.name =3D "bd71828-pmic",
 		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe =3D bd71828_probe,
+	.id_table =3D bd71828_pmic_id,
 };
=20
 module_platform_driver(bd71828_regulator);
@@ -727,4 +1711,3 @@ module_platform_driver(bd71828_regulator);
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
 MODULE_DESCRIPTION("BD71828 voltage regulator driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:bd71828-pmic");
--=20
2.52.0


--+SoK6pZw+b2bzInr
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmkoM8IACgkQeFA3/03a
ocUWCwgAouGsmgAuD67+TYs8uy1Nvq5qxo7RqxegwEFLITAywnTPRT8sWIOIuEIW
qMsPDnHKAhoEGM+wZMORtrGOuiAqApNHuhlHhVme9OLO4PLA3FKqXi33jam+6MaT
YxqHfH/LwMWeZpe9Wg1P7LICSVuu7aQbchwdh77iWsgI2UBaNgjT+f/+wSVXfitg
PsQrmKBmYlpSQ6NCsmbncjyrx5R8h3bzPZw856oZQvWKNEQT73F5U6Zyvsp1W7NE
Jl9Ax4fDmwVEqvYcNSgoqEwhpvmOaOYkgyv0HYylIv1i6HrqFXmxbHC6mnsKG2Cx
ShTwJgzuWCoiYj9LgT3clwXU8SJydA==
=/b5E
-----END PGP SIGNATURE-----

--+SoK6pZw+b2bzInr--

