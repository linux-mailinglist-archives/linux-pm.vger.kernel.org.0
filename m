Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584E3357DDE
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 10:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhDHIPA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 04:15:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16043 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhDHIO7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 04:14:59 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGDWN2rlXzPnhp;
        Thu,  8 Apr 2021 16:12:00 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.175) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 16:14:41 +0800
From:   Lu Jialin <lujialin4@huawei.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
CC:     Lu Jialin <lujialin4@huawei.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH -next] PM: fix typos in comments
Date:   Thu, 8 Apr 2021 16:14:44 +0800
Message-ID: <20210408081444.167868-1-lujialin4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Change occured to occurred in kernel/power/autosleep.c.
Change consiting to consisting in kernel/power/snapshot.c.
Change avaiable to available in kernel/power/swap.c.
No functionality changed.

Signed-off-by: Lu Jialin <lujialin4@huawei.com>
---
 kernel/power/autosleep.c | 2 +-
 kernel/power/snapshot.c  | 2 +-
 kernel/power/swap.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/autosleep.c b/kernel/power/autosleep.c
index 9af5a50d3489..b29c8aca7486 100644
--- a/kernel/power/autosleep.c
+++ b/kernel/power/autosleep.c
@@ -54,7 +54,7 @@ static void try_to_suspend(struct work_struct *work)
 		goto out;
 
 	/*
-	 * If the wakeup occured for an unknown reason, wait to prevent the
+	 * If the wakeup occurred for an unknown reason, wait to prevent the
 	 * system from trying to suspend and waking up in a tight loop.
 	 */
 	if (final_count == initial_count)
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 64b7aab9aee4..27cb4e7086b7 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -329,7 +329,7 @@ static void *chain_alloc(struct chain_allocator *ca, unsigned int size)
 /**
  * Data types related to memory bitmaps.
  *
- * Memory bitmap is a structure consiting of many linked lists of
+ * Memory bitmap is a structure consisting of many linked lists of
  * objects.  The main list's elements are of type struct zone_bitmap
  * and each of them corresonds to one zone.  For each zone bitmap
  * object there is a list of objects of type struct bm_block that
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 72e33054a2e1..bea3cb8afa11 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -884,7 +884,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
  *	enough_swap - Make sure we have enough swap to save the image.
  *
  *	Returns TRUE or FALSE after checking the total amount of swap
- *	space avaiable from the resume partition.
+ *	space available from the resume partition.
  */
 
 static int enough_swap(unsigned int nr_pages)
-- 
2.17.1

