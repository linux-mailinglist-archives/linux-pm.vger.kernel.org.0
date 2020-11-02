Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6502A26EB
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 10:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgKBJXn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 04:23:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728253AbgKBJXl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 04:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604309020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvzFTHWSHGEnWR6Ifj3GAv6gxH6+jHEcfGAXbqacOLM=;
        b=IG3PanUBjPioQMFY6/GzArSHeUQYDMALPjaiObG5V9L6Rp+nn3SIqB6YtDVks0tRjzn/hk
        jC3Kbri0cyYiQSZhXMuwqtF5c/4HUTLMB4e2lfQJQuuhmE1DNYLjZShI78glm6ckAVqvTy
        4P4lClkQPR1T49/6OEh/6eUvzscOF4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-4rIlLjXWNA2GtVbijb8Etw-1; Mon, 02 Nov 2020 04:23:34 -0500
X-MC-Unique: 4rIlLjXWNA2GtVbijb8Etw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A23411074652;
        Mon,  2 Nov 2020 09:23:29 +0000 (UTC)
Received: from [10.36.113.163] (ovpn-113-163.ams2.redhat.com [10.36.113.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC9DF21E86;
        Mon,  2 Nov 2020 09:23:21 +0000 (UTC)
Subject: Re: [PATCH v3 3/4] arch, mm: restore dependency of
 __kernel_map_pages() of DEBUG_PAGEALLOC
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
References: <20201101170815.9795-1-rppt@kernel.org>
 <20201101170815.9795-4-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8eac2aa4-114e-f981-c8f8-ad8523175cf8@redhat.com>
Date:   Mon, 2 Nov 2020 10:23:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201101170815.9795-4-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


>   int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
>   				   unsigned numpages, unsigned long page_flags)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 14e397f3752c..ab0ef6bd351d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2924,7 +2924,11 @@ static inline bool debug_pagealloc_enabled_static(void)
>   	return static_branch_unlikely(&_debug_pagealloc_enabled);
>   }
>   
> -#if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_ARCH_HAS_SET_DIRECT_MAP)
> +#ifdef CONFIG_DEBUG_PAGEALLOC
> +/*
> + * To support DEBUG_PAGEALLOC architecture must ensure that
> + * __kernel_map_pages() never fails

Maybe add here, that this implies mapping everything via PTEs during boot.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

