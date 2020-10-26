Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6706B298C64
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 12:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774130AbgJZLy7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 07:54:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441155AbgJZLy6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Oct 2020 07:54:58 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5891822265;
        Mon, 26 Oct 2020 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603713297;
        bh=JL5L+tjAdTtgTIzF1IyLb8dhJjCHzTjL2OJ0c6FU4w4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=beAfxtxVzIWG7/PQSB9oT8HrWkddsR0PDdaGNijlEC3AuMvcZUXxJY9R8puB77jj0
         rPlZw+P1uGuAIqPmVzWmAkw1wLYd5tKrK+EpdZCOH48DMhCjDSmOkzAPgP4u1ZC3/i
         Sc+DoqTEeolhEbCvCJLclcbZXLgz0JV5qw710moE=
Date:   Mon, 26 Oct 2020 13:54:43 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
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
Subject: Re: [PATCH 1/4] mm: introduce debug_pagealloc_map_pages() helper
Message-ID: <20201026115443.GF1154158@kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <20201025101555.3057-2-rppt@kernel.org>
 <8720c067-7dc5-2b02-918b-e54dd642bfd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8720c067-7dc5-2b02-918b-e54dd642bfd6@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 12:05:13PM +0100, David Hildenbrand wrote:
> On 25.10.20 11:15, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > When CONFIG_DEBUG_PAGEALLOC is enabled, it unmaps pages from the
> > kernel direct mapping after free_pages(). The pages than need to be
> > mapped back before they could be used. Theese mapping operations use 
> > __kernel_map_pages() guarded with with debug_pagealloc_enabled().
> > 
> > The only place that calls __kernel_map_pages() without checking
> > whether DEBUG_PAGEALLOC is enabled is the hibernation code that
> > presumes availability of this function when ARCH_HAS_SET_DIRECT_MAP
> > is set. Still, on arm64, __kernel_map_pages() will bail out when
> > DEBUG_PAGEALLOC is not enabled but set_direct_map_invalid_noflush()
> > may render some pages not present in the direct map and hibernation
> > code won't be able to save such pages.
> > 
> > To make page allocation debugging and hibernation interaction more
> > robust, the dependency on DEBUG_PAGEALLOC or ARCH_HAS_SET_DIRECT_MAP
> > has to be made more explicit.
> > 
> > Start with combining the guard condition and the call to 
> > __kernel_map_pages() into a single debug_pagealloc_map_pages()
> > function to emphasize that __kernel_map_pages() should not be called
> > without DEBUG_PAGEALLOC and use this new function to map/unmap pages
> > when page allocation debug is enabled.
> > 
> > As the only remaining user of kernel_map_pages() is the hibernation
> > code, mode that function into kernel/power/snapshot.c closer to a
> > caller.
> 
> s/mode/move/
> 
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com> --- 
> > include/linux/mm.h      | 16 +++++++--------- kernel/power/snapshot.c
> > | 11 +++++++++++ mm/memory_hotplug.c     |  3 +-- mm/page_alloc.c
> > |  6 ++---- mm/slab.c               |  8 +++----- 5 files changed, 24
> > insertions(+), 20 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h index
> > ef360fe70aaf..14e397f3752c 100644 --- a/include/linux/mm.h +++
> > b/include/linux/mm.h @@ -2927,21 +2927,19 @@ static inline bool
> > debug_pagealloc_enabled_static(void) #if
> > defined(CONFIG_DEBUG_PAGEALLOC) ||
> > defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP) extern void
> > __kernel_map_pages(struct page *page, int numpages, int enable);
> > 
> > -/* - * When called in DEBUG_PAGEALLOC context, the call should most
> > likely be - * guarded by debug_pagealloc_enabled() or
> > debug_pagealloc_enabled_static() - */ -static inline void 
> > -kernel_map_pages(struct page *page, int numpages, int enable) 
> > +static inline void debug_pagealloc_map_pages(struct page *page, +
> > int numpages, int enable) { -	__kernel_map_pages(page, numpages,
> > enable); +	if (debug_pagealloc_enabled_static()) +
> > __kernel_map_pages(page, numpages, enable); } + #ifdef
> > CONFIG_HIBERNATION extern bool kernel_page_present(struct page
> > *page); #endif	/* CONFIG_HIBERNATION */ #else	/*
> > CONFIG_DEBUG_PAGEALLOC || CONFIG_ARCH_HAS_SET_DIRECT_MAP */ -static
> > inline void -kernel_map_pages(struct page *page, int numpages, int
> > enable) {} +static inline void debug_pagealloc_map_pages(struct page
> > *page, +					     int numpages, int enable) {} #ifdef
> > CONFIG_HIBERNATION static inline bool kernel_page_present(struct page
> > *page) { return true; } #endif	/* CONFIG_HIBERNATION */ diff --git
> > a/kernel/power/snapshot.c b/kernel/power/snapshot.c index
> > 46b1804c1ddf..fa499466f645 100644 --- a/kernel/power/snapshot.c +++
> > b/kernel/power/snapshot.c @@ -76,6 +76,17 @@ static inline void
> > hibernate_restore_protect_page(void *page_address) {} static inline
> > void hibernate_restore_unprotect_page(void *page_address) {} #endif
> > /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
> > 
> > +#if defined(CONFIG_DEBUG_PAGEALLOC) ||
> > defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP) +static inline void 
> > +kernel_map_pages(struct page *page, int numpages, int enable) +{ +
> > __kernel_map_pages(page, numpages, enable); +} +#else +static inline
> > void +kernel_map_pages(struct page *page, int numpages, int enable)
> > {} +#endif +
> 
> That change should go into a separate patch.
 
Hmm, I beleive you refer to moving kernel_map_pages() to snapshot.c,
right?

> For the debug_pagealloc_map_pages() parts
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
 
Thanks!

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
