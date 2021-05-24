Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF49738E35D
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 11:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhEXJbv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 05:31:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5674 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhEXJbv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 05:31:51 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpX1H3C9Bz1BR7R;
        Mon, 24 May 2021 17:27:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 17:30:20 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 17:30:20 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm <linux-pm@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] PM: fix spelling mistakes
Date:   Mon, 24 May 2021 17:30:10 +0800
Message-ID: <20210524093010.8839-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix some spelling mistakes in comments:
corresonds ==> corresponds
alocated ==> allocated
unitialized ==> uninitialized
Deompression ==> Decompression

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/power/snapshot.c | 8 ++++----
 kernel/power/swap.c     | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 1a221dcb3c01..af507c8c895b 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -331,7 +331,7 @@ static void *chain_alloc(struct chain_allocator *ca, unsigned int size)
  *
  * Memory bitmap is a structure consisting of many linked lists of
  * objects.  The main list's elements are of type struct zone_bitmap
- * and each of them corresonds to one zone.  For each zone bitmap
+ * and each of them corresponds to one zone.  For each zone bitmap
  * object there is a list of objects of type struct bm_block that
  * represent each blocks of bitmap in which information is stored.
  *
@@ -1500,7 +1500,7 @@ static struct memory_bitmap copy_bm;
 /**
  * swsusp_free - Free pages allocated for hibernation image.
  *
- * Image pages are alocated before snapshot creation, so they need to be
+ * Image pages are allocated before snapshot creation, so they need to be
  * released after resume.
  */
 void swsusp_free(void)
@@ -2326,7 +2326,7 @@ static struct memory_bitmap *safe_highmem_bm;
  * (@nr_highmem_p points to the variable containing the number of highmem image
  * pages).  The pages that are "safe" (ie. will not be overwritten when the
  * hibernation image is restored entirely) have the corresponding bits set in
- * @bm (it must be unitialized).
+ * @bm (it must be uninitialized).
  *
  * NOTE: This function should not be called if there are no highmem image pages.
  */
@@ -2483,7 +2483,7 @@ static inline void free_highmem_data(void) {}
 
 /**
  * prepare_image - Make room for loading hibernation image.
- * @new_bm: Unitialized memory bitmap structure.
+ * @new_bm: Uninitialized memory bitmap structure.
  * @bm: Memory bitmap with unsafe pages marked.
  *
  * Use @bm to mark the pages that will be overwritten in the process of
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index bea3cb8afa11..3cb89baebc79 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1125,7 +1125,7 @@ struct dec_data {
 };
 
 /**
- * Deompression function that runs in its own thread.
+ * Decompression function that runs in its own thread.
  */
 static int lzo_decompress_threadfn(void *data)
 {
-- 
2.25.1


