Return-Path: <linux-pm+bounces-40147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4039CEFDDD
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 11:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16168301F8E5
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 10:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E842D0C8C;
	Sat,  3 Jan 2026 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wm75/+kc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C0B239085
	for <linux-pm@vger.kernel.org>; Sat,  3 Jan 2026 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767434608; cv=none; b=QyHfngAw6BPPqSxUwbRKweyBggvURTcMxWkkr+Y67pZ5+XXmvz89JPTsxGccnEnNb05/VLi6Qn9jHsgWZAHmpTj/hCUvv1NO2Td3xN6Tu7g5XYrnJiWcA+OJDp7eDkRaZmXORnmlnxWhyNm2f1V7xs7yTDfZdPHL44OnOR61uGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767434608; c=relaxed/simple;
	bh=A94DAyTO7kYqQUnINuHd8gangTUwz1WgeTPn3k7pJEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+DhpdEkDHEksX+kqRFLxheQFT7gD63A39BFmkP+3uJx1nimpmYawedubs7vyvDAEZ0MFJlkRhYfGxXZVAAjmUjwID2HMvtM7z7SDQd+h5tgd0aJR9UJ4puium5d0YcgDA8izuXLYUkdHruxEWBgcSfaMcBTqXciMl1f4g77fjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wm75/+kc; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5957db5bdedso14571198e87.2
        for <linux-pm@vger.kernel.org>; Sat, 03 Jan 2026 02:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767434604; x=1768039404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bDXSZppGA43wphmZJyL9aJJ8iAZCIXmj8aHnH0wAQ/k=;
        b=wm75/+kcB+W3uqP2lD/akxsDeuxWdoSwUB+er0lLY+X1fWXkYryzoK6CpfzillxUDh
         FJaexOoiniW1cGRUimOpPfXJqFTVTcgyAy2d2vUakbck7VZh/E/wKPbz5kbs3uApWL3B
         prvNqe4pCP36DqL6vL7HQYXpLiu5qwm1NQP1JKybPmDzQBnL5tUUQlIhsOayzzd7Adeh
         OXpB5YjiFv2TLsfJN5xn9ja8OlszLiymD0DdqkamOaI7xQLiptGjmCReUcKmxNvJSbGu
         qt7Cl9Syrq807FFZQQWbLwW4c7/+XmkPfE9ikNr2WmbF7lMXvfiwzs/kf6mbPbC5ivix
         DpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767434604; x=1768039404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDXSZppGA43wphmZJyL9aJJ8iAZCIXmj8aHnH0wAQ/k=;
        b=xJ3iaXiZMjyclg6kGrz5fvB1nY8wnG0ReekXx83TvgzrNwQxY1zDVHWOuW+uLbIZGk
         s0vJwd9u79pLXpwWMKGr3unywrMh/s0ZZSuefmy5hImv/3cMSqCoqvFnuMIB7dkbtxGe
         UeG+1Ec3APRYzRoBee6+FJmeK9qykyfaZCA+LU3g6BtCufNRbEsFfR2PysCRHG8rJo76
         vxOlqqPtsuQlyLfFEO9AnVSyRQMcbP6AIfY+0RHp/G0kImqgifaC44m5+ZPvhxWefy99
         5ZxPdYA1Bvbqd5tfsjvTm7YryBwP+7KHUHcFtYc2dUvniE2MAYj218j9GXlOPoiifGeu
         JwIw==
X-Forwarded-Encrypted: i=1; AJvYcCXHEx6YMzKMrhvVXZqXV9katJYTqmuecKagMJQpUf0tbzV3GX6tFLyzbm8p+FO4bF8CrkeOfL20Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8QFDWIvj9gMBFJkh23v3HRbVUHEj26DYJbGVRxYWiVLe3nMX6
	DWswaWE1O6pRnYuCAYL/J2oKEK0muo6jGjEZ50lBq4b+e/xEPV0k/kZQD2jUuIu+CzG5ab0MHxu
	F1AiH3j8WqxDeEIDcfZTrOVOEo8GxrvE1jkmgavhdGw==
