Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C942E125956
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 02:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLSBqA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 20:46:00 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40006 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfLSBqA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 18 Dec 2019 20:46:00 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B8231A306D61336F4726;
        Thu, 19 Dec 2019 09:45:58 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 19 Dec 2019 09:45:49 +0800
From:   Ma Feng <mafeng.ma@huawei.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ma Feng <mafeng.ma@huawei.com>
Subject: [PATCH 1/3] power: supply: ab8500: Remove unneeded semicolon
Date:   Thu, 19 Dec 2019 09:46:29 +0800
Message-ID: <1576719991-109247-1-git-send-email-mafeng.ma@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes coccicheck warning:

drivers/power/supply/ab8500_fg.c:2224:5-6: Unneeded semicolon
drivers/power/supply/ab8500_fg.c:2227:4-5: Unneeded semicolon
drivers/power/supply/ab8500_fg.c:2334:3-4: Unneeded semicolon
drivers/power/supply/ab8500_fg.c:2342:3-4: Unneeded semicolon
drivers/power/supply/ab8500_fg.c:2350:3-4: Unneeded semicolon
drivers/power/supply/ab8500_fg.c:2358:3-4: Unneeded semicolon
drivers/power/supply/ab8500_fg.c:2366:3-4: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
---
 drivers/power/supply/ab8500_fg.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index c3912ee..b96f90a 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2221,10 +2221,10 @@ static int ab8500_fg_get_ext_psy_data(struct device *dev, void *data)
 						ab8500_fg_update_cap_scalers(di);
 					queue_work(di->fg_wq, &di->fg_work);
 					break;
-				};
+				}
 			default:
 				break;
-			};
+			}
 			break;
 		case POWER_SUPPLY_PROP_TECHNOLOGY:
 			switch (ext->desc->type) {
@@ -2331,7 +2331,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 		if (ret) {
 			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_MAX_TIME_REG\n", __func__);
 			goto out;
-		};
+		}
 
 		ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
 			AB8505_RTC_PCUT_FLAG_TIME_REG, di->bm->fg_params->pcut_flag_time);
@@ -2339,7 +2339,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 		if (ret) {
 			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_FLAG_TIME_REG\n", __func__);
 			goto out;
-		};
+		}
 
 		ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
 			AB8505_RTC_PCUT_RESTART_REG, di->bm->fg_params->pcut_max_restart);
@@ -2347,7 +2347,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 		if (ret) {
 			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_RESTART_REG\n", __func__);
 			goto out;
-		};
+		}
 
 		ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
 			AB8505_RTC_PCUT_DEBOUNCE_REG, di->bm->fg_params->pcut_debounce_time);
@@ -2355,7 +2355,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 		if (ret) {
 			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_DEBOUNCE_REG\n", __func__);
 			goto out;
-		};
+		}
 
 		ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
 			AB8505_RTC_PCUT_CTL_STATUS_REG, di->bm->fg_params->pcut_enable);
@@ -2363,7 +2363,7 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 		if (ret) {
 			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_CTL_STATUS_REG\n", __func__);
 			goto out;
-		};
+		}
 	}
 out:
 	return ret;
-- 
2.6.2

