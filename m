Return-Path: <linux-pm+bounces-34840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874C1B7E1FE
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51C42A4716
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 10:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4783835A299;
	Wed, 17 Sep 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sap60pkr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543431B821;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104131; cv=none; b=b9j3Pc51K72CZcgxsXS374EpmkRUtGA8R+a0bzRXcdGGqTBonM74ldv0QkZzGIJ7DPRyxO+2E8y5xLgB1LIwZg6Te1sP7YbPV3SOvofWu2vprM70DBG1hvn+xDJQuYk4Km0ELfWGH9KRLhryuYECE4vCTZIp8sGIg6PCejQQWvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104131; c=relaxed/simple;
	bh=abX2lkK/naqt5m2SiBvhX1liqLhyoC6tFHR95sZXKZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bpljDBbjZ4d94bzcsswk19WojkIh2pV1rMCN+87p3Y8XoZ3zz/5G2OtWoVU+Q6zN6zG+oxJgP+YOsSKe6kWE8Iyooc1QYdYQb6e/FKDLu+pvwrEY5+CneqbVsZZqXzuo2dKctPbo97rIXMtUwjXdqMEFqu2+t/F2FWcQj1xKm0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sap60pkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87289C4CEFB;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104130;
	bh=abX2lkK/naqt5m2SiBvhX1liqLhyoC6tFHR95sZXKZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Sap60pkr6h3aNIDO1BYl8Ok7SXTfZ8XN6kQSMx+RCiKq7piqHIr9r8Pwphq2zPGCX
	 DB4rZoIp024apzoMjzVFAVTOY0BtgjFCQzuiIWa3mKliLQFDprlunTQigj4Tdz2nwo
	 /AqimnbLgNJga05VAmP+NV2rnqguP2Bl0hRzkgUN6T6ahHhyFulTT0Ont0T2ixpo6p
	 b/b2RKwJX1mjjACqrjT2/sEJH3ixTgeC+bLxqsswSdgyIem2ClPIoRYkPNVnN1Pe0B
	 2ATzFVdyJr9u+V+nEPEke019UkHV6AMDwBOxCUODie2QNml5hE+ASMARLTKjdfSkfG
	 m+mXbTHIGW8ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E04CA0EE8;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Wed, 17 Sep 2025 18:15:20 +0800
Subject: [PATCH v5 7/9] power: supply: qcom_battmgr: Add charge control
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-qcom_battmgr_update-v5-7-270ade9ffe13@oss.qualcomm.com>
References: <20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com>
In-Reply-To: <20250917-qcom_battmgr_update-v5-0-270ade9ffe13@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, 
 =?utf-8?q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758104128; l=14635;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=jzSCE05POFXfIP7n7nMn80KBdyQaeAna7NpNfboIVy4=;
 b=YbjkIyRevfanQJC4HpYCPt0870qCoALmSSCCxKiNTz+OiD4KYR8ZRvoiy4vzIXfT/9vAjm+w/
 VQZ+4ISzPSkABNP009oOfJeMAA+j0lzD/Gqc5IdHDfoKeTXSUc2vXeR
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add charge control support for SM8550 and X1E80100. It's supported
with below two power supply properties:

charge_control_end_threshold: The battery SoC (State of Charge)
threshold at which the charging should be terminated.

charge_control_start_threshold: The battery SoC threshold at
which the charging should be resumed.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 275 +++++++++++++++++++++++++++++++++++-
 1 file changed, 273 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index c4144839b2989d92085e605c96d7a71918d3d737..151cd5618ca5c70f941245e4df5a18d4778f1349 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -7,6 +7,7 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of_device.h>
 #include <linux/power_supply.h>
 #include <linux/property.h>
