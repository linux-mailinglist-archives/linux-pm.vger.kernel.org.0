Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BE12A7D62
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 12:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgKELmY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 06:42:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730124AbgKELmY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 06:42:24 -0500
Received: from kernel.org (unknown [2.55.183.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AF252071A;
        Thu,  5 Nov 2020 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604576542;
        bh=wBBJASevkpsRXZMXJL2OiMK6CtZhq8iWhEgufgr/S4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHJruZEGepbkqow1qhwuCKDkVoe/lpKxogvFghtL/5RowA6qyrxSq531Gliqcbzyu
         tDTgfPvrJ9vN7jvSKObEIq9kiRh1xeaKbxhp+zX6zw46ZOu6eW7fSqiBEMlywA8zjt
         Ph/W2QEvA7Z47iM8NgnnYxvGybdML21CtLacZNig=
Date:   Thu, 5 Nov 2020 13:42:00 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
Subject: Re: [PATCH v4 3/4] arch, mm: restore dependency of
 __kernel_map_pages() of DEBUG_PAGEALLOC
Message-ID: <20201105114200.GZ4879@kernel.org>
References: <20201103162057.22916-1-rppt@kernel.org>
 <20201103162057.22916-4-rppt@kernel.org>
 <f9c1dc66-fc60-db4d-9670-0271adb2ed07@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9c1dc66-fc60-db4d-9670-0271adb2ed07@suse.cz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:02:20PM +0100, Vlastimil Babka wrote:
> On 11/3/20 5:20 PM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Subject should have "on DEBUG_PAGEALLOC" ?
> 
> > The design of DEBUG_PAGEALLOC presumes that __kernel_map_pages() must never
> > fail. With this assumption is wouldn't be safe to allow general usage of
> > this function.
> > 
> > Moreover, some architectures that implement __kernel_map_pages() have this
> > function guarded by #ifdef DEBUG_PAGEALLOC and some refuse to map/unmap
> > pages when page allocation debugging is disabled at runtime.
> > 
> > As all the users of __kernel_map_pages() were converted to use
> > debug_pagealloc_map_pages() it is safe to make it available only when
> > DEBUG_PAGEALLOC is set.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   arch/Kconfig                     |  3 +++
> >   arch/arm64/Kconfig               |  4 +---
> >   arch/arm64/mm/pageattr.c         |  8 ++++++--
> >   arch/powerpc/Kconfig             |  5 +----
> >   arch/riscv/Kconfig               |  4 +---
> >   arch/riscv/include/asm/pgtable.h |  2 --
> >   arch/riscv/mm/pageattr.c         |  2 ++
> >   arch/s390/Kconfig                |  4 +---
> >   arch/sparc/Kconfig               |  4 +---
> >   arch/x86/Kconfig                 |  4 +---
> >   arch/x86/mm/pat/set_memory.c     |  2 ++
> >   include/linux/mm.h               | 10 +++++++---
> >   12 files changed, 26 insertions(+), 26 deletions(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 56b6ccc0e32d..56d4752b6db6 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1028,6 +1028,9 @@ config HAVE_STATIC_CALL_INLINE
> >   	bool
> >   	depends on HAVE_STATIC_CALL
> > +config ARCH_SUPPORTS_DEBUG_PAGEALLOC
> > +	bool
> > +
> >   source "kernel/gcov/Kconfig"
> >   source "scripts/gcc-plugins/Kconfig"
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 1d466addb078..a932810cfd90 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -71,6 +71,7 @@ config ARM64
> >   	select ARCH_USE_QUEUED_RWLOCKS
> >   	select ARCH_USE_QUEUED_SPINLOCKS
> >   	select ARCH_USE_SYM_ANNOTATIONS
> > +	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
> >   	select ARCH_SUPPORTS_MEMORY_FAILURE
> >   	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
> >   	select ARCH_SUPPORTS_ATOMIC_RMW
> > @@ -1025,9 +1026,6 @@ config HOLES_IN_ZONE
> >   source "kernel/Kconfig.hz"
> > -config ARCH_SUPPORTS_DEBUG_PAGEALLOC
> > -	def_bool y
> > -
> >   config ARCH_SPARSEMEM_ENABLE
> >   	def_bool y
> >   	select SPARSEMEM_VMEMMAP_ENABLE
> > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > index 1b94f5b82654..439325532be1 100644
> > --- a/arch/arm64/mm/pageattr.c
> > +++ b/arch/arm64/mm/pageattr.c
> > @@ -155,7 +155,7 @@ int set_direct_map_invalid_noflush(struct page *page)
> >   		.clear_mask = __pgprot(PTE_VALID),
> >   	};
> > -	if (!rodata_full)
> > +	if (!debug_pagealloc_enabled() && !rodata_full)
> >   		return 0;
> >   	return apply_to_page_range(&init_mm,
> > @@ -170,7 +170,7 @@ int set_direct_map_default_noflush(struct page *page)
> >   		.clear_mask = __pgprot(PTE_RDONLY),
> >   	};
> > -	if (!rodata_full)
> > +	if (!debug_pagealloc_enabled() && !rodata_full)
> >   		return 0;
> >   	return apply_to_page_range(&init_mm,
> 
> I don't understand these two hunks. Previous patch calls this for
> hibernation when CONFIG_ARCH_HAS_SET_DIRECT_MAP, which is true for arm64.
> Why suddenly this starts to depend on debug_pagealloc_enabled()?

I was confused about this for quite a long :)

On arm64 the changes to direct^w linear map are allowed when 

	debug_page_alloc() || rodata_full

In hibernation we essentially have now

	if (1)
		set_direct_map(something)
	else
		debug_page_alloc_map()

With debug_pagealloc enabled but with rodata_full disabled arm64
versions of set_direct_map_*() will become a nop, so a page that was
unmapped by debug_pagealloc() will not be mapped back.

I'm still puzzled how hibernation might ever need to save a free page,
but that's another story.

-- 
Sincerely yours,
Mike.
