Return-Path: <linux-pm+bounces-32742-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FB6B2E664
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 22:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1262E189E04E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 20:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBF92BEC4E;
	Wed, 20 Aug 2025 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="gIYNfFna"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AA29B8E1;
	Wed, 20 Aug 2025 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755721317; cv=none; b=ZGDKaigjSwjUqb6RabmX+JhwmvjB5hFtXTyXOvR8bTgUIg23OttJ3HPXy7TSU4qzwI6lxkw+cF+U/5rQw8u37iX02b99u/QRzfPOZK6c2n8c8zvhKgU3oyokhfqphucQa5xfBkpwpsWEPGZgAjOnQZZ3HsCtkhvTGr6sI7GvA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755721317; c=relaxed/simple;
	bh=mEhS30Oupg/K8ngK8yixG1LI/lbzJXTbVz8EkgttMUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gP6Xv3v/Gp/SieygosZ3fdtktONq9/Sa1C7W4f3rqgIkL7fu5jeOPyxL7CBJ8soDQ2cv2rRTk9buVmaxlw50j8X+7PslHAH+q09Y5e3GmEUJkBLM/xqvttMLiKnhk4gPVaWDSd5irn1lkAB0FyJ0AEX0Enli5gPNrvEJcil0L04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=gIYNfFna; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:In-Reply-To:References:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=c76nMO+uSGoS3+9L1mYQORTx4QUKa9ae5OvbSwJ6sEw=; b=gIYNfFna8+PGthCFX4srTy+VTs
	AnbDd6OcMQcpT0RuNENhx7KvsQa1upVZfZb0Sl0EDPNWclSvnBAVjpsJZGAu6XueLLTCSOuym/sTL
	vWkSVABqjwqjF28pPHbYrK2lJN7l+CqsOYeNmJO1d80dYKFOKKgiotCQUNOdhOMTOYVU1KvJEdlCb
	TZOhKGNlgMBW+IewsV6mcf9cpw9LnI9izqGQQxCR/c2f83ld3hz8MfK3iOb/Pnea+q3hNiCJ6rr/5
	YCdLiANNjPR/+t3mtfAR45ZPtIMUUHheuF+9f/Bb8lo3rxlDmPOSeAbIp/dNDh0ML0iExmgyMQw4S
	1gB1+ZSw==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 20 Aug 2025 22:21:41 +0200
Subject: [PATCH v2 2/2] power: supply: Add bd718(15/28/78) charger driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-bd71828-charger-v2-2-32fc96027e92@kemnade.info>
References: <20250820-bd71828-charger-v2-0-32fc96027e92@kemnade.info>
In-Reply-To: <20250820-bd71828-charger-v2-0-32fc96027e92@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=35547; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=mEhS30Oupg/K8ngK8yixG1LI/lbzJXTbVz8EkgttMUA=;
 b=owGbwMvMwCEm/rzkS6lq2x3G02pJDBnL9GIrhLSfb7Vzlq6dKX8tm5l93xfzsy8ikr8cb5Vt8
 yqvCJrQUcrCIMbBICumyPLLWsHtk8qz3OCpEfYwc1iZQIYwcHEKwETCyxgZvv3WY51jy37yV3gr
 v5K4UmHCzgunToalfA//UWi529PmOsMfrn/TTBMk1bctVnA8w2d38Jlt/Kej71LXNWRZXWMSn32
 fDQA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Add charger driver for ROHM BD718(15/28/78) PMIC charger block.
It is a stripped down version of the driver here:
https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.1637061794.git.matti.vaittinen@fi.rohmeurope.com/

For the ease of review and to do a step-by-step approach remove all the
coloumb counter related stuff and do not sneak in BD71827 support. That
also avoids non-trivial rebasing of the above series.

