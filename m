Return-Path: <linux-pm+bounces-27542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73402AC19C3
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 03:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7667A26451
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 01:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457F20C489;
	Fri, 23 May 2025 01:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqNy1i6d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55E205AA1;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747964384; cv=none; b=TyPw8rJh9jbFUa9WGHkGROOx28h4AWDPUVTIRD8gdDpVEAn3XWx+SMrF15fPZMl39fLw1LJIhhLJScFYaEB2sPzmiDh1/RUvTOmst+LKm6a/hmJh3eLYnmEDW4M1P12US91sfDYIn1jMfXmG9hACFjPxXKFDVqxu55YI4R1psbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747964384; c=relaxed/simple;
	bh=cym4dssKpYufKHgDHXCakXVU+FEamG34ZUHmBeBuKF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZuETW+xzU6ACNBilbPnhXzx70BdpmFveYODlZrIn8pV52etIhQcMlePIQ09IWJAnYwaJIqIhMENHlvTe+/Gntos/GR1H9WtIfQIECy3BYGGJga9xfr/nxKOlMgeJUOHa45EuuwLSyr/N1cWGgmcp1GdsLykKh58ahv1SUXzVrSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqNy1i6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F783C4AF0D;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747964383;
	bh=cym4dssKpYufKHgDHXCakXVU+FEamG34ZUHmBeBuKF8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gqNy1i6dk2qqrmSmXpqTYOil2p1WR8YSw6mYzg3VF0pB57MF6xqqVJ+aJT2mT+d5D
	 5FAEgbcesOvWlkUgf7PkUe5e/xGpbUKn2X29kqI+Dk8eCcM37RjsCo5OM13LiQInwB
	 /5NJ6YCGs1rk5C6Aplqb7+c5q2MprBtZC6uen74TYY+iv5ArJlEfm4V2ygzx+yrVDk
	 NwDM7FS5ribs8izNcTnkunY94fBAAXVB26XOERO96Jg8W++c7sXgc3ndlVy/aNaPQ8
	 iefr1GoP0QZXCMb96io6d9ZbB5S7QaFKMrAdQFqrF/pb7grWkIFmYkRf99hrzdF8Vg
	 Ovs+1N56e54HQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5E4C54ED0;
	Fri, 23 May 2025 01:39:43 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Fri, 23 May 2025 09:39:22 +0800
Subject: [PATCH 5/5] power: supply: qcom-battmgr: Add charge control
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-qcom_battmgr_update-v1-5-2bb6d4e0a56e@oss.qualcomm.com>
References: <20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com>
In-Reply-To: <20250523-qcom_battmgr_update-v1-0-2bb6d4e0a56e@oss.qualcomm.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>, 
 David Collins <david.collins@oss.qualcomm.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 kernel@oss.qualcomm.com, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747964381; l=10882;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=fTXdGyuL8UjaypE2dDm/s2ZDCEQjqdSYF4BjdA2U7VA=;
 b=mQIQDrYryRCD1e/oO2Qxd6b15OFGLwwVPRe0rcBD5CqHeWGrYvYOYbCNyvaCXfX3Iu6Zkyh/B
 Ydupra/SzUfC91Di1AUtC0FtjwTMDPUauTK7c38mbzJBpaG4QgfkH7B
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add charge control support starting from SM8550 platform. It's supported
with below two power supply properties:

charge_control_end_threshold: SOC threshold at which the charging
should be terminated.

charge_control_start_threshold: SOC threshold at which the charging
should be resumed.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 194 +++++++++++++++++++++++++++++++++++-
 1 file changed, 193 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index d5d0200b92bdc3d9a22f44159ad45b152efe8be0..0bce8c253430ded88b0947d191f0d8953b2baa9e 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -21,6 +21,7 @@
 enum qcom_battmgr_variant {
 	QCOM_BATTMGR_SM8350,
 	QCOM_BATTMGR_SC8280XP,
+	QCOM_BATTMGR_SM8550,
 };
 
 #define BATTMGR_BAT_STATUS		0x1
@@ -66,6 +67,9 @@ enum qcom_battmgr_variant {
 #define BATT_RESISTANCE			21
 #define BATT_POWER_NOW			22
 #define BATT_POWER_AVG			23
+#define BATT_CHG_CTRL_EN		24
+#define BATT_CHG_CTRL_START_THR		25
+#define BATT_CHG_CTRL_END_THR		26
 
 #define BATTMGR_USB_PROPERTY_GET	0x32
 #define BATTMGR_USB_PROPERTY_SET	0x33
@@ -90,6 +94,13 @@ enum qcom_battmgr_variant {
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
@@ -124,6 +135,13 @@ struct qcom_battmgr_discharge_time_request {
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
@@ -236,6 +254,8 @@ struct qcom_battmgr_info {
 	unsigned int capacity_warning;
 	unsigned int cycle_count;
 	unsigned int charge_count;
+	unsigned int charge_ctrl_start;
+	unsigned int charge_ctrl_end;
 	char model_number[BATTMGR_STRING_LEN];
 	char serial_number[BATTMGR_STRING_LEN];
 	char oem_info[BATTMGR_STRING_LEN];
@@ -424,6 +444,8 @@ static const u8 sm8350_bat_prop_map[] = {
 	[POWER_SUPPLY_PROP_RESISTANCE] = BATT_RESISTANCE,
 	[POWER_SUPPLY_PROP_STATE_OF_HEALTH] = BATT_SOH,
 	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
+	[POWER_SUPPLY_PROP_CHARGE_CONTROL_START_THRESHOLD] = BATT_CHG_CTRL_START_THR,
+	[POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD] = BATT_CHG_CTRL_END_THR,
 };
 
 static int qcom_battmgr_bat_sm8350_update(struct qcom_battmgr *battmgr,
@@ -599,6 +621,12 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
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
@@ -624,6 +652,120 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
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
@@ -689,6 +831,42 @@ static const struct power_supply_desc sm8350_bat_psy_desc = {
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
@@ -1196,6 +1374,12 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
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
@@ -1278,6 +1462,7 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 		}
 		break;
 	case BATTMGR_REQUEST_NOTIFICATION:
+	case BATTMGR_CHG_CTRL_LIMIT_EN:
 		battmgr->error = 0;
 		break;
 	default:
@@ -1334,6 +1519,7 @@ static const struct of_device_id qcom_battmgr_of_variants[] = {
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
 	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
 	{}
 };
@@ -1344,6 +1530,7 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 			      const struct auxiliary_device_id *id)
 {
 	struct power_supply_config psy_cfg_supply = {};
+	const struct power_supply_desc *psy_desc;
 	struct power_supply_config psy_cfg = {};
 	const struct of_device_id *match;
 	struct qcom_battmgr *battmgr;
@@ -1394,7 +1581,12 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
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



