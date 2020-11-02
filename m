Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E342A26FE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 10:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgKBJ2h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 04:28:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727992AbgKBJ2g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 04:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604309313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R6jpfVvnbZweO6L9WbYNkIEDq4eIj3Ssxl4RmqN6ucY=;
        b=HgrxhqtrP+Ga9z1SnzZmRyjpE70IpK1CBX7OEPCjmefau8OVquAobaNhAg/gnt3Bj2/jTP
        Gv/225mSKZAjl9RLY0UvlXX9K4FeuTfG2WnGIDhcrEgr7RgmFsHrr9JJSYuv1gtAVAWK67
        p8ICv2GgFEVgffFXEQNreJ9Yr4sQ7N0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-jyeDbgmvO1-7_tiQHjRZ_Q-1; Mon, 02 Nov 2020 04:28:29 -0500
X-MC-Unique: jyeDbgmvO1-7_tiQHjRZ_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0526D8049F7;
        Mon,  2 Nov 2020 09:28:24 +0000 (UTC)
Received: from [10.36.113.163] (ovpn-113-163.ams2.redhat.com [10.36.113.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 206F75B4AF;
        Mon,  2 Nov 2020 09:28:14 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] arch, mm: make kernel_page_present() always
 available
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Len Brown <len.brown@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
References: <20201101170815.9795-1-rppt@kernel.org>
 <20201101170815.9795-5-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <08db307a-b093-d7aa-7364-045f328ab147@redhat.com>
Date:   Mon, 2 Nov 2020 10:28:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201101170815.9795-5-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01.11.20 18:08, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> For architectures that enable ARCH_HAS_SET_MEMORY having the ability to
> verify that a page is mapped in the kernel direct map can be useful
> regardless of hibernation.
> 
> Add RISC-V implementation of kernel_page_present(), update its forward
> declarations and stubs to be a part of set_memory API and remove ugly
> ifdefery in inlcude/linux/mm.h around current declarations of
> kernel_page_present().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/arm64/include/asm/cacheflush.h |  1 +
>   arch/arm64/mm/pageattr.c            |  4 +---
>   arch/riscv/include/asm/set_memory.h |  1 +
>   arch/riscv/mm/pageattr.c            | 29 +++++++++++++++++++++++++++++
>   arch/x86/include/asm/set_memory.h   |  1 +
>   arch/x86/mm/pat/set_memory.c        |  4 +---
>   include/linux/mm.h                  |  7 -------
>   include/linux/set_memory.h          |  5 +++++
>   8 files changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index 9384fd8fc13c..45217f21f1fe 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -140,6 +140,7 @@ int set_memory_valid(unsigned long addr, int numpages, int enable);
>   
>   int set_direct_map_invalid_noflush(struct page *page);
>   int set_direct_map_default_noflush(struct page *page);
> +bool kernel_page_present(struct page *page);
>   
>   #include <asm-generic/cacheflush.h>
>   
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 439325532be1..92eccaf595c8 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -186,8 +186,8 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
>   
>   	set_memory_valid((unsigned long)page_address(page), numpages, enable);
>   }
> +#endif /* CONFIG_DEBUG_PAGEALLOC */
>   
> -#ifdef CONFIG_HIBERNATION
>   /*
>    * This function is used to determine if a linear map page has been marked as
>    * not-valid. Walk the page table and check the PTE_VALID bit. This is based
> @@ -234,5 +234,3 @@ bool kernel_page_present(struct page *page)
>   	ptep = pte_offset_kernel(pmdp, addr);
>   	return pte_valid(READ_ONCE(*ptep));
>   }
> -#endif /* CONFIG_HIBERNATION */
> -#endif /* CONFIG_DEBUG_PAGEALLOC */
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index 4c5bae7ca01c..d690b08dff2a 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -24,6 +24,7 @@ static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
>   
>   int set_direct_map_invalid_noflush(struct page *page);
>   int set_direct_map_default_noflush(struct page *page);
> +bool kernel_page_present(struct page *page);
>   
>   #endif /* __ASSEMBLY__ */
>   
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 321b09d2e2ea..87ba5a68bbb8 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -198,3 +198,32 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
>   			     __pgprot(0), __pgprot(_PAGE_PRESENT));
>   }
>   #endif
> +
> +bool kernel_page_present(struct page *page)
> +{
> +	unsigned long addr = (unsigned long)page_address(page);
> +	pgd_t *pgd;
> +	pud_t *pud;
> +	p4d_t *p4d;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +
> +	pgd = pgd_offset_k(addr);
> +	if (!pgd_present(*pgd))
> +		return false;
> +
> +	p4d = p4d_offset(pgd, addr);
> +	if (!p4d_present(*p4d))
> +		return false;
> +
> +	pud = pud_offset(p4d, addr);
> +	if (!pud_present(*pud))
> +		return false;
> +
> +	pmd = pmd_offset(pud, addr);
> +	if (!pmd_present(*pmd))
> +		return false;
> +
> +	pte = pte_offset_kernel(pmd, addr);
> +	return pte_present(*pte);
> +}
> diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
> index 5948218f35c5..4352f08bfbb5 100644
> --- a/arch/x86/include/asm/set_memory.h
> +++ b/arch/x86/include/asm/set_memory.h
> @@ -82,6 +82,7 @@ int set_pages_rw(struct page *page, int numpages);
>   
>   int set_direct_map_invalid_noflush(struct page *page);
>   int set_direct_map_default_noflush(struct page *page);
> +bool kernel_page_present(struct page *page);
>   
>   extern int kernel_set_to_readonly;
>   
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index bc9be96b777f..16f878c26667 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2226,8 +2226,8 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
>   
>   	arch_flush_lazy_mmu_mode();
>   }
> +#endif /* CONFIG_DEBUG_PAGEALLOC */
>   
> -#ifdef CONFIG_HIBERNATION
>   bool kernel_page_present(struct page *page)
>   {
>   	unsigned int level;
> @@ -2239,8 +2239,6 @@ bool kernel_page_present(struct page *page)
>   	pte = lookup_address((unsigned long)page_address(page), &level);
>   	return (pte_val(*pte) & _PAGE_PRESENT);
>   }
> -#endif /* CONFIG_HIBERNATION */
> -#endif /* CONFIG_DEBUG_PAGEALLOC */
>   
>   int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
>   				   unsigned numpages, unsigned long page_flags)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ab0ef6bd351d..44b82f22e76a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2937,16 +2937,9 @@ static inline void debug_pagealloc_map_pages(struct page *page,
>   	if (debug_pagealloc_enabled_static())
>   		__kernel_map_pages(page, numpages, enable);
>   }
> -
> -#ifdef CONFIG_HIBERNATION
> -extern bool kernel_page_present(struct page *page);
> -#endif	/* CONFIG_HIBERNATION */
>   #else	/* CONFIG_DEBUG_PAGEALLOC */
>   static inline void debug_pagealloc_map_pages(struct page *page,
>   					     int numpages, int enable) {}
> -#ifdef CONFIG_HIBERNATION
> -static inline bool kernel_page_present(struct page *page) { return true; }
> -#endif	/* CONFIG_HIBERNATION */
>   #endif	/* CONFIG_DEBUG_PAGEALLOC */
>   
>   #ifdef __HAVE_ARCH_GATE_AREA
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index 860e0f843c12..fe1aa4e54680 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -23,6 +23,11 @@ static inline int set_direct_map_default_noflush(struct page *page)
>   {
>   	return 0;
>   }
> +
> +static inline bool kernel_page_present(struct page *page)
> +{
> +	return true;
> +}
>   #endif
>   
>   #ifndef set_mce_nospec
> 

It's somewhat weird to move this to set_memory.h - it's only one 
possible user. I think include/linux/mm.h is a better fit. Ack to making 
it independent of CONFIG_HIBERNATION.

in include/linux/mm.h , I'd prefer:

#if defined(CONFIG_DEBUG_PAGEALLOC) || \
     defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
bool kernel_page_present(struct page *page);
#else
static inline bool kernel_page_present(struct page *page)
{
	return true;
}
#endif

-- 
Thanks,

David / dhildenb

