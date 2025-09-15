Return-Path: <linux-pm+bounces-34650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D67DB5737B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 10:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EBA1A2068A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 08:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA7C2F1FF9;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGFodUPl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E772EFDB6;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926214; cv=none; b=ir/4IVv3dFwVm4+y5xZUbSamYZkOsmgX+XulOXo8eESa9VFn778BLKcwJC7XnAiqj03PWzBTZe7cv9mGKtpsZuFojMQ2z2u970tGD+f1Q+OIQhVU11/FrfNSRMi/D84mlWbnwXv2s7Iif/Xz7OZNcV201M2nsYDgMOqXv17qYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926214; c=relaxed/simple;
	bh=tsehSsRduiMLDfiK/ZnPvndOdLHJ35iXTLk0fVXPvZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kpkkBsmZClAwj44vT4L4ZG6BKHnIr0P5GVqYhbwUrfQhi+9hqm+KZouynUj04k19bOn1Aa8bUbfos8NpPenlw6IFuuminlf78tmYcPlEG1JlejHAJVyOg8asuvQ4JHbHMYxIBOZYty9fqLglF1cEL7434CBLeErYaycRpfIKgVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGFodUPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BCC5C19424;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757926214;
	bh=tsehSsRduiMLDfiK/ZnPvndOdLHJ35iXTLk0fVXPvZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jGFodUPltni9TE92IoXukDoawV5kZ8cZ6KkOi4JSoHCkhUGryxvRbMf1qYRm6QIiK
	 MvX43WeLq2kOWu6W/H/IqvEHx2o2UwQlI4iwNLHAlj5qMzkUIjK349irCs02tY9KtW
	 QBoF27VLsN3yzstB9zpXE5KV7McSMt06EscfABJX6xjxUm6JOeT9HQ6xFu9pKfyhoF
	 pkxIvHMZNTlacetbtwRZYta8HHWMgg2qrXb3++ECSNRp1Kq4QfQ3sAylz5Okif1ZGS
	 z09lC+7XQjn6LgM2vOeK53vMrybik31URzFEZdTnjlaJuSCvf24SYrVVWMPs2WAxj1
	 MjiCJqO/JMmuw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EDCCAC599;
	Mon, 15 Sep 2025 08:50:14 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+fenglin.wu.oss.qualcomm.com@kernel.org>
Date: Mon, 15 Sep 2025 16:49:57 +0800
Subject: [PATCH v4 5/8] power: supply: qcom_battmgr: update compats for
 SM8550 and X1E80100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-qcom_battmgr_update-v4-5-6f6464a41afe@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757926212; l=1658;
 i=fenglin.wu@oss.qualcomm.com; s=20240327; h=from:subject:message-id;
 bh=Padek38N2d5tUa3CUkX9jyBikXlN/Pbraz4T8Ku3qcU=;
 b=I2tXllxxFJiZp1PUs2ZXAd6+fCURDDMuR+9uSp9oDmD2Tsk4GEidsm/gxEWwTp7rsC5RoNMHo
 EIJAKUQ91JFDkmHXp0ELnNtx3haCRxlQtBI3QzjBsr8ZOOF2X1L7xXt
X-Developer-Key: i=fenglin.wu@oss.qualcomm.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for fenglin.wu@oss.qualcomm.com/20240327
 with auth_id=406
X-Original-From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Reply-To: fenglin.wu@oss.qualcomm.com

From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>

Add variant definitions for SM8550 and X1E80100 platforms. Add a compat
for SM8550 and update match data for X1E80100 specifically so that they
could be handled differently in supporting charge control functionality.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
---
 drivers/power/supply/qcom_battmgr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 008e241e3eac3574a78459a2256e006e48c9f508..174d3f83ac2b070bb90c21a498686e91cc629ebe 100644
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
@@ -1333,7 +1335,8 @@ static void qcom_battmgr_pdr_notify(void *priv, int state)
 static const struct of_device_id qcom_battmgr_of_variants[] = {
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
-	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
+	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
 	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
 	{}
 };

-- 
2.34.1



