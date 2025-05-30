Return-Path: <linux-pm+bounces-27835-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D379AC890B
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 09:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152601BA4FBB
	for <lists+linux-pm@lfdr.de>; Fri, 30 May 2025 07:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F171219313;
	Fri, 30 May 2025 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiogAM7F"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0220E6E2;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748590541; cv=none; b=k3BwIvfX8UWfInwu0xyi9e2/TcF/LpbHiEbjjGUZDxupG0/txZdp63Qg8BXUbVzlb6WNZ1z7bybz5wToDg5GnMkDtJy6oxgqsaXaD2ccZsPPcRRIfMpJpw09RVKa9TlaZAxd9DwnLxxbuc+m+wBzgI67WHr2fuxCqpRaXAkthUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748590541; c=relaxed/simple;
	bh=I7vVj46X/TuoUOXGqkLDn4CTbOSzY+ii6ETEXV21OWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lWzocu4ZofT31MUmWoYrHC2H+uimUw+fIS6hEw798fTYOuEB9gUt1HyHwXb3Duk9GEDr1EsE1PKb5LL9EwD93WXgfoXV0NWg49FcO44JFCI6e1W7fv6aTfm5Xmpy826fzbwgMTy5WrH54/6wNI2ORnOnG5Lj0EO7vdQ22bqYp04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiogAM7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F612C4CEFE;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748590540;
	bh=I7vVj46X/TuoUOXGqkLDn4CTbOSzY+ii6ETEXV21OWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kiogAM7F0GtVQYSg9zuMLBIO6UT8ojpJE4nsMs9+5nsnceDPB3HNceP+OvI5O0+M0
	 yYvrqL6jAKqTtHlrD6TSgapnEN7WRP1DQKf+47d/l7HI7bC1NRvvuzCdZ//4DoQaTA
	 sCsPAv4SrChe+neiB9l1UsWVC6UIOoedw6+yrFxOYdI23bOu/glZtO65Qp7xLhExhS
	 t1mWBNjUPNhnLQZ5Ndy8SxuEsPvms0Ige3/moZLfiYQAz4XDbBtIr3WaWysvckn/Pm
	 DHN8RJIy3VnAq/mHZkcBWwOOaLoF0WSUSz4oFFdtOmoto1rpuysVGFN28amjKwDoYu
	 kM6/1nfl4ugbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F4BC5B552;
	Fri, 30 May 2025 07:35:40 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Fri, 30 May 2025 15:35:10 +0800
Subject: [PATCH v2 5/8] power: supply: qcom_battmgr: Add charge control
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-qcom_battmgr_update-v2-5-9e377193a656@oss.qualcomm.com>
References: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
In-Reply-To: <20250530-qcom_battmgr_update-v2-0-9e377193a656@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748590538; l=15139;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=+5w/EErdc8TWh1g3OZvOJrj0YAdsZWrwlcTfLxAzT/I=;
 b=aAVh7Q+5p3k0PvL0/5dpHNGGbe9kF3HC7LA5G5G/LDDL6Q/RZVcrPIq8MF64oC9ilwZkjonMc
 2d4b/2o0qBSDxQiC0NEng3khT+fw9cOBtw4mkBcUz3rYY98nSt0khCY
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add charge control support for SM8550 and X1E80100. It's supported
with below two power supply properties:

charge_control_end_threshold: SOC threshold at which the charging
should be terminated.

charge_control_start_threshold: SOC threshold at which the charging
should be resumed.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 256 ++++++++++++++++++++++++++++++++++--
 1 file changed, 248 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index d5d0200b92bdc3d9a22f44159ad45b152efe8be0..39009415f4bfcd76b010305179d3c8fb847254a6 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -21,6 +21,8 @@
 enum qcom_battmgr_variant {
 	QCOM_BATTMGR_SM8350,
 	QCOM_BATTMGR_SC8280XP,
+	QCOM_BATTMGR_X1E80100,
+	QCOM_BATTMGR_SM8550,
 };
 
 #define BATTMGR_BAT_STATUS		0x1
