Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9758358B86
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 19:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhDHRik (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 13:38:40 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:42935 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbhDHRik (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 13:38:40 -0400
Received: by mail-ot1-f41.google.com with SMTP id c24-20020a9d6c980000b02902662e210895so3068472otr.9;
        Thu, 08 Apr 2021 10:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Za9qZOBqeZjEVPtGBzrMmWv0sOzk51r1HTrllhzYbGw=;
        b=L/JwskOV2izykcNblXCzZd7JdzP4XpWuVDRPN6SP2WDqisj4l1+7DtOFOHraCYDU0/
         wdGj2uNacdf4nzktw3pMXE/qFrXWM7NsJMoIgIdnsYEKbl4z8rfiri1bSSk6BqDg3lpQ
         nNvexyP5UmsSKS4L7UUAy1AOiLZh9RkE3yJqWkqDLrPb/AOSMI2kRwfmExFlKHjNtvFN
         a6yQvFA+tNJIfAD3I8sLYJlIux1mCWXCvasTXdq4HEo1LxE/ZnNoL0E/hMNZLK9Gbtj9
         zZ23eDaih1MVDHSVT0SIaIndgMoIkl6oqOwuGlC7+PXDD3gQDtQpqPqwRmiW+qDRGkfK
         lolg==
X-Gm-Message-State: AOAM530cR8B/Ml9cBlB19sO59dHE+jtAIdbxsIEfZlPQQC83zgPKHoFk
        vwZT4Rx74fTBrqBGpvJWGu+wCZ1FDMCvkeTpCr4=
X-Google-Smtp-Source: ABdhPJxBGTYcthKOaAtKuFJMdn8SXlw+UK31dWkh1xU1S1ueVyyO7YwBB9iKE7hevaG/VAiDY25GWJih4RcFtBjz6do=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr8952295otf.206.1617903508550;
 Thu, 08 Apr 2021 10:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210408081444.167868-1-lujialin4@huawei.com>
In-Reply-To: <20210408081444.167868-1-lujialin4@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Apr 2021 19:38:17 +0200
Message-ID: <CAJZ5v0h9MXxNE+TjKAet+7vT2LDYG=h80wd1_5Q5=h6daDmPRA@mail.gmail.com>
Subject: Re: [PATCH -next] PM: fix typos in comments
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 8, 2021 at 10:14 AM Lu Jialin <lujialin4@huawei.com> wrote:
>
> Change occured to occurred in kernel/power/autosleep.c.
> Change consiting to consisting in kernel/power/snapshot.c.
> Change avaiable to available in kernel/power/swap.c.
> No functionality changed.
>
> Signed-off-by: Lu Jialin <lujialin4@huawei.com>
> ---
>  kernel/power/autosleep.c | 2 +-
>  kernel/power/snapshot.c  | 2 +-
>  kernel/power/swap.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/autosleep.c b/kernel/power/autosleep.c
> index 9af5a50d3489..b29c8aca7486 100644
> --- a/kernel/power/autosleep.c
> +++ b/kernel/power/autosleep.c
> @@ -54,7 +54,7 @@ static void try_to_suspend(struct work_struct *work)
>                 goto out;
>
>         /*
> -        * If the wakeup occured for an unknown reason, wait to prevent the
> +        * If the wakeup occurred for an unknown reason, wait to prevent the
>          * system from trying to suspend and waking up in a tight loop.
>          */
>         if (final_count == initial_count)
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 64b7aab9aee4..27cb4e7086b7 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -329,7 +329,7 @@ static void *chain_alloc(struct chain_allocator *ca, unsigned int size)
>  /**
>   * Data types related to memory bitmaps.
>   *
> - * Memory bitmap is a structure consiting of many linked lists of
> + * Memory bitmap is a structure consisting of many linked lists of
>   * objects.  The main list's elements are of type struct zone_bitmap
>   * and each of them corresonds to one zone.  For each zone bitmap
>   * object there is a list of objects of type struct bm_block that
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 72e33054a2e1..bea3cb8afa11 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -884,7 +884,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
>   *     enough_swap - Make sure we have enough swap to save the image.
>   *
>   *     Returns TRUE or FALSE after checking the total amount of swap
> - *     space avaiable from the resume partition.
> + *     space available from the resume partition.
>   */
>
>  static int enough_swap(unsigned int nr_pages)
> --

Applied as 5.13 material, thanks!
