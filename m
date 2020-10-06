Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61941285075
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 19:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJFRGE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 13:06:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52535 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgJFRGE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 13:06:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kPqPY-00052b-S3; Tue, 06 Oct 2020 17:06:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: bq25980: remove redundant zero check on ret
Date:   Tue,  6 Oct 2020 18:06:00 +0100
Message-Id: <20201006170600.545361-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently ret is assigned to zero and the following statement checks
if it is non-zero. This check is redundant and can be removed

Addresses-Coverity: ("Logically dead code")
Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259xx family")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/bq25980_charger.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 3995fb7cf060..f04f9acdb13b 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -613,9 +613,6 @@ static int bq25980_set_battery_property(struct power_supply *psy,
 	struct bq25980_device *bq = power_supply_get_drvdata(psy);
 	int ret = 0;
 
-	if (ret)
-		return ret;
-
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 		ret = bq25980_set_const_charge_curr(bq, val->intval);
-- 
2.27.0

