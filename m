Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CF523CE04
	for <lists+linux-pm@lfdr.de>; Wed,  5 Aug 2020 20:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgHESGO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Aug 2020 14:06:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39394 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgHESEG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2020 14:04:06 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k3Goz-0004ck-PC; Wed, 05 Aug 2020 10:38:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: pm2301_charger: fix spelling mistake "chargind" -> "charging"
Date:   Wed,  5 Aug 2020 11:38:57 +0100
Message-Id: <20200805103857.15725-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/pm2301_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply/pm2301_charger.c
index 17749fc90e16..787867805944 100644
--- a/drivers/power/supply/pm2301_charger.c
+++ b/drivers/power/supply/pm2301_charger.c
@@ -396,7 +396,7 @@ static int pm2_int_reg3(void *pm2_data, int val)
 
 	if (val & (PM2XXX_INT4_ITCHARGINGON)) {
 		dev_dbg(pm2->dev ,
-			"chargind operation has started\n");
+			"charging operation has started\n");
 	}
 
 	if (val & (PM2XXX_INT4_ITVRESUME)) {
-- 
2.27.0

