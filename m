Return-Path: <linux-pm+bounces-12366-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E35D2954E64
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 18:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC7FB2393A
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480271BF309;
	Fri, 16 Aug 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6XS9IMV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F921BB68E;
	Fri, 16 Aug 2024 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824176; cv=none; b=rfzYoWa6u/hcV39OKDSwoRyQDzSwDi8xEmpdSpzJPAvEqD2ZBMvldnLpWUAb+ts1m9aBJkdmWbVE2Zf0gJAL2oCX+RyneJIivCtlbV6YWymqsrvy1ytaA/tjLObfOFPsxtkgxQrWD42clFbZ80/S+cMac4lmIzQ4OTZHYFFVXqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824176; c=relaxed/simple;
	bh=ojxinrOLcNbVPPySpuUlMDM4K5NF51Th8jrtqoS20cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQ1D3IvDccgXugaXcYO8d6H19Ok6QE9JomNqNsGQNMrBIU5Ynr7OIJr6Y/hXEMAWeys54L/vOg7eM+y3mZEeNVNIz57uMGfj22Y6LlN6Hv3l8OkEjsgX8mjVd+y3yWs1zh2pXkyVsT1Hxa+wGaocqRensXEy82iTxqf+flqsNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6XS9IMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C280BC4AF0B;
	Fri, 16 Aug 2024 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723824175;
	bh=ojxinrOLcNbVPPySpuUlMDM4K5NF51Th8jrtqoS20cg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U6XS9IMVKC34MPnxz65HHLOwwDzDPs4pNteWmVXQo2fPky2z5uchrNhUtqKX5EK7h
	 +sU1R//EFZ0eTQR58kQNLdk0PqUwS1ZojjwsGn0/TpOGvCp4YCEO9i5KhiNGiFr/zN
	 zh6WuM5cAFleSAlas8PDfIxjS1kOSzxGdMwmCmsRCmbYXZuhydcBiVB5gWYa9JuwRK
	 b4uD0O+mCaJrWIQqJF1pNHFiUSz6Gbo3gQ4VoftrMjTi8GDGq1USfK50Oj8rLHZcux
	 qAJSoCGmjIp/LeqmBg3iaqNxTFHrk29CT2YOmOjpP8DPnP90jnmUEXRlh1TYeeU/H2
	 K80AU49JkwQOg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2610c095ea1so299616fac.3;
        Fri, 16 Aug 2024 09:02:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSPf7tkgyTdw/98ehGJFzNLc7yPTlUSkdTzljf412j+SVJX7UgVM0r2nQkRR7Im0Jcmno5jby37qI=@vger.kernel.org, AJvYcCVuvr7pBxb/FpBstRgazoaxSxAqH6Go4A3YLf6zL4FEMX36rqxPZ+sKWdsy7DSfwFz7F86fcO7kJGJrzOx2@vger.kernel.org, AJvYcCWIhfybxHA+sBNqk3EBlFNybfyIIk6Z9gyvxo3vM7wgQ0X2QnW628Vf9B+6xo2QFEyy4d/7WIZZfh1Ai7PE@vger.kernel.org, AJvYcCXa9xdD8AbA90uMYekMZPRIHJ0mKAXmhJ4gZkTE2F/k+UpAG8OLtAM97mueIm3ZEsheEbRln8/MVdyaNbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Y2js8Dd1Lv9VVoh7OT+b4FOyRVrCipscHBnVYQ9rwqlcnzgD
	HyV9DnE13yx8RmtMQFuPRS63hlfyK/mQKM5DdKa7yZOO/z2jwRwq3Lg4kDp/xq98pWMH2lZuZ1k
	o9WIEUlLaOjTCX1rQ0vf7kDxEyj0=
X-Google-Smtp-Source: AGHT+IEDPxTrNj6EFPbZPOKHv1diO/kM3WHBW6ox5eiR/xox4p4nBVhdyxkPOCjWMWDzftuYBn/6jRnxKDNjx57c3Zg=
X-Received: by 2002:a05:6870:b253:b0:25f:401a:2ec3 with SMTP id
 586e51a60fabf-2701c0a7b6fmr2095254fac.0.1723824174920; Fri, 16 Aug 2024
 09:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816-b4-cleanup-h-of-node-put-thermal-v2-0-cee9fc490478@linaro.org>
 <20240816-b4-cleanup-h-of-node-put-thermal-v2-4-cee9fc490478@linaro.org>
 <CAJZ5v0j9WTzd5qg3bLLB6Y41xu1zoJMy7TV1xhFxEzW-x=b5=w@mail.gmail.com> <3b33d0b0-ae9f-4afe-af2f-9596394bcc4f@linaro.org>
In-Reply-To: <3b33d0b0-ae9f-4afe-af2f-9596394bcc4f@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Aug 2024 18:02:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ix+mJy6snyYuYg711ERmbJ8cNYV6DtmK1WZGur-Pd2-A@mail.gmail.com>
Message-ID: <CAJZ5v0ix+mJy6snyYuYg711ERmbJ8cNYV6DtmK1WZGur-Pd2-A@mail.gmail.com>
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

On Fri, Aug 16, 2024 at 2:22=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/08/2024 13:30, Rafael J. Wysocki wrote:
> > On Fri, Aug 16, 2024 at 9:40=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> Use scoped for_each_child_of_node_scoped() when iterating over device
> >> nodes to make code a bit simpler.
> >>
> >> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  drivers/thermal/thermal_of.c | 8 +++-----
> >>  1 file changed, 3 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of=
.c
> >> index 94cc077ab3a1..ce398fde48bb 100644
> >> --- a/drivers/thermal/thermal_of.c
> >> +++ b/drivers/thermal/thermal_of.c
> >> @@ -373,7 +373,7 @@ static int thermal_of_for_each_cooling_maps(struct=
 thermal_zone_device *tz,
> >>                                             int (*action)(struct devic=
e_node *, int, int,
> >>                                                           struct therm=
al_zone_device *, struct thermal_cooling_device *))
> >>  {
> >> -       struct device_node *tz_np, *cm_np, *child;
> >> +       struct device_node *tz_np, *cm_np;
> >>         int ret =3D 0;
> >>
> >>         tz_np =3D thermal_of_zone_get_by_name(tz);
> >> @@ -386,12 +386,10 @@ static int thermal_of_for_each_cooling_maps(stru=
ct thermal_zone_device *tz,
> >>         if (!cm_np)
> >>                 goto out;
> >>
> >> -       for_each_child_of_node(cm_np, child) {
> >> +       for_each_child_of_node_scoped(cm_np, child) {
> >>                 ret =3D thermal_of_for_each_cooling_device(tz_np, chil=
d, tz, cdev, action);
> >> -               if (ret) {
> >> -                       of_node_put(child);
> >> +               if (ret)
> >>                         break;
> >> -               }
> >>         }
> >>
> >>         of_node_put(cm_np);
> >>
> >> --
> >
> > This clashes with
> >
> > https://lore.kernel.org/linux-pm/1758256.QkHrqEjB74@rjwysocki.net/
> >
> > which I would prefer to go in first if you don't mind.
>
> My other patchset which fixes bugs here, could go in before:
> https://lore.kernel.org/all/20240814195823.437597-1-krzysztof.kozlowski@l=
inaro.org/

Right, but these don't clash significantly if I'm not mistaken.

It may make sense to push them for 6.11-rc even.

> so it will be backported. Other than that, I am fine with rebasing my
> changes. There is no point in refactoring the code if it is being
> removed/reshuffled :)

OK

