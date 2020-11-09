Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EEA2AC13E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 17:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgKIQsH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 11:48:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730419AbgKIQsH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Nov 2020 11:48:07 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C3EA2074F;
        Mon,  9 Nov 2020 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604940486;
        bh=6rn/Is9/mb71Cx8T5OixcswhdKR8Yw8hRoo0YqfjdsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2PklhGFO1GSLbrkd4w7eR0OQVXIC9bB/NRFuu0yXJ2cad3g2XWFGm5qY1CfZsxWEJ
         hIEGvV7DG50YSNEMxKxpw57WvEfw0aU7JllVonG+2csYY0gr4DIxzUIPf5drKxbhRb
         AQb1wGfM13MfcFzy1XYj4m6UEF/itQaci+zuEFqA=
Date:   Mon, 9 Nov 2020 18:47:52 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v6 0/4] arch, mm: improve robustness of direct map
 manipulation
Message-ID: <20201109164752.GF301837@kernel.org>
References: <20201109162415.13764-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109162415.13764-1-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Oops, this one has some rebase errors, I'll send v7 soon.
Sorry for the noise.

On Mon, Nov 09, 2020 at 06:24:11PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> During recent discussion about KVM protected memory, David raised a concern
> about usage of __kernel_map_pages() outside of DEBUG_PAGEALLOC scope [1].
> 
> Indeed, for architectures that define CONFIG_ARCH_HAS_SET_DIRECT_MAP it is
> possible that __kernel_map_pages() would fail, but since this function is
> void, the failure will go unnoticed.
> 
> Moreover, there's lack of consistency of __kernel_map_pages() semantics
> across architectures as some guard this function with
> #ifdef DEBUG_PAGEALLOC, some refuse to update the direct map if page
> allocation debugging is disabled at run time and some allow modifying the
> direct map regardless of DEBUG_PAGEALLOC settings.
> 
> This set straightens this out by restoring dependency of
> __kernel_map_pages() on DEBUG_PAGEALLOC and updating the call sites
> accordingly. 
> 
> Since currently the only user of __kernel_map_pages() outside
> DEBUG_PAGEALLOC is hibernation, it is updated to make direct map accesses
> there more explicit.
> 
> [1] https://lore.kernel.org/lkml/2759b4bf-e1e3-d006-7d86-78a40348269d@redhat.com
> 
> v6 changes:
> * revert slab changes to avoid redundant check of static key
> 
> v5 changes:
> * use pairs of _map()/_unmap() functions instead of _map(..., int enable) as
>   Vlastimil suggested
> https://lore.kernel.org/lkml/20201108065758.1815-1-rppt@kernel.org
> 
> v4 changes:
> * s/WARN_ON/pr_warn_once/ per David and Kirill
> * rebase on v5.10-rc2
> * add Acked/Reviewed tags
> https://lore.kernel.org/lkml/20201103162057.22916-1-rppt@kernel.org
> 
> v3 changes:
> * update arm64 changes to avoid regression, per Rick's comments
> * fix bisectability
> https://lore.kernel.org/lkml/20201101170815.9795-1-rppt@kernel.org
> 
> v2 changes:
> * Rephrase patch 2 changelog to better describe the change intentions and
> implications
> * Move removal of kernel_map_pages() from patch 1 to patch 2, per David
> https://lore.kernel.org/lkml/20201029161902.19272-1-rppt@kernel.org
> 
> v1:
> https://lore.kernel.org/lkml/20201025101555.3057-1-rppt@kernel.org
> 
> Mike Rapoport (4):
>   mm: introduce debug_pagealloc_{map,unmap}_pages() helpers
>   PM: hibernate: make direct map manipulations more explicit
>   arch, mm: restore dependency of __kernel_map_pages() on DEBUG_PAGEALLOC
>   arch, mm: make kernel_page_present() always available
> 
>  arch/Kconfig                        |  3 +++
>  arch/arm64/Kconfig                  |  4 +--
>  arch/arm64/include/asm/cacheflush.h |  1 +
>  arch/arm64/mm/pageattr.c            |  6 +++--
>  arch/powerpc/Kconfig                |  5 +---
>  arch/riscv/Kconfig                  |  4 +--
>  arch/riscv/include/asm/pgtable.h    |  2 --
>  arch/riscv/include/asm/set_memory.h |  1 +
>  arch/riscv/mm/pageattr.c            | 31 ++++++++++++++++++++++
>  arch/s390/Kconfig                   |  4 +--
>  arch/sparc/Kconfig                  |  4 +--
>  arch/x86/Kconfig                    |  4 +--
>  arch/x86/include/asm/set_memory.h   |  1 +
>  arch/x86/mm/pat/set_memory.c        |  4 +--
>  include/linux/mm.h                  | 40 ++++++++++++++---------------
>  include/linux/set_memory.h          |  5 ++++
>  kernel/power/snapshot.c             | 38 +++++++++++++++++++++++++--
>  mm/memory_hotplug.c                 |  3 +--
>  mm/page_alloc.c                     |  6 ++---
>  19 files changed, 113 insertions(+), 53 deletions(-)
> 
> -- 
> 2.28.0
> 

-- 
Sincerely yours,
Mike.