@@ -68,6 +69,9 @@ enum qcom_battmgr_variant {
 #define BATT_RESISTANCE			21
 #define BATT_POWER_NOW			22
 #define BATT_POWER_AVG			23
+#define BATT_CHG_CTRL_EN		24
+#define BATT_CHG_CTRL_START_THR		25
+#define BATT_CHG_CTRL_END_THR		26
 
 #define BATTMGR_USB_PROPERTY_GET	0x32
 #define BATTMGR_USB_PROPERTY_SET	0x33
@@ -92,6 +96,13 @@ enum qcom_battmgr_variant {
 #define WLS_TYPE			5
 #define WLS_BOOST_EN			6
 
+#define BATTMGR_CHG_CTRL_LIMIT_EN	0x48
+#define CHARGE_CTRL_START_THR_MIN	50
+#define CHARGE_CTRL_START_THR_MAX	95
+#define CHARGE_CTRL_END_THR_MIN		55
+#define CHARGE_CTRL_END_THR_MAX		100
+#define CHARGE_CTRL_DELTA_SOC		5
+
 struct qcom_battmgr_enable_request {
 	struct pmic_glink_hdr hdr;
 	__le32 battery_id;
@@ -126,6 +137,13 @@ struct qcom_battmgr_discharge_time_request {
 	__le32 reserved;
 };
 
+struct qcom_battmgr_charge_ctrl_request {
+	struct pmic_glink_hdr hdr;
+	__le32 enable;
+	__le32 target_soc;
+	__le32 delta_soc;
+};
+
 struct qcom_battmgr_message {
 	struct pmic_glink_hdr hdr;
 	union {
@@ -238,6 +256,8 @@ struct qcom_battmgr_info {
 	unsigned int capacity_warning;
 	unsigned int cycle_count;
 	unsigned int charge_count;
+	unsigned int charge_ctrl_start;
+	unsigned int charge_ctrl_end;
 	char model_number[BATTMGR_STRING_LEN];
 	char serial_number[BATTMGR_STRING_LEN];
 	char oem_info[BATTMGR_STRING_LEN];
@@ -426,6 +446,8 @@ static const u8 sm8350_bat_prop_map[] = {
 	[POWER_SUPPLY_PROP_INTERNAL_RESISTANCE] = BATT_RESISTANCE,
 	[POWER_SUPPLY_PROP_STATE_OF_HEALTH] = BATT_SOH,
 	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
+	[POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD] = BATT_CHG_CTRL_START_THR,
+	[POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD] = BATT_CHG_CTRL_END_THR,
 };
 
 static int qcom_battmgr_bat_sm8350_update(struct qcom_battmgr *battmgr,
@@ -602,6 +624,12 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_TIME_TO_FULL_AVG:
 		val->intval = battmgr->status.charge_time;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+		val->intval = battmgr->info.charge_ctrl_start;
+		break;
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		val->intval = battmgr->info.charge_ctrl_end;
+		break;
 	case POWER_SUPPLY_PROP_MANUFACTURE_YEAR:
 		val->intval = battmgr->info.year;
 		break;
@@ -627,6 +655,149 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int qcom_battmgr_set_charge_control(struct qcom_battmgr *battmgr,
+					   u32 target_soc, u32 delta_soc)
+{
+	struct qcom_battmgr_charge_ctrl_request request = {
+		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
+		.hdr.type = cpu_to_le32(PMIC_GLINK_REQ_RESP),
+		.hdr.opcode = cpu_to_le32(BATTMGR_CHG_CTRL_LIMIT_EN),
+		.enable = cpu_to_le32(1),
+		.target_soc = cpu_to_le32(target_soc),
+		.delta_soc = cpu_to_le32(delta_soc),
+	};
+
+	return qcom_battmgr_request(battmgr, &request, sizeof(request));
+}
+
+static int qcom_battmgr_set_charge_start_threshold(struct qcom_battmgr *battmgr, int start_soc)
+{
+	u32 target_soc, delta_soc;
+	int ret;
+
+	if (start_soc < CHARGE_CTRL_START_THR_MIN ||
+	    start_soc > CHARGE_CTRL_START_THR_MAX) {
+		dev_err(battmgr->dev, "charge control start threshold exceed range: [%u - %u]\n",
+			CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
+		return -EINVAL;
+	}
+
+	/*
+	 * If the new start threshold is larger than the old end threshold,
+	 * move the end threshold one step (DELTA_SOC) after the new start
+	 * threshold.
+	 */
+	if (start_soc > battmgr->info.charge_ctrl_end) {
+		target_soc = start_soc + CHARGE_CTRL_DELTA_SOC;
+		target_soc = min_t(u32, target_soc, CHARGE_CTRL_END_THR_MAX);
+		delta_soc = target_soc - start_soc;
+		delta_soc = min_t(u32, delta_soc, CHARGE_CTRL_DELTA_SOC);
+	} else {
+		target_soc =  battmgr->info.charge_ctrl_end;
+		delta_soc = battmgr->info.charge_ctrl_end - start_soc;
+	}
+
+	mutex_lock(&battmgr->lock);
+	ret = qcom_battmgr_set_charge_control(battmgr, target_soc, delta_soc);
+	mutex_unlock(&battmgr->lock);
+	if (!ret) {
+		battmgr->info.charge_ctrl_start = start_soc;
+		battmgr->info.charge_ctrl_end = target_soc;
+	}
+
+	return 0;
+}
+
+static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, int end_soc)
+{
+	u32 delta_soc = CHARGE_CTRL_DELTA_SOC;
+	int ret;
+
+	if (end_soc < CHARGE_CTRL_END_THR_MIN ||
+	    end_soc > CHARGE_CTRL_END_THR_MAX) {
+		dev_err(battmgr->dev, "charge control end threshold exceed range: [%u - %u]\n",
+			CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
+		return -EINVAL;
+	}
+
+	if (battmgr->info.charge_ctrl_start && end_soc > battmgr->info.charge_ctrl_start)
+		delta_soc = end_soc - battmgr->info.charge_ctrl_start;
+
+	mutex_lock(&battmgr->lock);
+	ret = qcom_battmgr_set_charge_control(battmgr, end_soc, delta_soc);
+	mutex_unlock(&battmgr->lock);
+	if (!ret) {
+		battmgr->info.charge_ctrl_start = end_soc - delta_soc;
+		battmgr->info.charge_ctrl_end = end_soc;
+	}
+
+	return 0;
+}
+
+static int qcom_battmgr_charge_control_thresholds_init(struct qcom_battmgr *battmgr)
+{
+	int ret;
+	u8 en, end_soc, start_soc, delta_soc;
+
+	ret = nvmem_cell_read_u8(battmgr->dev->parent, "charge_limit_en", &en);
+	if (!ret && en != 0) {
+		ret = nvmem_cell_read_u8(battmgr->dev->parent, "charge_limit_end", &end_soc);
+		if (ret < 0)
+			return ret;
+
+		ret = nvmem_cell_read_u8(battmgr->dev->parent, "charge_limit_delta", &delta_soc);
+		if (ret < 0)
+			return ret;
+
+		if (delta_soc >= end_soc)
+			return -EINVAL;
+
+		start_soc = end_soc - delta_soc;
+		end_soc = clamp(end_soc, CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
+		start_soc = clamp(start_soc, CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
+
+		battmgr->info.charge_ctrl_start = start_soc;
+		battmgr->info.charge_ctrl_end = end_soc;
+	}
+
+	return 0;
+}
+
+static int qcom_battmgr_bat_is_writeable(struct power_supply *psy,
+					 enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		return 1;
+	default:
+		return 0;
+	}
+
+	return 0;
+}
+
+static int qcom_battmgr_bat_set_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 const union power_supply_propval *pval)
+{
+	struct qcom_battmgr *battmgr = power_supply_get_drvdata(psy);
+
+	if (!battmgr->service_up)
+		return -EAGAIN;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD:
+		return qcom_battmgr_set_charge_start_threshold(battmgr, pval->intval);
+	case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
+		return qcom_battmgr_set_charge_end_threshold(battmgr, pval->intval);
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const enum power_supply_property sc8280xp_bat_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -660,6 +831,43 @@ static const struct power_supply_desc sc8280xp_bat_psy_desc = {
 	.get_property = qcom_battmgr_bat_get_property,
 };
 
+static const enum power_supply_property x1e80100_bat_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_EMPTY,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
+	POWER_SUPPLY_PROP_ENERGY_FULL,
+	POWER_SUPPLY_PROP_ENERGY_EMPTY,
+	POWER_SUPPLY_PROP_ENERGY_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_MANUFACTURE_YEAR,
+	POWER_SUPPLY_PROP_MANUFACTURE_MONTH,
+	POWER_SUPPLY_PROP_MANUFACTURE_DAY,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
+};
+
+static const struct power_supply_desc x1e80100_bat_psy_desc = {
+	.name = "qcom-battmgr-bat",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = x1e80100_bat_props,
+	.num_properties = ARRAY_SIZE(x1e80100_bat_props),
+	.get_property = qcom_battmgr_bat_get_property,
+	.set_property = qcom_battmgr_bat_set_property,
+	.property_is_writeable = qcom_battmgr_bat_is_writeable,
+};
+
 static const enum power_supply_property sm8350_bat_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_HEALTH,
@@ -692,6 +900,42 @@ static const struct power_supply_desc sm8350_bat_psy_desc = {
 	.get_property = qcom_battmgr_bat_get_property,
 };
 
+static const enum power_supply_property sm8550_bat_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CHARGE_COUNTER,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
+	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
+	POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
+	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
+	POWER_SUPPLY_PROP_POWER_NOW,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD,
+	POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
+};
+
+static const struct power_supply_desc sm8550_bat_psy_desc = {
+	.name = "qcom-battmgr-bat",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.properties = sm8550_bat_props,
+	.num_properties = ARRAY_SIZE(sm8550_bat_props),
+	.get_property = qcom_battmgr_bat_get_property,
+	.set_property = qcom_battmgr_bat_set_property,
+	.property_is_writeable = qcom_battmgr_bat_is_writeable,
+};
+
 static int qcom_battmgr_ac_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
@@ -1088,6 +1332,9 @@ static void qcom_battmgr_sc8280xp_callback(struct qcom_battmgr *battmgr,
 	case BATTMGR_BAT_CHARGE_TIME:
 		battmgr->status.charge_time = le32_to_cpu(resp->time);
 		break;
+	case BATTMGR_CHG_CTRL_LIMIT_EN:
+		battmgr->error = 0;
+		break;
 	default:
 		dev_warn(battmgr->dev, "unknown message %#x\n", opcode);
 		break;
@@ -1201,6 +1448,12 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 		case BATT_POWER_NOW:
 			battmgr->status.power_now = le32_to_cpu(resp->intval.value);
 			break;
+		case BATT_CHG_CTRL_START_THR:
+			battmgr->info.charge_ctrl_start = le32_to_cpu(resp->intval.value);
+			break;
+		case BATT_CHG_CTRL_END_THR:
+			battmgr->info.charge_ctrl_end = le32_to_cpu(resp->intval.value);
+			break;
 		default:
 			dev_warn(battmgr->dev, "unknown property %#x\n", property);
 			break;
@@ -1283,6 +1536,7 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 		}
 		break;
 	case BATTMGR_REQUEST_NOTIFICATION:
+	case BATTMGR_CHG_CTRL_LIMIT_EN:
 		battmgr->error = 0;
 		break;
 	default:
@@ -1350,11 +1604,13 @@ static char *qcom_battmgr_battery[] = { "battery" };
 static int qcom_battmgr_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
+	const struct power_supply_desc *psy_desc;
 	struct power_supply_config psy_cfg_supply = {};
 	struct power_supply_config psy_cfg = {};
 	const struct of_device_id *match;
 	struct qcom_battmgr *battmgr;
 	struct device *dev = &adev->dev;
+	int ret;
 
 	battmgr = devm_kzalloc(dev, sizeof(*battmgr), GFP_KERNEL);
 	if (!battmgr)
@@ -1380,9 +1636,19 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	else
 		battmgr->variant = QCOM_BATTMGR_SM8350;
 
+	ret = qcom_battmgr_charge_control_thresholds_init(battmgr);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "failed to init battery charge control thresholds\n");
+
 	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
 	    battmgr->variant == QCOM_BATTMGR_X1E80100) {
-		battmgr->bat_psy = devm_power_supply_register(dev, &sc8280xp_bat_psy_desc, &psy_cfg);
+		if (battmgr->variant == QCOM_BATTMGR_X1E80100)
+			psy_desc = &x1e80100_bat_psy_desc;
+		else
+			psy_desc = &sc8280xp_bat_psy_desc;
+
+		battmgr->bat_psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
 		if (IS_ERR(battmgr->bat_psy))
 			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
 					     "failed to register battery power supply\n");
@@ -1402,7 +1668,12 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 			return dev_err_probe(dev, PTR_ERR(battmgr->wls_psy),
 					     "failed to register wireless charing power supply\n");
 	} else {
-		battmgr->bat_psy = devm_power_supply_register(dev, &sm8350_bat_psy_desc, &psy_cfg);
+		if (battmgr->variant == QCOM_BATTMGR_SM8550)
+			psy_desc = &sm8550_bat_psy_desc;
+		else
+			psy_desc = &sm8350_bat_psy_desc;
+
+		battmgr->bat_psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
 		if (IS_ERR(battmgr->bat_psy))
 			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
 					     "failed to register battery power supply\n");

-- 
2.34.1



