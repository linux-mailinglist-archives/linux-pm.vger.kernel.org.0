Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B270320998A
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jun 2020 07:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389330AbgFYFjr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jun 2020 01:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgFYFjq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 01:39:46 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813FAC0613ED
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 22:39:44 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 190so2862683vsr.9
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2020 22:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o28OKWhut3HMZUNak3zVCQQ2sG33LP10e/q4/9mCjjU=;
        b=OVoN5D3AuxHuRoYyBfsVLSXggFgoB6QKM3U/ng0NMFEAOCfW6En5Y607igX1dtKER5
         xcTkmzawii/n8qLs98ObXRKQHXTVoiWnDLrWEf3cahlWztlCcAQm5pr19D7apP7YtpCz
         DLZT34RY7ckLf0AYxyMSYefBOAok8NRP6pAkKKeKhmyzenP0TFmyFfHLVEYfvnpg2Biy
         y4Xe5273d4MO66k96MKCpyRV/6S5lK/6js9TqNATeWzAuZriFhaTkTCO0kBARdONXIGv
         9QyYZsZDLyR0PY1OX7h7Gj5haAxl35t7vIgnWGj/PAX0ASoE9NpfsOfMf88TKhUgq0y8
         kLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o28OKWhut3HMZUNak3zVCQQ2sG33LP10e/q4/9mCjjU=;
        b=ckSIveXfDjUQl4CmhwLmloP27N00IRZAGjxPrdt/7IW9Vw//so78WRPLeMcdIHZs7T
         ZNl1MWxlHXty8XkpsTjpvA297cm3tpmyMMXdFVG1qb1+wLWE7gOTouzeVAW7FdjMqNdP
         kvqtMpjcQ7NdTui+d6C493fqMB2d2gwqYCU4sNwzVsiMaAEEYdcVKQmXgyCHDKo5Ffn8
         VHDfDc9n0qlt3WfKjGNebsfKjLfHg72VS0DMivhcQk7IyExbgMRNQ7PB1a6bEvpbM6CY
         kXP6/FgniTcgsvwS89byX1yET8TS+vWkqmvOVeRCPk5IRa1hvOgUPMzZiHrNDihEE7nr
         toIQ==
X-Gm-Message-State: AOAM531oD+VjkRT0tk83yDYneh1hzDvsBDoXagIKbHpZXOI/aAU3qFlf
        nqvEdGNjrLHUmlOfqgaPboWtV3/QKPsAVoDZShFIZR3ELrs=
X-Google-Smtp-Source: ABdhPJyTlY7jwgUEWV9OEdRju7FpA70X4je+OIpMIigFxv49EwgS3i3w0TK8ujenkmyUpjWly8v8UcNA3fYb/1xeObc=
X-Received: by 2002:a67:e19d:: with SMTP id e29mr27147880vsl.9.1593063583338;
 Wed, 24 Jun 2020 22:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <1593053768-31016-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1593053768-31016-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 25 Jun 2020 11:09:32 +0530
Message-ID: <CAHLCerNaq_sytBYSUqZjyoP0gg8FbdK08pKSf1-zcv+UN7dUTg@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: rcar_gen3_thermal: Fix undefined temperature
 if negative
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        niklas.soderlund+renesas@ragnatech.se, van.do.xw@renesas.com,
        dien.pham.ry@renesas.com, Linux PM list <linux-pm@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 25, 2020 at 8:26 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
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
> and fix bug too. Note that the variable name "reg" is not good
> because it should be the same type as rcar_gen3_thermal_read().
> However, there is better to rename it in a further patch as
> cleanup.
>
> Signed-off-by: Van Do <van.do.xw@renesas.com>
> Signed-off-by: Dien Pham <dien.pham.ry@renesas.com>
> [shimoda: minor fixes, add Fixes tag]
> Fixes: 564e73d283af ("thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver")
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>
> Tested-by: Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  Changes from v2:
>  - Add Niklas-san's Reviewed-by and Tested-by.
>  - Keep the variable name "reg" and revise the commit description for it.
>  https://patchwork.kernel.org/patch/11595327/
>
>  Changes from v1:
>  - Use int instead of long.
>  - Rename "reg" with "ctemp".
>  https://patchwork.kernel.org/patch/11593051/
>
>  drivers/thermal/rcar_gen3_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> index 58fe7c1..c48c5e9 100644
> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -167,7 +167,7 @@ static int rcar_gen3_thermal_get_temp(void *devdata, int *temp)
>  {
>         struct rcar_gen3_thermal_tsc *tsc = devdata;
>         int mcelsius, val;
> -       u32 reg;
> +       int reg;
>
>         /* Read register and convert to mili Celsius */
>         reg = rcar_gen3_thermal_read(tsc, REG_GEN3_TEMP) & CTEMP_MASK;
> --
> 2.7.4
>
