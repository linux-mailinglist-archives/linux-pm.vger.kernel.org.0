Return-Path: <linux-pm+bounces-23180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85537A49D36
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 16:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7AC175D9C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C2272912;
	Fri, 28 Feb 2025 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpGnAg0J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7A27181C;
	Fri, 28 Feb 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755966; cv=none; b=Dti4t/fCEHS+o6+qIXCHXfpE5NZcNzyB+788RV1AXAjQJAyMkt7s4kxh6b287BrhA9NxMFf3HTP2juX3HZjKBnbhwvt88jEaU8Q70Eup3USWUIhWdnkVj0muHSgbWzn39A4REtl6+wzT1+vhDQGZuYYGkKGiJ5UgFNLEjnPnBKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755966; c=relaxed/simple;
	bh=F8YT766/SjESb7HVqHUcjI5vFvf6sDNhEKkzd0Xmkzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pK36BgB6o2vXyX4vM1Y2KMpPD2lYIaBy8RX+vYSn72W6LxkrPmiZkXvEYPamjlaUCKv7ZKAaCrc/iyG3CmovBDGO/YvnygGHu85ERFdE1O18r9WoAK4TFN5SokZWq360hVV8QhcQjL+ttg+ZXdMsTpEenfuWy9RkpupiSMw/0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpGnAg0J; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abf48293ad0so21733166b.0;
        Fri, 28 Feb 2025 07:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740755963; x=1741360763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P7oY7BYAEv4W8+02LYZ2YxpBYCsfW/J7/vInnek1u5o=;
        b=WpGnAg0JdqFR9O4GyPPcGAUaQIpUYXnp9mdbfZdp5eU/RegYPEQC+035w44/U3e9bG
         daB2x9HCWZT1NlUIZdV6KsqWYAoOJcX2z1LQCb2KcHieOTYK9gvGSvn7D0d1XDEVx9Z2
         nKuvh0Yu0Tbu5YGzNQQ/sBe1eoao1ok6ppQYcX52/sV7S+unTLizRxRxA6GGgB/mB+53
         cc+mmkLpXHiWR7krHLq3kb2jIp1gCZzQa4WyiDFvFfPb4AwOeo7aZUa/Ucha3RVlopDc
         pjrMohu+nM88DmsWYPFW+EC27wwsrrktZGx3tCurSOPS5qrnPy8GX65lDx98Vu0jdM+e
         /zFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740755963; x=1741360763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7oY7BYAEv4W8+02LYZ2YxpBYCsfW/J7/vInnek1u5o=;
        b=pLuYK3q8w79gnBzd8VsWpkkPID+hrNwU37GlG/c/pAyQkaNSH32bx4nGNeff5YAPid
         rp2N+GS51d9JMgEcTUIpQVDQJ1tcpOdz1wZG0mp+xP1x3dHjAOXdsPUDhPoxUY6e3cyi
         QX3r6RF/80mggb74c8tvwgpZhKnNBJHsT8cad1W9LFOmQdnBqFkQI3UzyMakrnYOgN1k
         lgWzOxmYaUAPNYDKzoettzOKwAUKX+nl0QSDlzPlJ63h59X5neUW1UUo8+1xKWn7cLVP
         x95z4v+UADjS/k+jOuapclLJYdgb7/6MMu+unGNV+WEKkSzrIeXW7pdf0S4Wl6qc1qMG
         +w+w==
X-Forwarded-Encrypted: i=1; AJvYcCVIkaOYVFN2R5+8IrYOijI65zBDR4OeUstLC5LhOjWAA4sNqFs6sT42x3wY/BLwTjAfWootr+tRpW8=@vger.kernel.org, AJvYcCW4dynuutYS26z4wBQ6c5X5tApebtfXvbzcG7+aM+ER5zBektrXNUJPZ1qz5iEM8ItFm2zrqGA4VblUW6c=@vger.kernel.org, AJvYcCWqoWaLpGkL7nrTpt8AokN6Rlpn8XRzaZMOTsQaWZGooe6YSxgqrtE+JZvRRa6EBV0HKQah69HvPBfBi68ot0gl1To=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkiYDY/aXEkwWAz0YKFbRx7+Q4g+GecU4a7kRO42OSEb8/WzA5
	pY52ZKfkM5JCZfkhBda5Db8c9eme5/jw+BgAPnISletb7KRPHr+rZYBKNhnpDK0ku3Er5KbZEHH
	7e7jON/Cf84iJzGAWphx8kJtkZ/mrMw==
X-Gm-Gg: ASbGncuTtGTM9WxAeCC3vVcUPOi3ilNDzhgDIecCxNpVk0JD9/LQR0rHkyzxmtXPyZQ
	QYMUwDyL+VdoM3xbrq0LNSJGBdvQFC3FDmBfCBxwqgFN6Ibjk6AkB6XYyOo0c6xs1pM0CqkZfRv
	EBjUZxnPs=
