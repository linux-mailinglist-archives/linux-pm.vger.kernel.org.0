Return-Path: <linux-pm+bounces-40941-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CB5D25BE1
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 17:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1D3E300BEC5
	for <lists+linux-pm@lfdr.de>; Thu, 15 Jan 2026 16:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2C239C624;
	Thu, 15 Jan 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXPLsGKp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7873A39E6EB
	for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494263; cv=none; b=LXJVrnz6GP94M0tF41t5nIS//CSyU6A8dkxsZ0QXtmr7K6DBJqh0B6HktAaFZ6bBS5+EkDjy3NWlGmyHEVpjjfvw8jrLl/vYG4sQYUgZFC6ok5DVI725jlG91ynr/stIpUdXPe4Cn1zv9txV+twnxnkVzF7MwovZ0VmzY1xniIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494263; c=relaxed/simple;
	bh=/DuIE6mRzwj/+bMbVcAeEzXFJYClbB5uV0Jy0njq9n4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvVv7Stmn4tvgjsD0KOMYw1H5ZoKxtdmlnvwuk2Rtj/3VR4PA94TCzBFLJycVw/6TwCU8+4Y9vBrtY5WrV8idngrJVX7ok3HKEOoDLqq3U8tUKioNc52FgU71Dz2CTxGw8MLtmEfUnjxWy83xj2HzC6OCjoXl/4/oPXfRWgXfe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XXPLsGKp; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-382fd8aaa6eso9811191fa.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Jan 2026 08:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768494260; x=1769099060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z6eQcDBBoiOSc1c+K4AoT/0VH8sQq4tUq5ijhJiu4pU=;
        b=XXPLsGKpK3vwk7YWp4n2jIYiomSiGjGkISy5Qk0AFYxYqLlo2F+uzkkzjaXTl+hYiD
         p3vPRZA/vly+/gW2X+QkyhWqcssrHZJYE5whaquhoUD+oRriRbuP7BRnQcihRJ7lHHjr
         1EmHmsKH9xlvDbTY9Z+YhKxYNJrd4HkqkN9oett3iVoFOsDkVzQtX5BU66c1zyl9Xs77
         eIETJybmZ1lPFQMEEm0diFnCrObBf9uv9ACCBhiawWXmk3I1a552r/X257yvJ1GUjEKY
         1WdaqXeeXlu8veNc0l5QOLlbMckXs0LjQBGa3DdkHp2yhd+6/+DqPt2zKVECtvsP289o
         uvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768494260; x=1769099060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6eQcDBBoiOSc1c+K4AoT/0VH8sQq4tUq5ijhJiu4pU=;
        b=UmMjJe1aAhSiu+y2udkPjk9z3SddGJmmQEV5zReJkZuV3kxVWUD+sbekCkO0mrycpx
         fDs2V+n3rWYxTSI8jYBXJx+HcUyCNLixMUfetRDv005lCz6wwgn4y7SVwdq6M8RecWfu
         GooObYM+rJ+fkZ6DeTr7NdS2xdDaKvxhe3qHvJWxONuXPiAJZNhX1phk1Z/86w6wfP21
         sYBBi35hZR+bwRW0XMeFtXPTWRsNJEopdfOCxU5wFs+tuxzelIRV0mEM9Y+yWFjwATvb
         0hfub6et853zYC1+81MUzUouABFkmwc0AVGrbTtWNNMGjR6aMOmv06FGJrWKpKo1D3Ef
         z/uA==
X-Forwarded-Encrypted: i=1; AJvYcCWBj79yFI3gCa1KWaHMzo2ekvqb2uoTHQSEtUGa+iNCQa3jUSWg+7NvHFsQmyPscns8BXsR4Tjhiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4Uar7iGWijWySDsfxcY2P6qYZqLzilMjccHn/hpLN9ShGEK/
	hWGFf/c52j2zdvkT8GSCIp3AjtPnUc0WDzMXzCSSWfcGiK4DiwVuAvFQEMzoPQyKpJpPLaWLwgy
	N2bslV+8miGo7kgSIiWMzCS9XFnf53VgqmvysB3R1RVRPV5p1Q3Oj
X-Gm-Gg: AY/fxX6kAqucx+C3tTcS7e45p0t5D3f9/jHmGGhY+o1Q6CO3JHz0KmlpAGbY3gFMcIT
	FSYnc/caNUWVIXIqmLpJ9uKYCX+rjVj4o6jloqrAZft+H+d1UvQKWV5VOIq9WMrxOYvyW0l7qvj
	Tjl59qlsFwZz6pdqY9lZ+6GK2/8fgeVoxfbhXMxvvv7U4XFSuNDdP5ll7HOWJWVVEzlqxGOtS3g
	p2ceANpWOwRtoVY4ULAxiGiom4I1omLouWj39OrSrE29+YxUn/b7VnmlXCo7jQB2d7+zsuL
