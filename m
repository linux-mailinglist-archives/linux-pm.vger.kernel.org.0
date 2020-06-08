Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF421F17EC
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jun 2020 13:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgFHLi0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jun 2020 07:38:26 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:37378 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgFHLi0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2020 07:38:26 -0400
Received: by mail-oo1-f67.google.com with SMTP id q188so3387938ooq.4;
        Mon, 08 Jun 2020 04:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AiShaBk5DF8yJr8mCXeHyaoG4bYVbbRWHsXx0u1WEtU=;
        b=V7WnzTV1kd7CrK86kOcIqFOweGzqSHDOpR48C2qK4zj1PsQlcW6W0T51XrTL2gA03W
         6IwyFH8snMfqwZ4IDi73C4sMEpmfsmY6pAejh/+uXeWGWtDmrG3UQbbTvNUhEtoXtJQo
         VndPN41tRwABJoXGm2tHWWCnG+Ig72dUFcZ8JbMbE1tbPz9+ds6pw1J/l6Quv9NI17dh
         nCQcbXO43LNnoulaTmX0OuNdsqbBSDFuOLnG7k6dmRnA2o7RY82gCrnWZcNRcuHXvhBt
         jj2zJJkJlHQjuH4evFDqBJQCcx9qL6wlSe1WychL65C3u0afpfSGjnEawf4rG9t8ZLHr
         q6Ng==
X-Gm-Message-State: AOAM531OsHlOarEDJKQx+aFmAzyNHXKdvTUHpBGGGV4/AiKBOCehpkmB
        JiXoRcBW2vIbEf6S/65UIaVywhE9k8jW0+fCNSs=
X-Google-Smtp-Source: ABdhPJyCMTABEDVdv5hJ2Q1huzrZFzk/SkHxERmtXEWTrMjSXi7dTcSE7kx1P19B+Lzj+wDegxkLJeWgL5VXetS1NvQ=
X-Received: by 2002:a4a:5744:: with SMTP id u65mr16876209ooa.1.1591616305143;
 Mon, 08 Jun 2020 04:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <1591614776-20333-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1591614776-20333-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Jun 2020 13:38:13 +0200
Message-ID: <CAMuHMdXT0qofW38-g79TSiy1nUBhrWNPfbViKRyWSFdme=oD0g@mail.gmail.com>
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Fix undefined temperature if negative
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Dien Pham <dien.pham.ry@renesas.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>, van.do.xw@renesas.com,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Shimoda-san, Pham-san,

On Mon, Jun 8, 2020 at 1:13 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> From: Dien Pham <dien.pham.ry@renesas.com>
>
> As description for DIV_ROUND_CLOSEST in file include/linux/kernel.h.
>   "Result is undefined for negative divisors if the dividend variable
>    type is unsigned and for negative dividends if the divisor variable
>    type is unsigned."
>
> In current code, the FIXPT_DIV uses DIV_ROUND_CLOSEST but has not
> checked sign of divisor before using. It makes undefined temperature
> value in case the value is negative.
>
> This patch fixes to satisfy DIV_ROUND_CLOSEST description
> and fix bug too.
>
> Signed-off-by: Van Do <van.do.xw@renesas.com>
> Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
> [shimoda: minor fixes, add Fixes tag]
> Fixes: 564e73d283af ("thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Thanks for your patch!

> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -167,7 +167,7 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
>  {
>         struct rcar_gen3_thermal_tsc *tsc = devdata;
>         int mcelsius, val;
> -       u32 reg;
> +       long reg;

"long" is 64-bit, so "int" should be sufficient.

>         /* Read register and convert to mili Celsius */
>         reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;

However, rcar_gen3_thermal_read() does return u32, so keeping u32 for
reg looks more logical to me.

Successive lines are:

        if (reg <= thcode[tsc->id][1])
                val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b1,
                                tsc->coef.a1);
        else
                val = FIXPT_DIV(FIXPT_INT(reg) - tsc->coef.b2,
                                tsc->coef.a2);

Perhaps it's safer to add an cast to FIXPT_INT(), so it always returns
int, and/or add casts to FIXPT_DIV(), so only signed values are passed
to DIV_ROUND_CLOSEST?
That would prevent the issue from reappearing later.

BTW, rcar_gen3_thermal_mcelsius_to_temp() returns a value to store in a
register, hence I think it should return u32 instead of int.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
