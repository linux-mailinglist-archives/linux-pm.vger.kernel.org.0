Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172762F5704
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 02:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbhANB5f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 20:57:35 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39172 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbhAMXn3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 18:43:29 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10DMsMQN093342;
        Wed, 13 Jan 2021 16:54:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610578462;
        bh=/Zlmr8Iad4qwtDW5CFTi5k84Y25UAYrbaevAVuzfJqI=;
        h=From:To:CC:Subject:Date;
        b=e+Mh/pxPLXzs3fpPzvpw8wl3JP26qlk5xGjDhmzuSm3rO2j8kzmyQNGdACH9gx0Ug
         nrxFvrQrvTX9enhUg+zifxoqk4CKSRHOc1WmXehV9QUH+Rz31YB7fi7Qhqo3jF+oZj
         NvNMo+U3HQQEAAsHNuvUYfQ0MDHO+1NqwUNEOqi4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10DMsMeA004637
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jan 2021 16:54:22 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 Jan 2021 16:54:21 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 Jan 2021 16:54:21 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10DMsLDl042146;
        Wed, 13 Jan 2021 16:54:21 -0600
From:   Ricardo Rivera-Matos <r-rivera-matos@ti.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dan.carpenter@oracle.com>,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: [PATCH] power: supply: bq256xx: Fix BQ256XX_NUM_WD_VAL and bq256xx_watchdog_time[] overrun
Date:   Wed, 13 Jan 2021 16:53:52 -0600
Message-ID: <20210113225352.13099-1-r-rivera-matos@ti.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Corrects BQ256XX_NUM_WD_VAL from value of "8" to "4" and fixes the issue when 'i'
is equal to array size then array index over runs the array

Fixes: 32e4978bb92 ("power: supply: bq256xx: Introduce the BQ256XX charger driver")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
---
 drivers/power/supply/bq256xx_charger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index dc74c44618af..8414472083a6 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -135,7 +135,7 @@
 #define BQ256XX_NTC_FAULT_COLD		(BIT(2) | BIT(0))
 #define BQ256XX_NTC_FAULT_HOT		(BIT(2) | BIT(1))
 
-#define BQ256XX_NUM_WD_VAL	8
+#define BQ256XX_NUM_WD_VAL	4
 #define BQ256XX_WATCHDOG_MASK	GENMASK(5, 4)
 #define BQ256XX_WATCHDOG_MAX	1600000
 #define BQ256XX_WATCHDOG_DIS	0
@@ -1508,6 +1508,10 @@ static int bq256xx_hw_init(struct bq256xx_device *bq)
 	int i;
 
 	for (i = 0; i < BQ256XX_NUM_WD_VAL; i++) {
+		if (bq->watchdog_timer == bq256xx_watchdog_time[i]) {
+			wd_reg_val = i;
+			break;
+		}
 		if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
 		    bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
 			wd_reg_val = i;
-- 
2.30.0

