Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E852AB7DE
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 13:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgKIMKv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 07:10:51 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:54059 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729451AbgKIMKu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 07:10:50 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5283855|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0188708-0.00136702-0.979762;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.IuVM-82_1604923842;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IuVM-82_1604923842)
          by smtp.aliyun-inc.com(10.147.42.22);
          Mon, 09 Nov 2020 20:10:46 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     sre@kernel.org, wens@csie.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, tiny.windzz@gmail.com
Cc:     Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH 1/3] power: supply: axp20x_usb_power: fix typo
Date:   Mon,  9 Nov 2020 20:10:38 +0800
Message-Id: <20201109121038.17840-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

s/on on/on

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/power/supply/axp20x_usb_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 0eaa86c52874..3b4fd710347d 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -397,7 +397,7 @@ static int axp20x_usb_power_prop_writeable(struct power_supply *psy,
 	struct axp20x_usb_power *power = power_supply_get_drvdata(psy);
 
 	/*
-	 * The VBUS path select flag works differently on on AXP288 and newer:
+	 * The VBUS path select flag works differently on AXP288 and newer:
 	 *  - On AXP20x and AXP22x, the flag enables VBUS (ignoring N_VBUSEN).
 	 *  - On AXP288 and AXP8xx, the flag disables VBUS (ignoring N_VBUSEN).
 	 * We only expose the control on variants where it can be used to force
-- 
2.28.0

