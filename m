Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B6C2877BE
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 17:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbgJHPoM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 11:44:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60819 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730958AbgJHPoM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 11:44:12 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kQY5Q-0000fq-7C; Thu, 08 Oct 2020 15:44:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rhyland Klein <rklein@nvidia.com>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: Fix sizeof() mismatch
Date:   Thu,  8 Oct 2020 16:44:07 +0100
Message-Id: <20201008154407.102824-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An incorrect sizeof() is being used, sizeof(psy->supplied_from) is not
correct, it should be sizeof(*psy->supplied_from).  This bug did not
cause any issues because it just so happens the sizes are the same.

Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
Fixes: f6e0b081fb30 ("power_supply: Populate supplied_from hierarchy from the device tree")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/power/supply/power_supply_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 38e3aa642131..50f323740c74 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -261,7 +261,8 @@ static int power_supply_check_supplies(struct power_supply *psy)
 		return 0;
 
 	/* All supplies found, allocate char ** array for filling */
-	psy->supplied_from = devm_kzalloc(&psy->dev, sizeof(psy->supplied_from),
+	psy->supplied_from = devm_kzalloc(&psy->dev,
+					  sizeof(*psy->supplied_from),
 					  GFP_KERNEL);
 	if (!psy->supplied_from)
 		return -ENOMEM;
-- 
2.27.0

