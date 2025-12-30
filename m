Return-Path: <linux-pm+bounces-40048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4858CE9E05
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 15:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F0463001C11
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 14:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5492E1F9ECB;
	Tue, 30 Dec 2025 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EcnZ9vv/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A351EE7C6
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767103698; cv=none; b=bHwT00tbm2CAN5J1NTcWOoNyhDWw5hX/mkDMhbzl2/zWmfYVt/TCWvEp2Ba1Gs+vagcFAT4e8iy1R7Vy8xijjoyKfGSxpBuE2Xkte3MhqXyREIx2VJzEfTA7k/ashq+EcZ70FyA+QOkxp3xz7jcZqEqGG5jsNb+9m1OCA9x9uR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767103698; c=relaxed/simple;
	bh=d5b20GjOZmEe7MLdyY8hDIhd+/ediIvuv0ZzoeBumSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrDWib4cg5ui0JsFI48Nge68JHj3OMsyGoQqTrUmnnL5v2q+xB0Sm7sGxrxkEQKDScsG2Hrdjk/5Wy4e7N98SpjuFuZBBN0JyACFEuo6MirjS7q20caiq78fz7+e12O5i3Dxm7ZN2ZK2K1iGOQz9r0qs78v7u9k4S+9/Z5uL7iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EcnZ9vv/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59583505988so15474533e87.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 06:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767103694; x=1767708494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VyJApu1LEoZShSyHFwCDEnHWsxopeMuohegEMjDmgz8=;
        b=EcnZ9vv/3har4lcrpUgmRbnPtEwziVmLBHWbDqT72aJXxx2VmPzz56kMk/nWJQEnMy
         s0lO7dRT2im+JF6anTFP5FCFwuHUUrm54Q6DJ7jOtzgwShoEumwbCCbjDl0Litbf5KrK
         rDAZb3/dFEDU1Qb6gqUfyVV9+hZ6BHgKoH+Y0Db1nVIh7giz0YPAO2Ypc/1hmLGKHnrY
         xr/tH7JAGHAmJ+FSbyBXeyalSIilCKL2B9i8vnSnX0J4fxX6ioMTjC0eSggscyOngKvU
         AVw9G7HMHF+RC3C2T6AQU7cw90JaBZb6FDmyCE/3md8lH9RhaWiXLpFPtpDhsuDN89lW
         bWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767103694; x=1767708494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyJApu1LEoZShSyHFwCDEnHWsxopeMuohegEMjDmgz8=;
        b=WIn1Ya7rbCW/R+2d+eTmPhavrn5LYlVEpa1WLg6OGMa16Qh/OhLXhyJD4p3KbEpJJP
         PRJRFgG5H9RmdIZu7bViZzzdetylcJWXJVGuck1XkZkJGJ4H/s7jj9hCGdjBgt1twgly
         4TXs64SimpSUWZiq0AKRMB3XvWALOO+BUN6hOlW0GX5//Lbx8WP46pyC1JWYqB84SWZH
         O0ruOhX4YgSiG0/V2x47qeESghsELvbaQ6NTQSHDEhI3U5qpbd7GR4aZCnqEQhHJYoo+
         U8iaFJZ5I3CeifbQHyY8OHRxZJafKajJl1emzuz7iFIERH34ML5LLoonZU8oLGPq6WuT
         n4qg==
X-Forwarded-Encrypted: i=1; AJvYcCWpBSsvsM4+KedmuXmPDs0Dmo28sjq6yRHmOgqqPmTkauPVrlSN8V92pKFs0/J0d258BPUNWUfeCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMc6gxovQ68si4vrFlyJV4G5W1AssA+xU+6W9u6U07Jsb0536g
	78Dg/JWbluatPxSEEMI1oi8/q4WNqtn8dIGiDG+RZZK3b20ppICyPPiFx20LQDc346cGJelXNIp
	DlCYwJDgJhcC2uPgGrnf8Dyw6lVG2qdnvUV6SADBFJQ==
