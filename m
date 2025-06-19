Return-Path: <linux-pm+bounces-29089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E4AAE0985
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 17:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454E05A6E93
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 14:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FB52264C1;
	Thu, 19 Jun 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQ4rIDwL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526C021ADA7
	for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344935; cv=none; b=B1xvBp38EAFqEMmXO3Z1W2C4TLwsxglZ7tRhOTqCXz6JhpPXD7YOFQ9CioYeOGb8nvpfmGKXqPnTROhk3BfqeXL8tPtVoc14EoAq2WCLwE+Ep+q7tsIgQ/joZiV1iTj+ySxRymLBdekhdTTe7KTEYCvelPdkWZVL7XwkQonYiM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344935; c=relaxed/simple;
	bh=Gh059vN04/yomWRamYHsFmOtOA8wZ9W9B2hhFqlEEeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SgGmeJIRublGOtfGm26EGYF9DjwRaAviFZsLfe3tS+15dUYyFp3wEytNO3vRrqAqNjSg0MOA/msdcYWmEHM7CXKgBPFnkLpXPWahBNPDy7BDzSjUv49JhinrSZVlIwuhC7mIfGXa5jVjR8xcZb9P0XGBJDNqBa1zhpIuo+c5Fp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yQ4rIDwL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450ce3a2dd5so7859465e9.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 07:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750344930; x=1750949730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPcmXvkL7pHBOkknQ/9IxvWMgzVk5GGr/MOGB3cvxGA=;
        b=yQ4rIDwLOcc2kCj3iXnV7qqxhZAecIE1L29o1erMJT7TKW5v7v8bnQGB1ogCzmJkSj
         SxDMVHZbj5ooSjfKcd7sRkxJm1qHSpx82V2pmI/RSRiBPQwmV4d1g65jdQ2p3AqYBc+J
         G2o/yfcK6av2M407z3jM89reQu9qon09CouEgrwyCoDkuV0nwfhZ4+i1JNA46Ui3ri/O
         PIY/a9ihXDTxPq+L5k8ZENAyhA3C6eKEzIEKLknJVd1OlrEOswbw2kCntIvv3uzse49t
         CZnb6Fb1ko/v23N4wSchHhRYOTTfBqJYlgk1lrzYcjJhF92DrBmZJ6KK++Cw23yvTbGB
         2nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344930; x=1750949730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPcmXvkL7pHBOkknQ/9IxvWMgzVk5GGr/MOGB3cvxGA=;
        b=Jg0THTsYCA4C4vql3WTDYFHXHAPrVsYmwtZv7Wexfim9I2QYcwhyoqBmV7SQjCZp9B
         xKmQuZN6SuAj6n1HLcRNpVb5Yoqv3F3SdtmFYT7u3H7BIhIr3br1b/7PdL7BNqx+v5ag
         wn/ZVjMI5imtr/8uiwpYi4GSOdNzHLjEgdzm7dh16nFHFu3vL/yhFrwlSxtvRY9HLxwx
         AH0Rs58hHbxiWRbG7p6uEqIXNcrZFjReSqxHnp2ou4ppqorQKM4+UtoAvnYsAzPH/nBD
         2YSSZQWNUC0OeKBl/LFF11cDwDHrdJVuuDQmYuDp5UGP8pb+4L1RKHLeIb9psi8xeNI6
         yyrA==
X-Forwarded-Encrypted: i=1; AJvYcCWrpmktXQfFU10sFjevTobnTnXZVLt1jrbKzlEHlGqHn+7lOWQwZI8eGx2BAaC6ce1kRGYboiHWoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwcDYhR9KPjdcl2RIhK4cb8GgmPl2tU/3WuiJ8H+9BHoRO+K/k
	CTUlDsZVqZy5DS7ZgOtex1e7AQwTiT9qSoCd49kHFYxsd4ujgIPZGwwq5rHO4WV+RfA=
X-Gm-Gg: ASbGncs9bGESdaItHea1B3q9Ug3RCrGBEPBt8MCT/Fmkva738ZhMoW4rACHnNTQSf5C
	oaDJe4L/qZCbpa55AwZo60TRJTOvrE9G/wenKZEQWtKx62vIaFK6es/byjUnh0GtKYYlQbxe+66
	KO6hlDsGATa2k36mTE+w/KDW5zjerGbZHUca9/6k/Ym65b462UKKwEAtDHURnXRaOLpppBf8Fa3
	3n4ttqYS9FRHMdRnn91vO8rhxG7e8hiO5ueV+7Z6Fmv3LBFlTb6HrCuE/A9T+Xs4Yjw3EneHcuN
	0z26kiZ1Nhvxej5K60N5+a8abnKLLPaqhEiNCMiMQo5FCQj44oPkYxKfU/rd8gRrIhmlxFecnen
	kbA4Jhpc2KdI=
