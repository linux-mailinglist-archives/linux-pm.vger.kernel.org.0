Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A452D704539
	for <lists+linux-pm@lfdr.de>; Tue, 16 May 2023 08:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjEPGWC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 May 2023 02:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjEPGV4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 May 2023 02:21:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F4B448F;
        Mon, 15 May 2023 23:21:39 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QL5fF05WWzLq2s;
        Tue, 16 May 2023 14:18:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:21:37 +0800
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
        <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 12/13] mm: page_alloc: move sysctls into it own fils
Date:   Tue, 16 May 2023 14:38:20 +0800
Message-ID: <20230516063821.121844-13-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230516063821.121844-1-wangkefeng.wang@huawei.com>
References: <20230516063821.121844-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

This moves all page alloc related sysctls to its own file,
as part of the kernel/sysctl.c spring cleaning, also move
some functions declarations from mm.h into internal.h.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h     |  11 -----
 include/linux/mmzone.h |  21 ---------
 kernel/sysctl.c        |  67 ---------------------------
 mm/internal.h          |  11 +++++
 mm/mm_init.c           |   2 +
 mm/page_alloc.c        | 103 +++++++++++++++++++++++++++++++++++------
 6 files changed, 102 insertions(+), 113 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d3241f4ac903..eabe520139ef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3008,12 +3008,6 @@ extern int __meminit early_pfn_to_nid(unsigned long pfn);
 #endif
 
 extern void set_dma_reserve(unsigned long new_dma_reserve);
-extern void memmap_init_range(unsigned long, int, unsigned long,
-		unsigned long, unsigned long, enum meminit_context,
-		struct vmem_altmap *, int migratetype);
-extern void setup_per_zone_wmarks(void);
-extern void calculate_min_free_kbytes(void);
-extern int __meminit init_per_zone_wmark_min(void);
 extern void mem_init(void);
 extern void __init mmap_init(void);
 
@@ -3034,11 +3028,6 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...);
 
 extern void setup_per_cpu_pageset(void);
 
-/* page_alloc.c */
-extern int min_free_kbytes;
-extern int watermark_boost_factor;
-extern int watermark_scale_factor;
-
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index a4889c9d4055..3a68326c9989 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1512,27 +1512,6 @@ static inline bool has_managed_dma(void)
 }
 #endif
 
-/* These two functions are used to setup the per zone pages min values */
-struct ctl_table;
-
-int min_free_kbytes_sysctl_handler(struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-int watermark_scale_factor_sysctl_handler(struct ctl_table *, int, void *,
-		size_t *, loff_t *);
-extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES];
-int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *, int, void *,
-		size_t *, loff_t *);
-int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *, int,
-		void *, size_t *, loff_t *);
-int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *, int,
-		void *, size_t *, loff_t *);
-int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *, int,
-		void *, size_t *, loff_t *);
-int numa_zonelist_order_handler(struct ctl_table *, int,
-		void *, size_t *, loff_t *);
-extern int percpu_pagelist_high_fraction;
-extern char numa_zonelist_order[];
-#define NUMA_ZONELIST_ORDER_LEN	16
 
 #ifndef CONFIG_NUMA
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index bfe53e835524..a57de67f032f 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2119,13 +2119,6 @@ static struct ctl_table vm_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
-	{
-		.procname	= "lowmem_reserve_ratio",
-		.data		= &sysctl_lowmem_reserve_ratio,
-		.maxlen		= sizeof(sysctl_lowmem_reserve_ratio),
-		.mode		= 0644,
-		.proc_handler	= lowmem_reserve_ratio_sysctl_handler,
-	},
 	{
 		.procname	= "drop_caches",
 		.data		= &sysctl_drop_caches,
@@ -2135,39 +2128,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= SYSCTL_FOUR,
 	},
