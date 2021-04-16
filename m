Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D961D361C9F
	for <lists+linux-pm@lfdr.de>; Fri, 16 Apr 2021 11:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbhDPJA7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Apr 2021 05:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235236AbhDPJA7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Apr 2021 05:00:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAE926115B;
        Fri, 16 Apr 2021 09:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618563634;
        bh=7wmVpOqsaknh+P4FzEE06MYfMkAiP80y7LVM+GvJfiQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JZWecCC70vkjElc81yiZgJS8UklIydW4O8zpob6+1MRlysFahpgFt6KH2yeocZdzC
         /9TYaCUP9KTo+AuSYEFxw9ye09DHRdqnun4SzfLJC3RnqEDAnsaOjCBTMZ3HWgQXc8
         BtOxLUpokHw30chVeZrNMJS8cR/j7aWhltCLFYXpdzITDOk0o2SSPEGqtiZtQJX6Cw
         or95tE1eQofV9Xr6FNKeRU+2nkfoBeQGcq7ejyTya8q4kRjCvr8OwdK54LMJ48UKkr
         19rJDF6a10OdNCdSWuPzNNFOTGWm2ycBM0V62cgJq1n52fQ5qoSS+bNj/dMkkmZxTI
         ZP7EBahpTzpNQ==
Received: by mail-ed1-f46.google.com with SMTP id e7so31275949edu.10;
        Fri, 16 Apr 2021 02:00:34 -0700 (PDT)
X-Gm-Message-State: AOAM532YvxZR7eSAn3wpSNKNkirZ/xjXZotDoWnLvuFASqS9U/JzAobw
        wHNtlR3JGmvvHnA6w23E5lv244HKy0BsyeOfhUU=
X-Google-Smtp-Source: ABdhPJyS0LWKxxT6wHKAww0y5cojiL8VJFRg4ktDZ0lY8VrMNI2SaQHOhE7kynmEUPwlzFWiNxKaMDM9HdJtbjYQm3k=
X-Received: by 2002:a50:e607:: with SMTP id y7mr8957861edm.18.1618563633453;
 Fri, 16 Apr 2021 02:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210404043219.11334-1-zhuguangqing83@gmail.com>
In-Reply-To: <20210404043219.11334-1-zhuguangqing83@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 16 Apr 2021 11:00:21 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcCiMCNKmP5TCLk9-qCJ=c4qP59Jr3B1sBZfxTqe4FuAw@mail.gmail.com>
Message-ID: <CAJKOXPcCiMCNKmP5TCLk9-qCJ=c4qP59Jr3B1sBZfxTqe4FuAw@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/tsens: fix missing put_device error
To:     zhuguangqing83@gmail.com
Cc:     Amit Kucheria <amitk@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 4 Apr 2021 at 06:34, <zhuguangqing83@gmail.com> wrote:
>
> From: Guangqing Zhu <zhuguangqing83@gmail.com>
>
> Fixes coccicheck error:
>
> drivers/thermal/qcom/tsens.c:759:4-10: ERROR: missing put_device; call
> of_find_device_by_node on line 715, but without a corresponding object
> release within this function.
>
> Fixes: a7ff82976122 ("drivers: thermal: tsens: Merge tsens-common.c into
> tsens.c")
>
> Signed-off-by: Guangqing Zhu <zhuguangqing83@gmail.com>
> ---
>  drivers/thermal/qcom/tsens.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index d8ce3a687b80..cc4c6a9853a4 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -755,9 +755,10 @@ int __init init_common(struct tsens_priv *priv)
>                 for (i = VER_MAJOR; i <= VER_STEP; i++) {
>                         priv->rf[i] = devm_regmap_field_alloc(dev, priv->srot_map,
>                                                               priv->fields[i]);
> -                       if (IS_ERR(priv->rf[i]))
> -                               return PTR_ERR(priv->rf[i]);
> -               }
> +                       if (IS_ERR(priv->rf[i])) {
> +                               ret = PTR_ERR(priv->rf[i]);
> +                               goto err_put_device;
> +                       }

As kbuild robot pointed out - this does not even compile. Please at
least build all your patches before sending.

Best regards,
Krzysztof
