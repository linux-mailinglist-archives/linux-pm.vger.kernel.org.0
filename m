Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DD13EDB4A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 18:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhHPQv6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 12:51:58 -0400
Received: from comms.puri.sm ([159.203.221.185]:46824 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhHPQv6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Aug 2021 12:51:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8CB7DDFE25;
        Mon, 16 Aug 2021 09:51:26 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HiCGyLyjgrIW; Mon, 16 Aug 2021 09:51:21 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Subject: [PATCH 1/4] power: supply: max17042_battery: clean up MAX17055_V_empty
Date:   Mon, 16 Aug 2021 18:50:13 +0200
Message-Id: <20210816165016.3153776-1-sebastian.krzyszkowiak@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This register is same as in MAX17047 and MAX17050, so there's no need
for custom casing it.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/power/supply/max17042_battery.c | 4 ----
 include/linux/power/max17042_battery.h  | 1 -
 2 files changed, 5 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index c6078f179fb3..01e6728a9e2b 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -283,8 +283,6 @@ static int max17042_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042)
 			ret = regmap_read(map, MAX17042_V_empty, &data);
-		else if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
-			ret = regmap_read(map, MAX17055_V_empty, &data);
 		else
 			ret = regmap_read(map, MAX17047_V_empty, &data);
 		if (ret < 0)
@@ -778,8 +776,6 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 
 	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042)
 		max17042_override_por(map, MAX17042_V_empty, config->vempty);
-	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)
-		max17042_override_por(map, MAX17055_V_empty, config->vempty);
 	else
 		max17042_override_por(map, MAX17047_V_empty, config->vempty);
 	max17042_override_por(map, MAX17042_TempNom, config->temp_nom);
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index d55c746ac56e..7e5da60cbea3 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -113,7 +113,6 @@ enum max17042_register {
 enum max17055_register {
 	MAX17055_QRes		= 0x0C,
 	MAX17055_TTF		= 0x20,
-	MAX17055_V_empty	= 0x3A,
 	MAX17055_TIMER		= 0x3E,
 	MAX17055_USER_MEM	= 0x40,
 	MAX17055_RGAIN		= 0x42,
-- 
2.32.0

