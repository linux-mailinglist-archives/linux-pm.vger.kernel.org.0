Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942E142EBE4
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 10:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbhJOIVj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 04:21:39 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14356 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbhJOIT7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 04:19:59 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HVzXq6026z8yrq;
        Fri, 15 Oct 2021 16:12:59 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (7.185.36.106) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 16:17:51 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 16:17:51 +0800
From:   Yuanzheng Song <songyuanzheng@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] Fix null pointer dereference in thermal_release()
Date:   Fri, 15 Oct 2021 08:32:30 +0000
Message-ID: <20211015083230.67658-1-songyuanzheng@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If both dev_set_name() and device_register() failed, then
null pointer dereference occurs in thermal_release() which
will use strncmp() to compare the name.

So fix it by adding dev_set_name() return value check.

Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
---
 drivers/thermal/thermal_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9e243d9f929e..6904b97fd6ea 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -904,6 +904,10 @@ __thermal_cooling_device_register(struct device_node *np,
 		goto out_kfree_cdev;
 	cdev->id = ret;
 
+	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
+	if (ret)
+		goto out_ida_remove;
+
 	cdev->type = kstrdup(type ? type : "", GFP_KERNEL);
 	if (!cdev->type) {
 		ret = -ENOMEM;
@@ -918,7 +922,6 @@ __thermal_cooling_device_register(struct device_node *np,
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;
 	thermal_cooling_device_setup_sysfs(cdev);
-	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	ret = device_register(&cdev->device);
 	if (ret)
 		goto out_kfree_type;
@@ -1229,6 +1232,10 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	tz->id = id;
 	strlcpy(tz->type, type, sizeof(tz->type));
 
+	result = dev_set_name(&tz->device, "thermal_zone%d", tz->id);
+	if (result)
+		goto remove_id;
+
 	if (!ops->critical)
 		ops->critical = thermal_zone_device_critical;
 
@@ -1250,7 +1257,6 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	/* A new thermal zone needs to be updated anyway. */
 	atomic_set(&tz->need_update, 1);
 
-	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
 	result = device_register(&tz->device);
 	if (result)
 		goto release_device;
-- 
2.25.1

