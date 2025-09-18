Return-Path: <linux-pm+bounces-34969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DB2B8585E
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 17:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E743AD268
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 15:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CB0307AFE;
	Thu, 18 Sep 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zp/SOqSq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D655923B60A
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208507; cv=none; b=VKBziPm7wh2ZCSylBvfooa4ROni5FLULU7YxZmT2T6f2iK7gtvNRSReSj7NSeCA/ZpHB0QQ6HxUjRLjayTlgA6e+5jMSmos9jpaPoD3haD87uE6IWpEM67r96phsh6Vpd/MKa+Pggszp3B/iHITsvktjAt2HHQuBI8o2TyezwSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208507; c=relaxed/simple;
	bh=W5nTjMEiqZnba5g8e3Gi7lUj7gQH38jU4DdLi32iJEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sw7Hw6mw353pE3ytAwA/6HIL+16SCjiDl6olU5bG+aLX7PTyKDiu/d5Ujfjn8nHRJ27qLJQ/8wlhW7yxceTyBd9nSDRXXugqBftT/7evfgSaNmdfH6CSBwauXeVgHx9CHYLc7op9t/ZdI9GwNgZJ8NoPz/OwWh4PPAYjPi6mw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zp/SOqSq; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-73b4e3d0756so3433037b3.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 08:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758208504; x=1758813304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OFt6YzhskfMz4G5ASFBcNJdSZpqtygY9kyuCw6Wbqgk=;
        b=zp/SOqSqSMI5TW4vac7YZCkoM9yhF0pMqb0QTI0ezQjs1cYd0yO6U+s5kfa6TAT35K
         EuEhHFpdmfWDaWGY/EQkP/ejyIhf+H8vvhUMfYXBq/x0xjBcU+Bllk6lXsr2eccMd528
         4P8EpBsktYPSTCPwv3th5y8rtpFaUwFMwSoiRSGleDnx/TXO5dJE1t0VXgLBnE8L+02i
         gUChk7v08DwLvgwe0mwyPBWDCSFgqvUwk4fN5kwbX4ZaknTZmMS5Qo4UFxrqcm+KagT2
         Unnl6S72aYIYHH5+vX0CFZ6YeXuRLd+WSz1LsN310YMoO608Hk4933mL1tRto5OOVAyC
         KuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758208504; x=1758813304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OFt6YzhskfMz4G5ASFBcNJdSZpqtygY9kyuCw6Wbqgk=;
        b=Yc52VPIGo5zKCPTCOICSsp1Ln44nI5EgJ2d1fuWeA/EjdOJr71dk5KvURBVmF+inmy
         viTElDUAQHE9QmG5+8HhhfrIJvx3mBBJxnUIBNqG3H8ObosAreOr92sq9jlG4rl/Hj/P
         U5JD+H/QPs0gYyjV2V5bU8O2CASN7/3HSvOezoiEuMT7ZduWnW+3nt4LXP3JN+YjH7/0
         h+8zfWHYBoQC8NULZPrR/nhJ1Ots8n1Tzh7mMnBUONOb1FLXBv7qs/edJxm3OP7HF5ut
         Ncy/eND9+Is+uIezLpbtW0qhEChv7KyX2llhM4bEaPdXA+zrMA1LuYdBep6y+yNHIp/v
         +3Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVHxMvwFeVx0/7tdK5tUYQ6Pa8UUA2Brb6MHtIg8pFWzkShTW7NpIF6OiT9kOIeYoqo5tU3tK2Q0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ER7KSU8fvsslpuX1ZN+LNyPLdjUXzuZBc5i3MVKVqhrl2Bce
	pWi+6VZ2G+PAlQSeW01MqgGoB1gMIzroXFY3Hn4htBHyR3f7xF2fOQHaBkK2/OF6296dgOicF/j
	t40sbVtE7ffql3Ip3yq/FkJEo1pF9OUUeNw8Ye7uNuw==
X-Gm-Gg: ASbGncvc1UHYtKiBHRrtoivQYWcodeUBFa8nSsqoYL6VVeH54xdmgKsoIg5WG+1UjQM
	gzGlb76c0mm+A6IbutxC+pRgYQptKYiKSK4a6h4HVrhJBpyxq1DK621q5A/YOr64KPQXH1DFgVF
	XOvRlM8kv04vfUPELOOJa09fxEJyQfMZsvczlWsAqtUUY4aQH5/ACapBBkKxisuCKN/PiI8qUoH
	mcSxhRXffuTJ9gjaANPOOnjkmg=
X-Google-Smtp-Source: AGHT+IFWx6n1PzkYYp5utqUHYs3cajDfg2GyxSlUHuEjN16hnOdbRT6rrrmIdLRynF4h/+ErT5T1ASVcKks2d63Qrt8=
X-Received: by 2002:a05:690c:7281:b0:731:6570:132 with SMTP id
 00721157ae682-73891b87069mr62837047b3.35.1758208503588; Thu, 18 Sep 2025
 08:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com> <20250902-pm-v3-3-ffadbb454cdc@nxp.com>
In-Reply-To: <20250902-pm-v3-3-ffadbb454cdc@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 18 Sep 2025 17:14:27 +0200
X-Gm-Features: AS18NWCdTZsclOkAHpdSQCQjKeMfCrt_EDcLieD3X8xYbm6A6ARROAgFxf2mSRY
Message-ID: <CAPDyKFq1Coz4rbdam01s3pOCDa=Et2ePmf7niLSgOdjCbnEANg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] usb: chipidea: ci_hdrc_imx: Set out of band wakeup
 for i.MX95
To: Peng Fan <peng.fan@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Peter Chen <peter.chen@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, imx@lists.linux.dev, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 05:33, Peng Fan <peng.fan@nxp.com> wrote:
>
> i.MX95 USB2 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
> power domain(Digital logic) is off. There is still always on logic
> have the wakeup capability which is out band wakeup capbility.
>
> So use device_set_out_band_wakeup for i.MX95 to make sure usb2 could
> wakeup system even if HSIOMIX power domain is in off state.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 8 ++++++++
>  include/linux/usb/chipidea.h       | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index d7c2a1a3c2715967203b98c819fa864e06a00a32..a2b3f673dfc1183a02783bf6ef92f8570c6042cf 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -79,6 +79,10 @@ static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
>                 CI_HDRC_HAS_PORTSC_PEC_MISSED,
>  };
>
> +static const struct ci_hdrc_imx_platform_flag imx95_usb_data = {
> +       .flags = CI_HDRC_SUPPORTS_RUNTIME_PM | CI_HDRC_OUT_BAND_WAKEUP,
> +};
> +
>  static const struct ci_hdrc_imx_platform_flag s32g_usb_data = {
>         .flags = CI_HDRC_DISABLE_HOST_STREAMING,
>  };
> @@ -94,6 +98,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
>         { .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
>         { .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
>         { .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
> +       { .compatible = "fsl,imx95-usb", .data = &imx95_usb_data},
>         { .compatible = "nxp,s32g2-usb", .data = &s32g_usb_data},
>         { /* sentinel */ }
>  };
> @@ -570,6 +575,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>
>         device_set_wakeup_capable(dev, true);
>
> +       if (pdata.flags & CI_HDRC_OUT_BAND_WAKEUP)
> +               device_set_out_band_wakeup(dev, true);
> +

Based on my comment in patch1, I think we should set this flag from
within a system suspend callback for the device in question.

[...]

Kind regards
Uffe

