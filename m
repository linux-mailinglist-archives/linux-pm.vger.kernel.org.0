Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34842567D5
	for <lists+linux-pm@lfdr.de>; Sat, 29 Aug 2020 15:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgH2NNi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 29 Aug 2020 09:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgH2NKo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 29 Aug 2020 09:10:44 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 007632076D;
        Sat, 29 Aug 2020 13:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598706643;
        bh=z1sTsa1dpruwAUEEfp1W27KJA2xFmbwqQp5IOMzOoU4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DNFZoUQs+N4C1jS97X4sJiyIy1gDiwUEBZhvmyiTp3eqOC5xhZOUhxi3e6iR19L8o
         A/esD5eCS3bR55GtU6QfbScIxxlABrEtTI/RlRBwwVkR2KsFPUv7HmUgt1oMrT8T5c
         zY096JfQb2KaZXURE/Bx9vAmU+jLpTTyouiK8Oho=
Received: by mail-lj1-f178.google.com with SMTP id t23so1857001ljc.3;
        Sat, 29 Aug 2020 06:10:42 -0700 (PDT)
X-Gm-Message-State: AOAM533FzM3Ly/BqVLgmku5UCe9WnwUo0EUFzqy9C1z6CPI/IBWqvuJa
        45yuQgZeqBB8ZsDXxhuQFB1hF+LB7geP7xUwZHo=
X-Google-Smtp-Source: ABdhPJzcoYwMbQDiFlTomIEruCL5TFbgX/szDz7jSloxr/PA2l7GtagUnsDtLuSgrs6u+KeuSH6Y+qbAcRFt/NYA8xQ=
X-Received: by 2002:a2e:910b:: with SMTP id m11mr1571569ljg.159.1598706641354;
 Sat, 29 Aug 2020 06:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200828153100.19006-1-krzk@kernel.org>
In-Reply-To: <20200828153100.19006-1-krzk@kernel.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
Date:   Sat, 29 Aug 2020 22:10:04 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3+mxBXzVp5Wz=F6nbx3bfubrmJozVzVdt8s1e45WQOqg@mail.gmail.com>
Message-ID: <CAGTfZH3+mxBXzVp5Wz=F6nbx3bfubrmJozVzVdt8s1e45WQOqg@mail.gmail.com>
Subject: Re: [PATCH] devfreq: rk3399_dmc: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Aug 29, 2020 at 12:31 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/devfreq/rk3399_dmc.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
> index 027769e39f9b..35b3542f1f7b 100644
> --- a/drivers/devfreq/rk3399_dmc.c
> +++ b/drivers/devfreq/rk3399_dmc.c
> @@ -324,22 +324,14 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>         mutex_init(&data->lock);
>
>         data->vdd_center = devm_regulator_get(dev, "center");
> -       if (IS_ERR(data->vdd_center)) {
> -               if (PTR_ERR(data->vdd_center) == -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> -
> -               dev_err(dev, "Cannot get the regulator \"center\"\n");
> -               return PTR_ERR(data->vdd_center);
> -       }
> +       if (IS_ERR(data->vdd_center))
> +               return dev_err_probe(dev, PTR_ERR(data->vdd_center),
> +                                    "Cannot get the regulator \"center\"\n");
>
>         data->dmc_clk = devm_clk_get(dev, "dmc_clk");
> -       if (IS_ERR(data->dmc_clk)) {
> -               if (PTR_ERR(data->dmc_clk) == -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> -
> -               dev_err(dev, "Cannot get the clk dmc_clk\n");
> -               return PTR_ERR(data->dmc_clk);
> -       }
> +       if (IS_ERR(data->dmc_clk))
> +               return dev_err_probe(dev, PTR_ERR(data->dmc_clk),
> +                                    "Cannot get the clk dmc_clk\n");
>
>         data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
>         if (IS_ERR(data->edev))
> --
> 2.17.1
>

Applied it. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
