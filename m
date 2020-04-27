Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609531BA031
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 11:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgD0Jm1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 05:42:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47594 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbgD0Jm1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 05:42:27 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CE0012D0EF721FE4CED9;
        Mon, 27 Apr 2020 17:42:24 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Apr 2020 17:42:18 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/2] cpuidle: sysfs: Minor coding style correction
Date:   Mon, 27 Apr 2020 17:34:21 +0800
Message-ID: <1587980061-16433-2-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1587980061-16433-1-git-send-email-guohanjun@huawei.com>
References: <1587980061-16433-1-git-send-email-guohanjun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix two minor coding style issues.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/cpuidle/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 7729cf6..d3ef1d7 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -426,12 +426,12 @@ static inline void cpuidle_remove_s2idle_attr_group(struct cpuidle_state_kobj *k
 #define attr_to_stateattr(a) container_of(a, struct cpuidle_state_attr, attr)
 
 static ssize_t cpuidle_state_show(struct kobject *kobj, struct attribute *attr,
-				  char * buf)
+				  char *buf)
 {
 	int ret = -EIO;
 	struct cpuidle_state *state = kobj_to_state(kobj);
 	struct cpuidle_state_usage *state_usage = kobj_to_state_usage(kobj);
-	struct cpuidle_state_attr * cattr = attr_to_stateattr(attr);
+	struct cpuidle_state_attr *cattr = attr_to_stateattr(attr);
 
 	if (cattr->show)
 		ret = cattr->show(state, state_usage, buf);
-- 
1.7.12.4

