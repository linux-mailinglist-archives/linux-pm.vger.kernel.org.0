Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61E73DD78F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Aug 2021 15:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhHBNqU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Aug 2021 09:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbhHBNqO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Aug 2021 09:46:14 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875DEC06175F
        for <linux-pm@vger.kernel.org>; Mon,  2 Aug 2021 06:46:04 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id q75so1108754vkb.7
        for <linux-pm@vger.kernel.org>; Mon, 02 Aug 2021 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RB17MU1pJAfRQkn/6jvNyWpVmGH7Icd/hgOnLlEzxuk=;
        b=F5ASIru8EOb8b8ijHzOub5FKpL7CkNGrP/d38JvlhjC4EZQb4iHRHWmoHA99e522SR
         DudGw4ze9SBj/QThHZHNn3eBE4gaiiwfiWkoA84+VmIQOahuMLfOCst9BsGiGPYhyhcg
         1/SP/TOZczxWNXOzV6gLXF6xl7FwEnXCaGwOBSIqLnLLlbK3BgElbOQEHltY5Lzk0etI
         p19bOUg4+/T1NhUQFD/CsIivwMBF1Gacc4DEcLrtL0X94Wgc5kGAfH9FtdnNSx6DtcPz
         KbiHk+DDKEUVtXJEl2WzSWw92KUqI+0SSS6Td1/DoPK7ndr5VU/zMpev/hZOde2R+vO8
         FgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RB17MU1pJAfRQkn/6jvNyWpVmGH7Icd/hgOnLlEzxuk=;
        b=IhpSFZXBswUJiBflyUuYifW3Vomp3s5vMU3jo+rI2DNMemTje25AIRklt3HDawlGRv
         MUWo99Z2zYtAaGZtCqDQfWfQjoNssii41yIQjREIt0WLBQznA0sIfyX5fQI/wn+lPWjK
         viXd5UFtXfRNJQG9vpc3x7MRLVijiFXfbAnHpvR/zIjoEiP2NAuNFXyEwz7aTYSv64M5
         IWamdrIqHy2gGoPNXYR4pvhzUeBmfVRJGJ3jK6LKEmarDBYpqu4qGLAzhg9QLPig/Ae2
         kJ5YhXi6+rLwEzvP49ETWDVch9QNR1uFA5Pw6y/YWnxnBaAsqnGD2phhRTNBmRetdIj9
         wqSQ==
X-Gm-Message-State: AOAM531BReBrXxUz/e/MFhFyzcYHuQhsENBEi0mlLjps+YCv1IEzXxtS
        5V5XO/QuI1LzpNckoNTshkaAAZ4CUqyCysATKoLunw==
X-Google-Smtp-Source: ABdhPJys3C0NSF1OSBF2pdtOJrpc0ETgxFdEBsdyOedgw8e0aQQ3cCChzifcy/n0XDDC0J14ljAcg9DyT2dg6iAQlhM=
X-Received: by 2002:a1f:cf47:: with SMTP id f68mr8719981vkg.7.1627911963456;
 Mon, 02 Aug 2021 06:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <57783ece7ddae55f2bda2f59f452180bff744ea0.1626257398.git.geert+renesas@glider.be>
In-Reply-To: <57783ece7ddae55f2bda2f59f452180bff744ea0.1626257398.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 2 Aug 2021 15:45:27 +0200
Message-ID: <CAPDyKFoDULrvVJxRNQBjS-p6FynzXN_Az2eXkf9ag4CjYcsLNg@mail.gmail.com>
Subject: Re: [PATCH v2] staging: board: Fix uninitialized spinlock when
 attaching genpd
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 14 Jul 2021 at 12:13, Geert Uytterhoeven
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
>
> v2:
>   - Improve code comment.
> ---
>  drivers/staging/board/board.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
> index cb6feb34dd401ae3..f980af0373452cab 100644
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
> +       /* Initialization similar to device_pm_init_common() */
> +       spin_lock_init(&dev->power.lock);
> +       dev->power.early_init = true;
> +
> +       return of_genpd_add_device(&pd_args, dev);

It looks like the only device that is being managed here, is a
platform device that corresponds to the sh_mobile_lcdc_driver
(drivers/video/fbdev/sh_mobile_lcdcfb.c).

Wouldn't it be better to move the domain information into the platform
data of the above platform device and then deal with the attach to the
genpd from the sh_mobile_lcdc_driver?

In this way, the behaviour would be more consistent with others
probe/attach to genpd - and $subject patch would not be needed.

>  }
>  #else
>  static inline int board_staging_add_dev_domain(struct platform_device *pdev,
> --
> 2.25.1
>

Kind regards
Uffe
