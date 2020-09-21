Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171F62724D0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Sep 2020 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgIUNLg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Sep 2020 09:11:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727455AbgIUNKz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:55 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0894D7546E7C1BE89E59;
        Mon, 21 Sep 2020 21:10:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:44 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-pm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] thermal: stm32: simplify the return expression of stm_thermal_prepare()
Date:   Mon, 21 Sep 2020 21:11:07 +0800
Message-ID: <20200921131107.93273-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/thermal/st/stm_thermal.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index 331e2b768..5fd3fb891 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -446,14 +446,9 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
 #ifdef CONFIG_PM_SLEEP
 static int stm_thermal_suspend(struct device *dev)
 {
-	int ret;
 	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
 
-	ret = stm_thermal_sensor_off(sensor);
-	if (ret)
-		return ret;
-
-	return 0;
+	return stm_thermal_sensor_off(sensor);
 }
 
 static int stm_thermal_resume(struct device *dev)
-- 
2.23.0

