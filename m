Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA4F249235
	for <lists+linux-pm@lfdr.de>; Wed, 19 Aug 2020 03:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHSBRS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Aug 2020 21:17:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44916 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbgHSBRN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Aug 2020 21:17:13 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A453F638830F4077E796;
        Wed, 19 Aug 2020 09:17:10 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 09:16:36 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amit.kucheria@verdurent.com>, <linux-pm@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH] thermal: Use kobj_to_dev() instead of container_of()
Date:   Wed, 19 Aug 2020 09:14:31 +0800
Message-ID: <1597799671-11530-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use kobj_to_dev() instead of container_of()

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/thermal/thermal_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 8c23121..a6f371f 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -448,7 +448,7 @@ static umode_t thermal_zone_passive_is_visible(struct kobject *kobj,
 					       struct attribute *attr,
 					       int attrno)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct thermal_zone_device *tz;
 	enum thermal_trip_type trip_type;
 	int count, passive = 0;
-- 
2.7.4

