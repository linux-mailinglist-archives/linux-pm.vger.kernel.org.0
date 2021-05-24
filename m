Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC9B38E889
	for <lists+linux-pm@lfdr.de>; Mon, 24 May 2021 16:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhEXOUe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 May 2021 10:20:34 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36611 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232929AbhEXOUd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 May 2021 10:20:33 -0400
Received: by mail-oi1-f169.google.com with SMTP id t24so11678360oiw.3
        for <linux-pm@vger.kernel.org>; Mon, 24 May 2021 07:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmCsXFThM3ELZyxG4lsr4JGktMa48275Emgx8/AMUj4=;
        b=izzmqxQvyFRDWsLqJlVE+8CQV2LMKQw3eN1e4qjhIX9r0BwQTUh5qksWU/tjWN6bw6
         tp2lzJoqTtqvnMvbsJd2PtAj/7ZfJZI6EQnAzztv4s9TUjuZL0kmQ0zWq+pfacfn6AKZ
         c+LHyQWCBWkioCF9DUaopxxzoBlcedlc54tQV7xd+/nn23ZA7lBqq6Eo0WKeWd96Sjr8
         ruqDGwgXAEcB7gKc1WAL1vtsgCTE1BfVcT5pfTyMelvuSMBiBpMAx6H/L09b80llgbN7
         vGTX1ha6BVZu9HQ/jvgWAvBM4J2fIs+MV4xroNIjPwtUIA+7w4dNbLTd1dzsorL3kxaU
         f/7A==
X-Gm-Message-State: AOAM532L3L/tDtnCuDVsQ8s2z5ZmnuN7v+JNvsbwZSx02erQSDTiy9Kr
        2OeHZEwF5xd9+y2IDASCvDD8l1lofOm33MNhoCQ=
X-Google-Smtp-Source: ABdhPJyUcV+sI3ExMhxS9MQREWocW+FxTorqOHkMw0F50syktsfkQPcVmnLL+KRG48cnLawm1j0j5VWWYBU4fh6dq7A=
X-Received: by 2002:aca:4758:: with SMTP id u85mr11031045oia.71.1621865943101;
 Mon, 24 May 2021 07:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210524093010.8839-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210524093010.8839-1-thunder.leizhen@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 May 2021 16:18:47 +0200
Message-ID: <CAJZ5v0ihQVN-+5ZUhYNxahrDk7Q87ALzgTNDgn+mhMn1_QkW_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM: fix spelling mistakes
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 24, 2021 at 11:30 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Fix some spelling mistakes in comments:
> corresonds ==> corresponds
> alocated ==> allocated
> unitialized ==> uninitialized
> Deompression ==> Decompression
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/power/snapshot.c | 8 ++++----
>  kernel/power/swap.c     | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 1a221dcb3c01..af507c8c895b 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -331,7 +331,7 @@ static void *chain_alloc(struct chain_allocator *ca, unsigned int size)
>   *
>   * Memory bitmap is a structure consisting of many linked lists of
>   * objects.  The main list's elements are of type struct zone_bitmap
> - * and each of them corresonds to one zone.  For each zone bitmap
> + * and each of them corresponds to one zone.  For each zone bitmap
>   * object there is a list of objects of type struct bm_block that
>   * represent each blocks of bitmap in which information is stored.
>   *
> @@ -1500,7 +1500,7 @@ static struct memory_bitmap copy_bm;
>  /**
>   * swsusp_free - Free pages allocated for hibernation image.
>   *
> - * Image pages are alocated before snapshot creation, so they need to be
> + * Image pages are allocated before snapshot creation, so they need to be
>   * released after resume.
>   */
>  void swsusp_free(void)
> @@ -2326,7 +2326,7 @@ static struct memory_bitmap *safe_highmem_bm;
>   * (@nr_highmem_p points to the variable containing the number of highmem image
>   * pages).  The pages that are "safe" (ie. will not be overwritten when the
>   * hibernation image is restored entirely) have the corresponding bits set in
> - * @bm (it must be unitialized).
> + * @bm (it must be uninitialized).
>   *
>   * NOTE: This function should not be called if there are no highmem image pages.
>   */
> @@ -2483,7 +2483,7 @@ static inline void free_highmem_data(void) {}
>
>  /**
>   * prepare_image - Make room for loading hibernation image.
> - * @new_bm: Unitialized memory bitmap structure.
> + * @new_bm: Uninitialized memory bitmap structure.
>   * @bm: Memory bitmap with unsafe pages marked.
>   *
>   * Use @bm to mark the pages that will be overwritten in the process of
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index bea3cb8afa11..3cb89baebc79 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1125,7 +1125,7 @@ struct dec_data {
>  };
>
>  /**
> - * Deompression function that runs in its own thread.
> + * Decompression function that runs in its own thread.
>   */
>  static int lzo_decompress_threadfn(void *data)
>  {
> --

Applied as 5.14 material with some edits in the subject and changelog, thanks!
