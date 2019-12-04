Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 219F9112598
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 09:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLDInT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 03:43:19 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45976 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfLDInT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 03:43:19 -0500
Received: by mail-vs1-f67.google.com with SMTP id l24so4291541vsr.12
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 00:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+SZ9v7OkVrvJ6QaeG0oUf8yqDKkUw0TZlHMsxgTeAUg=;
        b=ozY/oy0LhPGAUReBjMed9tUWjdzGs68C98eMHleym7NGLw8mo6pEaKKTLUZRQlU3wM
         +2W9d3lE1B7K/VuDG4b06EE35ZprZsnEbnH+7MJU3sX1xgP1UBM9zxaVXY+3tyipy47e
         05R1f3cM8PLGhyXRKl9aPrapV8tcWSrLv8spXMyuXDx3rRb/UP2b9Qon7i2pDqAFVMC7
         q1T3/mgZWgR6MSBodZk5NOE6AL2VT8wrgq+PvXEsS0QV++4L/IHPuWjvfkd9ZponSZsW
         b+cjKPBB8iCGMrq9wPVv9zEF5gccNe6DUV9D5QEGixoQ5b1JV7QSFwBdNxsVX1P/N6YA
         Kg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+SZ9v7OkVrvJ6QaeG0oUf8yqDKkUw0TZlHMsxgTeAUg=;
        b=HQnFp7Bj2rXJVqEMvkEmrzSFYE5GHsNuMmiZXrM1WZgDnAkdloKH1za3FX+4Bn6KJA
         5HQZULp0PZwolIrdJsa7DEXZaJtJ67EBO/kmkolsj4suV6Eui1Pl2PS+bJNJroDNjt7F
         A1wdE2U9ZgcpjC9bBBc0WAA/jHcBGFK6NYD84AOkJZxbYb1tSZayPIy37KCImuHW1t9N
         JRZKJ3C+FDzX5rKhg3E9rinksdyaywcGhq9s+QL6JAEumUG2XWFWWkTEJj6ofEX88iTr
         4+Qgvw043NpVVgKKkfuoO9JXF8fZzIYK846+yRZlUkMrI3xokKu2hAfpglGSmwku6I8+
         xEvA==
X-Gm-Message-State: APjAAAV7QcHcZ7IyPR+ijHVUzLQdCLTcuX9EpY4R7KRMxNVWriThQDf3
        0dIkWqWcc0LNoKwNnQoZm3f09kk69xTjRXBKlC48pA==
X-Google-Smtp-Source: APXvYqx74HU73kauUE3SN4x1GqN1piIReRrm6swkZnGHfssEu+YGONU15Um7fno0NFMP5mtYDaI+4iR27mqk+Wu+ryU=
X-Received: by 2002:a67:f496:: with SMTP id o22mr879529vsn.9.1575448997829;
 Wed, 04 Dec 2019 00:43:17 -0800 (PST)
MIME-Version: 1.0
References: <20191030182132.25763-1-f.fainelli@gmail.com> <20191030182132.25763-5-f.fainelli@gmail.com>
In-Reply-To: <20191030182132.25763-5-f.fainelli@gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 4 Dec 2019 14:13:06 +0530
Message-ID: <CAHLCerMCLDo90Lq2Pwb6OgPxzk=r1aR86BFEXm7hm=viaCPUXA@mail.gmail.com>
Subject: Re: [PATCH 4/6] thermal: brcmstb_thermal: Add 16nm process thermal parameters
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 30, 2019 at 11:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> Match the 7216 compatible string in order to derive the correct 16nm
> process thermal parameters to obtain correct readings.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/broadcom/brcmstb_thermal.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> index 2ad4eeb79f9c..41d4a142707c 100644
> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> @@ -283,12 +283,18 @@ static const struct thermal_zone_of_device_ops of_ops = {
>         .set_trips      = brcmstb_set_trips,
>  };
>
> +static const struct brcmstb_thermal_params brcmstb_16nm_params = {
> +       .offset = 457829,
> +       .mult   = 557,
> +};
> +
>  static const struct brcmstb_thermal_params brcmstb_28nm_params = {
>         .offset = 410040,
>         .mult   = 487,
>  };
>
>  static const struct of_device_id brcmstb_thermal_id_table[] = {
> +       { .compatible = "brcm,avs-tmon-bcm7216", .data = &brcmstb_16nm_params },
>         { .compatible = "brcm,avs-tmon", .data = &brcmstb_28nm_params },
>         {},
>  };
> --
> 2.17.1
>