X-Google-Smtp-Source: AGHT+IFtBraPIaQpBiymetsznsOvIzlEwuqrLSWFnfSvCpGcicRJBeGr4DA/338qPZgAwfUuoxlTMZWNYQWkG+jYe1A=
X-Received: by 2002:a17:906:f592:b0:ab7:d06d:b4bf with SMTP id
 a640c23a62f3a-abf265a3614mr422762466b.39.1740755962545; Fri, 28 Feb 2025
 07:19:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250216195850.5352-1-linux.amoon@gmail.com> <20250216195850.5352-2-linux.amoon@gmail.com>
 <e101aff2-a08e-4fed-8e38-df1aea44d23e@arm.com>
In-Reply-To: <e101aff2-a08e-4fed-8e38-df1aea44d23e@arm.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 28 Feb 2025 20:49:04 +0530
X-Gm-Features: AQ5f1Jq85EQ9ba5HWSGuaxxOFszs6piXmm_ai8qdDjz-7jgZDC6Fo3Zgq3faa6E
Message-ID: <CANAwSgRq+EjR70kVnh8AYZ6ZTSzV0uVwuF9E+_mpdG-6je-a8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drivers/thermal/exynos: Refactor clk_sec
 initialization inside SOC-specific case
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Lukasz,

Thanks for your review comments

On Fri, 28 Feb 2025 at 20:07, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Anand,
>
> On 2/16/25 19:58, Anand Moon wrote:
> > Refactor the initialization of the clk_sec clock to be inside the
> > SOC_ARCH_EXYNOS5420_TRIMINFO case. It ensures that the clk_sec clock
> > is only initialized for the specified SOC and not for other SOCs,
> > thereby simplifying the code.
>
> So IIUC there was no need to init that clock for other types of SoCs...
> Do we know that for sure (e.g. from other TRMs)?
This clock (clk) is utilized for the Thermal Management Unit (TMU) and
the GPU in the Exynos 542x,
as specified in the user manual.
>
> If that was the case, then simplification here can go further, but after
> some fixes.
>
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v3: improve the commit message
> > ---
> >   drivers/thermal/samsung/exynos_tmu.c | 26 +++++++++++++-------------
> >   1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 47a99b3c5395..9c138772d380 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -1040,19 +1040,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
> >       if (IS_ERR(data->clk))
> >               return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");
> >
> > -     data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
> > -     if (IS_ERR(data->clk_sec)) {
> > -             if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
> > -                     return dev_err_probe(dev, PTR_ERR(data->clk_sec),
> > -                                          "Failed to get triminfo clock\n");
> > -     } else {
> > -             ret = clk_prepare(data->clk_sec);
> > -             if (ret) {
> > -                     dev_err(dev, "Failed to get clock\n");
> > -                     return ret;
> > -             }
> > -     }
> > -
> >       ret = clk_prepare(data->clk);
>
> Here the data->clk is now used in different order.
Ok.
>
> >       if (ret) {
> >               dev_err(dev, "Failed to get clock\n");
> > @@ -1060,6 +1047,19 @@ static int exynos_tmu_probe(struct platform_device *pdev)
> >       }
> >
> >       switch (data->soc) {
> > +     case SOC_ARCH_EXYNOS5420_TRIMINFO:
> > +             data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
> > +             if (IS_ERR(data->clk_sec)) {
> > +                     return dev_err_probe(dev, PTR_ERR(data->clk_sec),
> > +                                          "Failed to get triminfo clock\n");
>
> Then here you shouldn't simply copy the old code. Now the data->clk
> is first, so should be 'clk_unprepare()' before return of the function.
>
> > +             } else {
>
> You can get rid of this 'else' above and still be safe in your
> refactoring.
>
> > +                     ret = clk_prepare(data->clk_sec);
> > +                     if (ret) {
> > +                             dev_err(dev, "Failed to get clock\n");
> > +                             return ret;
> > +                     }
>
> Here you can further simplify this to something like:
> -----------------------8<-------------------------------------
>
> +       case SOC_ARCH_EXYNOS5420_TRIMINFO:
> +               data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
> +               if (IS_ERR(data->clk_sec)) {
> +                       clk_unprepare(data->clk); ///// <----
> +                       return dev_err_probe(dev, PTR_ERR(data->clk_sec),
> +                                            "Failed to get triminfo clock\n");
> +               }
> +               ret = clk_prepare(data->clk_sec);
> +               if (ret) {
> +                       dev_err(dev, "Failed to get clock\n");
> +                       clk_unprepare(data->clk); ///// <----
> +                       return ret;
> +               }
> +
> +       break;
Ok
>
> --------------------------->8---------------------------------
>
> Or with better 'goto' flow.
>
> > +             }
> > +     break;
> >       case SOC_ARCH_EXYNOS5433:
> >       case SOC_ARCH_EXYNOS7:
> >               data->sclk = devm_clk_get(dev, "tmu_sclk");
>
>
> Also, you should revisit the 'goto' cleanup section at the bottom.
Thanks. I will recheck and update the code for the next version.
>
> Regards,
> Lukasz

Thanks
-Anand

