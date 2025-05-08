Return-Path: <linux-pm+bounces-26880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D678AAF75E
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 12:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711751BC3E9D
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 10:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614DA1C8612;
	Thu,  8 May 2025 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAOKJki6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02471C5D59
	for <linux-pm@vger.kernel.org>; Thu,  8 May 2025 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746698653; cv=none; b=j9P+fryZ6WdE03oFsX42MpF53GXjapaw8akKGYhoEbS1v9sEkEPnCmoPTYFB761QLu1jNYY55XxYCdE28RZb4bvrbWD2egYu3v92o6TIBKW/nJOF81sqsENPdJxVw4Cdew8/aC3JR5Y0y5AIpQa9uZ37ENuVcRe2uaoBuooXllw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746698653; c=relaxed/simple;
	bh=nQWMS8zLodxQjA2tkoVMA2V3++BSV8DfYZl9qCc12q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9DJEeEcyI+ZWzfYxqJ3ne30Ft6/0FkYjlZ56EInrXRqjtQg1pvzuK+3ZuzS6y1szS3cyfYlDo3/g7ojoVbvrV+T/L2QgGcnpE2pMnGey2PJc5VOQfl6P6OPw5PCCKwqNBY6TvOGNXBnJDI3HXkA2CCaoQGTjS5BR7r/5DJFigM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FAOKJki6; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso811548276.2
        for <linux-pm@vger.kernel.org>; Thu, 08 May 2025 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746698649; x=1747303449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+OMCAEKXt9Na5TVEs/wllXz+LY/w4SZyrDL1epmaZEU=;
        b=FAOKJki6OBNOt28NYq+dOT0TCHWF0fCAIikha134jsYRFKMNvLFwu7bLmsDcBNq/0/
         9JqUwi7qNK1yhW0QJiRh/+ri7vJ3BiP3y+tdBGmo8SESjHMpgvvponj7S+N12v3gPNLk
         gxEnVSv6TwDiNYPiPRC9EaHSI6PCIKeimerfJQ2AGzNZ+w3yaww/TpfC5OOzzic+qAJD
         1cm1bZd3lcTlWXu+gJeruukumXyJ/ecOlk8zOnyzdzfVL2I7znRXRNS0Sh0rokKONP9F
         U2uFCuzZlwMNF31d1lWLdEh8322hCFFrmsV4U3B+j1eQukVXfvFGurI7vCG/Ek50zlMr
         xxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746698649; x=1747303449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OMCAEKXt9Na5TVEs/wllXz+LY/w4SZyrDL1epmaZEU=;
        b=SqodkkYwgFgyKmmp0MGAowJ2p+X+UsQ1ULqp47ZccPILb0Ax3XiNUlrdbK/8hkHHP6
         CYpXY6QnGD8QfejPiW5h3oAxE2ZpmI/sjZin8r2CFGFDoXytBHyFuSLAIWEwnxoQDzlc
         11JG1ezN5tvOJ1/6mrozX7HRcXrWRywxA7y2qWoLJcu9LtlavJA6v7ugoZnTDVIX0o8G
         dcirAmCNMFWB5+9iR44hpTzgSHVoeFLdzaAXoEimEcK1/R0l1D21H9hQg+EGOhUYswfJ
         kt/1q9NV8jwUY9ubN7+N0dKqYnSFAgvu073vu6PiKpb+m2/6GXZjYBd6T9hbJO9jq1In
         1A/A==
X-Forwarded-Encrypted: i=1; AJvYcCUMzlsjkJ9w1w+RrmAhuQSZkhqJqxbV571aYN++DUEX2Ilk1pL6Rmz4tnokLusbuXz0mUJCd/M7cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBF9mxER29nOt1Pbd/9a09o6d+dR/W7uUZ9aMKsYoWTFqiRQv4
	h4yRXMcQ2x7j68Ri6yD7uz7dzNqHaz4JD5JsKDOLdII6MsOdFd2o9PfZDrwR4do5tIdAj5xJLa9
	l0BcJFmD2nNYVvJnrMWs726B3KzCswg+rahekDg==
X-Gm-Gg: ASbGncs0RCGf7LYBdvcVbFHMdVwE4KzEmTm/DLVPXgALgp9TGwdKNCgh3e6S0PHfadh
	R7x5Swj8BcaVU/zEhTmKBYAxAXav6VnhFueaHei9aP5lkxKxxeYoCRQL4bMUMfEKsKf8nT4vDVc
	+5NFM99wM06y/tvcQb0a7sftU=
X-Google-Smtp-Source: AGHT+IEe4zp5EUGAPH2midu3NVbyBycrHIpRT+XUkbdIdzvQqiRxX8Kp0ZBPTG8H9R5eDjAreGEn66s7Qu9eZSe/884=
X-Received: by 2002:a05:6902:2b0d:b0:e78:f1e2:8f25 with SMTP id
 3f1490d57ef6-e78f1e2907amr1705899276.0.1746698649338; Thu, 08 May 2025
 03:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507160056.11876-1-hiagofranco@gmail.com> <20250507160056.11876-4-hiagofranco@gmail.com>
In-Reply-To: <20250507160056.11876-4-hiagofranco@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 8 May 2025 12:03:33 +0200
X-Gm-Features: ATxdqUFUvDJo4SEFGQh5UV_w7ICgnExMVykRp0SMxPXtgTPPo6OOJoK0tLhcWVM
Message-ID: <CAPDyKFrHD1hVCfOK-JV5FJM+Cd9DoKKZGKcC94fxx6_9Bsri1g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Hiago De Franco <hiago.franco@toradex.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@oss.nxp.com>, daniel.baluta@nxp.com, iuliana.prodan@oss.nxp.com, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 18:02, Hiago De Franco <hiagofranco@gmail.com> wrote:
>
> From: Hiago De Franco <hiago.franco@toradex.com>
>
> When the remote core is started before Linux boots (e.g., by the
> bootloader), the driver currently is not able to attach because it only
> checks for cores running in different partitions. If the core was kicked
> by the bootloader, it is in the same partition as Linux and it is
> already up and running.
>
> This adds power mode verification through the SCU interface, enabling
> the driver to detect when the remote core is already running and
> properly attach to it.
>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
> Suggested-by: Peng Fan <peng.fan@nxp.com>
> ---
> v2: Dropped unecessary include. Removed the imx_rproc_is_on function, as
> suggested.
> ---
>  drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 627e57a88db2..9b6e9e41b7fc 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -949,6 +949,19 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>                         if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
>                                 return -EINVAL;
>
> +                       /*
> +                        * If remote core is already running (e.g. kicked by
> +                        * the bootloader), attach to it.
> +                        */
> +                       ret = imx_sc_pm_get_resource_power_mode(priv->ipc_handle,
> +                                                               priv->rsrc_id);
> +                       if (ret < 0)
> +                               dev_err(dev, "failed to get power resource %d mode, ret %d\n",
> +                                       priv->rsrc_id, ret);
> +
> +                       if (ret == IMX_SC_PM_PW_MODE_ON)
> +                               priv->rproc->state = RPROC_DETACHED;
> +
>                         return imx_rproc_attach_pd(priv);

Why is it important to potentially set "priv->rproc->state =
RPROC_DETACHED" before calling imx_rproc_attach_pd()?

Would it be possible to do it the other way around? First calling
imx_rproc_attach_pd() then get the power-mode to know if
RPROC_DETACHED should be set or not?

The main reason why I ask, is because of how we handle the single PM
domain case. In that case, the PM domain has already been attached
(and powered-on) before we reach this point.

>                 }
>
> --
> 2.39.5
>

Kind regards
Uffe