-	{
-		.procname	= "min_free_kbytes",
-		.data		= &min_free_kbytes,
-		.maxlen		= sizeof(min_free_kbytes),
-		.mode		= 0644,
-		.proc_handler	= min_free_kbytes_sysctl_handler,
-		.extra1		= SYSCTL_ZERO,
-	},
-	{
-		.procname	= "watermark_boost_factor",
-		.data		= &watermark_boost_factor,
-		.maxlen		= sizeof(watermark_boost_factor),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
-	{
-		.procname	= "watermark_scale_factor",
-		.data		= &watermark_scale_factor,
-		.maxlen		= sizeof(watermark_scale_factor),
-		.mode		= 0644,
-		.proc_handler	= watermark_scale_factor_sysctl_handler,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_THREE_THOUSAND,
-	},
-	{
-		.procname	= "percpu_pagelist_high_fraction",
-		.data		= &percpu_pagelist_high_fraction,
-		.maxlen		= sizeof(percpu_pagelist_high_fraction),
-		.mode		= 0644,
-		.proc_handler	= percpu_pagelist_high_fraction_sysctl_handler,
-		.extra1		= SYSCTL_ZERO,
-	},
 	{
 		.procname	= "page_lock_unfairness",
 		.data		= &sysctl_page_lock_unfairness,
@@ -2223,24 +2183,6 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
-	{
-		.procname	= "min_unmapped_ratio",
-		.data		= &sysctl_min_unmapped_ratio,
-		.maxlen		= sizeof(sysctl_min_unmapped_ratio),
-		.mode		= 0644,
-		.proc_handler	= sysctl_min_unmapped_ratio_sysctl_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_HUNDRED,
-	},
-	{
-		.procname	= "min_slab_ratio",
-		.data		= &sysctl_min_slab_ratio,
-		.maxlen		= sizeof(sysctl_min_slab_ratio),
-		.mode		= 0644,
-		.proc_handler	= sysctl_min_slab_ratio_sysctl_handler,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE_HUNDRED,
-	},
 #endif
 #ifdef CONFIG_SMP
 	{
@@ -2267,15 +2209,6 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= mmap_min_addr_handler,
 	},
 #endif
-#ifdef CONFIG_NUMA
-	{
-		.procname	= "numa_zonelist_order",
-		.data		= &numa_zonelist_order,
-		.maxlen		= NUMA_ZONELIST_ORDER_LEN,
-		.mode		= 0644,
-		.proc_handler	= numa_zonelist_order_handler,
-	},
-#endif
 #if (defined(CONFIG_X86_32) && !defined(CONFIG_UML))|| \
    (defined(CONFIG_SUPERH) && defined(CONFIG_VSYSCALL))
 	{
diff --git a/mm/internal.h b/mm/internal.h
index 79324b7f2bc8..5fdf930a87b5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -213,6 +213,13 @@ static inline bool is_check_pages_enabled(void)
 	return static_branch_unlikely(&check_pages_enabled);
 }
 
+extern int min_free_kbytes;
+
+void setup_per_zone_wmarks(void);
+void calculate_min_free_kbytes(void);
+int __meminit init_per_zone_wmark_min(void);
+void page_alloc_sysctl_init(void);
+
 /*
  * Structure for holding the mostly immutable allocation parameters passed
  * between functions involved in allocations, including the alloc_pages*
@@ -423,6 +430,10 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
 			  phys_addr_t min_addr,
 			  int nid, bool exact_nid);
 
+void memmap_init_range(unsigned long, int, unsigned long, unsigned long,
+		unsigned long, enum meminit_context, struct vmem_altmap *, int);
+
+
 int split_free_page(struct page *free_page,
 			unsigned int order, unsigned long split_pfn_offset);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 0fd4ddfdfb2e..10bf560302c4 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2392,6 +2392,8 @@ void __init page_alloc_init_late(void)
 	/* Initialize page ext after all struct pages are initialized. */
 	if (deferred_struct_pages)
 		page_ext_init();
+
+	page_alloc_sysctl_init();
 }
 
 #ifndef __HAVE_ARCH_RESERVED_KERNEL_PAGES
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2a95e095bb2a..5e8680669388 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -206,7 +206,6 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 };
 EXPORT_SYMBOL(node_states);
 
-int percpu_pagelist_high_fraction;
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 
 /*
@@ -302,8 +301,8 @@ compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS] = {
 
 int min_free_kbytes = 1024;
 int user_min_free_kbytes = -1;
-int watermark_boost_factor __read_mostly = 15000;
-int watermark_scale_factor = 10;
+static int watermark_boost_factor __read_mostly = 15000;
+static int watermark_scale_factor = 10;
 
 /* movable_zone is the "real" zone pages in ZONE_MOVABLE are taken from */
 int movable_zone;
@@ -4917,12 +4916,12 @@ static int __parse_numa_zonelist_order(char *s)
 	return 0;
 }
 
-char numa_zonelist_order[] = "Node";
-
+static char numa_zonelist_order[] = "Node";
+#define NUMA_ZONELIST_ORDER_LEN	16
 /*
  * sysctl handler for numa_zonelist_order
  */
