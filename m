Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36AE2AD307
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 11:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgKJKCk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 05:02:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727098AbgKJKCk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 05:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605002559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDregu+IjBgmVX/QBgcALAud6U3Yyo4UVoHSI5mURRk=;
        b=QFu0L5IQlJC4/TOvLbZwncMWuAYLW6kYXxamNXbKk2bUVkNcyrpTbWDz0xDcMi390NwdIO
        dtt+B9eV9nHZPMsyXhyEc6LpKzMYi59GUB6CozUUQdpCHzXVZCl/s3kduVfLRHzqqtMcQJ
        gE7OW1FlPAwrjjIWZ0tVABvI6HjK1Ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-hfNa44UoMDa7ZaTnX3vi-g-1; Tue, 10 Nov 2020 05:02:35 -0500
X-MC-Unique: hfNa44UoMDa7ZaTnX3vi-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5BF1186DD47;
        Tue, 10 Nov 2020 10:02:29 +0000 (UTC)
Received: from [10.36.114.232] (ovpn-114-232.ams2.redhat.com [10.36.114.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A77F5C1C4;
        Tue, 10 Nov 2020 10:02:19 +0000 (UTC)
Subject: Re: [PATCH v7 4/4] arch, mm: make kernel_page_present() always
 available
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
References: <20201109192128.960-1-rppt@kernel.org>
 <20201109192128.960-5-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <01b18dfb-2650-f70a-8e0a-a062d96e1849@redhat.com>
Date:   Tue, 10 Nov 2020 11:02:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201109192128.960-5-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09.11.20 20:21, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> For architectures that enable ARCH_HAS_SET_MEMORY having the ability to
> verify that a page is mapped in the kernel direct map can be useful
> regardless of hibernation.
> 
> Add RISC-V implementation of kernel_page_present(), update its forward
> declarations and stubs to be a part of set_memory API and remove ugly
> ifdefery in inlcude/linux/mm.h around current declarations of
> kernel_page_present().
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

