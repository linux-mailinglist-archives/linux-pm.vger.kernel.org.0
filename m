Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5042AC4D5
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 20:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgKITVy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 14:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgKITVy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Nov 2020 14:21:54 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6901C20809;
        Mon,  9 Nov 2020 19:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604949713;
        bh=h7vn3gxjwfsVsLQ35Kx4jKwALCLmKMWicQ8E54QVB4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rSdlvJO1ibHDkdea0knczQZR4AbttS8kfVDHQCw2titR3o4nJY2i/OgWKC7SHWY5J
         1l/MTjAmGBVdJlgpBDWkYgMJ6ZdgPHgSggN5w9wbA7CkWkuyKB2Jfw1fChF6CIpW6b
         cmfNWDEk79APLhM4A7QRIdtX596XCytquuH1UwkU=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Len Brown <len.brown@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pavel Machek <pavel@ucw.cz>, Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v7 1/4] mm: introduce debug_pagealloc_{map,unmap}_pages() helpers
Date:   Mon,  9 Nov 2020 21:21:25 +0200
Message-Id: <20201109192128.960-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109192128.960-1-rppt@kernel.org>
References: <20201109192128.960-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

When CONFIG_DEBUG_PAGEALLOC is enabled, it unmaps pages from the kernel
direct mapping after free_pages(). The pages than need to be mapped back
before they could be used. Theese mapping operations use
__kernel_map_pages() guarded with with debug_pagealloc_enabled().

The only place that calls __kernel_map_pages() without checking whether
DEBUG_PAGEALLOC is enabled is the hibernation code that presumes
availability of this function when ARCH_HAS_SET_DIRECT_MAP is set.
Still, on arm64, __kernel_map_pages() will bail out when DEBUG_PAGEALLOC is
not enabled but set_direct_map_invalid_noflush() may render some pages not
present in the direct map and hibernation code won't be able to save such
pages.

To make page allocation debugging and hibernation interaction more robust,
the dependency on DEBUG_PAGEALLOC or ARCH_HAS_SET_DIRECT_MAP has to be made
more explicit.

Start with combining the guard condition and the call to
__kernel_map_pages() into debug_pagealloc_map_pages() and
debug_pagealloc_unmap_pages() functions to emphasize that
__kernel_map_pages() should not be called without DEBUG_PAGEALLOC and use
these new functions to map/unmap pages when page allocation debugging is
enabled.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h  | 15 +++++++++++++++
 mm/memory_hotplug.c |  3 +--
 mm/page_alloc.c     |  6 ++----
 mm/slab.c           |  2 +-
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360fe70aaf..bb8c70178f4e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2936,12 +2936,27 @@ kernel_map_pages(struct page *page, int numpages, int enable)
 {
 	__kernel_map_pages(page, numpages, enable);
 }
+
+static inline void debug_pagealloc_map_pages(struct page *page, int numpages)
+{
+	if (debug_pagealloc_enabled_static())
+		__kernel_map_pages(page, numpages, 1);
+}
+
+static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages)
+{
+	if (debug_pagealloc_enabled_static())
+		__kernel_map_pages(page, numpages, 0);
+}
+
 #ifdef CONFIG_HIBERNATION
 extern bool kernel_page_present(struct page *page);
 #endif	/* CONFIG_HIBERNATION */
 #else	/* CONFIG_DEBUG_PAGEALLOC || CONFIG_ARCH_HAS_SET_DIRECT_MAP */
 static inline void
 kernel_map_pages(struct page *page, int numpages, int enable) {}
+static inline void debug_pagealloc_map_pages(struct page *page, int numpages) {}
+static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages) {}
 #ifdef CONFIG_HIBERNATION
 static inline bool kernel_page_present(struct page *page) { return true; }
 #endif	/* CONFIG_HIBERNATION */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b44d4c7ba73b..f18f86ba2a68 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -614,8 +614,7 @@ void generic_online_page(struct page *page, unsigned int order)
 	 * so we should map it first. This is better than introducing a special
 	 * case in page freeing fast path.
 	 */
-	if (debug_pagealloc_enabled_static())
-		kernel_map_pages(page, 1 << order, 1);
+	debug_pagealloc_map_pages(page, 1 << order);
 	__free_pages_core(page, order);
 	totalram_pages_add(1UL << order);
 #ifdef CONFIG_HIGHMEM
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 23f5066bd4a5..db1bf70458d0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1272,8 +1272,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	 */
 	arch_free_page(page, order);
 
-	if (debug_pagealloc_enabled_static())
-		kernel_map_pages(page, 1 << order, 0);
+	debug_pagealloc_unmap_pages(page, 1 << order);
 
 	kasan_free_nondeferred_pages(page, order);
 
@@ -2270,8 +2269,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	set_page_refcounted(page);
 
 	arch_alloc_page(page, order);
-	if (debug_pagealloc_enabled_static())
-		kernel_map_pages(page, 1 << order, 1);
+	debug_pagealloc_map_pages(page, 1 << order);
 	kasan_alloc_pages(page, order);
 	kernel_poison_pages(page, 1 << order, 1);
 	set_page_owner(page, order, gfp_flags);
diff --git a/mm/slab.c b/mm/slab.c
index b1113561b98b..5a46f5bd5957 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1434,7 +1434,7 @@ static void slab_kernel_map(struct kmem_cache *cachep, void *objp, int map)
 	if (!is_debug_pagealloc_cache(cachep))
 		return;
 
-	kernel_map_pages(virt_to_page(objp), cachep->size / PAGE_SIZE, map);
+	__kernel_map_pages(virt_to_page(objp), cachep->size / PAGE_SIZE, map);
 }
 
 #else
-- 
2.28.0