X-Gm-Gg: AY/fxX7cOjPKgtcW5aPJBEC/jgFSXPCZ+B0XdJrME3yFKFm0w5H3bD6yustX/KzVzf3
	DZpUKnMSQMtTjiB9q3j/3FT0DV1hgcGuEpPdCxlOJcz8wE2Z/Lkprqu19CMMsKOABX9OeJrxvB0
	jLpc/5V4Mo1LbmJMoY9z1PkZ6JzfTfBIdg02QUQlJMrr0oUpnoRHTcgBl29ccZr6h/mQRZ6lg9u
	ei02nB5ZAz4QKrGYnPr6acDi74fqxeXXO5dVKc7YvtZd/2l/5mpf5Z5HTyVxLHlyJ6Aw6MfkaKd
	p9hUeRM=
X-Google-Smtp-Source: AGHT+IE5fYKXYm6s7wg7VCYj3x3U8vGECYHQuPDTbdIUhcnUk9fct3+MvwocLHBZETGEXghR/RioxsyFpqqrT1jVOi8=
X-Received: by 2002:a05:6512:3d9e:b0:595:7d7c:59a9 with SMTP id
 2adb3069b0e04-59a17d6bb20mr12422984e87.22.1767103693612; Tue, 30 Dec 2025
 06:08:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216055247.13150-1-rmxpzlb@gmail.com>
In-Reply-To: <20251216055247.13150-1-rmxpzlb@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Dec 2025 15:07:37 +0100
X-Gm-Features: AQt7F2pCXsP1gwfFRKDfAs1-CtV1ujaercDhCS5Kpm883EIuOK5DFfbTj1RsrhE
Message-ID: <CAPDyKFpx-hxv4QVW+zp8Zbd=-9vvmwsVJ2adem6V1gWLQteYsQ@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain:rockchip: Fix init genpd as GENPD_STATE_ON
 before regulator ready
To: Frank Zhang <rmxpzlb@gmail.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	linux-pm@vger.kernel.org, chaoyi.chen@rock-chips.com, 
	sebastian.reichel@collabora.com, quentin.schulz@cherry.de, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Content-Type: text/plain; charset="UTF-8"

+ Nicolas

On Tue, 16 Dec 2025 at 06:53, Frank Zhang <rmxpzlb@gmail.com> wrote:
>
> RK3588_PD_NPU initialize as GENPD_STATE_ON before regulator ready.
> rknn_iommu initlized success and suspend RK3588_PD_NPU. When rocket
> driver register, it will resume rknn_iommu.
>
> If regulator is still not ready at this point, rknn_iommu resume fail,
> pm runtime status will be error: -EPROBE_DEFER.
>
> This patch set pmdomain to off if it need regulator during probe,
> consumer device can power on pmdomain after regulator ready.
>
> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
> Tested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

The problem with the child-domain using a regulator has been discussed
before [1] between Nicolas, Heiko and me. That said, I have looped in
Nicolas to allow him to share his opinion about this too.

My view on is that I would prefer that we try to address/fix the root
cause, rather than trying to paper over the problem as what seems to
be suggested in the $subject patch. Or at least I need Nicolas/Heiko
to confirm that they are fine with the $subject patch, before I pick
it up.

Kind regards
Uffe

> ---
> Changes in v2:
> - Simplified the regulator check logic, trun off pmdomain if need
>   regulator.
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 4f1336a0f49a..997e93c12951 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -879,6 +879,16 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>                 pd->genpd.name = pd->info->name;
>         else
>                 pd->genpd.name = kbasename(node->full_name);
> +
> +       /*
> +        * power domain's needing a regulator should default to off, since
> +        * the regulator state is unknown at probe time. Also the regulator
> +        * state cannot be checked, since that usually requires IP needing
> +        * (a different) power domain.
> +        */
> +       if (pd->info->need_regulator)
> +               rockchip_pd_power(pd, false);
> +
>         pd->genpd.power_off = rockchip_pd_power_off;
>         pd->genpd.power_on = rockchip_pd_power_on;
>         pd->genpd.attach_dev = rockchip_pd_attach_dev;

[1]
https://lore.kernel.org/all/CAPDyKFr=GwJ+cO3cW4Ed_LsS=q_JtuuQPDweDpLgDO4hBLFXUA@mail.gmail.com/

