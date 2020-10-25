Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBD4298133
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 11:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415131AbgJYKQv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 06:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415116AbgJYKQt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 25 Oct 2020 06:16:49 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DB8322314;
        Sun, 25 Oct 2020 10:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603621008;
        bh=bPnP1TnrAlU7rcLw/axrz4SbJiUgDqoCknxxvu06CG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLD7RjimnmIZJ9yVq0/7EC+biqWmxnWNy0cBy1FWRgZNXBjqH7aGLuHE1C2v2u6w7
         +nRLX8XkMHNtaApu5K5mRX29IAgW/dO4fxbUsO7Mh4SyTjDj/XKwJhjGb7+zhpoHAS
         a1jhgDfRJuTG99jahOJvPTUOQLGTdgLSlZQkME/Y=
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
Subject: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages in the direct map
Date:   Sun, 25 Oct 2020 12:15:53 +0200
Message-Id: <20201025101555.3057-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201025101555.3057-1-rppt@kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

When DEBUG_PAGEALLOC or ARCH_HAS_SET_DIRECT_MAP is enabled a page may be
not present in the direct map and has to be explicitly mapped before it
could be copied.

On arm64 it is possible that a page would be removed from the direct map
using set_direct_map_invalid_noflush() but __kernel_map_pages() will refuse
to map this page back if DEBUG_PAGEALLOC is disabled.

Explicitly use set_direct_map_{default,invalid}_noflush() for
ARCH_HAS_SET_DIRECT_MAP case and debug_pagealloc_map_pages() for
DEBUG_PAGEALLOC case.

While on that, rename kernel_map_pages() to hibernate_map_page() and drop
numpages parameter.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 kernel/power/snapshot.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index fa499466f645..ecb7b32ce77c 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -76,16 +76,25 @@ static inline void hibernate_restore_protect_page(void *page_address) {}
 static inline void hibernate_restore_unprotect_page(void *page_address) {}
 #endif /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
 
-#if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
-static inline void
-kernel_map_pages(struct page *page, int numpages, int enable)
+static inline void hibernate_map_page(struct page *page, int enable)
 {
-	__kernel_map_pages(page, numpages, enable);
+	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
+		unsigned long addr = (unsigned long)page_address(page);
+		int ret;
+
+		if (enable)
+			ret = set_direct_map_default_noflush(page);
+		else
+			ret = set_direct_map_invalid_noflush(page);
+
+		if (WARN_ON(ret))
+			return;
+
+		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
+	} else {
+		debug_pagealloc_map_pages(page, 1, enable);
+	}
 }
-#else
-static inline void
-kernel_map_pages(struct page *page, int numpages, int enable) {}
-#endif
 
 static int swsusp_page_is_free(struct page *);
 static void swsusp_set_page_forbidden(struct page *);
@@ -1366,9 +1375,9 @@ static void safe_copy_page(void *dst, struct page *s_page)
 	if (kernel_page_present(s_page)) {
 		do_copy_page(dst, page_address(s_page));
 	} else {
-		kernel_map_pages(s_page, 1, 1);
+		hibernate_map_page(s_page, 1);
 		do_copy_page(dst, page_address(s_page));
-		kernel_map_pages(s_page, 1, 0);
+		hibernate_map_page(s_page, 0);
 	}
 }
 
-- 
2.28.0

