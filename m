Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161382B07B0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 15:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKLOm5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 09:42:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:47662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLOm5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Nov 2020 09:42:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D6BE8AB95;
        Thu, 12 Nov 2020 14:42:54 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] kernel/power: allow hibernation with page_poison
 sanity checking
To:     David Hildenbrand <david@redhat.com>,
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
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7811e5ec-c7ae-09a9-7f90-45e14956c4c4@suse.cz>
Date:   Thu, 12 Nov 2020 15:39:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <eba10537-98c0-5363-8ff6-c0e71b823e50@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/11/20 4:42 PM, David Hildenbrand wrote:
...
>> @@ -1152,12 +1152,18 @@ void clear_free_pages(void)
>>   	if (WARN_ON(!(free_pages_map)))
>>   		return;
>>   
>> -	if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free()) {
>> +	if (page_poisoning_enabled() || want_init_on_free()) {
>>   		memory_bm_position_reset(bm);
>>   		pfn = memory_bm_next_pfn(bm);
>>   		while (pfn != BM_END_OF_MAP) {
>> -			if (pfn_valid(pfn))
>> -				clear_highpage(pfn_to_page(pfn));
>> +			if (pfn_valid(pfn)) {
>> +				struct page *page = pfn_to_page(pfn);
> 
> ^ empty line missing. And at least I prefer to declare all variables in
> the function header.
> 
> I'd even suggest to move this into a separate function like
> 
> clear_or_poison_free_page(struct page *page)
> 
> 

Ok, fixup below.

----8<----
 From cae1e8ccfa57c28ed1b2f5f8a47319b86cbdcfbf Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 12 Nov 2020 15:33:07 +0100
Subject: [PATCH] kernel/power: allow hibernation with page_poison sanity
  checking-fix

Adapt to __kernel_unpoison_pages fixup. Split out clear_or_poison_free_page()
per David Hildenbrand.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
  include/linux/mm.h      |  1 +
  kernel/power/snapshot.c | 18 ++++++++++--------
  2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 861b9392b5dc..d4cfb06a611e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2896,6 +2896,7 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages)
  #else
  static inline bool page_poisoning_enabled(void) { return false; }
  static inline bool page_poisoning_enabled_static(void) { return false; }
+static inline void __kernel_poison_pages(struct page *page, int nunmpages) { }
  static inline void kernel_poison_pages(struct page *page, int numpages) { }
  static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
  #endif
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 6b1c84afa891..a3491b29c5cc 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1144,6 +1144,14 @@ void free_basic_memory_bitmaps(void)
  	pr_debug("Basic memory bitmaps freed\n");
  }
  
+static void clear_or_poison_free_page(struct page *page)
+{
+	if (page_poisoning_enabled_static())
+		__kernel_poison_pages(page, 1);
+	else if (want_init_on_free())
+		clear_highpage(page);
+}
+
  void clear_or_poison_free_pages(void)
  {
  	struct memory_bitmap *bm = free_pages_map;
@@ -1156,14 +1164,8 @@ void clear_or_poison_free_pages(void)
  		memory_bm_position_reset(bm);
  		pfn = memory_bm_next_pfn(bm);
  		while (pfn != BM_END_OF_MAP) {
-			if (pfn_valid(pfn)) {
-				struct page *page = pfn_to_page(pfn);
-				if (page_poisoning_enabled_static())
-					kernel_poison_pages(page, 1);
-				else if (want_init_on_free())
-					clear_highpage(page);
-
-			}
+			if (pfn_valid(pfn))
+				clear_or_poison_free_page(pfn_to_page(pfn));
  
  			pfn = memory_bm_next_pfn(bm);
  		}
-- 
2.29.1


