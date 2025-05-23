Return-Path: <linux-pm+bounces-27556-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A546FAC230A
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 14:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F2A3B8B39
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781F261FFE;
	Fri, 23 May 2025 12:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsSLSlFL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1999478;
	Fri, 23 May 2025 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004725; cv=none; b=gIPx/0KIxGMFDWZHxiOf3iH5cvMEhyL2xtUU2H7AqMc0EDXYRSzbbWBkACXI/IvjrvcS7HPtZt+N4r6ity98+JfQsWwh9bKRBeutHMU7Xa/c1dKMNW++U6bpbkJ4Dteuw00Ucb85KmNRupCJFSII6ukZGp8NY1hq0RUXHlNVWow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004725; c=relaxed/simple;
	bh=ZiOqMUDN7gDQRGBJ9S3lJOWMapimTDHrW/d3CnLHWlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nDxxSuMgXOssV4plILYUD3Y6/l6Lhe/IFHicaCopPk+Z0r6ok34MlJGLb7ycuzQwGKTbvHtSZOVjmNW1tvBxdOBB094A+ufSyzEfODSwsKtdUEKITXF+hRc3dGMgu7QfZntQFGC9xuEOgbQ8SklMp3HJ3skFB8rCJDJJbtqguGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsSLSlFL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD65CC4CEEF;
	Fri, 23 May 2025 12:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748004724;
	bh=ZiOqMUDN7gDQRGBJ9S3lJOWMapimTDHrW/d3CnLHWlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lsSLSlFLtz1bVXQrwgmsk9wT0AYbuFskA5/c641ikfUX8mH6jnA+qoiMqRCSBUAQw
	 VpIFfRT5Smf43CMEnTeL7A2fTuKUBp6Po1gyzsDilJFM7qMNUuUHGK4H+bsfe1ESA5
	 VrrDtxWzH4wRyQyY5yrcfvs2QabdE2uiOR6cPXwc49RW1+OiE9cxGNTxskph/haAB6
	 vXVmHiwOIIvl1m0VMJEBgRbfT8yncoPkU72vJrA6h+y6/Bx2qELs3aw0qurmxe/tQ1
	 Vk2wTY+/6twfexoTujc2ffQBEJ93YjGfLZsWpBLx0KuzYgDKXvNxUYZKCp0LYihOuF
	 xiMfQYkVQbnKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA374C54ED0;
	Fri, 23 May 2025 12:52:04 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Fri, 23 May 2025 14:51:44 +0200
Subject: [PATCH v4 1/5] power: supply: max1720x correct capacity
 computation
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250523-b4-gs101_max77759_fg-v4-1-b49904e35a34@uclouvain.be>
References: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
In-Reply-To: <20250523-b4-gs101_max77759_fg-v4-0-b49904e35a34@uclouvain.be>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748004727; l=2215;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=eC7BjQT0ON0eLj1BHeNmcDKE6aFWeTYyXf1R0uFKWNU=;
 b=u72BzfqomX49C/S2gr/GbMspbY67y8FvftX3344pxMav8E91Kbxtx06+Ycy1Ar4vUSw7B6fAR
 7cyUOcdgcxPBN8eRzTOtB2LREJJjjfJzpnAvYamLmywQoKw6Qc8LebC
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

From the datasheet of the MAX17201/17205, the LSB should be
"5.0μVh/RSENSE". The current computation sets it at 0.5mAh=5.0μVh/10mOhm
which does not take into account the value of rsense which can be
different from 10mOhm.

Change the computation to fit the specs.

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 drivers/power/supply/max1720x_battery.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index ea3912fd1de8bfd0d029c16f276316d06e1b105c..68b5314ecf3a234f906ec8fe400e586855b69cd9 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -288,9 +288,10 @@ static int max172xx_voltage_to_ps(unsigned int reg)
 	return reg * 1250;	/* in uV */
 }
 
-static int max172xx_capacity_to_ps(unsigned int reg)
+static int max172xx_capacity_to_ps(unsigned int reg,
+				   struct max1720x_device_info *info)
 {
-	return reg * 500;	/* in uAh */
+	return reg * (500000 / info->rsense);	/* in uAh */
 }
 
 /*
@@ -394,11 +395,11 @@ static int max1720x_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 		ret = regmap_read(info->regmap, MAX172XX_DESIGN_CAP, &reg_val);
-		val->intval = max172xx_capacity_to_ps(reg_val);
+		val->intval = max172xx_capacity_to_ps(reg_val, info);
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_AVG:
 		ret = regmap_read(info->regmap, MAX172XX_REPCAP, &reg_val);
-		val->intval = max172xx_capacity_to_ps(reg_val);
+		val->intval = max172xx_capacity_to_ps(reg_val, info);
 		break;
 	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG:
 		ret = regmap_read(info->regmap, MAX172XX_TTE, &reg_val);
@@ -422,7 +423,7 @@ static int max1720x_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = regmap_read(info->regmap, MAX172XX_FULL_CAP, &reg_val);
-		val->intval = max172xx_capacity_to_ps(reg_val);
+		val->intval = max172xx_capacity_to_ps(reg_val, info);
 		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		ret = regmap_read(info->regmap, MAX172XX_DEV_NAME, &reg_val);

-- 
2.49.0



