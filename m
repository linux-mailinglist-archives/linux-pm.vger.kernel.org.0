Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08891D901C
	for <lists+linux-pm@lfdr.de>; Tue, 19 May 2020 08:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgESGc2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 May 2020 02:32:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727041AbgESGc2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 May 2020 02:32:28 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BAAC980B7D09DC453DBB;
        Tue, 19 May 2020 14:32:23 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 14:32:16 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
CC:     <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/6] cpuidle: sysfs: Fix the overlap for showing available governors
Date:   Tue, 19 May 2020 14:25:20 +0800
Message-ID: <1589869525-29893-2-git-send-email-guohanjun@huawei.com>
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

When showing the available governors, it's "%s " in scnprintf(),
not "%s", so if the governor name has 15 characters, it will
overlap with the later one, fix it by adding one more for the
size.

While we are at it, fix the minor coding style issue and remove
the "/sizeof(char)" since sizeof(char) always equals 1.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpuidle/sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index d3ef1d7..477b05a 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -35,10 +35,10 @@ static ssize_t show_available_governors(struct device *dev,
 
 	mutex_lock(&cpuidle_lock);
 	list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
-		if (i >= (ssize_t) ((PAGE_SIZE/sizeof(char)) -
-				    CPUIDLE_NAME_LEN - 2))
+		if (i >= (ssize_t) (PAGE_SIZE - (CPUIDLE_NAME_LEN + 2)))
 			goto out;
-		i += scnprintf(&buf[i], CPUIDLE_NAME_LEN, "%s ", tmp->name);
+
+		i += scnprintf(&buf[i], CPUIDLE_NAME_LEN + 1, "%s ", tmp->name);
 	}
 
 out:
-- 
1.7.12.4

