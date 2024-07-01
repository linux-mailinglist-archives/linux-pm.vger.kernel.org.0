Return-Path: <linux-pm+bounces-10293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A0691E61B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 19:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369FCB21A16
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jul 2024 16:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4908516DC3A;
	Mon,  1 Jul 2024 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Inzjp2EA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B943144;
	Mon,  1 Jul 2024 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853177; cv=none; b=gQIEJ1B0q9aZv/13ey1bAxZUnE37pYdbivf/CZBnDFlCdS91e6J3zXciZVBZgygM0gb1oY5Bahp6AhW5oRE/ZivcafrvEHMtcjswrNBAvAHaONWb3cuixApfJqqLVNEyFfpY+jnb8WdxTpEpBJ5Y+NGAoQf7O5ayBhhRfICzb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853177; c=relaxed/simple;
	bh=zUGL8isiXEnqzL1HE8Wbu1BcaCkPiWfaa1HJedHH6p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmmRWqc+lZJQkfh3jRN2iHmVyIIZS0QZQkO/8q/bDH5lk2Xij48SZh/z/DUl6EejU3rz7lZDlLgLBvWCCiGO6+gvjzjrM7iATHhaLc6goBUEKD2McQVzj2VWURmdhAMGYP4pPmsqOYX0i989UABhuQgyciq2PISTck8Apu9yZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Inzjp2EA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DD1C4AF10;
	Mon,  1 Jul 2024 16:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719853176;
	bh=zUGL8isiXEnqzL1HE8Wbu1BcaCkPiWfaa1HJedHH6p8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Inzjp2EADF0fqQJi+DIeZB0Hwvma8nd533uc3N9Obi5CIwYMOuaVGDp2QugqPB3vy
	 7Hn96cPBcaonYothTe9+nN6ARzXqjQ1mH2lnDUMdjziOIJtIBSen2fdxiFZlJBd8/z
	 Ns1c8ouDcQlsIXREerT0KIvU8UpHZWvmmqPHCRLHMms2k1+KDudg0shTmrDcrq0yDi
	 0iBwc0FqR0Ji+nr/i8z+3L0EzJl5glRjqarpnY6h9NX6dlhedz0zTRU6XVA6iuijg8
	 rfNA9Y2mVWiSAUVRrM+aoiFcSlvsgL/AcAQyyIxLj3LKxgwodcjP9OZle1rzO5y/L9
	 JVYgtfPHiMZkA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-24c5ec50da1so453333fac.3;
        Mon, 01 Jul 2024 09:59:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWXOmbCCDbM/4bLefCz3SOVqzKnor3SD94w0pVhMIlbqfk09sKCMs8X3wGd+UZLotSzwgxRObXr0Sl+bGffEQx55SSIrMXkit+VceXAWj5rKtv8TDrJL/1hwB50nWohvZI+A7ajkE=
X-Gm-Message-State: AOJu0YxeqFcLZecWCSh6qVTB7P2RBuZYJw7pDYIm2YLC3KIkrjjEDnNW
	IELrFy7dtD/gpB66T+7E6MaXet0AtsI/Yyiu6UCDBNQk2Vu1LFdHz65HMYeYJb32wVUWFfrIyrn
	1HaS16f915Wkaa77omEiX+0QSYiw=
X-Google-Smtp-Source: AGHT+IFoPgW50EvjNW4Q1RLKjT3T97gSHyMry3rat4zYIOxXZ83z/B+T4onbyQO++EPGBuprRtcQmiqwGw4HC4uuV+E=
X-Received: by 2002:a05:6870:8192:b0:24f:e599:9168 with SMTP id
 586e51a60fabf-25db33732ffmr6149076fac.1.1719853175725; Mon, 01 Jul 2024
 09:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628095955.34096-1-christian.loehle@arm.com>
 <20240628095955.34096-4-christian.loehle@arm.com> <CAJZ5v0jaEt2yo9OvYqpzfcbPtAvTk63tKXjm6QCi7zeKuU2SUA@mail.gmail.com>
 <c40acf72-010f-4a8b-80e4-33f133ba266b@arm.com>
