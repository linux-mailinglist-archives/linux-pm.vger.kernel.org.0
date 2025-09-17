Return-Path: <linux-pm+bounces-34837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D9B7F2DC
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 15:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 922597ADF16
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 10:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DCF350855;
	Wed, 17 Sep 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsnyUOLs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF792F83CD;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104130; cv=none; b=LBm4Lzji9j4JM9OTI/Mfv+CaQ4/c5fpmol1goCpSH6zB5yvXqwlFYiBAsh3Q14Blpch/omyreRW7KGqeFC065ZJ2ArzwiI1SgWYENDyPZXyaHBlamuvH7KV3ijZIjfHFMMugHeL7sIif5C9IM7DjqN19TV5RvXZSTGn30+TeMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104130; c=relaxed/simple;
	bh=azyJg6KUgdRDGC1p4IH9GAOTVnz4HX46CIrB3AT7Hx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMIniuzreFvCpHLrzPK1pBanb4zkl+kDkz1Gu60FnYFK48txFPJ/4ZrUOFNF7bSldLuCTOacnV5zmDp7jAxsTXRS9glHFj9tq2CL3UcV79C9LFAeoIY+uIzJ/FiBTDGys7THUZEtdwHCH41o/8ByFdU9SuftqH37OisM8/FVvvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsnyUOLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5373BC19421;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104130;
	bh=azyJg6KUgdRDGC1p4IH9GAOTVnz4HX46CIrB3AT7Hx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YsnyUOLsppluqdcDx6D0e3q222uz6R932eweJC0EW6EHHpHuS7UgiG2cTKTTSWXS3
	 6smkWP/Qf4M5b0TCez49FrkWwckcgNX3/kdwjq5m1NxeXs2lSJzxE0DBPcxFLEI/Am
	 HdvMWOJr8AMoM3AKPrQl0oD+Az+np+2U3KN/pf7KGhLPJn6jRVYd08wBVi4yvqqedL
	 G5ZTSr+6HN4RVWQCDTfSkK5w/EoXLK74Gf9dxzl60zBr+hRwnpD+JzOE9kPDq9rERD
	 VgjuAdNFR8uBO+K+xkDeF8o9IzSNfdjhYEh/YBKqpl0n+v9c5CVOV4cbxBvrH7ufSf
	 /xgcgAs4f3mQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424D8CAC599;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Wed, 17 Sep 2025 18:15:17 +0800
Subject: [PATCH v5 4/9] power: supply: qcom_battmgr: Add state_of_health
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-qcom_battmgr_update-v5-4-270ade9ffe13@oss.qualcomm.com>
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
 linux-usb@vger.kernel.org, Fenglin Wu <fenglin.wu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758104128; l=2199;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=J+Tofx9OY3dW9voQAra7xP6gCfAfzWclJNIDuOa+XFI=;
 b=ngXgVYDJhqidf9rMnPZQg35NeTizCPuVsJQvmVrsTMvqWqmLmecbunugfRjnn1vcRyJVfL2Bp
 /y/dIla1UdNCp7e7l4nmfXD74OaSE7B9mFu8T3MV3+kRsigTTOd13Gk
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add state_of_health property to read battery health percentage from
battery management firmware.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 6026266907c9dfd902240d451a0d1c50fa5dbc59..8d66f4dc95e3c141788189799b6e371e293d1d54 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -256,6 +256,7 @@ struct qcom_battmgr_status {
 	unsigned int voltage_ocv;
 	unsigned int temperature;
 	unsigned int resistance;
+	unsigned int soh_percent;
 
 	unsigned int discharge_time;
 	unsigned int charge_time;
@@ -421,6 +422,7 @@ static const u8 sm8350_bat_prop_map[] = {
 	[POWER_SUPPLY_PROP_TIME_TO_FULL_AVG] = BATT_TTF_AVG,
 	[POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG] = BATT_TTE_AVG,
 	[POWER_SUPPLY_PROP_INTERNAL_RESISTANCE] = BATT_RESISTANCE,
+	[POWER_SUPPLY_PROP_STATE_OF_HEALTH] = BATT_SOH,
 	[POWER_SUPPLY_PROP_POWER_NOW] = BATT_POWER_NOW,
 };
 
@@ -588,6 +590,9 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_INTERNAL_RESISTANCE:
 		val->intval = battmgr->status.resistance;
 		break;
+	case POWER_SUPPLY_PROP_STATE_OF_HEALTH:
+		val->intval = battmgr->status.soh_percent;
+		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
 		val->intval = battmgr->status.discharge_time;
 		break;
@@ -672,6 +677,7 @@ static const enum power_supply_property sm8350_bat_props[] = {
 	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
 	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
 	POWER_SUPPLY_PROP_INTERNAL_RESISTANCE,
+	POWER_SUPPLY_PROP_STATE_OF_HEALTH,
 	POWER_SUPPLY_PROP_POWER_NOW,
 };
 
@@ -1141,6 +1147,9 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
 		case BATT_CAPACITY:
 			battmgr->status.percent = le32_to_cpu(resp->intval.value) / 100;
 			break;
+		case BATT_SOH:
+			battmgr->status.soh_percent = le32_to_cpu(resp->intval.value);
+			break;
 		case BATT_VOLT_OCV:
 			battmgr->status.voltage_ocv = le32_to_cpu(resp->intval.value);
 			break;

-- 
2.34.1



