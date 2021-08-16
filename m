Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630DC3EDB50
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 18:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhHPQwE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 12:52:04 -0400
Received: from comms.puri.sm ([159.203.221.185]:46848 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhHPQwD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Aug 2021 12:52:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 1CE2BDFE25;
        Mon, 16 Aug 2021 09:51:32 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4NlhZzjv7O4J; Mon, 16 Aug 2021 09:51:30 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Subject: [PATCH 3/4] power: supply: max17042_battery: more robust chip type checks
Date:   Mon, 16 Aug 2021 18:50:15 +0200
Message-Id: <20210816165016.3153776-3-sebastian.krzyszkowiak@puri.sm>
In-Reply-To: <20210816165016.3153776-1-sebastian.krzyszkowiak@puri.sm>
References: <20210816165016.3153776-1-sebastian.krzyszkowiak@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Prepared by checking the datasheets of max17042, max17047/50
and max170455 for differences in register maps.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
---
 drivers/power/supply/max17042_battery.c | 40 +++++++++++++------------
 include/linux/power/max17042_battery.h  |  9 ++++--
 2 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index eeccc365fe54..e6bcda966476 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -763,34 +763,36 @@ static inline void max17042_override_por_values(struct max17042_chip *chip)
 	max17042_override_por(map, MAX17042_FilterCFG, config->filter_cfg);
 	max17042_override_por(map, MAX17042_RelaxCFG, config->relax_cfg);
 	max17042_override_por(map, MAX17042_MiscCFG, config->misc_cfg);
-	max17042_override_por(map, MAX17042_MaskSOC, config->masksoc);
 
 	max17042_override_por(map, MAX17042_FullCAP, config->fullcap);
 	max17042_override_por(map, MAX17042_FullCAPNom, config->fullcapnom);
-	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042)
-		max17042_override_por(map, MAX17042_SOC_empty,
-						config->socempty);
-	max17042_override_por(map, MAX17042_LAvg_empty, config->lavg_empty);
 	max17042_override_por(map, MAX17042_dQacc, config->dqacc);
 	max17042_override_por(map, MAX17042_dPacc, config->dpacc);
 
-	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042)
-		max17042_override_por(map, MAX17042_V_empty, config->vempty);
-	else
-		max17042_override_por(map, MAX17047_V_empty, config->vempty);
-	max17042_override_por(map, MAX17042_TempNom, config->temp_nom);
-	max17042_override_por(map, MAX17042_TempLim, config->temp_lim);
-	max17042_override_por(map, MAX17042_FCTC, config->fctc);
 	max17042_override_por(map, MAX17042_RCOMP0, config->rcomp0);
 	max17042_override_por(map, MAX17042_TempCo, config->tcompc0);
-	if (chip->chip_type &&
-	    ((chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042) ||
+
+	if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042) {
+		max17042_override_por(map, MAX17042_MaskSOC, config->masksoc);
+		max17042_override_por(map, MAX17042_SOC_empty, config->socempty);
+		max17042_override_por(map, MAX17042_V_empty, config->vempty);
+		max17042_override_por(map, MAX17042_EmptyTempCo, config->empty_tempco);
+		max17042_override_por(map, MAX17042_K_empty0, config->kempty0);
+	}
+
+	if ((chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042) ||
 	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17047) ||
-	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050))) {
-		max17042_override_por(map, MAX17042_EmptyTempCo,
-						config->empty_tempco);
-		max17042_override_por(map, MAX17042_K_empty0,
-						config->kempty0);
+	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050)) {
+		max17042_override_por(map, MAX17042_LAvg_empty, config->lavg_empty);
+		max17042_override_por(map, MAX17042_TempNom, config->temp_nom);
+		max17042_override_por(map, MAX17042_TempLim, config->temp_lim);
+		max17042_override_por(map, MAX17042_FCTC, config->fctc);
+	}
+
+	if ((chip->chip_type == MAXIM_DEVICE_TYPE_MAX17047) ||
+	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17050) ||
+	    (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17055)) {
+		max17042_override_por(map, MAX17047_V_empty, config->vempty);
 	}
 }
 
diff --git a/include/linux/power/max17042_battery.h b/include/linux/power/max17042_battery.h
index 86f16fc3b694..dd24756a8af7 100644
--- a/include/linux/power/max17042_battery.h
+++ b/include/linux/power/max17042_battery.h
@@ -110,12 +110,14 @@ enum max17042_register {
 	MAX17042_VFSOC		= 0xFF,
 };
 
+/* Registers specific to max17055 only */
 enum max17055_register {
 	MAX17055_QRes		= 0x0C,
+	MAX17055_RCell		= 0x14,
 	MAX17055_TTF		= 0x20,
-	MAX17055_TIMER		= 0x3E,
+	MAX17055_DieTemp	= 0x34,
 	MAX17055_USER_MEM	= 0x40,
-	MAX17055_RGAIN		= 0x42,
+	MAX17055_RGAIN		= 0x43,
 
 	MAX17055_ConvgCfg	= 0x49,
 	MAX17055_VFRemCap	= 0x4A,
@@ -154,13 +156,14 @@ enum max17055_register {
 	MAX17055_AtAvCap	= 0xDF,
 };
 
-/* Registers specific to max17047/50 */
+/* Registers specific to max17047/50/55 */
 enum max17047_register {
 	MAX17047_QRTbl00	= 0x12,
 	MAX17047_FullSOCThr	= 0x13,
 	MAX17047_QRTbl10	= 0x22,
 	MAX17047_QRTbl20	= 0x32,
 	MAX17047_V_empty	= 0x3A,
+	MAX17047_TIMER		= 0x3E,
 	MAX17047_QRTbl30	= 0x42,
 };
 
-- 
2.32.0

