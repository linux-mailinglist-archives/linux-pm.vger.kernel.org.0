Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C525B2B0981
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 17:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgKLQH0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 11:07:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728811AbgKLQHV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 11:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605197239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRZEx8RGEYLRngswzLvwuQM5eiFnRZ2mPobY/fc2J1k=;
        b=PPFXSpwAtMPWV0W2p2aMe1WpEYwx+hmVKIf+dTrHFzm2kmWz5XYhVcvlegt4wIpQBBhww+
        uqXOS1wLWdWlShy2By7Ty8v65JnjQpe3yWeEJFsuKkBiJaG2cHkkI6aMBDRzhJxUkPgxGH
        m7LZTPnPhzvEM7WIEngnGUrOPEz9FoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-89aUGZthPEaUpKAeX8ZkJA-1; Thu, 12 Nov 2020 11:07:15 -0500
X-MC-Unique: 89aUGZthPEaUpKAeX8ZkJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46CC680474C;
        Thu, 12 Nov 2020 16:07:07 +0000 (UTC)
Received: from [10.36.115.61] (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A0655D9CA;
        Thu, 12 Nov 2020 16:07:03 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] kernel/power: allow hibernation with page_poison
 sanity checking
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
References: <20201103152237.9853-1-vbabka@suse.cz>
 <20201103152237.9853-4-vbabka@suse.cz>
 <eba10537-98c0-5363-8ff6-c0e71b823e50@redhat.com>
 <7811e5ec-c7ae-09a9-7f90-45e14956c4c4@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <44ab29d4-4ad2-3142-0fcf-78897cf68c71@redhat.com>
Date:   Thu, 12 Nov 2020 17:07:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7811e5ec-c7ae-09a9-7f90-45e14956c4c4@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12.11.20 15:39, Vlastimil Babka wrote:
> On 11/11/20 4:42 PM, David Hildenbrand wrote:
> ...
>>> @@ -1152,12 +1152,18 @@ void clear_free_pages(void)
>>>    	if (WARN_ON(!(free_pages_map)))
>>>    		return;
>>>    
>>> -	if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free()) {
>>> +	if (page_poisoning_enabled() || want_init_on_free()) {
>>>    		memory_bm_position_reset(bm);
>>>    		pfn = memory_bm_next_pfn(bm);
>>>    		while (pfn != BM_END_OF_MAP) {
>>> -			if (pfn_valid(pfn))
>>> -				clear_highpage(pfn_to_page(pfn));
>>> +			if (pfn_valid(pfn)) {
>>> +				struct page *page = pfn_to_page(pfn);
>>
>> ^ empty line missing. And at least I prefer to declare all variables in
>> the function header.
>>
>> I'd even suggest to move this into a separate function like
>>
>> clear_or_poison_free_page(struct page *page)
>>
>>
> 
> Ok, fixup below.
> 
> ----8<----
>   From cae1e8ccfa57c28ed1b2f5f8a47319b86cbdcfbf Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 12 Nov 2020 15:33:07 +0100
> Subject: [PATCH] kernel/power: allow hibernation with page_poison sanity
>    checking-fix
> 
> Adapt to __kernel_unpoison_pages fixup. Split out clear_or_poison_free_page()
> per David Hildenbrand.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>    include/linux/mm.h      |  1 +
>    kernel/power/snapshot.c | 18 ++++++++++--------
>    2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 861b9392b5dc..d4cfb06a611e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2896,6 +2896,7 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages)
>    #else
>    static inline bool page_poisoning_enabled(void) { return false; }
>    static inline bool page_poisoning_enabled_static(void) { return false; }
> +static inline void __kernel_poison_pages(struct page *page, int nunmpages) { }
>    static inline void kernel_poison_pages(struct page *page, int numpages) { }
>    static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
>    #endif
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 6b1c84afa891..a3491b29c5cc 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1144,6 +1144,14 @@ void free_basic_memory_bitmaps(void)
>    	pr_debug("Basic memory bitmaps freed\n");
>    }
>    
> +static void clear_or_poison_free_page(struct page *page)
> +{
> +	if (page_poisoning_enabled_static())
> +		__kernel_poison_pages(page, 1);
> +	else if (want_init_on_free())
> +		clear_highpage(page);
> +}
> +
>    void clear_or_poison_free_pages(void)
>    {
>    	struct memory_bitmap *bm = free_pages_map;
> @@ -1156,14 +1164,8 @@ void clear_or_poison_free_pages(void)
>    		memory_bm_position_reset(bm);
>    		pfn = memory_bm_next_pfn(bm);
>    		while (pfn != BM_END_OF_MAP) {
> -			if (pfn_valid(pfn)) {
> -				struct page *page = pfn_to_page(pfn);
> -				if (page_poisoning_enabled_static())
> -					kernel_poison_pages(page, 1);
> -				else if (want_init_on_free())
> -					clear_highpage(page);
> -
> -			}
> +			if (pfn_valid(pfn))
> +				clear_or_poison_free_page(pfn_to_page(pfn));
>    
>    			pfn = memory_bm_next_pfn(bm);
>    		}
> 

LGTM, thanks!

-- 
Thanks,

David / dhildenb

