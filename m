Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE451BA10A
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgD0KX1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 06:23:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37460 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbgD0KX0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 06:23:26 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D3CCC7C7865E4E374FC9;
        Mon, 27 Apr 2020 18:23:23 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Apr 2020 18:23:16 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [RFC PATCH] cpuidle: Make cpuidle governor switchable to be the default behaviour
Date:   Mon, 27 Apr 2020 18:17:17 +0800
Message-ID: <1587982637-33618-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For now cpuidle governor can be switched via sysfs only when the
boot option "cpuidle_sysfs_switch" is passed, but it's important
to switch the governor to adapt to different workloads, especially
after TEO and haltpoll governor were introduced.

Introduce a CONFIG option to make cpuidle governor switchable to be
the default behaviour, which will not break the boot option behaviour.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/cpuidle/Kconfig | 9 +++++++++
 drivers/cpuidle/sysfs.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c0aeedd..c40cb40 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -47,6 +47,15 @@ config CPU_IDLE_GOV_HALTPOLL
 config DT_IDLE_STATES
 	bool
 
+config CPU_IDLE_SWITCH_GOV_IN_DEFAULT
+	bool "Switch the CPU idle governor via sysfs at runtime in default behaviour"
+	help
+	  Make the CPU idle governor switchable at runtime, and make it as the
+	  default behaviour even the boot option "cpuidle_sysfs_switch" is not
+	  passed in cmdline.
+
+	  Say N if you unsure about this.
+
 menu "ARM CPU Idle Drivers"
 depends on ARM || ARM64
 source "drivers/cpuidle/Kconfig.arm"
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index d3ef1d7..43701da 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -146,7 +146,7 @@ static DEVICE_ATTR(current_governor, 0644, show_current_governor,
  */
 int cpuidle_add_interface(struct device *dev)
 {
-	if (sysfs_switch)
+	if (IS_ENABLED(CONFIG_CPU_IDLE_SWITCH_GOV_IN_DEFAULT) || sysfs_switch)
 		cpuidle_attr_group.attrs = cpuidle_switch_attrs;
 
 	return sysfs_create_group(&dev->kobj, &cpuidle_attr_group);
-- 
1.7.12.4

