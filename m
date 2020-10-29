Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3EC29F13A
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 17:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgJ2QUP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 12:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgJ2QUO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Oct 2020 12:20:14 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E20214DB;
        Thu, 29 Oct 2020 16:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603988412;
        bh=Vg0yD9BtaVpEElcVKbOe2Bvglikqvddyf8H8xD1VMBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4hvKt8QAkQABI0XAx0mpjzWm82u6JR9o7yyFv1WWXyz7Ou/WOjRxq9xYLO1Zzggw
         4hOYKvUVWDl1QLLAuw6aHCM7jGzE5qdL6Kygzzm3oIw2JLUCXToATDPCt9QQTIo7nB
         DlBE1o3qBycyjp/MHMZlhPMj/C+Wo5gZSVn1UdL8=
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
Subject: [PATCH v2 4/4] arch, mm: make kernel_page_present() always available
Date:   Thu, 29 Oct 2020 18:19:02 +0200
Message-Id: <20201029161902.19272-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029161902.19272-1-rppt@kernel.org>
References: <20201029161902.19272-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

For architectures that enable ARCH_HAS_SET_MEMORY having the ability to
verify that a page is mapped in the kernel direct map can be useful
regardless of hibernation.

Add RISC-V implementation of kernel_page_present(), update its forward
declarations and stubs to be a part of set_memory API and remove ugly
ifdefery in inlcude/linux/mm.h around current declarations of
kernel_page_present().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/cacheflush.h |  1 +
 arch/riscv/include/asm/set_memory.h |  1 +
 arch/riscv/mm/pageattr.c            | 29 +++++++++++++++++++++++++++++
 arch/x86/include/asm/set_memory.h   |  1 +
 arch/x86/mm/pat/set_memory.c        |  2 --
 include/linux/mm.h                  |  7 -------
 include/linux/set_memory.h          |  5 +++++
 7 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 9384fd8fc13c..45217f21f1fe 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -140,6 +140,7 @@ int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+bool kernel_page_present(struct page *page);
 
 #include <asm-generic/cacheflush.h>
 
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index 4c5bae7ca01c..d690b08dff2a 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -24,6 +24,7 @@ static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+bool kernel_page_present(struct page *page);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 321b09d2e2ea..87ba5a68bbb8 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -198,3 +198,32 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 			     __pgprot(0), __pgprot(_PAGE_PRESENT));
 }
 #endif
+
+bool kernel_page_present(struct page *page)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	pgd_t *pgd;
+	pud_t *pud;
+	p4d_t *p4d;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset_k(addr);
+	if (!pgd_present(*pgd))
+		return false;
+
+	p4d = p4d_offset(pgd, addr);
+	if (!p4d_present(*p4d))
+		return false;
+
+	pud = pud_offset(p4d, addr);
+	if (!pud_present(*pud))
+		return false;
+
+	pmd = pmd_offset(pud, addr);
+	if (!pmd_present(*pmd))
+		return false;
+
+	pte = pte_offset_kernel(pmd, addr);
+	return pte_present(*pte);
+}
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 5948218f35c5..4352f08bfbb5 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -82,6 +82,7 @@ int set_pages_rw(struct page *page, int numpages);
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+bool kernel_page_present(struct page *page);
 
 extern int kernel_set_to_readonly;
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 7f248fc45317..16f878c26667 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2228,7 +2228,6 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 }
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
-#ifdef CONFIG_HIBERNATION
 bool kernel_page_present(struct page *page)
 {
 	unsigned int level;
@@ -2240,7 +2239,6 @@ bool kernel_page_present(struct page *page)
 	pte = lookup_address((unsigned long)page_address(page), &level);
 	return (pte_val(*pte) & _PAGE_PRESENT);
 }
-#endif /* CONFIG_HIBERNATION */
 
 int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 				   unsigned numpages, unsigned long page_flags)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ab0ef6bd351d..44b82f22e76a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2937,16 +2937,9 @@ static inline void debug_pagealloc_map_pages(struct page *page,
 	if (debug_pagealloc_enabled_static())
 		__kernel_map_pages(page, numpages, enable);
 }
-
-#ifdef CONFIG_HIBERNATION
-extern bool kernel_page_present(struct page *page);
-#endif	/* CONFIG_HIBERNATION */
 #else	/* CONFIG_DEBUG_PAGEALLOC */
 static inline void debug_pagealloc_map_pages(struct page *page,
 					     int numpages, int enable) {}
-#ifdef CONFIG_HIBERNATION
-static inline bool kernel_page_present(struct page *page) { return true; }
-#endif	/* CONFIG_HIBERNATION */
 #endif	/* CONFIG_DEBUG_PAGEALLOC */
 
 #ifdef __HAVE_ARCH_GATE_AREA
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index 860e0f843c12..fe1aa4e54680 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -23,6 +23,11 @@ static inline int set_direct_map_default_noflush(struct page *page)
 {
 	return 0;
 }
+
+static inline bool kernel_page_present(struct page *page)
+{
+	return true;
+}
 #endif
 
 #ifndef set_mce_nospec
-- 
2.28.0

