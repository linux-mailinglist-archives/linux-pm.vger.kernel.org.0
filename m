Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08AA2AA9DE
	for <lists+linux-pm@lfdr.de>; Sun,  8 Nov 2020 07:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgKHG6q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Nov 2020 01:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgKHG6q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 8 Nov 2020 01:58:46 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2003622210;
        Sun,  8 Nov 2020 06:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604818725;
        bh=0+/Ijks+tfwTVzbr4Km98lXXrR2UvY+Np3e94RlQ6xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kojy+ghyD1q7+EkttkLyjKdeW/x7n35VGmuZbOsZ8H9qHCfBB04pMlemdjxjAiZxj
         b4raIaTvdFV1sVmrUS8fiCsOP50b3YEG4eZXd8KF2TDGzzESACuFOBYXb2F6YA69YC
         OjclfcDeaofFbFA/P9NqmCTxxkKxrFvP9msEiuC8=
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
        x86@kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 3/5] PM: hibernate: make direct map manipulations more explicit
Date:   Sun,  8 Nov 2020 08:57:56 +0200
Message-Id: <20201108065758.1815-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108065758.1815-1-rppt@kernel.org>
References: <20201108065758.1815-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

When DEBUG_PAGEALLOC or ARCH_HAS_SET_DIRECT_MAP is enabled a page may be
not present in the direct map and has to be explicitly mapped before it
could be copied.

Introduce hibernate_map_page() and hibernation_unmap_page() that will
explicitly use set_direct_map_{default,invalid}_noflush() for
ARCH_HAS_SET_DIRECT_MAP case and debug_pagealloc_{map,unmap}_pages() for
DEBUG_PAGEALLOC case.

The remapping of the pages in safe_copy_page() presumes that it only
changes protection bits in an existing PTE and so it is safe to ignore
return value of set_direct_map_{default,invalid}_noflush().

Still, add a pr_warn() so that future changes in set_memory APIs will not
silently break hibernation.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h      | 12 ------------
 kernel/power/snapshot.c | 38 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bb8c70178f4e..e198b938f5c5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2927,16 +2927,6 @@ static inline bool debug_pagealloc_enabled_static(void)
 #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
 extern void __kernel_map_pages(struct page *page, int numpages, int enable);
 
-/*
- * When called in DEBUG_PAGEALLOC context, the call should most likely be
- * guarded by debug_pagealloc_enabled() or debug_pagealloc_enabled_static()
- */
-static inline void
-kernel_map_pages(struct page *page, int numpages, int enable)
-{
-	__kernel_map_pages(page, numpages, enable);
-}
-
 static inline void debug_pagealloc_map_pages(struct page *page, int numpages)
 {
 	if (debug_pagealloc_enabled_static())
@@ -2953,8 +2943,6 @@ static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages)
 extern bool kernel_page_present(struct page *page);
 #endif	/* CONFIG_HIBERNATION */
 #else	/* CONFIG_DEBUG_PAGEALLOC || CONFIG_ARCH_HAS_SET_DIRECT_MAP */
-static inline void
-kernel_map_pages(struct page *page, int numpages, int enable) {}
 static inline void debug_pagealloc_map_pages(struct page *page, int numpages) {}
 static inline void debug_pagealloc_unmap_pages(struct page *page, int numpages) {}
 #ifdef CONFIG_HIBERNATION
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 46b1804c1ddf..d848377dd8dc 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -76,6 +76,40 @@ static inline void hibernate_restore_protect_page(void *page_address) {}
 static inline void hibernate_restore_unprotect_page(void *page_address) {}
 #endif /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
 
+
+/*
+ * The calls to set_direct_map_*() should not fail because remapping a page
+ * here means that we only update protection bits in an existing PTE.
+ * It is still worth to have a warning here if something changes and this
+ * will no longer be the case.
+ */
+static inline void hibernate_map_page(struct page *page)
+{
+	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
+		int ret = set_direct_map_default_noflush(page);
+
+		if (ret)
+			pr_warn_once("Failed to remap page\n");
+	} else {
+		debug_pagealloc_map_pages(page, 1);
+	}
+}
+
+static inline void hibernate_unmap_page(struct page *page)
+{
+	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
+		unsigned long addr = (unsigned long)page_address(page);
+		int ret  = set_direct_map_invalid_noflush(page);
+
+		if (ret)
+			pr_warn_once("Failed to remap page\n");
+
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	} else {
+		debug_pagealloc_unmap_pages(page, 1);
+	}
+}
+
 static int swsusp_page_is_free(struct page *);
 static void swsusp_set_page_forbidden(struct page *);
 static void swsusp_unset_page_forbidden(struct page *);
@@ -1355,9 +1389,9 @@ static void safe_copy_page(void *dst, struct page *s_page)
 	if (kernel_page_present(s_page)) {
 		do_copy_page(dst, page_address(s_page));
 	} else {
-		kernel_map_pages(s_page, 1, 1);
+		hibernate_map_page(s_page);
 		do_copy_page(dst, page_address(s_page));
-		kernel_map_pages(s_page, 1, 0);
+		hibernate_unmap_page(s_page);
 	}
 }
 
-- 
2.28.0

