Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5544942D55E
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 10:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhJNIuC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 04:50:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14351 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhJNIuB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Oct 2021 04:50:01 -0400
Received: from dggeml757-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HVNG029Sfz8yqy;
        Thu, 14 Oct 2021 16:43:04 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 dggeml757-chm.china.huawei.com (10.1.199.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 14 Oct 2021 16:47:54 +0800
From:   Ziyang Xuan <william.xuanziyang@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>
CC:     <rui.zhang@intel.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] thermal/core: fix a UAF bug in __thermal_cooling_device_register()
Date:   Thu, 14 Oct 2021 16:47:00 +0800
Message-ID: <20211014084700.202420-1-william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeml757-chm.china.huawei.com (10.1.199.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When device_register() return failed, program will goto out_kfree_type
to release 'cdev->device' by put_device(). That will call thermal_release()
to free 'cdev'. But the follow-up processes access 'cdev' continually.
That trggers the UAF bug.

====================================================================
BUG: KASAN: use-after-free in __thermal_cooling_device_register+0x75b/0xa90
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 dump_stack_lvl+0xe2/0x152
 print_address_description.constprop.0+0x21/0x140
 ? __thermal_cooling_device_register+0x75b/0xa90
 kasan_report.cold+0x7f/0x11b
 ? __thermal_cooling_device_register+0x75b/0xa90
 __thermal_cooling_device_register+0x75b/0xa90
 ? memset+0x20/0x40
 ? __sanitizer_cov_trace_pc+0x1d/0x50
 ? __devres_alloc_node+0x130/0x180
 devm_thermal_of_cooling_device_register+0x67/0xf0
 max6650_probe.cold+0x557/0x6aa
......

Freed by task 258:
 kasan_save_stack+0x1b/0x40
 kasan_set_track+0x1c/0x30
 kasan_set_free_info+0x20/0x30
 __kasan_slab_free+0x109/0x140
 kfree+0x117/0x4c0
 thermal_release+0xa0/0x110
 device_release+0xa7/0x240
 kobject_put+0x1ce/0x540
 put_device+0x20/0x30
 __thermal_cooling_device_register+0x731/0xa90
 devm_thermal_of_cooling_device_register+0x67/0xf0
 max6650_probe.cold+0x557/0x6aa [max6650]

Do not use 'cdev' again after put_device() to fix the problem like doing
in thermal_zone_device_register().

Fixes: 584837618100 ("thermal/drivers/core: Use a char pointer for the cooling device name")
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 drivers/thermal/thermal_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 97ef9b040b84..ee7453944ccb 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -888,7 +888,7 @@ __thermal_cooling_device_register(struct device_node *np,
 {
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
-	int ret;
+	int id, ret;
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
 	    !ops->set_cur_state)
@@ -898,10 +898,10 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
-	ret = ida_simple_get(&thermal_cdev_ida, 0, 0, GFP_KERNEL);
-	if (ret < 0)
+	id = ida_simple_get(&thermal_cdev_ida, 0, 0, GFP_KERNEL);
+	if (id < 0)
 		goto out_kfree_cdev;
-	cdev->id = ret;
+	cdev->id = id;
 
 	cdev->type = kstrdup(type ? type : "", GFP_KERNEL);
 	if (!cdev->type) {
@@ -942,8 +942,9 @@ __thermal_cooling_device_register(struct device_node *np,
 out_kfree_type:
 	kfree(cdev->type);
 	put_device(&cdev->device);
+	cdev = NULL;
 out_ida_remove:
-	ida_simple_remove(&thermal_cdev_ida, cdev->id);
+	ida_simple_remove(&thermal_cdev_ida, id);
 out_kfree_cdev:
 	kfree(cdev);
 	return ERR_PTR(ret);
-- 
2.25.1

