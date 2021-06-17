Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D942D3ABB5B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jun 2021 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhFQSZG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 14:25:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:6645 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231193AbhFQSZG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Jun 2021 14:25:06 -0400
IronPort-SDR: a5dJkqjWnYtxqve8cct/8R++WMhBEkcQ1qKLOPl1FEaSb8Qp7GyxoM4Q0ZNeipIHJpxvB+nx8Z
 57MRInAfEd6A==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193741151"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="193741151"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 11:22:52 -0700
IronPort-SDR: tZ7JsTrA3+H4qLRsBwtwz21bprP5B7L6wHAn+2TArLopF2g7qOzdpVee/GFn/YDBWqGOjZEz0d
 eI0Gs4MiKniA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="452868339"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jun 2021 11:22:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E7B73262; Thu, 17 Jun 2021 21:23:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] power: supply: bq24190_charger: drop of_match_ptr() from device ID table
Date:   Thu, 17 Jun 2021 21:23:10 +0300
Message-Id: <20210617182310.60503-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr() does not have any sense (this also allows ACPI
matching via PRP0001, even though it might be not relevant here). This
fixes compile warning (!CONFIG_OF):

  drivers/power/supply/bq24190_charger.c:1972:34: warning: ‘bq24190_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/power/supply/bq24190_charger.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 852e86bfe2fb..35ff0c8fe96f 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -5,11 +5,10 @@
  * Author: Mark A. Greer <mgreer@animalcreek.com>
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <linux/of_irq.h>
-#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/power_supply.h>
 #include <linux/power/bq24190_charger.h>
@@ -1959,7 +1958,6 @@ static const struct i2c_device_id bq24190_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
 
-#ifdef CONFIG_OF
 static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24190", },
 	{ .compatible = "ti,bq24192", },
@@ -1968,11 +1966,6 @@ static const struct of_device_id bq24190_of_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq24190_of_match);
-#else
-static const struct of_device_id bq24190_of_match[] = {
-	{ },
-};
-#endif
 
 static struct i2c_driver bq24190_driver = {
 	.probe		= bq24190_probe,
@@ -1981,7 +1974,7 @@ static struct i2c_driver bq24190_driver = {
 	.driver = {
 		.name		= "bq24190-charger",
 		.pm		= &bq24190_pm_ops,
-		.of_match_table	= of_match_ptr(bq24190_of_match),
+		.of_match_table	= bq24190_of_match,
 	},
 };
 module_i2c_driver(bq24190_driver);
-- 
2.30.2

