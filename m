Return-Path: <linux-pm+bounces-33082-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5D0B35527
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 09:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9801B63AC3
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 07:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C337A27FB18;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3WLIEZl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084F17A2E1;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192717; cv=none; b=A13+bizRgoGZzMd346jLr08yyNq6ehIIkRgUd79+xogCJ80pmPM1WYdpoeafBCNI7aEDVk0XYAqhAJqX155oVURh2P+DJehdLGusmAYFwABEg8W1ANMMwks80D37AsZ9ThylmDxj4Nh8RPHUTrIisZacZbPwXE0X7ptSlpx/6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192717; c=relaxed/simple;
	bh=th/xW83aBeFoGO0hEkmPF1u8WTaW4iQP3V4pb7YIS3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CfmYUsU/aDDVQiHoAS6HK4owiLX/7627U7proOtmPHnYZ829oJ12Qu2LjMQsXrxGp5AeuhxKCudk/bSroZCEzpn7eDlxyZAdMMfqY6y8ARVgRC6HkIXOW6dQ8xm35zeV4B+cT1CYWUbjCjPPVXc9sEjkoAe44iw2uALVvYgL91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3WLIEZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FD8EC4AF0C;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756192717;
	bh=th/xW83aBeFoGO0hEkmPF1u8WTaW4iQP3V4pb7YIS3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=T3WLIEZltJNuYPW/xK4FBjaimp+Yn5DYp0Ppjrf7R2T0YI65E6mHN3dzOeUsO/ST1
	 bGRz5aVty+bisR3OK6PV972PLe9lHyDX6O8y+INkLjDBdlqRNqCAz9Riwc5SCjkcxq
	 bNF3fCfDJNGnZpGq16v3tWpmdZI0Ku0qs97B8IOMqqT4TMu/DQyReNYuG8acBw1sWk
	 HBFW4+ZdwX6GTVaF6oORxwWKrL9UXKpIqIOQO6wh2fzpmJQdShOr5Jj3Y72wJy+UUL
	 CylE2NvlrTuStEU1dU5l5R5N+Ayyar38WEgZRTLHSo2F56/eeT19f0RnKhfU7QZaHO
	 lyH38rdS90Hlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA37CA0FEB;
	Tue, 26 Aug 2025 07:18:37 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Tue, 26 Aug 2025 15:18:30 +0800
Subject: [PATCH v3 3/8] power: supply: qcom_battmgr: Add resistance power
 supply property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-qcom_battmgr_update-v3-3-74ea410ef146@oss.qualcomm.com>
References: <20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com>
In-Reply-To: <20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com>
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
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756192715; l=2473;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=zi7yrMpAus4YPx9C7Vqz+BBGGIxG0pJ58Kd1/KkUxEk=;
 b=CGPIfUQGXSxWECziA/MijgMweL4PH+LcwC3O9EtYxiQEW5JF0pSXMZ9tsttAcqeNqz8mBfzos
 hbLS+gt0sLUCP4OJl475PPqHyByr9ZSLeVV1d+CfGmMIo3qK8Bg5ZjT
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add power supply property to get battery internal resistance from
the battery management firmware.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index fe27676fbc7cd12292caa6fb3b5b46a18c426e6d..55477ae92fd56ede465b32d6f7ed9da78ebd869c 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
  * Copyright (c) 2022, Linaro Ltd
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/auxiliary_bus.h>
 #include <linux/module.h>
@@ -254,6 +255,7 @@ struct qcom_battmgr_status {
 	unsigned int voltage_now;
 	unsigned int voltage_ocv;
 	unsigned int temperature;
+	unsigned int resistance;
 
 	unsigned int discharge_time;
 	unsigned int charge_time;
@@ -418,6 +420,7 @@ static const u8 sm8350_bat_prop_map[] = {
 	[POWER_SUPPLY_PROP_MODEL_NAME] = BATT_MODEL_NAME,
 	[POWER_SUPPLY_PROP_TIME_TO_FULL_AVG] = BATT_TTF_AVG,
 	[POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG] = BATT_TTE_AVG,
+	[POWER_SUPPLY_PROP_INTERNAL_RESISTANCE] = BATT_RESISTANCE,
 	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
 };
 
@@ -582,6 +585,9 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_TEMP:
 		val->intval = battmgr->status.temperature;
 		break;
+	case POWER_SUPPLY_PROP_INTERNAL_RESISTANCE:
+		val->intval = battmgr->status.resistance;
+		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
 		val->intval = battmgr->status.discharge_time;
 		break;
@@ -665,6 +671,7 @@ static const enum power_supply_property sm8350_bat_props[] = {
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
+	POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
 	POWER_SUPPLY_PROP_POWER_NOW,
 };
 
@@ -1174,6 +1181,9 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 		case BATT_TTE_AVG:
 			battmgr->status.discharge_time = le32_to_cpu(resp->intval.value);
 			break;
+		case BATT_RESISTANCE:
+			battmgr->status.resistance = le32_to_cpu(resp->intval.value);
+			break;
 		case BATT_POWER_NOW:
 			battmgr->status.power_now = le32_to_cpu(resp->intval.value);
 			break;

-- 
2.34.1