X-Google-Smtp-Source: AGHT+IE2ObqWoDCMO8WviqKvQwMgcBj5iUuOl3ZkQ4kc42xVydoPY8Y2WHctsPtlsRAhnSDQeaAz2A==
X-Received: by 2002:a05:600c:1d06:b0:450:c20d:64c3 with SMTP id 5b1f17b1804b1-4533caad17fmr212544145e9.18.1750344929495;
        Thu, 19 Jun 2025 07:55:29 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm31343715e9.40.2025.06.19.07.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:28 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Jun 2025 16:55:17 +0200
Subject: [PATCH 09/11] power: supply: qcom_smbx: add smb5 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-smb2-smb5-support-v1-9-ac5dec51b6e1@linaro.org>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-hardening@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=21861;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Gh059vN04/yomWRamYHsFmOtOA8wZ9W9B2hhFqlEEeo=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoVCTSw0XXqPOjoSVAlw5euwE4kdZqsabuq12Kh
 GTDtshaV+yJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaFQk0gAKCRAFgzErGV9k
 tq+oEACNihkZDBZL+qvvHgDjmHHest6ymBW89XRVMVtHZE56OGjjlKeQI88rHfUH6//Pryg2lav
 lPaH0yVV7EK+9WcH6fCdP8O9ZkDcDNdXL4b5LF+fWnbi5JxPbgRXcDV++b4LO4AgWGLrkN6M5w+
 PjdhVluOnbPBLOTtzqYprCysQHuw3FYxFrMJYp7AnyDlkLxzgPWSRKL5runwoBoQI25IbEyVjCX
 N0LZ+1lPjcpMu6PbcwWc4JNJGltbLEzGnH4WViKKPzv5oT95iF00MWVwxu/VoXu3WV9je1Frxi6
 AAvsNgug5svuidKfuPqZ9y7yub/8bzAb/80UG+NKc7CceUcwGJGJOQQM323HQNcrXJrvstYjXfX
 CMc4P/6HIFFMb6HtJFYUW82j+dKJ+1U5OqBgxSv7j+rgdJA2RgAfNFsvawVffMGY6a041N0RZJK
 mePkQKJAjPAGqEi0PGjTi/P2HdURUBqOGbhSGFxm4JJg+Mxo+nyfu2VwtUX9WoaFBAnTv54if7T
 xZGO5/WHEaP6qiUi5u7NA5cE0hr41xvYYvF12Bgvr8R4Yg34m5LVPDFG8R53tRN8mDi1qFPWXdU
 MAdkb9JxLZOsQ/sCx9c9UCocaYRS+nT5aPuhtH2k52dPZRgNIut6HnAeHjDGW+XWDV02etqvDGT
 ZV9f6v5iwTHVHkQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

Introduce support for the SMB5 charger found on pm8150b and other more
modern Qualcomm SoCs.

SMB5 is largely similar to SMB2, with a few register differences. The
main difference is the new Type-C hardware block which some registers
are moved to.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/power/supply/qcom_smbx.c | 367 +++++++++++++++++++++++++++++++++------
 1 file changed, 314 insertions(+), 53 deletions(-)

diff --git a/drivers/power/supply/qcom_smbx.c b/drivers/power/supply/qcom_smbx.c
index 10ddd33a09599decb23c0f1ccd02fa9b56602543..d902f3f43548191d3d0310ce90e699918ed0f16f 100644
--- a/drivers/power/supply/qcom_smbx.c
+++ b/drivers/power/supply/qcom_smbx.c
@@ -22,18 +22,32 @@
 #include <linux/regmap.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+enum smb_generation {
+	SMB2,
+	SMB5,
+};
+
+#define SMB_REG_OFFSET(smb) (smb->gen == SMB2 ? 0x600 : 0x100)
+
 /* clang-format off */
 #define BATTERY_CHARGER_STATUS_1			0x06
 #define BATTERY_CHARGER_STATUS_MASK			GENMASK(2, 0)
 
 #define BATTERY_CHARGER_STATUS_2			0x07
-#define CHARGER_ERROR_STATUS_BAT_OV_BIT			BIT(5)
-#define BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT		BIT(3)
-#define BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT		BIT(2)
-#define BAT_TEMP_STATUS_TOO_HOT_BIT			BIT(1)
-#define BAT_TEMP_STATUS_TOO_COLD_BIT			BIT(0)
+#define SMB2_CHARGER_ERROR_STATUS_BAT_OV_BIT		BIT(5)
+#define SMB2_BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT	BIT(3)
+#define SMB2_BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT	BIT(2)
+#define SMB2_BAT_TEMP_STATUS_TOO_HOT_BIT		BIT(1)
+#define SMB5_CHARGER_ERROR_STATUS_BAT_OV_BIT		BIT(1)
+#define SMB2_BAT_TEMP_STATUS_TOO_COLD_BIT		BIT(0)
+
+#define BATTERY_CHARGER_STATUS_7			0x0D
+#define SMB5_BAT_TEMP_STATUS_HOT_SOFT_BIT		BIT(5)
+#define SMB5_BAT_TEMP_STATUS_COLD_SOFT_BIT		BIT(4)
+#define SMB5_BAT_TEMP_STATUS_TOO_HOT_BIT		BIT(3)
+#define SMB5_BAT_TEMP_STATUS_TOO_COLD_BIT		BIT(2)
 
 #define CHARGING_ENABLE_CMD				0x42
 #define CHARGING_ENABLE_CMD_BIT				BIT(0)
 
