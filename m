Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089B3298132
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 11:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415117AbgJYKQk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 06:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415116AbgJYKQj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 25 Oct 2020 06:16:39 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 588C0223AC;
        Sun, 25 Oct 2020 10:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603620998;
        bh=+K+xWVsprkoE5NXLr7XmpN8TUaUKkedCjdcNMY1fC64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yWcjcDRJUVlh27zoZCsehXiSA66bJUO6vH08WwG2F0UWSzDAT4V4cC70hJqiZe4iK
         Ef53qUHsELceiLw8f8w2WzmUP05ISOLwRaxUEHen/9i2qmEvRsNWEhBK/W2E6X5Z9h
         BU6vsW7wlJbYJ/ks589wkB0F4fyeXkMO9DDCpFOo=
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
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH 1/4] mm: introduce debug_pagealloc_map_pages() helper
Date:   Sun, 25 Oct 2020 12:15:52 +0200
Message-Id: <20201025101555.3057-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201025101555.3057-1-rppt@kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
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
__kernel_map_pages() into a single debug_pagealloc_map_pages() function to
emphasize that __kernel_map_pages() should not be called without
DEBUG_PAGEALLOC and use this new function to map/unmap pages when page
allocation debug is enabled.

As the only remaining user of kernel_map_pages() is the hibernation code,
mode that function into kernel/power/snapshot.c closer to a caller.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/mm.h      | 16 +++++++---------
 kernel/power/snapshot.c | 11 +++++++++++
 mm/memory_hotplug.c     |  3 +--
 mm/page_alloc.c         |  6 ++----
 mm/slab.c               |  8 +++-----
 5 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef360fe70aaf..14e397f3752c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2927,21 +2927,19 @@ static inline bool debug_pagealloc_enabled_static(void)
 #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
 extern void __kernel_map_pages(struct page *page, int numpages, int enable);
 
-/*
- * When called in DEBUG_PAGEALLOC context, the call should most likely be
- * guarded by debug_pagealloc_enabled() or debug_pagealloc_enabled_static()
- */
-static inline void
-kernel_map_pages(struct page *page, int numpages, int enable)
+static inline void debug_pagealloc_map_pages(struct page *page,
+					     int numpages, int enable)
 {
-	__kernel_map_pages(page, numpages, enable);
+	if (debug_pagealloc_enabled_static())
+		__kernel_map_pages(page, numpages, enable);
 }
+
 #ifdef CONFIG_HIBERNATION
 extern bool kernel_page_present(struct page *page);
 #endif	/* CONFIG_HIBERNATION */
 #else	/* CONFIG_DEBUG_PAGEALLOC || CONFIG_ARCH_HAS_SET_DIRECT_MAP */
-static inline void
-kernel_map_pages(struct page *page, int numpages, int enable) {}
+static inline void debug_pagealloc_map_pages(struct page *page,
+					     int numpages, int enable) {}
 #ifdef CONFIG_HIBERNATION
 static inline bool kernel_page_present(struct page *page) { return true; }
 #endif	/* CONFIG_HIBERNATION */
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 46b1804c1ddf..fa499466f645 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -76,6 +76,17 @@ static inline void hibernate_restore_protect_page(void *page_address) {}
 static inline void hibernate_restore_unprotect_page(void *page_address) {}
 #endif /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
 
+#if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
+static inline void
+kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	__kernel_map_pages(page, numpages, enable);
+}
+#else
+static inline void
+kernel_map_pages(struct page *page, int numpages, int enable) {}
+#endif
+
 static int swsusp_page_is_free(struct page *);
 static void swsusp_set_page_forbidden(struct page *);
 static void swsusp_unset_page_forbidden(struct page *);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index b44d4c7ba73b..e2b6043a4428 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -614,8 +614,7 @@ void generic_online_page(struct page *page, unsigned int order)
 	 * so we should map it first. This is better than introducing a special
 	 * case in page freeing fast path.
 	 */
-	if (debug_pagealloc_enabled_static())
-		kernel_map_pages(page, 1 << order, 1);
+	debug_pagealloc_map_pages(page, 1 << order, 1);
 	__free_pages_core(page, order);
 	totalram_pages_add(1UL << order);
 #ifdef CONFIG_HIGHMEM
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 23f5066bd4a5..9a66a1ff9193 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1272,8 +1272,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	 */
 	arch_free_page(page, order);
 
-	if (debug_pagealloc_enabled_static())
-		kernel_map_pages(page, 1 << order, 0);
+	debug_pagealloc_map_pages(page, 1 << order, 0);
 
 	kasan_free_nondeferred_pages(page, order);
 
@@ -2270,8 +2269,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	set_page_refcounted(page);
 
 	arch_alloc_page(page, order);
-	if (debug_pagealloc_enabled_static())
-		kernel_map_pages(page, 1 << order, 1);
+	debug_pagealloc_map_pages(page, 1 << order, 1);
 	kasan_alloc_pages(page, order);
 	kernel_poison_pages(page, 1 << order, 1);
 	set_page_owner(page, order, gfp_flags);
diff --git a/mm/slab.c b/mm/slab.c
index b1113561b98b..340db0ce74c4 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1431,10 +1431,8 @@ static bool is_debug_pagealloc_cache(struct kmem_cache *cachep)
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static void slab_kernel_map(struct kmem_cache *cachep, void *objp, int map)
 {
-	if (!is_debug_pagealloc_cache(cachep))
-		return;
-
-	kernel_map_pages(virt_to_page(objp), cachep->size / PAGE_SIZE, map);
+	debug_pagealloc_map_pages(virt_to_page(objp),
+				  cachep->size / PAGE_SIZE, map);
 }
 
 #else
@@ -2062,7 +2060,7 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
 
 #if DEBUG
 	/*
-	 * If we're going to use the generic kernel_map_pages()
+	 * If we're going to use the generic debug_pagealloc_map_pages()
 	 * poisoning, then it's going to smash the contents of
 	 * the redzone and userword anyhow, so switch them off.
 	 */
-- 
2.28.0

