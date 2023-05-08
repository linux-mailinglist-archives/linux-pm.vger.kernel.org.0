Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122ED6FA03F
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 08:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjEHGzG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 02:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjEHGyz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 02:54:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCE9A5F6;
        Sun,  7 May 2023 23:54:53 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QFBmK4B1vzLpB0;
        Mon,  8 May 2023 14:52:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 14:54:50 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>
CC:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 07/12] mm: page_alloc: split out FAIL_PAGE_ALLOC
Date:   Mon, 8 May 2023 15:11:55 +0800
Message-ID: <20230508071200.123962-8-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
References: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

... to a single file to reduce a bit of page_alloc.c.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/fault-inject.h |  9 +++++
 mm/Makefile                  |  1 +
 mm/fail_page_alloc.c         | 66 ++++++++++++++++++++++++++++++++
 mm/page_alloc.c              | 74 ------------------------------------
 4 files changed, 76 insertions(+), 74 deletions(-)
 create mode 100644 mm/fail_page_alloc.c

diff --git a/include/linux/fault-inject.h b/include/linux/fault-inject.h
index 481abf530b3c..6d5edef09d45 100644
--- a/include/linux/fault-inject.h
+++ b/include/linux/fault-inject.h
@@ -93,6 +93,15 @@ struct kmem_cache;
 
 bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order);
 
+#ifdef CONFIG_FAIL_PAGE_ALLOC
+bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order);
+#else
+static inline bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+{
+	return false;
+}
+#endif /* CONFIG_FAIL_PAGE_ALLOC */
+
 int should_failslab(struct kmem_cache *s, gfp_t gfpflags);
 #ifdef CONFIG_FAILSLAB
 extern bool __should_failslab(struct kmem_cache *s, gfp_t gfpflags);
diff --git a/mm/Makefile b/mm/Makefile
index 5262ce5baa28..0eec4bc72d3f 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
 obj-$(CONFIG_KMSAN)	+= kmsan/
 obj-$(CONFIG_FAILSLAB) += failslab.o
+obj-$(CONFIG_FAIL_PAGE_ALLOC) += fail_page_alloc.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
diff --git a/mm/fail_page_alloc.c b/mm/fail_page_alloc.c
new file mode 100644
index 000000000000..b1b09cce9394
--- /dev/null
+++ b/mm/fail_page_alloc.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fault-inject.h>
+#include <linux/mm.h>
+
+static struct {
+	struct fault_attr attr;
+
+	bool ignore_gfp_highmem;
+	bool ignore_gfp_reclaim;
+	u32 min_order;
+} fail_page_alloc = {
+	.attr = FAULT_ATTR_INITIALIZER,
+	.ignore_gfp_reclaim = true,
+	.ignore_gfp_highmem = true,
+	.min_order = 1,
+};
+
+static int __init setup_fail_page_alloc(char *str)
+{
+	return setup_fault_attr(&fail_page_alloc.attr, str);
+}
+__setup("fail_page_alloc=", setup_fail_page_alloc);
+
+bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+{
+	int flags = 0;
+
+	if (order < fail_page_alloc.min_order)
+		return false;
+	if (gfp_mask & __GFP_NOFAIL)
+		return false;
+	if (fail_page_alloc.ignore_gfp_highmem && (gfp_mask & __GFP_HIGHMEM))
+		return false;
+	if (fail_page_alloc.ignore_gfp_reclaim &&
+			(gfp_mask & __GFP_DIRECT_RECLAIM))
+		return false;
+
+	/* See comment in __should_failslab() */
+	if (gfp_mask & __GFP_NOWARN)
+		flags |= FAULT_NOWARN;
+
+	return should_fail_ex(&fail_page_alloc.attr, 1 << order, flags);
+}
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+
+static int __init fail_page_alloc_debugfs(void)
+{
+	umode_t mode = S_IFREG | 0600;
+	struct dentry *dir;
+
+	dir = fault_create_debugfs_attr("fail_page_alloc", NULL,
+					&fail_page_alloc.attr);
+
+	debugfs_create_bool("ignore-gfp-wait", mode, dir,
+			    &fail_page_alloc.ignore_gfp_reclaim);
+	debugfs_create_bool("ignore-gfp-highmem", mode, dir,
+			    &fail_page_alloc.ignore_gfp_highmem);
+	debugfs_create_u32("min-order", mode, dir, &fail_page_alloc.min_order);
+
+	return 0;
+}
+
+late_initcall(fail_page_alloc_debugfs);
+
+#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bc453edbad21..fce47ccbcb3a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2942,80 +2942,6 @@ struct page *rmqueue(struct zone *preferred_zone,
 	return page;
 }
 
-#ifdef CONFIG_FAIL_PAGE_ALLOC
-
-static struct {
-	struct fault_attr attr;
-
-	bool ignore_gfp_highmem;
-	bool ignore_gfp_reclaim;
-	u32 min_order;
-} fail_page_alloc = {
-	.attr = FAULT_ATTR_INITIALIZER,
-	.ignore_gfp_reclaim = true,
-	.ignore_gfp_highmem = true,
-	.min_order = 1,
-};
-
-static int __init setup_fail_page_alloc(char *str)
-{
-	return setup_fault_attr(&fail_page_alloc.attr, str);
-}
-__setup("fail_page_alloc=", setup_fail_page_alloc);
-
-static bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
-{
-	int flags = 0;
-
-	if (order < fail_page_alloc.min_order)
-		return false;
-	if (gfp_mask & __GFP_NOFAIL)
-		return false;
-	if (fail_page_alloc.ignore_gfp_highmem && (gfp_mask & __GFP_HIGHMEM))
-		return false;
-	if (fail_page_alloc.ignore_gfp_reclaim &&
-			(gfp_mask & __GFP_DIRECT_RECLAIM))
-		return false;
-
-	/* See comment in __should_failslab() */
-	if (gfp_mask & __GFP_NOWARN)
-		flags |= FAULT_NOWARN;
-
-	return should_fail_ex(&fail_page_alloc.attr, 1 << order, flags);
-}
-
-#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
-
-static int __init fail_page_alloc_debugfs(void)
-{
-	umode_t mode = S_IFREG | 0600;
-	struct dentry *dir;
-
-	dir = fault_create_debugfs_attr("fail_page_alloc", NULL,
-					&fail_page_alloc.attr);
-
-	debugfs_create_bool("ignore-gfp-wait", mode, dir,
-			    &fail_page_alloc.ignore_gfp_reclaim);
-	debugfs_create_bool("ignore-gfp-highmem", mode, dir,
-			    &fail_page_alloc.ignore_gfp_highmem);
-	debugfs_create_u32("min-order", mode, dir, &fail_page_alloc.min_order);
-
-	return 0;
-}
-
-late_initcall(fail_page_alloc_debugfs);
-
-#endif /* CONFIG_FAULT_INJECTION_DEBUG_FS */
-
-#else /* CONFIG_FAIL_PAGE_ALLOC */
-
-static inline bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
-{
-	return false;
-}
-
-#endif /* CONFIG_FAIL_PAGE_ALLOC */
-
 noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 {
 	return __should_fail_alloc_page(gfp_mask, order);
-- 
2.35.3

