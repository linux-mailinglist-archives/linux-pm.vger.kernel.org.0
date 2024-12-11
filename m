Return-Path: <linux-pm+bounces-19063-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1B39ED6D8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 20:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D21228238D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 19:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A795201249;
	Wed, 11 Dec 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYzPXr6S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098C1C3F27;
	Wed, 11 Dec 2024 19:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946831; cv=none; b=rGRvtV5HKrQWjfMsT2rdK2zsO7QutDgSqbydK2PtSpcYyJBNfO1KvgTxtM1SOy4X5bBIH28EDMY55gViRpBQu4M6YreJi3SK1D1eQCOjT7akoa/sE/MgQf1ppg9CHLqBBkSX+cz/cYmTyYaMnQayGfsKWsxjNmGTZv/o3a427UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946831; c=relaxed/simple;
	bh=awILHNQ8O38EIuFqxBPqIuRrNjOaY4wzupNrF0qkS2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oL9Z4CXxEGgUvq1Ckl4fMFsbRXSJVRR1gTSbNyUjbqFnEd+2PH1k8uqotmVhw732QBYEMiVoLO8NwIkeDNyJxmUR7eI2fo+/3kjSm0lZs7r5Af+ycx+uI4E+zYKzdkIRBgz4yOzyJugu2OAdhSZa52HqUGdVYtaPhrRMdaM5nQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYzPXr6S; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so9833188a12.2;
        Wed, 11 Dec 2024 11:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733946828; x=1734551628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUkg/yF7ykYCR3YM3sPZ1dL76jj3S9T17dsWcGrfYpk=;
        b=XYzPXr6S1lgMtHO80dSrwg3Vk/LlcO70wjcZ3tyKuLJMEtx1tPd8duBges0+GFqs0k
         r2jeAgF+z8TMYaHBexMllhdShTeynBNF1xScrL1Tq1aHN3NB56MOfWBv50/1gPSt9BQJ
         ZgbkOcbGOkU+AeDtQZP6uOlJWHUA1IY+sDVtLZCK0zj0bIZppZ6YyDOmdoyRmPUG/5P4
         41lnF22+PagWVuhaNk46YsFoLOlRDpYGSSAM80/zCQHojquBk3zCEv67ELNcwHmEmRX7
         dOLFKom9L7oezJvGB11e2a+Tr317elDgsljrgHQeexkNAV0CgNcnOXOuxTUXISdeXDT2
         wMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733946828; x=1734551628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUkg/yF7ykYCR3YM3sPZ1dL76jj3S9T17dsWcGrfYpk=;
        b=F3cLukEbNozsL6AA9cppq6tBG2FvqGCEeLFpphJs7RIurpwyRyOuMG8wuc+dyB8OV1
         NGaXMI8x1OSKPT9oMmYVFzyiKjB8C75tOxysqcFlifEhRMGWIyVxCp+FFn115f3X5iLc
         fs4xNVHBc5+ksLjy52FQB4wRFkICkeoo5thWt8ydMoDxCPurwVDHD9gIBf6mvMlIphiJ
         IjRYYgqm+vkMXAbwQLhRC81tFskzO228s/BpicB8LhoSt7terpECmRTPNLlCkjF3t+IF
         t9mlRUPORD9TCFAdedZy5cbz9o/LUdzLj+5S7GyQ0lZQ0TvUseF/kV5L89iK8HDI6ts1
         uaSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3mzbjMxdxO8iWvREWYYF7KOpreBoWhd3vhaQQsHkImR2PTwd0nhmh+1MgTM0ZTkz6/42on2AE96D/@vger.kernel.org, AJvYcCVIE95vvHkkm2fp2S9s4Dj5vzQ97XRKCii4rtcOk9FkcFo2seHBC1uqQ+lvqDPKlhMsKEp006lSl9EmlTWR@vger.kernel.org, AJvYcCVwzORWP5JOf1Bn0bU5yVDQIaOEz/TQcuwMITXMVAlpZiHRO5gG7ZPZdCJobMe2kARgsKjWIZOWJtk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf59oY7Nzcf3JJyn7JMxZnSTAHgJMOKQkxf8AaE2QFKEFkGb2f
	ShTIrlYkZEojwTo0y9YZ9r9YZkd3ekakImoRsFAJHoGA+uRWWodZXc0/dWigVDiQyz2AcDBPa49
	aCWHBUW5D1jxUaHW1lXOvVbfkpdk=
X-Gm-Gg: ASbGnct2wYPv3mwriT/6lQuf9KnkeiBkX5BrftnKcGgOq+s8fDuxYesfFDmDTOMPU0o
	jWPbPWBjmsSwSLKKykElABzoWwuMAIOwW4vVN
