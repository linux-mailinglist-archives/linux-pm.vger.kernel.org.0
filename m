Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB2E2CEE64
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 13:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgLDMx4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 07:53:56 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:34724 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgLDMx4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 07:53:56 -0500
Received: by mail-lj1-f174.google.com with SMTP id y16so6513091ljk.1;
        Fri, 04 Dec 2020 04:53:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SdNS9XUNC4ZzqVm79pxf+yDLSdfEG7Ie5RFai8XimqQ=;
        b=MxNcGvGgyot6qQtTL03Omoh+9XE5HFjJCubYDnafUPNIYdUBbk/6nJpN0wcCJGT3Q7
         y9chG+JwOoLvK1ir62TKydesfML0dDmlzjyGkgZnU9iUdKLWR6Yxmquv+xVlKii+vjja
         OmtDMz6xgG99rbup4pa6rGErP6tPKCMpRK8+/CrynzH00ePEgQAl96DCWvzGLdak97Ia
         evD5lPdYaZ2KT6QPmrO//efP5pO7J6puV08R++F1fHltg7fQAot2NntyqW3QPbA0lWnr
         sUJ/LcYJcOSQX4eJGL4WPGvDbp1z978kLOqyTEKhsTuL6wh59a2XdTjHBfnrqlcVXoaa
         7rKg==
X-Gm-Message-State: AOAM533bKs8jc2KsQcDbPDNWjqAhJbqeijJsYYPsISuVrigWsrjxNsSV
        nrEdN3Dd6q1Q0FA9Bo1Jr2s=
X-Google-Smtp-Source: ABdhPJwvvsww8p6nyQNJ6rnbIEf7mYD+UhISRV6YB4Dwf38WaQbqCgzSnNlxbK3K8HELm2Q6jPn5MQ==
X-Received: by 2002:a2e:3a10:: with SMTP id h16mr3467671lja.400.1607086387890;
        Fri, 04 Dec 2020 04:53:07 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id x30sm1706333ljd.108.2020.12.04.04.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 04:53:06 -0800 (PST)
Date:   Fri, 4 Dec 2020 14:53:00 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Cong Pham <cpham2403@gmail.com>, rostokus@gmail.com,
        fan.chen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC PATCH v2 5/6] power: supply: Add bd718(27/28/78) charger driver
Message-ID: <6a2b702f578b393425d6fad184972008a48b7eaf.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607085199.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add charger driver for ROHM BD718(27/28/78) PMIC charger block.
Driver utilizes the swgauge for battery status / current polling,
CC correction and SOC estimation.

A version of driver which does not utilize swgauge can be seen
in ROHM venor specific Linux tree - comparison can visualize how
swgauge can simplify IC specific drivers.

https://github.com/RohmSemiconductor/Linux-Kernel-PMIC-Drivers/blob/stable-v5.4.6/drivers/power/supply/bd71827-power.c
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

This is an example of driver which could be using the swgauge. Driver
is for ROHM BD71827, BD71828 and BD71878. This driver is not properly
tested and no review is requested now - this is provided to give some
context to sw-gauge (gah. I already hate that name - open to all
suggestions. Naming is Hard). If the idea of swgauge is seen Ok - then
I will do proper testing and send a proper version of this patch.

 drivers/power/supply/Kconfig         |   10 +
 drivers/power/supply/Makefile        |    1 +
 drivers/power/supply/bd71827-power.c | 2162 ++++++++++++++++++++++++++
 3 files changed, 2173 insertions(+)
 create mode 100644 drivers/power/supply/bd71827-power.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index d78231f3caf7..137daf2fb071 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -756,6 +756,16 @@ config CHARGER_BD70528
 	  information and altering charger configurations from charger
 	  block of the ROHM BD70528 Power Management IC.
 
+config CHARGER_BD71828
+	tristate "Power-supply driver for ROHM BD71828 PMIC"
+	depends on MFD_ROHM_BD71828
+	select SW_GAUGE
+	help
+	  Say Y here to enable support for charger, battery and fuel gauge
+	  in ROHM BD71827 and ROHM BD71828 power management ICs. This driver
+	  gets various bits of information about battery and charger states
+	  and also implements fuel gauge based on coulomb counters on PMIC.
+
 config CHARGER_BD99954
 	tristate "ROHM bd99954 charger driver"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index f3d9472ee8cb..36c2f369085a 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD70528)	+= bd70528-charger.o
+obj-$(CONFIG_CHARGER_BD71828)	+= bd71827-power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
 obj-$(CONFIG_RN5T618_POWER)	+= rn5t618_power.o
