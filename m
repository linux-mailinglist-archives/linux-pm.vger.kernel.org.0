Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66052ABEF1
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 15:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbgKIOmC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 09:42:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729454AbgKIOmC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Nov 2020 09:42:02 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D215206E3;
        Mon,  9 Nov 2020 14:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604932922;
        bh=XyH/OGSoZtwKFi7Dr6r4PbxrZ95WCPZt6ITMBGRDbT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AACidaKdvM9fjww+sp/aLxSmuCgmX5y5VInfhx0TIj5OjJteJpSMpOU9k+cy2ANao
         bPCbw8OTl+tQ2hkhXviYnObTrxDMTytkrEn70tTATzIjRMFL7twkjoJg60mbELrRtH
         jrhu4hO9i4CTCZoHNJYPLc9KZT9JgGfbJFGI+3OU=
Date:   Mon, 9 Nov 2020 16:41:48 +0200
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
Subject: Re: [PATCH v5 1/5] mm: introduce debug_pagealloc_{map,unmap}_pages()
 helpers
Message-ID: <20201109144148.GE301837@kernel.org>
References: <20201108065758.1815-1-rppt@kernel.org>
 <20201108065758.1815-2-rppt@kernel.org>
 <4bd5ae2b-4fc6-73dc-b83b-e71826990946@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bd5ae2b-4fc6-73dc-b83b-e71826990946@suse.cz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Nov 09, 2020 at 12:33:46PM +0100, Vlastimil Babka wrote:
> On 11/8/20 7:57 AM, Mike Rapoport wrote:
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -1428,21 +1428,19 @@ static bool is_debug_pagealloc_cache(struct kmem_cache *cachep)
> >   	return false;
> >   }
> > -#ifdef CONFIG_DEBUG_PAGEALLOC
> >   static void slab_kernel_map(struct kmem_cache *cachep, void *objp, int map)
> >   {
> >   	if (!is_debug_pagealloc_cache(cachep))
> >   		return;
> 
> Hmm, I didn't notice earlier, sorry.
> The is_debug_pagealloc_cache() above includes a
> debug_pagealloc_enabled_static() check, so it should be fine to use
> __kernel_map_pages() directly below. Otherwise we generate two static key
> checks for the same key needlessly.

Ok, I'll revert slab changes.

> > -	kernel_map_pages(virt_to_page(objp), cachep->size / PAGE_SIZE, map);
> > +	if (map)
> > +		debug_pagealloc_map_pages(virt_to_page(objp),
> > +					  cachep->size / PAGE_SIZE);
> > +	else
> > +		debug_pagealloc_unmap_pages(virt_to_page(objp),
> > +					    cachep->size / PAGE_SIZE);
> >   }
> > -#else
> > -static inline void slab_kernel_map(struct kmem_cache *cachep, void *objp,
> > -				int map) {}
> > -
> > -#endif
> > -
> >   static void poison_obj(struct kmem_cache *cachep, void *addr, unsigned char val)
> >   {
> >   	int size = cachep->object_size;
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
