Return-Path: <linux-pm+bounces-34646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F39FB5736B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00CCD17B28B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B152F0C7F;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruCcniRt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837832F0696;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926214; cv=none; b=fHMTs1cr9T2a5EQUIWIWO48wD3LKlS8Q2zzmuhc5xrNsDIGH2y5Ft4nG9OIy0CyMoa4XiKHQht1f/gy6gxqEPJLCn3dGX/wv3+H7VbN25o3Q4czP5kDMOW2Q/4DVt0PE6unN1Ca79uNAj7Mzj+ywJuQ6cFoIBP9AAuLrcUvWU+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926214; c=relaxed/simple;
	bh=W+b8h6Qxt10qDCCb1XrQIJLibkuQUcej5ptibTlODKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NbuSYXuLXmqCCHdg3Ur82mx71i3VT2Tur9rWrWiUekx0lB3FCM2mIwDrBXoI6DFf6sNjwOorY8OggBPdI2dGZxZiV6EQ7bKRo4nPSNHIPbDSB1a4t2fyf0gZQnafRuAdw/48C5D5DoWYqWSF3nOIPvFWThN1u+PRUlOerqqGj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruCcniRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E0C5C16AAE;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926214;
	bh=W+b8h6Qxt10qDCCb1XrQIJLibkuQUcej5ptibTlODKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ruCcniRt/eRvs164a66R1kQQNyLWBh3oCjYhYm1n8TVjWrsr2z2XKSe1+5vH/GRp3
	 7HOaaSikj6lz84KEmlWac5VRFGl6OD9Vjlz5SntF+uLK1btWcqphgRz9iYaoKO67cU
	 i20W/uV2I1tTaF4+IVL54euISpm2mZgk8Qu8L+OkXLOL/2NM8jd1rhoIm5WbepnEYC
	 AbidNhuZTXeEfV49OqD+XtK1mQ7wxwi8wvz0PfGY1SifgarlND9xqlQHtK6CGVJWzE
	 JCE7obb2f9hY7h23lpaBXmf6szlGFeHQpbU98nkTBqFfFDStPEl22vHzndZTI29PVa
	 vGSkPHaLPAAmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224C7CAC59A;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Mon, 15 Sep 2025 16:49:56 +0800
Subject: [PATCH v4 4/8] power: supply: qcom_battmgr: Add state_of_health
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-qcom_battmgr_update-v4-4-6f6464a41afe@oss.qualcomm.com>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
In-Reply-To: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757926212; l=2278;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=VIN2pXk/U1+wm3Thq8v/fKUD3hKeRjRBB653GlANfdk=;
 b=Ox21fema1o1mrdUdH2t3LlgNM+skvt0wpjfURX8IBrf2Ta9Iv+7KqncS380cQJOUHifFy7uao
 KPEZgenQYPoDyIvke0TiPZksVedf0I1rWLa/CopiRCUnt+jJkFNKtQf
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add state_of_health property to read battery health percentage from
battery management firmware.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 55477ae92fd56ede465b32d6f7ed9da78ebd869c..008e241e3eac3574a78459a2256e006e48c9f508 100644
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



