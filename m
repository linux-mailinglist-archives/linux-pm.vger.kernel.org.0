Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B556C16588B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 08:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgBTHg1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 02:36:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45742 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBTHg1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 02:36:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id e18so3079426ljn.12;
        Wed, 19 Feb 2020 23:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aVaTaGAdPnXmlEao5t9a8PtghnVt1a2fykzb/9fBetk=;
        b=YKXtJmPAow7STBfpon54tj50Bz2dfXXkH6TurYRhkIAUAuZtZvdPzg2KpAxd+UdMwe
         jWN6d/L0iMN596fesH8FUY0T2GX0Yse8jnE88rSVKP3CTkTlksoqVDy274AI57g0jcXA
         Re6FSroueRiCrFnpW7B5+J47GjoBD7CaxRTeCDF17dJ0Y8owXPAjwcmUAwQP5dhoms0M
         XxLgrVY/sa+gX+xHAHzvCJIXfIniapqV3p3dNJvrWhE1vgjmmrkwL2juuFxLZFK8tAWT
         0ykAD6BKmS0dL7UCwEmQv9pAFh8QAViRc87iRhpO8T0NVU2hHOArngs8Hf2lxeA8FjM4
         bY1w==
X-Gm-Message-State: APjAAAWEwz5D08DoV4AvZwS+ijYZhdgpRGvDJN81cW/cv8NnXgG0ubAR
        3M7/vXJfx+JjN+lxTm15rAs=
X-Google-Smtp-Source: APXvYqyFLl3F+GE4wtPuN+vUsdfXeSxwXTHOea5waQ9zUgkK0aNag2unkASLnZyyFk7w6tiMgmrHgw==
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr19083609ljj.265.1582184179351;
        Wed, 19 Feb 2020 23:36:19 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id o6sm1269816lfg.11.2020.02.19.23.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 23:36:18 -0800 (PST)
Date:   Thu, 20 Feb 2020 09:36:10 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Milo Kim <milo.kim@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "GitAuthor: Matti Vaittinen" <matti.vaittinen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: [RFC PATCH v3 4/8] regulator: rename regulator_linear_range to
 linear_range
Message-ID: <f66749295e07448012c80c2054b1f14506d17d76.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rename the "regulator_linear_range" to more generic linear_range
as a first step towards converting the "regulator_linear_range"
to common helpers.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/88pg86x.c             |  4 +-
 drivers/regulator/88pm800-regulator.c   |  4 +-
 drivers/regulator/act8865-regulator.c   |  4 +-
 drivers/regulator/act8945a-regulator.c  |  2 +-
 drivers/regulator/arizona-ldo1.c        |  2 +-
 drivers/regulator/arizona-micsupp.c     |  4 +-
 drivers/regulator/as3711-regulator.c    |  6 +--
 drivers/regulator/as3722-regulator.c    |  4 +-
 drivers/regulator/axp20x-regulator.c    | 16 +++---
 drivers/regulator/bcm590xx-regulator.c  |  8 +--
 drivers/regulator/bd70528-regulator.c   |  8 +--
 drivers/regulator/bd718x7-regulator.c   | 26 ++++-----
 drivers/regulator/da903x.c              |  2 +-
 drivers/regulator/helpers.c             |  8 +--
 drivers/regulator/hi6421-regulator.c    |  4 +-
 drivers/regulator/lochnagar-regulator.c |  4 +-
 drivers/regulator/lp873x-regulator.c    |  4 +-
 drivers/regulator/lp87565-regulator.c   |  2 +-
 drivers/regulator/lp8788-buck.c         |  2 +-
 drivers/regulator/max77650-regulator.c  |  2 +-
 drivers/regulator/mcp16502.c            |  4 +-
 drivers/regulator/mt6323-regulator.c    |  6 +--
 drivers/regulator/mt6358-regulator.c    |  8 +--
 drivers/regulator/mt6380-regulator.c    |  6 +--
 drivers/regulator/mt6397-regulator.c    |  6 +--
 drivers/regulator/palmas-regulator.c    |  4 +-
 drivers/regulator/qcom-rpmh-regulator.c |  2 +-
 drivers/regulator/qcom_rpm-regulator.c  | 14 ++---
 drivers/regulator/qcom_smd-regulator.c  | 70 ++++++++++++-------------
 drivers/regulator/rk808-regulator.c     | 10 ++--
 drivers/regulator/s2mps11.c             | 14 ++---
 drivers/regulator/sky81452-regulator.c  |  2 +-
 drivers/regulator/stpmic1_regulator.c   | 18 +++----
 drivers/regulator/tps65086-regulator.c  | 10 ++--
 drivers/regulator/tps65217-regulator.c  |  4 +-
 drivers/regulator/tps65218-regulator.c  |  6 +--
 drivers/regulator/tps65912-regulator.c  |  4 +-
 drivers/regulator/twl-regulator.c       |  4 +-
 drivers/regulator/twl6030-regulator.c   |  2 +-
 drivers/regulator/wm831x-dcdc.c         |  2 +-
 drivers/regulator/wm831x-ldo.c          |  4 +-
 drivers/regulator/wm8350-regulator.c    |  2 +-
 drivers/regulator/wm8400-regulator.c    |  2 +-
 include/linux/regulator/driver.h        |  8 +--
 44 files changed, 164 insertions(+), 164 deletions(-)

diff --git a/drivers/regulator/88pg86x.c b/drivers/regulator/88pg86x.c
index d5ef55c81185..71cfa2c5de5e 100644
--- a/drivers/regulator/88pg86x.c
+++ b/drivers/regulator/88pg86x.c
@@ -11,13 +11,13 @@ static const struct regulator_ops pg86x_ops = {
 	.list_voltage = regulator_list_voltage_linear_range,
 };
 
-static const struct regulator_linear_range pg86x_buck1_ranges[] = {
+static const struct linear_range pg86x_buck1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(      0,  0, 10,     0),
 	REGULATOR_LINEAR_RANGE(1000000, 11, 34, 25000),
 	REGULATOR_LINEAR_RANGE(1600000, 35, 47, 50000),
 };
 
-static const struct regulator_linear_range pg86x_buck2_ranges[] = {
+static const struct linear_range pg86x_buck2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(      0,  0, 15,     0),
 	REGULATOR_LINEAR_RANGE(1000000, 16, 39, 25000),
 	REGULATOR_LINEAR_RANGE(1600000, 40, 52, 50000),
diff --git a/drivers/regulator/88pm800-regulator.c b/drivers/regulator/88pm800-regulator.c
index 69ae25886181..d08ee81ed1ac 100644
--- a/drivers/regulator/88pm800-regulator.c
+++ b/drivers/regulator/88pm800-regulator.c
@@ -134,13 +134,13 @@ struct pm800_regulator_info {
 }
 
 /* Ranges are sorted in ascending order. */
-static const struct regulator_linear_range buck1_volt_range[] = {
+static const struct linear_range buck1_volt_range[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 0x4f, 12500),
 	REGULATOR_LINEAR_RANGE(1600000, 0x50, 0x54, 50000),
 };
 
 /* BUCK 2~5 have same ranges. */
-static const struct regulator_linear_range buck2_5_volt_range[] = {
+static const struct linear_range buck2_5_volt_range[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 0x4f, 12500),
 	REGULATOR_LINEAR_RANGE(1600000, 0x50, 0x72, 50000),
 };
diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 0fa97f934df4..19b9742c9ecc 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -220,13 +220,13 @@ static const struct regmap_config act8865_regmap_config = {
 	.val_bits = 8,
 };
 
-static const struct regulator_linear_range act8865_voltage_ranges[] = {
+static const struct linear_range act8865_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 23, 25000),
 	REGULATOR_LINEAR_RANGE(1200000, 24, 47, 50000),
 	REGULATOR_LINEAR_RANGE(2400000, 48, 63, 100000),
 };
 
-static const struct regulator_linear_range act8600_sudcdc_voltage_ranges[] = {
+static const struct linear_range act8600_sudcdc_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(3000000, 0, 63, 0),
 	REGULATOR_LINEAR_RANGE(3000000, 64, 159, 100000),
 	REGULATOR_LINEAR_RANGE(12600000, 160, 191, 200000),
diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index d2f804dbc785..6a62f946ccae 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -73,7 +73,7 @@ struct act8945a_pmic {
 	u32 op_mode[ACT8945A_ID_MAX];
 };
 
-static const struct regulator_linear_range act8945a_voltage_ranges[] = {
+static const struct linear_range act8945a_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 23, 25000),
 	REGULATOR_LINEAR_RANGE(1200000, 24, 47, 50000),
 	REGULATOR_LINEAR_RANGE(2400000, 48, 63, 100000),
diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index 1a3d7b720f5e..ade0bef4569d 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -87,7 +87,7 @@ static const struct regulator_ops arizona_ldo1_hc_ops = {
 	.set_bypass = regulator_set_bypass_regmap,
 };
 
-static const struct regulator_linear_range arizona_ldo1_hc_ranges[] = {
+static const struct linear_range arizona_ldo1_hc_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0, 0x6, 50000),
 	REGULATOR_LINEAR_RANGE(1800000, 0x7, 0x7, 0),
 };
diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index ae1a5de3e57d..f6cfd3f6f0dd 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -125,7 +125,7 @@ static const struct regulator_ops arizona_micsupp_ops = {
 	.set_bypass = arizona_micsupp_set_bypass,
 };
 
-static const struct regulator_linear_range arizona_micsupp_ranges[] = {
+static const struct linear_range arizona_micsupp_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0,    0x1e, 50000),
 	REGULATOR_LINEAR_RANGE(3300000, 0x1f, 0x1f, 0),
 };
@@ -152,7 +152,7 @@ static const struct regulator_desc arizona_micsupp = {
 	.owner = THIS_MODULE,
 };
 
-static const struct regulator_linear_range arizona_micsupp_ext_ranges[] = {
+static const struct linear_range arizona_micsupp_ext_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000,  0,    0x14, 25000),
 	REGULATOR_LINEAR_RANGE(1500000, 0x15, 0x27, 100000),
 };
diff --git a/drivers/regulator/as3711-regulator.c b/drivers/regulator/as3711-regulator.c
index ece88103f2fd..b6b9206969ae 100644
--- a/drivers/regulator/as3711-regulator.c
+++ b/drivers/regulator/as3711-regulator.c
@@ -103,18 +103,18 @@ static const struct regulator_ops as3711_dldo_ops = {
 	.map_voltage		= regulator_map_voltage_linear_range,
 };
 
-static const struct regulator_linear_range as3711_sd_ranges[] = {
+static const struct linear_range as3711_sd_ranges[] = {
 	REGULATOR_LINEAR_RANGE(612500, 0x1, 0x40, 12500),
 	REGULATOR_LINEAR_RANGE(1425000, 0x41, 0x70, 25000),
 	REGULATOR_LINEAR_RANGE(2650000, 0x71, 0x7f, 50000),
 };
 
-static const struct regulator_linear_range as3711_aldo_ranges[] = {
+static const struct linear_range as3711_aldo_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1200000, 0, 0xf, 50000),
 	REGULATOR_LINEAR_RANGE(1800000, 0x10, 0x1f, 100000),
 };
 
-static const struct regulator_linear_range as3711_dldo_ranges[] = {
+static const struct linear_range as3711_dldo_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0, 0x10, 50000),
 	REGULATOR_LINEAR_RANGE(1750000, 0x20, 0x3f, 50000),
 };
diff --git a/drivers/regulator/as3722-regulator.c b/drivers/regulator/as3722-regulator.c
index bd5d0bacb08d..33ca197860b3 100644
--- a/drivers/regulator/as3722-regulator.c
+++ b/drivers/regulator/as3722-regulator.c
@@ -389,7 +389,7 @@ static const struct regulator_ops as3722_ldo6_extcntrl_ops = {
 	.set_bypass = regulator_set_bypass_regmap,
 };
 
-static const struct regulator_linear_range as3722_ldo_ranges[] = {
+static const struct linear_range as3722_ldo_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, 0x00, 0x00, 0),
 	REGULATOR_LINEAR_RANGE(825000, 0x01, 0x24, 25000),
 	REGULATOR_LINEAR_RANGE(1725000, 0x40, 0x7F, 25000),
@@ -487,7 +487,7 @@ static bool as3722_sd0_is_low_voltage(struct as3722_regulators *as3722_regs)
 	return false;
 }
 
-static const struct regulator_linear_range as3722_sd2345_ranges[] = {
+static const struct linear_range as3722_sd2345_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, 0x00, 0x00, 0),
 	REGULATOR_LINEAR_RANGE(612500, 0x01, 0x40, 12500),
 	REGULATOR_LINEAR_RANGE(1425000, 0x41, 0x70, 25000),
diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 16f0c8570036..7b3dc37130f3 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -512,7 +512,7 @@ static const struct regulator_ops axp20x_ops_sw = {
 	.is_enabled		= regulator_is_enabled_regmap,
 };
 
