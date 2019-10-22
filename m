Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D358DE047C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 15:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbfJVNGV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 09:06:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35589 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731850AbfJVNGV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 09:06:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so26681350qtq.2
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2019 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IFWTbMD8AdeW8CJ2pCx3d0rW0WQ9zdFS/kI+sYlxUlw=;
        b=HhLfr2vGbjQYb9rn8HQIy2DLmFbAqcxrwLSlbP3wl17ZMLM1KjkzM4iR1Cvu6S1qDd
         CoEeF4DA79piGOBUWJGNkZAF8WQ8IIM/lGLGTaALz+Hf36nOLIphsPix9D4E6y5LB8Fs
         l+QbEjt4JlU2YrAtAc4G1gB4AL+x0BZiIo11L6pWdIYMQvzNQ8BhHDhTOqo5K8kB25Ml
         HnAE4jArpeieysIkWtaYYxGKcml0GZnI4AdZf986UtI4LSoqWCRT0mMrnfKz7I2Wo9KT
         3hZbhzNN8HEhUl5UKFqJcwdT5ngWiaW84WSDtr6Z+CcY57RR23rFjQJcTySy6+Cpbxrx
         oJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IFWTbMD8AdeW8CJ2pCx3d0rW0WQ9zdFS/kI+sYlxUlw=;
        b=RzAy24TTBnt/eF1lp9I+vXHx34aYjsUuQUgiZi9sH2UBVHHiF6BvVPI/ILKWVDsJxF
         842yDufYbSZNBWPQAVuE25TXL8EC4xB6x0W+5b/BBZ9gtKV+RN2CdosySPY58rKEsp1Y
         dm0rqKFcazP0t0MgYvyfzB+wxhaepfw0QjOPNjkZtLcnAIFdslniunBXVEvxxaAGIt50
         aXvcYS5oqtoUA7vcAIsCN5OvtZ2E9PBGLerZk2v763Ra/9G30YAyvOJf/8Tfku97a/jn
         BmchxPSnjUgtfiscpND/MODNRAf4viMpbA3ggT407GGOWjXrohjbD0xvanxxOP1oK5Sk
         x/PA==
X-Gm-Message-State: APjAAAW+ESwZ8suD91+ZefLUC9XOsBwiHZUi5yx5FoEs1XK3zQYXUn2A
        QY3n/K/vRNif8NFKv53kQS5IrtTogzMNERXxkI3f5g==
X-Google-Smtp-Source: APXvYqxx/KtPDbvOc/l9nR5i6+vVfYhh1O6G+InyUToPteiA4rp6ydW+ZlHhJfx3jmclxN9NxPqz/B4OF/PJPBB2h7g=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr3301704qtb.264.1571749580487;
 Tue, 22 Oct 2019 06:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191022111806.23143-1-colin.king@canonical.com>
In-Reply-To: <20191022111806.23143-1-colin.king@canonical.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 22 Oct 2019 18:36:08 +0530
Message-ID: <CAP245DXjVDJ68kmWONmWh4YB=dcVrQ4q1y3bPncDc5=FohY2Vw@mail.gmail.com>
Subject: Re: [PATCH][next] thermal: qcom: tsens-v1: fix kfree of a non-pointer value
To:     Colin King <colin.king@canonical.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 22, 2019 at 4:48 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the kfree of pointer qfprom_cdata is kfreeing an
> error value that has been cast to a pointer rather than a
> valid address.  Fix this by removing the kfree.

Hmm, we just added this to other places[1] as a fix for mem leaks
using the nvmem api.

I think we need to fix up the qfprom_read wrapper. Srini?

[1] https://lore.kernel.org/stable/20191010083616.685532154@linuxfoundation.org/

> Fixes: 95ededc17e4e ("thermal: qcom: tsens-v1: Add support for MSM8956 and MSM8976")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/thermal/qcom/tsens-v1.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 2d1077b64887..bd2ddb684a45 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -240,10 +240,8 @@ static int calibrate_8976(struct tsens_priv *priv)
>         u32 *qfprom_cdata;
>
>         qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
> -       if (IS_ERR(qfprom_cdata)) {
> -               kfree(qfprom_cdata);
> +       if (IS_ERR(qfprom_cdata))
>                 return PTR_ERR(qfprom_cdata);
> -       }
>
>         mode = (qfprom_cdata[4] & MSM8976_CAL_SEL_MASK);
>         dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> --
> 2.20.1
>
