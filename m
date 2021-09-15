Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989D840C50B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 14:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhIOMUC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 08:20:02 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:46073 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbhIOMUB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 08:20:01 -0400
Received: by mail-oi1-f169.google.com with SMTP id j66so3876812oih.12;
        Wed, 15 Sep 2021 05:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvvJJNI1+sTHv2f+I5qP4x74Kh+0gtSO81EJ4aTnVtY=;
        b=v2uWRboaIUYyjQrs00LG9SdsulTNiFbEVogt5vAJ/bI1sgvGxLY9h9/OS9Gz7MWB/Y
         6BmpCxxkUba1Sqb/I4x2u8MF4Ml+Z4AQNr133F47CZH98ASrXZxDZ4FeDS1gaKaHjg5V
         tGJeEHHsgw5TcAyoh2PPL1EQoBAZ7KqAgCWJhv3AX34dAXFWCjf7HwHGZU2z5KcveYEV
         4B7Z7qJ1S0QKKWg1Ms6H0kbtfXbi3rwmC+Q1GhKmXgYgy8Z/aj5ll9N5SyPU7cieVoVT
         9VeDl6Bw6+Sy//e0KOVGNbxsHDXERmVxC/BnsEE+JC+Qp0VMlLjYuzzzpm37t5prB4UW
         B60g==
X-Gm-Message-State: AOAM531bm2Z3gJObMEaWYFHvAyj8jfnlnt60uR+O4nTDMl9hwHWX4Q6P
        /h7VkDI/Vfmbq6Y+Gd/B1u9Z2b0z7Se/wWMq3g4=
X-Google-Smtp-Source: ABdhPJzr4K4NK6PzgJLyGKXS6rEoO7yfb8imqlpL56m+CBo9PJ5AjYJ9RLAhkHylKV3i7J26yWeMqKl8Ty9bv+tNDtA=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr4785952ois.69.1631708322538;
 Wed, 15 Sep 2021 05:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210818214740.3743-1-fallacoulibalyz@gmail.com>
In-Reply-To: <20210818214740.3743-1-fallacoulibalyz@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Sep 2021 14:18:31 +0200
Message-ID: <CAJZ5v0hBOzx=p+4t0KrnzfhapBaUkRzeuRKkY-oX=U4qwey-9Q@mail.gmail.com>
Subject: Re: [PATCH] kernel/power: Remove blk_status_to_errno in hib_wait_io
To:     Falla Coulibaly <fallacoulibalyz@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 18, 2021 at 11:48 PM Falla Coulibaly
<fallacoulibalyz@gmail.com> wrote:
>
> blk_status_to_errno doesn't appear to perform extra work besides
> converting blk_status_t to integer. This patch removes that unnecessary
> conversion as the return type of the function is blk_status_t.
>
> Signed-off-by: Falla Coulibaly <fallacoulibalyz@gmail.com>
> ---
>  kernel/power/swap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 3cb89baebc79..9ec418955556 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -306,7 +306,7 @@ static blk_status_t hib_wait_io(struct hib_bio_batch *hb)
>          * a plug will flush the plug list before sleeping.
>          */
>         wait_event(hb->wait, atomic_read(&hb->count) == 0);
> -       return blk_status_to_errno(hb->error);
> +       return hb->error;
>  }
>
>  /*
> --

Applied as 5.16 material, thanks!