@@ -55,11 +69,14 @@
 
 #define FLOAT_VOLTAGE_CFG				0x70
 #define FLOAT_VOLTAGE_SETTING_MASK			GENMASK(7, 0)
 
-#define FG_UPDATE_CFG_2_SEL				0x7D
-#define SOC_LT_CHG_RECHARGE_THRESH_SEL_BIT		BIT(2)
-#define VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT		BIT(1)
+#define SMB2_FG_UPDATE_CFG_2_SEL			0x7D
+#define SMB2_SOC_LT_CHG_RECHARGE_THRESH_SEL_BIT		BIT(2)
+#define SMB2_VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT		BIT(1)
+
+#define SMB5_CHARGE_RCHG_SOC_THRESHOLD_CFG_REG		0x7D
+#define SMB5_CHARGE_RCHG_SOC_THRESHOLD_CFG_MASK		GENMASK(7, 0)
 
 #define OTG_CFG						0x153
 #define OTG_EN_SRC_CFG_BIT				BIT(1)
 
@@ -73,36 +90,46 @@
 #define CDP_CHARGER_BIT					BIT(2)
 #define OCP_CHARGER_BIT					BIT(1)
 #define SDP_CHARGER_BIT					BIT(0)
 
+#define USBIN_CMD_IL					0x340
+#define USBIN_SUSPEND_BIT				BIT(0)
+
 #define CMD_APSD					0x341
 #define APSD_RERUN_BIT					BIT(0)
 
+#define CMD_ICL_OVERRIDE				0x342
+#define ICL_OVERRIDE_BIT				BIT(0)
+
 #define TYPE_C_CFG					0x358
+#define APSD_START_ON_CC_BIT				BIT(7)
 #define FACTORY_MODE_DETECTION_EN_BIT			BIT(5)
 #define VCONN_OC_CFG_BIT				BIT(1)
 
 #define USBIN_OPTIONS_1_CFG				0x362
+#define AUTO_SRC_DETECT_BIT				BIT(3)
 #define HVDCP_EN_BIT					BIT(2)
 
+#define USBIN_LOAD_CFG					0x65
+#define ICL_OVERRIDE_AFTER_APSD_BIT			BIT(4)
+
 #define USBIN_ICL_OPTIONS				0x366
 #define USB51_MODE_BIT					BIT(1)
 #define USBIN_MODE_CHG_BIT				BIT(0)
 
 /* PMI8998 only */
 #define TYPE_C_INTRPT_ENB_SOFTWARE_CTRL			0x368
-#define VCONN_EN_SRC_BIT				BIT(4)
+#define SMB2_VCONN_EN_SRC_BIT				BIT(4)
 #define VCONN_EN_VALUE_BIT				BIT(3)
 #define TYPEC_POWER_ROLE_CMD_MASK			GENMASK(2, 0)
-#define UFP_EN_CMD_BIT					BIT(2)
-#define DFP_EN_CMD_BIT					BIT(1)
-#define TYPEC_DISABLE_CMD_BIT				BIT(0)
+#define SMB5_EN_SNK_ONLY_BIT				BIT(1)
 
 #define USBIN_CURRENT_LIMIT_CFG				0x370
 
 #define USBIN_AICL_OPTIONS_CFG				0x380
 #define SUSPEND_ON_COLLAPSE_USBIN_BIT			BIT(7)
 #define USBIN_AICL_START_AT_MAX_BIT			BIT(5)
+#define USBIN_AICL_PERIODIC_RERUN_EN_BIT		BIT(4)
 #define USBIN_AICL_ADC_EN_BIT				BIT(3)
 #define USBIN_AICL_EN_BIT				BIT(2)
 #define USBIN_HV_COLLAPSE_RESPONSE_BIT			BIT(1)
 #define USBIN_LV_COLLAPSE_RESPONSE_BIT			BIT(0)
@@ -113,15 +140,41 @@
 
 #define USBIN_CONT_AICL_THRESHOLD_CFG			0x384
 #define USBIN_CONT_AICL_THRESHOLD_CFG_MASK		GENMASK(5, 0)
 
-#define ICL_STATUS					0x607
+#define ICL_STATUS(smb)					(SMB_REG_OFFSET(smb) + 0x07)
 #define INPUT_CURRENT_LIMIT_MASK			GENMASK(7, 0)
 
