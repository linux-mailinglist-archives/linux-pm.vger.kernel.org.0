Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 372AD13F4C4
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 19:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389265AbgAPSva (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 13:51:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45870 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389571AbgAPRJD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 12:09:03 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1is8dh-0001uN-1q; Thu, 16 Jan 2020 17:09:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] power: supply: bq25890_charger: fix incorrect error return when bq25890_field_read fails
Date:   Thu, 16 Jan 2020 17:09:00 +0000
Message-Id: <20200116170900.86548-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently a read failure by bq25890_field_read on F_DEV_REV is returning
an error in id instead of rev. Fix this by returning the value in rev.

Addresses-Coverity: ("Copy-paste error")
Fixes: d20267c9a98e ("power: supply: bq25890_charger: Add support of BQ25892 and BQ25896 chips")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/bq25890_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 785dbc6307b0..aebd1253dbc9 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -765,7 +765,7 @@ static int bq25890_get_chip_version(struct bq25890_device *bq)
 	rev = bq25890_field_read(bq, F_DEV_REV);
 	if (rev < 0) {
 		dev_err(bq->dev, "Cannot read chip revision.\n");
-		return id;
+		return rev;
 	}
 
 	switch (id) {
-- 
2.24.0