@@ -66,6 +68,9 @@ enum qcom_battmgr_variant {
 #define BATT_RESISTANCE			21
 #define BATT_POWER_NOW			22
 #define BATT_POWER_AVG			23
+#define BATT_CHG_CTRL_EN		24
+#define BATT_CHG_CTRL_START_THR		25
+#define BATT_CHG_CTRL_END_THR		26
 
 #define BATTMGR_USB_PROPERTY_GET	0x32
 #define BATTMGR_USB_PROPERTY_SET	0x33
@@ -90,6 +95,13 @@ enum qcom_battmgr_variant {
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
@@ -124,6 +136,13 @@ struct qcom_battmgr_discharge_time_request {
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
@@ -236,6 +255,8 @@ struct qcom_battmgr_info {
 	unsigned int capacity_warning;
 	unsigned int cycle_count;
 	unsigned int charge_count;
+	unsigned int charge_ctrl_start;
+	unsigned int charge_ctrl_end;
 	char model_number[BATTMGR_STRING_LEN];
 	char serial_number[BATTMGR_STRING_LEN];
 	char oem_info[BATTMGR_STRING_LEN];
@@ -424,6 +445,8 @@ static const u8 sm8350_bat_prop_map[] = {
 	[POWER_SUPPLY_PROP_RESISTANCE] = BATT_RESISTANCE,
 	[POWER_SUPPLY_PROP_STATE_OF_HEALTH] = BATT_SOH,
 	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
+	[POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD] = BATT_CHG_CTRL_START_THR,
+	[POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD] = BATT_CHG_CTRL_END_THR,
 };
 
 static int qcom_battmgr_bat_sm8350_update(struct qcom_battmgr *battmgr,
@@ -494,7 +517,8 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
 	if (!battmgr->service_up)
 		return -EAGAIN;
 
-	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+			battmgr->variant == QCOM_BATTMGR_X1E80100)
 		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
 	else
 		ret = qcom_battmgr_bat_sm8350_update(battmgr, psp);
@@ -599,6 +623,12 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
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
@@ -624,6 +654,120 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
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
+static int qcom_battmgr_set_charge_start_threshold(struct qcom_battmgr *battmgr, int soc)
+{
+	u32 target_soc, delta_soc;
+	int ret;
+
+	if (soc < CHARGE_CTRL_START_THR_MIN ||
+			soc > CHARGE_CTRL_START_THR_MAX) {
+		dev_err(battmgr->dev, "charge control start threshold exceed range: [%u - %u]\n",
+				CHARGE_CTRL_START_THR_MIN, CHARGE_CTRL_START_THR_MAX);
+		return -EINVAL;
+	}
+
+	/*
+	 * If the new start threshold is larger than the old end threshold,
+	 * move the end threshold one step (DELTA_SOC) after the new start
+	 * threshold.
+	 */
+	if (soc > battmgr->info.charge_ctrl_end) {
+		target_soc = soc + CHARGE_CTRL_DELTA_SOC;
+		target_soc = min_t(u32, target_soc, CHARGE_CTRL_END_THR_MAX);
+		delta_soc = target_soc - soc;
+		delta_soc = min_t(u32, delta_soc, CHARGE_CTRL_DELTA_SOC);
+	} else {
+		target_soc =  battmgr->info.charge_ctrl_end;
+		delta_soc = battmgr->info.charge_ctrl_end - soc;
+	}
+
+	mutex_lock(&battmgr->lock);
+	ret = qcom_battmgr_set_charge_control(battmgr, target_soc, delta_soc);
+	mutex_unlock(&battmgr->lock);
+	if (!ret) {
+		battmgr->info.charge_ctrl_start = soc;
+		battmgr->info.charge_ctrl_end = target_soc;
+	}
+
+	return 0;
+}
+
+static int qcom_battmgr_set_charge_end_threshold(struct qcom_battmgr *battmgr, int soc)
+{
+	u32 delta_soc = CHARGE_CTRL_DELTA_SOC;
+	int ret;
+
+	if (soc < CHARGE_CTRL_END_THR_MIN ||
+			soc > CHARGE_CTRL_END_THR_MAX) {
+		dev_err(battmgr->dev, "charge control end threshold exceed range: [%u - %u]\n",
+				CHARGE_CTRL_END_THR_MIN, CHARGE_CTRL_END_THR_MAX);
+		return -EINVAL;
+	}
+
+	if (battmgr->info.charge_ctrl_start && soc > battmgr->info.charge_ctrl_start)
+		delta_soc = soc - battmgr->info.charge_ctrl_start;
+
+	mutex_lock(&battmgr->lock);
+	ret = qcom_battmgr_set_charge_control(battmgr, soc, delta_soc);
+	mutex_unlock(&battmgr->lock);
+	if (!ret) {
+		battmgr->info.charge_ctrl_start = soc - delta_soc;
+		battmgr->info.charge_ctrl_end = soc;
+	}
+
+	return 0;
+}
+
+static int qcom_battmgr_bat_is_writeable(struct power_supply *psy,
+				enum power_supply_property psp)
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
+			enum power_supply_property psp,
+			const union power_supply_propval *pval)
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
@@ -657,6 +801,43 @@ static const struct power_supply_desc sc8280xp_bat_psy_desc = {
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
@@ -689,6 +870,42 @@ static const struct power_supply_desc sm8350_bat_psy_desc = {
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
+	POWER_SUPPLY_PROP_RESISTANCE,
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
@@ -764,7 +981,8 @@ static int qcom_battmgr_usb_get_property(struct power_supply *psy,
 	if (!battmgr->service_up)
 		return -EAGAIN;
 
-	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+			battmgr->variant == QCOM_BATTMGR_X1E80100)
 		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
 	else
 		ret = qcom_battmgr_usb_sm8350_update(battmgr, psp);
@@ -886,7 +1104,8 @@ static int qcom_battmgr_wls_get_property(struct power_supply *psy,
 	if (!battmgr->service_up)
 		return -EAGAIN;
 
-	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+			battmgr->variant == QCOM_BATTMGR_X1E80100)
 		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
 	else
 		ret = qcom_battmgr_wls_sm8350_update(battmgr, psp);
@@ -1196,6 +1415,12 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
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
@@ -1278,6 +1503,7 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 		}
 		break;
 	case BATTMGR_REQUEST_NOTIFICATION:
+	case BATTMGR_CHG_CTRL_LIMIT_EN:
 		battmgr->error = 0;
 		break;
 	default:
@@ -1297,7 +1523,8 @@ static void qcom_battmgr_callback(const void *data, size_t len, void *priv)
 
 	if (opcode == BATTMGR_NOTIFICATION)
 		qcom_battmgr_notification(battmgr, data, len);
-	else if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
+	else if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+			battmgr->variant == QCOM_BATTMGR_X1E80100)
 		qcom_battmgr_sc8280xp_callback(battmgr, data, len);
 	else
 		qcom_battmgr_sm8350_callback(battmgr, data, len);
@@ -1333,7 +1560,8 @@ static void qcom_battmgr_pdr_notify(void *priv, int state)
 static const struct of_device_id qcom_battmgr_of_variants[] = {
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
-	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
+	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
 	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
 	{}
 };
@@ -1343,6 +1571,7 @@ static char *qcom_battmgr_battery[] = { "battery" };
 static int qcom_battmgr_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
+	const struct power_supply_desc *psy_desc;
 	struct power_supply_config psy_cfg_supply = {};
 	struct power_supply_config psy_cfg = {};
 	const struct of_device_id *match;
@@ -1373,8 +1602,14 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	else
 		battmgr->variant = QCOM_BATTMGR_SM8350;
 
-	if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
-		battmgr->bat_psy = devm_power_supply_register(dev, &sc8280xp_bat_psy_desc, &psy_cfg);
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+			battmgr->variant == QCOM_BATTMGR_X1E80100) {
+		if (battmgr->variant == QCOM_BATTMGR_X1E80100)
+			psy_desc = &x1e80100_bat_psy_desc;
+		else
+			psy_desc = &sc8280xp_bat_psy_desc;
+
+		battmgr->bat_psy = devm_power_supply_register(dev, psy_desc, &psy_cfg);
 		if (IS_ERR(battmgr->bat_psy))
 			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),
 					     "failed to register battery power supply\n");
@@ -1394,7 +1629,12 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
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



