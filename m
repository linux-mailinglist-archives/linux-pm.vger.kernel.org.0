Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4E31D901E
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 08:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgESGcd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 02:32:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726859AbgESGcd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 May 2020 02:32:33 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C405C9B8A8B51C3C864B;
        Tue, 19 May 2020 14:32:23 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 14:32:17 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
CC:     <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 4/6] cpuidle: sysfs: Remove sysfs_switch and switch attributes
Date:   Tue, 19 May 2020 14:25:23 +0800
Message-ID: <1589869525-29893-5-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1589869525-29893-1-git-send-email-guohanjun@huawei.com>
References: <1589869525-29893-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since the cpuidle governor can be switched via sysfs in default,
remove sysfs_switch and cpuidle_switch_attrs.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/sysfs.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index b51c470d..14c0eb5 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -18,14 +18,6 @@
 
 #include "cpuidle.h"
 
-static unsigned int sysfs_switch;
-static int __init cpuidle_sysfs_setup(char *unused)
-{
-	sysfs_switch = 1;
-	return 1;
-}
-__setup("cpuidle_sysfs_switch", cpuidle_sysfs_setup);
-
 static ssize_t show_available_governors(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -112,7 +104,7 @@ static DEVICE_ATTR(current_governor, 0644, show_current_governor,
 				   store_current_governor);
 static DEVICE_ATTR(current_governor_ro, 0444, show_current_governor, NULL);
 
-static struct attribute *cpuidle_default_attrs[] = {
+static struct attribute *cpuidle_attrs[] = {
 	&dev_attr_available_governors.attr,
 	&dev_attr_current_driver.attr,
 	&dev_attr_current_governor.attr,
@@ -120,15 +112,8 @@ static DEVICE_ATTR(current_governor, 0644, show_current_governor,
 	NULL
 };
 
-static struct attribute *cpuidle_switch_attrs[] = {
-	&dev_attr_available_governors.attr,
-	&dev_attr_current_driver.attr,
-	&dev_attr_current_governor.attr,
-	NULL
-};
-
 static struct attribute_group cpuidle_attr_group = {
-	.attrs = cpuidle_default_attrs,
+	.attrs = cpuidle_attrs,
 	.name = "cpuidle",
 };
 
@@ -138,9 +123,6 @@ static DEVICE_ATTR(current_governor, 0644, show_current_governor,
  */
 int cpuidle_add_interface(struct device *dev)
 {
-	if (sysfs_switch)
-		cpuidle_attr_group.attrs = cpuidle_switch_attrs;
-
 	return sysfs_create_group(&dev->kobj, &cpuidle_attr_group);
 }
 
-- 
1.7.12.4

