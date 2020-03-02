Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2FD1756AF
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 10:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgCBJOx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 04:14:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbgCBJOx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Mar 2020 04:14:53 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 113917080579DB15C0D0;
        Mon,  2 Mar 2020 17:14:50 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Mon, 2 Mar 2020 17:14:40 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <gregkh@linuxfoundation.org>, <christian.brauner@ubuntu.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <yaohongbo@huawei.com>, <chenzhou10@huawei.com>,
        <rjw@rjwysocki.net>, <pavel@ucw.cz>
Subject: [PATCH -next] drivers/base/power: fix build error without SYSFS
Date:   Mon, 2 Mar 2020 17:29:18 +0800
Message-ID: <20200302092918.40163-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If CONFIG_SYSFS=n, the following error is seen while building 
drivers/base/power/sysfs.c:

drivers/base/power/sysfs.c: In function dpm_sysfs_change_owner:
drivers/base/power/sysfs.c:708:44: error: passing argument 2 of
sysfs_group_change_owner from incompatible pointer type
[-Werror=incompatible-pointer-types]
  rc = sysfs_group_change_owner(&dev->kobj, &pm_attr_group, kuid, kgid);
                                            ^
In file included from ./include/linux/kobject.h:20:0,
                 from ./include/linux/device.h:17,
                 from drivers/base/power/sysfs.c:3:
./include/linux/sysfs.h:564:19: note: expected const struct
attribute_group ** but argument is of type const struct attribute_group *

dpm_sysfs_change_owner() should only used when CONFIG_SYSFS is
defined.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 3b52fc5d7876 ("drivers/base/power: add dpm_sysfs_change_owner()")
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 drivers/base/power/power.h | 10 +++++++++-
 drivers/base/power/sysfs.c |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 54292cdd7808..4bd88f696be9 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -74,7 +74,6 @@ extern int pm_qos_sysfs_add_flags(struct device *dev);
 extern void pm_qos_sysfs_remove_flags(struct device *dev);
 extern int pm_qos_sysfs_add_latency_tolerance(struct device *dev);
 extern void pm_qos_sysfs_remove_latency_tolerance(struct device *dev);
-extern int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
 
 #else /* CONFIG_PM */
 
@@ -89,6 +88,15 @@ static inline void pm_runtime_remove(struct device *dev) {}
 
 static inline int dpm_sysfs_add(struct device *dev) { return 0; }
 static inline void dpm_sysfs_remove(struct device *dev) {}
+
+#endif
+
+#if defined(CONFIG_PM) && defined(CONFIG_SYSFS)
+
+extern int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid);
+
+#else
+
 static inline int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid,
 					 kgid_t kgid) { return 0; }
 
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index 2b99fe1eb207..d6749f374ded 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -698,6 +698,7 @@ int dpm_sysfs_add(struct device *dev)
 	return rc;
 }
 
+#ifdef CONFIG_SYSFS
 int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 {
 	int rc;
@@ -736,6 +737,7 @@ int dpm_sysfs_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
 	}
 	return 0;
 }
+#endif
 
 int wakeup_sysfs_add(struct device *dev)
 {
-- 
2.17.1

