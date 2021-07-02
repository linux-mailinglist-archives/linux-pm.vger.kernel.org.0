Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE18A3B9AE2
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jul 2021 05:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhGBDPJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jul 2021 23:15:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43170 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234874AbhGBDPH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 23:15:07 -0400
X-UUID: 9a7f91168abd46998cb87dc45ccded36-20210702
X-UUID: 9a7f91168abd46998cb87dc45ccded36-20210702
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 844862738; Fri, 02 Jul 2021 11:12:19 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 2 Jul 2021 11:12:16 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 2 Jul 2021 11:12:16 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v19 7/7] soc: mediatek: SVS: add mt8192 SVS GPU driver
Date:   Fri, 2 Jul 2021 11:12:14 +0800
Message-ID: <20210702031214.21597-8-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210702031214.21597-1-roger.lu@mediatek.com>
References: <20210702031214.21597-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
Reviewed-by: YT Lee <yt.lee@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 487 ++++++++++++++++++++++++++++++++-
 1 file changed, 481 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index e0c56273c688..5f308105624f 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -36,6 +36,10 @@
 #define SVSB_CCI			BIT(2)
 #define SVSB_GPU			BIT(3)
 
+/* svs bank 2-line type */
+#define SVSB_LOW			BIT(4)
+#define SVSB_HIGH			BIT(5)
+
 /* svs bank mode support */
 #define SVSB_MODE_ALL_DISABLE		0
 #define SVSB_MODE_INIT01		BIT(1)
