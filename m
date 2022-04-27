Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A385121B6
	for <lists+linux-pm@lfdr.de>; Wed, 27 Apr 2022 20:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiD0SzF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Apr 2022 14:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiD0Syp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2022 14:54:45 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52E93E3A16
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 11:41:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v12so3693161wrv.10
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2022 11:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81JshLhHWnLeYe+FAG28CKV+ZD4fjG4zxsI+4Z0qeY8=;
        b=bu80toK7NYeqA71y0iCKqG3gVCQG0Dwp+WpuC2gfKT7WiGGBxmcXihWDQnEaSc1Zsm
         3r/qJe+VCS2QGyHn4RF0IwzGH8APx7+fSyaFSKil+aoTT5PzcZWCr4rXlK9mlD86+Uph
         Sb7k2oN45HewsziLz6WjbWFJRh7A7QO36MUd0URiIx6o0NBARBvtB9v6tfW2lwbq/ppa
         2aR18KE8+phE5/PsG5t2idj4/zdO8DfNoLA92N6j77uiCYWnUDIqV9IHE3BwRtKLr/WG
         OQox2/IirFLnjepUl9Qks6P9jRiqCRpfiIAIryoYlKsV7O1iVhWtL4/OTlBmMJ4cXGnF
         XR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81JshLhHWnLeYe+FAG28CKV+ZD4fjG4zxsI+4Z0qeY8=;
        b=GzNAysMWc2fczmivI4r6MHjzr7+I1rjakcS8eIvGsG08dERa1liOq88IkLpXPyt5No
         7BuCBVoP1t+5BcpFMGjBL8MR77a1scnRs53Ow6LL4aOWXcP5ZKtJBNyp34MzN1lxB+lw
         OxjgBonNqdTsE5doY4aAHe232SeqcV83XWPbM7xBx60vi6V/GN3H8prVHOHxjhaJQhrK
         5VmDhoq4xvFOO68ADoSIyQ6+nngIwfVTYsHmvc8kDXzjtNEHRok15jXnryGzFrLIK08F
         MOdP42Qxg5jX4k4//vkrIPICn871sH3vk70/3Cp0AzAIg5ogDYh42OBt1Xdy6yAsa2tk
         x+Zg==
X-Gm-Message-State: AOAM533qdtJHJ2wvx8ETgMpH7gkHh3oJz2GTNbfdEKtAMyw2xo8IdDKd
        oKMd0HKmHR/Xh26k4+PPni8PdA==
X-Google-Smtp-Source: ABdhPJx8HsHaFwKTPTbysuxSagLxw6aJ/Kp9iUO+NDcsLXgLJTh8qt75lS+ihKdg2BEYxzbsgzVj2A==
X-Received: by 2002:a5d:584e:0:b0:20a:9122:2c3c with SMTP id i14-20020a5d584e000000b0020a91222c3cmr23471234wrf.193.1651084877174;
        Wed, 27 Apr 2022 11:41:17 -0700 (PDT)
Received: from localhost.localdomain (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d64c3000000b0020aef267950sm1992798wri.49.2022.04.27.11.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:41:16 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org, Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH 1/6] power: supply: add Qualcomm PMI8998 SMB2 Charger driver
Date:   Wed, 27 Apr 2022 19:40:26 +0100
Message-Id: <20220427184031.2569442-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427184031.2569442-1-caleb.connolly@linaro.org>
References: <20220427184031.2569442-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add a driver for the SMB2 charger block found in the Qualcomm PMI8998
and PM660.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Changes since v1:
 * Renamed from qcom_smb2 to qcom_pmi8998_charger
---
 drivers/power/supply/Kconfig                |    9 +
 drivers/power/supply/Makefile               |    1 +
 drivers/power/supply/qcom_pmi8998_charger.c | 1070 +++++++++++++++++++
 3 files changed, 1080 insertions(+)
 create mode 100644 drivers/power/supply/qcom_pmi8998_charger.c

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 1aa8323ad9f6..1fd9ad98b607 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -897,4 +897,13 @@ config BATTERY_UG3105
 	  device is off or suspended, the functionality of this driver is
 	  limited to reporting capacity only.
 
+config CHARGER_QCOM_SMB2
+	tristate "Qualcomm PMI8998 PMIC charger driver"
+	depends on MFD_SPMI_PMIC
+	depends on IIO
+	help
+	  Say Y here to enable the Qualcomm PMIC Charger driver. This
+	  adds support for the SMB2 switch mode battery charger found
+	  in PMI8998 and related PMICs.
+
 endif # POWER_SUPPLY
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 7f02f36aea55..a39e3eda6dbd 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -108,3 +108,4 @@ obj-$(CONFIG_BATTERY_ACER_A500)	+= acer_a500_battery.o
 obj-$(CONFIG_BATTERY_SURFACE)	+= surface_battery.o
 obj-$(CONFIG_CHARGER_SURFACE)	+= surface_charger.o
 obj-$(CONFIG_BATTERY_UG3105)	+= ug3105_battery.o
