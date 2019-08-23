Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE2B9AE9B
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 14:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbfHWL7t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 07:59:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38255 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730661AbfHWL7t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 07:59:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id u190so7942175qkh.5
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2019 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/7z9akY64/3nYd1LmH/7prCtJSCPHvXXZJ3LUcNZ2M=;
        b=XbdgalBjnT6mmlRqw9XcB9jlAIHOZn6Gnw5Pmfq2q7Zi7O2Ir6vsKjMd7HKsRo48c6
         gwrEn8jk7Nuwwiq87RVyk2hSXMiWgHc11WN2eRiJO+XQuL3vD3lIBs71tto/V/LoJy+3
         Drumf7PyN0wWYFSwVL1PxPmQ3J1JdV08hzKk0rh8XrIRtoOEvEwQ6kY9pLdqGLDgTh+g
         /040z1SXt8h99Hpy4Fp1000AsUOOAHnJM4PvTuN+GxE2X4KhXolHXmq7GSvNf8SbCddY
         Um3jsN3kQYtp3Kb/olv2XkF8iPxXPjpl0z0L4be8d5iOL+LvDHxf7CAZcPjwjbe1GBqR
         2l5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/7z9akY64/3nYd1LmH/7prCtJSCPHvXXZJ3LUcNZ2M=;
        b=U1zoWQm2r3tn8t2tzlpPZNbBVJZwHghxqx1fV/434NUcr2d8CqsBCYnXFX+mted30n
         eI50sQfwbHyFl7BeZ5mrHR+fp30GvO15Fda/ATlLMFuPgyV9G83gWvPVOq61ewCcBbV3
         QLQJ3GAYhI53HmazhrJ9mt9H53sNHG5lfHqHxBll14463avB0KuS8+rg9VHMg2T8cbha
         9WE3RV7RsTAe3mmGojK+KvxHciw79wNSL/nIN4vOx4c+UjX4KDI/fWT38CVEAa20MTeN
         +ykupuh2AgkrAnDgz9C2Ybxev6Gy60JiTpIEHJnagC4cYAOWM6cmzF40DKQHwKwQ9r9x
         NJDQ==
X-Gm-Message-State: APjAAAVvxuFHaJuSFPa03c/vLU+SCUQclBPy3FlYFsQPYV7ruQh88Nol
        jl2XltHfnB1EINMY0TThrn9lGJAOIk34xlEf7BX04g==
X-Google-Smtp-Source: APXvYqxnSMlBmki602wGLbsV0PSiWdOK/0Q5DRafxwp9BavPVXNT/gdZlRtfnKwj4ckAe6b/LglAx9q0RQmv1RkWgH8=
X-Received: by 2002:a05:620a:5f7:: with SMTP id z23mr3611218qkg.106.1566561587907;
 Fri, 23 Aug 2019 04:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190823093835.32655-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20190823093835.32655-1-srinivas.kandagatla@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Fri, 23 Aug 2019 17:29:36 +0530
