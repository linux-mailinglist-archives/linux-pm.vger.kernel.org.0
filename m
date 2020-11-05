Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C55C2A7D12
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 12:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgKELdp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 06:33:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:53756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730015AbgKELcR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 06:32:17 -0500
Received: from kernel.org (unknown [2.55.183.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CBFE2078E;
        Thu,  5 Nov 2020 11:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604575935;
        bh=Bddnym2ScSgZW0MXOH6ivSBDQPosBdmDCn8iejOUWN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lV6UuMgvF8R3zfaurE9MkrC6I4RRQ2ehwYW+6ca/MvBFcAHxNY9cvsP6pB/VOgFkz
         490HRfm8GhZ2lwAZWCnAZGiXP7hhSKrUfsMb0TcYfEijy+kbMpqnBowIlTt59yIWhQ
         v06Jxbw6wvDvaklmn4EOV9uG879gJBciLf4YrWYo=
Date:   Thu, 5 Nov 2020 13:31:54 +0200
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
Subject: Re: [PATCH v4 1/4] mm: introduce debug_pagealloc_map_pages() helper
Message-ID: <20201105113154.GX4879@kernel.org>
References: <20201103162057.22916-1-rppt@kernel.org>
 <20201103162057.22916-2-rppt@kernel.org>
 <971e9638-2395-daf4-d19e-fe3cf5d34b98@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971e9638-2395-daf4-d19e-fe3cf5d34b98@suse.cz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 06:35:50PM +0100, Vlastimil Babka wrote:
> On 11/3/20 5:20 PM, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > When CONFIG_DEBUG_PAGEALLOC is enabled, it unmaps pages from the kernel
> > direct mapping after free_pages(). The pages than need to be mapped back
> > before they could be used. Theese mapping operations use
> > __kernel_map_pages() guarded with with debug_pagealloc_enabled().
> > 
> > The only place that calls __kernel_map_pages() without checking whether
> > DEBUG_PAGEALLOC is enabled is the hibernation code that presumes
> > availability of this function when ARCH_HAS_SET_DIRECT_MAP is set.
> > Still, on arm64, __kernel_map_pages() will bail out when DEBUG_PAGEALLOC is
> > not enabled but set_direct_map_invalid_noflush() may render some pages not
> > present in the direct map and hibernation code won't be able to save such
> > pages.
> > 
> > To make page allocation debugging and hibernation interaction more robust,
> > the dependency on DEBUG_PAGEALLOC or ARCH_HAS_SET_DIRECT_MAP has to be made
> > more explicit.
> > 
> > Start with combining the guard condition and the call to
> > __kernel_map_pages() into a single debug_pagealloc_map_pages() function to
> > emphasize that __kernel_map_pages() should not be called without
> > DEBUG_PAGEALLOC and use this new function to map/unmap pages when page
> > allocation debug is enabled.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> But, the "enable" param is hideous. I would rather have map and unmap
> variants (and just did the same split for page poisoning) and this seems to
> be a good opportunity. If David didn't propose it already, I'm surprised ;)

I'm ok with map and unmap, and no, David didn't propose it already :)

> > ---
> >   include/linux/mm.h  | 10 ++++++++++
> >   mm/memory_hotplug.c |  3 +--
> >   mm/page_alloc.c     |  6 ++----
> >   mm/slab.c           |  8 +++-----
> >   4 files changed, 16 insertions(+), 11 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index ef360fe70aaf..1fc0609056dc 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2936,12 +2936,22 @@ kernel_map_pages(struct page *page, int numpages, int enable)
> >   {
> >   	__kernel_map_pages(page, numpages, enable);
> >   }
> > +
> > +static inline void debug_pagealloc_map_pages(struct page *page,
> > +					     int numpages, int enable)
> > +{
> > +	if (debug_pagealloc_enabled_static())
> > +		__kernel_map_pages(page, numpages, enable);
> > +}
> > +
> >   #ifdef CONFIG_HIBERNATION
> >   extern bool kernel_page_present(struct page *page);
> >   #endif	/* CONFIG_HIBERNATION */
> >   #else	/* CONFIG_DEBUG_PAGEALLOC || CONFIG_ARCH_HAS_SET_DIRECT_MAP */
> >   static inline void
> >   kernel_map_pages(struct page *page, int numpages, int enable) {}
> > +static inline void debug_pagealloc_map_pages(struct page *page,
> > +					     int numpages, int enable) {}
> >   #ifdef CONFIG_HIBERNATION
> >   static inline bool kernel_page_present(struct page *page) { return true; }
> >   #endif	/* CONFIG_HIBERNATION */
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index b44d4c7ba73b..e2b6043a4428 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -614,8 +614,7 @@ void generic_online_page(struct page *page, unsigned int order)
> >   	 * so we should map it first. This is better than introducing a special
> >   	 * case in page freeing fast path.
> >   	 */
> > -	if (debug_pagealloc_enabled_static())
> > -		kernel_map_pages(page, 1 << order, 1);
> > +	debug_pagealloc_map_pages(page, 1 << order, 1);
> >   	__free_pages_core(page, order);
> >   	totalram_pages_add(1UL << order);
> >   #ifdef CONFIG_HIGHMEM
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 23f5066bd4a5..9a66a1ff9193 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1272,8 +1272,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
> >   	 */
> >   	arch_free_page(page, order);
> > -	if (debug_pagealloc_enabled_static())
> > -		kernel_map_pages(page, 1 << order, 0);
> > +	debug_pagealloc_map_pages(page, 1 << order, 0);
> >   	kasan_free_nondeferred_pages(page, order);
> > @@ -2270,8 +2269,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
> >   	set_page_refcounted(page);
> >   	arch_alloc_page(page, order);
> > -	if (debug_pagealloc_enabled_static())
> > -		kernel_map_pages(page, 1 << order, 1);
> > +	debug_pagealloc_map_pages(page, 1 << order, 1);
> >   	kasan_alloc_pages(page, order);
> >   	kernel_poison_pages(page, 1 << order, 1);
> >   	set_page_owner(page, order, gfp_flags);
> > diff --git a/mm/slab.c b/mm/slab.c
> > index b1113561b98b..340db0ce74c4 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -1431,10 +1431,8 @@ static bool is_debug_pagealloc_cache(struct kmem_cache *cachep)
> >   #ifdef CONFIG_DEBUG_PAGEALLOC
> >   static void slab_kernel_map(struct kmem_cache *cachep, void *objp, int map)
> >   {
> > -	if (!is_debug_pagealloc_cache(cachep))
> > -		return;
> > -
> > -	kernel_map_pages(virt_to_page(objp), cachep->size / PAGE_SIZE, map);
> > +	debug_pagealloc_map_pages(virt_to_page(objp),
> > +				  cachep->size / PAGE_SIZE, map);
> >   }
> >   #else
> > @@ -2062,7 +2060,7 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
> >   #if DEBUG
> >   	/*
> > -	 * If we're going to use the generic kernel_map_pages()
> > +	 * If we're going to use the generic debug_pagealloc_map_pages()
> >   	 * poisoning, then it's going to smash the contents of
> >   	 * the redzone and userword anyhow, so switch them off.
> >   	 */
> > 
> 

-- 
Sincerely yours,
Mike.
