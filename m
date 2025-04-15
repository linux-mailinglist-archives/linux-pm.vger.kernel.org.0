Return-Path: <linux-pm+bounces-25485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33425A8A52B
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 19:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06063B1060
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 17:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F389519E967;
	Tue, 15 Apr 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzmbIYra"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C984D6FC5;
	Tue, 15 Apr 2025 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744737478; cv=none; b=QMUkZzEcbuaYrYWu/dftSlMi5QWPTGMdgZUM9+z7DS+K+PhnKeuQFx9Qo1lLHrQ+LC5pn8QYO1JD8UrsLAprUXVuXlnfNtyrszr7D5bHtXpGBfanbSlvRoUPasr4jCrl3pAuB/4HMnYZkdtQFEev4m08+2mhEcIqHDzQ/VT0CAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744737478; c=relaxed/simple;
	bh=0AKl/IsRYslwoVUW1m7o9u3fbr4ueHyDO0QWtpy18/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHb7pWL88CaFzKlqTs5OD40ARQTZm/k8ntPmRXuntevB8yZS9/gJDBUTV16dxUkZvi5lof+0AppIpQ5Bo5snIJDbZ6U71J/VN4beKUJw/kgh8MV8o2QzjIjyDrMcBQDNqJCvGZwOWxwFYetgFcyvtODmNihShSnsPfW21ICfhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzmbIYra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2319CC4CEEF;
	Tue, 15 Apr 2025 17:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744737478;
	bh=0AKl/IsRYslwoVUW1m7o9u3fbr4ueHyDO0QWtpy18/E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uzmbIYraB+/hNPPpeHu5iQ59YfOzP/UIesCQXOHlU7LhdjCd3W/5SpGYiv/6/LyXH
	 ZobA3oHULhM0Ktuxt4iv7U3aKT3kZKsF/H+fUBTIIijcvwxrv66m0Xt/+tiDJ6Rfrn
	 ++YkWONByXXL2LR7lOh5YTabvrgPx7I3zsgPa6huIHsxp/gc2n7NWq2lAB5cXU7NUA
	 AoKKOjUzfEVZZfKZdDXi+nHZBpNDomcEFSX87ZD7k19DVq252y7mLtRw7+EB83yk5A
	 2LA4yBfGYoWXHVgUgSlEjwfSgTpW+Wip3c5uJINpQmKAjeP7kqB0EqORYu97HqcYSt
	 xi0Hmv0T6/NhA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2b8e26063e4so2829108fac.3;
        Tue, 15 Apr 2025 10:17:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJIDV7jNvl6JyvNBxT8thhjmrLlwZMniCTJgefd9ildHFRqtVVacLG0n5HcQYcItwTfmg7PfOWrf/Hqs8=@vger.kernel.org, AJvYcCWzS0Ex30xW22RHBdSgFY5dV0Yt95I4MufraIzX1nuC/3wYltt9uE8rMm17Gn2ljBU3oCirlffLnXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNMpn9yYYZSVP7IgfHjEFWyB1hRNOI2COk06Dm/c18FEUW8l3X
	PefonMcDY4toZZnR98cZF2W3mVN7CJjw/my+OPsZ8CCtFNkGn9bHRbemuTasPuhiVU2wNwk58DZ
	3IsCKeG1Z/Qo3vs/lIgQthi9FbRY=
X-Google-Smtp-Source: AGHT+IE8i9pYhCWpc0Z0zMWQ4IuY2YHkZmpW07tdSUgh5pECuqRMh2pTlndSFdkHU7kgpYSBSTpnnbMkIsLySUGS1Po=
X-Received: by 2002:a05:6871:410c:b0:29e:4a13:603f with SMTP id
 586e51a60fabf-2d4c3966836mr2578fac.4.1744737477341; Tue, 15 Apr 2025 10:17:57
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_EE27C7D1D6BDB3EE57A2C467CC59A866C405@qq.com> <tencent_6D2374392DB66C9D23BF6E2546638A42EC08@qq.com>
In-Reply-To: <tencent_6D2374392DB66C9D23BF6E2546638A42EC08@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 Apr 2025 19:17:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iE_iw+pSBppEWnJw=2=DFNa-J2VPDorTNF=Mve+0PNCg@mail.gmail.com>
X-Gm-Features: ATxdqUGlC1rknMXLhtRZskxYJ82qaSpg2SVaqpZAeB9vwYey56V6yOt0pI7hiXI
Message-ID: <CAJZ5v0iE_iw+pSBppEWnJw=2=DFNa-J2VPDorTNF=Mve+0PNCg@mail.gmail.com>
Subject: Re: [PATCH v3] PM: EM: Fix potential division-by-zero error in em_compute_costs()
To: Yaxiong Tian <iambestgod@qq.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yaxiong Tian <tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 11:09=E2=80=AFAM Yaxiong Tian <iambestgod@qq.com> w=
rote:
>
> From: Yaxiong Tian <tianyaxiong@kylinos.cn>
>
> When the device is of a non-CPU type, table[i].performance won't be
> initialized in the previous em_init_performance(), resulting in division
> by zero when calculating costs in em_compute_costs().
>
> Since the 'cost' algorithm is only used for EAS energy efficiency
> calculations and is currently not utilized by other device drivers, we
> should add the _is_cpu_device(dev) check to prevent this division-by-zero
> issue.
>
> Fixes: <1b600da51073> ("PM: EM: Optimize em_cpu_energy() and remove divis=
ion")

Please look at the Fixes: tags in the kernel git history.  They don't
look like the one above.

> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> ---
>  kernel/power/energy_model.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index d9b7e2b38c7a..fc972cc1fc12 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -235,7 +235,7 @@ static int em_compute_costs(struct device *dev, struc=
t em_perf_state *table,
>
>         /* Compute the cost of each performance state. */
>         for (i =3D nr_states - 1; i >=3D 0; i--) {
> -               unsigned long power_res, cost;
> +               unsigned long power_res, cost =3D 0;
>
>                 if ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost) =
{
>                         ret =3D cb->get_cost(dev, table[i].frequency, &co=
st);
> @@ -244,7 +244,7 @@ static int em_compute_costs(struct device *dev, struc=
t em_perf_state *table,
>                                         cost, ret);
>                                 return -EINVAL;
>                         }
> -               } else {
> +               } else if (_is_cpu_device(dev)) {

Can't you just check this upfront at the beginning of the function and
make it bail out if dev is not a CPU device?

>                         /* increase resolution of 'cost' precision */
>                         power_res =3D table[i].power * 10;
>                         cost =3D power_res / table[i].performance;
> --

