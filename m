Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6970F14EA7C
	for <lists+linux-pm@lfdr.de>; Fri, 31 Jan 2020 11:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgAaKLl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 Jan 2020 05:11:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39327 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728160AbgAaKLl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jan 2020 05:11:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so6075430oty.6;
        Fri, 31 Jan 2020 02:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSq/O5z4OiKt2gIxWlmYXDdfWXOXBwGpqYL0q2hrwZQ=;
        b=hfxHnOabjLtHmshzS23bvfpf6uonOdaofUKFUkaVj5ngOjGYLfQ8VPomyRR76zQclQ
         4IhWIphL2avzbuhgaHKVm2gPD/eh1F9STX5LKAKQV+yWFLGa7x4izC0H1svzeNNLH3QS
         H5wcnDKJZ0jRx6MTwY7CQy1tcav8wO2pvp4ZGJTwSpdWyiQS9Rb/wpYAYwJVPxomSNjD
         D3HwopchQJ4sd2Z57vy0Vv12D3VK3Vi7VP4KbtW2fmd0JZ/hF6JpnnKgwDd/NAGoLOO2
         N1MR4eGOLUNMD4T23f8jpAGfTocYvOkZq6cpSU+pZqdtC2ESVDgoIkx8ABgOMm77peCk
         5SXQ==
X-Gm-Message-State: APjAAAU7fAoTAh5EFhxb+sDvC9prRU3ibipRaBk5qoi4Ae+6zxI/hKln
        iVfhukU4T7u5rYcoWUC47SzvHceDW2XrsWnOMdo=
X-Google-Smtp-Source: APXvYqzvE5/+Pbp+3XgX3B4B6R/3TqiKaD+1/9bs8HNzUkgVsARShDsPlW5lSa4ht2ZHeJy9a0d6wVgWmSFh7YrtAg8=
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr7192372otn.262.1580465499703;
 Fri, 31 Jan 2020 02:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20200124132957.15769-1-geert+renesas@glider.be> <20200124132957.15769-3-geert+renesas@glider.be>
In-Reply-To: <20200124132957.15769-3-geert+renesas@glider.be>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Jan 2020 11:11:28 +0100
Message-ID: <CAJZ5v0hqzs1GaJ+qs=8DHhe-zK4QSNGJiKn1B9qsp0jcK3pSuQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: ccree - fix debugfs register access while suspended
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, linux-crypto@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 24, 2020 at 2:30 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Reading the debugfs files under /sys/kernel/debug/ccree/ can be done by
> the user at any time.  On R-Car SoCs, the CCREE device is power-managed
> using a moduile clock, and if this clock is not running, bogus register
> values may be read.
>
> Fix this by filling in the debugfs_regset32.dev field, so debugfs will
> make sure the device is resumed while its registers are being read.
>
> This fixes the bogus values (0x00000260) in the register dumps on R-Car
> H3 ES1.0:
>
>     -e6601000.crypto/regs:HOST_IRR = 0x00000260
>     -e6601000.crypto/regs:HOST_POWER_DOWN_EN = 0x00000260
>     +e6601000.crypto/regs:HOST_IRR = 0x00000038
>     +e6601000.crypto/regs:HOST_POWER_DOWN_EN = 0x00000038
>      e6601000.crypto/regs:AXIM_MON_ERR = 0x00000000
>      e6601000.crypto/regs:DSCRPTR_QUEUE_CONTENT = 0x000002aa
>     -e6601000.crypto/regs:HOST_IMR = 0x00000260
>     +e6601000.crypto/regs:HOST_IMR = 0x017ffeff
>      e6601000.crypto/regs:AXIM_CFG = 0x001f0007
>      e6601000.crypto/regs:AXIM_CACHE_PARAMS = 0x00000000
>     -e6601000.crypto/regs:GPR_HOST = 0x00000260
>     +e6601000.crypto/regs:GPR_HOST = 0x017ffeff
>      e6601000.crypto/regs:AXIM_MON_COMP = 0x00000000
>     -e6601000.crypto/version:SIGNATURE = 0x00000260
>     -e6601000.crypto/version:VERSION = 0x00000260
>     +e6601000.crypto/version:SIGNATURE = 0xdcc63000
>     +e6601000.crypto/version:VERSION = 0xaf400001
>
> Note that this behavior is system-dependent, and the issue does not show
> up on all R-Car Gen3 SoCs and boards.  Even when the device is
> suspended, the module clock may be left enabled, if configured by the
> firmware for Secure Mode, or when controlled by the Real-Time Core.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

LGTM:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/crypto/ccree/cc_debugfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/crypto/ccree/cc_debugfs.c b/drivers/crypto/ccree/cc_debugfs.c
> index 5669997386988055..35f3a2137502bd96 100644
> --- a/drivers/crypto/ccree/cc_debugfs.c
> +++ b/drivers/crypto/ccree/cc_debugfs.c
> @@ -81,6 +81,7 @@ int cc_debugfs_init(struct cc_drvdata *drvdata)
>         regset->regs = debug_regs;
>         regset->nregs = ARRAY_SIZE(debug_regs);
>         regset->base = drvdata->cc_base;
> +       regset->dev = dev;
>
>         ctx->dir = debugfs_create_dir(drvdata->plat_dev->name, cc_debugfs_dir);
>
> @@ -102,6 +103,7 @@ int cc_debugfs_init(struct cc_drvdata *drvdata)
>                 verset->nregs = ARRAY_SIZE(pid_cid_regs);
>         }
>         verset->base = drvdata->cc_base;
> +       verset->dev = dev;
>
>         debugfs_create_regset32("version", 0400, ctx->dir, verset);
>
> --
> 2.17.1
>
