Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5C1BF34D
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 10:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgD3IqW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 04:46:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3393 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726626AbgD3IqW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 30 Apr 2020 04:46:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6AA9EAF8174EEA4EDE8B;
        Thu, 30 Apr 2020 16:46:20 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 16:46:10 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
CC:     <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [RFC v2 PATCH 1/6] cpuidle: sysfs: Fix the overlap for showing available governors
Date:   Thu, 30 Apr 2020 16:39:42 +0800
Message-ID: <1588235987-12300-2-git-send-email-guohanjun@huawei.com>
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

When showing the available governors, it's "%s " in scnprintf(),
not "%s", so if the governor name has 15 characters, it will
overlap with the later one, fix it by adding one more for the
size.

While we are at it, fix the minor coding sytle as well.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/cpuidle/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index d3ef1d7..3485210 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -35,10 +35,10 @@ static ssize_t show_available_governors(struct device *dev,
 
 	mutex_lock(&cpuidle_lock);
 	list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
-		if (i >= (ssize_t) ((PAGE_SIZE/sizeof(char)) -
+		if (i >= (ssize_t) ((PAGE_SIZE / sizeof(char)) -
 				    CPUIDLE_NAME_LEN - 2))
 			goto out;
-		i += scnprintf(&buf[i], CPUIDLE_NAME_LEN, "%s ", tmp->name);
+		i += scnprintf(&buf[i], CPUIDLE_NAME_LEN + 1, "%s ", tmp->name);
 	}
 
 out:
-- 
1.7.12.4

