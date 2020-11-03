Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131972A44DB
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 13:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgKCMOG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 07:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:37128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbgKCMOF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 07:14:05 -0500
Received: from kernel.org (unknown [87.71.17.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A5E021D40;
        Tue,  3 Nov 2020 12:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604405644;
        bh=rLf9yomATEx+srpgZeJ+KGPkFKfQ91E1jTn5i//k+v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g6hnGexdu0W8O3pdlTR5aEzs0r2kP0xaYSrsTT9GezuIkJBm3EQGnE9HC9/i0y14W
         KQUMLf4/1ekMps9SlVeB61DMUq0iGCpQKrc0qBQk9l3Egw36MfVD4m724myMj1mv1P
         DJcwnqhwNdB7eOcGdB3ofp3gW4GGQabL04rnh6Gk=
Date:   Tue, 3 Nov 2020 14:13:50 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
Message-ID: <20201103121350.GI4879@kernel.org>
References: <20201101170815.9795-1-rppt@kernel.org>
 <20201101170815.9795-3-rppt@kernel.org>
 <20201103110816.t6a3ebtgcm7mfogy@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103110816.t6a3ebtgcm7mfogy@box>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 03, 2020 at 02:08:16PM +0300, Kirill A. Shutemov wrote:
> On Sun, Nov 01, 2020 at 07:08:13PM +0200, Mike Rapoport wrote:
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > index 46b1804c1ddf..054c8cce4236 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -76,6 +76,32 @@ static inline void hibernate_restore_protect_page(void *page_address) {}
> >  static inline void hibernate_restore_unprotect_page(void *page_address) {}
> >  #endif /* CONFIG_STRICT_KERNEL_RWX  && CONFIG_ARCH_HAS_SET_MEMORY */
> >  
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
> 
> _ONCE?

I've changed it to pr_warn() after David said people enable panic on
warn in production kernels.

> > +			return;
> > +
> > +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > +	} else {
> > +		debug_pagealloc_map_pages(page, 1, enable);
> > +	}
> > +}
> > +
> >  static int swsusp_page_is_free(struct page *);
> >  static void swsusp_set_page_forbidden(struct page *);
> >  static void swsusp_unset_page_forbidden(struct page *);
> 
> -- 
>  Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
