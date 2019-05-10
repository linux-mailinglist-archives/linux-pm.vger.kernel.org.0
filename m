Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D421D198DD
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 09:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfEJHSw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 03:18:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726855AbfEJHSw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 May 2019 03:18:52 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6A9479CB491DD3E1EA86;
        Fri, 10 May 2019 15:18:48 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 May 2019
 15:18:40 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sre@kernel.org>, <andrew.smirnov@gmail.com>,
        <sebastian.reichel@collabora.com>, <enric.balletbo@collabora.com>,
        <linux@roeck-us.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] power: supply: ucs1002: Fix build error without CONFIG_REGULATOR
Date:   Fri, 10 May 2019 15:18:23 +0800
Message-ID: <20190510071823.2984-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix gcc build error while CONFIG_REGULATOR is not set

drivers/power/supply/ucs1002_power.o: In function `ucs1002_probe':
drivers/power/supply/ucs1002_power.c:593: undefined reference to `devm_regulator_register'
drivers/power/supply/ucs1002_power.o:(.rodata+0x3b8): undefined reference to `regulator_enable_regmap'
drivers/power/supply/ucs1002_power.o:(.rodata+0x3c0): undefined reference to `regulator_disable_regmap'
drivers/power/supply/ucs1002_power.o:(.rodata+0x3c8): undefined reference to `regulator_is_enabled_regmap'

Add Kconfig dependency to CONFIG_REGULATOR.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 9a2688e42638 ("power: supply: Add driver for Microchip UCS1002")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/power/supply/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index ef36bd2..26dacda 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -682,6 +682,7 @@ config CHARGER_UCS1002
 	tristate "Microchip UCS1002 USB Port Power Controller"
 	depends on I2C
 	depends on OF
+	depends on REGULATOR
 	select REGMAP_I2C
 	help
 	  Say Y to enable support for Microchip UCS1002 Programmable
-- 
2.7.4


