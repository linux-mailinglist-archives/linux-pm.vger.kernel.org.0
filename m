Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318AC2A2DD1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 16:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgKBPNL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 10:13:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgKBPNL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Nov 2020 10:13:11 -0500
Received: from kernel.org (unknown [87.71.17.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C3A22258;
        Mon,  2 Nov 2020 15:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604329990;
        bh=pQm13rJ0TtLsoFHOZA52H/TzTWUyG6xri7XGlle4HPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U5iA6iZ+4RrbBTruBVP23DAtPFm6+kceLiKQw3J0W+zg1uOK+4S4JJxuhMMUqU1YR
         AbaxuhUr3wcVgMFL7UiNf9Rgt38tsM1oxGu8FMS5KMZthwA6c6ykTjZZtEvaQ3kHdo
         qOQc20cDKQCRHjZYM2XM4fU6aSAxgj4DgVoNXSRU=
Date:   Mon, 2 Nov 2020 17:12:56 +0200
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
        x86@kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v3 2/4] PM: hibernate: make direct map manipulations more
 explicit
Message-ID: <20201102151256.GA4879@kernel.org>
References: <20201101170815.9795-1-rppt@kernel.org>
 <20201101170815.9795-3-rppt@kernel.org>
 <55cd2a4a-cfa8-d420-66b3-a25fcdd9b876@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55cd2a4a-cfa8-d420-66b3-a25fcdd9b876@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 02, 2020 at 10:19:36AM +0100, David Hildenbrand wrote:
> On 01.11.20 18:08, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > When DEBUG_PAGEALLOC or ARCH_HAS_SET_DIRECT_MAP is enabled a page may be
> > not present in the direct map and has to be explicitly mapped before it
> > could be copied.
> > 
> > Introduce hibernate_map_page() that will explicitly use
> > set_direct_map_{default,invalid}_noflush() for ARCH_HAS_SET_DIRECT_MAP case
> > and debug_pagealloc_map_pages() for DEBUG_PAGEALLOC case.
> > 
> > The remapping of the pages in safe_copy_page() presumes that it only
> > changes protection bits in an existing PTE and so it is safe to ignore
> > return value of set_direct_map_{default,invalid}_noflush().
> > 
> > Still, add a WARN_ON() so that future changes in set_memory APIs will not
> > silently break hibernation.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   include/linux/mm.h      | 12 ------------
> >   kernel/power/snapshot.c | 30 ++++++++++++++++++++++++++++--
> >   2 files changed, 28 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 1fc0609056dc..14e397f3752c 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2927,16 +2927,6 @@ static inline bool debug_pagealloc_enabled_static(void)
> >   #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
> >   extern void __kernel_map_pages(struct page *page, int numpages, int enable);
> > -/*
> > - * When called in DEBUG_PAGEALLOC context, the call should most likely be
> > - * guarded by debug_pagealloc_enabled() or debug_pagealloc_enabled_static()
> > - */
> > -static inline void
> > -kernel_map_pages(struct page *page, int numpages, int enable)
> > -{
> > -	__kernel_map_pages(page, numpages, enable);
> > -}
> > -
> >   static inline void debug_pagealloc_map_pages(struct page *page,
> >   					     int numpages, int enable)
> >   {
> > @@ -2948,8 +2938,6 @@ static inline void debug_pagealloc_map_pages(struct page *page,
> >   extern bool kernel_page_present(struct page *page);
> >   #endif	/* CONFIG_HIBERNATION */
> >   #else	/* CONFIG_DEBUG_PAGEALLOC || CONFIG_ARCH_HAS_SET_DIRECT_MAP */
> > -static inline void
> > -kernel_map_pages(struct page *page, int numpages, int enable) {}
> >   static inline void debug_pagealloc_map_pages(struct page *page,
> >   					     int numpages, int enable) {}
> >   #ifdef CONFIG_HIBERNATION
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index 46b1804c1ddf..054c8cce4236 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -76,6 +76,32 @@ static inline void hibernate_restore_protect_page(void *page_address) {}
> >   static inline void hibernate_restore_unprotect_page(void *page_address) {}
> >   #endif /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
> > +static inline void hibernate_map_page(struct page *page, int enable)
> > +{
> > +	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
> > +		unsigned long addr = (unsigned long)page_address(page);
> > +		int ret;
> > +
> > +		/*
> > +		 * This should not fail because remapping a page here means
> > +		 * that we only update protection bits in an existing PTE.
> > +		 * It is still worth to have WARN_ON() here if something
> > +		 * changes and this will no longer be the case.
> > +		 */
> > +		if (enable)
> > +			ret = set_direct_map_default_noflush(page);
> > +		else
> > +			ret = set_direct_map_invalid_noflush(page);
> > +
> > +		if (WARN_ON(ret))
> > +			return;
> 
> People seem to prefer pr_warn() now that production kernels have panic on
> warn enabled. It's weird.

Weird indeed as the whole point of WARN to yell without causing a
crash...
I can change to pr_warn though...

> > +
> > +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > +	} else {
> > +		debug_pagealloc_map_pages(page, 1, enable);
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