X-Google-Smtp-Source: AGHT+IFv9Sczsd0mQ9Rbff05mKNUzboS24htjzD9Z2VVbj8mRpyVeCykSOxdH3C+PWYJ9RVkG/vNjP/KNUylPlL22qo=
X-Received: by 2002:a17:906:23f1:b0:aa6:a228:afa9 with SMTP id
 a640c23a62f3a-aa6c1ab6290mr122294366b.3.1733946827671; Wed, 11 Dec 2024
 11:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211143044.9550-1-sebastian.reichel@collabora.com> <20241211143044.9550-4-sebastian.reichel@collabora.com>
In-Reply-To: <20241211143044.9550-4-sebastian.reichel@collabora.com>
From: Peter Geis <pgwipeout@gmail.com>
Date: Wed, 11 Dec 2024 14:53:34 -0500
Message-ID: <CAMdYzYqLq=kSC8fiBapRS_8w0s8PaL9Yd46VgM56YbTEmUG1xA@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] pmdomain: rockchip: forward rockchip_do_pmu_set_power_domain
 errors
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Elaine Zhang <zhangqing@rock-chips.com>, 
	=?UTF-8?Q?Adri=C3=A1n_Mart=C3=ADnez_Larumbe?= <adrian.larumbe@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Chen-Yu Tsai <wens@csie.org>, 
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kernel@collabora.com, 
	Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 9:32=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Currently rockchip_do_pmu_set_power_domain prints a warning if there
> have been errors turning on the power domain, but it does not return
> any errors and rockchip_pd_power() tries to continue setting up the
> QOS registers. This usually results in accessing unpowered registers,
> which triggers an SError and a full system hang.
>
> This improves the error handling by forwarding the error to avoid
> kernel panics.

Good Afternoon,

I think we should merge your patch here with my patch for returning
errors from rockchip_pmu_set_idle_request [1].

>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Adrian Larumbe <adrian.larumbe@collabora.com> # On Rock 5B
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 34 +++++++++++++++++---------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/ro=
ckchip/pm-domains.c
> index a161ee13c633..8f440f2883db 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -533,16 +533,17 @@ static int rockchip_pmu_domain_mem_reset(struct roc=
kchip_pm_domain *pd)
>         return ret;
>  }
>
> -static void rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *=
pd,
> -                                            bool on)
> +static int rockchip_do_pmu_set_power_domain(struct rockchip_pm_domain *p=
d,
> +                                           bool on)
>  {
>         struct rockchip_pmu *pmu =3D pd->pmu;
>         struct generic_pm_domain *genpd =3D &pd->genpd;
>         u32 pd_pwr_offset =3D pd->info->pwr_offset;
>         bool is_on, is_mem_on =3D false;
> +       int ret;
>
>         if (pd->info->pwr_mask =3D=3D 0)
> -               return;
> +               return 0;
>
>         if (on && pd->info->mem_status_mask)
>                 is_mem_on =3D rockchip_pmu_domain_is_mem_on(pd);
> @@ -557,16 +558,21 @@ static void rockchip_do_pmu_set_power_domain(struct=
 rockchip_pm_domain *pd,
>
>         wmb();
>
> -       if (is_mem_on && rockchip_pmu_domain_mem_reset(pd))
> -               return;
> +       if (is_mem_on) {
> +               ret =3D rockchip_pmu_domain_mem_reset(pd);
> +               if (ret)
> +                       return ret;
> +       }
>
> -       if (readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd, is_o=
n,
> -                                     is_on =3D=3D on, 0, 10000)) {
> -               dev_err(pmu->dev,
> -                       "failed to set domain '%s', val=3D%d\n",
> -                       genpd->name, is_on);
> -               return;
> +       ret =3D readx_poll_timeout_atomic(rockchip_pmu_domain_is_on, pd, =
is_on,
> +                                       is_on =3D=3D on, 0, 10000);
> +       if (ret) {
> +               dev_err(pmu->dev, "failed to set domain '%s' %s, val=3D%d=
\n",
> +                       genpd->name, on ? "on" : "off", is_on);
> +               return ret;
>         }
> +
> +       return 0;
>  }
>
>  static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_o=
n)
> @@ -592,7 +598,11 @@ static int rockchip_pd_power(struct rockchip_pm_doma=
in *pd, bool power_on)
>                         rockchip_pmu_set_idle_request(pd, true);
>                 }
>
> -               rockchip_do_pmu_set_power_domain(pd, power_on);
> +               ret =3D rockchip_do_pmu_set_power_domain(pd, power_on);
> +               if (ret < 0) {
> +                       clk_bulk_disable(pd->num_clks, pd->clks);
> +                       return ret;

Looking at it, we shouldn't return directly from here because the
mutex never gets unlocked.
Instead of repeating clk_bulk_disable and return ret for each failure,
we can initialize ret =3D 0, have a goto: out pointing to
clk_bulk_disable, and change return 0 to return ret at the end.

What do you think?

Very Respectfully,
Peter Geis

[1] https://lore.kernel.org/linux-rockchip/20241210013010.81257-2-pgwipeout=
@gmail.com/

> +               }
>
>                 if (power_on) {
>                         /* if powering up, leave idle mode */
> --
> 2.45.2
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

