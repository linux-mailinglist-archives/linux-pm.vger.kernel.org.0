Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F227426336B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 19:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgIIRDo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 13:03:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11759 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730349AbgIIPq3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Sep 2020 11:46:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CEF1D1ADD43EFCF8CF07;
        Wed,  9 Sep 2020 21:44:58 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:44:49 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <edubezval@gmail.com>, <j-keerthy@ti.com>, <rui.zhang@intel.com>,
        <daniel.lezcano@linaro.org>, <amitk@kernel.org>,
        <sudipm.mukherjee@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] thermal: ti-soc-thermal: Remove unused function ti_thermal_get_temp()
Date:   Wed, 9 Sep 2020 21:44:48 +0800
Message-ID: <20200909134448.30344-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

commit b263b473bf62 ("thermal: ti-soc-thermal: Remove redundant code")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 2ce4b19f312a..93b28c7ce83d 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -106,14 +106,6 @@ static inline int __ti_thermal_get_temp(void *devdata, int *temp)
 	return ret;
 }
 
-static inline int ti_thermal_get_temp(struct thermal_zone_device *thermal,
-				      int *temp)
-{
-	struct ti_thermal_data *data = thermal->devdata;
-
-	return __ti_thermal_get_temp(data, temp);
-}
-
 static int __ti_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
 {
 	struct ti_thermal_data *data = p;
-- 
2.17.1


