Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D590B435FAA
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 12:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhJUKvf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 06:51:35 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:34530 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJUKve (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 06:51:34 -0400
Received: by mail-oi1-f171.google.com with SMTP id v77so366548oie.1;
        Thu, 21 Oct 2021 03:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nP2vFNPxI37N8uLOpzFpF7dKWuNYgW2/FE/Tat39R0Q=;
        b=QpPzAI9kHcato9eV8oye5+iRrSm6Ji0ZQJT0CZarhNgBJR8qVBkgndyJhLroLdo1Dp
         9QbX12YuTwu12BuHJA1zy3k5SK+kvum6kzJlcxlYtgX13HaPn2/0no86GnpHzr24jNQx
         LbeBB+HwTomfPH2z+S/OiH+/Rv2BMZ7Wq/FVIaFCh873swrcmzxB7+uisSw/6r1D+uYT
         kisXtoNbKGxoP3QMC4j4+8bX+Jay5KF9URNdoYRZ2+Ko+GI33JorKhM22V/sXKXiT2AX
         ycozBg6UdgrkQBHkAmdxfaovG+JbFA0foc3LuyXIKqI9nou8Y8b1JdwlQpOJe6O63D+7
         DsiQ==
X-Gm-Message-State: AOAM532szNTnewlRYpxSC/3TdK2y25CI2KC0c48if+4VJWBj68JWKgha
        1f6Kaspn07bT6Y6L5hGH5tInvR1IqHdwtuYvRYwaTOel
X-Google-Smtp-Source: ABdhPJw8q3JuoPKjv5MTm9qAw0p16wHNn/zGVn84Q18EczAeLiPhmFlKo3UQ5njvrzeUENKc84wbLk79fKo+MUjtITQ=
X-Received: by 2002:aca:5c5:: with SMTP id 188mr3673122oif.154.1634813358761;
 Thu, 21 Oct 2021 03:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211007191337.540058-1-anders.roxell@linaro.org>
In-Reply-To: <20211007191337.540058-1-anders.roxell@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Oct 2021 12:49:07 +0200
Message-ID: <CAJZ5v0gTK79W5RK3v+4GPN+EN68EHoDhbQjxi7t-bHASTxcFhw@mail.gmail.com>
Subject: Re: [PATCH] kernel: power: swap: fix sparse warnings
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 7, 2021 at 9:13 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When building the kernel with sparse enabled 'C=1' the following
> warnings shows up:
>
> kernel/power/swap.c:390:29: warning: incorrect type in assignment (different base types)
> kernel/power/swap.c:390:29:    expected int ret
> kernel/power/swap.c:390:29:    got restricted blk_status_t
>
> This is due to function hib_wait_io() returns a 'blk_status_t' which is
> a bitwise u8. Commit 5416da01ff6e ("PM: hibernate: Remove
> blk_status_to_errno in hib_wait_io") seemed to have mixed up the return
> type. However, the 4e4cbee93d56 ("block: switch bios to blk_status_t")
> actually broke the behaviour by returning the wrong type.
>
> Rework so function hib_wait_io() returns a 'int' instead of
> 'blk_status_t' and make sure to call function
> blk_status_to_errno(hb->error)' when returning from function
> hib_wait_io() a int gets returned.
>
> Fixes: 4e4cbee93d56 ("block: switch bios to blk_status_t")
> Fixes: 5416da01ff6e ("PM: hibernate: Remove blk_status_to_errno in hib_wait_io")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  kernel/power/swap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 9ec418955556..47107f9cd14c 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -299,14 +299,14 @@ static int hib_submit_io(int op, int op_flags, pgoff_t page_off, void *addr,
>         return error;
>  }
>
> -static blk_status_t hib_wait_io(struct hib_bio_batch *hb)
> +static int hib_wait_io(struct hib_bio_batch *hb)
>  {
>         /*
>          * We are relying on the behavior of blk_plug that a thread with
>          * a plug will flush the plug list before sleeping.
>          */
>         wait_event(hb->wait, atomic_read(&hb->count) == 0);
> -       return hb->error;
> +       return blk_status_to_errno(hb->error);
>  }
>
>  /*
> --

Applied as 5.16 material, thanks!
