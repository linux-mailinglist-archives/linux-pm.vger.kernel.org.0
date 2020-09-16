Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56EC26BCCA
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 08:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgIPGVH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 02:21:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46576 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbgIPGVG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Sep 2020 02:21:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 36CA992F4AB5C7079307;
        Wed, 16 Sep 2020 14:21:04 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 14:20:58 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] thermal: core: remove unnecessary mutex_init()
Date:   Wed, 16 Sep 2020 14:21:39 +0800
Message-ID: <20200916062139.191233-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The mutex poweroff_lock is initialized statically. It is
unnecessary to initialize by mutex_init().

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/thermal/thermal_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index a6616e530..49ae4a61c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1652,7 +1652,6 @@ static int __init thermal_init(void)
 	if (result)
 		goto error;
 
-	mutex_init(&poweroff_lock);
 	result = thermal_register_governors();
 	if (result)
 		goto error;
-- 
2.23.0

