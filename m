Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 996DD13FC78
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2020 23:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbgAPW4K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 17:56:10 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39352 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbgAPW4K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 17:56:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so20969584oty.6
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2020 14:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+RsdozmG9oAorRpMDSv2lpVMaBdsCUmAl0Rx9qh4kI=;
        b=Rslu8lBAJRm1nuB/mjY/s2pVIGY59dJJ1TbFZGxCOWickmK81LwN4xyqRDayAXnIGr
         Edf8wAj1AqTZ723c+Kk/GIG3Yml7ICb9LJ9Jiyso92PE9fPQ24ntGTr+TEVrWvng1Lhw
         AWDp+jt2UjWPBflznjTc2YzNNm5gpNm2Izn5LvK7oleIiYwbwimoFPd/+LF+6s2A8y/I
         vm7KYMS3dgz7WX57b4S+YkODsHZgpDHgpvg7SSGP4WkzxUYb3Fo29CBfYLkv/EHVmmSO
         MCs2/MaYW3Ffq6J6M5yLTdErXVtTXzjz1DLlNdqgFS+W9eJLzLFQ0Ua2qFUQcEt0QI0o
         OlIg==
X-Gm-Message-State: APjAAAXm+v6iyAB2Hc0BjFA6PPQVBJhRrvcdJ1YS1pfmFm9bcCUe576J
        B3wRvNNqGMj0fGHizGCoE7GbtrK+wzvY48WYeow=
X-Google-Smtp-Source: APXvYqy7JctXWcKMr2oxpt/OKC4TQqL5eUG45rHdFhHGC3S8ypYHKzObF7NIuJmB+CPZGNstHl3r8HLpwRNm5CNW1UA=
X-Received: by 2002:a9d:62c7:: with SMTP id z7mr3921162otk.189.1579215369683;
 Thu, 16 Jan 2020 14:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20200116110934.90531-1-glider@google.com>
In-Reply-To: <20200116110934.90531-1-glider@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 16 Jan 2020 23:55:58 +0100
Message-ID: <CAJZ5v0gcKk1eNDy1MM+MjgkHOJ9hFL7O0N2iyNwf8jJcw50waw@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: fix crashes with init_on_free=1
To:     Alexander Potapenko <glider@google.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Johannes Stezenbach <js@sig21.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 16, 2020 at 12:10 PM <glider@google.com> wrote:
>
> Upon resuming from hibernation, free pages may contain stale data from
> the kernel that initiated the resume. This breaks the invariant
> inflicted by init_on_free=1 that freed pages must be zeroed.
>
> To deal with this problem, make clear_free_pages() also clear the free
> pages when init_on_free is enabled.
>
> Reported-by: Johannes Stezenbach <js@sig21.net>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")
> ---
>  kernel/power/snapshot.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 26b9168321e7..d65f2d5ab694 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1147,24 +1147,24 @@ void free_basic_memory_bitmaps(void)
>
>  void clear_free_pages(void)
>  {
> -#ifdef CONFIG_PAGE_POISONING_ZERO
>         struct memory_bitmap *bm = free_pages_map;
>         unsigned long pfn;
>
>         if (WARN_ON(!(free_pages_map)))
>                 return;
>
> -       memory_bm_position_reset(bm);
> -       pfn = memory_bm_next_pfn(bm);
> -       while (pfn != BM_END_OF_MAP) {
> -               if (pfn_valid(pfn))
> -                       clear_highpage(pfn_to_page(pfn));
> -
> +       if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free()) {
> +               memory_bm_position_reset(bm);
>                 pfn = memory_bm_next_pfn(bm);
> +               while (pfn != BM_END_OF_MAP) {
> +                       if (pfn_valid(pfn))
> +                               clear_highpage(pfn_to_page(pfn));
> +
> +                       pfn = memory_bm_next_pfn(bm);
> +               }
> +               memory_bm_position_reset(bm);
> +               pr_info("free pages cleared after restore\n");
>         }
> -       memory_bm_position_reset(bm);
> -       pr_info("free pages cleared after restore\n");
> -#endif /* PAGE_POISONING_ZERO */
>  }
>
>  /**
> --

Queued up as a fix for 5.5-rc and "stable", thanks!
