Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8112E2AB72E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 12:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgKILdy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 06:33:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:54204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729891AbgKILdy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2BA62ABF4;
        Mon,  9 Nov 2020 11:33:51 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] mm: introduce debug_pagealloc_{map,unmap}_pages()
 helpers
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
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
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org
References: <20201108065758.1815-1-rppt@kernel.org>
 <20201108065758.1815-2-rppt@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4bd5ae2b-4fc6-73dc-b83b-e71826990946@suse.cz>
Date:   Mon, 9 Nov 2020 12:33:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201108065758.1815-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/8/20 7:57 AM, Mike Rapoport wrote:
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1428,21 +1428,19 @@ static bool is_debug_pagealloc_cache(struct kmem_cache *cachep)
>   	return false;
>   }
>   
> -#ifdef CONFIG_DEBUG_PAGEALLOC
>   static void slab_kernel_map(struct kmem_cache *cachep, void *objp, int map)
>   {
>   	if (!is_debug_pagealloc_cache(cachep))
>   		return;

Hmm, I didn't notice earlier, sorry.
The is_debug_pagealloc_cache() above includes a debug_pagealloc_enabled_static() 
check, so it should be fine to use
__kernel_map_pages() directly below. Otherwise we generate two static key checks 
for the same key needlessly.

>   
> -	kernel_map_pages(virt_to_page(objp), cachep->size / PAGE_SIZE, map);
> +	if (map)
> +		debug_pagealloc_map_pages(virt_to_page(objp),
> +					  cachep->size / PAGE_SIZE);
> +	else
> +		debug_pagealloc_unmap_pages(virt_to_page(objp),
> +					    cachep->size / PAGE_SIZE);
>   }
>   
> -#else
> -static inline void slab_kernel_map(struct kmem_cache *cachep, void *objp,
> -				int map) {}
> -
> -#endif
> -
>   static void poison_obj(struct kmem_cache *cachep, void *addr, unsigned char val)
>   {
>   	int size = cachep->object_size;
> @@ -2062,7 +2060,7 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
>   
>   #if DEBUG
>   	/*
> -	 * If we're going to use the generic kernel_map_pages()
> +	 * If we're going to use the generic debug_pagealloc_map_pages()
>   	 * poisoning, then it's going to smash the contents of
>   	 * the redzone and userword anyhow, so switch them off.
>   	 */
> 

