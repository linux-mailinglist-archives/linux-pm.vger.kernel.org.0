Return-Path: <linux-pm+bounces-18420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A889E1543
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 09:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F53166248
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B812A1DAC93;
	Tue,  3 Dec 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha7Qq0p3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3491DA636;
	Tue,  3 Dec 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213086; cv=none; b=s/J40ICWyjWlWxa7KB9fkpOIFbTV1YA6PRdYvLpApzJcSQikROeT7m4nMBqfuzSOGrE8d7YfcB/m0ZOK0iOer9/6YGKJ2tvNiH/gswBN4p13kMpld5+n8j0EDsSmfVi/VtsiwvCmG5LtuT29vdhnL7iN05WWenDmEjj6Cv3xOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213086; c=relaxed/simple;
	bh=LvEfLAz0g5jWylQkuc4jmKfRUuAwIhqD5Odb9MxBipU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LGftQJS1AIn7BnMyaYhUtnMXIh3tQjPXo2xLeRTigg3lqUFL+Cb41GA1DLtY2r2PqG9PonUE9U8n5JWmmlWVouf1UlPV/xufyzPnwgspO0HvnJ/Yk6YQPwSCTrxvOj3gUY8QngvHOVzmdlU+XmN83mP1C4xvrG4eiDzC88jYxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha7Qq0p3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFB22C4CED6;
	Tue,  3 Dec 2024 08:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733213086;
	bh=LvEfLAz0g5jWylQkuc4jmKfRUuAwIhqD5Odb9MxBipU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ha7Qq0p3hspUwfLb7xYgvZI/6TJ+eLtHFRsw1hvMMxAyH/MYKdn4Xreui/c8T+SIB
	 0mNQAVq20t7EWv8n3ttUJJ3ORd1J+Re259S2p9RC1ZeUk3VwoFWTdi5syKggep8DQy
	 +X13Gj7lpORjf4/OcygaIbMnUmx/zR9/Q6MZLXhXjn9TdgmoDVk3LuN2FJbjCmdoyo
	 7TKOEjQyVc/AM42+igX1s4q1Dh150iS9z3GZ1KrBvYNM7ZuqGt0tzoqkH9DJreTzpd
	 4rMpEQfPhANaLNqJoKjr5526ti/RO/eXxYlP47bwtcX8yLw9lwpM1+SRCgnAecd9ML
	 oVzZWDAIzKoPQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB89CE6C616;
	Tue,  3 Dec 2024 08:04:45 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Date: Tue, 03 Dec 2024 09:04:36 +0100
Subject: [PATCH] power: supply: max1720x: add charge full property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-max1720x-charge-full-prop-v1-1-b02776b43f17@liebherr.com>
X-B4-Tracking: v=1; b=H4sIAJO7TmcC/yWOQQ6DIBBFr0JYFwOIAVz1Ho2LEcaWRNSCNibGu
 5fWzSRvfubNP2jGFDDTlhw04SfkME8FxI1Q94LpiSz4wlRyqUQZLMIutOQ7K3Eq8bCNI1vSvDB
 sBLcWRC2coOV+STiE/e9+dBcnfG/lxXotaQ8ZmZtjDGtLFK+NckZxBGGV8to1UFuJxuoGPTcG3
 cD7Wv/UGSfPruZsnVviQ4RqQJ9guz8jhLEqVtqd5xcJ9lfv4AAAAA==
X-Change-ID: 20241202-max1720x-charge-full-prop-e51099a131c1
To: Sebastian Reichel <sre@kernel.org>, 
 Thomas Antoine <t.antoine@uclouvain.be>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733213084; l=2122;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=RkkK3ElM3J0WHWfD2Z/jYMO3Bs/oJAsns7dWA0uLXxM=;
 b=R2TCaDXPn2Qv3gJ51ltJ4JB+0wLrzZC7+cyy7KSIYDcb9xrdrCO8K9MA66Ba+k70QHKg3legf
 otvN7CcWBaMB9TBziV61YoV7k08ePRK/0G46kND7GVL/GcTbXfBfpjj
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Charge full holds the calculated full capacity of the cell based on all
inputs from the ModelGauge m5 algorithm including empty compensation. A
new full-capacity value is calculated continuously as application
conditions change.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
 drivers/power/supply/max1720x_battery.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/power/supply/max1720x_battery.c b/drivers/power/supply/max1720x_battery.c
index 33105419e2427bb37963bda9948b647c239f8faa..9c7e14d2c7b87b8194511f36ade16e774281333e 100644
--- a/drivers/power/supply/max1720x_battery.c
+++ b/drivers/power/supply/max1720x_battery.c
@@ -29,6 +29,7 @@
 #define MAX172XX_TEMP			0x08	/* Temperature */
 #define MAX172XX_CURRENT		0x0A	/* Actual current */
 #define MAX172XX_AVG_CURRENT		0x0B	/* Average current */
+#define MAX172XX_FULL_CAP		0x10	/* Calculated full capacity */
 #define MAX172XX_TTE			0x11	/* Time to empty */
 #define MAX172XX_AVG_TA			0x16	/* Average temperature */
 #define MAX172XX_CYCLES			0x17
@@ -250,6 +251,7 @@ static const enum power_supply_property max1720x_battery_props[] = {
 	POWER_SUPPLY_PROP_TEMP,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
@@ -362,6 +364,10 @@ static int max1720x_battery_get_property(struct power_supply *psy,
 		ret = regmap_read(info->regmap, MAX172XX_AVG_CURRENT, &reg_val);
 		val->intval = max172xx_current_to_voltage(reg_val) / info->rsense;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL:
+		ret = regmap_read(info->regmap, MAX172XX_FULL_CAP, &reg_val);
+		val->intval = max172xx_capacity_to_ps(reg_val);
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		ret = regmap_read(info->regmap, MAX172XX_DEV_NAME, &reg_val);
 		reg_val = FIELD_GET(MAX172XX_DEV_NAME_TYPE_MASK, reg_val);

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241202-max1720x-charge-full-prop-e51099a131c1

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



