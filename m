Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289A331C1B4
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 19:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhBOSip (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 13:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhBOSia (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2021 13:38:30 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C08C061574
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 10:37:48 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id m188so8026827yba.13
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2021 10:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlG7WSBTmTt0VpZB7OCV0qVL7K8LEJDd0nI5vTKhQZg=;
        b=btS7zOsd8wzWdOEdLz2gpNybzWGD/BAdcRlSgW6lyo+d1eTDlo6Apq86ia5o0yvLol
         ppNdfSG9Ew07RangzW5JjgXQTYWEJEMBS1EC/xzXNmeZuU/GmzelkZsTTN/ls7pnKGv7
         M2JilzX+pX7HcaEPfsdGyWLo/ganbfaiisPmzPwHMH6NonEsOA9X85PVMfhfmbz43akz
         AEe8aueXHiFPpdSsaeQJmX0UTql6yGPgx7lgFMbam7wNCucfYyvpJd8dsY8/OdXZmlHv
         bkPDYvdNutZddnwMgv58clq+g3ZJkXrKxn3cjKmbDL47DQSeD8hoPaovvo/StdVOscKo
         HgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlG7WSBTmTt0VpZB7OCV0qVL7K8LEJDd0nI5vTKhQZg=;
        b=ayY1Htd3djtKA9e1pAxPzu3he5VlVnB5myQPz5G79sXdgrS41xrlspRsSzO6IIklZb
         aYHbS5IrSDvMWu17dVWBgCcAxttTbBXQei66yBlRlNSif5UD1H2ExIXEbAp3reISW1A3
         +XpmVWgxGmnlHBgStE5ywr5w13kl5Z/GR0xlM6QWxCP24MR+eOtMBv8bBzikeJHiTBHy
         F1rkFjc7J+G7Bq++5YX9oi+11VhbAEfOV53/Opo2uRN1EQBlQ7sRVz8Br+jEIZuZ3oFm
         FayvQ4hxvKAARz7gdteKMBC6cef7++llBgRAYdb+ic9WUAGV+MJzFSTpQqT2S+ksZ0pC
         u7cQ==
X-Gm-Message-State: AOAM532sJxBWYj9ow9iXoEpLfKMo1LXfi81y3b4kx479GGVN8m/ZYetT
        WnnJHNno4fK4QgtFh2aQyEgAuuHKWm7Glv60yW4fj1sp6po=
X-Google-Smtp-Source: ABdhPJyrNN8exbyo9T1MkxxXLxlRiWI1Wl1nf3PhjP4mVD6FrDEXdUPlDEuRTLmkptHAKrq7S6AmU78+qu5pBAVCeIw=
X-Received: by 2002:a25:8b8b:: with SMTP id j11mr22476525ybl.310.1613414267730;
 Mon, 15 Feb 2021 10:37:47 -0800 (PST)
MIME-Version: 1.0
References: <20210215151405.2551143-1-geert+renesas@glider.be>
In-Reply-To: <20210215151405.2551143-1-geert+renesas@glider.be>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 15 Feb 2021 10:37:11 -0800
Message-ID: <CAGETcx-c5P76JkB-upi8ArDqa=TrR3bJMnpDTO-59sh83opW8g@mail.gmail.com>
Subject: Re: [PATCH] staging: board: Fix uninitialized spinlock when attaching genpd
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 15, 2021 at 7:14 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> On Armadillo-800-EVA with CONFIG_DEBUG_SPINLOCK=y:
>
>     BUG: spinlock bad magic on CPU#0, swapper/1
>      lock: lcdc0_device+0x10c/0x308, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
>     CPU: 0 PID: 1 Comm: swapper Not tainted 5.11.0-rc5-armadillo-00036-gbbca04be7a80-dirty #287
>     Hardware name: Generic R8A7740 (Flattened Device Tree)
>     [<c010c3c8>] (unwind_backtrace) from [<c010a49c>] (show_stack+0x10/0x14)
>     [<c010a49c>] (show_stack) from [<c0159534>] (do_raw_spin_lock+0x20/0x94)
>     [<c0159534>] (do_raw_spin_lock) from [<c040858c>] (dev_pm_get_subsys_data+0x8c/0x11c)
>     [<c040858c>] (dev_pm_get_subsys_data) from [<c05fbcac>] (genpd_add_device+0x78/0x2b8)
>     [<c05fbcac>] (genpd_add_device) from [<c0412db4>] (of_genpd_add_device+0x34/0x4c)
>     [<c0412db4>] (of_genpd_add_device) from [<c0a1ea74>] (board_staging_register_device+0x11c/0x148)
>     [<c0a1ea74>] (board_staging_register_device) from [<c0a1eac4>] (board_staging_register_devices+0x24/0x28)
>
> of_genpd_add_device() is called before platform_device_register(), as it
> needs to attach the genpd before the device is probed.  But the spinlock
> is only initialized when the device is registered.
>
> Fix this by open-coding the spinlock initialization, cfr.
> device_pm_init_common() in the internal drivers/base code, and in the
> SuperH early platform code.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Exposed by fw_devlinks changing probe order.
> Masked before due to an unrelated wait context check failure, which
> disabled any further spinlock checks.
> https://lore.kernel.org/linux-acpi/CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com
> ---
>  drivers/staging/board/board.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
> index cb6feb34dd401ae3..604612937f038e92 100644
> --- a/drivers/staging/board/board.c
> +++ b/drivers/staging/board/board.c
> @@ -136,6 +136,7 @@ int __init board_staging_register_clock(const struct board_staging_clk *bsc)
>  static int board_staging_add_dev_domain(struct platform_device *pdev,
>                                         const char *domain)
>  {
> +       struct device *dev = &pdev->dev;
>         struct of_phandle_args pd_args;
>         struct device_node *np;
>
> @@ -148,7 +149,11 @@ static int board_staging_add_dev_domain(struct platform_device *pdev,
>         pd_args.np = np;
>         pd_args.args_count = 0;
>
> -       return of_genpd_add_device(&pd_args, &pdev->dev);
> +       /* Cfr. device_pm_init_common() */

What's Cfr?

> +       spin_lock_init(&dev->power.lock);
> +       dev->power.early_init = true;

Also, I tried looking up, but it's not exactly what this flag
represents other than the fact the spinlock has been initialized?
Which is weird to me. So maybe Rafael can double check this?

-Saravana

> +
> +       return of_genpd_add_device(&pd_args, dev);
>  }
>  #else
>  static inline int board_staging_add_dev_domain(struct platform_device *pdev,
> --
> 2.25.1
>
