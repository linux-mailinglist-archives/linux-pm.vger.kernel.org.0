Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673F629894F
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 10:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768795AbgJZJQN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 05:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730488AbgJZJQM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Oct 2020 05:16:12 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98A52076D;
        Mon, 26 Oct 2020 09:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603703772;
        bh=pop+GQ7xmiCTdiMy7B7WjKex9h5Ro/VhE9OJ7tV4F50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcsGfbDXA790Gjo2jSURCFd11bM6efKFvKFsUWyXN44//16ZrE/paF3TuAJVQB4Rr
         mz78GEiiRdCUDL2DmSZQKmV3QOTV3troBBj6WAvp8CVBS8VJ7TSHYavrFKSKMBbgmb
         ZMwdKEfod10n2z6aUqC33jSQaZUMycRaW8U5Xg+0=
Date:   Mon, 26 Oct 2020 11:15:54 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "david@redhat.com" <david@redhat.com>,
        "cl@linux.com" <cl@linux.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "will@kernel.org" <will@kernel.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "rientjes@google.com" <rientjes@google.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "luto@kernel.org" <luto@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "Brown, Len" <len.brown@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: Re: [PATCH 2/4] PM: hibernate: improve robustness of mapping pages
 in the direct map
Message-ID: <20201026091554.GB1154158@kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <20201025101555.3057-3-rppt@kernel.org>
 <f20900a403bea9eb3f0814128e5ea46f6580f5a5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f20900a403bea9eb3f0814128e5ea46f6580f5a5.camel@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 12:38:32AM +0000, Edgecombe, Rick P wrote:
> On Sun, 2020-10-25 at 12:15 +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > When DEBUG_PAGEALLOC or ARCH_HAS_SET_DIRECT_MAP is enabled a page may
> > be
> > not present in the direct map and has to be explicitly mapped before
> > it
> > could be copied.
> > 
> > On arm64 it is possible that a page would be removed from the direct
> > map
> > using set_direct_map_invalid_noflush() but __kernel_map_pages() will
> > refuse
> > to map this page back if DEBUG_PAGEALLOC is disabled.
> 
> It looks to me that arm64 __kernel_map_pages() will still attempt to
> map it if rodata_full is true, how does this happen?

Unless I misread the code, arm64 requires both rodata_full and
debug_pagealloc_enabled() to be true for __kernel_map_pages() to do
anything.
But rodata_full condition applies to set_direct_map_*_noflush() as well,
so with !rodata_full the linear map won't be ever changed.

> > Explicitly use set_direct_map_{default,invalid}_noflush() for
> > ARCH_HAS_SET_DIRECT_MAP case and debug_pagealloc_map_pages() for
> > DEBUG_PAGEALLOC case.
> > 
> > While on that, rename kernel_map_pages() to hibernate_map_page() and
> > drop
> > numpages parameter.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  kernel/power/snapshot.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> > 
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index fa499466f645..ecb7b32ce77c 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -76,16 +76,25 @@ static inline void
> > hibernate_restore_protect_page(void *page_address) {}
> >  static inline void hibernate_restore_unprotect_page(void
> > *page_address) {}
> >  #endif /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
> >  
> > -#if defined(CONFIG_DEBUG_PAGEALLOC) ||
> > defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
> > -static inline void
> > -kernel_map_pages(struct page *page, int numpages, int enable)
> > +static inline void hibernate_map_page(struct page *page, int enable)
> >  {
> > -	__kernel_map_pages(page, numpages, enable);
> > +	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
> > +		unsigned long addr = (unsigned long)page_address(page);
> > +		int ret;
> > +
> > +		if (enable)
> > +			ret = set_direct_map_default_noflush(page);
> > +		else
> > +			ret = set_direct_map_invalid_noflush(page);
> > +
> > +		if (WARN_ON(ret))
> > +			return;
> > +
> > +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > +	} else {
> > +		debug_pagealloc_map_pages(page, 1, enable);
> > +	}
> >  }
> > -#else
> > -static inline void
> > -kernel_map_pages(struct page *page, int numpages, int enable) {}
> > -#endif
> >  
> >  static int swsusp_page_is_free(struct page *);
> >  static void swsusp_set_page_forbidden(struct page *);
> > @@ -1366,9 +1375,9 @@ static void safe_copy_page(void *dst, struct
> > page *s_page)
> >  	if (kernel_page_present(s_page)) {
> >  		do_copy_page(dst, page_address(s_page));
> >  	} else {
> > -		kernel_map_pages(s_page, 1, 1);
> > +		hibernate_map_page(s_page, 1);
> >  		do_copy_page(dst, page_address(s_page));
> > -		kernel_map_pages(s_page, 1, 0);
> > +		hibernate_map_page(s_page, 0);
> >  	}
> >  }
> >  
> 
> If somehow a page was unmapped such that
> set_direct_map_default_noflush() would fail, then this code introduces
> a WARN, but it will still try to read the unmapped page. Why not just
> have the WARN's inside of __kernel_map_pages() if they fail and then
> have a warning for the debug page alloc cases as well? Since logic
> around both expects them not to fail.

The intention of this series is to disallow usage of
__kernel_map_pages() when DEBUG_PAGEALLOC=n. I'll update this patch to
better handle possible errors, but I still want to keep WARN in the
caller.

-- 
Sincerely yours,
Mike.
