Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01ED76BE1A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfGQOTL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 10:19:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33980 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbfGQOTL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jul 2019 10:19:11 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 68D1BC5C673E4A53180A;
        Wed, 17 Jul 2019 22:19:07 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 17 Jul 2019
 22:18:58 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sre@kernel.org>, <linus.walleij@linaro.org>,
        <lee.jones@linaro.org>, <loic.pallardy@st.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] power: supply: ab8500: remove set but not used variables 'vbup33_vrtcn' and 'bup_vch_range'
Date:   Wed, 17 Jul 2019 22:18:48 +0800
Message-ID: <20190717141848.31116-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warnings:

drivers/power/supply/ab8500_charger.c:
 In function ab8500_charger_init_hw_registers:
drivers/power/supply/ab8500_charger.c:3013:24: warning:
 variable vbup33_vrtcn set but not used [-Wunused-but-set-variable]
drivers/power/supply/ab8500_charger.c:3013:5: warning:
 variable bup_vch_range set but not used [-Wunused-but-set-variable]

They are not used since commit 4c4268dc97c4 ("power:
supply: ab8500: Drop AB8540/9540 support")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: Fix patch title
---
 drivers/power/supply/ab8500_charger.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 30de448..270a48a 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -3010,7 +3010,6 @@ static int ab8500_charger_usb_get_property(struct power_supply *psy,
 static int ab8500_charger_init_hw_registers(struct ab8500_charger *di)
 {
 	int ret = 0;
-	u8 bup_vch_range = 0, vbup33_vrtcn = 0;
 
 	/* Setup maximum charger current and voltage for ABB cut2.0 */
 	if (!is_ab8500_1p1_or_earlier(di->parent)) {
@@ -3111,12 +3110,6 @@ static int ab8500_charger_init_hw_registers(struct ab8500_charger *di)
 		goto out;
 	}
 
-	/* Backup battery voltage and current */
-	if (di->bm->bkup_bat_v > BUP_VCH_SEL_3P1V)
-		bup_vch_range = BUP_VCH_RANGE;
-	if (di->bm->bkup_bat_v == BUP_VCH_SEL_3P3V)
-		vbup33_vrtcn = VBUP33_VRTCN;
-
 	ret = abx500_set_register_interruptible(di->dev,
 		AB8500_RTC,
 		AB8500_RTC_BACKUP_CHG_REG,
-- 
2.7.4


