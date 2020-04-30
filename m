Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C4C1BF350
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 10:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgD3IqY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 04:46:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3349 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbgD3IqX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Apr 2020 04:46:23 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 898E14AE9353540B38F3;
        Thu, 30 Apr 2020 16:46:20 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 16:46:11 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
CC:     <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [RFC v2 PATCH 4/6] cpuidle: sysfs: Remove sysfs_switch and switch attributes
Date:   Thu, 30 Apr 2020 16:39:45 +0800
Message-ID: <1588235987-12300-5-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1588235987-12300-1-git-send-email-guohanjun@huawei.com>
References: <1588235987-12300-1-git-send-email-guohanjun@huawei.com>
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
---
 drivers/cpuidle/sysfs.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 2425c6a..c3bbfc7 100644
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

