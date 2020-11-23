Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29B72C11F1
	for <lists+linux-pm@lfdr.de>; Mon, 23 Nov 2020 18:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbgKWR3d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Nov 2020 12:29:33 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46629 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732550AbgKWR3d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 12:29:33 -0500
Received: by mail-ot1-f65.google.com with SMTP id g19so16624752otp.13;
        Mon, 23 Nov 2020 09:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoCeEEiueC0eR8W6StxQJoPExuC6/siWsRoZTafjIyI=;
        b=gEmbGd9RdqBlGr1MpZKSITy0Z85G0uLV4twSLvjX1dUWpp/3nzIV9uB1mKKpaJdtUt
         1MNFaglYMR4pW7YoXjDextg3Hu01wTjfEGJP1Ru1LiDF2IW0xd/JG89ny0OKB79T1O0t
         aB76xW65qCwrOo1oPqiAclsB1ueUL6UPpnZzOGtGb+3NmbRiGhGETxMwi33RdGBkcmwS
         pSb31L/zf+bqZ57KV7hP/+kkcIoM4QDzRflITfzyxBhrP4LJtJiQ8IEpubU4ysRRDoNf
         yOTLkxueVJcl4k6sqGWiHmZm3iiatoASw5zUZpBiHysCUrbxx9lhoeKcgDwsonCz9ieg
         u7xQ==
X-Gm-Message-State: AOAM5335UWlXT0Dnu+yFbynb2mp/P3W8M6spJFaIz0DbXbtQR0OMAT+T
        f0BWeG67nRjGJX4C9lqStblupKxspqeoyAEUqul0WEu8lf8=
X-Google-Smtp-Source: ABdhPJw/yFt2dWd5eFWPjrtWq7pjj9ia5WwgIgvpiT9nOh7AO8qdhxhzJVekziR1ACaxNwRKhV0xl4O6yHV/POCI+r4=
X-Received: by 2002:a9d:16f:: with SMTP id 102mr321122otu.206.1606152572974;
 Mon, 23 Nov 2020 09:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20201117134759.26797-1-lukasz.luba@arm.com>
In-Reply-To: <20201117134759.26797-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 23 Nov 2020 18:29:22 +0100
Message-ID: <CAJZ5v0hQNoi24RkwoU_SNuieUcN6+_0w6=0eBw7ZV55uWT=x+A@mail.gmail.com>
Subject: Re: [PATCH v2] powercap: Adjust printing the constraint name with new line
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 17, 2020 at 2:48 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The constrain name has limit of size 30, which sometimes might be hit.
> When this happens the new line might get lost. Prevent this and set the
> max limit for name string length equal 29. This would result is proper
> string clamping (when needed) and storing '\n' at index 29 and '\0' at 30,
> so similarly as desired originally.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Hi Rafael,
>
> It is based on top of you current pm/linux-next branch.
>
> Change log:
> v2:
> - switched to sprintf() with "%.*s\n" pattern
> v1 [1]
>
> Regards,
> Lukasz
>
> [1] https://lore.kernel.org/linux-pm/20201109172452.6923-1-lukasz.luba@arm.com/
>
>
>  drivers/powercap/powercap_sys.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> index 3f0b8e2ef3d4..f0654a932b37 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -170,9 +170,8 @@ static ssize_t show_constraint_name(struct device *dev,
>         if (pconst && pconst->ops && pconst->ops->get_name) {
>                 name = pconst->ops->get_name(power_zone, id);
>                 if (name) {
> -                       snprintf(buf, POWERCAP_CONSTRAINT_NAME_LEN,
> -                                                               "%s\n", name);
> -                       buf[POWERCAP_CONSTRAINT_NAME_LEN] = '\0';
> +                       sprintf(buf, "%.*s\n", POWERCAP_CONSTRAINT_NAME_LEN - 1,
> +                               name);
>                         len = strlen(buf);
>                 }
>         }
> --

Applied as 5.11 material, thanks!
