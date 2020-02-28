Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D15E31734F5
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 11:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgB1KGe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 05:06:34 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42032 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgB1KGd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 05:06:33 -0500
Received: by mail-vs1-f67.google.com with SMTP id w142so1567678vsw.9
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2020 02:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InyvFyZ/5bxCUOynjC6lpv2Fa6LG6T5vC6/2VR0weU4=;
        b=PzeYbRw+1d4tOTIvVmv8WOwZUT7ugbzZaN4HN095qyoN60ncxY+KxLJ8CGXgVLtywZ
         PzRRzd/Boh5BxVT39etHcbM/GVLwHGA/pQu/6qYEnkTyIFJat3gpBDHil+GfSjDlw+Ay
         aoJJq++pc+C1M/2qjZU5snzG5JOccINZQy1w8m0FAiQIZ7OJQgxFofSAIQ33bRVM1A7u
         BnHntdL/PwHIRGerTeue8Og1XlpoAC1B6ugfIIdOT0+QjYRp6nZwJBAjg5h9CJnqFGqZ
         1OM8YHno56hD+I5HrsNOFAw6k/r+dvKDG4Ns9huXjUdfzR2u3lBvDX5S2RHQ825XsXLb
         OwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InyvFyZ/5bxCUOynjC6lpv2Fa6LG6T5vC6/2VR0weU4=;
        b=TYxrPXKHQvBhStQNWdZ5xHhxYhLJcbtrPJngpuwOChBhXhAw/Kd422DIan49xdQwSD
         TP4d2sow5JaC8MEXpWggC/Gg9gOtRwkQVXmNKe8CdbYDd/aKt00nE3IXCNs1D4uF20BV
         sJnrFcyycS4pmvepFU+EoqO+JbHjpXK27OLwoQMzwccXa60+GngNatNTnb4AaZU29miw
         rvJM1u5uPhUBEmzd7kq0bcl8sPrE3OVSLcDazF3E3J+NBKZvVrU1PatoYqxDV/Tn+mm7
         gRvOidapaO+wAwl5410uQOGBWE+9Gs21Glm4lfiYlV+2Xt+PjlwA81905gvkRGcKW9E3
         phRw==
X-Gm-Message-State: ANhLgQ14TqaMypy8CpkVGrRhHWV1ltrAucTLDX81WzBYFFu0ttmcGGc1
        /v8t1DQk1yUID2Pqgr7bcdt7DMIxgvfGpPyNcScoGQ==
X-Google-Smtp-Source: ADFU+vuZA1XQ4xbgMSEaWxgfM1zO76KhScqpXifMj+FzO5W8iDdZrT7Cbt3IZqF0CejkSumiQMSUNEHOKy8Pgn+JJ6Q=
X-Received: by 2002:a05:6102:535:: with SMTP id m21mr1937391vsa.95.1582884391664;
 Fri, 28 Feb 2020 02:06:31 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200228092342eucas1p1ead44fbfd9ab57c02ffa588ca9acb97a@eucas1p1.samsung.com>
 <20200228092331.21548-1-m.szyprowski@samsung.com>
In-Reply-To: <20200228092331.21548-1-m.szyprowski@samsung.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 28 Feb 2020 15:36:20 +0530
Message-ID: <CAHLCerN7aV82NTAoPT-ukNBJifySqSxfRogXP6ByMmJiV6nuCA@mail.gmail.com>
Subject: Re: [PATCH] thermal: exynos: Silence warning during deferred probe
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 28, 2020 at 2:53 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Don't confuse user with meaningless warning about the failure of
> registering sensors in case of deferred probe.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/samsung/exynos_tmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index fd4a17812f33..e9a90bc23b11 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -1094,7 +1094,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>                                                     &exynos_sensor_ops);
>         if (IS_ERR(data->tzd)) {
>                 ret = PTR_ERR(data->tzd);
> -               dev_err(&pdev->dev, "Failed to register sensor: %d\n", ret);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&pdev->dev, "Failed to register sensor: %d\n",
> +                               ret);
>                 goto err_sclk;
>         }
>
> --
> 2.17.1
>
