Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C1F29E624
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 09:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgJ2IQN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Oct 2020 04:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42397 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728567AbgJ2IQJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2020 04:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603959368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2gRwEwp+09CxPY3cDDGs5AqZnz2L4R+qK1xrKBZP/ZQ=;
        b=FzwQIOYuQiYs8AOF0jSWfKko4kM786oPEch3YBrlcCg33I3RWV/PZlhcWMBvasAKZSkQo1
        UuhP3NJLwgXzCgQEtlOh5mPQq4rCYOYgBbezoY3+SbQWYchutULQci4oL/QzuQ14pQ8ItF
        9+GZvbOb12lYwWmjY/pkzovIBd1ffUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-GwWoSv2-OMqDqihE-45P3g-1; Thu, 29 Oct 2020 04:16:02 -0400
X-MC-Unique: GwWoSv2-OMqDqihE-45P3g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ED20809DC9;
        Thu, 29 Oct 2020 08:15:57 +0000 (UTC)
Received: from [10.36.112.181] (ovpn-112-181.ams2.redhat.com [10.36.112.181])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EBE05D9CC;
        Thu, 29 Oct 2020 08:15:48 +0000 (UTC)
Subject: Re: [PATCH 0/4] arch, mm: improve robustness of direct map
 manipulation
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
References: <20201025101555.3057-1-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <30075bb8-caed-c4de-c09e-e0f6fb964a8d@redhat.com>
Date:   Thu, 29 Oct 2020 09:15:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201025101555.3057-1-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25.10.20 11:15, Mike Rapoport wrote:
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

So, I was primarily wondering if we really have to touch direct mappings 
in hibernation code, or if we can avoid doing that. I was wondering if 
we cannot simply do something like kmap() when trying to access a 
!mapped page. Similar to reading old-os memory after kexec when in 
kdump. Just a thought.

-- 
Thanks,

David / dhildenb