+obj-$(CONFIG_CHARGER_QCOM_SMB2)	+= qcom_pmi8998_charger.o
diff --git a/drivers/power/supply/qcom_pmi8998_charger.c b/drivers/power/supply/qcom_pmi8998_charger.c
new file mode 100644
index 000000000000..fd4b585e72cb
--- /dev/null
+++ b/drivers/power/supply/qcom_pmi8998_charger.c
@@ -0,0 +1,1070 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2016-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Linaro Ltd.
+ * Author: Caleb Connolly <caleb.connolly@linaro.org>
+ *
+ * This driver is for the switch-mode battery charger and boost
+ * hardware found in pmi8998 and related PMICs.
+ */
+
+#include <linux/bits.h>
+#include <linux/iio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/minmax.h>
+#include <linux/of_irq.h>
+#include <linux/module.h>
+#include <linux/debugfs.h>
+
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#define BATTERY_CHARGER_STATUS_1			0x06
+#define BVR_INITIAL_RAMP_BIT				BIT(7)
+#define CC_SOFT_TERMINATE_BIT				BIT(6)
+#define STEP_CHARGING_STATUS_SHIFT			3
+#define STEP_CHARGING_STATUS_MASK			GENMASK(5, 3)
+#define BATTERY_CHARGER_STATUS_MASK			GENMASK(2, 0)
+
+#define BATTERY_CHARGER_STATUS_2			0x07
+#define INPUT_CURRENT_LIMITED_BIT			BIT(7)
+#define CHARGER_ERROR_STATUS_SFT_EXPIRE_BIT		BIT(6)
+#define CHARGER_ERROR_STATUS_BAT_OV_BIT			BIT(5)
+#define CHARGER_ERROR_STATUS_BAT_TERM_MISSING_BIT	BIT(4)
+#define BAT_TEMP_STATUS_MASK				GENMASK(3, 0)
+#define BAT_TEMP_STATUS_SOFT_LIMIT_MASK			GENMASK(3, 2)
+#define BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT		BIT(3)
+#define BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT		BIT(2)
+#define BAT_TEMP_STATUS_TOO_HOT_BIT			BIT(1)
+#define BAT_TEMP_STATUS_TOO_COLD_BIT			BIT(0)
+
+#define BATTERY_CHARGER_STATUS_4			0x0A
+#define CHARGE_CURRENT_POST_JEITA_MASK			GENMASK(7, 0)
+
+#define BATTERY_CHARGER_STATUS_7			0x0D
+#define ENABLE_TRICKLE_BIT				BIT(7)
+#define ENABLE_PRE_CHARGING_BIT				BIT(6)
+#define ENABLE_FAST_CHARGING_BIT			BIT(5)
+#define ENABLE_FULLON_MODE_BIT				BIT(4)
+#define TOO_COLD_ADC_BIT				BIT(3)
+#define TOO_HOT_ADC_BIT					BIT(2)
+#define HOT_SL_ADC_BIT					BIT(1)
+#define COLD_SL_ADC_BIT					BIT(0)
+
+#define CHARGING_ENABLE_CMD				0x42
+#define CHARGING_ENABLE_CMD_BIT				BIT(0)
+
+#define CHGR_CFG2					0x51
+#define CHG_EN_SRC_BIT					BIT(7)
+#define CHG_EN_POLARITY_BIT				BIT(6)
+#define PRETOFAST_TRANSITION_CFG_BIT			BIT(5)
+#define BAT_OV_ECC_BIT					BIT(4)
+#define I_TERM_BIT					BIT(3)
+#define AUTO_RECHG_BIT					BIT(2)
+#define EN_ANALOG_DROP_IN_VBATT_BIT			BIT(1)
+#define CHARGER_INHIBIT_BIT				BIT(0)
+
+#define PRE_CHARGE_CURRENT_CFG			0x60
+#define PRE_CHARGE_CURRENT_SETTING_MASK			GENMASK(5, 0)
+
+#define FAST_CHARGE_CURRENT_CFG			0x61
+#define FAST_CHARGE_CURRENT_SETTING_MASK		GENMASK(7, 0)
+
+#define FLOAT_VOLTAGE_CFG				0x70
+#define FLOAT_VOLTAGE_SETTING_MASK			GENMASK(7, 0)
+
+#define FG_UPDATE_CFG_2_SEL				0x7D
+#define SOC_LT_OTG_THRESH_SEL_BIT			BIT(3)
+#define SOC_LT_CHG_RECHARGE_THRESH_SEL_BIT		BIT(2)
+#define VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT		BIT(1)
+#define IBT_LT_CHG_TERM_THRESH_SEL_BIT			BIT(0)
+
+#define JEITA_EN_CFG				0x90
+#define JEITA_EN_HARDLIMIT_BIT				BIT(4)
+#define JEITA_EN_HOT_SL_FCV_BIT				BIT(3)
+#define JEITA_EN_COLD_SL_FCV_BIT			BIT(2)
+#define JEITA_EN_HOT_SL_CCC_BIT				BIT(1)
+#define JEITA_EN_COLD_SL_CCC_BIT			BIT(0)
+
+#define INT_RT_STS					0x310
+#define TYPE_C_CHANGE_RT_STS_BIT			BIT(7)
+#define USBIN_ICL_CHANGE_RT_STS_BIT			BIT(6)
+#define USBIN_SOURCE_CHANGE_RT_STS_BIT			BIT(5)
+#define USBIN_PLUGIN_RT_STS_BIT				BIT(4)
+#define USBIN_OV_RT_STS_BIT				BIT(3)
+#define USBIN_UV_RT_STS_BIT				BIT(2)
+#define USBIN_LT_3P6V_RT_STS_BIT			BIT(1)
+#define USBIN_COLLAPSE_RT_STS_BIT			BIT(0)
+
+#define OTG_CFG					0x153
+#define OTG_RESERVED_MASK				GENMASK(7, 6)
+#define DIS_OTG_ON_TLIM_BIT				BIT(5)
+#define QUICKSTART_OTG_FASTROLESWAP_BIT			BIT(4)
+#define INCREASE_DFP_TIME_BIT				BIT(3)
+#define ENABLE_OTG_IN_DEBUG_MODE_BIT			BIT(2)
+#define OTG_EN_SRC_CFG_BIT				BIT(1)
+#define CONCURRENT_MODE_CFG_BIT				BIT(0)
+
+#define OTG_ENG_OTG_CFG				0x1C0
+#define ENG_BUCKBOOST_HALT1_8_MODE_BIT			BIT(0)
+
+#define APSD_STATUS					0x307
+#define APSD_STATUS_7_BIT				BIT(7)
+#define HVDCP_CHECK_TIMEOUT_BIT				BIT(6)
+#define SLOW_PLUGIN_TIMEOUT_BIT				BIT(5)
+#define ENUMERATION_DONE_BIT				BIT(4)
+#define VADP_CHANGE_DONE_AFTER_AUTH_BIT			BIT(3)
+#define QC_AUTH_DONE_STATUS_BIT				BIT(2)
+#define QC_CHARGER_BIT					BIT(1)
+#define APSD_DTC_STATUS_DONE_BIT			BIT(0)
+
+#define APSD_RESULT_STATUS				0x308
+#define ICL_OVERRIDE_LATCH_BIT				BIT(7)
+#define APSD_RESULT_STATUS_MASK				GENMASK(6, 0)
+#define QC_3P0_BIT					BIT(6)
+#define QC_2P0_BIT					BIT(5)
+#define FLOAT_CHARGER_BIT				BIT(4)
+#define DCP_CHARGER_BIT					BIT(3)
+#define CDP_CHARGER_BIT					BIT(2)
+#define OCP_CHARGER_BIT					BIT(1)
+#define SDP_CHARGER_BIT					BIT(0)
+
+#define TYPE_C_STATUS_1				0x30B
+#define UFP_TYPEC_MASK					GENMASK(7, 5)
+#define UFP_TYPEC_RDSTD_BIT				BIT(7)
+#define UFP_TYPEC_RD1P5_BIT				BIT(6)
+#define UFP_TYPEC_RD3P0_BIT				BIT(5)
+#define UFP_TYPEC_FMB_255K_BIT				BIT(4)
+#define UFP_TYPEC_FMB_301K_BIT				BIT(3)
+#define UFP_TYPEC_FMB_523K_BIT				BIT(2)
+#define UFP_TYPEC_FMB_619K_BIT				BIT(1)
+#define UFP_TYPEC_OPEN_OPEN_BIT				BIT(0)
+
+#define TYPE_C_STATUS_2				0x30C
+#define DFP_RA_OPEN_BIT					BIT(7)
+#define TIMER_STAGE_BIT					BIT(6)
+#define EXIT_UFP_MODE_BIT				BIT(5)
+#define EXIT_DFP_MODE_BIT				BIT(4)
+#define DFP_TYPEC_MASK					GENMASK(3, 0)
+#define DFP_RD_OPEN_BIT					BIT(3)
+#define DFP_RD_RA_VCONN_BIT				BIT(2)
+#define DFP_RD_RD_BIT					BIT(1)
+#define DFP_RA_RA_BIT					BIT(0)
+
+#define TYPE_C_STATUS_3				0x30D
+#define ENABLE_BANDGAP_BIT				BIT(7)
+#define U_USB_GND_NOVBUS_BIT				BIT(6)
+#define U_USB_FLOAT_NOVBUS_BIT				BIT(5)
+#define U_USB_GND_BIT					BIT(4)
+#define U_USB_FMB1_BIT					BIT(3)
+#define U_USB_FLOAT1_BIT				BIT(2)
+#define U_USB_FMB2_BIT					BIT(1)
+#define U_USB_FLOAT2_BIT				BIT(0)
+
+#define TYPE_C_STATUS_4				0x30E
+#define UFP_DFP_MODE_STATUS_BIT				BIT(7)
+#define TYPEC_VBUS_STATUS_BIT				BIT(6)
+#define TYPEC_VBUS_ERROR_STATUS_BIT			BIT(5)
+#define TYPEC_DEBOUNCE_DONE_STATUS_BIT			BIT(4)
+#define TYPEC_UFP_AUDIO_ADAPT_STATUS_BIT		BIT(3)
+#define TYPEC_VCONN_OVERCURR_STATUS_BIT			BIT(2)
+#define CC_ORIENTATION_BIT				BIT(1)
+#define CC_ATTACHED_BIT					BIT(0)
+
+#define TYPE_C_STATUS_5				0x30F
+#define TRY_SOURCE_FAILED_BIT				BIT(6)
+#define TRY_SINK_FAILED_BIT				BIT(5)
+#define TIMER_STAGE_2_BIT				BIT(4)
+#define TYPEC_LEGACY_CABLE_STATUS_BIT			BIT(3)
+#define TYPEC_NONCOMP_LEGACY_CABLE_STATUS_BIT		BIT(2)
+#define TYPEC_TRYSOURCE_DETECT_STATUS_BIT		BIT(1)
+#define TYPEC_TRYSINK_DETECT_STATUS_BIT			BIT(0)
+
+#define CMD_APSD					0x341
+#define ICL_OVERRIDE_BIT				BIT(1)
+#define APSD_RERUN_BIT					BIT(0)
+
+#define TYPE_C_CFG					0x358
+#define APSD_START_ON_CC_BIT				BIT(7)
+#define WAIT_FOR_APSD_BIT				BIT(6)
+#define FACTORY_MODE_DETECTION_EN_BIT			BIT(5)
+#define FACTORY_MODE_ICL_3A_4A_BIT			BIT(4)
+#define FACTORY_MODE_DIS_CHGING_CFG_BIT			BIT(3)
+#define SUSPEND_NON_COMPLIANT_CFG_BIT			BIT(2)
+#define VCONN_OC_CFG_BIT				BIT(1)
+#define TYPE_C_OR_U_USB_BIT				BIT(0)
+
+#define TYPE_C_CFG_2				0x359
+#define TYPE_C_DFP_CURRSRC_MODE_BIT			BIT(7)
+#define DFP_CC_1P4V_OR_1P6V_BIT				BIT(6)
+#define VCONN_SOFTSTART_CFG_MASK			GENMASK(5, 4)
+#define EN_TRY_SOURCE_MODE_BIT				BIT(3)
+#define USB_FACTORY_MODE_ENABLE_BIT			BIT(2)
+#define TYPE_C_UFP_MODE_BIT				BIT(1)
+#define EN_80UA_180UA_CUR_SOURCE_BIT			BIT(0)
+
+#define TYPE_C_CFG_3				0x35A
+#define TVBUS_DEBOUNCE_BIT				BIT(7)
+#define TYPEC_LEGACY_CABLE_INT_EN_BIT			BIT(6)
+#define TYPEC_NONCOMPLIANT_LEGACY_CABLE_INT_EN_B	BIT(5)
+#define TYPEC_TRYSOURCE_DETECT_INT_EN_BIT		BIT(4)
+#define TYPEC_TRYSINK_DETECT_INT_EN_BIT			BIT(3)
+#define EN_TRYSINK_MODE_BIT				BIT(2)
+#define EN_LEGACY_CABLE_DETECTION_BIT			BIT(1)
+#define ALLOW_PD_DRING_UFP_TCCDB_BIT			BIT(0)
+
+#define USBIN_OPTIONS_1_CFG				0x362
+#define CABLE_R_SEL_BIT					BIT(7)
+#define HVDCP_AUTH_ALG_EN_CFG_BIT			BIT(6)
+#define HVDCP_AUTONOMOUS_MODE_EN_CFG_BIT		BIT(5)
+#define INPUT_PRIORITY_BIT				BIT(4)
+#define AUTO_SRC_DETECT_BIT				BIT(3)
+#define HVDCP_EN_BIT					BIT(2)
+#define VADP_INCREMENT_VOLTAGE_LIMIT_BIT		BIT(1)
+#define VADP_TAPER_TIMER_EN_BIT				BIT(0)
+
+#define USBIN_OPTIONS_2_CFG				0x363
+#define WIPWR_RST_EUD_CFG_BIT				BIT(7)
+#define SWITCHER_START_CFG_BIT				BIT(6)
+#define DCD_TIMEOUT_SEL_BIT				BIT(5)
+#define OCD_CURRENT_SEL_BIT				BIT(4)
+#define SLOW_PLUGIN_TIMER_EN_CFG_BIT			BIT(3)
+#define FLOAT_OPTIONS_MASK				GENMASK(2, 0)
+#define FLOAT_DIS_CHGING_CFG_BIT			BIT(2)
+#define SUSPEND_FLOAT_CFG_BIT				BIT(1)
+#define FORCE_FLOAT_SDP_CFG_BIT				BIT(0)
+
+#define TAPER_TIMER_SEL_CFG				0x364
+#define TYPEC_SPARE_CFG_BIT				BIT(7)
+#define TYPEC_DRP_DFP_TIME_CFG_BIT			BIT(5)
+#define TAPER_TIMER_SEL_MASK				GENMASK(1, 0)
+
+#define USBIN_LOAD_CFG				0x365
+#define USBIN_OV_CH_LOAD_OPTION_BIT			BIT(7)
+#define ICL_OVERRIDE_AFTER_APSD_BIT			BIT(4)
+
+#define USBIN_ICL_OPTIONS				0x366
+#define CFG_USB3P0_SEL_BIT				BIT(2)
+#define USB51_MODE_BIT					BIT(1)
+#define USBIN_MODE_CHG_BIT				BIT(0)
+
+#define TYPE_C_INTRPT_ENB_SOFTWARE_CTRL		0x368
+#define EXIT_SNK_BASED_ON_CC_BIT			BIT(7)
+#define VCONN_EN_ORIENTATION_BIT			BIT(6)
+#define TYPEC_VCONN_OVERCURR_INT_EN_BIT			BIT(5)
+#define VCONN_EN_SRC_BIT				BIT(4)
+#define VCONN_EN_VALUE_BIT				BIT(3)
+#define TYPEC_POWER_ROLE_CMD_MASK			GENMASK(2, 0)
+#define UFP_EN_CMD_BIT					BIT(2)
+#define DFP_EN_CMD_BIT					BIT(1)
+#define TYPEC_DISABLE_CMD_BIT				BIT(0)
+
+#define USBIN_CURRENT_LIMIT_CFG			0x370
+#define USBIN_CURRENT_LIMIT_MASK			GENMASK(7, 0)
+
+#define USBIN_AICL_OPTIONS_CFG			0x380
+#define SUSPEND_ON_COLLAPSE_USBIN_BIT			BIT(7)
+#define USBIN_AICL_HDC_EN_BIT				BIT(6)
+#define USBIN_AICL_START_AT_MAX_BIT			BIT(5)
+#define USBIN_AICL_RERUN_EN_BIT				BIT(4)
+#define USBIN_AICL_ADC_EN_BIT				BIT(3)
+#define USBIN_AICL_EN_BIT				BIT(2)
+#define USBIN_HV_COLLAPSE_RESPONSE_BIT			BIT(1)
+#define USBIN_LV_COLLAPSE_RESPONSE_BIT			BIT(0)
+
+#define USBIN_5V_AICL_THRESHOLD_CFG			0x381
+#define USBIN_5V_AICL_THRESHOLD_CFG_MASK		GENMASK(2, 0)
+
+#define USBIN_CONT_AICL_THRESHOLD_CFG		0x384
+#define USBIN_CONT_AICL_THRESHOLD_CFG_MASK		GENMASK(5, 0)
+
+#define DC_ENG_SSUPPLY_CFG2				0x4C1
+#define ENG_SSUPPLY_IVREF_OTG_SS_MASK			GENMASK(2, 0)
+#define OTG_SS_SLOW					0x3
+
+#define DCIN_AICL_REF_SEL_CFG			0x481
+#define DCIN_CONT_AICL_THRESHOLD_CFG_MASK		GENMASK(5, 0)
+
+#define WI_PWR_OPTIONS				0x495
+#define CHG_OK_BIT					BIT(7)
+#define WIPWR_UVLO_IRQ_OPT_BIT				BIT(6)
+#define BUCK_HOLDOFF_ENABLE_BIT				BIT(5)
+#define CHG_OK_HW_SW_SELECT_BIT				BIT(4)
+#define WIPWR_RST_ENABLE_BIT				BIT(3)
+#define DCIN_WIPWR_IRQ_SELECT_BIT			BIT(2)
+#define AICL_SWITCH_ENABLE_BIT				BIT(1)
+#define ZIN_ICL_ENABLE_BIT				BIT(0)
+
+#define ICL_STATUS					0x607
+#define INPUT_CURRENT_LIMIT_MASK			GENMASK(7, 0)
+
+#define POWER_PATH_STATUS				0x60B
+#define P_PATH_INPUT_SS_DONE_BIT			BIT(7)
+#define P_PATH_USBIN_SUSPEND_STS_BIT			BIT(6)
+#define P_PATH_DCIN_SUSPEND_STS_BIT			BIT(5)
+#define P_PATH_USE_USBIN_BIT				BIT(4)
+#define P_PATH_USE_DCIN_BIT				BIT(3)
+#define P_PATH_POWER_PATH_MASK				GENMASK(2, 1)
+#define P_PATH_VALID_INPUT_POWER_SOURCE_STS_BIT		BIT(0)
+
+#define BARK_BITE_WDOG_PET				0x643
+#define BARK_BITE_WDOG_PET_BIT				BIT(0)
+
+#define WD_CFG					0x651
+#define WATCHDOG_TRIGGER_AFP_EN_BIT			BIT(7)
+#define BARK_WDOG_INT_EN_BIT				BIT(6)
+#define BITE_WDOG_INT_EN_BIT				BIT(5)
+#define SFT_AFTER_WDOG_IRQ_MASK				GENMASK(4, 3)
+#define WDOG_IRQ_SFT_BIT				BIT(2)
+#define WDOG_TIMER_EN_ON_PLUGIN_BIT			BIT(1)
+#define WDOG_TIMER_EN_BIT				BIT(0)
+
+#define SNARL_BARK_BITE_WD_CFG			0x653
+#define BITE_WDOG_DISABLE_CHARGING_CFG_BIT		BIT(7)
+#define SNARL_WDOG_TIMEOUT_MASK				GENMASK(6, 4)
+#define BARK_WDOG_TIMEOUT_MASK				GENMASK(3, 2)
+#define BITE_WDOG_TIMEOUT_MASK				GENMASK(1, 0)
+
+#define AICL_RERUN_TIME_CFG				0x661
+#define AICL_RERUN_TIME_MASK				GENMASK(1, 0)
+
+#define STAT_CFG					0x690
+#define STAT_SW_OVERRIDE_VALUE_BIT			BIT(7)
+#define STAT_SW_OVERRIDE_CFG_BIT			BIT(6)
+#define STAT_PARALLEL_OFF_DG_CFG_MASK			GENMASK(5, 4)
+#define STAT_POLARITY_CFG_BIT				BIT(3)
+#define STAT_PARALLEL_CFG_BIT				BIT(2)
+#define STAT_FUNCTION_CFG_BIT				BIT(1)
+#define STAT_IRQ_PULSING_EN_BIT				BIT(0)
+
+#define USBIN_CURRENT_25MA				25000
+#define USBIN_CURRENT_100MA				100000
+#define USBIN_CURRENT_150MA				150000
+#define USBIN_CURRENT_500MA				500000
+#define USBIN_CURRENT_900MA				900000
+#define SDP_CURRENT_UA					500000
+#define CDP_CURRENT_UA					1500000
+#define DCP_CURRENT_UA					1500000
+
+enum charger_status {
+	TRICKLE_CHARGE = 0,
+	PRE_CHARGE,
+	FAST_CHARGE,
+	FULLON_CHARGE,
+	TAPER_CHARGE,
+	TERMINATE_CHARGE,
+	INHIBIT_CHARGE,
+	DISABLE_CHARGE,
+};
+
+struct smb2_register {
+	u16 addr;
+	u8 mask;
+	u8 val;
+};
+
+/**
+ * struct smb2_chip - smb2 chip structure
+ * @dev:		Device reference for power_supply
+ * @name:		The platform device name
+ * @base:		Base address for smb2 registers
+ * @regmap:		Register map
+ * @batt_info:		Battery data from DT
+ * @status_change_work: Worker to handle plug/unplug events
+ * @usb_in_i_chan:	USB_IN current measurement channel
+ * @usb_in_v_chan:	USB_IN voltage measurement channel
+ * @chg_psy:		Charger power supply instance
+ */
+struct smb2_chip {
+	struct device *dev;
+	const char *name;
+	unsigned int base;
+	struct regmap *regmap;
+	struct power_supply_battery_info *batt_info;
+
+	struct delayed_work status_change_work;
+
+	struct iio_channel *usb_in_i_chan;
+	struct iio_channel *usb_in_v_chan;
+
+	struct power_supply *chg_psy;
+};
+
+static enum power_supply_property smb2_properties[] = {
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_USB_TYPE,
+};
+
+static enum power_supply_usb_type smb2_usb_types[] = {
+	POWER_SUPPLY_USB_TYPE_UNKNOWN,
+	POWER_SUPPLY_USB_TYPE_SDP,
+	POWER_SUPPLY_USB_TYPE_DCP,
+	POWER_SUPPLY_USB_TYPE_CDP,
+};
+
+int smb2_get_prop_usb_online(struct smb2_chip *chip, int *val)
+{
+	unsigned int stat;
+	int rc;
+
+	rc = regmap_read(chip->regmap, chip->base + POWER_PATH_STATUS,
+			 &stat);
+	if (rc < 0) {
+		dev_err(chip->dev, "Couldn't read POWER_PATH_STATUS! ret=%d\n",
+			rc);
+		return rc;
+	}
+
+	*val = (stat & P_PATH_USE_USBIN_BIT) &&
+	       (stat & P_PATH_VALID_INPUT_POWER_SOURCE_STS_BIT);
+	return 0;
+}
+
+/*
+ * Qualcomm "automatic power source detection" aka APSD
+ * tells us what type of charger we're connected to.
+ */
+static int smb2_apsd_get_charger_type(struct smb2_chip *chip, int *val)
+{
+	int rc;
+	unsigned int apsd_stat, stat;
+	int usb_online;
+
+	rc = smb2_get_prop_usb_online(chip, &usb_online);
+	if (rc < 0 || !usb_online) {
+		*val = POWER_SUPPLY_USB_TYPE_UNKNOWN;
+		return 0;
+	}
+
+	rc = regmap_read(chip->regmap, chip->base + APSD_STATUS, &apsd_stat);
+	if (rc < 0) {
+		dev_err(chip->dev, "Failed to read apsd status, rc = %d", rc);
+		return rc;
+	}
+	if (!(apsd_stat & APSD_DTC_STATUS_DONE_BIT)) {
+		dev_err(chip->dev, "Apsd not ready");
+		return -EAGAIN;
+	}
+
+	rc = regmap_read(chip->regmap, chip->base + APSD_RESULT_STATUS, &stat);
+	if (rc < 0) {
+		dev_err(chip->dev, "Failed to read apsd result, rc = %d", rc);
+		return rc;
+	}
+
+	stat &= APSD_RESULT_STATUS_MASK;
+
+	if (stat & CDP_CHARGER_BIT)
+		*val = POWER_SUPPLY_USB_TYPE_CDP;
+	else if (stat & (DCP_CHARGER_BIT | OCP_CHARGER_BIT | FLOAT_CHARGER_BIT))
+		*val = POWER_SUPPLY_USB_TYPE_DCP;
+	else /* SDP_CHARGER_BIT (or others) */
+		*val = POWER_SUPPLY_USB_TYPE_SDP;
+
+	return 0;
+}
+
+int smb2_get_prop_status(struct smb2_chip *chip, int *val)
+{
+	int usb_online_val;
+	unsigned char stat[2];
+	int rc;
+
+	rc = smb2_get_prop_usb_online(chip, &usb_online_val);
+	if (rc < 0) {
+		dev_err(chip->dev, "Couldn't get usb online property rc = %d\n",
+			rc);
+		return rc;
+	}
+
+	if (!usb_online_val) {
+		*val = POWER_SUPPLY_STATUS_DISCHARGING;
+		return rc;
+	}
+
+	rc = regmap_bulk_read(chip->regmap,
+			 chip->base + BATTERY_CHARGER_STATUS_1, &stat, 2);
+	if (rc < 0) {
+		dev_err(chip->dev, "Failed to read charging status ret=%d\n",
+			rc);
+		return rc;
+	}
+
+	if (stat[1] & CHARGER_ERROR_STATUS_BAT_OV_BIT) {
+		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		return 0;
+	}
+
+	stat[0] = stat[0] & BATTERY_CHARGER_STATUS_MASK;
+
+	switch (stat[0]) {
+	case TRICKLE_CHARGE:
+	case PRE_CHARGE:
+	case FAST_CHARGE:
+	case FULLON_CHARGE:
+	case TAPER_CHARGE:
+		*val = POWER_SUPPLY_STATUS_CHARGING;
+		return rc;
+	case DISABLE_CHARGE:
+		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		return rc;
+	case TERMINATE_CHARGE:
+		*val = POWER_SUPPLY_STATUS_FULL;
+		return rc;
+	case INHIBIT_CHARGE:
+	default:
+		*val = POWER_SUPPLY_STATUS_UNKNOWN;
+		return rc;
+	}
+}
+
+static inline int smb2_get_current_limit(struct smb2_chip *chip,
+					 unsigned int *val)
+{
+	int rc = regmap_read(chip->regmap, chip->base + ICL_STATUS, val);
+
+	if (rc >= 0)
+		*val *= 25000;
+	return rc;
+}
+
+static int smb2_set_current_limit(struct smb2_chip *chip, unsigned int val)
+{
+	unsigned char val_raw, icl_option;
+	unsigned int load_cfg;
+	int rc;
+
+	if (val > 4800000) {
+		dev_err(chip->dev,
+			"Can't set current limit higher than 4800000uA");
+		return -EINVAL;
+	}
+	val_raw = val / 25000;
+
+	if (val == USBIN_CURRENT_100MA)
+		icl_option = 0;
+	else if (val == USBIN_CURRENT_150MA)
+		icl_option = CFG_USB3P0_SEL_BIT;
+	else if (val == USBIN_CURRENT_500MA)
+		icl_option = USB51_MODE_BIT;
+	else if (val == USBIN_CURRENT_900MA)
+		icl_option = CFG_USB3P0_SEL_BIT | USB51_MODE_BIT;
+	else if (val > USBIN_CURRENT_500MA)
+		icl_option = USBIN_MODE_CHG_BIT;
+
+	rc = regmap_update_bits(chip->regmap, chip->base + USBIN_ICL_OPTIONS,
+		CFG_USB3P0_SEL_BIT | USB51_MODE_BIT | USBIN_MODE_CHG_BIT,
+		icl_option);
+	if (rc < 0)
+		return rc;
+
+	return regmap_write(chip->regmap, chip->base + USBIN_CURRENT_LIMIT_CFG, val_raw);
+}
+
+void smb2_status_change_work(struct work_struct *work)
+{
+	struct smb2_chip *chip =
+		container_of(work, struct smb2_chip, status_change_work.work);
+	unsigned int charger_type, current_ua;
+	int usb_online, count, rc;
+
+	smb2_get_prop_usb_online(chip, &usb_online);
+	if (usb_online == 0)
+		return;
+
+	for (count = 0; count < 3; count++) {
+		dev_dbg(chip->dev, "get charger type retry %d\n", count);
+		rc = smb2_apsd_get_charger_type(chip, &charger_type);
+		if (rc == 0)
+			break;
+		msleep(100);
+	}
+
+	if (rc < 0) {
+		rc = regmap_update_bits(chip->regmap, chip->base + CMD_APSD,
+					APSD_RERUN_BIT, APSD_RERUN_BIT);
+		schedule_delayed_work(&chip->status_change_work,
+				      msecs_to_jiffies(1500));
+		dev_dbg(chip->dev, "get charger type failed, rerun apsd\n");
+		return;
+	}
+
+	switch (charger_type) {
+	case POWER_SUPPLY_USB_TYPE_CDP:
+		current_ua = CDP_CURRENT_UA;
+		break;
+	case POWER_SUPPLY_USB_TYPE_DCP:
+		current_ua = DCP_CURRENT_UA;
+		break;
+	case POWER_SUPPLY_USB_TYPE_SDP:
+	default:
+		current_ua = SDP_CURRENT_UA;
+		break;
+	}
+
+	smb2_set_current_limit(chip, current_ua);
+	power_supply_changed(chip->chg_psy);
+}
+
+int smb2_get_iio_chan(struct smb2_chip *chip, struct iio_channel *chan,
+		      int *val)
+{
+	int rc;
+	union power_supply_propval status;
+
+	rc = power_supply_get_property(chip->chg_psy, POWER_SUPPLY_PROP_STATUS,
+				       &status);
+	if (rc < 0 || status.intval != POWER_SUPPLY_STATUS_CHARGING) {
+		*val = 0;
+		return 0;
+	}
+
+	if (IS_ERR(chan)) {
+		dev_err(chip->dev, "Failed to chan, err = %li", PTR_ERR(chan));
+		return PTR_ERR(chan);
+	}
+
+	return iio_read_channel_processed(chan, val);
+}
+
+int smb2_get_prop_health(struct smb2_chip *chip, int *val)
+{
+	int rc;
+	unsigned int stat;
+
+	*val = POWER_SUPPLY_HEALTH_UNKNOWN;
+
+	rc = regmap_read(chip->regmap,
+			 chip->base + BATTERY_CHARGER_STATUS_2, &stat);
+	if (rc < 0) {
+		dev_err(chip->dev, "Couldn't read charger status rc=%d\n", rc);
+		return rc;
+	}
+
+	switch (stat) {
+	case CHARGER_ERROR_STATUS_BAT_OV_BIT:
+		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		return 0;
+	case BAT_TEMP_STATUS_TOO_COLD_BIT:
+		*val = POWER_SUPPLY_HEALTH_COLD;
+		return 0;
+	case BAT_TEMP_STATUS_TOO_HOT_BIT:
+		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
+		return 0;
+	case BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT:
+		*val = POWER_SUPPLY_HEALTH_COOL;
+		return 0;
+	case BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT:
+		*val = POWER_SUPPLY_HEALTH_WARM;
+		return 0;
+	default:
+		*val = POWER_SUPPLY_HEALTH_GOOD;
+		return 0;
+	}
+}
+
+static int smb2_get_property(struct power_supply *psy,
+			     enum power_supply_property psp,
+			     union power_supply_propval *val)
+{
+	struct smb2_chip *chip = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = "Qualcomm";
+		return 0;
+	case POWER_SUPPLY_PROP_MODEL_NAME:
+		val->strval = chip->name;
+		return 0;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		return smb2_get_current_limit(chip, &val->intval);
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		return smb2_get_iio_chan(chip, chip->usb_in_i_chan,
+					  &val->intval);
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		return smb2_get_iio_chan(chip, chip->usb_in_v_chan,
+					  &val->intval);
+	case POWER_SUPPLY_PROP_ONLINE:
+		return smb2_get_prop_usb_online(chip, &val->intval);
+	case POWER_SUPPLY_PROP_STATUS:
+		return smb2_get_prop_status(chip, &val->intval);
+	case POWER_SUPPLY_PROP_HEALTH:
+		return smb2_get_prop_health(chip, &val->intval);
+	case POWER_SUPPLY_PROP_USB_TYPE:
+		return smb2_apsd_get_charger_type(chip, &val->intval);
+	default:
+		dev_err(chip->dev, "invalid property: %d\n", psp);
+		return -EINVAL;
+	}
+}
+
+static int smb2_set_property(struct power_supply *psy,
+			     enum power_supply_property psp,
+			     const union power_supply_propval *val)
+{
+	struct smb2_chip *chip = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		return smb2_set_current_limit(chip, val->intval);
+	default:
+		dev_err(chip->dev, "No setter for property: %d\n", psp);
+		return -EINVAL;
+	}
+}
+
+static int smb2_property_is_writable(struct power_supply *psy,
+				     enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+irqreturn_t smb2_handle_batt_overvoltage(int irq, void *data)
+{
+	struct smb2_chip *chip = data;
+	unsigned int status;
+
+	regmap_read(chip->regmap,
+		    chip->base + BATTERY_CHARGER_STATUS_2, &status);
+
+	if (status & CHARGER_ERROR_STATUS_BAT_OV_BIT) {
+		/* The hardware stops charging automatically */
+		dev_err(chip->dev, "battery overvoltage detected, charging stopped\n");
+		power_supply_changed(chip->chg_psy);
+	}
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t smb2_handle_usb_plugin(int irq, void *data)
+{
+	struct smb2_chip *chip = data;
+
+	power_supply_changed(chip->chg_psy);
+
+	schedule_delayed_work(&chip->status_change_work,
+			      msecs_to_jiffies(1000));
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t smb2_handle_usb_icl_change(int irq, void *data)
+{
+	struct smb2_chip *chip = data;
+
+	power_supply_changed(chip->chg_psy);
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t smb2_handle_wdog_bark(int irq, void *data)
+{
+	struct smb2_chip *chip = data;
+	int rc;
+
+	power_supply_changed(chip->chg_psy);
+
+	rc = regmap_write(chip->regmap, BARK_BITE_WDOG_PET, BARK_BITE_WDOG_PET_BIT);
+	if (rc < 0)
+		dev_err(chip->dev, "Couldn't pet the dog rc=%d\n", rc);
+
+	return IRQ_HANDLED;
+}
+
+static const struct power_supply_desc smb2_psy_desc = {
+	.name = "pmi8998_charger",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.usb_types = smb2_usb_types,
+	.num_usb_types = ARRAY_SIZE(smb2_usb_types),
+	.properties = smb2_properties,
+	.num_properties = ARRAY_SIZE(smb2_properties),
+	.get_property = smb2_get_property,
+	.set_property = smb2_set_property,
+	.property_is_writeable = smb2_property_is_writable,
+};
+
+/* Init sequence derived from vendor downstream driver */
+static const struct smb2_register smb2_init_seq[] = {
+	{ .addr = AICL_RERUN_TIME_CFG,
+	  .mask = AICL_RERUN_TIME_MASK,
+	  .val = 0 },
+	/*
+	 * By default configure us as an upstream facing port
+	 * FIXME: for OTG we should set UFP_EN_CMD_BIT and DFP_EN_CMD_BIT both to 0
+	 */
+	{ .addr = TYPE_C_INTRPT_ENB_SOFTWARE_CTRL,
+	  .mask = TYPEC_POWER_ROLE_CMD_MASK | VCONN_EN_SRC_BIT
+		| VCONN_EN_VALUE_BIT,
+	  .val = VCONN_EN_SRC_BIT | UFP_EN_CMD_BIT },
+	/*
+	 * disable Type-C factory mode and stay in Attached.SRC state when VCONN
+	 * over-current happens
+	 */
+	{ .addr = TYPE_C_CFG,
+	  .mask = FACTORY_MODE_DETECTION_EN_BIT | VCONN_OC_CFG_BIT,
+	  .val = 0 },
+	/* Configure VBUS for software control */
+	{ .addr = OTG_CFG, .mask = OTG_EN_SRC_CFG_BIT, .val = 0 },
+	{ .addr = FG_UPDATE_CFG_2_SEL,
+	  .mask = SOC_LT_CHG_RECHARGE_THRESH_SEL_BIT
+		| VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT,
+	  .val = VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT },
+	/* Enable charging */
+	{ .addr = USBIN_OPTIONS_1_CFG, .mask = HVDCP_EN_BIT, .val = 0 },
+	{ .addr = CHARGING_ENABLE_CMD,
+	  .mask = CHARGING_ENABLE_CMD_BIT,
+	  .val = CHARGING_ENABLE_CMD_BIT },
+	/* Allow overriding the current limit */
+	{ .addr = USBIN_LOAD_CFG,
+	  .mask = ICL_OVERRIDE_AFTER_APSD_BIT,
+	  .val = ICL_OVERRIDE_AFTER_APSD_BIT },
+	{ .addr = CHGR_CFG2,
+	  .mask = CHG_EN_SRC_BIT | CHG_EN_POLARITY_BIT | PRETOFAST_TRANSITION_CFG_BIT
+		| BAT_OV_ECC_BIT | I_TERM_BIT | AUTO_RECHG_BIT
+		| EN_ANALOG_DROP_IN_VBATT_BIT | CHARGER_INHIBIT_BIT,
+	  .val = 0 },
+	/*
+	 * No clue what this does
+	 */
+	{ .addr = STAT_CFG,
+	  .mask = STAT_SW_OVERRIDE_CFG_BIT,
+	  .val = STAT_SW_OVERRIDE_CFG_BIT },
+	/*
+	 * Set the default SDP charger type to a 500ma USB 2.0 port
+	 */
+	{ .addr = USBIN_ICL_OPTIONS,
+	  .mask = USB51_MODE_BIT | USBIN_MODE_CHG_BIT,
+	  .val = USB51_MODE_BIT },
+	/*
+	 * Disable watchdog
+	 */
+	{
+	  .addr = SNARL_BARK_BITE_WD_CFG,
+	  .mask = 0xff,
+	  .val = 0 },
+	{ .addr = WD_CFG,
+	  .mask = WATCHDOG_TRIGGER_AFP_EN_BIT | WDOG_TIMER_EN_ON_PLUGIN_BIT
+		| BARK_WDOG_INT_EN_BIT,
+	  .val = 0 },
+	/* OnePlus init stuff from "op_set_collapse_fet" */
+	{ .addr = USBIN_5V_AICL_THRESHOLD_CFG,
+	  .mask = USBIN_5V_AICL_THRESHOLD_CFG_MASK,
+	  .val = 0x3 },
+	{ .addr = USBIN_CONT_AICL_THRESHOLD_CFG,
+	  .mask = USBIN_CONT_AICL_THRESHOLD_CFG_MASK,
+	  .val = 0x3 },
+	/* Yay undocumented register values! */
+	{ .addr = USBIN_LOAD_CFG,
+	  .mask = BIT(0) | BIT(1),
+	  .val = 0x3 },
+	/* Enable Automatic Input Current Limit, this will slowly ramp up the current
+	 * When connected to a wall charger, and automatically stop when it detects
+	 * the charger current limit (voltage drop?) or it reaches the programmed limit.
+	 */
+	{ .addr = USBIN_AICL_OPTIONS_CFG,
+	  .mask = USBIN_AICL_START_AT_MAX_BIT | USBIN_AICL_ADC_EN_BIT | USBIN_AICL_EN_BIT
+		| SUSPEND_ON_COLLAPSE_USBIN_BIT | USBIN_HV_COLLAPSE_RESPONSE_BIT
+		| USBIN_LV_COLLAPSE_RESPONSE_BIT,
+	  .val = USBIN_HV_COLLAPSE_RESPONSE_BIT | USBIN_LV_COLLAPSE_RESPONSE_BIT
+		| USBIN_AICL_EN_BIT },
+	/*
+	 * Set pre charge current to default, the OnePlus 6 bootloader
+	 * sets this very conservatively.
+	 * NOTE: seems to be reset to zero again anyway after boot
+	 */
+	{ .addr = PRE_CHARGE_CURRENT_CFG,
+	  .mask = PRE_CHARGE_CURRENT_SETTING_MASK,
+	  .val = 500000 / 25000 },
+	/*
+	 * Set "fast charge current" to the default 2A, the OnePlus 6 also
+	 * sets this very conservatively.
+	 * NOTE: seems to be reset to zero again anyway after boot
+	 */
+	{ .addr = FAST_CHARGE_CURRENT_CFG,
+	  .mask = FAST_CHARGE_CURRENT_SETTING_MASK,
+	  .addr = 1950000 / 25000 },
+};
+
+static int smb2_init_hw(struct smb2_chip *chip)
+{
+	int rc, i;
+
+	for (i = 0; i < ARRAY_SIZE(smb2_init_seq); i++) {
+		dev_dbg(chip->dev, "%d: Writing 0x%02x to 0x%02x\n", i,
+			smb2_init_seq[i].val, smb2_init_seq[i].addr);
+		rc = regmap_update_bits(chip->regmap,
+					chip->base + smb2_init_seq[i].addr,
+					smb2_init_seq[i].mask,
+					smb2_init_seq[i].val);
+		if (rc < 0)
+			return dev_err_probe(chip->dev, rc,
+				"%s: Failed to write 0x%02x to 0x%02x\n",
+				__func__, smb2_init_seq[i].val,
+				smb2_init_seq[i].addr);
+	}
+
+	return 0;
+}
+
+static int smb2_probe(struct platform_device *pdev)
+{
+	struct power_supply_config supply_config = {};
+	struct smb2_chip *chip;
+	int rc, irq;
+
+	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = &pdev->dev;
+	chip->name = pdev->name;
+
+	chip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!chip->regmap) {
+		return dev_err_probe(chip->dev, -ENODEV,
+				     "failed to locate the regmap\n");
+	}
+
+	rc = device_property_read_u32(chip->dev, "reg", &chip->base);
+	if (rc < 0) {
+		return dev_err_probe(chip->dev, rc,
+				     "Couldn't read base address\n");
+	}
+
+	irq = of_irq_get_byname(pdev->dev.of_node, "bat-ov");
+	if (irq < 0) {
+		return dev_err_probe(&pdev->dev, irq,
+				     "Couldn't get irq bat-ov byname\n");
+	}
+
+	rc = devm_request_threaded_irq(chip->dev, irq, NULL,
+				       smb2_handle_batt_overvoltage, IRQF_ONESHOT,
+				       "bat-ov", chip);
+	if (irq < 0)
+		return dev_err_probe(&pdev->dev, irq,
+				     "Couldn't get irq bat-ov byname\n");
+
+	irq = of_irq_get_byname(pdev->dev.of_node, "usb-plugin");
+	if (irq < 0)
+		return dev_err_probe(&pdev->dev, irq,
+				     "Couldn't get irq usb-plugin byname\n");
+
+	rc = devm_request_threaded_irq(chip->dev, irq, NULL,
+				       smb2_handle_usb_plugin, IRQF_ONESHOT,
+				       "usb-plugin", chip);
+	if (irq < 0)
+		return dev_err_probe(&pdev->dev, irq,
+			"Couldn't request irq usb-plugin\n");
+
+
+	irq = of_irq_get_byname(pdev->dev.of_node, "usbin-icl-change");
+	if (irq < 0) {
+		return dev_err_probe(&pdev->dev, irq,
+				     "Couldn't get irq usbin-icl-change byname\n");
+	}
+
+	rc = devm_request_threaded_irq(chip->dev, irq, NULL,
+				       smb2_handle_usb_icl_change, IRQF_ONESHOT,
+				       "usbin-icl-change", chip);
+	if (rc < 0)
+		return dev_err_probe(&pdev->dev, irq,
+			"Couldn't request irq usbin-icl-change\n");
+
+	irq = of_irq_get_byname(pdev->dev.of_node, "wdog-bark");
+	if (irq < 0) {
+		return dev_err_probe(&pdev->dev, irq,
+				     "Couldn't get irq wdog-bark byname\n");
+	}
+
+	rc = devm_request_threaded_irq(chip->dev, irq, NULL,
+				       smb2_handle_wdog_bark, IRQF_ONESHOT,
+				       "wdog-bark", chip);
+	if (rc < 0)
+		return dev_err_probe(&pdev->dev, irq,
+			"Couldn't request irq wdog-bark\n");
+
+	chip->usb_in_v_chan = iio_channel_get(chip->dev, "usbin_v");
+	if (IS_ERR(chip->usb_in_v_chan))
+		return dev_err_probe(chip->dev, PTR_ERR(chip->usb_in_v_chan),
+			"Couldn't get usbin_v IIO channel from RRADC\n");
+
+	chip->usb_in_i_chan = iio_channel_get(chip->dev, "usbin_i");
+	if (IS_ERR(chip->usb_in_i_chan)) {
+		iio_channel_release(chip->usb_in_v_chan);
+		return dev_err_probe(chip->dev, PTR_ERR(chip->usb_in_i_chan),
+			"Couldn't get usbin_i IIO channel from RRADC\n");
+	}
+
+	rc = smb2_init_hw(chip);
+	if (rc < 0)
+		return rc;
+
+	supply_config.drv_data = chip;
+	supply_config.of_node = pdev->dev.of_node;
+
+	chip->chg_psy = devm_power_supply_register(chip->dev, &smb2_psy_desc,
+						   &supply_config);
+	if (IS_ERR(chip->chg_psy))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chip->chg_psy),
+				     "failed to register power supply\n");
+
+	rc = power_supply_get_battery_info(chip->chg_psy, &chip->batt_info);
+	if (rc)
+		return dev_err_probe(&pdev->dev, rc,
+				     "Failed to get battery info\n");
+
+	INIT_DELAYED_WORK(&chip->status_change_work, smb2_status_change_work);
+
+	rc = (chip->batt_info->voltage_max_design_uv - 3487500) / 7500 + 1;
+	rc = regmap_update_bits(chip->regmap,
+				chip->base + FLOAT_VOLTAGE_CFG,
+				FLOAT_VOLTAGE_SETTING_MASK,
+				rc);
+	if (rc < 0)
+		return dev_err_probe(chip->dev, rc, "Couldn't set vbat max\n");
+
+	platform_set_drvdata(pdev, chip);
+
+	/* Initialise charger state */
+	schedule_delayed_work(&chip->status_change_work,
+			      msecs_to_jiffies(1000));
+
+	return 0;
+}
+
+static const struct of_device_id smb2_match_id_table[] = {
+	{ .compatible = "qcom,pmi8998-charger" },
+	{ .compatible = "qcom,pm660-charger" },
+	{ /* sentinal */ }
+};
+MODULE_DEVICE_TABLE(of, smb2_match_id_table);
+
+static struct platform_driver qcom_spmi_smb2 = {
+	.probe = smb2_probe,
+	.driver = {
+			.name = "qcom-pmi8998-charger",
+			.of_match_table = smb2_match_id_table,
+		},
+};
+
+module_platform_driver(qcom_spmi_smb2);
+
+MODULE_AUTHOR("Caleb Connolly <caleb.connolly@linaro.org>");
+MODULE_DESCRIPTION("Qualcomm SMB2 Charger Driver");
+MODULE_LICENSE("GPL");
-- 
2.36.0

