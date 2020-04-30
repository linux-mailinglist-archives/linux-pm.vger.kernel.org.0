Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D461BF351
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 10:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgD3IqY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 04:46:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3398 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbgD3IqX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Apr 2020 04:46:23 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6F52DCA2C81BFA93F45E;
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
Subject: [RFC v2 PATCH 3/6] cpuidle: Make cpuidle governor switchable to be the default behaviour
Date:   Thu, 30 Apr 2020 16:39:44 +0800
Message-ID: <1588235987-12300-4-git-send-email-guohanjun@huawei.com>
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

For now cpuidle governor can be switched via sysfs only when the
boot option "cpuidle_sysfs_switch" is passed, but it's important
to switch the governor to adapt to different workloads, especially
after TEO and haltpoll governor were introduced.

Add available_governors and current_governor into the default
attributes, but reserve the current_governor_ro for temporal
compatibility.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/cpuidle/sysfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index af5a65f..2425c6a 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -106,19 +106,20 @@ static ssize_t store_current_governor(struct device *dev,
 	return ret ? ret : count;
 }
 
+static DEVICE_ATTR(available_governors, 0444, show_available_governors, NULL);
 static DEVICE_ATTR(current_driver, 0444, show_current_driver, NULL);
+static DEVICE_ATTR(current_governor, 0644, show_current_governor,
+				   store_current_governor);
 static DEVICE_ATTR(current_governor_ro, 0444, show_current_governor, NULL);
 
 static struct attribute *cpuidle_default_attrs[] = {
+	&dev_attr_available_governors.attr,
 	&dev_attr_current_driver.attr,
+	&dev_attr_current_governor.attr,
 	&dev_attr_current_governor_ro.attr,
 	NULL
 };
 
-static DEVICE_ATTR(available_governors, 0444, show_available_governors, NULL);
-static DEVICE_ATTR(current_governor, 0644, show_current_governor,
-		   store_current_governor);
-
 static struct attribute *cpuidle_switch_attrs[] = {
 	&dev_attr_available_governors.attr,
 	&dev_attr_current_driver.attr,
-- 
1.7.12.4

