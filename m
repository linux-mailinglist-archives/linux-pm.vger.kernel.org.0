Return-Path: <linux-pm+bounces-28957-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37812ADEB91
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 14:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6DA3A2095
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 12:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087DC2BD022;
	Wed, 18 Jun 2025 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PS7QpX9j"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA20293C78
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248792; cv=none; b=LfLkl+rjfr0a8vrP6wOnQp92IUiCNCHRCJPdwGlTbGOV95iXEXpJEwDphMwgxDFazcM+bISexYCz8sc/HLNJgRjuJ1c2psRNm0ySOeXUWOw/AYQQa1sb5kTfTMzVthkt7yv/SqLu1bNYr90iCUJV4kN0ABWooykwQaxThEupvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248792; c=relaxed/simple;
	bh=S+Z1yIM9Z7AMg6puDBieh0UvRmQ1svKpeSk5WrhTYRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0M+qajhD/kf7igiQ3Bf9ODtRnxhLl7zZP8OjI1D/SQInLdrxbEzg5fC8eZUe2Fw4ERY7zNTKofHRG3C9sxxzkzeJa8SZizEQM1bay97tjMK/IcJFENJRhD3gPAmgWgRWzFNARS41qwzbkGw2T+Q898QQuwf4xbXQz5pL7N/C9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PS7QpX9j; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-adfb562266cso650974266b.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750248789; x=1750853589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bKGxDPrsrGFp0Bze86vZksL2+DNrY5eWcc4p55uZfLg=;
        b=PS7QpX9jMPQvzX6sjDOFk1szG0lEk5c7rjgLVAuJwXtzlY6vEyyRUzXguADzoyQ4SB
         m6/bF3TJYKJoOmWygsQxIvHxXdUfS5B6tmZXK2V6Us5YU+fVDUXsgmOPFVoYgGhfOP0M
         n3QJTx0Y0LiGBjXOpcJTfM4ISpnPspoPeBqm1YCzPP8Vk7FHqrNir2jbzQsN9GiijjqC
         j4h3tnLRGeJFnL74BniE57h4mB4Z1CoN9t0YcCu8y7MGxXqRGmQQVcltuPiaXXaWo6vY
         d0+y44N0lUfMCItGFvsbkGYezUAkQdbNCBZ9qGliEUmk/pFoiFXkwz+d6+knE8pFXj50
         B2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750248789; x=1750853589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKGxDPrsrGFp0Bze86vZksL2+DNrY5eWcc4p55uZfLg=;
        b=J8AaMvsxi5dyfmu3rDx3Nf3S5jPL01eoxZ3PDqz8xweVDOnXLLflfwJttvIV22IIYK
         p0dfuBTcBdmh6llsSE3Lb8b85wu9tpS0kOKGcXYuQ9K6voMcLjCv8L5pyVxwl8tG2SMS
         m/zAc82ijnnA6gpIruM6q2fPUQRWZ8o4/P+bKR+jzniBqbfyAeu9AedjFT8LtQbOw3ik
         iuaNVVGXgf66Ew2yPjlaPLAwM/Bgk5dIm4h+8EYzTC4JnUxoaZq13FFMxzP8b0HmXkmK
         vtHJti0TPaEJFzgTg35vzMXlNZD04+Lda7QOAKMSmAAEN4CrJa+3xo5hX+/7IrDUw1ri
         Qy2w==
X-Forwarded-Encrypted: i=1; AJvYcCXE9uM+IFNOBFn9vCXiXz7WuB45fUllOYfWmrzVIW0qF8Rt7hAiFQ0CtkIzEhctslw/bwF36BzCrw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/+ooGAksAFOU5ppYNzl4ka+6P9JmVKnK5UaZTrFyXQVWKHw9h
	+MnZ6sryzloCmBqKoRCAnQl8JqSBUdnNYTzJj8YcsDov++/fMQlbKWBEWAnBdLgQY7gpWO0RPIP
	7WeJIqpvCn65M34oPQTl8yai9Y/KHXsaNOQi5br1JvQ==
X-Gm-Gg: ASbGnct1Gaz16I94GmYTmj3cjz5qRI20lUNI5V6qk9yEstVTOyy7yQ/BmMm10L4Adwm
	r/LUsY2LrVbdylLJJgoM+RsVjZZXT4InaEv7/ZqQ/ec+sYkre+oRWYTyR8sDtQZJ+Em/K9lEDUu
	V8smzw6yiEl7zlaB0xuOwhEUHu+65Ocr/OISEopXEs/ec=
X-Google-Smtp-Source: AGHT+IGTSzjogHCi/geFRfkS1k64vxCFzHGvVMOvmRTwVeChVfJIOBt9QznhX1/YRhdAVy4BHCTh3ig3roxkOz/SlaA=
X-Received: by 2002:a17:907:fd18:b0:add:fa4e:8a7e with SMTP id
 a640c23a62f3a-adfad4104cemr1503686066b.32.1750248789286; Wed, 18 Jun 2025
 05:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617193450.183889-1-hiagofranco@gmail.com> <20250617193450.183889-4-hiagofranco@gmail.com>
