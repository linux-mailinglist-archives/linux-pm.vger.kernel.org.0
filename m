Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72421F9330
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 15:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfKLOv5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 09:51:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727607AbfKLOv4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 09:51:56 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 191453D20E3DC7DFCD79;
        Tue, 12 Nov 2019 22:51:54 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 12 Nov 2019
 22:51:43 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <amit.kucheria@verdurent.com>,
        <qperret@google.com>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] thermal: power_allocator: Fix Kconfig warning
Date:   Tue, 12 Nov 2019 22:51:14 +0800
Message-ID: <20191112145114.36580-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When do randbuiding, we got this:

WARNING: unmet direct dependencies detected for THERMAL_GOV_POWER_ALLOCATOR
  Depends on [n]: THERMAL [=y] && ENERGY_MODEL [=n]
  Selected by [y]:
  - THERMAL_DEFAULT_GOV_POWER_ALLOCATOR [=y] && <choice>

Make THERMAL_DEFAULT_GOV_POWER_ALLOCATOR also depends on ENERGY_MODEL.

Fixes: a4e893e802e6 ("thermal: cpu_cooling: Migrate to using the EM framework")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/thermal/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 59b79fc..5e9e038 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -108,6 +108,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
 
 config THERMAL_DEFAULT_GOV_POWER_ALLOCATOR
 	bool "power_allocator"
+	depends on ENERGY_MODEL
 	select THERMAL_GOV_POWER_ALLOCATOR
 	help
 	  Select this if you want to control temperature based on
-- 
2.7.4


