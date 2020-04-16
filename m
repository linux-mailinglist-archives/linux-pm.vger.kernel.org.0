Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5547B1ABAF0
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 10:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441245AbgDPIQx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Thu, 16 Apr 2020 04:16:53 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35609 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441174AbgDPIQm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2020 04:16:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id b7so13346072oic.2;
        Thu, 16 Apr 2020 01:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tPX2HnPqzUvvNO4rAsIvdunmOvZ+H+heasUYTIwn1Ps=;
        b=CJOP10V+sR0oslqpLljgdTGQGx/7WbZCODYhyi4U7Klt+frywKgyfmMsq2DaB9pH0T
         Q/+9MtzbeTirjB4q+htS8vVir6SbZcuNEPOZb4ZmcGO6yvNy34eWQUBkcm+iYsAh/6Ze
         Uvc9MrGXOlpZ1l6nM3uOBkNnEGa1iKSOoULb7D5Nedc4RAZ0GSM9ESA6exfMu1paSA0x
         D4c8htF9+b6S3+BqLRhmkfci6GXnrPrtyOt3IviUBT21pmnJAWh3DSKbe7T6Po0fsXJw
         oWu5aZJZG3YVeOpMHBrlUhwnAz6QsndafvBpN57mChZRUtu6mtypAulFiZ6fuAgyJ4df
         U/Vg==
X-Gm-Message-State: AGi0PuboAnXNFu7/RyO5GomOhkxGeRt3IoJfFMfkz+xvHB6qv7dZ+wLJ
        shgvH3KYNhDLJ+VxVf2NvfAB6cmGAHk9+yrYf5HCQQ==
X-Google-Smtp-Source: APiQypLGClCjRSG/OnKGSCXGjMDFiMcEyS/VL6hXUZZxt7tHSzKXwZ3QhHtaPkASodp0E75GswIzQh40lhnZAMigB5c=
X-Received: by 2002:aca:cdd1:: with SMTP id d200mr2057747oig.153.1587025001019;
 Thu, 16 Apr 2020 01:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200415172349.2185096-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20200415172349.2185096-1-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Apr 2020 10:16:29 +0200
Message-ID: <CAMuHMdWpskYLe59XgVOyBnCMzQdYg+TBXQqcaVQ8y2rPRskrWg@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_thermal: Clean up rcar_thermal_update_temp()
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

On Wed, Apr 15, 2020 at 7:23 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> Moving the ctemp variable out of the private data structure made it
> possible to clean up rcar_thermal_update_temp(). Initialize the local
> ctemp to the error code to return if the reading fails and just return
> it at the end of the function.
>
> It's OK to change the datatype of old, new and ctemp to int as all
> values are AND with CTEMP (0x3f) before being stored. While at it

ANDed

> change the datatype of the loop variable 'i' to to unsigned int.
>
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

One small suggestion below.

> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -198,8 +198,8 @@ static void _rcar_thermal_bset(struct rcar_thermal_priv *priv, u32 reg,
>  static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
>  {
>         struct device *dev = rcar_priv_to_dev(priv);
> -       int i;
> -       u32 ctemp, old, new;
> +       int old, new, ctemp = -EINVAL;
> +       unsigned int i;
>
>         mutex_lock(&priv->lock);
>
> @@ -209,7 +209,6 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
>          */
>         rcar_thermal_bset(priv, THSCR, CPCTL, CPCTL);
>
> -       ctemp = 0;
>         old = ~0;
>         for (i = 0; i < 128; i++) {
>                 /*
> @@ -227,7 +226,7 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
>                 old = new;
>         }
>
> -       if (!ctemp) {
> +       if (ctemp == -EINVAL) {

I think "if (ctemp < 0)" is safer, as it doesn't rely on the actual error code.

>                 dev_err(dev, "thermal sensor was broken\n");
>                 goto err_out_unlock;
>         }
> @@ -248,7 +247,7 @@ static int rcar_thermal_update_temp(struct rcar_thermal_priv *priv)
>  err_out_unlock:
>         mutex_unlock(&priv->lock);
>
> -       return ctemp ? ctemp : -EINVAL;
> +       return ctemp;
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