@@ -323,6 +327,7 @@ struct svs_platform {
  * @volts: bank voltages
  * @reg_data: bank register data of each phase
  * @freq_base: reference frequency for bank init
+ * @turn_freq_base: refenrece frequency for turn point
  * @vboot: voltage request for bank init01 stage only
  * @volt_step: bank voltage step
  * @volt_base: bank voltage base
@@ -343,6 +348,8 @@ struct svs_platform {
  * @hw_id: bank hardware identification
  * @ctl0: bank thermal sensor selection
  * @cpu_id: cpu core id for SVS CPU only
+ * @turn_pt: turn point informs which opp_volt calculated by high/low bank.
+ * @type: bank type to represent it is 2-line (high/low) bank or 1-line bank.
  *
  * Other structure members which are not listed above are svs platform
  * efuse data for bank init
@@ -371,6 +378,7 @@ struct svs_bank {
 	u32 volts[16];
 	u32 reg_data[SVSB_PHASE_NUM][SVS_REG_NUM];
 	u32 freq_base;
+	u32 turn_freq_base;
 	u32 vboot;
 	u32 volt_step;
 	u32 volt_base;
@@ -410,6 +418,8 @@ struct svs_bank {
 	u32 hw_id;
 	u32 ctl0;
 	u32 cpu_id;
+	u32 turn_pt;
+	u32 type;
 };
 
 static u32 percent(u32 numerator, u32 denominator)
@@ -445,6 +455,37 @@ static u32 svs_bank_volt_to_opp_volt(u32 svsb_volt, u32 svsb_volt_step,
 	return (svsb_volt * svsb_volt_step) + svsb_volt_base;
 }
 
+static u32 svs_opp_volt_to_bank_volt(u32 opp_u_volt, u32 svsb_volt_step,
+				     u32 svsb_volt_base)
+{
+	return (opp_u_volt - svsb_volt_base) / svsb_volt_step;
+}
+
+static int svs_sync_bank_volts_from_opp(struct svs_bank *svsb)
+{
+	struct dev_pm_opp *opp;
+	u32 i, opp_u_volt;
+
+	for (i = 0; i < svsb->opp_count; i++) {
+		opp = dev_pm_opp_find_freq_exact(svsb->opp_dev,
+						 svsb->opp_freqs[i],
+						 true);
+		if (IS_ERR(opp)) {
+			dev_err(svsb->dev, "cannot find freq = %u (%ld)\n",
+				svsb->opp_freqs[i], PTR_ERR(opp));
+			return PTR_ERR(opp);
+		}
+
+		opp_u_volt = dev_pm_opp_get_voltage(opp);
+		svsb->volts[i] = svs_opp_volt_to_bank_volt(opp_u_volt,
+							   svsb->volt_step,
+							   svsb->volt_base);
+		dev_pm_opp_put(opp);
+	}
+
+	return 0;
+}
+
 static int svs_get_bank_zone_temperature(const char *tzone_name,
 					 int *tzone_temp)
 {
@@ -460,7 +501,7 @@ static int svs_get_bank_zone_temperature(const char *tzone_name,
 static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool force_update)
 {
 	int tzone_temp = 0, ret = -EPERM;
-	u32 i, svsb_volt, opp_volt, temp_offset = 0;
+	u32 i, svsb_volt, opp_volt, temp_offset = 0, opp_start, opp_stop;
 
 	mutex_lock(&svsb->lock);
 
@@ -474,6 +515,21 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool force_update)
 		goto unlock_mutex;
 	}
 
+	/*
+	 * 2-line bank updates its corresponding opp volts.
+	 * 1-line bank updates all opp volts.
+	 */
+	if (svsb->type == SVSB_HIGH) {
+		opp_start = 0;
+		opp_stop = svsb->turn_pt;
+	} else if (svsb->type == SVSB_LOW) {
+		opp_start = svsb->turn_pt;
+		opp_stop = svsb->opp_count;
+	} else {
+		opp_start = 0;
+		opp_stop = svsb->opp_count;
+	}
+
 	/* Get thermal effect */
 	if (svsb->phase == SVSB_PHASE_MON) {
 		if (svsb->temp > svsb->temp_upper_bound &&
@@ -495,10 +551,16 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb, bool force_update)
 			temp_offset += svsb->tzone_high_temp_offset;
 		else if (tzone_temp <= svsb->tzone_low_temp)
 			temp_offset += svsb->tzone_low_temp_offset;
+
+		/* 2-line bank takes thermal factor to update all opp volts */
+		if (svsb->type == SVSB_HIGH || svsb->type == SVSB_LOW) {
+			opp_start = 0;
+			opp_stop = svsb->opp_count;
+		}
 	}
 
 	/* vmin <= svsb_volt (opp_volt) <= signed-off (default) voltage */
-	for (i = 0; i < svsb->opp_count; i++) {
+	for (i = opp_start; i < opp_stop; i++) {
 		if (svsb->phase == SVSB_PHASE_MON) {
 			svsb_volt = max(svsb->volts[i] + svsb->volt_offset +
 					temp_offset, svsb->vmin);
@@ -549,6 +611,187 @@ static u32 interpolate(u32 f0, u32 f1, u32 v0, u32 v1, u32 fx)
 	return DIV_ROUND_UP(vx, 100);
 }
 
+static void svs_get_vops_v3(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb = svsp->pbank;
+	u32 i, vop_i, *vop, vop74, vop30, mask7_0 = GENMASK(7, 0);
+	u32 b_sft, bits8 = 8, shift_byte = 0, reg_4bytes = 4;
+	u32 middle_index = (svsb->opp_count / 2);
+	u32 opp_start = 0, opp_stop = 0, turn_pt = svsb->turn_pt;
+
+	if (svsb->phase == SVSB_PHASE_MON &&
+	    svsb->volt_flags & SVSB_MON_VOLT_IGNORE)
+		return;
+
+	vop74 = svs_readl(svsp, VOP74);
+	vop30 = svs_readl(svsp, VOP30);
+
+	if (turn_pt < middle_index) {
+		if (svsb->type == SVSB_HIGH) {
+			/* We attain volts[0 ~ (turn_pt - 1)] */
+			for (i = 0; i < turn_pt; i++) {
+				b_sft = bits8 * (shift_byte % reg_4bytes);
+				vop = (shift_byte < reg_4bytes) ? &vop30 :
+								  &vop74;
+				svsb->volts[i] = (*vop >> b_sft) & mask7_0;
+				shift_byte++;
+			}
+		} else if (svsb->type == SVSB_LOW) {
+			/*
+			 * We attain volts[turn_pt] +
+			 * volts[vop_i ~ (opp_count - 1)]
+			 */
+			vop_i = svsb->opp_count - 7;
+			svsb->volts[turn_pt] = vop30 & mask7_0;
+			shift_byte++;
+			for (i = vop_i; i < svsb->opp_count; i++) {
+				b_sft = bits8 * (shift_byte % reg_4bytes);
+				vop = (shift_byte < reg_4bytes) ? &vop30 :
+								  &vop74;
+				svsb->volts[i] = (*vop >> b_sft) & mask7_0;
+				shift_byte++;
+			}
+
+			/*
+			 * We attain volts[turn_pt + 1 ~ (vop_i - 1)]
+			 * by interpolate
+			 */
+			for (i = turn_pt + 1; i < vop_i; i++)
+				svsb->volts[i] =
+					interpolate(svsb->freqs_pct[turn_pt],
+						    svsb->freqs_pct[vop_i],
+						    svsb->volts[turn_pt],
+						    svsb->volts[vop_i],
+						    svsb->freqs_pct[i]);
+		}
+	} else {
+		if (svsb->type == SVSB_HIGH) {
+			/* We attain volts[0] + volts[vop_i ~ (turn_pt - 1)] */
+			vop_i = turn_pt - 7;
+			svsb->volts[0] = vop30 & mask7_0;
+			shift_byte++;
+			for (i = vop_i; i < turn_pt; i++) {
+				b_sft = bits8 * (shift_byte % reg_4bytes);
+				vop = (shift_byte < reg_4bytes) ? &vop30 :
+								  &vop74;
+				svsb->volts[i] = (*vop >> b_sft) & mask7_0;
+				shift_byte++;
+			}
+
+			/* We attain volts[1 ~ (vop_i - 1)] by interpolate */
+			for (i = 1; i < vop_i; i++)
+				svsb->volts[i] =
+					interpolate(svsb->freqs_pct[0],
+						    svsb->freqs_pct[vop_i],
+						    svsb->volts[0],
+						    svsb->volts[vop_i],
+						    svsb->freqs_pct[i]);
+		} else if (svsb->type == SVSB_LOW) {
+			/* We attain volts[turn_pt ~ (opp_count - 1)] */
+			for (i = turn_pt; i < svsb->opp_count; i++) {
+				b_sft = bits8 * (shift_byte % reg_4bytes);
+				vop = (shift_byte < reg_4bytes) ? &vop30 :
+								  &vop74;
+				svsb->volts[i] = (*vop >> b_sft) & mask7_0;
+				shift_byte++;
+			}
+		}
+	}
+
+	if (svsb->volt_flags & SVSB_INIT02_RM_DVTFIXED) {
+		if (svsb->type == SVSB_HIGH) {
+			opp_start = 0;
+			opp_stop = svsb->turn_pt;
+		} else if (svsb->type == SVSB_LOW) {
+			opp_start = svsb->turn_pt;
+			opp_stop = svsb->opp_count;
+		}
+
+		for (i = opp_start; i < opp_stop; i++)
+			svsb->volts[i] -= svsb->dvt_fixed;
+	}
+}
+
+static void svs_set_freqs_pct_v3(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb = svsp->pbank;
+	u32 i, freq_i, *freq_pct, freq_pct74 = 0, freq_pct30 = 0;
+	u32 b_sft, bits8 = 8, shift_byte = 0, reg_4bytes = 4;
+	u32 middle_index = (svsb->opp_count / 2);
+	u32 turn_pt = middle_index;
+
+	for (i = 0; i < svsb->opp_count; i++) {
+		if (svsb->opp_freqs[i] <= svsb->turn_freq_base) {
+			svsb->turn_pt = i;
+			break;
+		}
+	}
+
+	turn_pt = svsb->turn_pt;
+
+	/* Target is to fill out freq_pct74 / freq_pct30 */
+	if (turn_pt < middle_index) {
+		if (svsb->type == SVSB_HIGH) {
+			/* Edge case for preventing freq_pct30 from being 0 */
+			if (turn_pt == 0)
+				freq_pct30 = svsb->freqs_pct[0];
+
+			/* We select freqs_pct[0 ~ (turn_pt - 1)] */
+			for (i = 0; i < turn_pt; i++) {
+				b_sft = bits8 * (shift_byte % reg_4bytes);
+				freq_pct = (shift_byte < reg_4bytes) ?
+					   &freq_pct30 : &freq_pct74;
+				*freq_pct |= (svsb->freqs_pct[i] << b_sft);
+				shift_byte++;
+			}
+		} else if (svsb->type == SVSB_LOW) {
+			/*
+			 * We select freqs_pct[turn_pt] +
+			 * freqs_pct[(opp_count - 7) ~ (opp_count -1)]
+			 */
+			freq_pct30 = svsb->freqs_pct[turn_pt];
+			shift_byte++;
+			freq_i = svsb->opp_count - 7;
+			for (i = freq_i; i < svsb->opp_count; i++) {
+				b_sft = bits8 * (shift_byte % reg_4bytes);
+				freq_pct = (shift_byte < reg_4bytes) ?
+					   &freq_pct30 : &freq_pct74;
+				*freq_pct |= (svsb->freqs_pct[i] << b_sft);
+				shift_byte++;
+			}
+		}
+	} else {
+		if (svsb->type == SVSB_HIGH) {
+			/*
+			 * We select freqs_pct[0] +
+			 * freqs_pct[(turn_pt - 7) ~ (turn_pt - 1)]
+			 */
+			freq_pct30 = svsb->freqs_pct[0];
+			shift_byte++;
+			freq_i = turn_pt - 7;
+			for (i = freq_i; i < turn_pt; i++) {
+				b_sft = bits8 * (shift_byte % reg_4bytes);
+				freq_pct = (shift_byte < reg_4bytes) ?
+					   &freq_pct30 : &freq_pct74;
+				*freq_pct |= (svsb->freqs_pct[i] << b_sft);
+				shift_byte++;
+			}
+		} else if (svsb->type == SVSB_LOW) {
+			/* We select freqs_pct[turn_pt ~ (opp_count - 1)] */
+			for (i = turn_pt; i < svsb->opp_count; i++) {
+				b_sft = bits8 * (shift_byte % reg_4bytes);
+				freq_pct = (shift_byte < reg_4bytes) ?
+					   &freq_pct30 : &freq_pct74;
+				*freq_pct |= (svsb->freqs_pct[i] << b_sft);
+				shift_byte++;
+			}
+		}
+	}
+
+	svs_writel(svsp, freq_pct74, FREQPCT74);
+	svs_writel(svsp, freq_pct30, FREQPCT30);
+}
+
 static void svs_get_vops_v2(struct svs_platform *svsp)
 {
 	struct svs_bank *svsb = svsp->pbank;
@@ -868,6 +1111,25 @@ static int svs_init02(struct svs_platform *svsp)
 		}
 	}
 
+	/*
+	 * 2-line high/low bank update its corresponding opp voltages only.
+	 * Therefore, we sync voltages from opp for high/low bank voltages
+	 * consistency.
+	 */
+	for (idx = 0; idx < svsp->bank_num; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (!(svsb->mode_support & SVSB_MODE_INIT02))
+			continue;
+
+		if (svsb->type == SVSB_HIGH || svsb->type == SVSB_LOW) {
+			if (svs_sync_bank_volts_from_opp(svsb)) {
+				dev_err(svsb->dev, "sync volt fail\n");
+				return -EPERM;
+			}
+		}
+	}
+
 	return 0;
 }
 
@@ -1114,7 +1376,12 @@ static int svs_resource_setup(struct svs_platform *svsp)
 			svsb->name = "SVSB_CCI";
 			break;
 		case SVSB_GPU:
-			svsb->name = "SVSB_GPU";
+			if (svsb->type == SVSB_HIGH)
+				svsb->name = "SVSB_GPU_HIGH";
+			else if (svsb->type == SVSB_LOW)
+				svsb->name = "SVSB_GPU_LOW";
+			else
+				svsb->name = "SVSB_GPU";
 			break;
 		default:
 			WARN_ON(1);
@@ -1176,6 +1443,88 @@ static int svs_resource_setup(struct svs_platform *svsp)
 	return 0;
 }
 
+static bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
+{
+	struct svs_bank *svsb;
+	struct nvmem_cell *cell;
+	u32 idx, i, ft_pgm, vmin, golden_temp;
+
+	for (i = 0; i < svsp->efuse_num; i++)
+		if (svsp->efuse[i])
+			dev_info(svsp->dev, "M_HW_RES%d: 0x%08x\n",
+				 i, svsp->efuse[i]);
+
+	/* Svs efuse parsing */
+	ft_pgm = svsp->efuse[0] & GENMASK(7, 0);
+	vmin = (svsp->efuse[19] >> 4) & GENMASK(1, 0);
+
+	for (idx = 0; idx < svsp->bank_num; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (svsb->sw_id != SVSB_GPU)
+			return false;
+
+		if (vmin == 0x1)
+			svsb->vmin = 0x1e;
+
+		if (ft_pgm == 0)
+			svsb->volt_flags |= SVSB_INIT01_VOLT_IGNORE;
+
+		if (svsb->type == SVSB_LOW) {
+			svsb->mtdes = svsp->efuse[10] & GENMASK(7, 0);
+			svsb->bdes = (svsp->efuse[10] >> 16) & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[10] >> 24) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[17]) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[17] >> 8) & GENMASK(7, 0);
+			svsb->vmax += svsb->dvt_fixed;
+		} else if (svsb->type == SVSB_HIGH) {
+			svsb->mtdes = svsp->efuse[9] & GENMASK(7, 0);
+			svsb->bdes = (svsp->efuse[9] >> 16) & GENMASK(7, 0);
+			svsb->mdes = (svsp->efuse[9] >> 24) & GENMASK(7, 0);
+			svsb->dcbdet = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
+			svsb->dcmdet = (svsp->efuse[17] >> 24) & GENMASK(7, 0);
+			svsb->vmax += svsb->dvt_fixed;
+		}
+	}
+
+	/* Thermal efuse parsing */
+	cell = nvmem_cell_get(svsp->dev, "t-calibration-data");
+	if (IS_ERR_OR_NULL(cell)) {
+		dev_err(svsp->dev, "no thermal cell, no mon mode\n");
+		for (idx = 0; idx < svsp->bank_num; idx++) {
+			svsb = &svsp->banks[idx];
+			svsb->mode_support &= ~SVSB_MODE_MON;
+		}
+
+		return true;
+	}
+
+	svsp->tefuse = nvmem_cell_read(cell, &svsp->tefuse_num);
+	svsp->tefuse_num /= sizeof(u32);
+	nvmem_cell_put(cell);
+
+	for (i = 0; i < svsp->tefuse_num; i++)
+		if (svsp->tefuse[i] != 0)
+			break;
+
+	if (i == svsp->tefuse_num)
+		golden_temp = 50; /* All thermal efuse data are 0 */
+	else
+		golden_temp = (svsp->tefuse[0] >> 24) & GENMASK(7, 0);
+
+	for (idx = 0; idx < svsp->bank_num; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (svsb->sw_id != SVSB_GPU)
+			return false;
+
+		svsb->mts = 500;
+		svsb->bts = (((500 * golden_temp + 250460) / 1000) - 25) * 4;
+	}
+
+	return true;
+}
+
 static bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
 {
 	struct thermal_parameter tp;
@@ -1598,10 +1947,11 @@ static int svs_status_debug_show(struct seq_file *m, void *v)
 
 	ret = svs_get_bank_zone_temperature(svsb->tzone_name, &tzone_temp);
 	if (ret)
-		seq_printf(m, "%s: no \"%s\" zone?\n", svsb->name,
-			   svsb->tzone_name);
+		seq_printf(m, "%s: no \"%s\" zone? turn_pt = %u\n",
+			   svsb->name, svsb->tzone_name, svsb->turn_pt);
 	else
-		seq_printf(m, "%s: temperature = %d\n", svsb->name, tzone_temp);
+		seq_printf(m, "%s: temperature = %d, turn_pt = %u\n",
+			   svsb->name, tzone_temp, svsb->turn_pt);
 
 	for (i = 0; i < svsb->opp_count; i++) {
 		opp = dev_pm_opp_find_freq_exact(svsb->opp_dev,
@@ -1734,6 +2084,88 @@ static int svs_create_svs_debug_cmds(struct svs_platform *svsp)
 	return 0;
 }
 
+static struct svs_bank svs_mt8192_banks[] = {
+	{
+		.sw_id			= SVSB_GPU,
+		.set_freqs_pct		= svs_set_freqs_pct_v3,
+		.get_vops		= svs_get_vops_v3,
+		.hw_id			= 0,
+		.tzone_name		= "gpu1",
+		.buck_name		= "mali",
+		.volt_flags		= SVSB_INIT02_RM_DVTFIXED,
+		.mode_support		= SVSB_MODE_INIT02,
+		.opp_count		= 16,
+		.freq_base		= 688000000,
+		.turn_freq_base		= 688000000,
+		.vboot			= 0x38,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.volt_offset		= 0,
+		.vmax			= 0x60,
+		.vmin			= 0x1a,
+		.dthi			= 0x1,
+		.dtlo			= 0xfe,
+		.det_window		= 0xa28,
+		.det_max		= 0xffff,
+		.age_config		= 0x555555,
+		.agem			= 0,
+		.dc_config		= 0x1,
+		.dvt_fixed		= 0x1,
+		.vco			= 0x18,
+		.chk_shift		= 0x87,
+		.temp_upper_bound	= 0x64,
+		.temp_lower_bound	= 0xb2,
+		.tzone_high_temp	= 85000,
+		.tzone_high_temp_offset	= 0,
+		.tzone_low_temp		= 25000,
+		.tzone_low_temp_offset	= 7,
+		.core_sel		= 0x0fff0100,
+		.int_st			= BIT(0),
+		.ctl0			= 0x00540003,
+		.type			= SVSB_LOW,
+	},
+	{
+		.sw_id			= SVSB_GPU,
+		.set_freqs_pct		= svs_set_freqs_pct_v3,
+		.get_vops		= svs_get_vops_v3,
+		.hw_id			= 1,
+		.tzone_name		= "gpu1",
+		.buck_name		= "mali",
+		.volt_flags		= SVSB_INIT02_RM_DVTFIXED |
+					  SVSB_MON_VOLT_IGNORE,
+		.mode_support		= SVSB_MODE_INIT02 | SVSB_MODE_MON,
+		.opp_count		= 16,
+		.freq_base		= 902000000,
+		.turn_freq_base		= 688000000,
+		.vboot			= 0x38,
+		.volt_step		= 6250,
+		.volt_base		= 400000,
+		.volt_offset		= 0,
+		.vmax			= 0x60,
+		.vmin			= 0x1a,
+		.dthi			= 0x1,
+		.dtlo			= 0xfe,
+		.det_window		= 0xa28,
+		.det_max		= 0xffff,
+		.age_config		= 0x555555,
+		.agem			= 0,
+		.dc_config		= 0x1,
+		.dvt_fixed		= 0x6,
+		.vco			= 0x18,
+		.chk_shift		= 0x87,
+		.temp_upper_bound	= 0x64,
+		.temp_lower_bound	= 0xb2,
+		.tzone_high_temp	= 85000,
+		.tzone_high_temp_offset	= 0,
+		.tzone_low_temp		= 25000,
+		.tzone_low_temp_offset	= 7,
+		.core_sel		= 0x0fff0101,
+		.int_st			= BIT(1),
+		.ctl0			= 0x00540003,
+		.type			= SVSB_HIGH,
+	},
+};
+
 static struct svs_bank svs_mt8183_banks[] = {
 	{
 		.sw_id			= SVSB_CPU_LITTLE,
@@ -1888,6 +2320,46 @@ static struct svs_bank svs_mt8183_banks[] = {
 	},
 };
 
+static int svs_get_svs_mt8192_platform_data(struct svs_platform *svsp)
+{
+	struct device *dev;
+	struct svs_bank *svsb;
+	u32 idx;
+
+	svsp->name = "mt8192-svs";
+	svsp->banks = svs_mt8192_banks;
+	svsp->efuse_parsing = svs_mt8192_efuse_parsing;
+	svsp->regs = svs_regs_v2;
+	svsp->irqflags = IRQF_TRIGGER_HIGH;
+	svsp->bank_num = ARRAY_SIZE(svs_mt8192_banks);
+	svsp->efuse_check = 9;
+
+	svsp->rst = devm_reset_control_get_optional(svsp->dev, "svs_rst");
+	if (IS_ERR(svsp->rst)) {
+		dev_err_probe(svsp->dev, PTR_ERR(svsp->rst),
+			      "cannot get svs reset control\n");
+		return PTR_ERR(svsp->rst);
+	}
+
+	dev = svs_add_device_link(svsp, "lvts");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	for (idx = 0; idx < svsp->bank_num; idx++) {
+		svsb = &svsp->banks[idx];
+
+		if (svsb->type == SVSB_HIGH)
+			svsb->opp_dev = svs_add_device_link(svsp, "mali");
+		else if (svsb->type == SVSB_LOW)
+			svsb->opp_dev = svs_get_subsys_device(svsp, "mali");
+
+		if (IS_ERR(svsb->opp_dev))
+			return PTR_ERR(svsb->opp_dev);
+	}
+
+	return 0;
+}
+
 static int svs_get_svs_mt8183_platform_data(struct svs_platform *svsp)
 {
 	struct device *dev;
@@ -1941,6 +2413,9 @@ static const struct of_device_id mtk_svs_of_match[] = {
 	{
 		.compatible = "mediatek,mt8183-svs",
 		.data = &svs_get_svs_mt8183_platform_data,
+	}, {
+		.compatible = "mediatek,mt8192-svs",
+		.data = &svs_get_svs_mt8192_platform_data,
 	}, {
 		/* Sentinel */
 	},
-- 
2.18.0

