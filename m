Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4992850D0
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 19:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJFRaR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 13:30:17 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40834 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgJFRaR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 13:30:17 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 096HUE9L126688;
        Tue, 6 Oct 2020 12:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602005414;
        bh=AzvZBRhmRABDkqrfilxWWOPhcvOL4CGtB+8gJlGQV3A=;
        h=From:To:CC:Subject:Date;
        b=XQws8qD+TtfYln3P9kDmtrWXWge8ViVw1rgYesKsaqO/nvcsnj1Cf/LaPvjmHY99E
         VoWNLykARPRbyhqgyLCK2Dn54MZhIO0e2DwqbZpX3DLsWTAY1pTZNetTQ9pidN247u
         7ZUpv72PXN7kcjBvHiYPRd62BeOAucaS5c3iqUFo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 096HUESg086451
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Oct 2020 12:30:14 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 6 Oct
 2020 12:30:13 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 6 Oct 2020 12:30:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 096HUDux109037;
        Tue, 6 Oct 2020 12:30:13 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] power: supply: bq25980: Fix uninitialized wd_reg_val
Date:   Tue, 6 Oct 2020 12:30:07 -0500
Message-ID: <20201006173007.17385-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the uninitialized wd_reg_val if the for..loop was not successful in
finding an appropriate match.

Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259xx family")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/power/supply/bq25980_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 3995fb7cf060..24b9c0c8b25d 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -1099,7 +1099,7 @@ static int bq25980_power_supply_init(struct bq25980_device *bq,
 static int bq25980_hw_init(struct bq25980_device *bq)
 {
 	struct power_supply_battery_info bat_info = { };
-	int wd_reg_val;
+	int wd_reg_val = 0;
 	int ret = 0;
 	int curr_val;
 	int volt_val;
-- 
2.28.0.585.ge1cfff676549

