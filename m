Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAB46FA041
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 08:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjEHGzK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 02:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjEHGyz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 02:54:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358FC7698;
        Sun,  7 May 2023 23:54:50 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QFBkF6Bv2zTkBF;
        Mon,  8 May 2023 14:50:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 14:54:48 +0800
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
Subject: [PATCH 04/12] mm: page_alloc: collect mem statistic into show_mem.c
Date:   Mon, 8 May 2023 15:11:52 +0800
Message-ID: <20230508071200.123962-5-wangkefeng.wang@huawei.com>
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

Let's move show_mem.c from lib to mm, as it belongs memory subsystem,
also split some memory statistic related functions from page_alloc.c
to show_mem.c, and we cleanup some unneeded include.

There is no functional change.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 lib/Makefile    |   2 +-
 lib/show_mem.c  |  37 -----
 mm/Makefile     |   2 +-
 mm/page_alloc.c | 402 ---------------------------------------------
 mm/show_mem.c   | 429 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 431 insertions(+), 441 deletions(-)
 delete mode 100644 lib/show_mem.c
 create mode 100644 mm/show_mem.c

diff --git a/lib/Makefile b/lib/Makefile
index 876fcdeae34e..38f23f352736 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -30,7 +30,7 @@ endif
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 maple_tree.o idr.o extable.o irq_regs.o argv_split.o \
-	 flex_proportions.o ratelimit.o show_mem.o \
+	 flex_proportions.o ratelimit.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o win_minmax.o memcat_p.o \
diff --git a/lib/show_mem.c b/lib/show_mem.c
deleted file mode 100644
index 1485c87be935..000000000000
--- a/lib/show_mem.c
+++ /dev/null
@@ -1,37 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Generic show_mem() implementation
- *
- * Copyright (C) 2008 Johannes Weiner <hannes@saeurebad.de>
- */
-
-#include <linux/mm.h>
-#include <linux/cma.h>
-
-void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
-{
-	unsigned long total = 0, reserved = 0, highmem = 0;
-	struct zone *zone;
-
-	printk("Mem-Info:\n");
-	__show_free_areas(filter, nodemask, max_zone_idx);
-
-	for_each_populated_zone(zone) {
-
-		total += zone->present_pages;
-		reserved += zone->present_pages - zone_managed_pages(zone);
-
-		if (is_highmem(zone))
-			highmem += zone->present_pages;
-	}
-
-	printk("%lu pages RAM\n", total);
-	printk("%lu pages HighMem/MovableOnly\n", highmem);
-	printk("%lu pages reserved\n", reserved);
-#ifdef CONFIG_CMA
-	printk("%lu pages cma reserved\n", totalcma_pages);
-#endif
-#ifdef CONFIG_MEMORY_FAILURE
-	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
-#endif
-}
diff --git a/mm/Makefile b/mm/Makefile
index e29afc890cde..5262ce5baa28 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -51,7 +51,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   readahead.o swap.o truncate.o vmscan.o shmem.o \
 			   util.o mmzone.o vmstat.o backing-dev.o \
 			   mm_init.o percpu.o slab_common.o \
-			   compaction.o \
+			   compaction.o show_mem.o\
 			   interval_tree.o list_lru.o workingset.o \
 			   debug.o gup.o mmap_lock.o $(mmu-y)
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fe7c1ee5becd..9a85238f1140 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -18,10 +18,7 @@
 #include <linux/stddef.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
-#include <linux/swap.h>
-#include <linux/swapops.h>
 #include <linux/interrupt.h>
-#include <linux/pagemap.h>
 #include <linux/jiffies.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
@@ -30,8 +27,6 @@
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/pagevec.h>
-#include <linux/blkdev.h>
-#include <linux/slab.h>
 #include <linux/ratelimit.h>
 #include <linux/oom.h>
 #include <linux/topology.h>
@@ -40,19 +35,10 @@
 #include <linux/cpuset.h>
 #include <linux/memory_hotplug.h>
 #include <linux/nodemask.h>
-#include <linux/vmalloc.h>
 #include <linux/vmstat.h>
-#include <linux/mempolicy.h>
-#include <linux/memremap.h>
-#include <linux/stop_machine.h>
-#include <linux/random.h>
 #include <linux/sort.h>
 #include <linux/pfn.h>
-#include <linux/backing-dev.h>
 #include <linux/fault-inject.h>
-#include <linux/page-isolation.h>
-#include <linux/debugobjects.h>
-#include <linux/kmemleak.h>
 #include <linux/compaction.h>
 #include <trace/events/kmem.h>
 #include <trace/events/oom.h>
