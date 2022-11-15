Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BDF62942F
	for <lists+linux-pm@lfdr.de>; Tue, 15 Nov 2022 10:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiKOJVU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Nov 2022 04:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiKOJVT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2022 04:21:19 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206051F4
        for <linux-pm@vger.kernel.org>; Tue, 15 Nov 2022 01:21:18 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NBLJS39pBz15MZZ;
        Tue, 15 Nov 2022 17:20:56 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 17:21:16 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 15 Nov
 2022 17:21:16 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-pm@vger.kernel.org>
CC:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>,
        <songyuanzheng@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH] thermal: core: fix some possible name leaks in error paths
Date:   Tue, 15 Nov 2022 17:19:45 +0800
Message-ID: <20221115091945.921469-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In some error paths before device_register(), the names allocated
by dev_set_name() are not freed. Move dev_set_name() front to
device_register(), so the name can be freed while calling
put_device().

Fixes: 1dd7128b839f ("thermal/core: Fix null pointer dereference in thermal_release()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/thermal/thermal_core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 117eeaf7dd24..46c7adf0a1fc 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -883,10 +883,6 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->id = ret;
 	id = ret;
 
-	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
-	if (ret)
-		goto out_ida_remove;
-
 	cdev->type = kstrdup(type ? type : "", GFP_KERNEL);
 	if (!cdev->type) {
 		ret = -ENOMEM;
@@ -901,6 +897,11 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
 	thermal_cooling_device_setup_sysfs(cdev);
+	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
+	if (ret) {
+		thermal_cooling_device_destroy_sysfs(cdev);
+		goto out_ida_remove;
+	}
 	ret = device_register(&cdev->device);
 	if (ret)
 		goto out_kfree_type;
@@ -1234,10 +1235,6 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	tz->id = id;
 	strscpy(tz->type, type, sizeof(tz->type));
 
-	result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
-	if (result)
-		goto remove_id;
-
 	if (!ops->critical)
 		ops->critical = thermal_zone_device_critical;
 
@@ -1260,6 +1257,11 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	/* A new thermal zone needs to be updated anyway. */
 	atomic_set(&tz->need_update, 1);
 
+	result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
+	if (result) {
+		thermal_zone_destroy_device_groups(tz);
+		goto remove_id;
+	}
 	result = device_register(&tz->device);
 	if (result)
 		goto release_device;
-- 
2.25.1

