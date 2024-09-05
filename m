Return-Path: <linux-pm+bounces-13713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F2996DF59
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 18:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81DC4287F13
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2024 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4975119F485;
	Thu,  5 Sep 2024 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwMRaXp3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0EB7DA92
	for <linux-pm@vger.kernel.org>; Thu,  5 Sep 2024 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552998; cv=none; b=lumv9OSvLSWKWaPd0ogy7gPZKwSAPmZiO/dnJ+ouGWqjWxVouMHgxAYcvMHEV5DrO1RvBuO5DyXfLFd+lSbj/i1mGkowesOSrfcIPzrrgOdGq9IGP//SZvG4XC+2iRhuq5bni/Wobf3r0UprE5QgTRUrQjSNKnVXBqebLjmWsEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552998; c=relaxed/simple;
	bh=XbT1YCH8SqWz/eTmMsIAXlLpeVmIpBn9oe+hrkLvpv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFQeViYonMbCtfb+SLPshoLqrHEUdUiwktX3cJMiswuojbvUshzahWkgg+VDcCw/TusmIz6kWlBIm4M8ydZz7KMPZncBLoZb+2s15YZpSErRN4nQ00HqIX/QbpArfEHiBCbS0isrs/Mk7QJoDX86kHlxW1zxj2cVtGRGoRsKehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wwMRaXp3; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6cdae28014dso7705737b3.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Sep 2024 09:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725552995; x=1726157795; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PjXtA67NkTqAhDw+xk2sd8wVjIX4v9yriXRxfqRD17k=;
        b=wwMRaXp3D0pfhxs6kI06VCpVnTjEHBNSheaRD4QaVBteBSHAzbUGezoU3PTC0P+fd8
         b9y2FJujU2DXRy7rkj6+EraD74exe5k50Cxv+A9qVA8r6S2m8NWKQUC1RebEc2oHgt4m
         6bH0afomWlz1+oOkrCwslPV30OTFy/yS7LfL3sA2Um88eONH6a8kIhPX11UYCg88YXZj
         YXyKP6Sn+RGbquCvWl8oJDd0Uf1IMsQS7XadKPcd9xJJbdj5KBpYK3LVO5d24vtPivcr
         gOZDr/A4VZuz0s3HmtYx0Od2mmhtP5faPbHGQF06v0GPFV8E3iM9TO3yf9XWH6P1LjEc
         1I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552995; x=1726157795;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjXtA67NkTqAhDw+xk2sd8wVjIX4v9yriXRxfqRD17k=;
        b=P6jSGRi76I7nboLUwKSeHifrfLSpqJW+HoF15J7BVwzpNNIyEcdNLtxoh0eDw9LT/U
         TErHFDi1QZDIfF5wO9Ua/E79nUTpr2IVtlxXJNK8WmSUmA054SndRddH6my7NsvuEz12
         iOYttg7bOeqCFXL8Bp7vnhS7+jAcN15iWJtFi5lZcjnntRSSwRsYE+VBex0kZJsV8oSV
         58aRjiSErp45uDi/OT9ikkIO6E0Z6UGXMUhok0kcVdMf057JbcgdQYmqQtskjFkSg/vp
         rpetYRc+9bDKSFj//g1EWEZcelSnUWx7Ok1eWqL4W0ojsgEQI0RO97YLuA/nlN49af9F
         vN2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbUjJmzOrHN3W2Rin8zadWl5xjM22ZjfviKHLj9AWf1XYQOHoMyB5bfZ4SSiHcdm6Cos9EZj1tKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyEAel3J7JV76f6p1s9SiPTd/Z4AdYwC46eVODJeZUa6UPNWjX
	IhBC/ibGMTlm8sEGFeWvDxV8w/r91XM4tOX1rSpwgx0xXvwQVsITlSwZyvLLnBxdd6y66jmVIyA
	qgEnJsDDDAohySpimjIi2m4kvC6kdR8YGy6xYYw==
X-Google-Smtp-Source: AGHT+IHF4JIHvjV5ZU5Sri1yZmo/2IQpX2mnsVMjFO6aJcUWOMDD1IaSX23mBNNsT/EI52Q3fe8hXyMFeVoPQnvlm3E=
X-Received: by 2002:a05:690c:fc2:b0:666:f7f:a05b with SMTP id
 00721157ae682-6db2583e3cemr61709927b3.0.1725552995374; Thu, 05 Sep 2024
 09:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823095319.3917639-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240823095319.3917639-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Sep 2024 18:15:58 +0200
