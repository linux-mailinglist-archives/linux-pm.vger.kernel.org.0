Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D1C39EFD9
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 09:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhFHHqg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 03:46:36 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4395 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHHqg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 03:46:36 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzhxH2M2fz6tqn;
        Tue,  8 Jun 2021 15:40:51 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:44:41 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:44:41 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] PM: remove trailing spaces and tabs
Date:   Tue, 8 Jun 2021 15:44:37 +0800
Message-ID: <20210608074437.12905-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Run the following command to find and remove the trailing spaces and tabs:

find kernel/power/ -type f | xargs sed -r -i 's/[ \t]+$//'

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/power/Kconfig   | 12 ++++++------
 kernel/power/process.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 6bfe3ead10ad..a12779650f15 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -98,20 +98,20 @@ config PM_STD_PARTITION
 	default ""
 	help
 	  The default resume partition is the partition that the suspend-
-	  to-disk implementation will look for a suspended disk image. 
+	  to-disk implementation will look for a suspended disk image.
 
-	  The partition specified here will be different for almost every user. 
+	  The partition specified here will be different for almost every user.
 	  It should be a valid swap partition (at least for now) that is turned
-	  on before suspending. 
+	  on before suspending.
 
 	  The partition specified can be overridden by specifying:
 
-		resume=/dev/<other device> 
+		resume=/dev/<other device>
 
-	  which will set the resume partition to the device specified. 
+	  which will set the resume partition to the device specified.
 
 	  Note there is currently not a way to specify which device to save the
-	  suspended image to. It will simply pick the first available swap 
+	  suspended image to. It will simply pick the first available swap
 	  device.
 
 config PM_SLEEP
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 50cc63534486..37401c99b7d7 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/power/process.c - Functions for starting/stopping processes on 
+ * drivers/power/process.c - Functions for starting/stopping processes on
  *                           suspend transitions.
  *
  * Originally from swsusp.
-- 
2.25.1


