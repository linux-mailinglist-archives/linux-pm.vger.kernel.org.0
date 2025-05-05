Return-Path: <linux-pm+bounces-26698-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73086AAB10D
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 05:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1941BC16D2
	for <lists+linux-pm@lfdr.de>; Tue,  6 May 2025 03:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392D133108E;
	Tue,  6 May 2025 00:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRuB0xyS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA72C0325;
	Mon,  5 May 2025 22:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485367; cv=none; b=MFM76Q1vAiaAMON6AX64Bid1GpzBynPK7Oq5eZTq1oF7DUFtgOkZ5DyvPs5PBt/Q6OwpCgeHEPZMHwk/awZRyUChKmHsvDcLPzyV5qW7QVNnlStgHPTO5ljmZ2pjBymEtCMzZfn8/y7qeXYhjY8Nm/QDO1BmiaJ+pjXsCQ3B+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485367; c=relaxed/simple;
	bh=iQuqLNlbfnoQsokddA345vQSrEYLa7Cz6ZvGPBbtin4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G37mbHsgvqWpEUIX/zyiSV/kXsSLi9mY3aUG8W1V4maKFd555EvUYsLzUXtu+IV3CdKSdvBc8nKzXq1qe5LG/OH19iRX4+fA2CDB54/nJsLmvs8koE2AvT710V+JPOUUCb2f1d0W3Q0rc4M9abobHdN0z+jYdFp9TK8Yj8cJwkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRuB0xyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFF8C4CEED;
	Mon,  5 May 2025 22:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485366;
	bh=iQuqLNlbfnoQsokddA345vQSrEYLa7Cz6ZvGPBbtin4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRuB0xySkEibXzLRtI1FGVhu4Ma/viu6DfbOg9UtnC4jsJN+iYZYACh3FFxAq6nNf
	 ByMIfOBrBEEXikXSrmeNa4fwF/TiwPwNDK/DBEQi8+Mz1ORf2Q82LjSbaOMrWJADKV
	 SzFp2cL22MvapEzYMEeBa76aYLzBpwqxfX95qWM5zjDrgoxqXmKKi/aUAtCizCITR1
	 mT0373vWp6laRs4JjIJQ02iFReduM1eeqAN3LSSNm4ggiotsnya9sxDlPWBHzoddBt
	 8CcsRdbPLl0g5haIN+Y8xACLBp3eWV8R1iKPgMybfUS5h3GtS+eix7KRk6q6ONjaB8
	 mfawMGUtJ98Lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chris Morgan <macromorgan@hotmail.com>,
	Philippe Simons <simons.philippe@gmail.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>,
	sre@kernel.org,
	wens@csie.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 292/486] power: supply: axp20x_battery: Update temp sensor for AXP717 from device tree
Date: Mon,  5 May 2025 18:36:08 -0400
Message-Id: <20250505223922.2682012-292-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

[ Upstream commit bbcfe510ecd47f2db4c8653c7dfa9dc7a55b1583 ]

Allow a boolean property of "x-powers,no-thermistor" to specify devices
where the ts pin is not connected to anything. This works around an
issue found with some devices where the efuse is not programmed
correctly from the factory or when the register gets set erroneously.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Tested-by: Philippe Simons <simons.philippe@gmail.com>
Link: https://lore.kernel.org/r/20250204155835.161973-4-macroalpha82@gmail.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/axp20x_battery.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
index 57eba1ddb17ba..88fbae613e8bc 100644
--- a/drivers/power/supply/axp20x_battery.c
+++ b/drivers/power/supply/axp20x_battery.c
@@ -89,6 +89,8 @@
 #define AXP717_BAT_CC_MIN_UA		0
 #define AXP717_BAT_CC_MAX_UA		3008000
 
+#define AXP717_TS_PIN_DISABLE		BIT(4)
+
 struct axp20x_batt_ps;
 
 struct axp_data {
@@ -117,6 +119,7 @@ struct axp20x_batt_ps {
 	/* Maximum constant charge current */
 	unsigned int max_ccc;
 	const struct axp_data	*data;
+	bool ts_disable;
 };
 
 static int axp20x_battery_get_max_voltage(struct axp20x_batt_ps *axp20x_batt,
@@ -983,6 +986,24 @@ static void axp717_set_battery_info(struct platform_device *pdev,
 	int ccc = info->constant_charge_current_max_ua;
 	int val;
 
+	axp_batt->ts_disable = (device_property_read_bool(axp_batt->dev,
+							  "x-powers,no-thermistor"));
+
+	/*
+	 * Under rare conditions an incorrectly programmed efuse for
+	 * the temp sensor on the PMIC may trigger a fault condition.
+	 * Allow users to hard-code if the ts pin is not used to work
+	 * around this problem. Note that this requires the battery
+	 * be correctly defined in the device tree with a monitored
+	 * battery node.
+	 */
+	if (axp_batt->ts_disable) {
+		regmap_update_bits(axp_batt->regmap,
+				   AXP717_TS_PIN_CFG,
+				   AXP717_TS_PIN_DISABLE,
+				   AXP717_TS_PIN_DISABLE);
+	}
+
 	if (vmin > 0 && axp717_set_voltage_min_design(axp_batt, vmin))
 		dev_err(&pdev->dev,
 			"couldn't set voltage_min_design\n");
-- 
2.39.5