Changes besides that:
Replace the custom property by a standard one and do not use megaohms
for the current sense resistor.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/power/supply/Kconfig         |    9 +
 drivers/power/supply/Makefile        |    1 +
 drivers/power/supply/bd71828-power.c | 1135 ++++++++++++++++++++++++++++++++++
 3 files changed, 1145 insertions(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 79ddb006e2dad6bf96b71ed570a37c006b5f9433..16dddb2355d9b89ccf0ad453fb77c189cf36f00f 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -974,6 +974,15 @@ config CHARGER_UCS1002
 	  Say Y to enable support for Microchip UCS1002 Programmable
 	  USB Port Power Controller with Charger Emulation.
 
+config CHARGER_BD71828
+	tristate "Power-supply driver for ROHM BD71828 and BD71815 PMIC"
+	depends on MFD_ROHM_BD71828
+	help
+	  Say Y here to enable support for charger and battery
+	  in ROHM BD71815, BD71817, ROHM BD71828 power management
+	  ICs. This driver gets various bits of information about battery
+	  and charger states.
+
 config CHARGER_BD99954
 	tristate "ROHM bd99954 charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index f943c9150b326d41ff241f82610f70298635eb08..c6520a11f021c872f01250ae54eb4c63018cd428 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
 obj-$(CONFIG_FUEL_GAUGE_STC3117)       += stc3117_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
+obj-$(CONFIG_CHARGER_BD71828)	+= bd71828-power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
 obj-$(CONFIG_RN5T618_POWER)	+= rn5t618_power.o
diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/bd71828-power.c
new file mode 100644
index 0000000000000000000000000000000000000000..f074d7159de1cb832bc0fb5ab494cddeb96a8968
--- /dev/null
+++ b/drivers/power/supply/bd71828-power.c
@@ -0,0 +1,1135 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * bd71828-power.c
+ * @file ROHM BD71815, BD71828 and BD71878 Charger driver
+ *
+ * Copyright 2021.
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/rohm-bd71815.h>
+#include <linux/mfd/rohm-bd71828.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+/* common defines */
+#define BD7182x_MASK_VBAT_U			0x1f
+#define BD7182x_MASK_VDCIN_U			0x0f
+#define BD7182x_MASK_IBAT_U			0x3f
+#define BD7182x_MASK_CURDIR_DISCHG		0x80
+#define BD7182x_MASK_CC_CCNTD_HI		0x0FFF
+#define BD7182x_MASK_CC_CCNTD			0x0FFFFFFF
+#define BD7182x_MASK_CHG_STATE			0x7f
+#define BD7182x_MASK_CC_FULL_CLR		0x10
+#define BD7182x_MASK_BAT_TEMP			0x07
+#define BD7182x_MASK_DCIN_DET			BIT(0)
+#define BD7182x_MASK_CONF_PON			BIT(0)
+#define BD71815_MASK_CONF_XSTB			BIT(1)
+#define BD7182x_MASK_BAT_STAT			0x3f
+#define BD7182x_MASK_DCIN_STAT			0x07
+
+#define BD7182x_MASK_CCNTRST			0x80
+#define BD7182x_MASK_CCNTENB			0x40
+#define BD7182x_MASK_CCCALIB			0x20
+#define BD7182x_MASK_WDT_AUTO			0x40
+#define BD7182x_MASK_VBAT_ALM_LIMIT_U		0x01
+#define BD7182x_MASK_CHG_EN			0x01
+
+#define BD7182x_DCIN_COLLAPSE_DEFAULT		0x36
+
+/* Measured min and max value clear bits */
+#define BD718XX_MASK_VSYS_MIN_AVG_CLR		0x10
+
+#define MAX_CURRENT_DEFAULT			890000		/* uA */
+#define AC_NAME					"bd71828_ac"
+#define BAT_NAME				"bd71828_bat"
+
+/*
+ * VBAT Low voltage detection Threshold
+ * 0x00D4*16mV = 212*0.016 = 3.392v
+ */
+#define VBAT_LOW_TH			0x00D4
+
+#define THR_RELAX_CURRENT_DEFAULT		5		/* mA */
+#define THR_RELAX_TIME_DEFAULT			(60 * 60)	/* sec. */
+
+#define DGRD_CYC_CAP_DEFAULT			88	/* 1 micro Ah */
+
+#define DGRD_TEMP_H_DEFAULT			450	/* 0.1 degrees C */
+#define DGRD_TEMP_M_DEFAULT			250	/* 0.1 degrees C */
+#define DGRD_TEMP_L_DEFAULT			50	/* 0.1 degrees C */
+#define DGRD_TEMP_VL_DEFAULT			0	/* 0.1 degrees C */
+
+#define SOC_EST_MAX_NUM_DEFAULT			5
+#define PWRCTRL_NORMAL				0x22
+#define PWRCTRL_RESET				0x23
+
+/*
+ * Originally we relied upon a fixed size table of OCV and VDR params.
+ * However the exising linux power-supply batinfo interface for getting the OCV
+ * values from DT does not have fixed amount of OCV values. Thus we use fixed
+ * parameter amount only for values provided as module params - and use this
+ * only as maximum number of parameters when values come from DT.
+ */
+#define NUM_BAT_PARAMS				23
+#define MAX_NUM_VDR_VALUES NUM_BAT_PARAMS
+
+struct pwr_regs {
+	int used_init_regs;
+	u8 vbat_init;
+	u8 vbat_init2;
+	u8 vbat_init3;
+	u8 vbat_avg;
+	u8 ibat;
+	u8 ibat_avg;
+	u8 meas_clear;
+	u8 vsys_min_avg;
+	u8 btemp_vth;
+	u8 chg_state;
+	u8 coulomb3;
+	u8 coulomb2;
+	u8 coulomb1;
+	u8 coulomb0;
+	u8 coulomb_ctrl;
+	u8 vbat_rex_avg;
+	u8 coulomb_full3;
+	u8 cc_full_clr;
+	u8 coulomb_chg3;
+	u8 bat_temp;
+	u8 dcin_stat;
+	u8 dcin_collapse_limit;
+	u8 chg_set1;
+	u8 chg_en;
+	u8 vbat_alm_limit_u;
+	u8 batcap_mon_limit_u;
+	u8 conf;
+	u8 vdcin;
+};
+
+static const struct pwr_regs pwr_regs_bd71828 = {
+	.vbat_init = BD71828_REG_VBAT_INITIAL1_U,
+	.vbat_init2 = BD71828_REG_VBAT_INITIAL2_U,
+	.vbat_init3 = BD71828_REG_OCV_PWRON_U,
+	.used_init_regs = 3,
+	.vbat_avg = BD71828_REG_VBAT_U,
+	.ibat = BD71828_REG_IBAT_U,
+	.ibat_avg = BD71828_REG_IBAT_AVG_U,
+	.meas_clear = BD71828_REG_MEAS_CLEAR,
+	.vsys_min_avg = BD71828_REG_VSYS_MIN_AVG_U,
+	.btemp_vth = BD71828_REG_VM_BTMP_U,
+	.chg_state = BD71828_REG_CHG_STATE,
+	.coulomb3 = BD71828_REG_CC_CNT3,
+	.coulomb2 = BD71828_REG_CC_CNT2,
+	.coulomb1 = BD71828_REG_CC_CNT1,
+	.coulomb0 = BD71828_REG_CC_CNT0,
+	.coulomb_ctrl = BD71828_REG_COULOMB_CTRL,
+	.vbat_rex_avg = BD71828_REG_VBAT_REX_AVG_U,
+	.coulomb_full3 = BD71828_REG_CC_CNT_FULL3,
+	.cc_full_clr = BD71828_REG_COULOMB_CTRL2,
+	.coulomb_chg3 = BD71828_REG_CC_CNT_CHG3,
+	.bat_temp = BD71828_REG_BAT_TEMP,
+	.dcin_stat = BD71828_REG_DCIN_STAT,
+	.dcin_collapse_limit = BD71828_REG_DCIN_CLPS,
+	.chg_set1 = BD71828_REG_CHG_SET1,
+	.chg_en   = BD71828_REG_CHG_EN,
+	.vbat_alm_limit_u = BD71828_REG_ALM_VBAT_LIMIT_U,
+	.batcap_mon_limit_u = BD71828_REG_BATCAP_MON_LIMIT_U,
+	.conf = BD71828_REG_CONF,
+	.vdcin = BD71828_REG_VDCIN_U,
+};
+
+static const struct pwr_regs pwr_regs_bd71815 = {
+	.vbat_init = BD71815_REG_VM_OCV_PRE_U,
+	.vbat_init2 = BD71815_REG_VM_OCV_PST_U,
+	.used_init_regs = 2,
+	.vbat_avg = BD71815_REG_VM_SA_VBAT_U,
+	/* BD71815 does not have separate current and current avg */
+	.ibat = BD71815_REG_CC_CURCD_U,
+	.ibat_avg = BD71815_REG_CC_CURCD_U,
+
+	.meas_clear = BD71815_REG_VM_SA_MINMAX_CLR,
+	.vsys_min_avg = BD71815_REG_VM_SA_VSYS_MIN_U,
+	.btemp_vth = BD71815_REG_VM_BTMP,
+	.chg_state = BD71815_REG_CHG_STATE,
+	.coulomb3 = BD71815_REG_CC_CCNTD_3,
+	.coulomb2 = BD71815_REG_CC_CCNTD_2,
+	.coulomb1 = BD71815_REG_CC_CCNTD_1,
+	.coulomb0 = BD71815_REG_CC_CCNTD_0,
+	.coulomb_ctrl = BD71815_REG_CC_CTRL,
+	.vbat_rex_avg = BD71815_REG_REX_SA_VBAT_U,
+	.coulomb_full3 = BD71815_REG_FULL_CCNTD_3,
+	.cc_full_clr = BD71815_REG_FULL_CTRL,
+	.coulomb_chg3 = BD71815_REG_CCNTD_CHG_3,
+	.bat_temp = BD71815_REG_BAT_TEMP,
+	.dcin_stat = BD71815_REG_DCIN_STAT,
+	.dcin_collapse_limit = BD71815_REG_DCIN_CLPS,
+	.chg_set1 = BD71815_REG_CHG_SET1,
+	.chg_en   = BD71815_REG_CHG_SET1,
+	.vbat_alm_limit_u = BD71815_REG_ALM_VBAT_TH_U,
+	.batcap_mon_limit_u = BD71815_REG_CC_BATCAP1_TH_U,
+	.conf = BD71815_REG_CONF,
+
+	.vdcin = BD71815_REG_VM_DCIN_U,
+};
+
+struct bd71828_power {
+	struct regmap *regmap;
+	enum rohm_chip_type chip_type;
+	struct device *dev;
+	struct power_supply *ac;
+	struct power_supply *bat;
+
+	const struct pwr_regs *regs;
+	/* Reg val to uA */
+	int curr_factor;
+	int rsens;
+	int (*get_temp)(struct bd71828_power *pwr, int *temp);
+	int (*bat_inserted)(struct bd71828_power *pwr);
+};
+
+static int bd7182x_write16(struct bd71828_power *pwr, int reg, u16 val)
+{
+	__be16 tmp;
+
+	tmp = cpu_to_be16(val);
+
+	return regmap_bulk_write(pwr->regmap, reg, &tmp, sizeof(tmp));
+}
+
+static int bd7182x_read16_himask(struct bd71828_power *pwr, int reg, int himask,
+				 u16 *val)
+{
+	struct regmap *regmap = pwr->regmap;
+	int ret;
+	__be16 rvals;
+	u8 *tmp = (u8 *)&rvals;
+
+	ret = regmap_bulk_read(regmap, reg, &rvals, sizeof(*val));
+	if (!ret) {
+		*tmp &= himask;
+		*val = be16_to_cpu(rvals);
+	}
+	return ret;
+}
+
+static int bd71828_get_vbat(struct bd71828_power *pwr, int *vcell)
+{
+	u16 tmp_vcell;
+	int ret;
+
+	ret = bd7182x_read16_himask(pwr, pwr->regs->vbat_avg,
+				    BD7182x_MASK_VBAT_U, &tmp_vcell);
+	if (ret)
+		dev_err(pwr->dev, "Failed to read battery average voltage\n");
+	else
+		*vcell = ((int)tmp_vcell) * 1000;
+
+	return ret;
+}
+
+static int bd71828_get_current_ds_adc(struct bd71828_power *pwr, int *curr, int *curr_avg)
+{
+	__be16 tmp_curr;
+	char *tmp = (char *)&tmp_curr;
+	int dir = 1;
+	int regs[] = { pwr->regs->ibat, pwr->regs->ibat_avg };
+	int *vals[] = { curr, curr_avg };
+	int ret, i;
+
+	for (dir = 1, i = 0; i < ARRAY_SIZE(regs); i++) {
+		ret = regmap_bulk_read(pwr->regmap, regs[i], &tmp_curr,
+				       sizeof(tmp_curr));
+		if (ret)
+			break;
+
+		if (*tmp & BD7182x_MASK_CURDIR_DISCHG)
+			dir = -1;
+
+		*tmp &= BD7182x_MASK_IBAT_U;
+
+		*vals[i] = dir * ((int)be16_to_cpu(tmp_curr)) * pwr->curr_factor;
+	}
+
+	return ret;
+}
+
+/* Unit is tenths of degree C */
+static int bd71815_get_temp(struct bd71828_power *pwr, int *temp)
+{
+	struct regmap *regmap = pwr->regmap;
+	int ret;
+	int t;
+
+	ret = regmap_read(regmap, pwr->regs->btemp_vth, &t);
+	if (ret)
+		return ret;
+
+	t = 200 - t;
+
+	if (t > 200) {
+		dev_err(pwr->dev, "Failed to read battery temperature\n");
+		return -ENODATA;
+	}
+
+	return 0;
+}
+
+/* Unit is tenths of degree C */
+static int bd71828_get_temp(struct bd71828_power *pwr, int *temp)
+{
+	u16 t;
+	int ret;
+	int tmp = 200 * 10000;
+
+	ret = bd7182x_read16_himask(pwr, pwr->regs->btemp_vth,
+				    BD71828_MASK_VM_BTMP_U, &t);
+	if (ret)
+		return ret;
+
+	if (t > 3200) {
+		dev_err(pwr->dev,
+			"Failed to read battery temperature\n");
+		return -ENODATA;
+	}
+
+	tmp -= 625ULL * (unsigned int)t;
+	*temp = tmp / 1000;
+
+	return ret;
+}
+
+static int bd71828_charge_status(struct bd71828_power *pwr,
+				 int *s, int *h)
+{
+	unsigned int state;
+	int status, health;
+	int ret = 1;
+
+	ret = regmap_read(pwr->regmap, pwr->regs->chg_state, &state);
+	if (ret)
+		dev_err(pwr->dev, "charger status reading failed (%d)\n", ret);
+
+	state &= BD7182x_MASK_CHG_STATE;
+
+	dev_dbg(pwr->dev, "CHG_STATE %d\n", state);
+
+	switch (state) {
+	case 0x00:
+		ret = 0;
+		status = POWER_SUPPLY_STATUS_DISCHARGING;
+		health = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case 0x01:
+	case 0x02:
+	case 0x03:
+	case 0x0E:
+		status = POWER_SUPPLY_STATUS_CHARGING;
+		health = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case 0x0F:
+		ret = 0;
+		status = POWER_SUPPLY_STATUS_FULL;
+		health = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case 0x10:
+	case 0x11:
+	case 0x12:
+	case 0x13:
+	case 0x14:
+	case 0x20:
+	case 0x21:
+	case 0x22:
+	case 0x23:
+	case 0x24:
+		ret = 0;
+		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		health = POWER_SUPPLY_HEALTH_OVERHEAT;
+		break;
+	case 0x30:
+	case 0x31:
+	case 0x32:
+	case 0x40:
+		ret = 0;
+		status = POWER_SUPPLY_STATUS_DISCHARGING;
+		health = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case 0x7f:
+	default:
+		ret = 0;
+		status = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		health = POWER_SUPPLY_HEALTH_DEAD;
+		break;
+	}
+
+	if (s)
+		*s = status;
+	if (h)
+		*h = health;
+
+	return ret;
+}
+
+static int get_chg_online(struct bd71828_power *pwr, int *chg_online)
+{
+	int r, ret;
+
+	ret = regmap_read(pwr->regmap, pwr->regs->dcin_stat, &r);
+	if (ret) {
+		dev_err(pwr->dev, "Failed to read DCIN status\n");
+		return ret;
+	}
+	*chg_online = ((r & BD7182x_MASK_DCIN_DET) != 0);
+
+	return 0;
+}
+
+static int get_bat_online(struct bd71828_power *pwr, int *bat_online)
+{
+	int r, ret;
+
+#define BAT_OPEN	0x7
+	ret = regmap_read(pwr->regmap, pwr->regs->bat_temp, &r);
+	if (ret) {
+		dev_err(pwr->dev, "Failed to read battery temperature\n");
+		return ret;
+	}
+	*bat_online = ((r & BD7182x_MASK_BAT_TEMP) != BAT_OPEN);
+
+	return 0;
+}
+
+static int bd71828_bat_inserted(struct bd71828_power *pwr)
+{
+	int ret, val;
+
+	ret = regmap_read(pwr->regmap, pwr->regs->conf, &val);
+	if (ret) {
+		dev_err(pwr->dev, "Failed to read CONF register\n");
+		return 0;
+	}
+	ret = val & BD7182x_MASK_CONF_PON;
+
+	if (ret)
+		regmap_update_bits(pwr->regmap, pwr->regs->conf,
+				   BD7182x_MASK_CONF_PON, 0);
+
+	return ret;
+}
+
+static int bd71815_bat_inserted(struct bd71828_power *pwr)
+{
+	int ret, val;
+
+	ret = regmap_read(pwr->regmap, pwr->regs->conf, &val);
+	if (ret) {
+		dev_err(pwr->dev, "Failed to read CONF register\n");
+		return ret;
+	}
+
+	ret = !(val & BD71815_MASK_CONF_XSTB);
+	if (ret)
+		regmap_write(pwr->regmap, pwr->regs->conf,  val |
+			     BD71815_MASK_CONF_XSTB);
+
+	return ret;
+}
+
+static int bd71828_init_hardware(struct bd71828_power *pwr)
+{
+	int ret;
+
+	/* TODO: Collapse limit should come from device-tree ? */
+	ret = regmap_write(pwr->regmap, pwr->regs->dcin_collapse_limit,
+			   BD7182x_DCIN_COLLAPSE_DEFAULT);
+	if (ret) {
+		dev_err(pwr->dev, "Failed to write DCIN collapse limit\n");
+		return ret;
+	}
+
+	ret = pwr->bat_inserted(pwr);
+	if (ret < 0)
+		return ret;
+
+	if (ret) {
+		/* WDT_FST auto set */
+		ret = regmap_update_bits(pwr->regmap, pwr->regs->chg_set1,
+					 BD7182x_MASK_WDT_AUTO,
+					 BD7182x_MASK_WDT_AUTO);
+		if (ret)
+			return ret;
+
+		ret = bd7182x_write16(pwr, pwr->regs->vbat_alm_limit_u,
+				      VBAT_LOW_TH);
+		if (ret)
+			return ret;
+
+		/*
+		 * On BD71815 "we mask the power-state" from relax detection.
+		 * I am unsure what the impact of the power-state would be if
+		 * we didn't - but this is what the vendor driver did - and
+		 * that driver has been used in few projects so I just assume
+		 * this is needed.
+		 */
+		if (pwr->chip_type == ROHM_CHIP_TYPE_BD71815) {
+			ret = regmap_set_bits(pwr->regmap,
+					      BD71815_REG_REX_CTRL_1,
+					      REX_PMU_STATE_MASK);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int bd71828_charger_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct bd71828_power *pwr = dev_get_drvdata(psy->dev.parent);
+	u32 vot;
+	u16 tmp;
+	int online;
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = get_chg_online(pwr, &online);
+		if (!ret)
+			val->intval = online;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = bd7182x_read16_himask(pwr, pwr->regs->vdcin,
+					    BD7182x_MASK_VDCIN_U, &tmp);
+		if (ret)
+			return ret;
+
+		vot = tmp;
+		/* 5 milli volt steps */
+		val->intval = 5000 * vot;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bd71828_battery_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct bd71828_power *pwr = dev_get_drvdata(psy->dev.parent);
+	int ret = 0;
+	int status, health, tmp, curr, curr_avg, chg_en;
+
+	if (psp == POWER_SUPPLY_PROP_STATUS ||
+	    psp == POWER_SUPPLY_PROP_HEALTH ||
+	    psp == POWER_SUPPLY_PROP_CHARGE_TYPE)
+		ret = bd71828_charge_status(pwr, &status, &health);
+	else if (psp == POWER_SUPPLY_PROP_CURRENT_AVG ||
+		 psp == POWER_SUPPLY_PROP_CURRENT_NOW)
+		ret = bd71828_get_current_ds_adc(pwr, &curr, &curr_avg);
+	if (ret)
+		return ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		val->intval = status;
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		val->intval = health;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = get_bat_online(pwr, &tmp);
+		if (!ret)
+			val->intval = tmp;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = bd71828_get_vbat(pwr, &tmp);
+		val->intval = tmp;
+		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		val->intval = curr_avg;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = curr;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		val->intval = MAX_CURRENT_DEFAULT;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		ret = pwr->get_temp(pwr, &val->intval);
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		ret = regmap_read(pwr->regmap, pwr->regs->chg_en, &chg_en);
+		if (ret)
+			return ret;
+
+		val->intval = (chg_en & BD7182x_MASK_CHG_EN) ?
+			POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO :
+			POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int bd71828_battery_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct bd71828_power *pwr = dev_get_drvdata(psy->dev.parent);
+	int ret = 0;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		if (val->intval == POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
+			ret = regmap_update_bits(pwr->regmap, pwr->regs->chg_en,
+						 BD7182x_MASK_CHG_EN,
+						 BD7182x_MASK_CHG_EN);
+		else
+			ret = regmap_update_bits(pwr->regmap, pwr->regs->chg_en,
+						 BD7182x_MASK_CHG_EN,
+						 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int bd71828_battery_property_is_writeable(struct power_supply *psy,
+						 enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/** @brief ac properties */
+static const enum power_supply_property bd71828_charger_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
+static const enum power_supply_property bd71828_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
+};
+
+/** @brief powers supplied by bd71828_ac */
+static char *bd71828_ac_supplied_to[] = {
+	BAT_NAME,
+};
+
+static const struct power_supply_desc bd71828_ac_desc = {
+	.name		= AC_NAME,
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.properties	= bd71828_charger_props,
+	.num_properties	= ARRAY_SIZE(bd71828_charger_props),
+	.get_property	= bd71828_charger_get_property,
+};
+
+static const struct power_supply_desc bd71828_bat_desc = {
+	.name		= BAT_NAME,
+	.type		= POWER_SUPPLY_TYPE_BATTERY,
+	.charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) |
+			     BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE),
+	.properties	= bd71828_battery_props,
+	.num_properties = ARRAY_SIZE(bd71828_battery_props),
+	.get_property	= bd71828_battery_get_property,
+	.set_property	= bd71828_battery_set_property,
+	.property_is_writeable   = bd71828_battery_property_is_writeable,
+};
+
+#define RSENS_CURR 10000000LLU
+
+#define BD_ISR_NAME(name) \
+bd7181x_##name##_isr
+
+#define BD_ISR_BAT(name, print, run_gauge)				\
+static irqreturn_t BD_ISR_NAME(name)(int irq, void *data)		\
+{									\
+	struct bd71828_power *pwr = (struct bd71828_power *)data;	\
+									\
+	dev_dbg(pwr->dev, "%s\n", print);				\
+	power_supply_changed(pwr->bat);				\
+									\
+	return IRQ_HANDLED;						\
+}
+
+#define BD_ISR_AC(name, print, run_gauge)				\
+static irqreturn_t BD_ISR_NAME(name)(int irq, void *data)		\
+{									\
+	struct bd71828_power *pwr = (struct bd71828_power *)data;	\
+									\
+	power_supply_changed(pwr->ac);					\
+	dev_dbg(pwr->dev, "%s\n", print);				\
+	power_supply_changed(pwr->bat);				\
+									\
+	return IRQ_HANDLED;						\
+}
+
+#define BD_ISR_DUMMY(name, print)					\
+static irqreturn_t BD_ISR_NAME(name)(int irq, void *data)		\
+{									\
+	struct bd71828_power *pwr = (struct bd71828_power *)data;	\
+									\
+	dev_dbg(pwr->dev, "%s\n", print);				\
+									\
+	return IRQ_HANDLED;						\
+}
+
+BD_ISR_BAT(chg_state_changed, "CHG state changed", true)
+/* DCIN voltage changes */
+BD_ISR_AC(dcin_removed, "DCIN removed", true)
+BD_ISR_AC(clps_out, "DCIN voltage back to normal", true)
+BD_ISR_AC(clps_in, "DCIN voltage collapsed", false)
+BD_ISR_AC(dcin_ovp_res, "DCIN voltage normal", true)
+BD_ISR_AC(dcin_ovp_det, "DCIN OVER VOLTAGE", true)
+
+BD_ISR_DUMMY(dcin_mon_det, "DCIN voltage below threshold")
+BD_ISR_DUMMY(dcin_mon_res, "DCIN voltage above threshold")
+
+BD_ISR_DUMMY(vsys_uv_res, "VSYS under-voltage cleared")
+BD_ISR_DUMMY(vsys_uv_det, "VSYS under-voltage")
+BD_ISR_DUMMY(vsys_low_res, "'VSYS low' cleared")
+BD_ISR_DUMMY(vsys_low_det, "VSYS low")
+BD_ISR_DUMMY(vsys_mon_res, "VSYS mon - resumed")
+BD_ISR_DUMMY(vsys_mon_det, "VSYS mon - detected")
+BD_ISR_BAT(chg_wdg_temp, "charger temperature watchdog triggered", true)
+BD_ISR_BAT(chg_wdg, "charging watchdog triggered", true)
+BD_ISR_BAT(bat_removed, "Battery removed", true)
+BD_ISR_BAT(bat_det, "Battery detected", true)
+/* TODO: Verify the meaning of these interrupts */
+BD_ISR_BAT(rechg_det, "Recharging", true)
+BD_ISR_BAT(rechg_res, "Recharge ending", true)
+BD_ISR_DUMMY(temp_transit, "Temperature transition")
+BD_ISR_BAT(therm_rmv, "bd71815-therm-rmv", false)
+BD_ISR_BAT(therm_det, "bd71815-therm-det", true)
+BD_ISR_BAT(bat_dead, "bd71815-bat-dead", false)
+BD_ISR_BAT(bat_short_res, "bd71815-bat-short-res", true)
+BD_ISR_BAT(bat_short, "bd71815-bat-short-det", false)
+BD_ISR_BAT(bat_low_res, "bd71815-bat-low-res", true)
+BD_ISR_BAT(bat_low, "bd71815-bat-low-det", true)
+BD_ISR_BAT(bat_ov_res, "bd71815-bat-over-res", true)
+/* What should we do here? */
+BD_ISR_BAT(bat_ov, "bd71815-bat-over-det", false)
+BD_ISR_BAT(bat_mon_res, "bd71815-bat-mon-res", true)
+BD_ISR_BAT(bat_mon, "bd71815-bat-mon-det", true)
+BD_ISR_BAT(bat_cc_mon, "bd71815-bat-cc-mon2", false)
+BD_ISR_BAT(bat_oc1_res, "bd71815-bat-oc1-res", true)
+BD_ISR_BAT(bat_oc1, "bd71815-bat-oc1-det", false)
+BD_ISR_BAT(bat_oc2_res, "bd71815-bat-oc2-res", true)
+BD_ISR_BAT(bat_oc2, "bd71815-bat-oc2-det", false)
+BD_ISR_BAT(bat_oc3_res, "bd71815-bat-oc3-res", true)
+BD_ISR_BAT(bat_oc3, "bd71815-bat-oc3-det", false)
+BD_ISR_BAT(temp_bat_low_res, "bd71815-temp-bat-low-res", true)
+BD_ISR_BAT(temp_bat_low, "bd71815-temp-bat-low-det", true)
+BD_ISR_BAT(temp_bat_hi_res, "bd71815-temp-bat-hi-res", true)
+BD_ISR_BAT(temp_bat_hi, "bd71815-temp-bat-hi-det", true)
+
+static irqreturn_t bd7182x_dcin_removed(int irq, void *data)
+{
+	struct bd71828_power *pwr = (struct bd71828_power *)data;
+
+	power_supply_changed(pwr->ac);
+	dev_dbg(pwr->dev, "DCIN removed\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd718x7_chg_done(int irq, void *data)
+{
+	struct bd71828_power *pwr = (struct bd71828_power *)data;
+
+	power_supply_changed(pwr->bat);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd7182x_dcin_detected(int irq, void *data)
+{
+	struct bd71828_power *pwr = (struct bd71828_power *)data;
+
+	dev_dbg(pwr->dev, "DCIN inserted\n");
+	power_supply_changed(pwr->ac);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71828_vbat_low_res(int irq, void *data)
+{
+	struct bd71828_power *pwr = (struct bd71828_power *)data;
+
+	dev_dbg(pwr->dev, "VBAT LOW Resumed\n");
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71828_vbat_low_det(int irq, void *data)
+{
+	struct bd71828_power *pwr = (struct bd71828_power *)data;
+
+	dev_dbg(pwr->dev, "VBAT LOW Detected\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71828_temp_bat_hi_det(int irq, void *data)
+{
+	struct bd71828_power *pwr = (struct bd71828_power *)data;
+
+	dev_warn(pwr->dev, "Overtemp Detected\n");
+	power_supply_changed(pwr->bat);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71828_temp_bat_hi_res(int irq, void *data)
+{
+	struct bd71828_power *pwr = (struct bd71828_power *)data;
+
+	dev_dbg(pwr->dev, "Overtemp Resumed\n");
+	power_supply_changed(pwr->bat);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71828_temp_bat_low_det(int irq, void *data)
+{
+	struct bd71828_power *pwr = (struct bd71828_power *)data;
+
+	dev_dbg(pwr->dev, "Lowtemp Detected\n");
+	power_supply_changed(pwr->bat);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71828_temp_bat_low_res(int irq, void *data)
+{
+	struct bd71828_power *pwr = (struct bd71828_power *)data;
+
+	dev_dbg(pwr->dev, "Lowtemp Resumed\n");
+	power_supply_changed(pwr->bat);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71828_temp_vf_det(int irq, void *data)
+{
+	struct bd71828_power *pwr = (struct bd71828_power *)data;
+
+	dev_dbg(pwr->dev, "VF Detected\n");
+	power_supply_changed(pwr->bat);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71828_temp_vf_res(int irq, void *data)
+{
+	struct bd71828_power *pwr = (struct bd71828_power *)data;
+
+	dev_dbg(pwr->dev, "VF Resumed\n");
+	power_supply_changed(pwr->bat);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71828_temp_vf125_det(int irq, void *data)
+{
+	struct bd71828_power *pwr = (struct bd71828_power *)data;
+
+	dev_dbg(pwr->dev, "VF125 Detected\n");
+	power_supply_changed(pwr->bat);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71828_temp_vf125_res(int irq, void *data)
+{
+	struct bd71828_power *pwr = (struct bd71828_power *)data;
+
+	dev_dbg(pwr->dev, "VF125 Resumed\n");
+	power_supply_changed(pwr->bat);
+
+	return IRQ_HANDLED;
+}
+
+struct bd7182x_irq_res {
+	const char *name;
+	irq_handler_t handler;
+};
+
+#define BDIRQ(na, hn) { .name = (na), .handler = (hn) }
+
+static int bd7182x_get_irqs(struct platform_device *pdev,
+			    struct bd71828_power *pwr)
+{
+	int i, irq, ret;
+	static const struct bd7182x_irq_res bd71815_irqs[] = {
+		BDIRQ("bd71815-dcin-rmv", BD_ISR_NAME(dcin_removed)),
+		BDIRQ("bd71815-dcin-clps-out", BD_ISR_NAME(clps_out)),
+		BDIRQ("bd71815-dcin-clps-in", BD_ISR_NAME(clps_in)),
+		BDIRQ("bd71815-dcin-ovp-res", BD_ISR_NAME(dcin_ovp_res)),
+		BDIRQ("bd71815-dcin-ovp-det", BD_ISR_NAME(dcin_ovp_det)),
+		BDIRQ("bd71815-dcin-mon-res", BD_ISR_NAME(dcin_mon_res)),
+		BDIRQ("bd71815-dcin-mon-det", BD_ISR_NAME(dcin_mon_det)),
+
+		BDIRQ("bd71815-vsys-uv-res", BD_ISR_NAME(vsys_uv_res)),
+		BDIRQ("bd71815-vsys-uv-det", BD_ISR_NAME(vsys_uv_det)),
+		BDIRQ("bd71815-vsys-low-res", BD_ISR_NAME(vsys_low_res)),
+		BDIRQ("bd71815-vsys-low-det",  BD_ISR_NAME(vsys_low_det)),
+		BDIRQ("bd71815-vsys-mon-res",  BD_ISR_NAME(vsys_mon_res)),
+		BDIRQ("bd71815-vsys-mon-det",  BD_ISR_NAME(vsys_mon_det)),
+		BDIRQ("bd71815-chg-wdg-temp", BD_ISR_NAME(chg_wdg_temp)),
+		BDIRQ("bd71815-chg-wdg",  BD_ISR_NAME(chg_wdg)),
+		BDIRQ("bd71815-rechg-det", BD_ISR_NAME(rechg_det)),
+		BDIRQ("bd71815-rechg-res", BD_ISR_NAME(rechg_res)),
+		BDIRQ("bd71815-ranged-temp-transit", BD_ISR_NAME(temp_transit)),
+		BDIRQ("bd71815-chg-state-change", BD_ISR_NAME(chg_state_changed)),
+		BDIRQ("bd71815-bat-temp-normal", bd71828_temp_bat_hi_res),
+		BDIRQ("bd71815-bat-temp-erange", bd71828_temp_bat_hi_det),
+		BDIRQ("bd71815-bat-rmv", BD_ISR_NAME(bat_removed)),
+		BDIRQ("bd71815-bat-det", BD_ISR_NAME(bat_det)),
+
+		/* Add ISRs for these */
+		BDIRQ("bd71815-therm-rmv", BD_ISR_NAME(therm_rmv)),
+		BDIRQ("bd71815-therm-det", BD_ISR_NAME(therm_det)),
+		BDIRQ("bd71815-bat-dead", BD_ISR_NAME(bat_dead)),
+		BDIRQ("bd71815-bat-short-res", BD_ISR_NAME(bat_short_res)),
+		BDIRQ("bd71815-bat-short-det", BD_ISR_NAME(bat_short)),
+		BDIRQ("bd71815-bat-low-res", BD_ISR_NAME(bat_low_res)),
+		BDIRQ("bd71815-bat-low-det", BD_ISR_NAME(bat_low)),
+		BDIRQ("bd71815-bat-over-res", BD_ISR_NAME(bat_ov_res)),
+		BDIRQ("bd71815-bat-over-det", BD_ISR_NAME(bat_ov)),
+		BDIRQ("bd71815-bat-mon-res", BD_ISR_NAME(bat_mon_res)),
+		BDIRQ("bd71815-bat-mon-det", BD_ISR_NAME(bat_mon)),
+		/* cc-mon 1 & 3 ? */
+		BDIRQ("bd71815-bat-cc-mon2", BD_ISR_NAME(bat_cc_mon)),
+		BDIRQ("bd71815-bat-oc1-res", BD_ISR_NAME(bat_oc1_res)),
+		BDIRQ("bd71815-bat-oc1-det", BD_ISR_NAME(bat_oc1)),
+		BDIRQ("bd71815-bat-oc2-res", BD_ISR_NAME(bat_oc2_res)),
+		BDIRQ("bd71815-bat-oc2-det", BD_ISR_NAME(bat_oc2)),
+		BDIRQ("bd71815-bat-oc3-res", BD_ISR_NAME(bat_oc3_res)),
+		BDIRQ("bd71815-bat-oc3-det", BD_ISR_NAME(bat_oc3)),
+		BDIRQ("bd71815-temp-bat-low-res", BD_ISR_NAME(temp_bat_low_res)),
+		BDIRQ("bd71815-temp-bat-low-det", BD_ISR_NAME(temp_bat_low)),
+		BDIRQ("bd71815-temp-bat-hi-res", BD_ISR_NAME(temp_bat_hi_res)),
+		BDIRQ("bd71815-temp-bat-hi-det", BD_ISR_NAME(temp_bat_hi)),
+		/*
+		 * TODO: add rest of the IRQs and re-check the handling.
+		 * Check the bd71815-bat-cc-mon1, bd71815-bat-cc-mon3,
+		 * bd71815-bat-low-res, bd71815-bat-low-det,
+		 * bd71815-bat-hi-res, bd71815-bat-hi-det.
+		 */
+	};
+	static const struct bd7182x_irq_res bd71828_irqs[] = {
+		BDIRQ("bd71828-chg-done", bd718x7_chg_done),
+		BDIRQ("bd71828-pwr-dcin-in", bd7182x_dcin_detected),
+		BDIRQ("bd71828-pwr-dcin-out", bd7182x_dcin_removed),
+		BDIRQ("bd71828-vbat-normal", bd71828_vbat_low_res),
+		BDIRQ("bd71828-vbat-low", bd71828_vbat_low_det),
+		BDIRQ("bd71828-btemp-hi", bd71828_temp_bat_hi_det),
+		BDIRQ("bd71828-btemp-cool", bd71828_temp_bat_hi_res),
+		BDIRQ("bd71828-btemp-lo", bd71828_temp_bat_low_det),
+		BDIRQ("bd71828-btemp-warm", bd71828_temp_bat_low_res),
+		BDIRQ("bd71828-temp-hi", bd71828_temp_vf_det),
+		BDIRQ("bd71828-temp-norm", bd71828_temp_vf_res),
+		BDIRQ("bd71828-temp-125-over", bd71828_temp_vf125_det),
+		BDIRQ("bd71828-temp-125-under", bd71828_temp_vf125_res),
+	};
+	int num_irqs;
+	const struct bd7182x_irq_res *irqs;
+
+	switch (pwr->chip_type) {
+	case ROHM_CHIP_TYPE_BD71828:
+		irqs = &bd71828_irqs[0];
+		num_irqs = ARRAY_SIZE(bd71828_irqs);
+		break;
+	case ROHM_CHIP_TYPE_BD71815:
+		irqs = &bd71815_irqs[0];
+		num_irqs = ARRAY_SIZE(bd71815_irqs);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_irqs; i++) {
+		irq = platform_get_irq_byname(pdev, irqs[i].name);
+
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						irqs[i].handler, 0,
+						irqs[i].name, pwr);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+#define RSENS_DEFAULT_30MOHM 30000 /* 30 mOhm in uOhms*/
+
+static int bd7182x_get_rsens(struct bd71828_power *pwr)
+{
+	u64 tmp = RSENS_CURR;
+	int rsens_ohm = RSENS_DEFAULT_30MOHM;
+	struct fwnode_handle *node = NULL;
+
+	if (pwr->dev->parent)
+		node = dev_fwnode(pwr->dev->parent);
+
+	if (node) {
+		int ret;
+		u32 rs;
+
+		ret = fwnode_property_read_u32(node,
+					       "rohm,charger-sense-resistor-micro-ohms",
+					       &rs);
+		if (ret) {
+			if (ret == -EINVAL) {
+				rs = RSENS_DEFAULT_30MOHM;
+			} else {
+				dev_err(pwr->dev, "Bad RSENS dt property\n");
+				return ret;
+			}
+		}
+		if (!rs) {
+			dev_err(pwr->dev, "Bad RSENS value\n");
+			return -EINVAL;
+		}
+
+		rsens_ohm = (int)rs;
+	}
+
+	/* Reg val to uA */
+	do_div(tmp, rsens_ohm);
+
+	pwr->curr_factor = tmp;
+	pwr->rsens = rsens_ohm;
+	dev_dbg(pwr->dev, "Setting rsens to %u micro ohm\n", pwr->rsens);
+	dev_dbg(pwr->dev, "Setting curr-factor to %u\n", pwr->curr_factor);
+	return 0;
+}
+
+static int bd71828_power_probe(struct platform_device *pdev)
+{
+	struct bd71828_power *pwr;
+	struct power_supply_config ac_cfg = {};
+	struct power_supply_config bat_cfg = {};
+	int ret;
+	struct regmap *regmap;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap) {
+		dev_err(&pdev->dev, "No parent regmap\n");
+		return -EINVAL;
+	}
+
+	pwr = devm_kzalloc(&pdev->dev, sizeof(*pwr), GFP_KERNEL);
+	if (!pwr)
+		return -ENOMEM;
+
+	pwr->regmap = regmap;
+	pwr->dev = &pdev->dev;
+	pwr->chip_type = platform_get_device_id(pdev)->driver_data;
+
+	switch (pwr->chip_type) {
+	case ROHM_CHIP_TYPE_BD71828:
+		pwr->bat_inserted = bd71828_bat_inserted;
+		pwr->get_temp = bd71828_get_temp;
+		pwr->regs = &pwr_regs_bd71828;
+		break;
+	case ROHM_CHIP_TYPE_BD71815:
+		pwr->bat_inserted = bd71815_bat_inserted;
+		pwr->get_temp = bd71815_get_temp;
+		pwr->regs = &pwr_regs_bd71815;
+		break;
+	default:
+		dev_err(pwr->dev, "Unknown PMIC\n");
+		return -EINVAL;
+	}
+
+	ret = bd7182x_get_rsens(pwr);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "sense resistor missing\n");
+
+	dev_set_drvdata(&pdev->dev, pwr);
+	bd71828_init_hardware(pwr);
+
+	bat_cfg.drv_data	= pwr;
+	bat_cfg.fwnode		= dev_fwnode(&pdev->dev);
+
+	ac_cfg.supplied_to	= bd71828_ac_supplied_to;
+	ac_cfg.num_supplicants	= ARRAY_SIZE(bd71828_ac_supplied_to);
+	ac_cfg.drv_data		= pwr;
+
+	pwr->ac = devm_power_supply_register(&pdev->dev, &bd71828_ac_desc,
+					     &ac_cfg);
+	if (IS_ERR(pwr->ac))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pwr->ac),
+				     "failed to register ac\n");
+
+	pwr->bat = devm_power_supply_register(&pdev->dev, &bd71828_bat_desc,
+					      &bat_cfg);
+	if (IS_ERR(pwr->bat))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pwr->bat),
+				     "failed to register bat\n");
+
+	ret = bd7182x_get_irqs(pdev, pwr);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to request IRQs");
+
+	/* Configure wakeup capable */
+	device_set_wakeup_capable(pwr->dev, 1);
+	device_set_wakeup_enable(pwr->dev, 1);
+
+	return 0;
+}
+
+static const struct platform_device_id bd71828_charger_id[] = {
+	{ "bd71815-power", ROHM_CHIP_TYPE_BD71815 },
+	{ "bd71828-power", ROHM_CHIP_TYPE_BD71828 },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, bd71828_charger_id);
+
+static struct platform_driver bd71828_power_driver = {
+	.driver = {
+		.name = "bd718xx-power",
+	},
+	.probe = bd71828_power_probe,
+	.id_table = bd71828_charger_id,
+};
+
+module_platform_driver(bd71828_power_driver);
+
+MODULE_AUTHOR("Cong Pham <cpham2403@gmail.com>");
+MODULE_DESCRIPTION("ROHM BD718(15/17/28/78) PMIC Battery Charger driver");
+MODULE_LICENSE("GPL");

-- 
2.39.5