-#define POWER_PATH_STATUS				0x60B
+#define POWER_PATH_STATUS(smb)				(SMB_REG_OFFSET(smb) + 0x0B)
 #define P_PATH_USE_USBIN_BIT				BIT(4)
 #define P_PATH_VALID_INPUT_POWER_SOURCE_STS_BIT		BIT(0)
 
+/* 0x5xx region is PM8150b only Type-C registers */
+
+/* Bits 2:0 match PMI8998 TYPE_C_INTRPT_ENB_SOFTWARE_CTRL */
+#define SMB5_TYPE_C_MODE_CFG				0x544
+#define SMB5_EN_TRY_SNK_BIT				BIT(4)
+#define SMB5_EN_SNK_ONLY_BIT				BIT(1)
+
+#define SMB5_TYPEC_TYPE_C_VCONN_CONTROL			0x546
+#define SMB5_VCONN_EN_ORIENTATION_BIT			BIT(2)
+#define SMB5_VCONN_EN_VALUE_BIT				BIT(1)
+#define SMB5_VCONN_EN_SRC_BIT				BIT(0)
+
+
+#define SMB5_TYPE_C_DEBUG_ACCESS_SINK			0x54a
+#define SMB5_TYPEC_DEBUG_ACCESS_SINK_MASK		GENMASK(4, 0)
+
+#define SMB5_DEBUG_ACCESS_SRC_CFG			0x54C
+#define SMB5_EN_UNORIENTED_DEBUG_ACCESS_SRC_BIT	BIT(0)
+
+#define SMB5_TYPE_C_EXIT_STATE_CFG			0x550
+#define SMB5_BYPASS_VSAFE0V_DURING_ROLE_SWAP_BIT	BIT(3)
+#define SMB5_SEL_SRC_UPPER_REF_BIT			BIT(2)
+#define SMB5_EXIT_SNK_BASED_ON_CC_BIT			BIT(0)
+
+/* Common */
+
 #define BARK_BITE_WDOG_PET				0x643
 #define BARK_BITE_WDOG_PET_BIT				BIT(0)
 
 #define WD_CFG						0x651
