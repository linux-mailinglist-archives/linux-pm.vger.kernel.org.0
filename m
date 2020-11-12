Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A03C2B08F6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Nov 2020 16:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgKLPwy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Nov 2020 10:52:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38298 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgKLPwy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2020 10:52:54 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so6027579otf.5;
        Thu, 12 Nov 2020 07:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcCNXEA6BLGo7Sfakes4HmCFZE5lkBnWWORJD7JsOa4=;
        b=BlNfPVRtonmjj7WBWnyt2PzWzsA88tW60VXHSckQt4tHno/iBMF9SiGyCIO8xyiZiS
         1EqiQomyhs0PnOzvXrTRBvX3S8Gqsxk0eU3NKr7+lte7kOKQmwwXiSggBQnLoei5YKrz
         mBeWBU6L8kifbRITQnZVsbRZpgWou1WqeKfld7e0GFZpVPLnXpgzk23XeKjizfAuuCcI
         I1CjlXQUFawEDdc8TruRzc5Qn9jD847zTXE/KKfjm2tziCmPq+1YmVpqycLybS8L85Bi
         7D9Z/SPI2hP+Xlp25PlJIu4RJcO9gp4iRSVF1xZNMHwBrghxt+TkSaQP6/QRL/8ZzoVk
         eFZw==
X-Gm-Message-State: AOAM530zeGdiXi82tBzz2JANfok0zO1MVIvXqV7tjjAMGYxM9wXP8N8h
        2GkESNNBajWctvKMudCLm+AztsgAtz6RlW5SkNc=
X-Google-Smtp-Source: ABdhPJyL11rg82abF0YTUDzf73L5kXq6DOaUFQOy3VVDE+vlRCqjzkSv6bGydjQ3d9dHfXHSemoUTEF8BdSAUDBG+o8=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr23099589otu.206.1605196373666;
 Thu, 12 Nov 2020 07:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20201103152237.9853-1-vbabka@suse.cz> <20201103152237.9853-4-vbabka@suse.cz>
 <eba10537-98c0-5363-8ff6-c0e71b823e50@redhat.com> <7811e5ec-c7ae-09a9-7f90-45e14956c4c4@suse.cz>
In-Reply-To: <7811e5ec-c7ae-09a9-7f90-45e14956c4c4@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Nov 2020 16:52:42 +0100
Message-ID: <CAJZ5v0inNr=h7PsSdGgiWZO6t9nGLWagNtM=C_AnoVyw6f3m8g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] kernel/power: allow hibernation with page_poison
 sanity checking
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 12, 2020 at 3:42 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/11/20 4:42 PM, David Hildenbrand wrote:
> ...
> >> @@ -1152,12 +1152,18 @@ void clear_free_pages(void)
> >>      if (WARN_ON(!(free_pages_map)))
> >>              return;
> >>
> >> -    if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free()) {
> >> +    if (page_poisoning_enabled() || want_init_on_free()) {
> >>              memory_bm_position_reset(bm);
> >>              pfn = memory_bm_next_pfn(bm);
> >>              while (pfn != BM_END_OF_MAP) {
> >> -                    if (pfn_valid(pfn))
> >> -                            clear_highpage(pfn_to_page(pfn));
> >> +                    if (pfn_valid(pfn)) {
> >> +                            struct page *page = pfn_to_page(pfn);
> >
> > ^ empty line missing. And at least I prefer to declare all variables in
> > the function header.
> >
> > I'd even suggest to move this into a separate function like
> >
> > clear_or_poison_free_page(struct page *page)
> >
> >
>
> Ok, fixup below.
>
> ----8<----
>  From cae1e8ccfa57c28ed1b2f5f8a47319b86cbdcfbf Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Thu, 12 Nov 2020 15:33:07 +0100
> Subject: [PATCH] kernel/power: allow hibernation with page_poison sanity
>   checking-fix
>
> Adapt to __kernel_unpoison_pages fixup. Split out clear_or_poison_free_page()
> per David Hildenbrand.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Still

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>   include/linux/mm.h      |  1 +
>   kernel/power/snapshot.c | 18 ++++++++++--------
>   2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 861b9392b5dc..d4cfb06a611e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2896,6 +2896,7 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages)
>   #else
>   static inline bool page_poisoning_enabled(void) { return false; }
>   static inline bool page_poisoning_enabled_static(void) { return false; }
> +static inline void __kernel_poison_pages(struct page *page, int nunmpages) { }
>   static inline void kernel_poison_pages(struct page *page, int numpages) { }
>   static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
>   #endif
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 6b1c84afa891..a3491b29c5cc 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1144,6 +1144,14 @@ void free_basic_memory_bitmaps(void)
>         pr_debug("Basic memory bitmaps freed\n");
>   }
>
> +static void clear_or_poison_free_page(struct page *page)
> +{
> +       if (page_poisoning_enabled_static())
> +               __kernel_poison_pages(page, 1);
> +       else if (want_init_on_free())
> +               clear_highpage(page);
> +}
> +
>   void clear_or_poison_free_pages(void)
>   {
>         struct memory_bitmap *bm = free_pages_map;
> @@ -1156,14 +1164,8 @@ void clear_or_poison_free_pages(void)
>                 memory_bm_position_reset(bm);
>                 pfn = memory_bm_next_pfn(bm);
>                 while (pfn != BM_END_OF_MAP) {
> -                       if (pfn_valid(pfn)) {
> -                               struct page *page = pfn_to_page(pfn);
> -                               if (page_poisoning_enabled_static())
> -                                       kernel_poison_pages(page, 1);
> -                               else if (want_init_on_free())
> -                                       clear_highpage(page);
> -
> -                       }
> +                       if (pfn_valid(pfn))
> +                               clear_or_poison_free_page(pfn_to_page(pfn));
>
>                         pfn = memory_bm_next_pfn(bm);
>                 }
> --
> 2.29.1
>
>