@@ -60,12 +46,9 @@
 #include <linux/mm_inline.h>
 #include <linux/mmu_notifier.h>
 #include <linux/migrate.h>
-#include <linux/hugetlb.h>
-#include <linux/sched/rt.h>
 #include <linux/sched/mm.h>
 #include <linux/page_owner.h>
 #include <linux/page_table_check.h>
-#include <linux/kthread.h>
 #include <linux/memcontrol.h>
 #include <linux/ftrace.h>
 #include <linux/lockdep.h>
@@ -73,13 +56,10 @@
 #include <linux/psi.h>
 #include <linux/khugepaged.h>
 #include <linux/delayacct.h>
-#include <asm/sections.h>
-#include <asm/tlbflush.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
 #include "page_reporting.h"
-#include "swap.h"
 
 /* Free Page Internal flags: for internal, non-pcp variants of free_pages(). */
 typedef int __bitwise fpi_t;
@@ -226,11 +206,6 @@ nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
 };
 EXPORT_SYMBOL(node_states);
 
-atomic_long_t _totalram_pages __read_mostly;
-EXPORT_SYMBOL(_totalram_pages);
-unsigned long totalreserve_pages __read_mostly;
-unsigned long totalcma_pages __read_mostly;
-
 int percpu_pagelist_high_fraction;
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 
@@ -5050,383 +5025,6 @@ unsigned long nr_free_buffer_pages(void)
 }
 EXPORT_SYMBOL_GPL(nr_free_buffer_pages);
 