In-Reply-To: <20250617193450.183889-4-hiagofranco@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 18 Jun 2025 14:12:31 +0200
X-Gm-Features: AX0GCFv-WhPn_WVjSMi4ptgdlE0BOC7_hZaPLP8zfqr856nDVAxKNS58yS5OlAM
Message-ID: <CAPDyKFq0EswFPF2nabJfQQ52D3Usy8AOUEH1WJWKsEhvOhO60w@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] remoteproc: imx_rproc: detect and attach to
 pre-booted remote cores
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Jun 2025 at 21:36, Hiago De Franco <hiagofranco@gmail.com> wrote:
>
> From: Hiago De Franco <hiago.franco@toradex.com>
>
> When the remote core is started before Linux boots (e.g., by the
> bootloader), the driver currently is not able to attach because it only
> checks for cores running in different partitions. If the core was kicked
> by the bootloader, it is in the same partition as Linux and it is
> already up and running.
>
> This adds power mode verification through dev_pm_genpd_is_on(), enabling
> the driver to detect when the remote core is already running and
> properly attach to it if all the power domain devices are on.
>
> To accomplish this, we need to avoid passing any attach_data or flags to
> dev_pm_domain_attach_list(), letting the platform device become a
> consumer of the power domain provider. With that the current power state
> of the genpds will not change, allowing the detection of the remote core
> power state.
>
> We enable and sync the device runtime PM during probe to make sure the
> power domains are correctly managed when the core is controlled by the
> kernel.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
> v4 -> v5:
>  - pm_runtime_get_sync() removed in favor of
>    pm_runtime_resume_and_get(). Now it also checks the return value of
>    this function.
>  - Added pm_runtime_disable() and pm_runtime_put() to imx_rproc_remove()
>    function.
> v3 -> v4:
>  - Changed to use the new dev_pm_genpd_is_on() function instead, as
>    suggested by Ulf. This will now get the power status of the two
>    remote cores power domains to decided if imx_rpoc needs to attach or
>    not. In order to do that, pm_runtime_enable() and
>    pm_runtime_get_sync() were introduced and pd_data was removed.
> v2 -> v3:
>  - Unchanged.
> v1 -> v2:
>  - Dropped unecessary include. Removed the imx_rproc_is_on function, as
>    suggested.
> ---
>  drivers/remoteproc/imx_rproc.c | 37 +++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 627e57a88db2..b53083f2553e 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/reboot.h>
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
> @@ -890,10 +891,8 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
>  static int imx_rproc_attach_pd(struct imx_rproc *priv)
>  {
>         struct device *dev = priv->dev;
> -       int ret;
> -       struct dev_pm_domain_attach_data pd_data = {
> -               .pd_flags = PD_FLAG_DEV_LINK_ON,
> -       };
> +       int ret, i;
> +       bool detached = true;
>
>         /*
>          * If there is only one power-domain entry, the platform driver framework
> @@ -902,7 +901,22 @@ static int imx_rproc_attach_pd(struct imx_rproc *priv)
>         if (dev->pm_domain)
>                 return 0;
>
> -       ret = dev_pm_domain_attach_list(dev, &pd_data, &priv->pd_list);
> +       ret = dev_pm_domain_attach_list(dev, NULL, &priv->pd_list);
> +       /*
> +        * If all the power domain devices are already turned on, the remote
> +        * core is already up when the kernel booted (e.g. kicked by the
> +        * bootloader). In this case attach to it.
> +        */
> +       for (i = 0; i < ret; i++) {
> +               if (!dev_pm_genpd_is_on(priv->pd_list->pd_devs[i])) {
> +                       detached = false;
> +                       break;
> +               }
> +       }
> +
> +       if (detached)
> +               priv->rproc->state = RPROC_DETACHED;
> +
>         return ret < 0 ? ret : 0;
>  }
>
> @@ -1146,6 +1160,15 @@ static int imx_rproc_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       if (dcfg->method == IMX_RPROC_SCU_API) {
> +               pm_runtime_enable(dev);
> +               ret = pm_runtime_resume_and_get(dev);
> +               if (ret) {
> +                       dev_err(dev, "pm_runtime get failed: %d\n", ret);
> +                       goto err_put_clk;
> +               }
> +       }
> +
>         ret = rproc_add(rproc);
>         if (ret) {
>                 dev_err(dev, "rproc_add failed\n");
> @@ -1171,6 +1194,10 @@ static void imx_rproc_remove(struct platform_device *pdev)
>         struct rproc *rproc = platform_get_drvdata(pdev);
>         struct imx_rproc *priv = rproc->priv;
>
> +       if (priv->dcfg->method == IMX_RPROC_SCU_API) {
> +               pm_runtime_disable(priv->dev);
> +               pm_runtime_put(priv->dev);
> +       }
>         clk_disable_unprepare(priv->clk);
>         rproc_del(rproc);
>         imx_rproc_put_scu(rproc);
> --
> 2.39.5
>