diff --git a/drivers/power/supply/bd71827-power.c b/drivers/power/supply/bd71827-power.c
new file mode 100644
index 000000000000..4c1524fdde5f
--- /dev/null
+++ b/drivers/power/supply/bd71827-power.c
@@ -0,0 +1,2162 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * bd71827-power.c
+ * @file ROHM BD71827 Charger driver
+ *
+ * Copyright 2016.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/power_supply.h>
+#include <linux/power/sw_gauge.h>
+#include <linux/mfd/rohm-bd71827.h>
+#include <linux/mfd/rohm-bd71828.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/proc_fs.h>
+#include <linux/uaccess.h>
+
+/* This is horrible - what kind of a helper would be good? */
+#define GAUGE_GET_DRVDATA(sw) (dev_get_drvdata((sw)->psy->dev.parent))
+
+#define MAX(X, Y) ((X) >= (Y) ? (X) : (Y))
+#define uAMP_TO_mAMP(ma) ((ma) / 1000)
+
+/* BD71828 and BD71827 common defines */
+#define BD7182x_MASK_VBAT_U		0x1f
+#define BD7182x_MASK_VDCIN_U		0x0f
+#define BD7182x_MASK_IBAT_U		0x3f
+#define BD7182x_MASK_CURDIR_DISCHG	0x80
+#define BD7182x_MASK_CC_CCNTD_HI	0x0FFF
+#define BD7182x_MASK_CC_CCNTD		0x0FFFFFFF
+#define BD7182x_MASK_CHG_STATE		0x7f
+#define BD7182x_MASK_CC_FULL_CLR	0x10
+#define BD7182x_MASK_BAT_TEMP		0x07
+#define BD7182x_MASK_DCIN_DET		0x01
+#define BD7182x_MASK_CONF_PON		0x01
+#define BD7182x_MASK_BAT_STAT		0x3f
+#define BD7182x_MASK_DCIN_STAT		0x07
+
+#define BD7182x_MASK_CCNTRST		0x80
+#define BD7182x_MASK_CCNTENB		0x40
+#define BD7182x_MASK_CCCALIB		0x20
+#define BD7182x_MASK_WDT_AUTO		0x40
+#define BD7182x_MASK_VBAT_ALM_LIMIT_U	0x01
+#define BD7182x_MASK_CHG_EN		0x01
+
+#define BD7182x_DCIN_COLLAPSE_DEFAULT	0x36
+
+/* Measured min and max value clear bits */
+#define BD7182x_MASK_VSYS_MIN_AVG_CLR	0x10
+#define BD7182x_MASK_VBAT_MIN_AVG_CLR	0x01
+
+
+#define JITTER_DEFAULT			3000		/* hope 3s is enough */
+#define BATTERY_CAP_MAH_DEFAULT		1529
+#define MAX_VOLTAGE_DEFAULT		ocv_table_default[0]
+#define MIN_VOLTAGE_DEFAULT		3400000
+#define THR_VOLTAGE_DEFAULT		4250000
+#define MAX_CURRENT_DEFAULT		890000		/* uA */
+#define AC_NAME				"bd71827_ac"
+#define BAT_NAME			"bd71827_bat"
+
+#define BY_BAT_VOLT			0
+#define BY_VBATLOAD_REG			1
+#define INIT_COULOMB			BY_VBATLOAD_REG
+
+/*
+ * VBAT Low voltage detection Threshold
+ * 0x00D4*16mV = 212*0.016 = 3.392v
+ */
+#define VBAT_LOW_TH			0x00D4
+
+#define THR_RELAX_CURRENT_DEFAULT	5		/* mA */
+#define THR_RELAX_TIME_DEFAULT		(60 * 60)	/* sec. */
+
+#define DGRD_CYC_CAP_DEFAULT		88	/* 1 micro Ah unit */
+
+#define DGRD_TEMP_H_DEFAULT		450	/* 0.1 degrees C unit */
+#define DGRD_TEMP_M_DEFAULT		250	/* 0.1 degrees C unit */
+#define DGRD_TEMP_L_DEFAULT		50	/* 0.1 degrees C unit */
+#define DGRD_TEMP_VL_DEFAULT		0	/* 0.1 degrees C unit */
+
+#define SOC_EST_MAX_NUM_DEFAULT		5
+#define DGRD_TEMP_CAP_H_DEFAULT		0
+#define DGRD_TEMP_CAP_M_DEFAULT		0
+#define DGRD_TEMP_CAP_L_DEFAULT		0
+#define DGRD_TEMP_CAP_VL_DEFAULT	0
+
+#define PWRCTRL_NORMAL			0x22
+#define PWRCTRL_RESET			0x23
+
+#define NUM_BAT_PARAMS			23
+
+struct pwr_regs {
+	u8 vbat_init;
+	u8 vbat_init2;
+	u8 vbat_init3;
+	u8 vbat_avg;
+	u8 ibat;
+	u8 ibat_avg;
+	u8 vsys_avg;
+	u8 vbat_min_avg;
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
+	u8 rex_clear_reg;
+	u8 rex_clear_mask;
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
+	u8 bat_stat;
+	u8 vdcin;
+#ifdef PWRCTRL_HACK
+	u8 pwrctrl;
+#endif
+};
+
+struct pwr_regs pwr_regs_bd71827 = {
+	.vbat_init = BD71827_REG_VM_OCV_PRE_U,
+	.vbat_init2 = BD71827_REG_VM_OCV_PST_U,
+	.vbat_init3 = BD71827_REG_VM_OCV_PWRON_U,
+	.vbat_avg = BD71827_REG_VM_SA_VBAT_U,
+	.ibat = BD71827_REG_CC_CURCD_U,
+	.ibat_avg = BD71827_REG_CC_SA_CURCD_U,
+	.vsys_avg = BD71827_REG_VM_SA_VSYS_U,
+	.vbat_min_avg = BD71827_REG_VM_SA_VBAT_MIN_U,
+	.meas_clear = BD71827_REG_VM_SA_MINMAX_CLR,
+	.vsys_min_avg = BD71827_REG_VM_SA_VSYS_MIN_U,
+	.btemp_vth = BD71827_REG_VM_BTMP,
+	.chg_state = BD71827_REG_CHG_STATE,
+	.coulomb3 = BD71827_REG_CC_CCNTD_3,
+	.coulomb2 = BD71827_REG_CC_CCNTD_2,
+	.coulomb1 = BD71827_REG_CC_CCNTD_1,
+	.coulomb0 = BD71827_REG_CC_CCNTD_0,
+	.coulomb_ctrl = BD71827_REG_CC_CTRL,
+	.vbat_rex_avg = BD71827_REG_REX_SA_VBAT_U,
+	.rex_clear_reg = BD71827_REG_REX_CTRL_1,
+	.rex_clear_mask = BD71827_REX_CLR_MASK,
+	.coulomb_full3 = BD71827_REG_FULL_CCNTD_3,
+	.cc_full_clr = BD71827_REG_FULL_CTRL,
+	.coulomb_chg3 = BD71827_REG_CCNTD_CHG_3,
+	.bat_temp = BD71827_REG_BAT_TEMP,
+	.dcin_stat = BD71827_REG_DCIN_STAT,
+	.dcin_collapse_limit = BD71827_REG_DCIN_CLPS,
+	.chg_set1 = BD71827_REG_CHG_SET1,
+	.chg_en = BD71827_REG_CHG_SET1,
+	.vbat_alm_limit_u = BD71827_REG_ALM_VBAT_TH_U,
+	.batcap_mon_limit_u = BD71827_REG_CC_BATCAP1_TH_U,
+	.conf = BD71827_REG_CONF,
+	.bat_stat = BD71827_REG_BAT_STAT,
+	.vdcin = BD71827_REG_VM_DCIN_U,
+#ifdef PWRCTRL_HACK
+	.pwrctrl = BD71827_REG_PWRCTRL,
+	.hibernate_mask = 0x1,
+#endif
+};
+
+struct pwr_regs pwr_regs_bd71828 = {
+	.vbat_init = BD71828_REG_VBAT_INITIAL1_U,
+	.vbat_init2 = BD71828_REG_VBAT_INITIAL2_U,
+	.vbat_init3 = BD71828_REG_OCV_PWRON_U,
+	.vbat_avg = BD71828_REG_VBAT_U,
+	.ibat = BD71828_REG_IBAT_U,
+	.ibat_avg = BD71828_REG_IBAT_AVG_U,
+	.vsys_avg = BD71828_REG_VSYS_AVG_U,
+	.vbat_min_avg = BD71828_REG_VBAT_MIN_AVG_U,
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
+	.rex_clear_reg = BD71828_REG_COULOMB_CTRL2,
+	.rex_clear_mask = BD71828_MASK_REX_CC_CLR,
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
+	.bat_stat = BD71828_REG_BAT_STAT,
+	.vdcin = BD71828_REG_VDCIN_U,
+#ifdef PWRCTRL_HACK
+	.pwrctrl = BD71828_REG_PS_CTRL_1,
+	.hibernate_mask = 0x2,
+#endif
+};
+
+
+static int ocv_table_default[NUM_BAT_PARAMS] = {
+	4350000,
+	4325945,
+	4255935,
+	4197476,
+	4142843,
+	4090615,
+	4047113,
+	3987352,
+	3957835,
+	3920815,
+	3879834,
+	3827010,
+	3807239,
+	3791379,
+	3779925,
+	3775038,
+	3773530,
+	3756695,
+	3734099,
+	3704867,
+	3635377,
+	3512942,
+	3019825
+};	/* unit 1 micro V */
+
+static int soc_table_default[NUM_BAT_PARAMS] = {
+	1000,
+	1000,
+	950,
+	900,
+	850,
+	800,
+	750,
+	700,
+	650,
+	600,
+	550,
+	500,
+	450,
+	400,
+	350,
+	300,
+	250,
+	200,
+	150,
+	100,
+	50,
+	0,
+	-50
+	/* unit 0.1% */
+};
+
+static int vdr_table_h_default[NUM_BAT_PARAMS] = {
+	100,
+	100,
+	102,
+	104,
+	105,
+	108,
+	111,
+	115,
+	122,
+	138,
+	158,
+	96,
+	108,
+	112,
+	117,
+	123,
+	137,
+	109,
+	131,
+	150,
+	172,
+	136,
+	218
+};
+
+static int vdr_table_m_default[NUM_BAT_PARAMS] = {
+	100,
+	100,
+	100,
+	100,
+	102,
+	104,
+	114,
+	110,
+	127,
+	141,
+	139,
+	96,
+	102,
+	106,
+	109,
+	113,
+	130,
+	134,
+	149,
+	188,
+	204,
+	126,
+	271
+};
+
+static int vdr_table_l_default[NUM_BAT_PARAMS] = {
+	100,
+	100,
+	98,
+	96,
+	96,
+	96,
+	105,
+	94,
+	108,
+	105,
+	95,
+	89,
+	90,
+	92,
+	99,
+	112,
+	129,
+	143,
+	155,
+	162,
+	156,
+	119,
+	326
+};
+
+static int vdr_table_vl_default[NUM_BAT_PARAMS] = {
+	100,
+	100,
+	98,
+	96,
+	95,
+	97,
+	101,
+	92,
+	100,
+	97,
+	91,
+	89,
+	90,
+	93,
+	103,
+	115,
+	128,
+	139,
+	148,
+	148,
+	156,
+	246,
+	336
+};
+
+int use_load_bat_params;
+
+static int battery_cap_mah;
+
+static int dgrd_cyc_cap = DGRD_CYC_CAP_DEFAULT;
+
+static int soc_est_max_num;
+
+static int dgrd_temp_cap_h;
+static int dgrd_temp_cap_m;
+static int dgrd_temp_cap_l;
+static int dgrd_temp_cap_vl;
+
+static int ocv_table[NUM_BAT_PARAMS];
+static int soc_table[NUM_BAT_PARAMS];
+static int vdr_table_h[NUM_BAT_PARAMS];
+static int vdr_table_m[NUM_BAT_PARAMS];
+static int vdr_table_l[NUM_BAT_PARAMS];
+static int vdr_table_vl[NUM_BAT_PARAMS];
+
+struct bd71827_power {
+	struct sw_gauge *sw;
+	struct sw_gauge_desc gdesc;
+	struct sw_gauge_ops ops;
+	struct regmap *regmap;
+	enum rohm_chip_type chip_type;
+	struct device *dev;
+	struct power_supply *ac;	/**< alternating current power */
+	int gauge_delay;		/**< Schedule to call gauge algorithm */
+	int	relax_time;		/**< Relax Time */
+	spinlock_t dlock;
+	struct delayed_work bd_work;	/**< delayed work for timed work */
+
+	struct pwr_regs *regs;
+	/* Reg val to uA */
+	int curr_factor;
+	int rsens;
+	int (*get_temp)(struct bd71827_power *pwr, int *temp);
+	int battery_cap;
+};
+
+#define CC_to_UAH(pwr, cc)				\
+({							\
+	u64 __tmp = ((u64)(cc)) * 1000000000000LLU;	\
+							\
+	do_div(__tmp, (pwr)->rsens * 36);		\
+	(int)__tmp;					\
+})
+
+/*
+ * rsens is typically tens of Mohms so dividing by 1000 should be ok. (usual
+ * values are 10 and 30 Mohms so division is likely to go even). We do this
+ * to avoid doing two do_divs which would be unnecessary performance hit
+ * even if this should not be time critical.
+ */
+#define UAH_to_CC(pwr, uah) ({			\
+	u64 __tmp = (uah);			\
+	u32 __rs = (pwr)->rsens / 1000;		\
+	__tmp *= ((u64)__rs) * 36LLU;		\
+						\
+	do_div(__tmp, 1000000000);		\
+	(int)__tmp;				\
+})
+
+#define CALIB_NORM			0
+#define CALIB_START			1
+#define CALIB_GO			2
+
+enum {
+	STAT_POWER_ON,
+	STAT_INITIALIZED,
+};
+
+/* u32 bd71827_calc_soc_org(u32 cc, int designed_cap); */
+
+static int bd7182x_write16(struct bd71827_power *pwr, int reg, uint16_t val)
+{
+
+	val = cpu_to_be16(val);
+
+	return regmap_bulk_write(pwr->regmap, reg, &val, sizeof(val));
+}
+
+static int bd7182x_read16_himask(struct bd71827_power *pwr, int reg, int himask,
+				 uint16_t *val)
+{
+	struct regmap *regmap = pwr->regmap;
+	int ret;
+	u8 *tmp = (u8 *) val;
+
+	ret = regmap_bulk_read(regmap, reg, val, sizeof(*val));
+	if (!ret) {
+		*tmp &= himask;
+		*val = be16_to_cpu(*val);
+	}
+	return ret;
+}
+
+#if INIT_COULOMB == BY_VBATLOAD_REG
+#define INITIAL_OCV_REGS 3
+/** @brief get initial battery voltage and current
+ * @param pwr power device
+ * @return 0
+ */
+static int bd71827_get_init_bat_stat(struct bd71827_power *pwr,
+				     int *ocv)
+{
+	int ret;
+	int i;
+	u8 regs[INITIAL_OCV_REGS] = {
+		pwr->regs->vbat_init,
+		pwr->regs->vbat_init2,
+		pwr->regs->vbat_init3
+	 };
+	uint16_t vals[INITIAL_OCV_REGS];
+
+	*ocv = 0;
+
+	for (i = 0; i < INITIAL_OCV_REGS; i++) {
+
+		ret = bd7182x_read16_himask(pwr, regs[i], BD7182x_MASK_VBAT_U,
+					    &vals[i]);
+		if (ret) {
+			dev_err(pwr->dev,
+				"Failed to read initial battery voltage\n");
+			return ret;
+		}
+		*ocv = MAX(vals[i], *ocv);
+
+		dev_dbg(pwr->dev, "VM_OCV_%d = %d\n", i, ((int)vals[i]) * 1000);
+	}
+
+	*ocv *= 1000;
+
+	return ret;
+}
+#endif
+
+static int bd71827_get_vbat(struct bd71827_power *pwr, int *vcell)
+{
+	uint16_t tmp_vcell;
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
+#if INIT_COULOMB == BY_BAT_VOLT
+static int bd71827_get_vbat_curr(struct bd71827_power *pwr, int *vcell, int *curr)
+{
+	int ret;
+
+	ret = bd71827_get_vbat(pwr, vcell);
+	*curr = 0;
+
+	return ret;
+}
+#endif
+
+static int bd71827_get_current_ds_adc(struct bd71827_power *pwr, int *curr, int *curr_avg)
+{
+	uint16_t tmp_curr;
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
+		tmp_curr = be16_to_cpu(tmp_curr);
+
+		*vals[i] = dir * ((int)tmp_curr) * pwr->curr_factor;
+	}
+
+	return ret;
+}
+
+static int bd71827_voltage_to_capacity(struct sw_gauge *sw
+				       __attribute__((unused)), int ocv,
+				       int temp __attribute__((unused)),
+				       int *soc);
+
+static int bd71827_voltage_to_capacity(struct sw_gauge *sw, int ocv, int temp,
+				       int *soc)
+{
+	int i = 0;
+
+	if (ocv > ocv_table[0]) {
+		*soc = soc_table[0];
+	} else {
+		for (i = 0; soc_table[i] != -50; i++) {
+			if ((ocv <= ocv_table[i]) && (ocv > ocv_table[i+1])) {
+				*soc = (soc_table[i] - soc_table[i+1]) *
+				      (ocv - ocv_table[i+1]) /
+				      (ocv_table[i] - ocv_table[i+1]);
+				*soc += soc_table[i+1];
+				break;
+			}
+		}
+		if (soc_table[i] == -50)
+			*soc = soc_table[i];
+	}
+
+	return 0;
+}
+
+/* Unit is tenths of degree C */
+static int bd71827_get_temp(struct sw_gauge *sw, int *temp)
+{
+	struct bd71827_power *pwr = GAUGE_GET_DRVDATA(sw);
+	struct regmap *regmap = pwr->regmap;
+	int ret;
+	int t;
+
+	ret = regmap_read(regmap, pwr->regs->btemp_vth, &t);
+	t = 200 - t;
+
+	if (ret || t > 200) {
+		dev_err(pwr->dev, "Failed to read battery temperature\n");
+		*temp = 2000;
+	} else {
+		*temp = t * 10;
+	}
+
+	return ret;
+}
+
+/* Unit is tenths of degree C */
+static int bd71828_get_temp(struct sw_gauge *sw, int *temp)
+{
+	struct bd71827_power *pwr = GAUGE_GET_DRVDATA(sw);
+	uint16_t t;
+	int ret;
+	int tmp = 200 * 10000;
+
+	ret = bd7182x_read16_himask(pwr, pwr->regs->btemp_vth,
+				    BD71828_MASK_VM_BTMP_U, &t);
+	if (ret || t > 3200)
+		dev_err(pwr->dev,
+			"Failed to read system min average voltage\n");
+
+	tmp -= 625ULL * (unsigned int)t;
+	*temp = tmp / 1000;
+
+	return ret;
+}
+
+static int bd71827_charge_status(struct bd71827_power *pwr,
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
+#if INIT_COULOMB == BY_BAT_VOLT
+static int bd71827_calib_voltage(struct bd71827_power *pwr, int *ocv)
+{
+	int r, curr, volt, ret;
+
+	bd71827_get_vbat_curr(pwr, &volt, &curr);
+
+	ret = regmap_read(pwr->regmap, pwr->regs->chg_state, &r);
+	if (ret) {
+		dev_err(pwr->dev, "Charger state reading failed (%d)\n", ret);
+	} else if (curr > 0) {
+		/* voltage increment caused by battery inner resistor */
+		if (r == 3)
+			volt -= 100 * 1000;
+		else if (r == 2)
+			volt -= 50 * 1000;
+	}
+	*ocv = volt;
+
+	return 0;
+}
+#endif
+static int __write_cc(struct bd71827_power *pwr, uint16_t bcap,
+		      unsigned int reg, uint32_t *new)
+{
+	int ret;
+	uint32_t tmp;
+	uint16_t *swap_hi = (uint16_t *)&tmp;
+	uint16_t *swap_lo = swap_hi + 1;
+
+	*swap_hi = cpu_to_be16(bcap & BD7182x_MASK_CC_CCNTD_HI);
+	*swap_lo = 0;
+
+	ret = regmap_bulk_write(pwr->regmap, reg, &tmp, sizeof(tmp));
+	if (ret) {
+		dev_err(pwr->dev, "Failed to write coulomb counter\n");
+		return ret;
+	}
+	if (new)
+		*new = cpu_to_be32(tmp);
+
+	return ret;
+}
+
+static int write_cc(struct bd71827_power *pwr, uint16_t bcap)
+{
+	int ret;
+	uint32_t new;
+
+	ret = __write_cc(pwr, bcap, pwr->regs->coulomb3, &new);
+	if (!ret)
+		dev_dbg(pwr->dev, "CC set to 0x%x\n", (int)new);
+
+	return ret;
+}
+
+static int stop_cc(struct bd71827_power *pwr)
+{
+	struct regmap *r = pwr->regmap;
+
+	return regmap_update_bits(r, pwr->regs->coulomb_ctrl,
+				  BD7182x_MASK_CCNTENB, 0);
+}
+
+static int start_cc(struct bd71827_power *pwr)
+{
+	struct regmap *r = pwr->regmap;
+
+	return regmap_update_bits(r, pwr->regs->coulomb_ctrl,
+				  BD7182x_MASK_CCNTENB, BD7182x_MASK_CCNTENB);
+}
+
+static int update_cc(struct bd71827_power *pwr, uint16_t bcap)
+{
+	int ret;
+
+	ret = stop_cc(pwr);
+	if (ret)
+		goto err_out;
+
+	ret = write_cc(pwr, bcap);
+	if (ret)
+		goto enable_out;
+
+	ret = start_cc(pwr);
+	if (ret)
+		goto enable_out;
+
+	return 0;
+
+enable_out:
+	start_cc(pwr);
+err_out:
+	dev_err(pwr->dev, "Coulomb counter write failed  (%d)\n", ret);
+	return ret;
+}
+
+static int bd71828_set_uah(struct sw_gauge *sw, int bcap)
+{
+	struct bd71827_power *pwr = GAUGE_GET_DRVDATA(sw);
+	u16 cc_val = UAH_to_CC(pwr, bcap);
+
+	return update_cc(pwr, cc_val);
+}
+
+static int __read_cc(struct bd71827_power *pwr, u32 *cc, unsigned int reg)
+{
+	int ret;
+	u32 tmp_cc;
+
+	ret = regmap_bulk_read(pwr->regmap, reg, &tmp_cc, sizeof(tmp_cc));
+	if (ret) {
+		dev_err(pwr->dev, "Failed to read coulomb counter\n");
+		return ret;
+	}
+	*cc = be32_to_cpu(tmp_cc) & BD7182x_MASK_CC_CCNTD;
+
+	return 0;
+}
+
+static int read_cc_full(struct bd71827_power *pwr, u32 *cc)
+{
+	return __read_cc(pwr, cc, pwr->regs->coulomb_full3);
+}
+
+static int read_cc(struct bd71827_power *pwr, u32 *cc)
+{
+	return __read_cc(pwr, cc, pwr->regs->coulomb3);
+}
+
+/** @brief set initial coulomb counter value from battery voltage
+ * @param pwr power device
+ * @return 0
+ */
+static int calibration_coulomb_counter(struct bd71827_power *pwr)
+{
+	struct regmap *regmap = pwr->regmap;
+	u32 bcap;
+	int soc, ocv, ret = 0, tmpret = 0;
+
+#if INIT_COULOMB == BY_VBATLOAD_REG
+	/* Get init OCV by HW */
+	bd71827_get_init_bat_stat(pwr, &ocv);
+
+	dev_dbg(pwr->dev, "ocv %d\n", ocv);
+#elif INIT_COULOMB == BY_BAT_VOLT
+	bd71827_calib_voltage(pwr, &ocv);
+#endif
+
+	/* Get init soc from ocv/soc table */
+	ret = bd71827_voltage_to_capacity(NULL, ocv, 0, &soc);
+	if (ret)
+		return ret;
+
+	dev_dbg(pwr->dev, "soc %d[0.1%%]\n", soc);
+	if (soc < 0)
+		soc = 0;
+	bcap = UAH_to_CC(pwr, pwr->battery_cap) * soc / 100;
+	write_cc(pwr, bcap + UAH_to_CC(pwr, pwr->battery_cap) / 200);
+
+	tmpret = write_cc(pwr, bcap);
+	if (tmpret)
+		goto enable_cc_out;
+
+enable_cc_out:
+	/* Start canceling offset of the DS ADC. This needs 1 second at least */
+	ret = regmap_update_bits(regmap, pwr->regs->coulomb_ctrl,
+				 BD7182x_MASK_CCCALIB, BD7182x_MASK_CCCALIB);
+
+	return (tmpret) ? tmpret : ret;
+}
+
+/* This should be used to get VSYS for low limit calculations */
+static int bd71827_get_vsys_min(struct sw_gauge *sw, int *uv)
+{
+	struct bd71827_power *pwr = GAUGE_GET_DRVDATA(sw);
+	uint16_t tmp_vcell;
+	int ret;
+
+	ret = bd7182x_read16_himask(pwr, pwr->regs->vsys_min_avg,
+				    BD7182x_MASK_VBAT_U, &tmp_vcell);
+	if (ret) {
+		dev_err(pwr->dev,
+			"Failed to read system min average voltage\n");
+		return ret;
+	}
+	ret = regmap_update_bits(pwr->regmap, pwr->regs->meas_clear,
+				 BD7182x_MASK_VSYS_MIN_AVG_CLR,
+				 BD7182x_MASK_VSYS_MIN_AVG_CLR);
+	if (ret)
+		dev_warn(pwr->dev, "failed to clear cached Vsys\n");
+
+	*uv = ((int)tmp_vcell) * 1000;
+
+	return 0;
+}
+
+/* This should be used for relax Vbat with BD71827 */
+static int bd71827_get_voltage(struct sw_gauge *sw, int *vbat)
+{
+	int voltage, ret;
+	struct bd71827_power *pwr = GAUGE_GET_DRVDATA(sw);
+
+	ret = bd71827_get_vbat(pwr, &voltage);
+	if (ret)
+		return ret;
+
+	*vbat = voltage;
+
+	return 0;
+}
+
+static int bd71828_get_uah_from_full(struct sw_gauge *sw, int *from_full_uah)
+{
+	int ret;
+	struct bd71827_power *pwr;
+	struct regmap *regmap;
+	u32 full_charged_coulomb_cnt;
+	u32 cc;
+	int diff_coulomb_cnt;
+
+	pwr = GAUGE_GET_DRVDATA(sw);
+	regmap = pwr->regmap;
+
+	/*
+	 * Read and clear the stored CC value from moment when battery was
+	 * last charged to full.
+	 */
+	ret = read_cc_full(pwr, &full_charged_coulomb_cnt);
+	if (ret) {
+		dev_err(pwr->dev, "failed to read full coulomb counter\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(regmap, pwr->regs->cc_full_clr,
+					 BD7182x_MASK_CC_FULL_CLR,
+					 BD7182x_MASK_CC_FULL_CLR);
+	/* Get current CC value to estimate change of charge since full */
+	ret = read_cc(pwr, &cc);
+	if (ret)
+		return ret;
+
+	diff_coulomb_cnt = full_charged_coulomb_cnt - cc;
+
+	diff_coulomb_cnt >>= 16;
+
+	/*
+	 * Ignore possible increase in CC which can be caused by ADC offset or
+	 * temperature change
+	 */
+	if (diff_coulomb_cnt > 0)
+		diff_coulomb_cnt = 0;
+
+	*from_full_uah = CC_to_UAH(pwr, diff_coulomb_cnt);
+
+	return 0;
+}
+
+static int bd71828_get_uah(struct sw_gauge *sw, int *uah)
+{
+	struct bd71827_power *pwr = GAUGE_GET_DRVDATA(sw);
+	u32 cc;
+	int ret;
+
+	ret = read_cc(pwr, &cc);
+	if (!ret)
+		*uah = CC_to_UAH(pwr, cc);
+
+	return ret;
+}
+
+static int init_cc(struct bd71827_power *pwr)
+{
+	return start_cc(pwr);
+}
+
+/*
+ * Standard batinfo supports only accuracy of 1% for SOC - which
+ * may not be sufficient for us. SWGAUGE provides soc in unts of 0.1% here
+ * to allow more accurate computation.
+ */
+int bd71827_get_ocv(struct sw_gauge *sw, int dsoc, int temp, int *ocv)
+{
+	int i = 0;
+
+	if (dsoc > soc_table[0]) {
+		*ocv = MAX_VOLTAGE_DEFAULT;
+		return 0;
+	}
+	if (dsoc == 0) {
+		*ocv = ocv_table[21];
+		return 0;
+	}
+
+	i = 0;
+	while (i < 22) {
+		if ((dsoc <= soc_table[i]) && (dsoc > soc_table[i+1])) {
+			*ocv = (ocv_table[i] - ocv_table[i+1]) *
+			       (dsoc - soc_table[i+1]) / (soc_table[i] -
+			       soc_table[i+1]) + ocv_table[i+1];
+			return 0;
+		}
+		i++;
+	}
+
+	*ocv = ocv_table[22];
+
+	return 0;
+}
+
+static void calc_vdr(int *res, int *vdr, int temp, int dgrd_temp,
+		     int *vdr_hi, int dgrd_temp_hi, int items)
+{
+	int i;
+
+	for (i = 0; i < items; i++)
+		res[i] = vdr[i] + (temp - dgrd_temp) * (vdr_hi[i] - vdr[i]) /
+			 (dgrd_temp_hi - dgrd_temp);
+}
+
+/* get VDR(Voltage Drop Rate) value by SOC */
+static int bd71827_get_vdr(struct bd71827_power *pwr, int dsoc, int temp)
+{
+	int i = 0;
+	int vdr = 100;
+	int vdr_table[NUM_BAT_PARAMS];
+
+	/* Calculate VDR by temperature */
+	if (temp >= DGRD_TEMP_H_DEFAULT)
+		for (i = 0; i < NUM_BAT_PARAMS; i++)
+			vdr_table[i] = vdr_table_h[i];
+	else if (temp >= DGRD_TEMP_M_DEFAULT)
+		calc_vdr(vdr_table, vdr_table_m, temp, DGRD_TEMP_M_DEFAULT,
+			 vdr_table_h, DGRD_TEMP_H_DEFAULT,
+			 NUM_BAT_PARAMS);
+	else if (temp >= DGRD_TEMP_L_DEFAULT)
+		calc_vdr(vdr_table, vdr_table_l, temp, DGRD_TEMP_L_DEFAULT,
+			 vdr_table_m, DGRD_TEMP_M_DEFAULT,
+			 NUM_BAT_PARAMS);
+	else if (temp >= DGRD_TEMP_VL_DEFAULT)
+		calc_vdr(vdr_table, vdr_table_vl, temp,
+			 DGRD_TEMP_VL_DEFAULT, vdr_table_l, DGRD_TEMP_L_DEFAULT,
+			 NUM_BAT_PARAMS);
+	else
+		for (i = 0; i < NUM_BAT_PARAMS; i++)
+			vdr_table[i] = vdr_table_vl[i];
+
+	if (dsoc > soc_table[0]) {
+		vdr = 100;
+	} else if (dsoc == 0) {
+		vdr = vdr_table[NUM_BAT_PARAMS - 2];
+	} else {
+		for (i = 0; i < NUM_BAT_PARAMS - 1; i++)
+			if ((dsoc <= soc_table[i]) && (dsoc > soc_table[i+1])) {
+				vdr = (vdr_table[i] - vdr_table[i+1]) *
+				      (dsoc - soc_table[i+1]) /
+				      (soc_table[i] - soc_table[i+1]) +
+				      vdr_table[i+1];
+				break;
+			}
+		if (i == NUM_BAT_PARAMS - 1)
+			vdr = vdr_table[i];
+	}
+	dev_dbg(pwr->dev, "vdr = %d\n", vdr);
+	return vdr;
+}
+
+static int bd71828_zero_correct(struct sw_gauge *sw, int *effective_cap,
+				int cc_uah, int vbat, int temp)
+{
+	int ocv_table_load[NUM_BAT_PARAMS];
+	int i, ret;
+	int ocv;
+	int dsoc;
+	struct bd71827_power *pwr = GAUGE_GET_DRVDATA(sw);
+
+	/*
+	 * Calculate SOC from CC and effective battery cap.
+	 * Use unit of 0.1% for dsoc to improve accuracy
+	 */
+	dsoc = cc_uah * 1000 / *effective_cap;
+	dev_dbg(pwr->dev,  "dsoc = %d\n", dsoc);
+
+	ret = bd71827_get_ocv(sw, dsoc, 0, &ocv);
+	if (ret)
+		return ret;
+
+	for (i = 1; i < NUM_BAT_PARAMS; i++) {
+		ocv_table_load[i] = ocv_table[i] - (ocv - vbat);
+		if (ocv_table_load[i] <= MIN_VOLTAGE_DEFAULT) {
+			dev_dbg(pwr->dev, "ocv_table_load[%d] = %d\n", i,
+				ocv_table_load[i]);
+			break;
+		}
+	}
+
+	/*
+	 * For improved accuracy ROHM helps customers to measure some
+	 * battery voltage drop curves to do further SOC estimation improvement.
+	 * If VDR tables are available we perform these corrections.
+	 */
+	if (i < NUM_BAT_PARAMS) {
+		int j, k, m;
+		int dv;
+		int lost_cap, new_lost_cap;
+		int dsoc0;
+		int vdr, vdr0;
+
+		dv = (ocv_table_load[i-1] - ocv_table_load[i]) / 5;
+		for (j = 1; j < 5; j++) {
+			if ((ocv_table_load[i] + dv * j) >
+			    MIN_VOLTAGE_DEFAULT) {
+				break;
+			}
+		}
+
+		lost_cap = ((NUM_BAT_PARAMS - 2 - i) * 5 + (j - 1)) *
+			    *effective_cap / 100;
+		dev_dbg(pwr->dev, "lost_cap-1 = %d\n", lost_cap);
+
+		for (m = 0; m < soc_est_max_num; m++) {
+			new_lost_cap = lost_cap;
+			dsoc0 = lost_cap * 1000 / *effective_cap;
+			if ((dsoc >= 0 && dsoc0 > dsoc) ||
+			    (dsoc < 0 && dsoc0 < dsoc))
+				dsoc0 = dsoc;
+
+			dev_dbg(pwr->dev, "dsoc0(%d) = %d\n", m, dsoc0);
+
+			vdr = bd71827_get_vdr(pwr, dsoc, temp);
+			vdr0 = bd71827_get_vdr(pwr, dsoc0, temp);
+
+			for (k = 1; k < NUM_BAT_PARAMS; k++) {
+				ocv_table_load[k] = ocv_table[k] -
+						    (ocv - vbat) * vdr0 / vdr;
+				if (ocv_table_load[k] <= MIN_VOLTAGE_DEFAULT) {
+					dev_dbg(pwr->dev,
+						"ocv_table_load[%d] = %d\n",  k,
+						ocv_table_load[k]);
+					break;
+				}
+			}
+			if (k < NUM_BAT_PARAMS) {
+				dv = (ocv_table_load[k-1] -
+				     ocv_table_load[k]) / 5;
+				for (j = 1; j < 5; j++)
+					if ((ocv_table_load[k] + dv * j) >
+					     MIN_VOLTAGE_DEFAULT)
+						break;
+
+				new_lost_cap = ((NUM_BAT_PARAMS - 2 - k) *
+						 5 + (j - 1)) *
+						*effective_cap / 100;
+				if (soc_est_max_num == 1)
+					lost_cap = new_lost_cap;
+				else
+					lost_cap += (new_lost_cap - lost_cap) /
+						    (2 * (soc_est_max_num - m));
+				dev_dbg(pwr->dev, "lost_cap-2(%d) = %d\n", m,
+					lost_cap);
+			}
+			if (new_lost_cap == lost_cap)
+				break;
+		}
+
+		*effective_cap -= lost_cap;
+	}
+
+	return 0;
+}
+
+static int get_chg_online(struct bd71827_power *pwr, int *chg_online)
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
+static int get_bat_online(struct bd71827_power *pwr, int *bat_online)
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
+static int bd71827_init_hardware(struct bd71827_power *pwr)
+{
+	int r, ret;
+
+	ret = regmap_write(pwr->regmap, pwr->regs->dcin_collapse_limit,
+			   BD7182x_DCIN_COLLAPSE_DEFAULT);
+	if (ret) {
+		dev_err(pwr->dev, "Failed to write DCIN collapse limit\n");
+		return ret;
+	}
+
+	ret = regmap_read(pwr->regmap, pwr->regs->conf, &r);
+	if (ret) {
+		dev_err(pwr->dev, "Failed to read CONF register\n");
+		return ret;
+	}
+
+	if (r & BD7182x_MASK_CONF_PON) {
+		int cc_val;
+
+		/* Init HW, when the battery is inserted. */
+		ret = regmap_update_bits(pwr->regmap, pwr->regs->conf,
+					 BD7182x_MASK_CONF_PON, 0);
+		if (ret) {
+			dev_err(pwr->dev, "Failed to clear CONF register\n");
+			return ret;
+		}
+
+		/* Stop Coulomb Counter */
+		ret = stop_cc(pwr);
+		if (ret)
+			return ret;
+
+		/* Set Coulomb Counter Reset bit*/
+		ret = regmap_update_bits(pwr->regmap, pwr->regs->coulomb_ctrl,
+					 BD7182x_MASK_CCNTRST,
+					 BD7182x_MASK_CCNTRST);
+		if (ret)
+			return ret;
+
+		/* Clear Coulomb Counter Reset bit*/
+		ret = regmap_update_bits(pwr->regmap, pwr->regs->coulomb_ctrl,
+					 BD7182x_MASK_CCNTRST, 0);
+		if (ret)
+			return ret;
+
+		/* Clear Relaxed Coulomb Counter */
+		ret = regmap_update_bits(pwr->regmap, pwr->regs->rex_clear_reg,
+					 pwr->regs->rex_clear_mask,
+					 pwr->regs->rex_clear_mask);
+
+		/* Set initial Coulomb Counter by HW OCV */
+		calibration_coulomb_counter(pwr);
+
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
+		/* convert to correct unit */
+		cc_val = UAH_to_CC(pwr, pwr->battery_cap);
+
+		ret = bd7182x_write16(pwr, pwr->regs->batcap_mon_limit_u,
+				      cc_val * 9 / 10);
+		if (ret)
+			return ret;
+
+		/* Set Battery Capacity Monitor threshold1 as 90% */
+		dev_dbg(pwr->dev, "BD71827_REG_CC_BATCAP1_TH = %d\n",
+			(cc_val * 9 / 10));
+	}
+
+	ret = init_cc(pwr);
+
+	return 0;
+}
+
+ /* Set default parameters if no module parameters were given */
+static void bd71827_set_battery_parameters(struct bd71827_power *pwr)
+{
+	int i;
+
+	if (use_load_bat_params == 0) {
+		battery_cap_mah = BATTERY_CAP_MAH_DEFAULT;
+		dgrd_cyc_cap = DGRD_CYC_CAP_DEFAULT;
+		soc_est_max_num = SOC_EST_MAX_NUM_DEFAULT;
+		dgrd_temp_cap_h = DGRD_TEMP_CAP_H_DEFAULT;
+		dgrd_temp_cap_m = DGRD_TEMP_CAP_M_DEFAULT;
+		dgrd_temp_cap_l = DGRD_TEMP_CAP_L_DEFAULT;
+		for (i = 0; i < NUM_BAT_PARAMS; i++) {
+			ocv_table[i] = ocv_table_default[i];
+			soc_table[i] = soc_table_default[i];
+			vdr_table_h[i] = vdr_table_h_default[i];
+			vdr_table_m[i] = vdr_table_m_default[i];
+			vdr_table_l[i] = vdr_table_l_default[i];
+			vdr_table_vl[i] = vdr_table_vl_default[i];
+		}
+	}
+	for (i = 0; i < NUM_BAT_PARAMS; i++)
+		soc_table[i] = soc_table_default[i];
+
+	pwr->battery_cap = battery_cap_mah * 1000;
+}
+
+static int bd71827_charger_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct bd71827_power *pwr = dev_get_drvdata(psy->dev.parent);
+	u32 vot;
+	uint16_t tmp;
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
+		val->intval = 5000 * vot;		// 5 milli volt steps
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int bd71827_battery_get_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					union power_supply_propval *val)
+{
+	struct bd71827_power *pwr = dev_get_drvdata(psy->dev.parent);
+	int ret = 0;
+	int status, health, tmp, curr, curr_avg;
+
+	if (psp == POWER_SUPPLY_PROP_STATUS || psp == POWER_SUPPLY_PROP_HEALTH
+	    || psp == POWER_SUPPLY_PROP_CHARGE_TYPE)
+		ret = bd71827_charge_status(pwr, &status, &health);
+	else if (psp == POWER_SUPPLY_PROP_CURRENT_AVG ||
+		 psp == POWER_SUPPLY_PROP_CURRENT_NOW)
+		ret = bd71827_get_current_ds_adc(pwr, &curr, &curr_avg);
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
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		if (status == POWER_SUPPLY_STATUS_CHARGING)
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
+		else
+			val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+	case POWER_SUPPLY_PROP_PRESENT:
+		ret = get_bat_online(pwr, &tmp);
+		if (!ret)
+			val->intval = tmp;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		ret = bd71827_get_vbat(pwr, &tmp);
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
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
+		val->intval = MAX_VOLTAGE_DEFAULT;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		val->intval = MIN_VOLTAGE_DEFAULT;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		val->intval = MAX_CURRENT_DEFAULT;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+/** @brief ac properties */
+static enum power_supply_property bd71827_charger_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+};
+
+/** @brief bat properies */
+/* TODO: Fix this in swgauge - swgauge must copy this and add own props
+ */
+static enum power_supply_property bd71827_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+};
+
+static ssize_t charging_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf,
+					   size_t count)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bd71827_power *pwr = power_supply_get_drvdata(psy);
+	ssize_t ret = 0;
+	unsigned long val;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val != 0 && val != 1) {
+		dev_warn(dev, "use 0/1 to disable/enable charging\n");
+		return -EINVAL;
+	}
+
+	if (val)
+		ret = regmap_update_bits(pwr->regmap, pwr->regs->chg_en,
+					 BD7182x_MASK_CHG_EN,
+					 BD7182x_MASK_CHG_EN);
+	else
+		ret = regmap_update_bits(pwr->regmap, pwr->regs->chg_en,
+					 BD7182x_MASK_CHG_EN,
+					 0);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t charging_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct power_supply *psy = dev_get_drvdata(dev);
+	struct bd71827_power *pwr = power_supply_get_drvdata(psy);
+	int chg_en, chg_online, ret;
+
+	ret = regmap_read(pwr->regmap, pwr->regs->chg_en, &chg_en);
+	if (ret)
+		return ret;
+
+	ret = get_chg_online(pwr, &chg_online);
+	if (ret)
+		return ret;
+
+	chg_en &= BD7182x_MASK_CHG_EN;
+	return sprintf(buf, "%x\n", chg_online && chg_en);
+}
+
+static DEVICE_ATTR_RW(charging);
+
+static struct attribute *bd71827_sysfs_attributes[] = {
+	&dev_attr_charging.attr, NULL,
+};
+
+static const struct attribute_group bd71827_sysfs_attr_group = {
+	.attrs = bd71827_sysfs_attributes,
+};
+
+static const struct attribute_group *bd71827_sysfs_attr_groups[] = {
+	&bd71827_sysfs_attr_group, NULL,
+};
+
+/** @brief powers supplied by bd71827_ac */
+static char *bd71827_ac_supplied_to[] = {
+	BAT_NAME,
+};
+
+static const struct power_supply_desc bd71827_ac_desc = {
+	.name		= AC_NAME,
+	.type		= POWER_SUPPLY_TYPE_MAINS,
+	.properties	= bd71827_charger_props,
+	.num_properties	= ARRAY_SIZE(bd71827_charger_props),
+	.get_property	= bd71827_charger_get_property,
+};
+
+static const struct power_supply_desc bd71827_battery_desc = {
+	.name		= BAT_NAME,
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties	= bd71827_battery_props,
+	.num_properties	= ARRAY_SIZE(bd71827_battery_props),
+	.get_property	= bd71827_battery_get_property,
+};
+
+#ifdef PWRCTRL_HACK
+/*
+ * This is not-so-pretty hack for allowing external code to call
+ * bd71827_chip_hibernate() without this power device-data
+ */
+static struct bd71827_power *hack;
+static DEFINE_SPINLOCK(pwrlock);
+
+static struct bd71827_power *get_power(void)
+{
+	mutex_lock(&pwrlock);
+	if (!hack) {
+		mutex_unlock(&pwrlock);
+		return -ENOENT;
+	}
+	return hack;
+}
+
+static void put_power(void)
+{
+	mutex_unlock(&pwrlock);
+}
+
+static int set_power(struct bd71827_power *pwr)
+{
+	mutex_lock(&pwrlock);
+	hack = pwr;
+	mutex_unlock(&pwrlock);
+}
+
+static void free_power(void)
+{
+	mutex_lock(&pwrlock);
+	hack = NULL;
+	mutex_unlock(&pwrlock);
+}
+
+/*
+ * TODO: Find the corret way to do this
+ */
+void bd71827_chip_hibernate(void)
+{
+	struct bd71827_power *pwr = get_power();
+
+	if (IS_ERR(pwr)) {
+		pr_err("%s called before probe finished\n", __func__);
+		return PTR_ERR(pwr);
+	}
+
+	/* programming sequence in EANAB-151 */
+	regmap_update_bits(pwr->regmap, pwr->regs->pwrctrl,
+			   pwr->regs->hibernate_mask, 0);
+	regmap_update_bits(pwr->regmap, pwr->regs->pwrctrl,
+			   pwr->regs->hibernate_mask,
+			   pwr->regs->hibernate_mask);
+	put_power();
+}
+#endif
+
+#define RSENS_CURR 10000000000LLU
+
+static irqreturn_t bd7182x_long_push(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	kobject_uevent(&(pwr->dev->kobj), KOBJ_OFFLINE);
+	dev_info(pwr->dev, "POWERON_LONG\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd7182x_mid_push(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	kobject_uevent(&(pwr->dev->kobj), KOBJ_OFFLINE);
+	dev_info(pwr->dev, "POWERON_MID\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd7182x_push(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	kobject_uevent(&(pwr->dev->kobj), KOBJ_ONLINE);
+	dev_info(pwr->dev, "POWERON_PRESS\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd7182x_dcin_removed(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	dev_info(pwr->dev, "\n~~~DCIN removed\n");
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd7182x_dcin_detected(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	dev_info(pwr->dev, "\n~~~DCIN inserted\n");
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71827_vbat_low_res(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	dev_info(pwr->dev, "\n~~~ VBAT LOW Resumed ...\n");
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71827_vbat_low_det(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	dev_info(pwr->dev, "\n~~~ VBAT LOW Detected ...\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71827_temp_bat_hi_det(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	dev_info(pwr->dev, "\n~~~ Overtemp Detected ...\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71827_temp_bat_hi_res(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	dev_info(pwr->dev, "\n~~~ Overtemp Resumed ...\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71827_temp_bat_low_det(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	dev_info(pwr->dev, "\n~~~ Lowtemp Detected ...\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71827_temp_bat_low_res(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	dev_info(pwr->dev, "\n~~~ Lowtemp Resumed ...\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71827_temp_vf_det(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	dev_info(pwr->dev, "\n~~~ VF Detected ...\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71827_temp_vf_res(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	dev_info(pwr->dev, "\n~~~ VF Resumed ...\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71827_temp_vf125_det(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	dev_info(pwr->dev, "\n~~~ VF125 Detected ...\n");
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd71827_temp_vf125_res(int irq, void *data)
+{
+	struct bd71827_power *pwr = (struct bd71827_power *)data;
+
+	dev_info(pwr->dev, "\n~~~ VF125 Resumed ...\n");
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
+int bd7182x_get_irqs(struct platform_device *pdev, struct bd71827_power *pwr)
+{
+	int i, irq, ret;
+	static const struct bd7182x_irq_res irqs[] = {
+		BDIRQ("bd71828-pwr-longpush", bd7182x_long_push),
+		BDIRQ("bd71828-pwr-midpush", bd7182x_mid_push),
+		BDIRQ("bd71828-pwr-push", bd7182x_push),
+		BDIRQ("bd71828-pwr-dcin-in", bd7182x_dcin_detected),
+		BDIRQ("bd71828-pwr-dcin-out", bd7182x_dcin_removed),
+		BDIRQ("bd71828-vbat-normal", bd71827_vbat_low_res),
+		BDIRQ("bd71828-vbat-low", bd71827_vbat_low_det),
+		BDIRQ("bd71828-btemp-hi", bd71827_temp_bat_hi_det),
+		BDIRQ("bd71828-btemp-cool", bd71827_temp_bat_hi_res),
+		BDIRQ("bd71828-btemp-lo", bd71827_temp_bat_low_det),
+		BDIRQ("bd71828-btemp-warm", bd71827_temp_bat_low_res),
+		BDIRQ("bd71828-temp-hi", bd71827_temp_vf_det),
+		BDIRQ("bd71828-temp-norm", bd71827_temp_vf_res),
+		BDIRQ("bd71828-temp-125-over", bd71827_temp_vf125_det),
+		BDIRQ("bd71828-temp-125-under", bd71827_temp_vf125_res),
+	};
+
+	for (i = 0; i < ARRAY_SIZE(irqs); i++) {
+		irq = platform_get_irq_byname(pdev, irqs[i].name);
+
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						irqs[i].handler, 0 /* IRQF_ONESHOT */,
+						irqs[i].name, pwr);
+		if (ret)
+			break;
+	}
+
+	return 0;
+//	return ret;
+}
+
+#define RSENS_DEFAULT_30MOHM 30000000
+
+int bd7182x_get_rsens(struct bd71827_power *pwr)
+{
+	u64 tmp = RSENS_CURR;
+	int rsens_ohm = RSENS_DEFAULT_30MOHM;
+	struct device_node *np = NULL;
+
+	if (pwr->dev->parent)
+		np = pwr->dev->parent->of_node;
+
+	if (np) {
+		int ret;
+		uint32_t rs;
+
+		ret = of_property_read_u32(np,
+					   "rohm,charger-sense-resistor-ohm",
+					   &rs);
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
+	dev_dbg(pwr->dev, "Setting rsens to %u ohm\n", pwr->rsens);
+	dev_dbg(pwr->dev, "Setting curr-factor to %u\n", pwr->curr_factor);
+	return 0;
+}
+
+/*
+ * BD71827 has no proper support for detecting relaxed battery.
+ * Driver has implemented current polling and logic has been that:
+ * if for the specified time current consumption has always been below
+ * threshold value when polled - then battery is assumed to be relaxed. This
+ * for sure leads to a problem when current cunsumption has had short
+ * 'spikes' - but this is what the logic has been - and it has probably been
+ * working as the driver is left as is? So let's just keep this logic here.
+ */
+static bool bd71827_is_relaxed(struct sw_gauge *sw, int *rex_volt)
+{
+	struct bd71827_power *pwr = GAUGE_GET_DRVDATA(sw);
+	int tmp_curr_mA, ret, curr, curr_avg;
+
+	ret = bd71827_get_current_ds_adc(pwr, &curr, &curr_avg);
+	if (ret) {
+		dev_err(pwr->dev, "Failed to get current\n");
+		return false;
+	}
+
+	tmp_curr_mA = uAMP_TO_mAMP(curr);
+	if ((tmp_curr_mA * tmp_curr_mA) <=
+	    (THR_RELAX_CURRENT_DEFAULT * THR_RELAX_CURRENT_DEFAULT))
+		 /* No load */
+		pwr->relax_time = pwr->relax_time + (JITTER_DEFAULT / 1000);
+	else
+		pwr->relax_time = 0;
+	if (!(pwr->relax_time >= THR_RELAX_TIME_DEFAULT))
+		return false;
+
+	ret = bd71827_get_voltage(sw, rex_volt);
+	if (ret) {
+		dev_err(pwr->dev, "Failed to get Vbat\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool bd71828_is_relaxed(struct sw_gauge *sw, int *rex_volt)
+{
+	int ret;
+	u16 tmp;
+	struct bd71827_power *pwr = GAUGE_GET_DRVDATA(sw);
+
+	ret = bd7182x_read16_himask(pwr, pwr->regs->vbat_rex_avg,
+				    BD7182x_MASK_VBAT_U, &tmp);
+	if (ret) {
+		dev_err(pwr->dev,
+			"Failed to read battery relax voltage\n");
+		return 0;
+	}
+	*rex_volt = tmp * 1000;
+
+	return !!tmp;
+}
+
+static int bd71828_get_cycle(struct sw_gauge *sw, int *cycle)
+{
+	int tmpret, ret, update = 0;
+	uint16_t charged_coulomb_cnt;
+	int cc_designed_cap;
+	struct bd71827_power *pwr = GAUGE_GET_DRVDATA(sw);
+
+	ret = bd7182x_read16_himask(pwr, pwr->regs->coulomb_chg3, 0xff,
+				    &charged_coulomb_cnt);
+	if (ret) {
+		dev_err(pwr->dev, "Failed to read charging CC (%d)\n", ret);
+		return ret;
+	}
+	dev_dbg(pwr->dev, "charged_coulomb_cnt = 0x%x\n",
+		(int)charged_coulomb_cnt);
+
+	cc_designed_cap = UAH_to_CC(pwr, sw->designed_cap);
+
+	while (charged_coulomb_cnt >= cc_designed_cap) {
+		update = 1;
+		/*
+		 * sw-gauge caches old cycle value so we do not need to care
+		 * about it. We just add new cycles
+		 */
+		*cycle = *cycle + 1;
+		dev_dbg(pwr->dev,  "Update cycle = %d\n", *cycle);
+		charged_coulomb_cnt -= cc_designed_cap;
+	}
+	if (update) {
+		ret = stop_cc(pwr);
+		if (ret)
+			return ret;
+
+		ret = bd7182x_write16(pwr, pwr->regs->coulomb_chg3,
+				      charged_coulomb_cnt);
+		if (ret) {
+			dev_err(pwr->dev, "Failed to update charging CC (%d)\n",
+				ret);
+		}
+
+		tmpret = start_cc(pwr);
+		if (tmpret)
+			return tmpret;
+	}
+	return ret;
+}
+
+/* TODO: These are battery specific and should come from DT */
+/* Add these in batinfo? */
+static struct sw_gauge_temp_degr battery_temp_dgr_table[] = {
+	{
+		.temp_floor = DGRD_TEMP_VL_DEFAULT,
+	},
+	{
+		.temp_floor = DGRD_TEMP_L_DEFAULT,
+	},
+	{
+		.temp_floor = DGRD_TEMP_M_DEFAULT,
+	},
+	{
+		.temp_floor = DGRD_TEMP_H_DEFAULT,
+	},
+};
+
+static void fgauge_initial_values(struct bd71827_power *pwr)
+{
+	struct sw_gauge_desc *d = &pwr->gdesc;
+	struct sw_gauge_ops *o = &pwr->ops;
+	int sz;
+
+	/* Set temperature degradation by module parameters */
+	battery_temp_dgr_table[0].temp_degrade_1C = dgrd_temp_cap_vl;
+	battery_temp_dgr_table[0].temp_degrade_1C = dgrd_temp_cap_l;
+	battery_temp_dgr_table[0].temp_degrade_1C = dgrd_temp_cap_m;
+	battery_temp_dgr_table[0].temp_degrade_1C = dgrd_temp_cap_h;
+
+	/* TODO: See if these could be get from DT? */
+	d->poll_interval = JITTER_DEFAULT; /* 3 seconds */
+	d->allow_set_cycle = true;
+	d->amount_of_temp_dgr = ARRAY_SIZE(battery_temp_dgr_table);
+	d->temp_dgr = battery_temp_dgr_table;
+	d->degrade_cycle_uah = dgrd_cyc_cap;
+	d->cap_adjust_volt_threshold = THR_VOLTAGE_DEFAULT;
+	d->designed_cap = pwr->battery_cap;
+
+	o->get_uah_from_full = bd71828_get_uah_from_full;	/* Ok */
+	o->get_uah = bd71828_get_uah;				/* Ok */
+	o->update_cc_uah = bd71828_set_uah;			/* Ok */
+	o->get_cycle = bd71828_get_cycle;			/* Ok */
+	o->get_vsys = bd71827_get_vsys_min;
+
+	/*
+	 * TODO: Add VDR stuff to DT and add this call-back conditionally.
+	 * We should not require the VDR parameters here - if user has no
+	 * interest/need for more accurate SOC estimation then he should not
+	 * be forced to get the VDR parameters from ROHM.
+	 */
+	o->zero_cap_adjust = bd71828_zero_correct;
+
+	if (!of_find_property(pwr->dev->of_node, "ocv-capacity-celsius",
+			      &sz)) {
+		o->get_soc_by_ocv = &bd71827_voltage_to_capacity;
+		o->get_ocv_by_soc = &bd71827_get_ocv;
+	} else {
+		dev_dbg(pwr->dev, "OCV values given from DT\n");
+	}
+
+	/* TODO:
+	 *	o->suspend_calibrate = bd71828_suspend_calibrate;
+	 */
+	switch (pwr->chip_type) {
+	case ROHM_CHIP_TYPE_BD71828:
+	case ROHM_CHIP_TYPE_BD71878:
+		o->get_temp = bd71828_get_temp;
+		o->is_relaxed = bd71828_is_relaxed;
+		break;
+	case ROHM_CHIP_TYPE_BD71827:
+		o->get_temp = bd71827_get_temp;
+		o->is_relaxed = bd71827_is_relaxed;
+		break;
+	/*
+	 * No need to handle default here as this is done already in probe.
+	 * But this keeps gcc shut-up.
+	 */
+	default:
+		break;
+	}
+}
+
+static int bd71827_power_probe(struct platform_device *pdev)
+{
+	struct bd71827_power *pwr;
+	struct power_supply_config ac_cfg = {};
+	struct power_supply_config bat_cfg = {};
+	struct sw_gauge_psy psycfg;
+	int ret;
+	struct regmap *regmap;
+
+	psycfg.pcfg = &bat_cfg;
+	psycfg.pdesc = &bd71827_battery_desc;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap) {
+		dev_err(&pdev->dev, "No parent regmap\n");
+		return -EINVAL;
+	}
+
+	pwr = devm_kzalloc(&pdev->dev, sizeof(*pwr), GFP_KERNEL);
+	if (pwr == NULL)
+		return -ENOMEM;
+
+	pwr->regmap = regmap;
+	pwr->dev = &pdev->dev;
+	pwr->chip_type = platform_get_device_id(pdev)->driver_data;
+	spin_lock_init(&pwr->dlock);
+
+	switch (pwr->chip_type) {
+	case ROHM_CHIP_TYPE_BD71828:
+	case ROHM_CHIP_TYPE_BD71878:
+		pwr->regs = &pwr_regs_bd71828;
+		dev_info(pwr->dev, "Found ROHM BD718x8\n");
+		break;
+	case ROHM_CHIP_TYPE_BD71827:
+		pwr->regs = &pwr_regs_bd71827;
+		dev_warn(pwr->dev, "BD71817 not tested\n");
+		break;
+	default:
+		dev_err(pwr->dev, "Unknown PMIC\n");
+		return -EINVAL;
+	}
+
+	/* We need to set batcap etc before we do set fgauge initial values */
+	bd71827_set_battery_parameters(pwr);
+	fgauge_initial_values(pwr);
+
+	ret = bd7182x_get_rsens(pwr);
+	if (ret) {
+		dev_err(&pdev->dev, "sense resistor missing\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, pwr);
+	bd71827_init_hardware(pwr);
+
+	bat_cfg.drv_data	= pwr;
+	bat_cfg.attr_grp	= &bd71827_sysfs_attr_groups[0];
+	bat_cfg.of_node		= pdev->dev.parent->of_node;
+
+	ac_cfg.supplied_to	= bd71827_ac_supplied_to;
+	ac_cfg.num_supplicants	= ARRAY_SIZE(bd71827_ac_supplied_to);
+	ac_cfg.drv_data		= pwr;
+
+	pwr->ac = devm_power_supply_register(&pdev->dev, &bd71827_ac_desc,
+					     &ac_cfg);
+	if (IS_ERR(pwr->ac)) {
+		ret = PTR_ERR(pwr->ac);
+		dev_err(&pdev->dev, "failed to register ac: %d\n", ret);
+		return ret;
+	}
+
+	/* Is name needed? If yes, then it should be numbered.. :/ */
+	pwr->gdesc.name = "bd71828-gauge";
+	pwr->sw = devm_psy_register_sw_gauge(pwr->dev, &psycfg, &pwr->ops,
+					&pwr->gdesc);
+	if (IS_ERR(pwr->sw)) {
+		dev_err(&pdev->dev, "SW-gauge registration failed\n");
+		return PTR_ERR(pwr->sw);
+	}
+
+	ret = bd7182x_get_irqs(pdev, pwr);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to request IRQs: %d\n", ret);
+		return ret;
+	};
+
+	/* Configure wakeup capable */
+	device_set_wakeup_capable(pwr->dev, 1);
+	device_set_wakeup_enable(pwr->dev, 1);
+
+	return 0;
+}
+
+static const struct platform_device_id bd71827_charger_id[] = {
+	{ "bd71827-power", ROHM_CHIP_TYPE_BD71827 },
+	{ "bd71828-power", ROHM_CHIP_TYPE_BD71828 },
+	{ "bd71878-power", ROHM_CHIP_TYPE_BD71878 },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, bd71827_charger_id);
+
+static struct platform_driver bd71827_power_driver = {
+	.driver = {
+		.name = "bd71827-power",
+	},
+	.probe = bd71827_power_probe,
+	.id_table = bd71827_charger_id,
+};
+
+module_platform_driver(bd71827_power_driver);
+
+module_param(use_load_bat_params, int, 0444);
+MODULE_PARM_DESC(use_load_bat_params, "use_load_bat_params:Use loading battery parameters");
+
+module_param(battery_cap_mah, int, 0444);
+MODULE_PARM_DESC(battery_cap_mah, "battery_cap_mah:Battery capacity (mAh)");
+
+module_param(dgrd_cyc_cap, int, 0444);
+MODULE_PARM_DESC(dgrd_cyc_cap, "dgrd_cyc_cap:Degraded capacity per cycle (uAh)");
+
+module_param(soc_est_max_num, int, 0444);
+MODULE_PARM_DESC(soc_est_max_num, "soc_est_max_num:SOC estimation max repeat number");
+
+module_param(dgrd_temp_cap_h, int, 0444);
+MODULE_PARM_DESC(dgrd_temp_cap_h, "dgrd_temp_cap_h:Degraded capacity at high temperature (uAh)");
+
+module_param(dgrd_temp_cap_m, int, 0444);
+MODULE_PARM_DESC(dgrd_temp_cap_m, "dgrd_temp_cap_m:Degraded capacity at middle temperature (uAh)");
+
+module_param(dgrd_temp_cap_l, int, 0444);
+MODULE_PARM_DESC(dgrd_temp_cap_l, "dgrd_temp_cap_l:Degraded capacity at low temperature (uAh)");
+
+module_param(dgrd_temp_cap_vl, int, 0444);
+MODULE_PARM_DESC(dgrd_temp_cap_vl, "dgrd_temp_cap_vl:Degraded capacity at very low temperature (uAh)");
+
+module_param_array(ocv_table, int, NULL, 0444);
+MODULE_PARM_DESC(ocv_table, "ocv_table:Open Circuit Voltage table (uV)");
+
+module_param_array(vdr_table_h, int, NULL, 0444);
+MODULE_PARM_DESC(vdr_table_h, "vdr_table_h:Voltage Drop Ratio temperature high area table");
+
+module_param_array(vdr_table_m, int, NULL, 0444);
+MODULE_PARM_DESC(vdr_table_m, "vdr_table_m:Voltage Drop Ratio temperature middle area table");
+
+module_param_array(vdr_table_l, int, NULL, 0444);
+MODULE_PARM_DESC(vdr_table_l, "vdr_table_l:Voltage Drop Ratio temperature low area table");
+
+module_param_array(vdr_table_vl, int, NULL, 0444);
+MODULE_PARM_DESC(vdr_table_vl, "vdr_table_vl:Voltage Drop Ratio temperature very low area table");
+
+MODULE_AUTHOR("Cong Pham <cpham2403@gmail.com>");
+MODULE_DESCRIPTION("ROHM BD718(27/28/78) PMIC Battery Charger driver");
+MODULE_LICENSE("GPL");
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