-int numa_zonelist_order_handler(struct ctl_table *table, int write,
+static int numa_zonelist_order_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	if (write)
@@ -4930,7 +4929,6 @@ int numa_zonelist_order_handler(struct ctl_table *table, int write,
 	return proc_dostring(table, write, buffer, length, ppos);
 }
 
-
 static int node_load[MAX_NUMNODES];
 
 /**
@@ -5333,6 +5331,7 @@ static int zone_batchsize(struct zone *zone)
 #endif
 }
 
+static int percpu_pagelist_high_fraction;
 static int zone_highsize(struct zone *zone, int batch, int cpu_online)
 {
 #ifdef CONFIG_MMU
@@ -5862,7 +5861,7 @@ postcore_initcall(init_per_zone_wmark_min)
  *	that we can call two helper functions whenever min_free_kbytes
  *	changes.
  */
-int min_free_kbytes_sysctl_handler(struct ctl_table *table, int write,
+static int min_free_kbytes_sysctl_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc;
@@ -5878,7 +5877,7 @@ int min_free_kbytes_sysctl_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
-int watermark_scale_factor_sysctl_handler(struct ctl_table *table, int write,
+static int watermark_scale_factor_sysctl_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc;
@@ -5908,7 +5907,7 @@ static void setup_min_unmapped_ratio(void)
 }
 
 
-int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *table, int write,
+static int sysctl_min_unmapped_ratio_sysctl_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc;
@@ -5935,7 +5934,7 @@ static void setup_min_slab_ratio(void)
 						     sysctl_min_slab_ratio) / 100;
 }
 
-int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *table, int write,
+static int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	int rc;
@@ -5959,8 +5958,8 @@ int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *table, int write,
  * minimum watermarks. The lowmem reserve ratio can only make sense
  * if in function of the boot time zone sizes.
  */
-int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table, int write,
-		void *buffer, size_t *length, loff_t *ppos)
+static int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table,
+		int write, void *buffer, size_t *length, loff_t *ppos)
 {
 	int i;
 
@@ -5980,7 +5979,7 @@ int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table, int write,
  * cpu. It is the fraction of total pages in each zone that a hot per cpu
  * pagelist can have before it gets flushed back to buddy allocator.
  */
-int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *table,
+static int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *table,
 		int write, void *buffer, size_t *length, loff_t *ppos)
 {
 	struct zone *zone;
@@ -6013,6 +6012,82 @@ int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *table,
 	return ret;
 }
 
+static struct ctl_table page_alloc_sysctl_table[] = {
+	{
+		.procname	= "min_free_kbytes",
+		.data		= &min_free_kbytes,
+		.maxlen		= sizeof(min_free_kbytes),
+		.mode		= 0644,
+		.proc_handler	= min_free_kbytes_sysctl_handler,
+		.extra1		= SYSCTL_ZERO,
+	},
+	{
+		.procname	= "watermark_boost_factor",
+		.data		= &watermark_boost_factor,
+		.maxlen		= sizeof(watermark_boost_factor),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+	},
+	{
+		.procname	= "watermark_scale_factor",
+		.data		= &watermark_scale_factor,
+		.maxlen		= sizeof(watermark_scale_factor),
+		.mode		= 0644,
+		.proc_handler	= watermark_scale_factor_sysctl_handler,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_THREE_THOUSAND,
+	},
+	{
+		.procname	= "percpu_pagelist_high_fraction",
+		.data		= &percpu_pagelist_high_fraction,
+		.maxlen		= sizeof(percpu_pagelist_high_fraction),
+		.mode		= 0644,
+		.proc_handler	= percpu_pagelist_high_fraction_sysctl_handler,
+		.extra1		= SYSCTL_ZERO,
+	},
+	{
+		.procname	= "lowmem_reserve_ratio",
+		.data		= &sysctl_lowmem_reserve_ratio,
+		.maxlen		= sizeof(sysctl_lowmem_reserve_ratio),
+		.mode		= 0644,
+		.proc_handler	= lowmem_reserve_ratio_sysctl_handler,
+	},
+#ifdef CONFIG_NUMA
+	{
+		.procname	= "numa_zonelist_order",
+		.data		= &numa_zonelist_order,
+		.maxlen		= NUMA_ZONELIST_ORDER_LEN,
+		.mode		= 0644,
+		.proc_handler	= numa_zonelist_order_handler,
+	},
+	{
+		.procname	= "min_unmapped_ratio",
+		.data		= &sysctl_min_unmapped_ratio,
+		.maxlen		= sizeof(sysctl_min_unmapped_ratio),
+		.mode		= 0644,
+		.proc_handler	= sysctl_min_unmapped_ratio_sysctl_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE_HUNDRED,
+	},
+	{
+		.procname	= "min_slab_ratio",
+		.data		= &sysctl_min_slab_ratio,
+		.maxlen		= sizeof(sysctl_min_slab_ratio),
+		.mode		= 0644,
+		.proc_handler	= sysctl_min_slab_ratio_sysctl_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE_HUNDRED,
+	},
+#endif
+	{}
+};
+
+void __init page_alloc_sysctl_init(void)
+{
+	register_sysctl_init("vm", page_alloc_sysctl_table);
+}
+
 #ifdef CONFIG_CONTIG_ALLOC
 /* Usage: See admin-guide/dynamic-debug-howto.rst */
 static void alloc_contig_dump_pages(struct list_head *page_list)
-- 
2.35.3

