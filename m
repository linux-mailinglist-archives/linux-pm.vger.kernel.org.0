Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52272A1FCC
	for <lists+linux-pm@lfdr.de>; Sun,  1 Nov 2020 18:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKARCc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Nov 2020 12:02:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgKARCb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 1 Nov 2020 12:02:31 -0500
Received: from kernel.org (unknown [87.71.17.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 420992074F;
        Sun,  1 Nov 2020 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604250150;
        bh=HP+ZQ6Ps8oAsoYLOvWAk4ExSXyhayG0jX2yWoBMUttE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxsex5hsLdBiTg92b0MNJxCbBPD+lO6NtdRjasPNMfUBXD6k5B0KcdxvFVYiQIEmX
         Bjfz+dfRQJnD6lyaCaBO97eSNhn6o7BX84zyBBhpcPltXScqdjcB1tCqstPvndRKPK
         MacevoYxMeN6oYR+VtqyVfF6MF53cPKygLmGPOBs=
Date:   Sun, 1 Nov 2020 19:02:17 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "david@redhat.com" <david@redhat.com>,
        "cl@linux.com" <cl@linux.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "will@kernel.org" <will@kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "rientjes@google.com" <rientjes@google.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "bp@alien8.de" <bp@alien8.de>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
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
Message-ID: <20201101170217.GD14628@kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <20201025101555.3057-3-rppt@kernel.org>
 <3b4b2b3559bd3dc68adcddf99415bae57152cb6b.camel@intel.com>
 <20201029075416.GJ1428094@kernel.org>
 <604554805defb03d158c09aba4b5cced3416a7fb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <604554805defb03d158c09aba4b5cced3416a7fb.camel@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 29, 2020 at 11:19:18PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2020-10-29 at 09:54 +0200, Mike Rapoport wrote:
> > __kernel_map_pages() on arm64 will also bail out if rodata_full is
> > false:
> > void __kernel_map_pages(struct page *page, int numpages, int enable)
> > {
> >         if (!debug_pagealloc_enabled() && !rodata_full)
> >                 return;
> > 
> >         set_memory_valid((unsigned long)page_address(page), numpages,
> > enable);
> > }
> > 
> > So using set_direct_map() to map back pages removed from the direct
> > map
> > with __kernel_map_pages() seems safe to me.
> 
> Heh, one of us must have some simple boolean error in our head. I hope
> its not me! :) I'll try on more time.

Well, then it's me :)
You are right, I misread this and I could not understand why
!rodata_full bothers you.

> __kernel_map_pages() will bail out if rodata_full is false **AND**
> debug page alloc is off. So it will only bail under conditions where
> there could be nothing unmapped on the direct map.
> 
> Equivalent logic would be:
> 	if (!(debug_pagealloc_enabled() || rodata_full))
> 		return;
> 
> Or:
> 	if (debug_pagealloc_enabled() || rodata_full)
> 		set_memory_valid(blah)
> 
> So if either is on, the existing code will try to re-map. But the
> set_direct_map_()'s will only work if rodata_full is on. So switching
> hibernate to set_direct_map() will cause the remap to be missed for the
> debug page alloc case, with !rodata_full.
> 
> It also breaks normal debug page alloc usage with !rodata_full for
> similar reasons after patch 3. The pages would never get unmapped.

I've updated the patches, there should be no regression now.

-- 
Sincerely yours,
Mike.
