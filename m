Return-Path: <linux-pm+bounces-12353-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA809954812
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 13:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8212C2866C2
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 11:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59641990A5;
	Fri, 16 Aug 2024 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+y2GNCH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437B13D516;
	Fri, 16 Aug 2024 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723807856; cv=none; b=YfUsNSCb9bUeQeGLjpIxp9c48wlMTdEMdufPVc5snEd1V03syVa4f6Df9Q+rNJWiHyxUZLYSy1QFJFlrKMKx3M9uPjm2GhXgMuF68Ss0aKPWP2SC9gQLLn56M4emy4oMNFzcefSORm3llmExBBaawdOxaQqe2PfBqEnC92ZdYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723807856; c=relaxed/simple;
	bh=iTKp4GL48Z79wykXvhoQWKuCdyuAxySCPMOzA1kXgjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaRGvmgpTSG6OMSnsahv2AM4S5EuxC9/zHyiPW9pCvpi2Wa9V16DQWTraCje6bq8PybSr/Wo7mg/AW1x63LsPxbWtrkakmL0urZ2ubZF4jcHmKns4cPD6KZQ1dsK7nltWyFCR5TpAcuqYWee4/ZxHtidbwqtZpwQB0zQ88MLbO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+y2GNCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461DBC4AF09;
	Fri, 16 Aug 2024 11:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723807856;
	bh=iTKp4GL48Z79wykXvhoQWKuCdyuAxySCPMOzA1kXgjc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F+y2GNCH+SzibnVJKE+az41UWlMCnq2IGTHTPvj2VJaoFAZ3kaHESrY5uKZjcJ3io
	 ne8bKy8h+NBJdqhfeTkHuz5ZkaNhOmT0t44Y5oxPUemqeMnv0DgFpUZ5qu2tsHomXy
	 r3reCIf2NO3Dklh/ordWOrV3ccQiPeyrdGZ3z1brNF/xHp6VfI82bbunzn3b5woBt+
	 Q5fMyK5/uzMV/DnHP8qMFA5xU9cp3uGWmntMHLjRiuXSZr2PgacntQn2eHos39QRu3
	 PX1N2mhtkIkrN3DTp9/QxCM8q9Qy8lT54pNZ3Gl207pYNfiwDYAIAUEQcdPPw0/BXB
	 m3WNXQqA5s60w==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2702920904bso34465fac.0;
        Fri, 16 Aug 2024 04:30:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX4UcWFUNDDIdqrNW/xU23LsMRespXoKziSrDzClcNPsnIzvV+66YEAty8k/tI/yl1tTFNiVGzJmH9KcIPS@vger.kernel.org, AJvYcCXVFdPURXH4Mr5ZR5JMK5KO3ZuRgB9kYw8WdrD9o781UP6YsDpaaNvWETFL/A0CMtLdw/BgMI9vk5pXdUs=@vger.kernel.org, AJvYcCXVvZwC5mdGzUs+GdcIZxDW9bjhRZbIYuiotrJsuwmc4Wht1ai2KRqd7mPF+Dcg++SIyyjtMOTImnlZCcmy@vger.kernel.org, AJvYcCXpCx94PMK0QAX0tOqA9sncYmidxZGjZEc7mKeiBHTrT2lZdevlqC1RSMgky75o4yXc+R7ciOzvMuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSwqhjRELifu7axoM/+neWCx+DHHaW3WI1CH8ToBFidrZNfwaa
	Gvw1ENVO3r5nJwyckqye9/t9db5FNdLsXt6bDpcbYNwAxETAZnRN0t4eNRQ+QBsbSrbbaHiZkKu
	uVBpWzktUKDpyrAHXRxAE3mH9QkA=
X-Google-Smtp-Source: AGHT+IGksgxrJE/AET4H4ek77RLxaKWMQtUSxMwVquLrAblG2r4SkuvWW2DDOXFBthaYmRRm7m2Y273sUrVZjRR86Cw=
X-Received: by 2002:a05:6870:1495:b0:260:f1c4:2fdf with SMTP id
 586e51a60fabf-2701c5e26c9mr1514734fac.9.1723807854964; Fri, 16 Aug 2024
 04:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816-b4-cleanup-h-of-node-put-thermal-v2-0-cee9fc490478@linaro.org>
 <20240816-b4-cleanup-h-of-node-put-thermal-v2-4-cee9fc490478@linaro.org>
In-Reply-To: <20240816-b4-cleanup-h-of-node-put-thermal-v2-4-cee9fc490478@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Aug 2024 13:30:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j9WTzd5qg3bLLB6Y41xu1zoJMy7TV1xhFxEzW-x=b5=w@mail.gmail.com>
Message-ID: <CAJZ5v0j9WTzd5qg3bLLB6Y41xu1zoJMy7TV1xhFxEzW-x=b5=w@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] thermal: of: Simplify thermal_of_for_each_cooling_maps()
 with scoped for each OF child loop
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 9:40=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/thermal/thermal_of.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 94cc077ab3a1..ce398fde48bb 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -373,7 +373,7 @@ static int thermal_of_for_each_cooling_maps(struct th=
ermal_zone_device *tz,
>                                             int (*action)(struct device_n=
ode *, int, int,
>                                                           struct thermal_=
zone_device *, struct thermal_cooling_device *))
>  {
> -       struct device_node *tz_np, *cm_np, *child;
> +       struct device_node *tz_np, *cm_np;
>         int ret =3D 0;
>
>         tz_np =3D thermal_of_zone_get_by_name(tz);
> @@ -386,12 +386,10 @@ static int thermal_of_for_each_cooling_maps(struct =
thermal_zone_device *tz,
>         if (!cm_np)
>                 goto out;
>
> -       for_each_child_of_node(cm_np, child) {
> +       for_each_child_of_node_scoped(cm_np, child) {
>                 ret =3D thermal_of_for_each_cooling_device(tz_np, child, =
tz, cdev, action);
> -               if (ret) {
> -                       of_node_put(child);
> +               if (ret)
>                         break;
> -               }
>         }
>
>         of_node_put(cm_np);
>
> --

This clashes with

https://lore.kernel.org/linux-pm/1758256.QkHrqEjB74@rjwysocki.net/

which I would prefer to go in first if you don't mind.

