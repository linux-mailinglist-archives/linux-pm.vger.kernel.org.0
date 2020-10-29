Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D1529E547
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 08:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbgJ2Hz4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 03:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731531AbgJ2Hyb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Oct 2020 03:54:31 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3F1620EDD;
        Thu, 29 Oct 2020 07:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603958070;
        bh=5V9raRTAO8xn/TWxASurP3gs711BOhAaxxP12fBIpug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=smkJOo6ejvJldTmaaqqEFjGX6LWRb76WicHCvCBcrN9qOMMNByoTCZCyPYd8JouA6
         FsHRDDeFim9xIzvbeq0FyT0w7eXPAkBTo6qZkKSqULTgH8mtDPy6sKAI1NlM6RXbk0
         gkAxCVUoVSgKd/P/vRphpHr37cKvq2I6Usohfbtc=
Date:   Thu, 29 Oct 2020 09:54:16 +0200
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
        "penberg@kernel.org" <penberg@kernel.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will@kernel.org" <will@kernel.org>,
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
Message-ID: <20201029075416.GJ1428094@kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <20201025101555.3057-3-rppt@kernel.org>
 <3b4b2b3559bd3dc68adcddf99415bae57152cb6b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b4b2b3559bd3dc68adcddf99415bae57152cb6b.camel@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 28, 2020 at 09:15:38PM +0000, Edgecombe, Rick P wrote:
> On Sun, 2020-10-25 at 12:15 +0200, Mike Rapoport wrote:
> > +       if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
> > +               unsigned long addr = (unsigned
> > long)page_address(page);
> > +               int ret;
> > +
> > +               if (enable)
> > +                       ret = set_direct_map_default_noflush(page);
> > +               else
> > +                       ret = set_direct_map_invalid_noflush(page);
> > +
> > +               if (WARN_ON(ret))
> > +                       return;
> > +
> > +               flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > +       } else {
> > +               debug_pagealloc_map_pages(page, 1, enable);
> > +       }
> 
> Looking at the arm side again, I think this might actually introduce a
> regression for the arm/hibernate/DEBUG_PAGEALLOC combo.
> 
> Unlike __kernel_map_pages(), it looks like arm's cpa will always bail
> in the set_direct_map_() functions if rodata_full is false.
>
> So if rodata_full was disabled but debug page alloc is on, then this
> would now skip remapping the pages. I guess the significance depends
> on whether hibernate could actually try to save any DEBUG_PAGEALLOC
> unmapped pages. Looks like it to me though.
 
__kernel_map_pages() on arm64 will also bail out if rodata_full is
false:

void __kernel_map_pages(struct page *page, int numpages, int enable)
{
	if (!debug_pagealloc_enabled() && !rodata_full)
		return;

	set_memory_valid((unsigned long)page_address(page), numpages, enable);
}

So using set_direct_map() to map back pages removed from the direct map
with __kernel_map_pages() seems safe to me.

-- 
Sincerely yours,
Mike.