X-Gm-Gg: AY/fxX7RkM9d3Y2lnK38oESOtER+WwEIs/ZlJJrcHv390YfW3iOCTwW8ozYOxnYN3ra
	a1K+LLNnig4Iz8y14cCbOgeHwxQP8fg4ZjaEU7Ao707+eqpWhGGdINa9mV2DhHUeXGFIQ/yhXGa
	2cMSObXUbiSWZuBKw/CZyFUSlucWOT+cLTPEijMk1raPtBNTUR4Dng3wiUn2oe0hZtlSlFh5xdu
	2ZBqHLCGkC7aM2VKvPQ1P1s0ikK9r88ZNn1+mki8K1A6S/C9dhR/ZAAXJEd5Yfjlq3EcipH
X-Google-Smtp-Source: AGHT+IFKB5FPDCXC2bA+k7uKQBiw0br0n5E1yiLNSCnfVzhkAKxTdSHEp5ZWB2TbHk2W/He8NymlZBgfriNTTFeJlI0=
X-Received: by 2002:a05:6512:10cf:b0:59a:108a:31fa with SMTP id
 2adb3069b0e04-59a17d18076mr14943741e87.10.1767434604071; Sat, 03 Jan 2026
 02:03:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205015428.643-1-ming.qian@oss.nxp.com> <20251205015428.643-3-ming.qian@oss.nxp.com>
In-Reply-To: <20251205015428.643-3-ming.qian@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sat, 3 Jan 2026 11:02:48 +0100
X-Gm-Features: AQt7F2oMTRKk7t89Y9gE75MVMNztzWV9UDfi1TNNrPc77CmFOSHTt5sl2zwMryU
Message-ID: <CAPDyKFq2iWX-axxnKHisRHwKJqnyHYm5oM2_UKZaeQduKdYkFw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] pmdomain: imx8m-blk-ctrl: Remove separate rst and
 clk mask for 8mq vpu
To: ming.qian@oss.nxp.com
Cc: linux-media@vger.kernel.org, mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
	nicolas@ndufresne.ca, benjamin.gaignard@collabora.com, p.zabel@pengutronix.de, 
	sebastian.fricke@collabora.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
	l.stach@pengutronix.de, Frank.li@nxp.com, peng.fan@nxp.com, 
	eagle.zhou@nxp.com, imx@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Dec 2025 at 02:55, <ming.qian@oss.nxp.com> wrote:
>
> From: Ming Qian <ming.qian@oss.nxp.com>
>
> For i.MX8MQ platform, the ADB in the VPUMIX domain has no separate reset
> and clock enable bits, but is ungated and reset together with the VPUs.
> So we can't reset G1 or G2 separately, it may led to the system hang.
> Remove rst_mask and clk_mask of imx8mq_vpu_blk_ctl_domain_data.
> Let imx8mq_vpu_power_notifier() do really vpu reset.
>
> Fixes: 608d7c325e85 ("soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl")
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> v3
> - Add some comments
> v2
> - Update commit message
>
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 5c83e5599f1e..74bf4936991d 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -846,22 +846,25 @@ static int imx8mq_vpu_power_notifier(struct notifier_block *nb,
>         return NOTIFY_OK;
>  }
>
> +/*
> + * For i.MX8MQ, the ADB in the VPUMIX domain has no separate reset and clock
> + * enable bits, but is ungated and reset together with the VPUs.
> + * Resetting G1 or G2 separately may led to system hang.
> + * Remove the rst_mask and clk_mask from the domain data of G1 and G2,
> + * Let imx8mq_vpu_power_notifier() do really vpu reset.
> + */
>  static const struct imx8m_blk_ctrl_domain_data imx8mq_vpu_blk_ctl_domain_data[] = {
>         [IMX8MQ_VPUBLK_PD_G1] = {
>                 .name = "vpublk-g1",
>                 .clk_names = (const char *[]){ "g1", },
>                 .num_clks = 1,
>                 .gpc_name = "g1",
> -               .rst_mask = BIT(1),
> -               .clk_mask = BIT(1),
>         },
>         [IMX8MQ_VPUBLK_PD_G2] = {
>                 .name = "vpublk-g2",
>                 .clk_names = (const char *[]){ "g2", },
>                 .num_clks = 1,
>                 .gpc_name = "g2",
> -               .rst_mask = BIT(0),
> -               .clk_mask = BIT(0),
>         },
>  };
>
> --
> 2.52.0
>

