Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0FA3BE9F2
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhGGOpC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Wed, 7 Jul 2021 10:45:02 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:45802 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhGGOpC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 10:45:02 -0400
Received: by mail-vs1-f53.google.com with SMTP id h5so1683144vsg.12;
        Wed, 07 Jul 2021 07:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E2lhPQvu4vBJKz05mCYuAwIVW7GnBtboKvF9BqYEEuU=;
        b=RQB8+7DvhkkzZyNRLoNDjOHSyR7MnGQkYXVNkMouYyY6+MkpbqhS0jvYD5/ybBel1b
         5TnpIcEUi34tm5GC2JDeY/Xhu77QgwmNynQVjBiB7c/z70eEJ3kx1p5EodmEkXcWzoAd
         SVwlMq6ANW3rBmK51nOEvASQegKiAqrhRkun1qmFifKh8M95m+Owp150hnBThYhO1pBg
         uJKfeE8u8C2nOkVm1RLhiCrMepdiui+dtCWpiCaWJ+gm7hG41AmXhrJEFSBtPcNzpO/5
         rPtoMPBADTBoh+TgyTDAZaBL3wcP7SPyE8zzDOGOpnLc2/Hp5cA6iLgmU8FMjozgZjNb
         M63A==
X-Gm-Message-State: AOAM531LiZGO4MqqLneQtCEGJImuSltC2bpIaAMWMQvPsPqRbFfwnMWM
        74/Ca3LCHNzK6ITX77DdQQsrzXMNpxYaaf9NAGU=
X-Google-Smtp-Source: ABdhPJyrlRVbhC/e3+KUntn7IIgtsCv/IuTl76VgxuK7zyojigXf80Tb0g+1k38FKaQ7vXPAIpWNU7hYj+f/hzlpkPQ=
X-Received: by 2002:a67:d012:: with SMTP id r18mr13635363vsi.3.1625668941369;
 Wed, 07 Jul 2021 07:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210707131306.4098443-1-niklas.soderlund+renesas@ragnatech.se> <20210707131306.4098443-4-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20210707131306.4098443-4-niklas.soderlund+renesas@ragnatech.se>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Jul 2021 16:42:10 +0200
Message-ID: <CAMuHMdUx19uGTX3nddkODwdzLeSGuZbuyac7VMitZv=1tgyPSg@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal: rcar_gen3_thermal: Fix datatype for loop counter
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Niklas,

Thanks for your patch!

On Wed, Jul 7, 2021 at 3:14 PM Niklas Söderlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The loop counter 'i' should be unsigned int to match struct
> rcar_gen3_thermal_priv num_tscs where it's stored.

It is also stored in rcar_gen3_thermal_tsc.id, which is still (signed) int.

> --- a/drivers/thermal/rcar_gen3_thermal.c
> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -423,7 +423,8 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>         struct resource *res;
>         struct thermal_zone_device *zone;
> -       int ret, i;
> +       unsigned int i;
> +       int ret;
>
>         /* default values if FUSEs are missing */
>         /* TODO: Read values from hardware on supported platforms */

And perhaps:

-                dev_info(dev, "TSC%d: Loaded %d trip points\n", i, ret);
+                dev_info(dev, "TSC%u: Loaded %d trip points\n", i, ret);

?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