-static inline void show_node(struct zone *zone)
-{
-	if (IS_ENABLED(CONFIG_NUMA))
-		printk("Node %d ", zone_to_nid(zone));
-}
-
-long si_mem_available(void)
-{
-	long available;
-	unsigned long pagecache;
-	unsigned long wmark_low = 0;
-	unsigned long pages[NR_LRU_LISTS];
-	unsigned long reclaimable;
-	struct zone *zone;
-	int lru;
-
-	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
-		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
-
-	for_each_zone(zone)
-		wmark_low += low_wmark_pages(zone);
-
-	/*
-	 * Estimate the amount of memory available for userspace allocations,
-	 * without causing swapping or OOM.
-	 */
-	available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
-
-	/*
-	 * Not all the page cache can be freed, otherwise the system will
-	 * start swapping or thrashing. Assume at least half of the page
-	 * cache, or the low watermark worth of cache, needs to stay.
-	 */
-	pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
-	pagecache -= min(pagecache / 2, wmark_low);
-	available += pagecache;
-
-	/*
-	 * Part of the reclaimable slab and other kernel memory consists of
-	 * items that are in use, and cannot be freed. Cap this estimate at the
-	 * low watermark.
-	 */
-	reclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B) +
-		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
-	available += reclaimable - min(reclaimable / 2, wmark_low);
-
-	if (available < 0)
-		available = 0;
-	return available;
-}
-EXPORT_SYMBOL_GPL(si_mem_available);
-
-void si_meminfo(struct sysinfo *val)
-{
-	val->totalram = totalram_pages();
-	val->sharedram = global_node_page_state(NR_SHMEM);
-	val->freeram = global_zone_page_state(NR_FREE_PAGES);
-	val->bufferram = nr_blockdev_pages();
-	val->totalhigh = totalhigh_pages();
-	val->freehigh = nr_free_highpages();
-	val->mem_unit = PAGE_SIZE;
-}
-
-EXPORT_SYMBOL(si_meminfo);
-
-#ifdef CONFIG_NUMA
-void si_meminfo_node(struct sysinfo *val, int nid)
-{
-	int zone_type;		/* needs to be signed */
-	unsigned long managed_pages = 0;
-	unsigned long managed_highpages = 0;
-	unsigned long free_highpages = 0;
-	pg_data_t *pgdat = NODE_DATA(nid);
-
-	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++)
-		managed_pages += zone_managed_pages(&pgdat->node_zones[zone_type]);
-	val->totalram = managed_pages;
-	val->sharedram = node_page_state(pgdat, NR_SHMEM);
-	val->freeram = sum_zone_node_page_state(nid, NR_FREE_PAGES);
-#ifdef CONFIG_HIGHMEM
-	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
-		struct zone *zone = &pgdat->node_zones[zone_type];
-
-		if (is_highmem(zone)) {
-			managed_highpages += zone_managed_pages(zone);
-			free_highpages += zone_page_state(zone, NR_FREE_PAGES);
-		}
-	}
-	val->totalhigh = managed_highpages;
-	val->freehigh = free_highpages;
-#else
-	val->totalhigh = managed_highpages;
-	val->freehigh = free_highpages;
-#endif
-	val->mem_unit = PAGE_SIZE;
-}
-#endif
-
-/*
- * Determine whether the node should be displayed or not, depending on whether
- * SHOW_MEM_FILTER_NODES was passed to show_free_areas().
- */
-static bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask)
-{
-	if (!(flags & SHOW_MEM_FILTER_NODES))
-		return false;
-
-	/*
-	 * no node mask - aka implicit memory numa policy. Do not bother with
-	 * the synchronization - read_mems_allowed_begin - because we do not
-	 * have to be precise here.
-	 */
-	if (!nodemask)
-		nodemask = &cpuset_current_mems_allowed;
-
-	return !node_isset(nid, *nodemask);
-}
-
-static void show_migration_types(unsigned char type)
-{
-	static const char types[MIGRATE_TYPES] = {
-		[MIGRATE_UNMOVABLE]	= 'U',
-		[MIGRATE_MOVABLE]	= 'M',
-		[MIGRATE_RECLAIMABLE]	= 'E',
-		[MIGRATE_HIGHATOMIC]	= 'H',
-#ifdef CONFIG_CMA
-		[MIGRATE_CMA]		= 'C',
-#endif
-#ifdef CONFIG_MEMORY_ISOLATION
-		[MIGRATE_ISOLATE]	= 'I',
-#endif
-	};
-	char tmp[MIGRATE_TYPES + 1];
-	char *p = tmp;
-	int i;
-
-	for (i = 0; i < MIGRATE_TYPES; i++) {
-		if (type & (1 << i))
-			*p++ = types[i];
-	}
-
-	*p = '\0';
-	printk(KERN_CONT "(%s) ", tmp);
-}
-
-static bool node_has_managed_zones(pg_data_t *pgdat, int max_zone_idx)
-{
-	int zone_idx;
-	for (zone_idx = 0; zone_idx <= max_zone_idx; zone_idx++)
-		if (zone_managed_pages(pgdat->node_zones + zone_idx))
-			return true;
-	return false;
-}
-
-/*
- * Show free area list (used inside shift_scroll-lock stuff)
- * We also calculate the percentage fragmentation. We do this by counting the
- * memory on each free list with the exception of the first item on the list.
- *
- * Bits in @filter:
- * SHOW_MEM_FILTER_NODES: suppress nodes that are not allowed by current's
- *   cpuset.
- */
-void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
-{
-	unsigned long free_pcp = 0;
-	int cpu, nid;
-	struct zone *zone;
-	pg_data_t *pgdat;
-
-	for_each_populated_zone(zone) {
-		if (zone_idx(zone) > max_zone_idx)
-			continue;
-		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
-			continue;
-
-		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
-	}
-
-	printk("active_anon:%lu inactive_anon:%lu isolated_anon:%lu\n"
-		" active_file:%lu inactive_file:%lu isolated_file:%lu\n"
-		" unevictable:%lu dirty:%lu writeback:%lu\n"
-		" slab_reclaimable:%lu slab_unreclaimable:%lu\n"
-		" mapped:%lu shmem:%lu pagetables:%lu\n"
-		" sec_pagetables:%lu bounce:%lu\n"
-		" kernel_misc_reclaimable:%lu\n"
-		" free:%lu free_pcp:%lu free_cma:%lu\n",
-		global_node_page_state(NR_ACTIVE_ANON),
-		global_node_page_state(NR_INACTIVE_ANON),
-		global_node_page_state(NR_ISOLATED_ANON),
-		global_node_page_state(NR_ACTIVE_FILE),
-		global_node_page_state(NR_INACTIVE_FILE),
-		global_node_page_state(NR_ISOLATED_FILE),
-		global_node_page_state(NR_UNEVICTABLE),
-		global_node_page_state(NR_FILE_DIRTY),
-		global_node_page_state(NR_WRITEBACK),
-		global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B),
-		global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B),
-		global_node_page_state(NR_FILE_MAPPED),
-		global_node_page_state(NR_SHMEM),
-		global_node_page_state(NR_PAGETABLE),
-		global_node_page_state(NR_SECONDARY_PAGETABLE),
-		global_zone_page_state(NR_BOUNCE),
-		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE),
-		global_zone_page_state(NR_FREE_PAGES),
-		free_pcp,
-		global_zone_page_state(NR_FREE_CMA_PAGES));
-
-	for_each_online_pgdat(pgdat) {
-		if (show_mem_node_skip(filter, pgdat->node_id, nodemask))
-			continue;
-		if (!node_has_managed_zones(pgdat, max_zone_idx))
-			continue;
-
-		printk("Node %d"
-			" active_anon:%lukB"
-			" inactive_anon:%lukB"
-			" active_file:%lukB"
-			" inactive_file:%lukB"
-			" unevictable:%lukB"
-			" isolated(anon):%lukB"
-			" isolated(file):%lukB"
-			" mapped:%lukB"
-			" dirty:%lukB"
-			" writeback:%lukB"
-			" shmem:%lukB"
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			" shmem_thp: %lukB"
-			" shmem_pmdmapped: %lukB"
-			" anon_thp: %lukB"
-#endif
-			" writeback_tmp:%lukB"
-			" kernel_stack:%lukB"
-#ifdef CONFIG_SHADOW_CALL_STACK
-			" shadow_call_stack:%lukB"
-#endif
-			" pagetables:%lukB"
-			" sec_pagetables:%lukB"
-			" all_unreclaimable? %s"
-			"\n",
-			pgdat->node_id,
-			K(node_page_state(pgdat, NR_ACTIVE_ANON)),
-			K(node_page_state(pgdat, NR_INACTIVE_ANON)),
-			K(node_page_state(pgdat, NR_ACTIVE_FILE)),
-			K(node_page_state(pgdat, NR_INACTIVE_FILE)),
-			K(node_page_state(pgdat, NR_UNEVICTABLE)),
-			K(node_page_state(pgdat, NR_ISOLATED_ANON)),
-			K(node_page_state(pgdat, NR_ISOLATED_FILE)),
-			K(node_page_state(pgdat, NR_FILE_MAPPED)),
-			K(node_page_state(pgdat, NR_FILE_DIRTY)),
-			K(node_page_state(pgdat, NR_WRITEBACK)),
-			K(node_page_state(pgdat, NR_SHMEM)),
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			K(node_page_state(pgdat, NR_SHMEM_THPS)),
-			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
-			K(node_page_state(pgdat, NR_ANON_THPS)),
-#endif
-			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
-			node_page_state(pgdat, NR_KERNEL_STACK_KB),
-#ifdef CONFIG_SHADOW_CALL_STACK
-			node_page_state(pgdat, NR_KERNEL_SCS_KB),
-#endif
-			K(node_page_state(pgdat, NR_PAGETABLE)),
-			K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
-			pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
-				"yes" : "no");
-	}
-
-	for_each_populated_zone(zone) {
-		int i;
-
-		if (zone_idx(zone) > max_zone_idx)
-			continue;
-		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
-			continue;
-
-		free_pcp = 0;
-		for_each_online_cpu(cpu)
-			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
-
-		show_node(zone);
-		printk(KERN_CONT
-			"%s"
-			" free:%lukB"
-			" boost:%lukB"
-			" min:%lukB"
-			" low:%lukB"
-			" high:%lukB"
-			" reserved_highatomic:%luKB"
-			" active_anon:%lukB"
-			" inactive_anon:%lukB"
-			" active_file:%lukB"
-			" inactive_file:%lukB"
-			" unevictable:%lukB"
-			" writepending:%lukB"
-			" present:%lukB"
-			" managed:%lukB"
-			" mlocked:%lukB"
-			" bounce:%lukB"
-			" free_pcp:%lukB"
-			" local_pcp:%ukB"
-			" free_cma:%lukB"
-			"\n",
-			zone->name,
-			K(zone_page_state(zone, NR_FREE_PAGES)),
-			K(zone->watermark_boost),
-			K(min_wmark_pages(zone)),
-			K(low_wmark_pages(zone)),
-			K(high_wmark_pages(zone)),
-			K(zone->nr_reserved_highatomic),
-			K(zone_page_state(zone, NR_ZONE_ACTIVE_ANON)),
-			K(zone_page_state(zone, NR_ZONE_INACTIVE_ANON)),
-			K(zone_page_state(zone, NR_ZONE_ACTIVE_FILE)),
-			K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
-			K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
-			K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
-			K(zone->present_pages),
-			K(zone_managed_pages(zone)),
-			K(zone_page_state(zone, NR_MLOCK)),
-			K(zone_page_state(zone, NR_BOUNCE)),
-			K(free_pcp),
-			K(this_cpu_read(zone->per_cpu_pageset->count)),
-			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
-		printk("lowmem_reserve[]:");
-		for (i = 0; i < MAX_NR_ZONES; i++)
-			printk(KERN_CONT " %ld", zone->lowmem_reserve[i]);
-		printk(KERN_CONT "\n");
-	}
-
-	for_each_populated_zone(zone) {
-		unsigned int order;
-		unsigned long nr[MAX_ORDER + 1], flags, total = 0;
-		unsigned char types[MAX_ORDER + 1];
-
-		if (zone_idx(zone) > max_zone_idx)
-			continue;
-		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
-			continue;
-		show_node(zone);
-		printk(KERN_CONT "%s: ", zone->name);
-
-		spin_lock_irqsave(&zone->lock, flags);
-		for (order = 0; order <= MAX_ORDER; order++) {
-			struct free_area *area = &zone->free_area[order];
-			int type;
-
-			nr[order] = area->nr_free;
-			total += nr[order] << order;
-
-			types[order] = 0;
-			for (type = 0; type < MIGRATE_TYPES; type++) {
-				if (!free_area_empty(area, type))
-					types[order] |= 1 << type;
-			}
-		}
-		spin_unlock_irqrestore(&zone->lock, flags);
-		for (order = 0; order <= MAX_ORDER; order++) {
-			printk(KERN_CONT "%lu*%lukB ",
-			       nr[order], K(1UL) << order);
-			if (nr[order])
-				show_migration_types(types[order]);
-		}
-		printk(KERN_CONT "= %lukB\n", K(total));
-	}
-
-	for_each_online_node(nid) {
-		if (show_mem_node_skip(filter, nid, nodemask))
-			continue;
-		hugetlb_show_meminfo_node(nid);
-	}
-
-	printk("%ld total pagecache pages\n", global_node_page_state(NR_FILE_PAGES));
-
-	show_swap_cache_info();
-}
-
 static void zoneref_set_zone(struct zone *zone, struct zoneref *zoneref)
 {
 	zoneref->zone = zone;
diff --git a/mm/show_mem.c b/mm/show_mem.c
new file mode 100644
index 000000000000..9f1a5d8b03d1
--- /dev/null
+++ b/mm/show_mem.c
@@ -0,0 +1,429 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic show_mem() implementation
+ *
+ * Copyright (C) 2008 Johannes Weiner <hannes@saeurebad.de>
+ */
+
+#include <linux/blkdev.h>
+#include <linux/cma.h>
+#include <linux/cpuset.h>
+#include <linux/highmem.h>
+#include <linux/hugetlb.h>
+#include <linux/mm.h>
+#include <linux/mmzone.h>
+#include <linux/swap.h>
+#include <linux/vmstat.h>
+
+#include "internal.h"
+#include "swap.h"
+
+atomic_long_t _totalram_pages __read_mostly;
+EXPORT_SYMBOL(_totalram_pages);
+unsigned long totalreserve_pages __read_mostly;
+unsigned long totalcma_pages __read_mostly;
+
+void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
+{
+	unsigned long total = 0, reserved = 0, highmem = 0;
+	struct zone *zone;
+
+	printk("Mem-Info:\n");
+	__show_free_areas(filter, nodemask, max_zone_idx);
+
+	for_each_populated_zone(zone) {
+
+		total += zone->present_pages;
+		reserved += zone->present_pages - zone_managed_pages(zone);
+
+		if (is_highmem(zone))
+			highmem += zone->present_pages;
+	}
+
+	printk("%lu pages RAM\n", total);
+	printk("%lu pages HighMem/MovableOnly\n", highmem);
+	printk("%lu pages reserved\n", reserved);
+#ifdef CONFIG_CMA
+	printk("%lu pages cma reserved\n", totalcma_pages);
+#endif
+#ifdef CONFIG_MEMORY_FAILURE
+	printk("%lu pages hwpoisoned\n", atomic_long_read(&num_poisoned_pages));
+#endif
+}
+
+static inline void show_node(struct zone *zone)
+{
+	if (IS_ENABLED(CONFIG_NUMA))
+		printk("Node %d ", zone_to_nid(zone));
+}
+
+long si_mem_available(void)
+{
+	long available;
+	unsigned long pagecache;
+	unsigned long wmark_low = 0;
+	unsigned long pages[NR_LRU_LISTS];
+	unsigned long reclaimable;
+	struct zone *zone;
+	int lru;
+
+	for (lru = LRU_BASE; lru < NR_LRU_LISTS; lru++)
+		pages[lru] = global_node_page_state(NR_LRU_BASE + lru);
+
+	for_each_zone(zone)
+		wmark_low += low_wmark_pages(zone);
+
+	/*
+	 * Estimate the amount of memory available for userspace allocations,
+	 * without causing swapping or OOM.
+	 */
+	available = global_zone_page_state(NR_FREE_PAGES) - totalreserve_pages;
+
+	/*
+	 * Not all the page cache can be freed, otherwise the system will
+	 * start swapping or thrashing. Assume at least half of the page
+	 * cache, or the low watermark worth of cache, needs to stay.
+	 */
+	pagecache = pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE];
+	pagecache -= min(pagecache / 2, wmark_low);
+	available += pagecache;
+
+	/*
+	 * Part of the reclaimable slab and other kernel memory consists of
+	 * items that are in use, and cannot be freed. Cap this estimate at the
+	 * low watermark.
+	 */
+	reclaimable = global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B) +
+		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
+	available += reclaimable - min(reclaimable / 2, wmark_low);
+
+	if (available < 0)
+		available = 0;
+	return available;
+}
+EXPORT_SYMBOL_GPL(si_mem_available);
+
+void si_meminfo(struct sysinfo *val)
+{
+	val->totalram = totalram_pages();
+	val->sharedram = global_node_page_state(NR_SHMEM);
+	val->freeram = global_zone_page_state(NR_FREE_PAGES);
+	val->bufferram = nr_blockdev_pages();
+	val->totalhigh = totalhigh_pages();
+	val->freehigh = nr_free_highpages();
+	val->mem_unit = PAGE_SIZE;
+}
+
+EXPORT_SYMBOL(si_meminfo);
+
+#ifdef CONFIG_NUMA
+void si_meminfo_node(struct sysinfo *val, int nid)
+{
+	int zone_type;		/* needs to be signed */
+	unsigned long managed_pages = 0;
+	unsigned long managed_highpages = 0;
+	unsigned long free_highpages = 0;
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++)
+		managed_pages += zone_managed_pages(&pgdat->node_zones[zone_type]);
+	val->totalram = managed_pages;
+	val->sharedram = node_page_state(pgdat, NR_SHMEM);
+	val->freeram = sum_zone_node_page_state(nid, NR_FREE_PAGES);
+#ifdef CONFIG_HIGHMEM
+	for (zone_type = 0; zone_type < MAX_NR_ZONES; zone_type++) {
+		struct zone *zone = &pgdat->node_zones[zone_type];
+
+		if (is_highmem(zone)) {
+			managed_highpages += zone_managed_pages(zone);
+			free_highpages += zone_page_state(zone, NR_FREE_PAGES);
+		}
+	}
+	val->totalhigh = managed_highpages;
+	val->freehigh = free_highpages;
+#else
+	val->totalhigh = managed_highpages;
+	val->freehigh = free_highpages;
+#endif
+	val->mem_unit = PAGE_SIZE;
+}
+#endif
+
+/*
+ * Determine whether the node should be displayed or not, depending on whether
+ * SHOW_MEM_FILTER_NODES was passed to show_free_areas().
+ */
+static bool show_mem_node_skip(unsigned int flags, int nid, nodemask_t *nodemask)
+{
+	if (!(flags & SHOW_MEM_FILTER_NODES))
+		return false;
+
+	/*
+	 * no node mask - aka implicit memory numa policy. Do not bother with
+	 * the synchronization - read_mems_allowed_begin - because we do not
+	 * have to be precise here.
+	 */
+	if (!nodemask)
+		nodemask = &cpuset_current_mems_allowed;
+
+	return !node_isset(nid, *nodemask);
+}
+
+static void show_migration_types(unsigned char type)
+{
+	static const char types[MIGRATE_TYPES] = {
+		[MIGRATE_UNMOVABLE]	= 'U',
+		[MIGRATE_MOVABLE]	= 'M',
+		[MIGRATE_RECLAIMABLE]	= 'E',
+		[MIGRATE_HIGHATOMIC]	= 'H',
+#ifdef CONFIG_CMA
+		[MIGRATE_CMA]		= 'C',
+#endif
+#ifdef CONFIG_MEMORY_ISOLATION
+		[MIGRATE_ISOLATE]	= 'I',
+#endif
+	};
+	char tmp[MIGRATE_TYPES + 1];
+	char *p = tmp;
+	int i;
+
+	for (i = 0; i < MIGRATE_TYPES; i++) {
+		if (type & (1 << i))
+			*p++ = types[i];
+	}
+
+	*p = '\0';
+	printk(KERN_CONT "(%s) ", tmp);
+}
+
+static bool node_has_managed_zones(pg_data_t *pgdat, int max_zone_idx)
+{
+	int zone_idx;
+	for (zone_idx = 0; zone_idx <= max_zone_idx; zone_idx++)
+		if (zone_managed_pages(pgdat->node_zones + zone_idx))
+			return true;
+	return false;
+}
+
+/*
+ * Show free area list (used inside shift_scroll-lock stuff)
+ * We also calculate the percentage fragmentation. We do this by counting the
+ * memory on each free list with the exception of the first item on the list.
+ *
+ * Bits in @filter:
+ * SHOW_MEM_FILTER_NODES: suppress nodes that are not allowed by current's
+ *   cpuset.
+ */
+void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
+{
+	unsigned long free_pcp = 0;
+	int cpu, nid;
+	struct zone *zone;
+	pg_data_t *pgdat;
+
+	for_each_populated_zone(zone) {
+		if (zone_idx(zone) > max_zone_idx)
+			continue;
+		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
+			continue;
+
+		for_each_online_cpu(cpu)
+			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+	}
+
+	printk("active_anon:%lu inactive_anon:%lu isolated_anon:%lu\n"
+		" active_file:%lu inactive_file:%lu isolated_file:%lu\n"
+		" unevictable:%lu dirty:%lu writeback:%lu\n"
+		" slab_reclaimable:%lu slab_unreclaimable:%lu\n"
+		" mapped:%lu shmem:%lu pagetables:%lu\n"
+		" sec_pagetables:%lu bounce:%lu\n"
+		" kernel_misc_reclaimable:%lu\n"
+		" free:%lu free_pcp:%lu free_cma:%lu\n",
+		global_node_page_state(NR_ACTIVE_ANON),
+		global_node_page_state(NR_INACTIVE_ANON),
+		global_node_page_state(NR_ISOLATED_ANON),
+		global_node_page_state(NR_ACTIVE_FILE),
+		global_node_page_state(NR_INACTIVE_FILE),
+		global_node_page_state(NR_ISOLATED_FILE),
+		global_node_page_state(NR_UNEVICTABLE),
+		global_node_page_state(NR_FILE_DIRTY),
+		global_node_page_state(NR_WRITEBACK),
+		global_node_page_state_pages(NR_SLAB_RECLAIMABLE_B),
+		global_node_page_state_pages(NR_SLAB_UNRECLAIMABLE_B),
+		global_node_page_state(NR_FILE_MAPPED),
+		global_node_page_state(NR_SHMEM),
+		global_node_page_state(NR_PAGETABLE),
+		global_node_page_state(NR_SECONDARY_PAGETABLE),
+		global_zone_page_state(NR_BOUNCE),
+		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE),
+		global_zone_page_state(NR_FREE_PAGES),
+		free_pcp,
+		global_zone_page_state(NR_FREE_CMA_PAGES));
+
+	for_each_online_pgdat(pgdat) {
+		if (show_mem_node_skip(filter, pgdat->node_id, nodemask))
+			continue;
+		if (!node_has_managed_zones(pgdat, max_zone_idx))
+			continue;
+
+		printk("Node %d"
+			" active_anon:%lukB"
+			" inactive_anon:%lukB"
+			" active_file:%lukB"
+			" inactive_file:%lukB"
+			" unevictable:%lukB"
+			" isolated(anon):%lukB"
+			" isolated(file):%lukB"
+			" mapped:%lukB"
+			" dirty:%lukB"
+			" writeback:%lukB"
+			" shmem:%lukB"
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			" shmem_thp: %lukB"
+			" shmem_pmdmapped: %lukB"
+			" anon_thp: %lukB"
+#endif
+			" writeback_tmp:%lukB"
+			" kernel_stack:%lukB"
+#ifdef CONFIG_SHADOW_CALL_STACK
+			" shadow_call_stack:%lukB"
+#endif
+			" pagetables:%lukB"
+			" sec_pagetables:%lukB"
+			" all_unreclaimable? %s"
+			"\n",
+			pgdat->node_id,
+			K(node_page_state(pgdat, NR_ACTIVE_ANON)),
+			K(node_page_state(pgdat, NR_INACTIVE_ANON)),
+			K(node_page_state(pgdat, NR_ACTIVE_FILE)),
+			K(node_page_state(pgdat, NR_INACTIVE_FILE)),
+			K(node_page_state(pgdat, NR_UNEVICTABLE)),
+			K(node_page_state(pgdat, NR_ISOLATED_ANON)),
+			K(node_page_state(pgdat, NR_ISOLATED_FILE)),
+			K(node_page_state(pgdat, NR_FILE_MAPPED)),
+			K(node_page_state(pgdat, NR_FILE_DIRTY)),
+			K(node_page_state(pgdat, NR_WRITEBACK)),
+			K(node_page_state(pgdat, NR_SHMEM)),
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+			K(node_page_state(pgdat, NR_SHMEM_THPS)),
+			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
+			K(node_page_state(pgdat, NR_ANON_THPS)),
+#endif
+			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
+			node_page_state(pgdat, NR_KERNEL_STACK_KB),
+#ifdef CONFIG_SHADOW_CALL_STACK
+			node_page_state(pgdat, NR_KERNEL_SCS_KB),
+#endif
+			K(node_page_state(pgdat, NR_PAGETABLE)),
+			K(node_page_state(pgdat, NR_SECONDARY_PAGETABLE)),
+			pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES ?
+				"yes" : "no");
+	}
+
+	for_each_populated_zone(zone) {
+		int i;
+
+		if (zone_idx(zone) > max_zone_idx)
+			continue;
+		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
+			continue;
+
+		free_pcp = 0;
+		for_each_online_cpu(cpu)
+			free_pcp += per_cpu_ptr(zone->per_cpu_pageset, cpu)->count;
+
+		show_node(zone);
+		printk(KERN_CONT
+			"%s"
+			" free:%lukB"
+			" boost:%lukB"
+			" min:%lukB"
+			" low:%lukB"
+			" high:%lukB"
+			" reserved_highatomic:%luKB"
+			" active_anon:%lukB"
+			" inactive_anon:%lukB"
+			" active_file:%lukB"
+			" inactive_file:%lukB"
+			" unevictable:%lukB"
+			" writepending:%lukB"
+			" present:%lukB"
+			" managed:%lukB"
+			" mlocked:%lukB"
+			" bounce:%lukB"
+			" free_pcp:%lukB"
+			" local_pcp:%ukB"
+			" free_cma:%lukB"
+			"\n",
+			zone->name,
+			K(zone_page_state(zone, NR_FREE_PAGES)),
+			K(zone->watermark_boost),
+			K(min_wmark_pages(zone)),
+			K(low_wmark_pages(zone)),
+			K(high_wmark_pages(zone)),
+			K(zone->nr_reserved_highatomic),
+			K(zone_page_state(zone, NR_ZONE_ACTIVE_ANON)),
+			K(zone_page_state(zone, NR_ZONE_INACTIVE_ANON)),
+			K(zone_page_state(zone, NR_ZONE_ACTIVE_FILE)),
+			K(zone_page_state(zone, NR_ZONE_INACTIVE_FILE)),
+			K(zone_page_state(zone, NR_ZONE_UNEVICTABLE)),
+			K(zone_page_state(zone, NR_ZONE_WRITE_PENDING)),
+			K(zone->present_pages),
+			K(zone_managed_pages(zone)),
+			K(zone_page_state(zone, NR_MLOCK)),
+			K(zone_page_state(zone, NR_BOUNCE)),
+			K(free_pcp),
+			K(this_cpu_read(zone->per_cpu_pageset->count)),
+			K(zone_page_state(zone, NR_FREE_CMA_PAGES)));
+		printk("lowmem_reserve[]:");
+		for (i = 0; i < MAX_NR_ZONES; i++)
+			printk(KERN_CONT " %ld", zone->lowmem_reserve[i]);
+		printk(KERN_CONT "\n");
+	}
+
+	for_each_populated_zone(zone) {
+		unsigned int order;
+		unsigned long nr[MAX_ORDER + 1], flags, total = 0;
+		unsigned char types[MAX_ORDER + 1];
+
+		if (zone_idx(zone) > max_zone_idx)
+			continue;
+		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
+			continue;
+		show_node(zone);
+		printk(KERN_CONT "%s: ", zone->name);
+
+		spin_lock_irqsave(&zone->lock, flags);
+		for (order = 0; order <= MAX_ORDER; order++) {
+			struct free_area *area = &zone->free_area[order];
+			int type;
+
+			nr[order] = area->nr_free;
+			total += nr[order] << order;
+
+			types[order] = 0;
+			for (type = 0; type < MIGRATE_TYPES; type++) {
+				if (!free_area_empty(area, type))
+					types[order] |= 1 << type;
+			}
+		}
+		spin_unlock_irqrestore(&zone->lock, flags);
+		for (order = 0; order <= MAX_ORDER; order++) {
+			printk(KERN_CONT "%lu*%lukB ",
+			       nr[order], K(1UL) << order);
+			if (nr[order])
+				show_migration_types(types[order]);
+		}
+		printk(KERN_CONT "= %lukB\n", K(total));
+	}
+
+	for_each_online_node(nid) {
+		if (show_mem_node_skip(filter, nid, nodemask))
+			continue;
+		hugetlb_show_meminfo_node(nid);
+	}
+
+	printk("%ld total pagecache pages\n", global_node_page_state(NR_FILE_PAGES));
+
+	show_swap_cache_info();
+}
-- 
2.35.3

