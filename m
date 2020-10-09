Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D50288857
	for <lists+linux-pm@lfdr.de>; Fri,  9 Oct 2020 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbgJIMMJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Oct 2020 08:12:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40182 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732957AbgJIMMJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2020 08:12:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 099CC7NU071967;
        Fri, 9 Oct 2020 07:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602245527;
        bh=sfIRZSYBuq+MnozQeCBK9PSbZtBv00OpSwHV6m/Zcv0=;
        h=From:To:CC:Subject:Date;
        b=Kgo558q1C7K20OGjWya28RrOuaKM485hETMvlu/0nTx7j/oQfaLPa/GvnmY3F67Lb
         7zJY1JHZuH1QcwM/gc29ruvk80Rj4b8HgxWY1ikvdhsgFnaSXAI70fvqlbGxiu67Ln
         l92Z40b2bukBwSyNjk96YxYw7+EOdTYKdbkKvOA4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 099CC7WG105005
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 07:12:07 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 9 Oct
 2020 07:12:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 9 Oct 2020 07:12:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 099CC6Rv104538;
        Fri, 9 Oct 2020 07:12:06 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] power: supply: bq25980: Fix uninitialized wd_reg_val and overrun
Date:   Fri, 9 Oct 2020 07:12:05 -0500
Message-ID: <20201009121205.28178-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the issue when 'i' is equal to array size then array index over
runs the array when checking for the watch dog value.

This also fixes the uninitialized wd_reg_val if the for..loop was not
successful in finding an appropriate match.

Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259xx family")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/power/supply/bq25980_charger.c | 29 +++++++++++++-------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 3995fb7cf060..e6a91e43ae5b 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -1099,28 +1099,29 @@ static int bq25980_power_supply_init(struct bq25980_device *bq,
 static int bq25980_hw_init(struct bq25980_device *bq)
 {
 	struct power_supply_battery_info bat_info = { };
-	int wd_reg_val;
+	int wd_reg_val = BQ25980_WATCHDOG_DIS;
+	int wd_max_val = BQ25980_NUM_WD_VAL - 1;
 	int ret = 0;
 	int curr_val;
 	int volt_val;
 	int i;
 
-	if (!bq->watchdog_timer) {
-		ret = regmap_update_bits(bq->regmap, BQ25980_CHRGR_CTRL_3,
-					 BQ25980_WATCHDOG_DIS,
-					 BQ25980_WATCHDOG_DIS);
-	} else {
-		for (i = 0; i < BQ25980_NUM_WD_VAL; i++) {
-			if (bq->watchdog_timer > bq25980_watchdog_time[i] &&
-			    bq->watchdog_timer < bq25980_watchdog_time[i + 1]) {
-				wd_reg_val = i;
-				break;
+	if (bq->watchdog_timer) {
+		if (bq->watchdog_timer >= bq25980_watchdog_time[wd_max_val])
+			wd_reg_val = wd_max_val;
+		else {
+			for (i = 0; i < wd_max_val; i++) {
+				if (bq->watchdog_timer > bq25980_watchdog_time[i] &&
+				    bq->watchdog_timer < bq25980_watchdog_time[i + 1]) {
+					wd_reg_val = i;
+					break;
+				}
 			}
 		}
-
-		ret = regmap_update_bits(bq->regmap, BQ25980_CHRGR_CTRL_3,
-					BQ25980_WATCHDOG_MASK, wd_reg_val);
 	}
+
+	ret = regmap_update_bits(bq->regmap, BQ25980_CHRGR_CTRL_3,
+				 BQ25980_WATCHDOG_MASK, wd_reg_val);
 	if (ret)
 		return ret;
 
-- 
2.28.0.585.ge1cfff676549

