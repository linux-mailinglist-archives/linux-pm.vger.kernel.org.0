Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822C02A6C57
	for <lists+linux-pm@lfdr.de>; Wed,  4 Nov 2020 19:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgKDSCZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Nov 2020 13:02:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:40058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgKDSCY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Nov 2020 13:02:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 46661AC2F;
        Wed,  4 Nov 2020 18:02:22 +0000 (UTC)
Subject: Re: [PATCH v4 3/4] arch, mm: restore dependency of
 __kernel_map_pages() of DEBUG_PAGEALLOC
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
References: <20201103162057.22916-1-rppt@kernel.org>
 <20201103162057.22916-4-rppt@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <f9c1dc66-fc60-db4d-9670-0271adb2ed07@suse.cz>
Date:   Wed, 4 Nov 2020 19:02:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103162057.22916-4-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/3/20 5:20 PM, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>

Subject should have "on DEBUG_PAGEALLOC" ?

> The design of DEBUG_PAGEALLOC presumes that __kernel_map_pages() must never
> fail. With this assumption is wouldn't be safe to allow general usage of
> this function.
> 
> Moreover, some architectures that implement __kernel_map_pages() have this
> function guarded by #ifdef DEBUG_PAGEALLOC and some refuse to map/unmap
> pages when page allocation debugging is disabled at runtime.
> 
> As all the users of __kernel_map_pages() were converted to use
> debug_pagealloc_map_pages() it is safe to make it available only when
> DEBUG_PAGEALLOC is set.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>   arch/Kconfig                     |  3 +++
>   arch/arm64/Kconfig               |  4 +---
>   arch/arm64/mm/pageattr.c         |  8 ++++++--
>   arch/powerpc/Kconfig             |  5 +----
>   arch/riscv/Kconfig               |  4 +---
>   arch/riscv/include/asm/pgtable.h |  2 --
>   arch/riscv/mm/pageattr.c         |  2 ++
>   arch/s390/Kconfig                |  4 +---
>   arch/sparc/Kconfig               |  4 +---
>   arch/x86/Kconfig                 |  4 +---
>   arch/x86/mm/pat/set_memory.c     |  2 ++
>   include/linux/mm.h               | 10 +++++++---
>   12 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 56b6ccc0e32d..56d4752b6db6 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1028,6 +1028,9 @@ config HAVE_STATIC_CALL_INLINE
>   	bool
>   	depends on HAVE_STATIC_CALL
>   
> +config ARCH_SUPPORTS_DEBUG_PAGEALLOC
> +	bool
> +
>   source "kernel/gcov/Kconfig"
>   
>   source "scripts/gcc-plugins/Kconfig"
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1d466addb078..a932810cfd90 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -71,6 +71,7 @@ config ARM64
>   	select ARCH_USE_QUEUED_RWLOCKS
>   	select ARCH_USE_QUEUED_SPINLOCKS
>   	select ARCH_USE_SYM_ANNOTATIONS
> +	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
>   	select ARCH_SUPPORTS_MEMORY_FAILURE
>   	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
>   	select ARCH_SUPPORTS_ATOMIC_RMW
> @@ -1025,9 +1026,6 @@ config HOLES_IN_ZONE
>   
>   source "kernel/Kconfig.hz"
>   
> -config ARCH_SUPPORTS_DEBUG_PAGEALLOC
> -	def_bool y
> -
>   config ARCH_SPARSEMEM_ENABLE
>   	def_bool y
>   	select SPARSEMEM_VMEMMAP_ENABLE
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index 1b94f5b82654..439325532be1 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -155,7 +155,7 @@ int set_direct_map_invalid_noflush(struct page *page)
>   		.clear_mask = __pgprot(PTE_VALID),
>   	};
>   
> -	if (!rodata_full)
> +	if (!debug_pagealloc_enabled() && !rodata_full)
>   		return 0;
>   
>   	return apply_to_page_range(&init_mm,
> @@ -170,7 +170,7 @@ int set_direct_map_default_noflush(struct page *page)
>   		.clear_mask = __pgprot(PTE_RDONLY),
>   	};
>   
> -	if (!rodata_full)
> +	if (!debug_pagealloc_enabled() && !rodata_full)
>   		return 0;
>   
>   	return apply_to_page_range(&init_mm,

I don't understand these two hunks. Previous patch calls this for hibernation 
when CONFIG_ARCH_HAS_SET_DIRECT_MAP, which is true for arm64. Why suddenly this 
starts to depend on debug_pagealloc_enabled()?
