Return-Path: <linux-pm+bounces-34839-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A43A2B7E1B3
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 14:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345CF1761DD
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 10:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4192635A28B;
	Wed, 17 Sep 2025 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYduRNCN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BA30F55F;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104130; cv=none; b=hAx6dFYUR/lYJFBt2NMb20ewNIGG9URBvQmnFTqc/WF7/pOBjMeOg1nPe+2tJH4iiJRC07rt6Ti9Eo2qTvMRnXy4DbghyAFSsnKfqrxuv02UY3kbuqnC/CtxG7iRb40Lg4Mi/p2t+s8h9zQIofPCF0nEVyZlNrj1LupjJdYd+1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104130; c=relaxed/simple;
	bh=drCDTLl9MrCpnziiNpFdJSCmd9bFS1Q78KQ78zbFjZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ny34oZ9tFa4rxfk44A8UKtFkB3M/KsvM/liLSBj1kvYrb2GzRJisG2uUd5mdUb/cmt7xG/BkjVp6CpGmuvj2y9gOlQyFny9MyBCAUT/jBBr4V3rHEfNSeyuTnGJISwJ2+a0/frrFRl6AM8DXM64FORVD6wJ/T8JywZlb6JIZrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYduRNCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63A1FC4CEFC;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758104130;
	bh=drCDTLl9MrCpnziiNpFdJSCmd9bFS1Q78KQ78zbFjZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gYduRNCNvSfGjnxLlhm2RCmYO9GZuMyeLdmaisUDqjl1ti6p0pHxhwabQMWZ/bOpw
	 L9tgD85cdKiAmqWGh8COlYjOOJIsJMQbR2idR8m6Ks1wgr8RdADELr4w4o6RYLOTCH
	 2JAFklciaqjkPdhAGh2ohA8U6OBi3Wcuiuu/TfVIbxbVa74wn98XOXvRa379btG+09
	 +hWAirSsTWZLacOo1NfImS7sU3ENdRSzz+BYYnPKYHz7iRk0Rxe03KMDyw1Qhw4lGY
	 smZtraF3yXkUmWTKAysY3mMIb3fdkvxR8/X5HNas4RJwAKc289hdnK4TMciO2AB8st
	 Dmfrqu+Ztsn1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565AFCAC598;
	Wed, 17 Sep 2025 10:15:30 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Wed, 17 Sep 2025 18:15:18 +0800
Subject: [PATCH v5 5/9] power: supply: qcom_battmgr: update compats for
 SM8550 and X1E80100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-qcom_battmgr_update-v5-5-270ade9ffe13@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758104128; l=4187;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=YzdvjtW+H6Rd6cLEcLCqEtAb9Cj2In+fOxNkmN6NA/Q=;
 b=HX/XQi5yvSoxRr5KXYiGjK9ysc+ESDzXNA5Jd8Zxo7a2fujbUdLC1j2QH6TAKRM+mspNCD6gU
 9YVao+uR3DNDg2Kn9t+KlQy0/to+ey8/wJnr1fN4nBPV8w2rxGX0EtA
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

The SM8550 and X1E80100 platforms now include charge control
functionality in battery management firmware, allowing charging
to stop when the battery reaches a set level and resume when it
drops below another level. To support this in the qcom_battmgr
driver, CHARGE_CONTROL_START/END_THRESHOLD power supply properties
can be added to manage these levels. This results in the battery
power supply properties for SM8550 and X1E80100 differing from
those for SM8350 and SC8280XP. Therefore, separate compatible
entries for SM8550 and X1E80100 are introduced, each with
their own variant definitions as match data.

Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 8d66f4dc95e3c141788189799b6e371e293d1d54..c4144839b2989d92085e605c96d7a71918d3d737 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -19,8 +19,10 @@
 #define BATTMGR_STRING_LEN	128
 
 enum qcom_battmgr_variant {
-	QCOM_BATTMGR_SM8350,
 	QCOM_BATTMGR_SC8280XP,
+	QCOM_BATTMGR_SM8350,
+	QCOM_BATTMGR_SM8550,
+	QCOM_BATTMGR_X1E80100,
 };
 
 #define BATTMGR_BAT_STATUS		0x1
@@ -494,7 +496,8 @@ static int qcom_battmgr_bat_get_property(struct power_supply *psy,
 	if (!battmgr->service_up)
 		return -EAGAIN;
 
-	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+	    battmgr->variant == QCOM_BATTMGR_X1E80100)
 		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
 	else
 		ret = qcom_battmgr_bat_sm8350_update(battmgr, psp);
@@ -764,7 +767,8 @@ static int qcom_battmgr_usb_get_property(struct power_supply *psy,
 	if (!battmgr->service_up)
 		return -EAGAIN;
 
-	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+	    battmgr->variant == QCOM_BATTMGR_X1E80100)
 		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
 	else
 		ret = qcom_battmgr_usb_sm8350_update(battmgr, psp);
@@ -886,7 +890,8 @@ static int qcom_battmgr_wls_get_property(struct power_supply *psy,
 	if (!battmgr->service_up)
 		return -EAGAIN;
 
-	if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+	    battmgr->variant == QCOM_BATTMGR_X1E80100)
 		ret = qcom_battmgr_bat_sc8280xp_update(battmgr, psp);
 	else
 		ret = qcom_battmgr_wls_sm8350_update(battmgr, psp);
@@ -1297,7 +1302,8 @@ static void qcom_battmgr_callback(const void *data, size_t len, void *priv)
 
 	if (opcode == BATTMGR_NOTIFICATION)
 		qcom_battmgr_notification(battmgr, data, len);
-	else if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
+	else if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+		 battmgr->variant == QCOM_BATTMGR_X1E80100)
 		qcom_battmgr_sc8280xp_callback(battmgr, data, len);
 	else
 		qcom_battmgr_sm8350_callback(battmgr, data, len);
@@ -1333,7 +1339,8 @@ static void qcom_battmgr_pdr_notify(void *priv, int state)
 static const struct of_device_id qcom_battmgr_of_variants[] = {
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
-	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
+	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
 	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
 	{}
 };
@@ -1373,7 +1380,8 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
 	else
 		battmgr->variant = QCOM_BATTMGR_SM8350;
 
-	if (battmgr->variant == QCOM_BATTMGR_SC8280XP) {
+	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
+	    battmgr->variant == QCOM_BATTMGR_X1E80100) {
 		battmgr->bat_psy = devm_power_supply_register(dev, &sc8280xp_bat_psy_desc, &psy_cfg);
 		if (IS_ERR(battmgr->bat_psy))
 			return dev_err_probe(dev, PTR_ERR(battmgr->bat_psy),

-- 
2.34.1