X-Received: by 2002:a05:651c:4397:10b0:383:1962:b8ec with SMTP id
 38308e7fff4ca-383842ed669mr838691fa.33.1768494259450; Thu, 15 Jan 2026
 08:24:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216055247.13150-1-rmxpzlb@gmail.com> <CAPDyKFpx-hxv4QVW+zp8Zbd=-9vvmwsVJ2adem6V1gWLQteYsQ@mail.gmail.com>
 <aWRG8w8GxzV9gpUK@venus>
In-Reply-To: <aWRG8w8GxzV9gpUK@venus>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Jan 2026 17:23:42 +0100
X-Gm-Features: AZwV_QgAedw6OVodqeBfNnhbwFIsw1Q42_a8HBS3WTSHHw6GBLICdo8b4ARh_kY
Message-ID: <CAPDyKFo49sptbbESdr8a=6E5KL-bDmH9nFJPrigjM8piwecVkg@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain:rockchip: Fix init genpd as GENPD_STATE_ON
 before regulator ready
To: Frank Zhang <rmxpzlb@gmail.com>, Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	linux-pm@vger.kernel.org, chaoyi.chen@rock-chips.com, 
	quentin.schulz@cherry.de, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 at 02:11, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Tue, Dec 30, 2025 at 03:07:37PM +0100, Ulf Hansson wrote:
> > + Nicolas
> >
> > On Tue, 16 Dec 2025 at 06:53, Frank Zhang <rmxpzlb@gmail.com> wrote:
> > >
> > > RK3588_PD_NPU initialize as GENPD_STATE_ON before regulator ready.
> > > rknn_iommu initlized success and suspend RK3588_PD_NPU. When rocket
> > > driver register, it will resume rknn_iommu.
> > >
> > > If regulator is still not ready at this point, rknn_iommu resume fail,
> > > pm runtime status will be error: -EPROBE_DEFER.
> > >
> > > This patch set pmdomain to off if it need regulator during probe,
> > > consumer device can power on pmdomain after regulator ready.
> > >
> > > Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
> > > Tested-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> > > Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
> >
> > The problem with the child-domain using a regulator has been discussed
> > before [1] between Nicolas, Heiko and me. That said, I have looped in
> > Nicolas to allow him to share his opinion about this too.
> > fauxbus
> > My view on is that I would prefer that we try to address/fix the root
> > cause, rather than trying to paper over the problem as what seems to
> > be suggested in the $subject patch. Or at least I need Nicolas/Heiko
> > to confirm that they are fine with the $subject patch, before I pick
> > it up.
>
> FWIW my thoughts on this:
>
> I believe the proper solution would be to acquire the regulator at
> probe time how it is usually being done in other drivers. I think
> this requires restructuring the driver, so that the sub-domains are
> registered as sub-devices (e.g. via fauxbus) to avoid the
> chicken-and-egg problem of the regulator for pmdomain1 needing
> pmdomain2. As this modification is most likely too big to be
> backported I think this patch should be merged for now:

Fair enough!

I agree with the above, while perhaps the auxiliary bus is probably a
better choice instead of the fauxbus for this case.

>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Cc: stable@vger.kernel.org
> Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")

Applied for fixes, thanks!

Kind regards
Uffe



>
> Greetings,
>
> -- Sebastian
>
> >
> > Kind regards
> > Uffe
> >
> > > ---
> > > Changes in v2:
> > > - Simplified the regulator check logic, trun off pmdomain if need
> > >   regulator.
> > > ---
> > >  drivers/pmdomain/rockchip/pm-domains.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> > > index 4f1336a0f49a..997e93c12951 100644
> > > --- a/drivers/pmdomain/rockchip/pm-domains.c
> > > +++ b/drivers/pmdomain/rockchip/pm-domains.c
> > > @@ -879,6 +879,16 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
> > >                 pd->genpd.name = pd->info->name;
> > >         else
> > >                 pd->genpd.name = kbasename(node->full_name);
> > > +
> > > +       /*
> > > +        * power domain's needing a regulator should default to off, since
> > > +        * the regulator state is unknown at probe time. Also the regulator
> > > +        * state cannot be checked, since that usually requires IP needing
> > > +        * (a different) power domain.
> > > +        */
> > > +       if (pd->info->need_regulator)
> > > +               rockchip_pd_power(pd, false);
> > > +
> > >         pd->genpd.power_off = rockchip_pd_power_off;
> > >         pd->genpd.power_on = rockchip_pd_power_on;
> > >         pd->genpd.attach_dev = rockchip_pd_attach_dev;
> >
> > [1]
> > https://lore.kernel.org/all/CAPDyKFr=GwJ+cO3cW4Ed_LsS=q_JtuuQPDweDpLgDO4hBLFXUA@mail.gmail.com/
> >

