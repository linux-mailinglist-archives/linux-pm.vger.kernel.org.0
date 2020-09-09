Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B5F262DFC
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 13:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgIILi3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 07:38:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:32866 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728709AbgIILgl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Sep 2020 07:36:41 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 976FF92641C7417C624E;
        Wed,  9 Sep 2020 19:20:13 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 19:20:07 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Sebastian Reichel <sre@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-pm@vger.kernel.org>
Subject: [PATCH -next] power: supply: charger-manager: Remove unused but set variable 'charger'
Date:   Wed, 9 Sep 2020 19:29:17 +0800
Message-ID: <20200909112917.5071-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Gcc report warning as follows:

drivers/power/supply/charger-manager.c:1626:29: warning:
 variable 'charger' set but not used [-Wunused-but-set-variable]
 1626 |   struct charger_regulator *charger;
      |                             ^~~~~~~

After c1f73028f75d ("power: supply: charger-manager: Update extcon
functions"), 'charger' is never be used, so removing it to avoid
build warning.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: c1f73028f75d ("power: supply: charger-manager: Update extcon functions")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/power/supply/charger-manager.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index 07992821e252..b2ca79173f95 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1622,13 +1622,8 @@ static int charger_manager_probe(struct platform_device *pdev)
 	return 0;
 
 err_reg_extcon:
-	for (i = 0; i < desc->num_charger_regulators; i++) {
-		struct charger_regulator *charger;
-
-		charger = &desc->charger_regulators[i];
-
+	for (i = 0; i < desc->num_charger_regulators; i++)
 		regulator_put(desc->charger_regulators[i].consumer);
-	}
 
 	power_supply_unregister(cm->charger_psy);
 