-static const struct regulator_linear_range axp20x_ldo4_ranges[] = {
+static const struct linear_range axp20x_ldo4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1250000,
 			       AXP20X_LDO4_V_OUT_1250mV_START,
 			       AXP20X_LDO4_V_OUT_1250mV_END,
@@ -640,7 +640,7 @@ static const struct regulator_desc axp22x_drivevbus_regulator = {
 };
 
 /* DCDC ranges shared with AXP813 */
-static const struct regulator_linear_range axp803_dcdc234_ranges[] = {
+static const struct linear_range axp803_dcdc234_ranges[] = {
 	REGULATOR_LINEAR_RANGE(500000,
 			       AXP803_DCDC234_500mV_START,
 			       AXP803_DCDC234_500mV_END,
@@ -651,7 +651,7 @@ static const struct regulator_linear_range axp803_dcdc234_ranges[] = {
 			       20000),
 };
 
-static const struct regulator_linear_range axp803_dcdc5_ranges[] = {
+static const struct linear_range axp803_dcdc5_ranges[] = {
 	REGULATOR_LINEAR_RANGE(800000,
 			       AXP803_DCDC5_800mV_START,
 			       AXP803_DCDC5_800mV_END,
@@ -662,7 +662,7 @@ static const struct regulator_linear_range axp803_dcdc5_ranges[] = {
 			       20000),
 };
 
-static const struct regulator_linear_range axp803_dcdc6_ranges[] = {
+static const struct linear_range axp803_dcdc6_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000,
 			       AXP803_DCDC6_600mV_START,
 			       AXP803_DCDC6_600mV_END,
@@ -674,7 +674,7 @@ static const struct regulator_linear_range axp803_dcdc6_ranges[] = {
 };
 
 /* AXP806's CLDO2 and AXP809's DLDO1 share the same range */
-static const struct regulator_linear_range axp803_dldo2_ranges[] = {
+static const struct linear_range axp803_dldo2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(700000,
 			       AXP803_DLDO2_700mV_START,
 			       AXP803_DLDO2_700mV_END,
@@ -760,7 +760,7 @@ static const struct regulator_desc axp803_regulators[] = {
 	AXP_DESC_FIXED(AXP803, RTC_LDO, "rtc-ldo", "ips", 3000),
 };
 
-static const struct regulator_linear_range axp806_dcdca_ranges[] = {
+static const struct linear_range axp806_dcdca_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000,
 			       AXP806_DCDCA_600mV_START,
 			       AXP806_DCDCA_600mV_END,
@@ -771,7 +771,7 @@ static const struct regulator_linear_range axp806_dcdca_ranges[] = {
 			       20000),
 };
 
-static const struct regulator_linear_range axp806_dcdcd_ranges[] = {
+static const struct linear_range axp806_dcdcd_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000,
 			       AXP806_DCDCD_600mV_START,
 			       AXP806_DCDCD_600mV_END,
@@ -836,7 +836,7 @@ static const struct regulator_desc axp806_regulators[] = {
 		    AXP806_PWR_OUT_CTRL2, AXP806_PWR_OUT_SW_MASK),
 };
 
-static const struct regulator_linear_range axp809_dcdc4_ranges[] = {
+static const struct linear_range axp809_dcdc4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000,
 			       AXP809_DCDC4_600mV_START,
 			       AXP809_DCDC4_600mV_END,
diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index 8c98c3f07660..65e23fc5f9c3 100644
--- a/drivers/regulator/bcm590xx-regulator.c
+++ b/drivers/regulator/bcm590xx-regulator.c
@@ -116,14 +116,14 @@ static const unsigned int ldo_vbus[] = {
 };
 
 /* DCDC group CSR: supported voltages in microvolts */
-static const struct regulator_linear_range dcdc_csr_ranges[] = {
+static const struct linear_range dcdc_csr_ranges[] = {
 	REGULATOR_LINEAR_RANGE(860000, 2, 50, 10000),
 	REGULATOR_LINEAR_RANGE(1360000, 51, 55, 20000),
 	REGULATOR_LINEAR_RANGE(900000, 56, 63, 0),
 };
 
 /* DCDC group IOSR1: supported voltages in microvolts */
-static const struct regulator_linear_range dcdc_iosr1_ranges[] = {
+static const struct linear_range dcdc_iosr1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(860000, 2, 51, 10000),
 	REGULATOR_LINEAR_RANGE(1500000, 52, 52, 0),
 	REGULATOR_LINEAR_RANGE(1800000, 53, 53, 0),
@@ -131,7 +131,7 @@ static const struct regulator_linear_range dcdc_iosr1_ranges[] = {
 };
 
 /* DCDC group SDSR1: supported voltages in microvolts */
-static const struct regulator_linear_range dcdc_sdsr1_ranges[] = {
+static const struct linear_range dcdc_sdsr1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(860000, 2, 50, 10000),
 	REGULATOR_LINEAR_RANGE(1340000, 51, 51, 0),
 	REGULATOR_LINEAR_RANGE(900000, 52, 63, 0),
@@ -143,7 +143,7 @@ struct bcm590xx_info {
 	u8 n_voltages;
 	const unsigned int *volt_table;
 	u8 n_linear_ranges;
-	const struct regulator_linear_range *linear_ranges;
+	const struct linear_range *linear_ranges;
 };
 
 #define BCM590XX_REG_TABLE(_name, _table) \
diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index 5bf8a2dc5fe7..d44adf7e875a 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -20,22 +20,22 @@
 #define BUCK_RAMPRATE_125MV 1
 #define BUCK_RAMP_MAX 250
 
-static const struct regulator_linear_range bd70528_buck1_volts[] = {
+static const struct linear_range bd70528_buck1_volts[] = {
 	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x1, 600000),
 	REGULATOR_LINEAR_RANGE(2750000, 0x2, 0xf, 50000),
 };
-static const struct regulator_linear_range bd70528_buck2_volts[] = {
+static const struct linear_range bd70528_buck2_volts[] = {
 	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x1, 300000),
 	REGULATOR_LINEAR_RANGE(1550000, 0x2, 0xd, 50000),
 	REGULATOR_LINEAR_RANGE(3000000, 0xe, 0xf, 300000),
 };
-static const struct regulator_linear_range bd70528_buck3_volts[] = {
+static const struct linear_range bd70528_buck3_volts[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0x00, 0xd, 50000),
 	REGULATOR_LINEAR_RANGE(1800000, 0xe, 0xf, 0),
 };
 
 /* All LDOs have same voltage ranges */
-static const struct regulator_linear_range bd70528_ldo_volts[] = {
+static const struct linear_range bd70528_ldo_volts[] = {
 	REGULATOR_LINEAR_RANGE(1650000, 0x0, 0x07, 50000),
 	REGULATOR_LINEAR_RANGE(2100000, 0x8, 0x0f, 100000),
 	REGULATOR_LINEAR_RANGE(2850000, 0x10, 0x19, 50000),
diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 13a43eee2e46..d9bef74430d5 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -152,7 +152,7 @@ static const struct regulator_ops bd718xx_dvs_buck_regulator_ops = {
  * BD71847 BUCK1/2
  * 0.70 to 1.30V (10mV step)
  */
-static const struct regulator_linear_range bd718xx_dvs_buck_volts[] = {
+static const struct linear_range bd718xx_dvs_buck_volts[] = {
 	REGULATOR_LINEAR_RANGE(700000, 0x00, 0x3C, 10000),
 	REGULATOR_LINEAR_RANGE(1300000, 0x3D, 0x3F, 0),
 };
@@ -163,7 +163,7 @@ static const struct regulator_linear_range bd718xx_dvs_buck_volts[] = {
  * and
  * 0.675 to 1.325 (range 1)
  */
-static const struct regulator_linear_range bd71837_buck5_volts[] = {
+static const struct linear_range bd71837_buck5_volts[] = {
 	/* Ranges when VOLT_SEL bit is 0 */
 	REGULATOR_LINEAR_RANGE(700000, 0x00, 0x03, 100000),
 	REGULATOR_LINEAR_RANGE(1050000, 0x04, 0x05, 50000),
@@ -185,7 +185,7 @@ static const unsigned int bd71837_buck5_volt_range_sel[] = {
 /*
  * BD71847 BUCK3
  */
-static const struct regulator_linear_range bd71847_buck3_volts[] = {
+static const struct linear_range bd71847_buck3_volts[] = {
 	/* Ranges when VOLT_SEL bits are 00 */
 	REGULATOR_LINEAR_RANGE(700000, 0x00, 0x03, 100000),
 	REGULATOR_LINEAR_RANGE(1050000, 0x04, 0x05, 50000),
@@ -202,7 +202,7 @@ static const unsigned int bd71847_buck3_volt_range_sel[] = {
 	0x0, 0x0, 0x0, 0x40, 0x80, 0x80, 0x80
 };
 
-static const struct regulator_linear_range bd71847_buck4_volts[] = {
+static const struct linear_range bd71847_buck4_volts[] = {
 	REGULATOR_LINEAR_RANGE(3000000, 0x00, 0x03, 100000),
 	REGULATOR_LINEAR_RANGE(2600000, 0x00, 0x03, 100000),
 };
@@ -213,7 +213,7 @@ static const unsigned int bd71847_buck4_volt_range_sel[] = { 0x0, 0x40 };
  * BUCK6
  * 3.0V to 3.3V (step 100mV)
  */
-static const struct regulator_linear_range bd71837_buck6_volts[] = {
+static const struct linear_range bd71837_buck6_volts[] = {
 	REGULATOR_LINEAR_RANGE(3000000, 0x00, 0x03, 100000),
 };
 
@@ -237,7 +237,7 @@ static const unsigned int bd718xx_3rd_nodvs_buck_volts[] = {
  * BUCK8
  * 0.8V to 1.40V (step 10mV)
  */
-static const struct regulator_linear_range bd718xx_4th_nodvs_buck_volts[] = {
+static const struct linear_range bd718xx_4th_nodvs_buck_volts[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x3C, 10000),
 };
 
@@ -245,7 +245,7 @@ static const struct regulator_linear_range bd718xx_4th_nodvs_buck_volts[] = {
  * LDO1
  * 3.0 to 3.3V (100mV step)
  */
-static const struct regulator_linear_range bd718xx_ldo1_volts[] = {
+static const struct linear_range bd718xx_ldo1_volts[] = {
 	REGULATOR_LINEAR_RANGE(3000000, 0x00, 0x03, 100000),
 	REGULATOR_LINEAR_RANGE(1600000, 0x00, 0x03, 100000),
 };
@@ -264,7 +264,7 @@ static const unsigned int ldo_2_volts[] = {
  * LDO3
  * 1.8 to 3.3V (100mV step)
  */
-static const struct regulator_linear_range bd718xx_ldo3_volts[] = {
+static const struct linear_range bd718xx_ldo3_volts[] = {
 	REGULATOR_LINEAR_RANGE(1800000, 0x00, 0x0F, 100000),
 };
 
@@ -272,7 +272,7 @@ static const struct regulator_linear_range bd718xx_ldo3_volts[] = {
  * LDO4
  * 0.9 to 1.8V (100mV step)
  */
-static const struct regulator_linear_range bd718xx_ldo4_volts[] = {
+static const struct linear_range bd718xx_ldo4_volts[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0x00, 0x09, 100000),
 };
 
@@ -280,7 +280,7 @@ static const struct regulator_linear_range bd718xx_ldo4_volts[] = {
  * LDO5 for BD71837
  * 1.8 to 3.3V (100mV step)
  */
-static const struct regulator_linear_range bd71837_ldo5_volts[] = {
+static const struct linear_range bd71837_ldo5_volts[] = {
 	REGULATOR_LINEAR_RANGE(1800000, 0x00, 0x0F, 100000),
 };
 
@@ -288,7 +288,7 @@ static const struct regulator_linear_range bd71837_ldo5_volts[] = {
  * LDO5 for BD71837
  * 1.8 to 3.3V (100mV step)
  */
-static const struct regulator_linear_range bd71847_ldo5_volts[] = {
+static const struct linear_range bd71847_ldo5_volts[] = {
 	REGULATOR_LINEAR_RANGE(1800000, 0x00, 0x0F, 100000),
 	REGULATOR_LINEAR_RANGE(800000, 0x00, 0x0F, 100000),
 };
@@ -299,7 +299,7 @@ static const unsigned int bd71847_ldo5_volt_range_sel[] = { 0x0, 0x20 };
  * LDO6
  * 0.9 to 1.8V (100mV step)
  */
-static const struct regulator_linear_range bd718xx_ldo6_volts[] = {
+static const struct linear_range bd718xx_ldo6_volts[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0x00, 0x09, 100000),
 };
 
@@ -307,7 +307,7 @@ static const struct regulator_linear_range bd718xx_ldo6_volts[] = {
  * LDO7
  * 1.8 to 3.3V (100mV step)
  */
-static const struct regulator_linear_range bd71837_ldo7_volts[] = {
+static const struct linear_range bd71837_ldo7_volts[] = {
 	REGULATOR_LINEAR_RANGE(1800000, 0x00, 0x0F, 100000),
 };
 
diff --git a/drivers/regulator/da903x.c b/drivers/regulator/da903x.c
index 5493c3a86426..770e694824ac 100644
--- a/drivers/regulator/da903x.c
+++ b/drivers/regulator/da903x.c
@@ -248,7 +248,7 @@ static int da9034_set_dvc_voltage_sel(struct regulator_dev *rdev,
 	return ret;
 }
 
-static const struct regulator_linear_range da9034_ldo12_ranges[] = {
+static const struct linear_range da9034_ldo12_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 50000),
 	REGULATOR_LINEAR_RANGE(2700000, 8, 15, 50000),
 };
diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index ca3dc3f3bb29..2c15df0484e5 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -403,7 +403,7 @@ EXPORT_SYMBOL_GPL(regulator_map_voltage_linear);
 int regulator_map_voltage_linear_range(struct regulator_dev *rdev,
 				       int min_uV, int max_uV)
 {
-	const struct regulator_linear_range *range;
+	const struct linear_range *range;
 	int ret = -EINVAL;
 	int voltage, i;
 
@@ -466,7 +466,7 @@ EXPORT_SYMBOL_GPL(regulator_map_voltage_linear_range);
 int regulator_map_voltage_pickable_linear_range(struct regulator_dev *rdev,
 						int min_uV, int max_uV)
 {
-	const struct regulator_linear_range *range;
+	const struct linear_range *range;
 	int ret = -EINVAL;
 	int voltage, i;
 	unsigned int selector = 0;
@@ -559,7 +559,7 @@ EXPORT_SYMBOL_GPL(regulator_list_voltage_linear);
 int regulator_list_voltage_pickable_linear_range(struct regulator_dev *rdev,
 						 unsigned int selector)
 {
-	const struct regulator_linear_range *range;
+	const struct linear_range *range;
 	int i;
 	unsigned int all_sels = 0;
 
@@ -602,7 +602,7 @@ EXPORT_SYMBOL_GPL(regulator_list_voltage_pickable_linear_range);
 int regulator_desc_list_voltage_linear_range(const struct regulator_desc *desc,
 					     unsigned int selector)
 {
-	const struct regulator_linear_range *range;
+	const struct linear_range *range;
 	int i;
 
 	if (!desc->n_linear_ranges) {
diff --git a/drivers/regulator/hi6421-regulator.c b/drivers/regulator/hi6421-regulator.c
index 5ac3d7c29725..66219d8dfc1a 100644
--- a/drivers/regulator/hi6421-regulator.c
+++ b/drivers/regulator/hi6421-regulator.c
@@ -87,7 +87,7 @@ static const unsigned int ldo_8_voltages[] = {
 };
 
 /* Ranges are sorted in ascending order. */
-static const struct regulator_linear_range ldo_audio_volt_range[] = {
+static const struct linear_range ldo_audio_volt_range[] = {
 	REGULATOR_LINEAR_RANGE(2800000, 0, 3, 50000),
 	REGULATOR_LINEAR_RANGE(3000000, 4, 7, 100000),
 };
@@ -195,7 +195,7 @@ static const struct regulator_ops hi6421_buck345_ops;
  * _id - LDO id name string
  * _match - of match name string
  * n_volt - number of votages available
- * volt_ranges - array of regulator_linear_range
+ * volt_ranges - array of linear_range
  * vstep - voltage increase in each linear step in uV
  * vreg - voltage select register
  * vmask - voltage select mask
diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index 9b05e03ba830..5ea3e4141684 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -36,7 +36,7 @@ static const struct regulator_ops lochnagar_micvdd_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 };
 
-static const struct regulator_linear_range lochnagar_micvdd_ranges[] = {
+static const struct linear_range lochnagar_micvdd_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1000000, 0,    0xC, 50000),
 	REGULATOR_LINEAR_RANGE(1700000, 0xD, 0x1F, 100000),
 };
@@ -97,7 +97,7 @@ static const struct regulator_ops lochnagar_vddcore_ops = {
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 };
 
-static const struct regulator_linear_range lochnagar_vddcore_ranges[] = {
+static const struct linear_range lochnagar_vddcore_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0x8, 0x41, 12500),
 };
 
diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
index b55de293ca7a..fe049b67e7d5 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -54,14 +54,14 @@ struct lp873x_regulator {
 
 static const struct lp873x_regulator regulators[];
 
-static const struct regulator_linear_range buck0_buck1_ranges[] = {
+static const struct linear_range buck0_buck1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, 0x0, 0x13, 0),
 	REGULATOR_LINEAR_RANGE(700000, 0x14, 0x17, 10000),
 	REGULATOR_LINEAR_RANGE(735000, 0x18, 0x9d, 5000),
 	REGULATOR_LINEAR_RANGE(1420000, 0x9e, 0xff, 20000),
 };
 
-static const struct regulator_linear_range ldo0_ldo1_ranges[] = {
+static const struct linear_range ldo0_ldo1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0x0, 0x19, 100000),
 };
 
diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index 4ae12ac1f4c6..5d525dacf959 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -46,7 +46,7 @@ struct lp87565_regulator {
 
 static const struct lp87565_regulator regulators[];
 
-static const struct regulator_linear_range buck0_1_2_3_ranges[] = {
+static const struct linear_range buck0_1_2_3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0xA, 0x17, 10000),
 	REGULATOR_LINEAR_RANGE(735000, 0x18, 0x9d, 5000),
 	REGULATOR_LINEAR_RANGE(1420000, 0x9e, 0xff, 20000),
diff --git a/drivers/regulator/lp8788-buck.c b/drivers/regulator/lp8788-buck.c
index 222502a29658..74b7b496b12d 100644
--- a/drivers/regulator/lp8788-buck.c
+++ b/drivers/regulator/lp8788-buck.c
@@ -92,7 +92,7 @@ struct lp8788_buck {
 };
 
 /* BUCK 1 ~ 4 voltage ranges */
-static const struct regulator_linear_range buck_volt_ranges[] = {
+static const struct linear_range buck_volt_ranges[] = {
 	REGULATOR_LINEAR_RANGE(500000, 0, 0, 0),
 	REGULATOR_LINEAR_RANGE(800000, 1, 25, 50000),
 };
diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index ac89a412f665..ca08f94a368d 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -49,7 +49,7 @@ static const unsigned int max77651_sbb1_volt_range_sel[] = {
 	0x0, 0x1, 0x2, 0x3
 };
 
-static const struct regulator_linear_range max77651_sbb1_volt_ranges[] = {
+static const struct linear_range max77651_sbb1_volt_ranges[] = {
 	/* range index 0 */
 	REGULATOR_LINEAR_RANGE(2400000, 0x00, 0x0f, 50000),
 	/* range index 1 */
diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index e5a02711cb46..6d0ad74935b3 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -391,11 +391,11 @@ static const struct of_device_id mcp16502_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mcp16502_ids);
 
-static const struct regulator_linear_range b1l12_ranges[] = {
+static const struct linear_range b1l12_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1200000, VDD_LOW_SEL, VDD_HIGH_SEL, 50000),
 };
 
-static const struct regulator_linear_range b234_ranges[] = {
+static const struct linear_range b234_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, VDD_LOW_SEL, VDD_HIGH_SEL, 25000),
 };
 
diff --git a/drivers/regulator/mt6323-regulator.c b/drivers/regulator/mt6323-regulator.c
index 893ea190788a..ff9016170db3 100644
--- a/drivers/regulator/mt6323-regulator.c
+++ b/drivers/regulator/mt6323-regulator.c
@@ -102,15 +102,15 @@ struct mt6323_regulator_info {
 	.modeset_mask = _modeset_mask,					\
 }
 
-static const struct regulator_linear_range buck_volt_range1[] = {
+static const struct linear_range buck_volt_range1[] = {
 	REGULATOR_LINEAR_RANGE(700000, 0, 0x7f, 6250),
 };
 
-static const struct regulator_linear_range buck_volt_range2[] = {
+static const struct linear_range buck_volt_range2[] = {
 	REGULATOR_LINEAR_RANGE(1400000, 0, 0x7f, 12500),
 };
 
-static const struct regulator_linear_range buck_volt_range3[] = {
+static const struct linear_range buck_volt_range3[] = {
 	REGULATOR_LINEAR_RANGE(500000, 0, 0x3f, 50000),
 };
 
diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index ba42682e06f3..13cb6ac9a892 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -137,19 +137,19 @@ struct mt6358_regulator_info {
 	.qi = BIT(15),							\
 }
 
-static const struct regulator_linear_range buck_volt_range1[] = {
+static const struct linear_range buck_volt_range1[] = {
 	REGULATOR_LINEAR_RANGE(500000, 0, 0x7f, 6250),
 };
 
-static const struct regulator_linear_range buck_volt_range2[] = {
+static const struct linear_range buck_volt_range2[] = {
 	REGULATOR_LINEAR_RANGE(500000, 0, 0x7f, 12500),
 };
 
-static const struct regulator_linear_range buck_volt_range3[] = {
+static const struct linear_range buck_volt_range3[] = {
 	REGULATOR_LINEAR_RANGE(500000, 0, 0x3f, 50000),
 };
 
-static const struct regulator_linear_range buck_volt_range4[] = {
+static const struct linear_range buck_volt_range4[] = {
 	REGULATOR_LINEAR_RANGE(1000000, 0, 0x7f, 12500),
 };
 
diff --git a/drivers/regulator/mt6380-regulator.c b/drivers/regulator/mt6380-regulator.c
index b6aed090b5e0..9efd8710a6f3 100644
--- a/drivers/regulator/mt6380-regulator.c
+++ b/drivers/regulator/mt6380-regulator.c
@@ -152,15 +152,15 @@ struct mt6380_regulator_info {
 	.modeset_mask = _modeset_mask,					\
 }
 
-static const struct regulator_linear_range buck_volt_range1[] = {
+static const struct linear_range buck_volt_range1[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 0xfe, 6250),
 };
 
-static const struct regulator_linear_range buck_volt_range2[] = {
+static const struct linear_range buck_volt_range2[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 0xfe, 6250),
 };
 
-static const struct regulator_linear_range buck_volt_range3[] = {
+static const struct linear_range buck_volt_range3[] = {
 	REGULATOR_LINEAR_RANGE(1200000, 0, 0x3c, 25000),
 };
 
diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index fd9ed864a0c1..269c2a6028e8 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -102,15 +102,15 @@ struct mt6397_regulator_info {
 	.qi = BIT(15),							\
 }
 
-static const struct regulator_linear_range buck_volt_range1[] = {
+static const struct linear_range buck_volt_range1[] = {
 	REGULATOR_LINEAR_RANGE(700000, 0, 0x7f, 6250),
 };
 
-static const struct regulator_linear_range buck_volt_range2[] = {
+static const struct linear_range buck_volt_range2[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0, 0x7f, 6250),
 };
 
-static const struct regulator_linear_range buck_volt_range3[] = {
+static const struct linear_range buck_volt_range3[] = {
 	REGULATOR_LINEAR_RANGE(1500000, 0, 0x1f, 20000),
 };
 
diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 31325912d311..337dd614695e 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -22,14 +22,14 @@
 #include <linux/of_platform.h>
 #include <linux/regulator/of_regulator.h>
 
-static const struct regulator_linear_range smps_low_ranges[] = {
+static const struct linear_range smps_low_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(500000, 0x1, 0x6, 0),
 	REGULATOR_LINEAR_RANGE(510000, 0x7, 0x79, 10000),
 	REGULATOR_LINEAR_RANGE(1650000, 0x7A, 0x7f, 0),
 };
 
-static const struct regulator_linear_range smps_high_ranges[] = {
+static const struct linear_range smps_high_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(1000000, 0x1, 0x6, 0),
 	REGULATOR_LINEAR_RANGE(1020000, 0x7, 0x79, 20000),
diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index c86ad40015ce..953c7fba8d9d 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -86,7 +86,7 @@ enum rpmh_regulator_type {
 struct rpmh_vreg_hw_data {
 	enum rpmh_regulator_type		regulator_type;
 	const struct regulator_ops		*ops;
-	const struct regulator_linear_range	voltage_range;
+	const struct linear_range	voltage_range;
 	int					n_voltages;
 	int					hpm_min_load_uA;
 	const int				*pmic_mode_map;
diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
index 7407cd5a1b74..c15cceeebe45 100644
--- a/drivers/regulator/qcom_rpm-regulator.c
+++ b/drivers/regulator/qcom_rpm-regulator.c
@@ -148,41 +148,41 @@ static const struct rpm_reg_parts rpm8960_ncp_parts = {
 /*
  * Physically available PMIC regulator voltage ranges
  */
-static const struct regulator_linear_range pldo_ranges[] = {
+static const struct linear_range pldo_ranges[] = {
 	REGULATOR_LINEAR_RANGE( 750000,   0,  59, 12500),
 	REGULATOR_LINEAR_RANGE(1500000,  60, 123, 25000),
 	REGULATOR_LINEAR_RANGE(3100000, 124, 160, 50000),
 };
 
-static const struct regulator_linear_range nldo_ranges[] = {
+static const struct linear_range nldo_ranges[] = {
 	REGULATOR_LINEAR_RANGE( 750000,   0,  63, 12500),
 };
 
-static const struct regulator_linear_range nldo1200_ranges[] = {
+static const struct linear_range nldo1200_ranges[] = {
 	REGULATOR_LINEAR_RANGE( 375000,   0,  59,  6250),
 	REGULATOR_LINEAR_RANGE( 750000,  60, 123, 12500),
 };
 
-static const struct regulator_linear_range smps_ranges[] = {
+static const struct linear_range smps_ranges[] = {
 	REGULATOR_LINEAR_RANGE( 375000,   0,  29, 12500),
 	REGULATOR_LINEAR_RANGE( 750000,  30,  89, 12500),
 	REGULATOR_LINEAR_RANGE(1500000,  90, 153, 25000),
 };
 
-static const struct regulator_linear_range ftsmps_ranges[] = {
+static const struct linear_range ftsmps_ranges[] = {
 	REGULATOR_LINEAR_RANGE( 350000,   0,   6, 50000),
 	REGULATOR_LINEAR_RANGE( 700000,   7,  63, 12500),
 	REGULATOR_LINEAR_RANGE(1500000,  64, 100, 50000),
 };
 
-static const struct regulator_linear_range smb208_ranges[] = {
+static const struct linear_range smb208_ranges[] = {
 	REGULATOR_LINEAR_RANGE( 375000,   0,  29, 12500),
 	REGULATOR_LINEAR_RANGE( 750000,  30,  89, 12500),
 	REGULATOR_LINEAR_RANGE(1500000,  90, 153, 25000),
 	REGULATOR_LINEAR_RANGE(3100000, 154, 234, 25000),
 };
 
-static const struct regulator_linear_range ncp_ranges[] = {
+static const struct linear_range ncp_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1500000,   0,  31, 50000),
 };
 
diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index fff8d5fdef6a..34b5c62265a9 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -199,7 +199,7 @@ static const struct regulator_ops rpm_bob_ops = {
 };
 
 static const struct regulator_desc pma8084_hfsmps = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(375000,  0,  95, 12500),
 		REGULATOR_LINEAR_RANGE(1550000, 96, 158, 25000),
 	},
@@ -209,7 +209,7 @@ static const struct regulator_desc pma8084_hfsmps = {
 };
 
 static const struct regulator_desc pma8084_ftsmps = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(350000,  0, 184, 5000),
 		REGULATOR_LINEAR_RANGE(1280000, 185, 261, 10000),
 	},
@@ -219,7 +219,7 @@ static const struct regulator_desc pma8084_ftsmps = {
 };
 
 static const struct regulator_desc pma8084_pldo = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE( 750000,  0,  63, 12500),
 		REGULATOR_LINEAR_RANGE(1550000, 64, 126, 25000),
 		REGULATOR_LINEAR_RANGE(3100000, 127, 163, 50000),
@@ -230,7 +230,7 @@ static const struct regulator_desc pma8084_pldo = {
 };
 
 static const struct regulator_desc pma8084_nldo = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(750000, 0, 63, 12500),
 	},
 	.n_linear_ranges = 1,
@@ -243,7 +243,7 @@ static const struct regulator_desc pma8084_switch = {
 };
 
 static const struct regulator_desc pm8x41_hfsmps = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE( 375000,  0,  95, 12500),
 		REGULATOR_LINEAR_RANGE(1575000, 96, 158, 25000),
 	},
@@ -253,7 +253,7 @@ static const struct regulator_desc pm8x41_hfsmps = {
 };
 
 static const struct regulator_desc pm8841_ftsmps = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(350000,  0, 184, 5000),
 		REGULATOR_LINEAR_RANGE(1280000, 185, 261, 10000),
 	},
@@ -263,7 +263,7 @@ static const struct regulator_desc pm8841_ftsmps = {
 };
 
 static const struct regulator_desc pm8941_boost = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(4000000, 0, 30, 50000),
 	},
 	.n_linear_ranges = 1,
@@ -272,7 +272,7 @@ static const struct regulator_desc pm8941_boost = {
 };
 
 static const struct regulator_desc pm8941_pldo = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE( 750000,  0,  63, 12500),
 		REGULATOR_LINEAR_RANGE(1550000, 64, 126, 25000),
 		REGULATOR_LINEAR_RANGE(3100000, 127, 163, 50000),
@@ -283,7 +283,7 @@ static const struct regulator_desc pm8941_pldo = {
 };
 
 static const struct regulator_desc pm8941_nldo = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(750000, 0, 63, 12500),
 	},
 	.n_linear_ranges = 1,
@@ -302,7 +302,7 @@ static const struct regulator_desc pm8941_switch = {
 };
 
 static const struct regulator_desc pm8916_pldo = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(750000, 0, 208, 12500),
 	},
 	.n_linear_ranges = 1,
@@ -311,7 +311,7 @@ static const struct regulator_desc pm8916_pldo = {
 };
 
 static const struct regulator_desc pm8916_nldo = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(375000, 0, 93, 12500),
 	},
 	.n_linear_ranges = 1,
@@ -320,7 +320,7 @@ static const struct regulator_desc pm8916_nldo = {
 };
 
 static const struct regulator_desc pm8916_buck_lvo_smps = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(375000, 0, 95, 12500),
 		REGULATOR_LINEAR_RANGE(750000, 96, 127, 25000),
 	},
@@ -330,7 +330,7 @@ static const struct regulator_desc pm8916_buck_lvo_smps = {
 };
 
 static const struct regulator_desc pm8916_buck_hvo_smps = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(1550000, 0, 31, 25000),
 	},
 	.n_linear_ranges = 1,
@@ -339,7 +339,7 @@ static const struct regulator_desc pm8916_buck_hvo_smps = {
 };
 
 static const struct regulator_desc pm8950_hfsmps = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(375000, 0, 95, 12500),
 		REGULATOR_LINEAR_RANGE(1550000, 96, 127, 25000),
 	},
@@ -349,7 +349,7 @@ static const struct regulator_desc pm8950_hfsmps = {
 };
 
 static const struct regulator_desc pm8950_ftsmps2p5 = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(80000, 0, 255, 5000),
 		REGULATOR_LINEAR_RANGE(160000, 256, 460, 10000),
 	},
@@ -359,7 +359,7 @@ static const struct regulator_desc pm8950_ftsmps2p5 = {
 };
 
 static const struct regulator_desc pm8950_ult_nldo = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(375000, 0, 202, 12500),
 	},
 	.n_linear_ranges = 1,
@@ -368,7 +368,7 @@ static const struct regulator_desc pm8950_ult_nldo = {
 };
 
 static const struct regulator_desc pm8950_ult_pldo = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(1750000, 0, 127, 12500),
 	},
 	.n_linear_ranges = 1,
@@ -377,7 +377,7 @@ static const struct regulator_desc pm8950_ult_pldo = {
 };
 
 static const struct regulator_desc pm8950_pldo_lv = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(1500000, 0, 16, 25000),
 	},
 	.n_linear_ranges = 1,
@@ -386,7 +386,7 @@ static const struct regulator_desc pm8950_pldo_lv = {
 };
 
 static const struct regulator_desc pm8950_pldo = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(975000, 0, 164, 12500),
 	},
 	.n_linear_ranges = 1,
@@ -396,7 +396,7 @@ static const struct regulator_desc pm8950_pldo = {
 
 
 static const struct regulator_desc pm8994_hfsmps = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE( 375000,  0,  95, 12500),
 		REGULATOR_LINEAR_RANGE(1550000, 96, 158, 25000),
 	},
@@ -406,7 +406,7 @@ static const struct regulator_desc pm8994_hfsmps = {
 };
 
 static const struct regulator_desc pm8994_ftsmps = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(350000,  0, 199, 5000),
 		REGULATOR_LINEAR_RANGE(700000, 200, 349, 10000),
 	},
@@ -416,7 +416,7 @@ static const struct regulator_desc pm8994_ftsmps = {
 };
 
 static const struct regulator_desc pm8994_nldo = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(750000, 0, 63, 12500),
 	},
 	.n_linear_ranges = 1,
@@ -425,7 +425,7 @@ static const struct regulator_desc pm8994_nldo = {
 };
 
 static const struct regulator_desc pm8994_pldo = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE( 750000,  0,  63, 12500),
 		REGULATOR_LINEAR_RANGE(1550000, 64, 126, 25000),
 		REGULATOR_LINEAR_RANGE(3100000, 127, 163, 50000),
@@ -446,7 +446,7 @@ static const struct regulator_desc pm8994_lnldo = {
 };
 
 static const struct regulator_desc pm8998_ftsmps = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(320000, 0, 258, 4000),
 	},
 	.n_linear_ranges = 1,
@@ -455,7 +455,7 @@ static const struct regulator_desc pm8998_ftsmps = {
 };
 
 static const struct regulator_desc pm8998_hfsmps = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
 	},
 	.n_linear_ranges = 1,
@@ -464,7 +464,7 @@ static const struct regulator_desc pm8998_hfsmps = {
 };
 
 static const struct regulator_desc pm8998_nldo = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
 	},
 	.n_linear_ranges = 1,
@@ -473,7 +473,7 @@ static const struct regulator_desc pm8998_nldo = {
 };
 
 static const struct regulator_desc pm8998_pldo = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(1664000, 0, 255, 8000),
 	},
 	.n_linear_ranges = 1,
@@ -482,7 +482,7 @@ static const struct regulator_desc pm8998_pldo = {
 };
 
 static const struct regulator_desc pm8998_pldo_lv = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(1256000, 0, 127, 8000),
 	},
 	.n_linear_ranges = 1,
@@ -495,7 +495,7 @@ static const struct regulator_desc pm8998_switch = {
 };
 
 static const struct regulator_desc pmi8998_bob = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(1824000, 0, 83, 32000),
 	},
 	.n_linear_ranges = 1,
@@ -504,7 +504,7 @@ static const struct regulator_desc pmi8998_bob = {
 };
 
 static const struct regulator_desc pms405_hfsmps3 = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
 	},
 	.n_linear_ranges = 1,
@@ -513,7 +513,7 @@ static const struct regulator_desc pms405_hfsmps3 = {
 };
 
 static const struct regulator_desc pms405_nldo300 = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
 	},
 	.n_linear_ranges = 1,
@@ -522,7 +522,7 @@ static const struct regulator_desc pms405_nldo300 = {
 };
 
 static const struct regulator_desc pms405_nldo1200 = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(312000, 0, 127, 8000),
 	},
 	.n_linear_ranges = 1,
@@ -531,7 +531,7 @@ static const struct regulator_desc pms405_nldo1200 = {
 };
 
 static const struct regulator_desc pms405_pldo50 = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(1664000, 0, 128, 16000),
 	},
 	.n_linear_ranges = 1,
@@ -540,7 +540,7 @@ static const struct regulator_desc pms405_pldo50 = {
 };
 
 static const struct regulator_desc pms405_pldo150 = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(1664000, 0, 128, 16000),
 	},
 	.n_linear_ranges = 1,
@@ -549,7 +549,7 @@ static const struct regulator_desc pms405_pldo150 = {
 };
 
 static const struct regulator_desc pms405_pldo600 = {
-	.linear_ranges = (struct regulator_linear_range[]) {
+	.linear_ranges = (struct linear_range[]) {
 		REGULATOR_LINEAR_RANGE(1256000, 0, 98, 8000),
 	},
 	.n_linear_ranges = 1,
diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 5b4003226484..b7a4cdbfd4c4 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -165,14 +165,14 @@ static const int rk808_buck_config_regs[] = {
 	RK808_BUCK4_CONFIG_REG,
 };
 
-static const struct regulator_linear_range rk808_ldo3_voltage_ranges[] = {
+static const struct linear_range rk808_ldo3_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0, 13, 100000),
 	REGULATOR_LINEAR_RANGE(2500000, 15, 15, 0),
 };
 
 #define RK809_BUCK5_SEL_CNT		(8)
 
-static const struct regulator_linear_range rk809_buck5_voltage_ranges[] = {
+static const struct linear_range rk809_buck5_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1500000, 0, 0, 0),
 	REGULATOR_LINEAR_RANGE(1800000, 1, 3, 200000),
 	REGULATOR_LINEAR_RANGE(2800000, 4, 5, 200000),
@@ -201,14 +201,14 @@ static const struct regulator_linear_range rk809_buck5_voltage_ranges[] = {
 #define RK817_BUCK1_SEL_CNT (RK817_BUCK1_SEL0 + RK817_BUCK1_SEL1 + 1)
 #define RK817_BUCK3_SEL_CNT (RK817_BUCK1_SEL0 + RK817_BUCK3_SEL1 + 1)
 
-static const struct regulator_linear_range rk817_buck1_voltage_ranges[] = {
+static const struct linear_range rk817_buck1_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(RK817_BUCK1_MIN0, 0,
 			       RK817_BUCK1_SEL0, RK817_BUCK1_STP0),
 	REGULATOR_LINEAR_RANGE(RK817_BUCK1_MIN1, RK817_BUCK1_SEL0 + 1,
 			       RK817_BUCK1_SEL_CNT, RK817_BUCK1_STP1),
 };
 
-static const struct regulator_linear_range rk817_buck3_voltage_ranges[] = {
+static const struct linear_range rk817_buck3_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(RK817_BUCK1_MIN0, 0,
 			       RK817_BUCK1_SEL0, RK817_BUCK1_STP0),
 	REGULATOR_LINEAR_RANGE(RK817_BUCK1_MIN1, RK817_BUCK1_SEL0 + 1,
@@ -665,7 +665,7 @@ static const struct regulator_ops rk808_switch_ops = {
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
-static const struct regulator_linear_range rk805_buck_1_2_voltage_ranges[] = {
+static const struct linear_range rk805_buck_1_2_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(712500, 0, 59, 12500),
 	REGULATOR_LINEAR_RANGE(1800000, 60, 62, 200000),
 	REGULATOR_LINEAR_RANGE(2300000, 63, 63, 0),
diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index 4f2dc5ebffdc..44511c62edea 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -749,37 +749,37 @@ static const struct regulator_ops s2mps15_reg_buck_ops = {
 }
 
 /* voltage range for s2mps15 LDO 3, 5, 15, 16, 18, 20, 23 and 27 */
-static const struct regulator_linear_range s2mps15_ldo_voltage_ranges1[] = {
+static const struct linear_range s2mps15_ldo_voltage_ranges1[] = {
 	REGULATOR_LINEAR_RANGE(1000000, 0xc, 0x38, 25000),
 };
 
 /* voltage range for s2mps15 LDO 2, 6, 14, 17, 19, 21, 24 and 25 */
-static const struct regulator_linear_range s2mps15_ldo_voltage_ranges2[] = {
+static const struct linear_range s2mps15_ldo_voltage_ranges2[] = {
 	REGULATOR_LINEAR_RANGE(1800000, 0x0, 0x3f, 25000),
 };
 
 /* voltage range for s2mps15 LDO 4, 11, 12, 13, 22 and 26 */
-static const struct regulator_linear_range s2mps15_ldo_voltage_ranges3[] = {
+static const struct linear_range s2mps15_ldo_voltage_ranges3[] = {
 	REGULATOR_LINEAR_RANGE(700000, 0x0, 0x34, 12500),
 };
 
 /* voltage range for s2mps15 LDO 7, 8, 9 and 10 */
-static const struct regulator_linear_range s2mps15_ldo_voltage_ranges4[] = {
+static const struct linear_range s2mps15_ldo_voltage_ranges4[] = {
 	REGULATOR_LINEAR_RANGE(700000, 0x10, 0x20, 25000),
 };
 
 /* voltage range for s2mps15 LDO 1 */
-static const struct regulator_linear_range s2mps15_ldo_voltage_ranges5[] = {
+static const struct linear_range s2mps15_ldo_voltage_ranges5[] = {
 	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x20, 12500),
 };
 
 /* voltage range for s2mps15 BUCK 1, 2, 3, 4, 5, 6 and 7 */
-static const struct regulator_linear_range s2mps15_buck_voltage_ranges1[] = {
+static const struct linear_range s2mps15_buck_voltage_ranges1[] = {
 	REGULATOR_LINEAR_RANGE(500000, 0x20, 0xc0, 6250),
 };
 
 /* voltage range for s2mps15 BUCK 8, 9 and 10 */
-static const struct regulator_linear_range s2mps15_buck_voltage_ranges2[] = {
+static const struct linear_range s2mps15_buck_voltage_ranges2[] = {
 	REGULATOR_LINEAR_RANGE(1000000, 0x20, 0x78, 12500),
 };
 
diff --git a/drivers/regulator/sky81452-regulator.c b/drivers/regulator/sky81452-regulator.c
index 177dede82a61..37658affe072 100644
--- a/drivers/regulator/sky81452-regulator.c
+++ b/drivers/regulator/sky81452-regulator.c
@@ -32,7 +32,7 @@ static const struct regulator_ops sky81452_reg_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 };
 
-static const struct regulator_linear_range sky81452_reg_ranges[] = {
+static const struct linear_range sky81452_reg_ranges[] = {
 	REGULATOR_LINEAR_RANGE(4500000, 0, 14, 250000),
 	REGULATOR_LINEAR_RANGE(9000000, 15, 31, 1000000),
 };
diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index f3d7d007ecbb..adc9973d1b2f 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -57,13 +57,13 @@ enum {
 /* Ramp delay worst case is (2250uV/uS) */
 #define PMIC_RAMP_DELAY 2200
 
-static const struct regulator_linear_range buck1_ranges[] = {
+static const struct linear_range buck1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(725000, 0, 4, 0),
 	REGULATOR_LINEAR_RANGE(725000, 5, 36, 25000),
 	REGULATOR_LINEAR_RANGE(1500000, 37, 63, 0),
 };
 
-static const struct regulator_linear_range buck2_ranges[] = {
+static const struct linear_range buck2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1000000, 0, 17, 0),
 	REGULATOR_LINEAR_RANGE(1050000, 18, 19, 0),
 	REGULATOR_LINEAR_RANGE(1100000, 20, 21, 0),
@@ -77,7 +77,7 @@ static const struct regulator_linear_range buck2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1500000, 36, 63, 0),
 };
 
-static const struct regulator_linear_range buck3_ranges[] = {
+static const struct linear_range buck3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1000000, 0, 19, 0),
 	REGULATOR_LINEAR_RANGE(1100000, 20, 23, 0),
 	REGULATOR_LINEAR_RANGE(1200000, 24, 27, 0),
@@ -87,7 +87,7 @@ static const struct regulator_linear_range buck3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(3400000, 56, 63, 0),
 };
 
-static const struct regulator_linear_range buck4_ranges[] = {
+static const struct linear_range buck4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 27, 25000),
 	REGULATOR_LINEAR_RANGE(1300000, 28, 29, 0),
 	REGULATOR_LINEAR_RANGE(1350000, 30, 31, 0),
@@ -97,19 +97,19 @@ static const struct regulator_linear_range buck4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(3900000, 61, 63, 0),
 };
 
-static const struct regulator_linear_range ldo1_ranges[] = {
+static const struct linear_range ldo1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
 	REGULATOR_LINEAR_RANGE(1700000, 8, 24, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 25, 31, 0),
 };
 
-static const struct regulator_linear_range ldo2_ranges[] = {
+static const struct linear_range ldo2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
 	REGULATOR_LINEAR_RANGE(1700000, 8, 24, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 25, 30, 0),
 };
 
-static const struct regulator_linear_range ldo3_ranges[] = {
+static const struct linear_range ldo3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
 	REGULATOR_LINEAR_RANGE(1700000, 8, 24, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 25, 30, 0),
@@ -117,13 +117,13 @@ static const struct regulator_linear_range ldo3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(500000, 31, 31, 0),
 };
 
-static const struct regulator_linear_range ldo5_ranges[] = {
+static const struct linear_range ldo5_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
 	REGULATOR_LINEAR_RANGE(1700000, 8, 30, 100000),
 	REGULATOR_LINEAR_RANGE(3900000, 31, 31, 0),
 };
 
-static const struct regulator_linear_range ldo6_ranges[] = {
+static const struct linear_range ldo6_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0, 24, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 25, 31, 0),
 };
diff --git a/drivers/regulator/tps65086-regulator.c b/drivers/regulator/tps65086-regulator.c
index 5a5e9b5bf4be..9910e949373c 100644
--- a/drivers/regulator/tps65086-regulator.c
+++ b/drivers/regulator/tps65086-regulator.c
@@ -71,23 +71,23 @@ struct tps65086_regulator {
 	unsigned int decay_mask;
 };
 
-static const struct regulator_linear_range tps65086_10mv_ranges[] = {
+static const struct linear_range tps65086_10mv_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(410000, 0x1, 0x7F, 10000),
 };
 
-static const struct regulator_linear_range tps65086_buck126_25mv_ranges[] = {
+static const struct linear_range tps65086_buck126_25mv_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(1000000, 0x1, 0x18, 0),
 	REGULATOR_LINEAR_RANGE(1025000, 0x19, 0x7F, 25000),
 };
 
-static const struct regulator_linear_range tps65086_buck345_25mv_ranges[] = {
+static const struct linear_range tps65086_buck345_25mv_ranges[] = {
 	REGULATOR_LINEAR_RANGE(0, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(425000, 0x1, 0x7F, 25000),
 };
 
-static const struct regulator_linear_range tps65086_ldoa1_ranges[] = {
+static const struct linear_range tps65086_ldoa1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1350000, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(1500000, 0x1, 0x7, 100000),
 	REGULATOR_LINEAR_RANGE(2300000, 0x8, 0xB, 100000),
@@ -95,7 +95,7 @@ static const struct regulator_linear_range tps65086_ldoa1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(3300000, 0xE, 0xE, 0),
 };
 
-static const struct regulator_linear_range tps65086_ldoa23_ranges[] = {
+static const struct linear_range tps65086_ldoa23_ranges[] = {
 	REGULATOR_LINEAR_RANGE(700000, 0x0, 0xD, 50000),
 	REGULATOR_LINEAR_RANGE(1400000, 0xE, 0xF, 100000),
 };
diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index 67ba78da77ec..d27dbbafcf72 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -56,14 +56,14 @@ static const unsigned int LDO1_VSEL_table[] = {
 	2800000, 3000000, 3100000, 3300000,
 };
 
-static const struct regulator_linear_range tps65217_uv1_ranges[] = {
+static const struct linear_range tps65217_uv1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0, 24, 25000),
 	REGULATOR_LINEAR_RANGE(1550000, 25, 52, 50000),
 	REGULATOR_LINEAR_RANGE(3000000, 53, 55, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 56, 63, 0),
 };
 
-static const struct regulator_linear_range tps65217_uv2_ranges[] = {
+static const struct linear_range tps65217_uv2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1500000, 0, 8, 50000),
 	REGULATOR_LINEAR_RANGE(2000000, 9, 13, 100000),
 	REGULATOR_LINEAR_RANGE(2450000, 14, 31, 50000),
diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index b72035610013..05d13f807918 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -56,17 +56,17 @@
 		.bypass_mask	= _sm,				\
 	}							\
 
-static const struct regulator_linear_range dcdc1_dcdc2_ranges[] = {
+static const struct linear_range dcdc1_dcdc2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(850000, 0x0, 0x32, 10000),
 	REGULATOR_LINEAR_RANGE(1375000, 0x33, 0x3f, 25000),
 };
 
-static const struct regulator_linear_range ldo1_dcdc3_ranges[] = {
+static const struct linear_range ldo1_dcdc3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0x0, 0x1a, 25000),
 	REGULATOR_LINEAR_RANGE(1600000, 0x1b, 0x3f, 50000),
 };
 
-static const struct regulator_linear_range dcdc4_ranges[] = {
+static const struct linear_range dcdc4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1175000, 0x0, 0xf, 25000),
 	REGULATOR_LINEAR_RANGE(1600000, 0x10, 0x34, 50000),
 };
diff --git a/drivers/regulator/tps65912-regulator.c b/drivers/regulator/tps65912-regulator.c
index 276faeddc370..15c79931ea89 100644
--- a/drivers/regulator/tps65912-regulator.c
+++ b/drivers/regulator/tps65912-regulator.c
@@ -46,11 +46,11 @@ enum tps65912_regulators { DCDC1, DCDC2, DCDC3, DCDC4, LDO1, LDO2, LDO3,
 		.n_linear_ranges	= ARRAY_SIZE(_lr),		\
 	}
 
-static const struct regulator_linear_range tps65912_dcdc_ranges[] = {
+static const struct linear_range tps65912_dcdc_ranges[] = {
 	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x3f, 50000),
 };
 
-static const struct regulator_linear_range tps65912_ldo_ranges[] = {
+static const struct linear_range tps65912_ldo_ranges[] = {
 	REGULATOR_LINEAR_RANGE(800000, 0x0, 0x20, 25000),
 	REGULATOR_LINEAR_RANGE(1650000, 0x21, 0x3c, 50000),
 	REGULATOR_LINEAR_RANGE(3100000, 0x3d, 0x3f, 100000),
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index 866b4dd01da9..4a51cfea45ac 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -360,12 +360,12 @@ static const u16 VINTANA2_VSEL_table[] = {
 };
 
 /* 600mV to 1450mV in 12.5 mV steps */
-static const struct regulator_linear_range VDD1_ranges[] = {
+static const struct linear_range VDD1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 68, 12500)
 };
 
 /* 600mV to 1450mV in 12.5 mV steps, everything above = 1500mV */
-static const struct regulator_linear_range VDD2_ranges[] = {
+static const struct linear_range VDD2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 68, 12500),
 	REGULATOR_LINEAR_RANGE(1500000, 69, 69, 12500)
 };
diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index b8100c3cedad..f7db250a7583 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -495,7 +495,7 @@ static const struct regulator_ops twlsmps_ops = {
 };
 
 /*----------------------------------------------------------------------*/
-static const struct regulator_linear_range twl6030ldo_linear_range[] = {
+static const struct linear_range twl6030ldo_linear_range[] = {
 	REGULATOR_LINEAR_RANGE(0, 0, 0, 0),
 	REGULATOR_LINEAR_RANGE(1000000, 1, 24, 100000),
 	REGULATOR_LINEAR_RANGE(2750000, 31, 31, 0),
diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index 018dbbd96771..ad2203d11a88 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -204,7 +204,7 @@ static irqreturn_t wm831x_dcdc_oc_irq(int irq, void *data)
  * BUCKV specifics
  */
 
-static const struct regulator_linear_range wm831x_buckv_ranges[] = {
+static const struct linear_range wm831x_buckv_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 0x7, 0),
 	REGULATOR_LINEAR_RANGE(600000, 0x8, 0x68, 12500),
 };
diff --git a/drivers/regulator/wm831x-ldo.c b/drivers/regulator/wm831x-ldo.c
index 56754686c982..7b6cf4810cb7 100644
--- a/drivers/regulator/wm831x-ldo.c
+++ b/drivers/regulator/wm831x-ldo.c
@@ -59,7 +59,7 @@ static irqreturn_t wm831x_ldo_uv_irq(int irq, void *data)
  * General purpose LDOs
  */
 
-static const struct regulator_linear_range wm831x_gp_ldo_ranges[] = {
+static const struct linear_range wm831x_gp_ldo_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0, 14, 50000),
 	REGULATOR_LINEAR_RANGE(1700000, 15, 31, 100000),
 };
@@ -312,7 +312,7 @@ static struct platform_driver wm831x_gp_ldo_driver = {
  * Analogue LDOs
  */
 
-static const struct regulator_linear_range wm831x_aldo_ranges[] = {
+static const struct linear_range wm831x_aldo_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1000000, 0, 12, 50000),
 	REGULATOR_LINEAR_RANGE(1700000, 13, 31, 100000),
 };
diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index 56d6168a888d..ae5f0e7fce8b 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -470,7 +470,7 @@ static int wm8350_dcdc_set_suspend_mode(struct regulator_dev *rdev,
 	return 0;
 }
 
-static const struct regulator_linear_range wm8350_ldo_ranges[] = {
+static const struct linear_range wm8350_ldo_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0, 15, 50000),
 	REGULATOR_LINEAR_RANGE(1800000, 16, 31, 100000),
 };
diff --git a/drivers/regulator/wm8400-regulator.c b/drivers/regulator/wm8400-regulator.c
index 6f331b51e479..4cb1fbb59722 100644
--- a/drivers/regulator/wm8400-regulator.c
+++ b/drivers/regulator/wm8400-regulator.c
@@ -13,7 +13,7 @@
 #include <linux/regulator/driver.h>
 #include <linux/mfd/wm8400-private.h>
 
-static const struct regulator_linear_range wm8400_ldo_ranges[] = {
+static const struct linear_range wm8400_ldo_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0, 14, 50000),
 	REGULATOR_LINEAR_RANGE(1700000, 15, 31, 100000),
 };
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 9a911bb5fb61..8419a4321775 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -40,7 +40,7 @@ enum regulator_status {
 };
 
 /**
- * struct regulator_linear_range - specify linear voltage ranges
+ * struct linear_range - specify linear voltage ranges
  *
  * Specify a range of voltages for regulator_map_linear_range() and
  * regulator_list_linear_range().
@@ -50,14 +50,14 @@ enum regulator_status {
  * @max_sel: Highest selector for range
  * @uV_step: Step size
  */
-struct regulator_linear_range {
+struct linear_range {
 	unsigned int min_uV;
 	unsigned int min_sel;
 	unsigned int max_sel;
 	unsigned int uV_step;
 };
 
-/* Initialize struct regulator_linear_range */
+/* Initialize struct linear_range */
 #define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
 {									\
 	.min_uV		= _min_uV,					\
@@ -348,7 +348,7 @@ struct regulator_desc {
 	unsigned int ramp_delay;
 	int min_dropout_uV;
 
-	const struct regulator_linear_range *linear_ranges;
+	const struct linear_range *linear_ranges;
 	const unsigned int *linear_range_selectors;
 
 	int n_linear_ranges;
-- 
2.21.0


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
