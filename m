Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30783180FA7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 06:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCKFQs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 01:16:48 -0400
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:35284 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725813AbgCKFQs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 01:16:48 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id AAB5A1802E2B6;
        Wed, 11 Mar 2020 05:07:10 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5C3691805A816;
        Wed, 11 Mar 2020 05:07:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:541:800:960:967:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1535:1605:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3865:3866:3867:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4051:4120:4321:4605:5007:6119:6261:6742:7903:9025:9036:10004:10848:11026:11473:11657:11658:11914:12043:12048:12294:12296:12297:12438:12555:12679:12698:12737:12895:12986:13894:14394:14877:21080:21433:21611:21627:21811:21939:21990:30045:30054:30075,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: part68_204fd3f78a028
X-Filterd-Recvd-Size: 9986
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:07:01 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH -next 011/491] ARM/QUALCOMM SUPPORT: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:25 -0700
Message-Id: <2e6818291503f032e7662f1fa45fb64c7751a7ae.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/media/platform/qcom/venus/vdec.c |  2 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs.c   |  2 +-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c |  4 ++--
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c |  2 +-
 drivers/rpmsg/qcom_glink_native.c        |  4 ++--
 drivers/soc/qcom/socinfo.c               | 16 ++++++++--------
 drivers/thermal/qcom/tsens-v0_1.c        |  8 ++++----
 drivers/thermal/qcom/tsens-v1.c          |  4 ++--
 8 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index f34920..9e0451 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -983,7 +983,7 @@ static int vdec_stop_capture(struct venus_inst *inst)
 	switch (inst->codec_state) {
 	case VENUS_DEC_STATE_DECODING:
 		ret = hfi_session_flush(inst, HFI_FLUSH_ALL);
-		/* fallthrough */
+		fallthrough;
 	case VENUS_DEC_STATE_DRAIN:
 		vdec_cancel_dst_buffers(inst);
 		inst->codec_state = VENUS_DEC_STATE_STOPPED;
diff --git a/drivers/phy/qualcomm/phy-qcom-usb-hs.c b/drivers/phy/qualcomm/phy-qcom-usb-hs.c
index 610542..327df1a 100644
--- a/drivers/phy/qualcomm/phy-qcom-usb-hs.c
+++ b/drivers/phy/qualcomm/phy-qcom-usb-hs.c
@@ -53,7 +53,7 @@ static int qcom_usb_hs_phy_set_mode(struct phy *phy,
 		case PHY_MODE_USB_OTG:
 		case PHY_MODE_USB_HOST:
 			val |= ULPI_INT_IDGRD;
-			/* fall through */
+			fallthrough;
 		case PHY_MODE_USB_DEVICE:
 			val |= ULPI_INT_SESS_VALID;
 		default:
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index fe0be8..3b0ab0e 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -793,13 +793,13 @@ static int pmic_gpio_populate(struct pmic_gpio_state *state,
 	switch (subtype) {
 	case PMIC_GPIO_SUBTYPE_GPIO_4CH:
 		pad->have_buffer = true;
-		/* Fall through */
+		fallthrough;
 	case PMIC_GPIO_SUBTYPE_GPIOC_4CH:
 		pad->num_sources = 4;
 		break;
 	case PMIC_GPIO_SUBTYPE_GPIO_8CH:
 		pad->have_buffer = true;
-		/* Fall through */
+		fallthrough;
 	case PMIC_GPIO_SUBTYPE_GPIOC_8CH:
 		pad->num_sources = 8;
 		break;
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index 338a15..b5949f7 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -346,7 +346,7 @@ static int pm8xxx_pin_config_set(struct pinctrl_dev *pctldev,
 				return -EINVAL;
 			}
 			pin->pull_up_strength = arg;
-			/* FALLTHROUGH */
+			fallthrough;
 		case PIN_CONFIG_BIAS_PULL_UP:
 			pin->bias = pin->pull_up_strength;
 			banks |= BIT(2);
diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 1995f5b..f40312 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -553,7 +553,7 @@ static void qcom_glink_receive_version(struct qcom_glink *glink,
 		break;
 	case GLINK_VERSION_1:
 		glink->features &= features;
-		/* FALLTHROUGH */
+		fallthrough;
 	default:
 		qcom_glink_send_version_ack(glink);
 		break;
@@ -584,7 +584,7 @@ static void qcom_glink_receive_version_ack(struct qcom_glink *glink,
 			break;
 
 		glink->features &= features;
-		/* FALLTHROUGH */
+		fallthrough;
 	default:
 		qcom_glink_send_version(glink);
 		break;
diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 7864b7..8ae5646 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -325,7 +325,7 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 		debugfs_create_x32("raw_device_number", 0400,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.raw_device_num);
-		/* Fall through */
+		fallthrough;
 	case SOCINFO_VERSION(0, 11):
 	case SOCINFO_VERSION(0, 10):
 	case SOCINFO_VERSION(0, 9):
@@ -333,12 +333,12 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 
 		debugfs_create_u32("foundry_id", 0400, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.foundry_id);
-		/* Fall through */
+		fallthrough;
 	case SOCINFO_VERSION(0, 8):
 	case SOCINFO_VERSION(0, 7):
 		DEBUGFS_ADD(info, pmic_model);
 		DEBUGFS_ADD(info, pmic_die_rev);
-		/* Fall through */
+		fallthrough;
 	case SOCINFO_VERSION(0, 6):
 		qcom_socinfo->info.hw_plat_subtype =
 			__le32_to_cpu(info->hw_plat_subtype);
@@ -346,7 +346,7 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 		debugfs_create_u32("hardware_platform_subtype", 0400,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.hw_plat_subtype);
-		/* Fall through */
+		fallthrough;
 	case SOCINFO_VERSION(0, 5):
 		qcom_socinfo->info.accessory_chip =
 			__le32_to_cpu(info->accessory_chip);
@@ -354,27 +354,27 @@ static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo,
 		debugfs_create_u32("accessory_chip", 0400,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.accessory_chip);
-		/* Fall through */
+		fallthrough;
 	case SOCINFO_VERSION(0, 4):
 		qcom_socinfo->info.plat_ver = __le32_to_cpu(info->plat_ver);
 
 		debugfs_create_u32("platform_version", 0400,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.plat_ver);
-		/* Fall through */
+		fallthrough;
 	case SOCINFO_VERSION(0, 3):
 		qcom_socinfo->info.hw_plat = __le32_to_cpu(info->hw_plat);
 
 		debugfs_create_u32("hardware_platform", 0400,
 				   qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.hw_plat);
-		/* Fall through */
+		fallthrough;
 	case SOCINFO_VERSION(0, 2):
 		qcom_socinfo->info.raw_ver  = __le32_to_cpu(info->raw_ver);
 
 		debugfs_create_u32("raw_version", 0400, qcom_socinfo->dbg_root,
 				   &qcom_socinfo->info.raw_ver);
-		/* Fall through */
+		fallthrough;
 	case SOCINFO_VERSION(0, 1):
 		DEBUGFS_ADD(info, build_id);
 		break;
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 4b8dd6..893ce1 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -163,7 +163,7 @@ static int calibrate_8916(struct tsens_priv *priv)
 		p2[4] = (qfprom_cdata[1] & MSM8916_S4_P2_MASK) >> MSM8916_S4_P2_SHIFT;
 		for (i = 0; i < priv->num_sensors; i++)
 			p2[i] = ((base1 + p2[i]) << 3);
-		/* Fall through */
+		fallthrough;
 	case ONE_PT_CALIB2:
 		base0 = (qfprom_cdata[0] & MSM8916_BASE0_MASK);
 		p1[0] = (qfprom_cdata[0] & MSM8916_S0_P1_MASK) >> MSM8916_S0_P1_SHIFT;
@@ -228,7 +228,7 @@ static int calibrate_8974(struct tsens_priv *priv)
 			p2[8] = (calib[5] & S8_P2_BKP_MASK) >> S8_P2_BKP_SHIFT;
 			p2[9] = (calib[5] & S9_P2_BKP_MASK) >> S9_P2_BKP_SHIFT;
 			p2[10] = (calib[5] & S10_P2_BKP_MASK) >> S10_P2_BKP_SHIFT;
-			/* Fall through */
+			fallthrough;
 		case ONE_PT_CALIB:
 		case ONE_PT_CALIB2:
 			base1 = bkp[0] & BASE1_MASK;
@@ -263,7 +263,7 @@ static int calibrate_8974(struct tsens_priv *priv)
 			p2[8] = (calib[4] & S8_P2_MASK) >> S8_P2_SHIFT;
 			p2[9] = (calib[4] & S9_P2_MASK) >> S9_P2_SHIFT;
 			p2[10] = (calib[4] & S10_P2_MASK) >> S10_P2_SHIFT;
-			/* Fall through */
+			fallthrough;
 		case ONE_PT_CALIB:
 		case ONE_PT_CALIB2:
 			base1 = calib[0] & BASE1_MASK;
@@ -293,7 +293,7 @@ static int calibrate_8974(struct tsens_priv *priv)
 			p2[i] <<= 2;
 			p2[i] |= BIT_APPEND;
 		}
-		/* Fall through */
+		fallthrough;
 	case ONE_PT_CALIB2:
 		for (i = 0; i < priv->num_sensors; i++) {
 			p1[i] += base1;
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index bd2ddb..d096d3 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -202,7 +202,7 @@ static int calibrate_v1(struct tsens_priv *priv)
 		p2[9] = (qfprom_cdata[3] & S9_P2_MASK) >> S9_P2_SHIFT;
 		for (i = 0; i < priv->num_sensors; i++)
 			p2[i] = ((base1 + p2[i]) << 2);
-		/* Fall through */
+		fallthrough;
 	case ONE_PT_CALIB2:
 		base0 = (qfprom_cdata[4] & BASE0_MASK) >> BASE0_SHIFT;
 		p1[0] = (qfprom_cdata[0] & S0_P1_MASK) >> S0_P1_SHIFT;
@@ -263,7 +263,7 @@ static int calibrate_8976(struct tsens_priv *priv)
 
 		for (i = 0; i < priv->num_sensors; i++)
 			p2[i] = ((base1 + p2[i]) << 2);
-		/* Fall through */
+		fallthrough;
 	case ONE_PT_CALIB2:
 		base0 = qfprom_cdata[0] & MSM8976_BASE0_MASK;
 		p1[0] = (qfprom_cdata[0] & MSM8976_S0_P1_MASK) >> MSM8976_S0_P1_SHIFT;
-- 
2.24.0

