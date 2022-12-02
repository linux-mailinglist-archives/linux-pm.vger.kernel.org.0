Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1868D64039E
	for <lists+linux-pm@lfdr.de>; Fri,  2 Dec 2022 10:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiLBJpL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Dec 2022 04:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiLBJot (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2022 04:44:49 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20230C82C6
        for <linux-pm@vger.kernel.org>; Fri,  2 Dec 2022 01:44:48 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NNp1H5gfQz15N5W;
        Fri,  2 Dec 2022 17:44:03 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 2 Dec
 2022 17:44:45 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <sre@kernel.org>, <rafael.j.wysocki@intel.com>,
        <swboyd@chromium.org>
CC:     <linux-pm@vger.kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH] power: supply: fix missing device_del() in __power_supply_register()
Date:   Fri, 2 Dec 2022 17:42:39 +0800
Message-ID: <20221202094239.2130443-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I got the a UAF and some warning reports while doing fault injection test:

==================================================================
BUG: KASAN: use-after-free in power_supply_uevent+0x59/0x190
Read of size 8 at addr ffff8881092c3c58 by task systemd-udevd/268

CPU: 3 PID: 268 Comm: systemd-udevd Tainted: G                 N 6.1.0-rc3+
rt1719: probe of 0-0043 failed with error -17
Call Trace:
 <TASK>
 kasan_report+0x90/0x190
 power_supply_uevent+0x59/0x190
 dev_uevent+0x1c8/0x3d0
 uevent_show+0x10f/0x1c0

Allocated by task 253:
 __kasan_kmalloc+0x7e/0x90
 __kmalloc_node_track_caller+0x55/0x1b0
 devm_kmalloc+0x5e/0x110
 rt1719_probe+0xdf/0x770 [rt1719]

Freed by task 253:
 kasan_save_free_info+0x2a/0x50
 __kasan_slab_free+0x102/0x190
 __kmem_cache_free+0xca/0x400
 release_nodes+0x78/0xa0
 devres_release_group+0x171/0x200
==================================================================

sysfs: cannot create duplicate filename '/class/power_supply/rt1719-source-psy-0-0043'
CPU: 3 PID: 1140 Comm: 89-i2c-rt1719 Tainted: G    B   W        N 6.1.0-rc3+
Call Trace:
 <TASK>
 dump_stack_lvl+0x67/0x83
 sysfs_warn_dup.cold.3+0x1c/0x28
 sysfs_do_create_link_sd.isra.2+0x11d/0x130
 sysfs_create_link+0x4c/0x80
 device_add+0x55a/0x10f0
 __power_supply_register+0x863/0xae0
 devm_power_supply_register+0x5f/0xb0

device_add() is called before device_init_wakeup(), if device_init_wakeup()
fails, device_del() needs be called.

Leak of device in sysfs, it also causes UAF problem:

CPU A
rt1719_probe()			|CPU B
  //desc is allocated by driver	|
  devm_kmalloc()		|
  __power_supply_register()	|
    psy->desc = desc;		|
  //desc is freed		|
  release_nodes()		|
				|power_supply_uevent()
				|  psy = dev_get_drvdata(dev);
				|  add_uevent_var(psy->desc->name) <-- UAF

So move device_del() after the error label wakeup_init_failed to fix this leak.

Fixes: 828802228485 ("power: supply: Init device wakeup after device_add()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 4b5fb172fa99..9bae94d2ea3a 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1387,8 +1387,8 @@ __power_supply_register(struct device *parent,
 register_cooler_failed:
 	psy_unregister_thermal(psy);
 register_thermal_failed:
-	device_del(dev);
 wakeup_init_failed:
+	device_del(dev);
 device_add_failed:
 check_supplies_failed:
 dev_set_name_failed:
-- 
2.25.1

