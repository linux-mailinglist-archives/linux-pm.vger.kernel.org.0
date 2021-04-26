Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA0836AF71
	for <lists+linux-pm@lfdr.de>; Mon, 26 Apr 2021 10:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhDZII5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Apr 2021 04:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhDZII4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Apr 2021 04:08:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F568C061574;
        Mon, 26 Apr 2021 01:08:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so399519wmn.2;
        Mon, 26 Apr 2021 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1+C61a0Cr2rRxPc4Jjq3nyzAUzXq7Gn1BorjliFLXXY=;
        b=fbkf+0kWc46up1wgYP3zVwbhQ6TUnWBsDrPW05UznNPUXZrStdK9KjE9UkEUETj24h
         PsHHHd/E1uyZQDHU83CoxvztCSHG7p+n5+F27i4tPk5PJoGBOMhkaBqxnQdBGB3y+wLl
         tn61++v0HFOfJh1BK/mDBQW/u/fGfxgvPq+CIN0k17iAq6nIf8aNXstKEibyacW4WTix
         ilE5fhircoDFPskaNgS+f7rwDeszaYE4I5MUO8FzHQH1GcfphqUTirlNsaEqZGoSUPNd
         0VcyADcNiR3QHJmW0p/POo8CbMQajwFg8pD7L6v7uawoVvApKYA7mR+JHI8DVQ5a16Ui
         0ZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1+C61a0Cr2rRxPc4Jjq3nyzAUzXq7Gn1BorjliFLXXY=;
        b=PPi3QbxOp8WH3L9NrtS84otJdhAYttAIAIHMDFHFcCIFtpCcbyHW8Id/arYWGN6bHX
         5DM34qHmHm+IkpJIsfmXeDO60pLIzMwUnFVQL1RJJPVUi70WnO0iPsPxXk7rESFECmlm
         j0slODMK6Ezmmw8M083JhNj/JLs+ffVMauwnHz5PrdgxGIoSYgAhmiUDv006ihbTYuJ1
         HNZIGxvqUcWc+4x8lu2ciSEyN41NONrChQZG1018avFzad+KbDdGV+MQRv3rP9GgKkMg
         XhAXgc2+e7ZNJioGI6BTTIG9iRtjN/gEpFFBCbGbcOHL2nbrOPf/nHdsg5tT6hZTvDy0
         oRsg==
X-Gm-Message-State: AOAM533/uw3RUNGlS4jc9G6X8/KdT6edEhQsof7Bmp0mfKgXWs6Li3QQ
        OtqiK2qgDj1oTjFaWkKwl54sDMeSoohpo3FuH6k=
X-Google-Smtp-Source: ABdhPJwHtgPSexyg/UZJqnA/kGIyUYaBuKzQ5Pp/PyYnUYFBFEeX7XJpts5stNulHO3Uf3F7JlL3sDqHL/w/LtbquYA=
X-Received: by 2002:a1c:1bd1:: with SMTP id b200mr7218681wmb.3.1619424491426;
 Mon, 26 Apr 2021 01:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210425174831.164332-1-krzysztof.kozlowski@canonical.com> <20210425174831.164332-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210425174831.164332-2-krzysztof.kozlowski@canonical.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 26 Apr 2021 16:07:34 +0800
Message-ID: <CAAfSe-tyAm1y-LV5LiiF_X6-ExFD3P9CxOwu+m2ZrLC5wdrnkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: sprd: add missing of_node_put for loop iteration
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 26 Apr 2021 at 01:48, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Early exits from for_each_available_child_of_node() should decrement the
> node reference counter.  Reported by Coccinelle:
>
>   drivers/thermal/sprd_thermal.c:387:1-23: WARNING:
>     Function "for_each_child_of_node" should have of_node_put() before goto around lines 391.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Acked-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks for fixing this.

> ---
>  drivers/thermal/sprd_thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/thermal/sprd_thermal.c b/drivers/thermal/sprd_thermal.c
> index 3682edb2f466..2778971aaf03 100644
> --- a/drivers/thermal/sprd_thermal.c
> +++ b/drivers/thermal/sprd_thermal.c
> @@ -388,6 +388,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
>                 sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
>                 if (!sen) {
>                         ret = -ENOMEM;
> +                       of_node_put(sen_child);
>                         goto disable_clk;
>                 }
>
> @@ -397,12 +398,14 @@ static int sprd_thm_probe(struct platform_device *pdev)
>                 ret = of_property_read_u32(sen_child, "reg", &sen->id);
>                 if (ret) {
>                         dev_err(&pdev->dev, "get sensor reg failed");
> +                       of_node_put(sen_child);
>                         goto disable_clk;
>                 }
>
>                 ret = sprd_thm_sensor_calibration(sen_child, thm, sen);
>                 if (ret) {
>                         dev_err(&pdev->dev, "efuse cal analysis failed");
> +                       of_node_put(sen_child);
>                         goto disable_clk;
>                 }
>
> @@ -416,6 +419,7 @@ static int sprd_thm_probe(struct platform_device *pdev)
>                         dev_err(&pdev->dev, "register thermal zone failed %d\n",
>                                 sen->id);
>                         ret = PTR_ERR(sen->tzd);
> +                       of_node_put(sen_child);
>                         goto disable_clk;
>                 }
>
> --
> 2.25.1
>
