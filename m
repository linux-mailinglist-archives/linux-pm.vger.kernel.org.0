Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DAF1BF355
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 10:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgD3Iqb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 04:46:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3395 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726766AbgD3Iqb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Apr 2020 04:46:31 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 557EB5F83E79386DA22A;
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
Subject: [RFC v2 PATCH 2/6] cpuidle: sysfs: Accept governor name with 15 characters
Date:   Thu, 30 Apr 2020 16:39:43 +0800
Message-ID: <1588235987-12300-3-git-send-email-guohanjun@huawei.com>
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

CPUIDLE_NAME_LEN is 16, so it's possible to accept governor name
with 15 characters, but now store_current_governor() rejects
governor name with 15 characters as it returns -EINVAL if count
equals CPUIDLE_NAME_LEN.

Refactor the code to accept such case and simplify the code.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/cpuidle/sysfs.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 3485210..af5a65f 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -85,34 +85,25 @@ static ssize_t store_current_governor(struct device *dev,
 				      struct device_attribute *attr,
 				      const char *buf, size_t count)
 {
-	char gov_name[CPUIDLE_NAME_LEN];
-	int ret = -EINVAL;
-	size_t len = count;
+	char gov_name[CPUIDLE_NAME_LEN + 1];
+	int ret;
 	struct cpuidle_governor *gov;
 
-	if (!len || len >= sizeof(gov_name))
+	ret = sscanf(buf, "%" __stringify(CPUIDLE_NAME_LEN) "s", gov_name);
+	if (ret != 1)
 		return -EINVAL;
 
-	memcpy(gov_name, buf, len);
-	gov_name[len] = '\0';
-	if (gov_name[len - 1] == '\n')
-		gov_name[--len] = '\0';
-
 	mutex_lock(&cpuidle_lock);
-
+	ret = -EINVAL;
 	list_for_each_entry(gov, &cpuidle_governors, governor_list) {
-		if (strlen(gov->name) == len && !strcmp(gov->name, gov_name)) {
+		if (!strncmp(gov->name, gov_name, CPUIDLE_NAME_LEN)) {
 			ret = cpuidle_switch_governor(gov);
 			break;
 		}
 	}
-
 	mutex_unlock(&cpuidle_lock);
 
-	if (ret)
-		return ret;
-	else
-		return count;
+	return ret ? ret : count;
 }
 
 static DEVICE_ATTR(current_driver, 0444, show_current_driver, NULL);
-- 
1.7.12.4

