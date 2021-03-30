Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27A34E17E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Mar 2021 08:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhC3Gsu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Mar 2021 02:48:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14191 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhC3GsT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Mar 2021 02:48:19 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8g1v44gdzmc94;
        Tue, 30 Mar 2021 14:45:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 14:48:06 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <edubezval@gmail.com>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>
CC:     <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <fanghao11@huawei.com>
Subject: [PATCH] thermal/drivers/hisi: Use the correct HiSilicon copyright
Date:   Tue, 30 Mar 2021 14:45:33 +0800
Message-ID: <1617086733-2705-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

s/Hisilicon/HiSilicon/g.
It should use capital S, according to
https://www.hisilicon.com/en/terms-of-use.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
---
 drivers/thermal/hisi_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index ee05950..d902db9 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -1,7 +1,7 @@
 /*
- * Hisilicon thermal sensor driver
+ * HiSilicon thermal sensor driver
  *
- * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Copyright (c) 2014-2015 HiSilicon Limited.
  * Copyright (c) 2014-2015 Linaro Limited.
  *
  * Xinwei Kong <kong.kongxinwei@hisilicon.com>
@@ -672,5 +672,5 @@ module_platform_driver(hisi_thermal_driver);
 
 MODULE_AUTHOR("Xinwei Kong <kong.kongxinwei@hisilicon.com>");
 MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
-MODULE_DESCRIPTION("Hisilicon thermal driver");
+MODULE_DESCRIPTION("HiSilicon thermal driver");
 MODULE_LICENSE("GPL v2");
-- 
2.8.1

