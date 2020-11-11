Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393EF2AF545
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 16:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgKKPm7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 10:42:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726638AbgKKPm5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2020 10:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605109375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xai5l2s8KRD9oSY9ZlqyCjNLFJtte63gsaAgqFvqKwM=;
        b=VKustqogNdxDiLPg5CDa11MlLoZE40PSXyfdnKnnFztK+hiA9esBrSQt6mMvmH04/sex1l
        vTMX+yHT70fI7vxQCa3Kjysb+2ewVjlgH7LIZ+8eQ11yupzbEKTZCJfNFyUY6xMRU242jk
        fM5hOlQCC8Cc46Shhy/nIM4j4TePweo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-nLNEnvcyONeYHoLevu9nvQ-1; Wed, 11 Nov 2020 10:42:51 -0500
X-MC-Unique: nLNEnvcyONeYHoLevu9nvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD7B41099F63;
        Wed, 11 Nov 2020 15:42:49 +0000 (UTC)
Received: from [10.36.114.151] (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C08FC27BBD;
        Wed, 11 Nov 2020 15:42:46 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <eba10537-98c0-5363-8ff6-c0e71b823e50@redhat.com>
Date:   Wed, 11 Nov 2020 16:42:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201103152237.9853-4-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03.11.20 16:22, Vlastimil Babka wrote:
> Page poisoning used to be incompatible with hibernation, as the state of
> poisoned pages was lost after resume, thus enabling CONFIG_HIBERNATION forces
> CONFIG_PAGE_POISONING_NO_SANITY. For the same reason, the poisoning with zeroes
> variant CONFIG_PAGE_POISONING_ZERO used to disable hibernation. The latter
> restriction was removed by commit 1ad1410f632d ("PM / Hibernate: allow
> hibernation with PAGE_POISONING_ZERO") and similarly for init_on_free by commit
> 18451f9f9e58 ("PM: hibernate: fix crashes with init_on_free=1") by making sure
> free pages are cleared after resume.
> 
> We can use the same mechanism to instead poison free pages with PAGE_POISON
> after resume. This covers both zero and 0xAA patterns. Thus we can remove the
> Kconfig restriction that disables page poison sanity checking when hibernation
> is enabled.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: <linux-pm@vger.kernel.org>
> ---
>   kernel/power/hibernate.c |  2 +-
>   kernel/power/power.h     |  2 +-
>   kernel/power/snapshot.c  | 14 ++++++++++----
>   mm/Kconfig.debug         |  1 -
>   4 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 2fc7d509a34f..da0b41914177 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -326,7 +326,7 @@ static int create_image(int platform_mode)
>   
>   	if (!in_suspend) {
>   		events_check_enabled = false;
> -		clear_free_pages();
> +		clear_or_poison_free_pages();
>   	}
>   
>   	platform_leave(platform_mode);
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 24f12d534515..778bf431ec02 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -106,7 +106,7 @@ extern int create_basic_memory_bitmaps(void);
>   extern void free_basic_memory_bitmaps(void);
>   extern int hibernate_preallocate_memory(void);
>   
> -extern void clear_free_pages(void);
> +extern void clear_or_poison_free_pages(void);
>   
>   /**
>    *	Auxiliary structure used for reading the snapshot image data and
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 46b1804c1ddf..6b1c84afa891 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1144,7 +1144,7 @@ void free_basic_memory_bitmaps(void)
>   	pr_debug("Basic memory bitmaps freed\n");
>   }
>   
> -void clear_free_pages(void)
> +void clear_or_poison_free_pages(void)
>   {
>   	struct memory_bitmap *bm = free_pages_map;
>   	unsigned long pfn;
> @@ -1152,12 +1152,18 @@ void clear_free_pages(void)
>   	if (WARN_ON(!(free_pages_map)))
>   		return;
>   
> -	if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free()) {
> +	if (page_poisoning_enabled() || want_init_on_free()) {
>   		memory_bm_position_reset(bm);
>   		pfn = memory_bm_next_pfn(bm);
>   		while (pfn != BM_END_OF_MAP) {
> -			if (pfn_valid(pfn))
> -				clear_highpage(pfn_to_page(pfn));
> +			if (pfn_valid(pfn)) {
> +				struct page *page = pfn_to_page(pfn);

^ empty line missing. And at least I prefer to declare all variables in 
the function header.

I'd even suggest to move this into a separate function like

clear_or_poison_free_page(struct page *page)


> +				if (page_poisoning_enabled_static())
> +					kernel_poison_pages(page, 1);
> +				else if (want_init_on_free())
> +					clear_highpage(page);
> +
> +			}
>   
>   			pfn = memory_bm_next_pfn(bm);
>   		}
> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> index 864f129f1937..c57786ad5be9 100644
> --- a/mm/Kconfig.debug
> +++ b/mm/Kconfig.debug
> @@ -64,7 +64,6 @@ config PAGE_OWNER
>   
>   config PAGE_POISONING
>   	bool "Poison pages after freeing"
> -	select PAGE_POISONING_NO_SANITY if HIBERNATION
>   	help
>   	  Fill the pages with poison patterns after free_pages() and verify
>   	  the patterns before alloc_pages. The filling of the memory helps
> 

Unless I am missing something important, this should work! Thanks!

-- 
Thanks,

David / dhildenb