Message-ID: <CAPDyKFpYgZwNvVnpS0fjmhcEq+yiBizxDTw9nJEyQF287miFJA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: imx93-blk-ctrl: fix power up domain fail
 during early noriq resume
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, victor.liu@nxp.com, 
	Dong Aisheng <aisheng.dong@nxp.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 11:44, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Dong Aisheng <aisheng.dong@nxp.com>
>
> After disabling PXP and having no displays connected, we met the following
> suspend/resume hang issue on MX93 EVK board.
>
>  Enabling non-boot CPUs ...
>  Detected VIPT I-cache on CPU1
>  GICv3: CPU1: found redistributor 100 region 0:0x0000000048060000
>  CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
>  CPU1 is up
>  imx93-blk-ctrl 4ac10000.system-controller: failed to power up domain: -13
>  imx93-blk-ctrl 4ac10000.system-controller: failed to power up domain: -13
>  imx93-blk-ctrl 4ac10000.system-controller: failed to power up domain: -13
> ...
>
> The issue was introduced since the commit c24efa673278
> ("PM: runtime: Capture device status before disabling runtime PM")
> which will also check the power.last_status must be RPM_ACTIVE before
> pm_runtime_get_sync() can return 1 (means already active) even pm_runtime
> is disabled during no_irq resume stage.
>
> However, the pm_runtime_set_active() we called ahead of
> pm_runtime_get_sync() will not update power.last_status which probably like
> a upstream kernel issue. But that's another issue which may worth an
> extra fix.

I think this is confusing, I don't see any calls to
pm_runtime_set_active() anywhere? Are you referring to some old code?

>
> This patch refers to the solution in the exist similar imx8m blkctrl
> driver[1] that it will power up upstream domains during blkctl suspend
> first in order to make sure the power.last_status to be RPM_ACTIVE. Then we
> can support calling pm_runtime_get_sync in noirq resume stage.
>
> After fixing, no need extra calling of pm_runtime_set_active() ahead.
>
> 1. drivers/pmdomain/imx/imx8m-blk-ctrl.c
>
> Fixes: e9aa77d413c9 ("soc: imx: add i.MX93 media blk ctrl driver")
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pmdomain/imx/imx93-blk-ctrl.c | 29 +++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx93-blk-ctrl.c b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> index 904ffa55b8f4..34ac7b722b90 100644
> --- a/drivers/pmdomain/imx/imx93-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx93-blk-ctrl.c
> @@ -424,6 +424,34 @@ static const struct imx93_blk_ctrl_data imx93_media_blk_ctl_dev_data = {
>         .reg_access_table = &imx93_media_blk_ctl_access_table,
>  };
>
> +static int imx93_blk_ctrl_suspend(struct device *dev)
> +{
> +       struct imx93_blk_ctrl *bc = dev_get_drvdata(dev);
> +
> +       /*
> +        * This may look strange, but is done so the generic PM_SLEEP code
> +        * can power down our domains and more importantly power them up again
> +        * after resume, without tripping over our usage of runtime PM to
> +        * control the upstream GPC domains. Things happen in the right order
> +        * in the system suspend/resume paths due to the device parent/child
> +        * hierarchy.
> +        */
> +       return pm_runtime_resume_and_get(bc->dev);

The reason why we *don't* use a regular parent/child setup of the PM
domains (genpds) to control power-on/off, is because there seems to be
a specific sequence that needs to be followed. So, instead we are
using runtime PM to control the power for the parent PM domain.  See
the comment in imx93_blk_ctrl_probe().

I have to admit, it all looks strange to me and seems also very fragile.

That said, why doesn't the sequence matter any longer during system
suspend/resume. Or maybe the sequence doesn't really matter after all?

> +}
> +
> +static int imx93_blk_ctrl_resume(struct device *dev)
> +{
> +       struct imx93_blk_ctrl *bc = dev_get_drvdata(dev);
> +
> +       pm_runtime_put(bc->dev);
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops imx93_blk_ctrl_pm_ops = {
> +       SYSTEM_SLEEP_PM_OPS(imx93_blk_ctrl_suspend, imx93_blk_ctrl_resume)
> +};
> +
>  static const struct of_device_id imx93_blk_ctrl_of_match[] = {
>         {
>                 .compatible = "fsl,imx93-media-blk-ctrl",
> @@ -439,6 +467,7 @@ static struct platform_driver imx93_blk_ctrl_driver = {
>         .remove_new = imx93_blk_ctrl_remove,
>         .driver = {
>                 .name = "imx93-blk-ctrl",
> +               .pm = pm_sleep_ptr(&imx93_blk_ctrl_pm_ops),
>                 .of_match_table = imx93_blk_ctrl_of_match,
>         },
>  };
> --
> 2.37.1
>

Kind regards
Uffe

