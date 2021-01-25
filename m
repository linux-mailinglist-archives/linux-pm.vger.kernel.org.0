Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26BE302979
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 19:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbhAYSA7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 13:00:59 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:34327 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbhAYRzz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 12:55:55 -0500
Received: by mail-oi1-f171.google.com with SMTP id h192so15709099oib.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Jan 2021 09:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wOQZtMyYeSs8GiA3+77yPCe6Fv8qkk88fELufWlSDnM=;
        b=QTXI0ZdvfKE1U47jbI3h+OYT4pBE02sHW0HwbjdqISv0uFAvIQGxIe2G5n68IGEV73
         lb2yS3firWMjWmit0tTzTBKRDHtiKAAuW1R0M5ZBKgV6q6WUgeWbV7Xwbaq7HnglDVr2
         jrxb2Oy/Thv+Ujgi2Xq94Fiapytk6gVDxUQ/G66inez7drmUnnO8Rm/7YLADqtgrIdgq
         waOEltRP+Ay9vo7FQ02wWNer418PJSj7+4amqeI9DQ9A1RpdF74aqzbqHsfvt2C9UKy1
         kklZerr1livuYyzRI4vif2Tsm7j/9u4x7Xt0R/UnQBlZKuZl44bJFZcXk8deaxwjK+Vo
         wakA==
X-Gm-Message-State: AOAM533IMfaiEAmzQgUWxn//kuTY3PpaIxoL8s/0T5kekMcOu5ivbnWA
        eD7Zzrcfh00cq8LilKCHP2hr8aeYwgKet0IYgXQ=
X-Google-Smtp-Source: ABdhPJxuQe6ZLzQtXgQP1RWAHDE8nOJGtwndEOep0cjAmjceTQUBJyX43QCsKtC5XGpe2Fvg6lGE+GspozoGn4F+Plg=
X-Received: by 2002:a05:6808:9a8:: with SMTP id e8mr865305oig.157.1611597314436;
 Mon, 25 Jan 2021 09:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20210122161941.1080-1-laurentbadel@eaton.com> <20210122161941.1080-2-laurentbadel@eaton.com>
In-Reply-To: <20210122161941.1080-2-laurentbadel@eaton.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jan 2021 18:55:03 +0100
Message-ID: <CAJZ5v0g75M8tMs3EqAa0Nb2z-41eg6kovm1WOZKOZ5Q4SGwbkw@mail.gmail.com>
Subject: Re: [PATCH 1/1] PM: hibernate: flush swap writer after marking
To:     Laurent Badel <laurentbadel@eaton.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 22, 2021 at 5:49 PM Laurent Badel <laurentbadel@eaton.com> wrote:
>
> Flush the swap writer after, not before, marking the files, to ensure the
> signature is properly written.
>
> Signed-off-by: Laurent Badel <laurentbadel@eaton.com>
> ---
>  kernel/power/swap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index c73f2e295167..72e33054a2e1 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -497,10 +497,10 @@ static int swap_writer_finish(struct swap_map_handle *handle,
>                 unsigned int flags, int error)
>  {
>         if (!error) {
> -               flush_swap_writer(handle);
>                 pr_info("S");
>                 error = mark_swapfiles(handle, flags);
>                 pr_cont("|\n");
> +               flush_swap_writer(handle);
>         }
>
>         if (error)
> --

Applied as 5.11-rc material, thanks!
