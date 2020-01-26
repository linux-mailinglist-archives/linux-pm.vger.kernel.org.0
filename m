Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CABBE149AD4
	for <lists+linux-pm@lfdr.de>; Sun, 26 Jan 2020 14:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgAZNdK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Jan 2020 08:33:10 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43354 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgAZNdJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jan 2020 08:33:09 -0500
Received: by mail-vk1-f196.google.com with SMTP id m195so669541vkh.10
        for <linux-pm@vger.kernel.org>; Sun, 26 Jan 2020 05:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=emKfjakMK0JQ5BS5YCFkbZaOfKcUBqnq7Vw1qMXzarA=;
        b=ai+SUiF/UB+ocFDZG4bWX3gairRXyO3KEZs3g3zkaG+2pYyYWK3fd9bt+E7Rar+SD4
         EIwg+XvovGF4K2Odgt+HUesXodKNd95varMryoGJqOHTWZQOv6S1c9horPbB6zQHQUFj
         z9zcOiYdUC0xWDGg/8FTElf80uvRJry+UUYvrQXpXo/t3fWys/BSnSQ76GW5zuNCsO1l
         pZM6EFHBmDXPG3u5Ed5vydQglmNUzoQYPbUyeuzEM07UGxpDHAax8tnbup1DAOHP7Yde
         /cxPg5ADJdZmZUlDdaVtddv2qRPpZENEBJutlRleqIojB4JNHjUkH8vvrlvOeC3MPHmZ
         7vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=emKfjakMK0JQ5BS5YCFkbZaOfKcUBqnq7Vw1qMXzarA=;
        b=KVqwSzTPMvSm8iW/8gkb9E3Xy+1UxbiJuC2QNfqh6Kw9VzbVQMQRG1xLJ04SsEgjzM
         km7NViqGMcL2eiiH9vys5oDPvWuhedMsfdyAvGSF/0ulkTWnZWfqWOQ3WQ8UsYzxofrN
         zncEWA7SP9sSB+loL6tYJUJUrFWCqIdQTfK6FznlIV/+oBCvYKKJYyRxOVxvkLGa/1FB
         XXfn6XIruxmrcvVtQPV4ZAE+4bsaapmD5HtufEc++I/rEFF1b6TaqN+xdD53kwvfpc1F
         CEGharTmdSK+9Til+80SV1V3JCtjnnNEjMTI8EH0rYvVWBtn1770Qmy75BkMFqb0H84C
         v/7A==
X-Gm-Message-State: APjAAAW/wn3XnCoM7mYTT+YpVxpWIvCPNi6uw2jGP6GrA96NCpjRTTFy
        2ubAhcPSEFQ7bAvrTsOlOncqZ7i1HkSJYpVpQ0OCAg==
X-Google-Smtp-Source: APXvYqwbEI5BxpWOjvqHw3OF1B1QFbz8m5/83C3fLpV6wDo9RxMYmlGUd3KSZPynqahIUdu2vYZLu7TpEP7jm7Xn4b4=
X-Received: by 2002:ac5:cd8c:: with SMTP id i12mr5971417vka.100.1580045588469;
 Sun, 26 Jan 2020 05:33:08 -0800 (PST)
MIME-Version: 1.0
References: <20200124132957.15769-1-geert+renesas@glider.be> <20200124132957.15769-3-geert+renesas@glider.be>
In-Reply-To: <20200124132957.15769-3-geert+renesas@glider.be>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sun, 26 Jan 2020 15:32:50 +0200
Message-ID: <CAOtvUMdA2aD9DJBmSpOJOFRw=1_9OcaG4Y915q5L7dgo7n7HTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: ccree - fix debugfs register access while suspended
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Bin Liu <b-liu@ti.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 24, 2020 at 3:30 PM Geert Uytterhoeven
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
>     -e6601000.crypto/regs:HOST_IRR =3D 0x00000260
>     -e6601000.crypto/regs:HOST_POWER_DOWN_EN =3D 0x00000260
>     +e6601000.crypto/regs:HOST_IRR =3D 0x00000038
>     +e6601000.crypto/regs:HOST_POWER_DOWN_EN =3D 0x00000038
>      e6601000.crypto/regs:AXIM_MON_ERR =3D 0x00000000
>      e6601000.crypto/regs:DSCRPTR_QUEUE_CONTENT =3D 0x000002aa
>     -e6601000.crypto/regs:HOST_IMR =3D 0x00000260
>     +e6601000.crypto/regs:HOST_IMR =3D 0x017ffeff
>      e6601000.crypto/regs:AXIM_CFG =3D 0x001f0007
>      e6601000.crypto/regs:AXIM_CACHE_PARAMS =3D 0x00000000
>     -e6601000.crypto/regs:GPR_HOST =3D 0x00000260
>     +e6601000.crypto/regs:GPR_HOST =3D 0x017ffeff
>      e6601000.crypto/regs:AXIM_MON_COMP =3D 0x00000000
>     -e6601000.crypto/version:SIGNATURE =3D 0x00000260
>     -e6601000.crypto/version:VERSION =3D 0x00000260
>     +e6601000.crypto/version:SIGNATURE =3D 0xdcc63000
>     +e6601000.crypto/version:VERSION =3D 0xaf400001
>
> Note that this behavior is system-dependent, and the issue does not show
> up on all R-Car Gen3 SoCs and boards.  Even when the device is
> suspended, the module clock may be left enabled, if configured by the
> firmware for Secure Mode, or when controlled by the Real-Time Core.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/crypto/ccree/cc_debugfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/crypto/ccree/cc_debugfs.c b/drivers/crypto/ccree/cc_=
debugfs.c
> index 5669997386988055..35f3a2137502bd96 100644
> --- a/drivers/crypto/ccree/cc_debugfs.c
> +++ b/drivers/crypto/ccree/cc_debugfs.c
> @@ -81,6 +81,7 @@ int cc_debugfs_init(struct cc_drvdata *drvdata)
>         regset->regs =3D debug_regs;
>         regset->nregs =3D ARRAY_SIZE(debug_regs);
>         regset->base =3D drvdata->cc_base;
> +       regset->dev =3D dev;
>
>         ctx->dir =3D debugfs_create_dir(drvdata->plat_dev->name, cc_debug=
fs_dir);
>
> @@ -102,6 +103,7 @@ int cc_debugfs_init(struct cc_drvdata *drvdata)
>                 verset->nregs =3D ARRAY_SIZE(pid_cid_regs);
>         }
>         verset->base =3D drvdata->cc_base;
> +       verset->dev =3D dev;
>
>         debugfs_create_regset32("version", 0400, ctx->dir, verset);
>
> --
> 2.17.1
>


Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Thanks,
Gilad
--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
