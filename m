Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA5229A6E9
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 09:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509340AbgJ0ItT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 04:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509336AbgJ0ItR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 27 Oct 2020 04:49:17 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 817B6207DE;
        Tue, 27 Oct 2020 08:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603788557;
        bh=vqvHVfwUem4JOBq/WXsfNE79L5Iz5nEhnMlkJj2ElFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cob/039dcWnn8OjH5If0m1K0e5hz+wi7uaTqafHhMC0w6AKDJ7mof/L9QVAWjAi5m
         AzwVpAcX/G3bIeFGz/QZ6LDXFrWjC3A32wjsC/UaCx/T35y4jeNZtg1G5OqKcQamFp
         mFhuBk5Uhn3ItuoN/wmMtQFg0IPWtBPQaAK5nUZY=
Date:   Tue, 27 Oct 2020 10:49:02 +0200
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
Message-ID: <20201027084902.GH1154158@kernel.org>
References: <20201025101555.3057-1-rppt@kernel.org>
 <20201025101555.3057-3-rppt@kernel.org>
 <f20900a403bea9eb3f0814128e5ea46f6580f5a5.camel@intel.com>
 <20201026091554.GB1154158@kernel.org>
 <a28d8248057e7dc01716764da9edfd666722ff62.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28d8248057e7dc01716764da9edfd666722ff62.camel@intel.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 06:57:32PM +0000, Edgecombe, Rick P wrote:
> On Mon, 2020-10-26 at 11:15 +0200, Mike Rapoport wrote:
> > On Mon, Oct 26, 2020 at 12:38:32AM +0000, Edgecombe, Rick P wrote:
> > > On Sun, 2020-10-25 at 12:15 +0200, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > 
> > > > When DEBUG_PAGEALLOC or ARCH_HAS_SET_DIRECT_MAP is enabled a page
> > > > may
> > > > be
> > > > not present in the direct map and has to be explicitly mapped
> > > > before
> > > > it
> > > > could be copied.
> > > > 
> > > > On arm64 it is possible that a page would be removed from the
> > > > direct
> > > > map
> > > > using set_direct_map_invalid_noflush() but __kernel_map_pages()
> > > > will
> > > > refuse
> > > > to map this page back if DEBUG_PAGEALLOC is disabled.
> > > 
> > > It looks to me that arm64 __kernel_map_pages() will still attempt
> > > to
> > > map it if rodata_full is true, how does this happen?
> > 
> > Unless I misread the code, arm64 requires both rodata_full and
> > debug_pagealloc_enabled() to be true for __kernel_map_pages() to do
> > anything.
> > But rodata_full condition applies to set_direct_map_*_noflush() as
> > well,
> > so with !rodata_full the linear map won't be ever changed.
> 
> Hmm, looks to me that __kernel_map_pages() will only skip it if both
> debug pagealloc and rodata_full are false.
> 
> But now I'm wondering if maybe we could simplify things by just moving
> the hibernate unmapped page logic off of the direct map. On x86,
> text_poke() used to use this reserved fixmap pte thing that it could
> rely on to remap memory with. If hibernate had some separate pte for
> remapping like that, then we could not have any direct map restrictions
> caused by it/kernel_map_pages(), and it wouldn't have to worry about
> relying on anything else.

Well, there is map_kernel_range() that can be used by hibernation as
there is no requirement for particular virtual address, but that would
be quite costly if done for every page.

Maybe we can do somthing like

	if (kernel_page_present(s_page)) {
		do_copy_page(dst, page_address(s_page));
	} else {
		map_kernel_range_noflush(page_address(page), PAGE_SIZE,
					 PROT_READ, &page);
		do_copy_page(dst, page_address(s_page));
		unmap_kernel_range_noflush(page_address(page), PAGE_SIZE);
	}

But it seems that a prerequisite for changing the way a page is mapped
in safe_copy_page() would be to teach hibernation that a mapping here
may fail.

-- 
Sincerely yours,
Mike.
