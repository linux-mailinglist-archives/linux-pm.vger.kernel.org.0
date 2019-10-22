Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD4C3E03F9
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 14:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfJVMj4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 08:39:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32864 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfJVMj4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 08:39:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so9142011wro.0;
        Tue, 22 Oct 2019 05:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IEqiM8atHxIH0UKIQukfFYbPpj8bV/qswpYiJzDBnHM=;
        b=Yuptn+Xp3pzaviOf1YxWnObsNNLNBlUMB5/hGbYF3C52rbNCi4WDbPc3AhB/Za6yJF
         a1IsjGOP5g6s2UrUYasbp1X2Eo7KBDE6vA9bmTPf1EuIct5L475O6LV6BynQz90AozVx
         XSbq6sQd2Ol2yPAWOy8rRYdBh4d/TOgkwe35GEm7DMKLnJTWcEY1t9KIsDstZBWqrnpg
         J9f8d2jkRCR/+vXXxPfC8iTGQ98sHlOLyoNgXCEFO03/K76nENZDkX+eZdDlCM25vxjJ
         VhRQNsPh1LqUKaNasvMpJAJ+UiAnNTv62rMisyFtCtrL/XiO5Hpy8txCAG0V4vZa11gg
         dXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEqiM8atHxIH0UKIQukfFYbPpj8bV/qswpYiJzDBnHM=;
        b=lkw2hroA+QEKZOIpXDfCtCYF2ZPhUf+d/M4m3EgoRCqUX9rKmKbMBvqYPdn/e2j/3h
         shwHiiKQD/cP4jOZ/8mdgmy7JWjUhpPTDaFefJADS4kB9q3DRVzVaNoaqNyU+MGUypR8
         fuooqsMsN5NRqSpeOnuqOWmlOz4Vk/pVWgEK+PfFtm2YL/EtfkPsWLq0uZX53n5utPkK
         64ES9MiCVimGieOWruA0BxsMaanHIGLd5dXtoLBaTL8MbW1A4kbaYF17SSRLAf5R8ZCO
         hiUWG0O3u0+tZbmfQPnQfrThl7qTHORDu2X5hr/TwTBcH+UoNp/UxKHw9IEC2iyMUUIh
         kk+g==
X-Gm-Message-State: APjAAAVgwmHZz+USx9wRcDY8zzb+stq8EunP0nNtE8+dQpkp8GPgnXHB
        t1cSlaU52/k9q2C74KICAqARmnv3lh0sA/+ReRI=
X-Google-Smtp-Source: APXvYqzmx0gQXGcCYVFgILHBvA3ZLu3gjr/gPD4qkrCi98W3sz9AeZuH2TREtsOFsdfX9mKCmYxiaees0zzNDltevIs=
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr3298507wro.305.1571747993646;
 Tue, 22 Oct 2019 05:39:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191022111806.23143-1-colin.king@canonical.com>
In-Reply-To: <20191022111806.23143-1-colin.king@canonical.com>
From:   AngeloGioacchino Del Regno <kholk11@gmail.com>
Date:   Tue, 22 Oct 2019 14:39:42 +0200
Message-ID: <CAK7fi1a8CiX=HVqhZSmQJdcjF1X_kdHFDwJhEpYJUcdPTcbMQA@mail.gmail.com>
Subject: Re: [PATCH][next] thermal: qcom: tsens-v1: fix kfree of a non-pointer value
To:     Colin King <colin.king@canonical.com>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, MSM <linux-arm-msm@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il giorno mar 22 ott 2019 alle ore 13:18 Colin King
<colin.king@canonical.com> ha scritto:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the kfree of pointer qfprom_cdata is kfreeing an
> error value that has been cast to a pointer rather than a
> valid address.  Fix this by removing the kfree.
>
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

I confirm that was one stupid mistake. I was about to send the same patch, and I
can confirm that this fix is working. Tested on my Xperia X Compact.

Tested-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
