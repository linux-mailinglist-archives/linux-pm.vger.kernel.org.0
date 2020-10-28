Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EBE29DD23
	for <lists+linux-pm@lfdr.de>; Thu, 29 Oct 2020 01:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgJ2AfL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Oct 2020 20:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731925AbgJ1WT3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/QY+frjp1dnSTegbpUI0625UXdGYc+dVdsYJMjhKKw=;
        b=hPo+tdiO30k2vbOy7ImTffeWp/Af7uzgQIyNld+pQACHUm/CTN+VGwWGb+rWE5N9Ds3p9v
        6c5gNtFUbLVWaaL3G7lsZEHzacTxrJYe1TbwhFBgAPcjC00puibdcxhfoJWxTTyLQUbcYs
        rUR4fUnw7t4HTOPxmhaG32GzkiYeLjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-5Kg-MYA4O2aB4WCrNYOgXA-1; Wed, 28 Oct 2020 07:17:50 -0400
X-MC-Unique: 5Kg-MYA4O2aB4WCrNYOgXA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90BEC809DE4;
        Wed, 28 Oct 2020 11:17:44 +0000 (UTC)
Received: from [10.36.114.138] (ovpn-114-138.ams2.redhat.com [10.36.114.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 033EC6EF5E;
        Wed, 28 Oct 2020 11:17:35 +0000 (UTC)
Subject: Re: [PATCH 0/4] arch, mm: improve robustness of direct map
 manipulation
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
References: <20201025101555.3057-1-rppt@kernel.org>
 <ae82f905a0092adb7e0f0ac206335c1883b3170f.camel@intel.com>
 <20201026090526.GA1154158@kernel.org>
 <a0212b073b3b2f62c3dbf1bf398f03fa402997be.camel@intel.com>
 <20201027083816.GG1154158@kernel.org>
 <e5fc62b6-f644-4ed5-de5b-ffd8337861e4@redhat.com>
 <20201028110945.GE1428094@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5805fdd9-14e5-141c-773b-c46d2da57258@redhat.com>
Date:   Wed, 28 Oct 2020 12:17:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201028110945.GE1428094@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28.10.20 12:09, Mike Rapoport wrote:
> On Tue, Oct 27, 2020 at 09:46:35AM +0100, David Hildenbrand wrote:
>> On 27.10.20 09:38, Mike Rapoport wrote:
>>> On Mon, Oct 26, 2020 at 06:05:30PM +0000, Edgecombe, Rick P wrote:
>>>
>>>> Beyond whatever you are seeing, for the latter case of new things
>>>> getting introduced to an interface with hidden dependencies... Another
>>>> edge case could be a new caller to set_memory_np() could result in
>>>> large NP pages. None of the callers today should cause this AFAICT, but
>>>> it's not great to rely on the callers to know these details.
> 
>>> A caller of set_memory_*() or set_direct_map_*() should expect a failure
>>> and be ready for that. So adding a WARN to safe_copy_page() is the first
>>> step in that direction :)
>>>
>>
>> I am probably missing something important, but why are we saving/restoring
>> the content of pages that were explicitly removed from the identity mapping
>> such that nobody will access them?
> 
> Actually, we should not be saving/restoring free pages during
> hibernation as there are several calls to mark_free_pages() that should
> exclude the free pages from the snapshot. I've tried to find why the fix
> that maps/unmaps a page to save it was required at the first place, but
> I could not find bug reports.
> 
> The closest I've got is an email from Rafael that asked to update
> "hibernate: handle DEBUG_PAGEALLOC" patch:
> 
> https://lore.kernel.org/linux-pm/200802200133.44098.rjw@sisk.pl/
> 
> Could it be that safe_copy_page() tries to workaround a non-existent
> problem?
> 

Clould be! Also see

https://lkml.kernel.org/r/38de5bb0-5559-d069-0ce0-daec66ef2746@suse.cz

which restores free page content based on more kernel parameters, not 
based on the original content.

-- 
Thanks,

David / dhildenb