Message-ID: <CAP245DVf9fZNVEaYS39_NZ133LbwuZ77i=2fHUs-u_r-5EK-3Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: thermal: qcom: tsens: Fix memory leak from
 qfprom read
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 23, 2019 at 3:08 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> memory returned as part of nvmem_read via qfprom_read should be
> freed by the consumer once done.
> Existing code is not doing it so fix it.
>
> Below memory leak detected by kmemleak
>    [<ffffff80088b7658>] kmemleak_alloc+0x50/0x84
>     [<ffffff80081df120>] __kmalloc+0xe8/0x168
>     [<ffffff80086db350>] nvmem_cell_read+0x30/0x80
>     [<ffffff8008632790>] qfprom_read+0x4c/0x7c
>     [<ffffff80086335a4>] calibrate_v1+0x34/0x204
>     [<ffffff8008632518>] tsens_probe+0x164/0x258
>     [<ffffff80084e0a1c>] platform_drv_probe+0x80/0xa0
>     [<ffffff80084de4f4>] really_probe+0x208/0x248
>     [<ffffff80084de2c4>] driver_probe_device+0x98/0xc0
>     [<ffffff80084dec54>] __device_attach_driver+0x9c/0xac
>     [<ffffff80084dca74>] bus_for_each_drv+0x60/0x8c
>     [<ffffff80084de634>] __device_attach+0x8c/0x100
>     [<ffffff80084de6c8>] device_initial_probe+0x20/0x28
>     [<ffffff80084dcbb8>] bus_probe_device+0x34/0x7c
>     [<ffffff80084deb08>] deferred_probe_work_func+0x6c/0x98
>     [<ffffff80080c3da8>] process_one_work+0x160/0x2f8
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/qcom/tsens-8960.c |  2 ++
>  drivers/thermal/qcom/tsens-v0_1.c | 12 ++++++++++--
>  drivers/thermal/qcom/tsens-v1.c   |  1 +
>  drivers/thermal/qcom/tsens.h      |  1 +
>  4 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
> index 8d9b721dadb6..e46a4e3f25c4 100644
> --- a/drivers/thermal/qcom/tsens-8960.c
> +++ b/drivers/thermal/qcom/tsens-8960.c
> @@ -229,6 +229,8 @@ static int calibrate_8960(struct tsens_priv *priv)
>         for (i = 0; i < num_read; i++, s++)
>                 s->offset = data[i];
>
> +       kfree(data);
> +
>         return 0;
>  }
>
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index 6f26fadf4c27..055647bcee67 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -145,8 +145,10 @@ static int calibrate_8916(struct tsens_priv *priv)
>                 return PTR_ERR(qfprom_cdata);
>
>         qfprom_csel = (u32 *)qfprom_read(priv->dev, "calib_sel");
> -       if (IS_ERR(qfprom_csel))
> +       if (IS_ERR(qfprom_csel)) {
> +               kfree(qfprom_cdata);
>                 return PTR_ERR(qfprom_csel);
> +       }
>
>         mode = (qfprom_csel[0] & MSM8916_CAL_SEL_MASK) >> MSM8916_CAL_SEL_SHIFT;
>         dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> @@ -181,6 +183,8 @@ static int calibrate_8916(struct tsens_priv *priv)
>         }
>
>         compute_intercept_slope(priv, p1, p2, mode);
> +       kfree(qfprom_cdata);
> +       kfree(qfprom_csel);
>
>         return 0;
>  }
> @@ -198,8 +202,10 @@ static int calibrate_8974(struct tsens_priv *priv)
>                 return PTR_ERR(calib);
>
>         bkp = (u32 *)qfprom_read(priv->dev, "calib_backup");
> -       if (IS_ERR(bkp))
> +       if (IS_ERR(bkp)) {
> +               kfree(calib);
>                 return PTR_ERR(bkp);
> +       }
>
>         calib_redun_sel =  bkp[1] & BKP_REDUN_SEL;
>         calib_redun_sel >>= BKP_REDUN_SHIFT;
> @@ -313,6 +319,8 @@ static int calibrate_8974(struct tsens_priv *priv)
>         }
>
>         compute_intercept_slope(priv, p1, p2, mode);
> +       kfree(calib);
> +       kfree(bkp);
>
>         return 0;
>  }
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 10b595d4f619..870f502f2cb6 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -138,6 +138,7 @@ static int calibrate_v1(struct tsens_priv *priv)
>         }
>
>         compute_intercept_slope(priv, p1, p2, mode);
> +       kfree(qfprom_cdata);
>
>         return 0;
>  }
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 2fd94997245b..b89083b61c38 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -17,6 +17,7 @@
>
>  #include <linux/thermal.h>
>  #include <linux/regmap.h>
> +#include <linux/slab.h>
>
>  struct tsens_priv;
>
> --
> 2.21.0
>
