Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0653F1BA032
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 11:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgD0Jm2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 05:42:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47590 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726349AbgD0Jm2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Apr 2020 05:42:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9B27543FB8566440134;
        Mon, 27 Apr 2020 17:42:24 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Apr 2020 17:42:18 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-pm@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 1/2] cpuidle: sysfs: Remove the unused define_one_r(o/w) macros
Date:   Mon, 27 Apr 2020 17:34:20 +0800
Message-ID: <1587980061-16433-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The define_one_ro and define_one_rw macros are not used,
remove it.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/cpuidle/sysfs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index cdeedbf..7729cf6 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -167,11 +167,6 @@ struct cpuidle_attr {
 	ssize_t (*store)(struct cpuidle_device *, const char *, size_t count);
 };
 
-#define define_one_ro(_name, show) \
-	static struct cpuidle_attr attr_##_name = __ATTR(_name, 0444, show, NULL)
-#define define_one_rw(_name, show, store) \
-	static struct cpuidle_attr attr_##_name = __ATTR(_name, 0644, show, store)
-
 #define attr_to_cpuidleattr(a) container_of(a, struct cpuidle_attr, attr)
 
 struct cpuidle_device_kobj {
-- 
1.7.12.4