@@ -184,8 +237,9 @@ struct smb_chip {
 	const char *name;
 	unsigned int base;
 	struct regmap *regmap;
 	struct power_supply_battery_info *batt_info;
+	enum smb_generation gen;
 
 	struct delayed_work status_change_work;
 	int cable_irq;
 	bool wakeup_enabled;
@@ -195,8 +249,15 @@ struct smb_chip {
 
 	struct power_supply *chg_psy;
 };
 
+struct smb_match_data {
+	const char *name;
+	enum smb_generation gen;
+	size_t init_seq_len;
+	const struct smb_init_register __counted_by(init_seq_len) *init_seq;
+};
+
 static enum power_supply_property smb_properties[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_CURRENT_MAX,
@@ -212,9 +273,9 @@ static int smb_get_prop_usb_online(struct smb_chip *chip, int *val)
 {
 	unsigned int stat;
 	int rc;
 
-	rc = regmap_read(chip->regmap, chip->base + POWER_PATH_STATUS, &stat);
+	rc = regmap_read(chip->regmap, chip->base + POWER_PATH_STATUS(chip), &stat);
 	if (rc < 0) {
 		dev_err(chip->dev, "Couldn't read power path status: %d\n", rc);
 		return rc;
 	}
@@ -267,11 +328,37 @@ static int smb_apsd_get_charger_type(struct smb_chip *chip, int *val)
 
 	return 0;
 }
 
+/* Return 1 when in overvoltage state, else 0 or -errno */
+static int smbx_ov_status(struct smb_chip *chip)
+{
+	u16 reg;
+	u8 mask;
+	int rc;
+	u32 val;
+
+	switch (chip->gen) {
+	case SMB2:
+		reg = BATTERY_CHARGER_STATUS_2;
+		mask = SMB2_CHARGER_ERROR_STATUS_BAT_OV_BIT;
+		break;
+	case SMB5:
+		reg = BATTERY_CHARGER_STATUS_7;
+		mask = SMB5_CHARGER_ERROR_STATUS_BAT_OV_BIT;
+		break;
+	}
+
+	rc = regmap_read(chip->regmap, chip->base + reg, &val);
+	if (rc)
+		return rc;
+
+	return !!(reg & mask);
+}
+
 static int smb_get_prop_status(struct smb_chip *chip, int *val)
 {
-	unsigned char stat[2];
+	u32 stat;
 	int usb_online = 0;
 	int rc;
 
 	rc = smb_get_prop_usb_online(chip, &usb_online);
@@ -279,24 +366,29 @@ static int smb_get_prop_status(struct smb_chip *chip, int *val)
 		*val = POWER_SUPPLY_STATUS_DISCHARGING;
 		return rc;
 	}
 
-	rc = regmap_bulk_read(chip->regmap,
-			      chip->base + BATTERY_CHARGER_STATUS_1, &stat, 2);
+	rc = regmap_read(chip->regmap,
+			      chip->base + BATTERY_CHARGER_STATUS_1, &stat);
 	if (rc < 0) {
 		dev_err(chip->dev, "Failed to read charging status ret=%d\n",
 			rc);
 		return rc;
 	}
 
-	if (stat[1] & CHARGER_ERROR_STATUS_BAT_OV_BIT) {
+	rc = smbx_ov_status(chip);
+	if (rc < 0)
+		return rc;
+
+	/* In overvoltage state */
+	if (rc == 1) {
 		*val = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		return 0;
 	}
 
-	stat[0] = stat[0] & BATTERY_CHARGER_STATUS_MASK;
+	stat = stat & BATTERY_CHARGER_STATUS_MASK;
 
-	switch (stat[0]) {
+	switch (stat) {
 	case TRICKLE_CHARGE:
 	case PRE_CHARGE:
 	case FAST_CHARGE:
 	case FULLON_CHARGE:
@@ -318,9 +410,9 @@ static int smb_get_prop_status(struct smb_chip *chip, int *val)
 
 static inline int smb_get_current_limit(struct smb_chip *chip,
 					 unsigned int *val)
 {
-	int rc = regmap_read(chip->regmap, chip->base + ICL_STATUS, val);
+	int rc = regmap_read(chip->regmap, chip->base + ICL_STATUS(chip), val);
 
 	if (rc >= 0)
 		*val *= CURRENT_SCALE_FACTOR;
 	return rc;
@@ -413,9 +505,46 @@ static int smb_get_iio_chan(struct smb_chip *chip, struct iio_channel *chan,
 
 	return iio_read_channel_processed(chan, val);
 }
 
-static int smb_get_prop_health(struct smb_chip *chip, int *val)
+static int smb5_get_prop_health(struct smb_chip *chip, int *val)
+{
+	int rc;
+	unsigned int stat;
+
+	rc = smbx_ov_status(chip);
+
+	/* Treat any error as if we are in the overvoltage state */
+	if (rc < 0)
+		dev_err(chip->dev, "Couldn't determine overvoltage status!");
+	if (rc) {
+		dev_err(chip->dev, "battery over-voltage");
+		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
+		return 0;
+	}
+
+	rc = regmap_read(chip->regmap, chip->base + BATTERY_CHARGER_STATUS_7,
+			 &stat);
+	if (rc < 0) {
+		dev_err(chip->dev, "Couldn't read charger status 7 rc=%d\n", rc);
+		return rc;
+	}
+
+	if (stat & SMB5_BAT_TEMP_STATUS_TOO_COLD_BIT)
+		*val = POWER_SUPPLY_HEALTH_COLD;
+	else if (stat & SMB5_BAT_TEMP_STATUS_TOO_HOT_BIT)
+		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
+	else if (stat & SMB5_BAT_TEMP_STATUS_COLD_SOFT_BIT)
+		*val = POWER_SUPPLY_HEALTH_COOL;
+	else if (stat & SMB5_BAT_TEMP_STATUS_HOT_SOFT_BIT)
+		*val = POWER_SUPPLY_HEALTH_WARM;
+	else
+		*val = POWER_SUPPLY_HEALTH_GOOD;
+
+	return 0;
+}
+
+static int smb2_get_prop_health(struct smb_chip *chip, int *val)
 {
 	int rc;
 	unsigned int stat;
 
@@ -426,34 +555,45 @@ static int smb_get_prop_health(struct smb_chip *chip, int *val)
 		return rc;
 	}
 
 	switch (stat) {
-	case CHARGER_ERROR_STATUS_BAT_OV_BIT:
+	case SMB2_CHARGER_ERROR_STATUS_BAT_OV_BIT:
 		*val = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		return 0;
-	case BAT_TEMP_STATUS_TOO_COLD_BIT:
+	case SMB2_BAT_TEMP_STATUS_TOO_COLD_BIT:
 		*val = POWER_SUPPLY_HEALTH_COLD;
 		return 0;
-	case BAT_TEMP_STATUS_TOO_HOT_BIT:
+	case SMB2_BAT_TEMP_STATUS_TOO_HOT_BIT:
 		*val = POWER_SUPPLY_HEALTH_OVERHEAT;
 		return 0;
-	case BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT:
+	case SMB2_BAT_TEMP_STATUS_COLD_SOFT_LIMIT_BIT:
 		*val = POWER_SUPPLY_HEALTH_COOL;
 		return 0;
-	case BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT:
+	case SMB2_BAT_TEMP_STATUS_HOT_SOFT_LIMIT_BIT:
 		*val = POWER_SUPPLY_HEALTH_WARM;
 		return 0;
 	default:
 		*val = POWER_SUPPLY_HEALTH_GOOD;
 		return 0;
 	}
 }
 
+static int smb_get_prop_health(struct smb_chip *chip, int *val)
+{
+	switch (chip->gen) {
+	case SMB2:
+		return smb2_get_prop_health(chip, val);
+	case SMB5:
+		return smb5_get_prop_health(chip, val);
+	}
+}
+
 static int smb_get_property(struct power_supply *psy,
 			     enum power_supply_property psp,
 			     union power_supply_propval *val)
 {
 	struct smb_chip *chip = power_supply_get_drvdata(psy);
+	int ret;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_MANUFACTURER:
 		val->strval = "Qualcomm";
@@ -466,10 +606,15 @@ static int smb_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		return smb_get_iio_chan(chip, chip->usb_in_i_chan,
 					 &val->intval);
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		return smb_get_iio_chan(chip, chip->usb_in_v_chan,
+		ret = smb_get_iio_chan(chip, chip->usb_in_v_chan,
 					 &val->intval);
+		if (!ret) {
+			if (chip->gen == SMB5)
+				val->intval *= 16;
+		}
+		return ret;
 	case POWER_SUPPLY_PROP_ONLINE:
 		return smb_get_prop_usb_online(chip, &val->intval);
 	case POWER_SUPPLY_PROP_STATUS:
 		return smb_get_prop_status(chip, &val->intval);
@@ -515,14 +660,10 @@ static int smb_property_is_writable(struct power_supply *psy,
 
 static irqreturn_t smb_handle_batt_overvoltage(int irq, void *data)
 {
 	struct smb_chip *chip = data;
-	unsigned int status;
 
-	regmap_read(chip->regmap, chip->base + BATTERY_CHARGER_STATUS_2,
-		    &status);
-
-	if (status & CHARGER_ERROR_STATUS_BAT_OV_BIT) {
+	if (smbx_ov_status(chip) == 1) {
 		/* The hardware stops charging automatically */
 		dev_err(chip->dev, "battery overvoltage detected\n");
 		power_supply_changed(chip->chg_psy);
 	}
@@ -566,9 +707,9 @@ static irqreturn_t smb_handle_wdog_bark(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
 static const struct power_supply_desc smb_psy_desc = {
-	.name = "pmi8998_charger",
+	.name = "SMB2_charger",
 	.type = POWER_SUPPLY_TYPE_USB,
 	.usb_types = BIT(POWER_SUPPLY_USB_TYPE_SDP) |
 		     BIT(POWER_SUPPLY_USB_TYPE_CDP) |
 		     BIT(POWER_SUPPLY_USB_TYPE_DCP) |
@@ -580,18 +721,100 @@ static const struct power_supply_desc smb_psy_desc = {
 	.property_is_writeable = smb_property_is_writable,
 };
 
 /* Init sequence derived from vendor downstream driver */
-static const struct smb_init_register smb_init_seq[] = {
-	{ .addr = AICL_RERUN_TIME_CFG, .mask = AICL_RERUN_TIME_MASK, .val = 0 },
+static const struct smb_init_register smb5_init_seq[] = {
+	{ .addr = USBIN_CMD_IL, .mask = USBIN_SUSPEND_BIT, .val = 0 },
+	/*
+	 * By default configure us as an upstream facing port
+	 * FIXME: This will be handled by the type-c driver
+	 */
+	{ .addr = SMB5_TYPE_C_MODE_CFG,
+	  .mask = SMB5_EN_TRY_SNK_BIT | SMB5_EN_SNK_ONLY_BIT,
+	  .val = SMB5_EN_TRY_SNK_BIT },
+	{ .addr = SMB5_TYPEC_TYPE_C_VCONN_CONTROL,
+	  .mask = SMB5_VCONN_EN_ORIENTATION_BIT | SMB5_VCONN_EN_SRC_BIT |
+		  SMB5_VCONN_EN_VALUE_BIT,
+	  .val = SMB2_VCONN_EN_SRC_BIT },
+	{ .addr = SMB5_DEBUG_ACCESS_SRC_CFG,
+	  .mask = SMB5_EN_UNORIENTED_DEBUG_ACCESS_SRC_BIT,
+	  .val = SMB5_EN_UNORIENTED_DEBUG_ACCESS_SRC_BIT },
+	{ .addr = SMB5_TYPE_C_EXIT_STATE_CFG,
+	  .mask = SMB5_SEL_SRC_UPPER_REF_BIT,
+	  .val = SMB5_SEL_SRC_UPPER_REF_BIT },
+	/*
+	 * Disable Type-C factory mode and stay in Attached.SRC state when VCONN
+	 * over-current happens
+	 */
+	{ .addr = TYPE_C_CFG,
+	  .mask = APSD_START_ON_CC_BIT,
+	  .val = 0 },
+	{ .addr = SMB5_TYPE_C_DEBUG_ACCESS_SINK,
+	  .mask = SMB5_TYPEC_DEBUG_ACCESS_SINK_MASK,
+	  .val = 0x17 },
+	/* Configure VBUS for software control */
+	{ .addr = OTG_CFG, .mask = OTG_EN_SRC_CFG_BIT, .val = 0 },
+	/*
+	 * Recharge when State Of Charge drops below 98%.
+	 */
+	{ .addr = SMB5_CHARGE_RCHG_SOC_THRESHOLD_CFG_REG,
+	  .mask = SMB5_CHARGE_RCHG_SOC_THRESHOLD_CFG_MASK,
+	  .val = 250 },
+	/* Enable charging */
+	{ .addr = CHARGING_ENABLE_CMD,
+	  .mask = CHARGING_ENABLE_CMD_BIT,
+	  .val = CHARGING_ENABLE_CMD_BIT },
+	/* Enable BC1P2 auto Src detect */
+	{ .addr = USBIN_OPTIONS_1_CFG,
+	  .mask = AUTO_SRC_DETECT_BIT,
+	  .val = AUTO_SRC_DETECT_BIT },
+	/* Set the default SDP charger type to a 500ma USB 2.0 port */
+	{ .addr = USBIN_ICL_OPTIONS,
+	  .mask = USBIN_MODE_CHG_BIT,
+	  .val = USBIN_MODE_CHG_BIT },
+	{ .addr = CMD_ICL_OVERRIDE,
+	  .mask = ICL_OVERRIDE_BIT,
+	  .val = 0 },
+	{ .addr = USBIN_LOAD_CFG,
+	  .mask = ICL_OVERRIDE_AFTER_APSD_BIT,
+	  .val = 0 },
+	/* Disable watchdog */
+	{ .addr = SNARL_BARK_BITE_WD_CFG, .mask = 0xff, .val = 0 },
+	{ .addr = WD_CFG,
+	  .mask = WATCHDOG_TRIGGER_AFP_EN_BIT | WDOG_TIMER_EN_ON_PLUGIN_BIT |
+		  BARK_WDOG_INT_EN_BIT,
+	  .val = 0 },
+	/*
+	 * Enable Automatic Input Current Limit, this will slowly ramp up the current
+	 * When connected to a wall charger, and automatically stop when it detects
+	 * the charger current limit (voltage drop?) or it reaches the programmed limit.
+	 */
+	{ .addr = USBIN_AICL_OPTIONS_CFG,
+	  .mask = USBIN_AICL_PERIODIC_RERUN_EN_BIT | USBIN_AICL_ADC_EN_BIT
+			| USBIN_AICL_EN_BIT | SUSPEND_ON_COLLAPSE_USBIN_BIT,
+	  .val = USBIN_AICL_PERIODIC_RERUN_EN_BIT | USBIN_AICL_ADC_EN_BIT
+			| USBIN_AICL_EN_BIT | SUSPEND_ON_COLLAPSE_USBIN_BIT },
+	/*
+	 * This overrides all of the other current limit configs and is
+	 * expected to be used for setting limits based on temperature.
+	 * We set some relatively safe default value while still allowing
+	 * a comfortably fast charging rate.
+	 */
+	{ .addr = FAST_CHARGE_CURRENT_CFG,
+	  .mask = FAST_CHARGE_CURRENT_SETTING_MASK,
+	  .val = 1950000 / CURRENT_SCALE_FACTOR },
+};
+
+/* Init sequence derived from vendor downstream driver */
+static const struct smb_init_register smb2_init_seq[] = {
 	/*
 	 * By default configure us as an upstream facing port
 	 * FIXME: This will be handled by the type-c driver
 	 */
 	{ .addr = TYPE_C_INTRPT_ENB_SOFTWARE_CTRL,
-	  .mask = TYPEC_POWER_ROLE_CMD_MASK | VCONN_EN_SRC_BIT |
+	  .mask = TYPEC_POWER_ROLE_CMD_MASK | SMB2_VCONN_EN_SRC_BIT |
 		  VCONN_EN_VALUE_BIT,
-	  .val = VCONN_EN_SRC_BIT },
+	  .val = SMB2_VCONN_EN_SRC_BIT },
 	/*
 	 * Disable Type-C factory mode and stay in Attached.SRC state when VCONN
 	 * over-current happens
 	 */
@@ -603,12 +826,12 @@ static const struct smb_init_register smb_init_seq[] = {
 	/*
 	 * Use VBAT to determine the recharge threshold when battery is full
 	 * rather than the state of charge.
 	 */
-	{ .addr = FG_UPDATE_CFG_2_SEL,
-	  .mask = SOC_LT_CHG_RECHARGE_THRESH_SEL_BIT |
-		  VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT,
-	  .val = VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT },
+	{ .addr = SMB2_FG_UPDATE_CFG_2_SEL,
+	  .mask = SMB2_SOC_LT_CHG_RECHARGE_THRESH_SEL_BIT |
+		  SMB2_VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT,
+	  .val = SMB2_VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT },
 	/* Enable charging */
 	{ .addr = USBIN_OPTIONS_1_CFG, .mask = HVDCP_EN_BIT, .val = 0 },
 	{ .addr = CHARGING_ENABLE_CMD,
 	  .mask = CHARGING_ENABLE_CMD_BIT,
@@ -674,19 +897,48 @@ static const struct smb_init_register smb_init_seq[] = {
 	  .mask = PRE_CHARGE_CURRENT_SETTING_MASK,
 	  .val = 500000 / CURRENT_SCALE_FACTOR },
 };
 
-static int smb_init_hw(struct smb_chip *chip)
+struct smb_match_data pmi8998_match_data = {
+	.init_seq = smb2_init_seq,
+	.init_seq_len = ARRAY_SIZE(smb2_init_seq),
+	.name = "pmi8998",
+	.gen = SMB2,
+};
+
+struct smb_match_data pm660_match_data = {
+	.init_seq = smb2_init_seq,
+	.init_seq_len = ARRAY_SIZE(smb2_init_seq),
+	.name = "pm660",
+	.gen = SMB2,
+};
+
+struct smb_match_data pm8150b_match_data = {
+	.init_seq = smb5_init_seq,
+	.init_seq_len = ARRAY_SIZE(smb5_init_seq),
+	.name = "pm8150b",
+	.gen = SMB5,
+};
+
+struct smb_match_data pm7250b_match_data = {
+	.init_seq = smb5_init_seq,
+	.init_seq_len = ARRAY_SIZE(smb5_init_seq),
+	.name = "pm7250b",
+	.gen = SMB5,
+};
+
+
+static int smb_init_hw(struct smb_chip *chip, const struct smb_init_register *init_seq, size_t len)
 {
 	int rc, i;
 
-	for (i = 0; i < ARRAY_SIZE(smb_init_seq); i++) {
+	for (i = 0; i < len; i++) {
 		dev_dbg(chip->dev, "%d: Writing 0x%02x to 0x%02x\n", i,
-			smb_init_seq[i].val, smb_init_seq[i].addr);
+			init_seq[i].val, init_seq[i].addr);
 		rc = regmap_update_bits(chip->regmap,
-					chip->base + smb_init_seq[i].addr,
-					smb_init_seq[i].mask,
-					smb_init_seq[i].val);
+					chip->base + init_seq[i].addr,
+					init_seq[i].mask,
+					init_seq[i].val);
 		if (rc < 0)
 			return dev_err_probe(chip->dev, rc,
 					     "%s: init command %d failed\n",
 					     __func__, i);
@@ -721,8 +973,9 @@ static int smb_probe(struct platform_device *pdev)
 {
 	struct power_supply_config supply_config = {};
 	struct power_supply_desc *desc;
 	struct smb_chip *chip;
+	const struct smb_match_data *match_data;
 	int rc, irq;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -751,9 +1004,15 @@ static int smb_probe(struct platform_device *pdev)
 		return dev_err_probe(chip->dev, PTR_ERR(chip->usb_in_i_chan),
 				     "Couldn't get usbin_i IIO channel\n");
 	}
 
-	rc = smb_init_hw(chip);
+	match_data = (const struct smb_match_data *)device_get_match_data(chip->dev);
+
+	chip->gen = match_data->gen;
+
+	dev_info(chip->dev, "Generation %s\n", chip->gen == SMB2 ? "SMB2" : "SMB5");
+
+	rc = smb_init_hw(chip, match_data->init_seq, match_data->init_seq_len);
 	if (rc < 0)
 		return rc;
 
 	supply_config.drv_data = chip;
@@ -764,9 +1023,9 @@ static int smb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	memcpy(desc, &smb_psy_desc, sizeof(smb_psy_desc));
 	desc->name =
 		devm_kasprintf(chip->dev, GFP_KERNEL, "%s-charger",
-			       (const char *)device_get_match_data(chip->dev));
+			       match_data->name);
 	if (!desc->name)
 		return -ENOMEM;
 
 	chip->chg_psy =
@@ -839,10 +1098,12 @@ static int smb_probe(struct platform_device *pdev)
 	return 0;
 }
 
 static const struct of_device_id smb_match_id_table[] = {
-	{ .compatible = "qcom,pmi8998-charger", .data = "pmi8998" },
-	{ .compatible = "qcom,pm660-charger", .data = "pm660" },
+	{ .compatible = "qcom,pmi8998-charger", .data = &pmi8998_match_data },
+	{ .compatible = "qcom,pm660-charger", .data = &pm660_match_data },
+	{ .compatible = "qcom,pm7250b-charger", .data = &pm7250b_match_data },
+	{ .compatible = "qcom,pm8150b-charger", .data = &pm8150b_match_data },
 	{ /* sentinal */ }
 };
 MODULE_DEVICE_TABLE(of, smb_match_id_table);
 

-- 
2.49.0


