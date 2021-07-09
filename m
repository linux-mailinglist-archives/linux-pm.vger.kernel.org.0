Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9A93C1D6E
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 04:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhGIC0t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 22:26:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6773 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhGIC0t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 22:26:49 -0400
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GLcK54WvBzXr3N
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 10:18:33 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 9 Jul
 2021 10:24:04 +0800
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Subject: Question about __pm_runtime_disable()
To:     <rafael.j.wysocki@intel.com>
CC:     <linuxarm@huawei.com>, Linux PM <linux-pm@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Message-ID: <4c65cdd3-05cd-499d-0dd1-b7d6e76372b1@hisilicon.com>
Date:   Fri, 9 Jul 2021 10:24:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael and other guys,

I encounter a runtime PM issue: there are four devices, and device 0 is 
the parent device, and device 1/2/3 are the children devices of device 0.

All of them supports runtime PM. But i want to ignore device2 and 
device3, so that if device 1 is suspended, then device0 can

be suspended. I use function pm_runtime_disable() to disable device2 and 
device3, and device 1 is suspended but device0 is still active.

I find that runtime_active_kids of device0 is still 2 though 
runtime_usage = 0, so it doesn't enter suspend status.

And i hack the code of funciton __pm_runtime_disable() to decrease 
child_count of device's parent as follows, and it works.

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index b570848..6ba224b 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1382,6 +1382,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_barrier);
   */
  void __pm_runtime_disable(struct device *dev, bool check_resume)
  {
+       struct device *parent = NULL;
+
         spin_lock_irq(&dev->power.lock);

         if (dev->power.disable_depth > 0) {
@@ -1413,6 +1415,10 @@ void __pm_runtime_disable(struct device *dev, 
bool check_resume)
         if (!dev->power.disable_depth++)
                 __pm_runtime_barrier(dev);

+       if (dev->parent) {
+               parent = dev->parent;
+               atomic_add_unless(&parent->power.child_count, -1, 0);
+       }
   out:
         spin_unlock_irq(&dev->power.lock);
  }

Is it appropriate for me to use function pm_runtime_disable() to ignore 
them (i try function function pm_suspend_ignore_children(), but it 
ignores all children of the device )?
Or does it need to decrease child_count the device's parent in function 
__pm_runtime_disable() ?


Best Regard,
Xiang Chen


