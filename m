Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D0E181847
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 13:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgCKMlA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 11 Mar 2020 08:41:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36754 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbgCKMlA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 08:41:00 -0400
Received: by mail-ot1-f68.google.com with SMTP id j14so1765989otq.3;
        Wed, 11 Mar 2020 05:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yj4Nx0/CVzLY4fpmrOCRUMalrx5ITd/SRiFE3/OjJHc=;
        b=rIVIsSoHa+E4juUmIDwUtFuelKf4FdovUq/NLyMKIrWAw8v/Pv3I2+B8OOg4s+6oJY
         CNEXpWFXUwUBDaBlMj+dxQxOfFsoIMPx2NBMfq8xUIoe5dJjycXtq9QnOaRYM8GuA6iY
         RSJyDX2cCQxy/O5YT5gNf3ORdlWlm5Q+xHSbgO/w7xJ1IDC5sztvt9+x2CXwPcpMRIXe
         +EwWiFD3CGbG7FgPwzXvYdoM82WWbqcs1DUKdFYCV0Mw7pJBfJ3+/HmOl9Yjy0NDwgPr
         lwgwsTvkSwy1j72do6ypeEURjoDQ4fU6eBZkVMIk3XdgXaxqXsVaOgTRVZ0QNokrbXlW
         kXXA==
X-Gm-Message-State: ANhLgQ2tXv9o2Z0e8puEpUmys2NTKNQJ6pCHJoCekbPP7LjtOJ2TbMKr
        jKX0XsrPZndNd2BDbU44DJ4mMtfhNYYC3Wpqi7M=
X-Google-Smtp-Source: ADFU+vt99nzelep3IzGKDxfX9iNny0uS9Fps1Tj4PAlyiuv7FresiGQBnB7K8mnmNqWoqg4qrV8fPG7iTpkMjCwCsXM=
X-Received: by 2002:a9d:4d02:: with SMTP id n2mr2063525otf.107.1583930457460;
 Wed, 11 Mar 2020 05:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200310170029.1648996-1-niklas.soderlund+renesas@ragnatech.se> <20200310170029.1648996-3-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20200310170029.1648996-3-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Mar 2020 13:40:46 +0100
Message-ID: <CAMuHMdU8VUf9deXmpSD=P9TQEL0s0xspHW2BdTtS=o-ZsFzGOw@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: rcar_thermal: Do not store ctemp in rcar_thermal_priv
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Tue, Mar 10, 2020 at 6:02 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> There is no need to cache the ctemp value in the private data structure
> as it's always prefetched before it's used. Remove it from the structure
> and have rcar_thermal_update_temp return the value instead of storing
> it.
>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One suggestion below...

> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -201,7 +200,6 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
>         struct device *dev = rcar_priv_to_dev(priv);
>         int i;
>         u32 ctemp, old, new;
> -       int ret = -EINVAL;

It might make sense to change ctemp to int, and preinitialize it to
-EINVAL...

>
>         mutex_lock(&priv->lock);
>
> @@ -247,32 +245,28 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
>                                                    ((ctemp - 1) << 0)));
>         }
>
> -       dev_dbg(dev, "thermal%d  %d -> %d\n", priv->id, priv->ctemp, ctemp);
> -
> -       priv->ctemp = ctemp;
> -       ret = 0;
>  err_out_unlock:
>         mutex_unlock(&priv->lock);
> -       return ret;
> +
> +       return ctemp ? ctemp : -EINVAL;

... so you can just return ctemp here.

>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
