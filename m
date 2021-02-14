Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDDB31AEB5
	for <lists+linux-pm@lfdr.de>; Sun, 14 Feb 2021 03:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhBNB7l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Feb 2021 20:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBNB7k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Feb 2021 20:59:40 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45205C0613D6
        for <linux-pm@vger.kernel.org>; Sat, 13 Feb 2021 17:59:00 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id o31so1272060uae.2
        for <linux-pm@vger.kernel.org>; Sat, 13 Feb 2021 17:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ixeWtkGZms2jqEPuipL0eImgJeTeZ0ddYDeZic7MgQ=;
        b=FncMT/GvGAc/EsdPfqvKoM9XNHSxs+pjuWH41t8zU5Kg0ah1J4kXkiQfKFmtCiwtNh
         aaZuIMeVc3qALvPLqyg1iedXNqMds7nnIHMAHaAHtmfWZVW+BPtKXnNL8Vz1XIfa6Abk
         56EQYlBSF42HXLn5XpStNIxJAknDvUZtB/D6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ixeWtkGZms2jqEPuipL0eImgJeTeZ0ddYDeZic7MgQ=;
        b=LTAy92jkn1WqxAiNS+jrzXiK2HJR7YMdokPBId++k4RXZjzJ2PoN828eJzhmKbvoZc
         NxLPfi73mxKatQ6KocnRiCQph/vgPhfeQ9+6T1qg4WITWEeolNoYaVWPuLiJ81sI3zyq
         wRpLgKHhQh+Ap/UCG/+LXkj1eqwEszD3/qeuojX6PahriWCZcmzxbFI/c6mgCZJgZdMQ
         maS5GEhkBfXK6eLyxfpFLEQYh5a6VkHxMSzEbCI9yHCYMdOVuDD5P6gLOjiJwLuW77Cu
         hbvPrrKQThS/iCf4MEf8qamD1KgjeaNjIkMXJ6qwRkz/0WqYEQfeZ3QxLIfhXPwNXEyr
         DakA==
X-Gm-Message-State: AOAM531/pK3MkifKofTFRpwdgW6hfSTzlITr2Lc/0FiRGrbJLR94ogsY
        FW/hkZ6zEFzgqpXUf5o8113ARFDxm4s3GDABb41IVg==
X-Google-Smtp-Source: ABdhPJyoBmJ7jwKAGqVcrzAOq50zvV6KWZm+xllaqflJaAKZU8l5lkgyKY/T9PH8CRPdqVqIBQm9Ix+HOUvSzxYHOr8=
X-Received: by 2002:ab0:2e9b:: with SMTP id f27mr1582267uaa.74.1613267939297;
 Sat, 13 Feb 2021 17:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20210129093010.22909-1-michael.kao@mediatek.com> <20210129093010.22909-3-michael.kao@mediatek.com>
In-Reply-To: <20210129093010.22909-3-michael.kao@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sun, 14 Feb 2021 09:58:48 +0800
Message-ID: <CANMq1KA-a1RQ=85w=sxJP8PfVfovx6Tscsuxf_vZpFqdxGc0=g@mail.gmail.com>
Subject: Re: [v2,2/3] thermal: mediatek: Add LVTS drivers for SoC theraml zones
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Fan Chen <fan.chen@mediatek.com>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 29, 2021 at 5:40 PM Michael Kao <michael.kao@mediatek.com> wrote:
>
> Add a LVTS (Low voltage thermal sensor) driver to report junction
> temperatures in Mediatek SoC and register the maximum temperature
> of sensors and each sensor as a thermal zone.
>
> Signed-off-by: Yu-Chia Chang <ethan.chang@mediatek.com>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  drivers/thermal/mediatek/Kconfig         |   10 +
>  drivers/thermal/mediatek/Makefile        |    1 +
>  drivers/thermal/mediatek/soc_temp_lvts.c | 1287 ++++++++++++++++++++++
>  drivers/thermal/mediatek/soc_temp_lvts.h |  312 ++++++
>  4 files changed, 1610 insertions(+)
>  create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.c
>  create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.h
>
> [snip]
> diff --git a/drivers/thermal/mediatek/Makefile b/drivers/thermal/mediatek/Makefile
> index f75313ddce5e..16ce166e5916 100644
> --- a/drivers/thermal/mediatek/Makefile
> +++ b/drivers/thermal/mediatek/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_MTK_SOC_THERMAL)  += soc_temp.o
> +obj-$(CONFIG_MTK_SOC_THERMAL_LVTS)     += soc_temp_lvts.o
> diff --git a/drivers/thermal/mediatek/soc_temp_lvts.c b/drivers/thermal/mediatek/soc_temp_lvts.c
> new file mode 100644
> index 000000000000..b56c2cd3cb39
> --- /dev/null
> +++ b/drivers/thermal/mediatek/soc_temp_lvts.c
> @@ -0,0 +1,1287 @@
> [snip]
> +
> +static unsigned int lvts_temp_to_raw(struct formula_coeff *co, int temp)
> +{
> +       unsigned int msr_raw;
> +
> +       msr_raw = ((long long)((co->golden_temp * 500 + co->b - temp)) << 14)
> +               / (-1 * co->a);

This fails to build test on arm (32-bit):
ERROR: "__aeabi_ldivmod" [drivers/thermal/mediatek/soc_temp_lvts.ko] undefined!

Recommend using div_s64:
   msr_raw = div_s64((s64)((co->golden_temp * 500 + co->b - temp)) << 14,
                     -1 * co->a);

> +
> +       return msr_raw;
> +}
> [snip]