In-Reply-To: <c40acf72-010f-4a8b-80e4-33f133ba266b@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 18:59:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hCANG0JBVcLgVkuS9N5Vb=sLVFtdZiJD8HYSQoX8NZgg@mail.gmail.com>
Message-ID: <CAJZ5v0hCANG0JBVcLgVkuS9N5Vb=sLVFtdZiJD8HYSQoX8NZgg@mail.gmail.com>
Subject: Re: [PATCHv4 3/3] cpuidle: teo: Don't count non-existent intercepts
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vincent.guittot@linaro.org, qyousef@layalina.io, 
	peterz@infradead.org, daniel.lezcano@linaro.org, ulf.hansson@linaro.org, 
	anna-maria@linutronix.de, dsmythies@telus.net, kajetan.puchalski@arm.com, 
	lukasz.luba@arm.com, dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 10:22=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> When bailing out early, teo will not query the sleep length anymore
> since commit 6da8f9ba5a87 ("cpuidle: teo:
> Skip tick_nohz_get_sleep_length() call in some cases") with an
> expected sleep_length_ns value of KTIME_MAX.
> This lead to state0 accumulating lots of 'intercepts' because
> the actually measured sleep length was < KTIME_MAX, so query the sleep
> length instead for teo to recognize if it still is in an
> intercept-likely scenario without alternating between the two modes.
>
> Fundamentally we can only do one of the two:
> 1. Skip sleep_length_ns query when we think intercept is likely
> 2. Have accurate data if sleep_length_ns is actually intercepted when
> we believe it is currently intercepted.
>
> Previously teo did the former while this patch chooses the latter as
> the additional time it takes to query the sleep length was found to be
> negligible and the variants of option 1 (count all unknowns as misses
> or count all unknown as hits) had significant regressions (as misses
> had lots of too shallow idle state selections and as hits had terrible
> performance in intercept-heavy workloads).
>
> Fixes: 6da8f9ba5a87 ("cpuidle: teo: Skip tick_nohz_get_sleep_length() cal=
l in some cases")
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
> v4: Skip constraint check if intercept logic selects state0
>
>  drivers/cpuidle/governors/teo.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/=
teo.c
> index 200a3598cbcf..6dc44197a80e 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -287,6 +287,7 @@ static int teo_select(struct cpuidle_driver *drv, str=
uct cpuidle_device *dev,
>         unsigned int hit_sum =3D 0;
>         int constraint_idx =3D 0;
>         int idx0 =3D 0, idx =3D -1;
> +       int prev_intercept_idx;
>         s64 duration_ns;
>         int i;
>
> @@ -364,6 +365,7 @@ static int teo_select(struct cpuidle_driver *drv, str=
uct cpuidle_device *dev,
>          * all of the deeper states a shallower idle state is likely to b=
e a
>          * better choice.
>          */
> +       prev_intercept_idx =3D idx;
>         if (2 * idx_intercept_sum > cpu_data->total - idx_hit_sum) {
>                 int first_suitable_idx =3D idx;
>
> @@ -415,6 +417,15 @@ static int teo_select(struct cpuidle_driver *drv, st=
ruct cpuidle_device *dev,
>                         first_suitable_idx =3D i;
>                 }
>         }
> +       if (!idx && prev_intercept_idx) {
> +               /*
> +                * We have to query the sleep length here otherwise we do=
n't
> +                * know after wakeup if our guess was correct.
> +                */
> +               duration_ns =3D tick_nohz_get_sleep_length(&delta_tick);
> +               cpu_data->sleep_length_ns =3D duration_ns;
> +               goto out_tick;
> +       }
>
>         /*
>          * If there is a latency constraint, it may be necessary to selec=
t an
> --

Applied as 6.11 material, thanks!

