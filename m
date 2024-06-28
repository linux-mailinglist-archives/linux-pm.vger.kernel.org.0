Return-Path: <linux-pm+bounces-10210-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A191C610
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 20:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C8A1C21C6E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2024 18:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D40A524B4;
	Fri, 28 Jun 2024 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHcpK7oo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A646F067;
	Fri, 28 Jun 2024 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600513; cv=none; b=Wv9kyDEV80XcSpezG2abTkC9r5HZbgFY1DWlXV/FAwCeYHNK9TbjYHZ7VhXgt5UYeaL2Y3j/0BWy9LAwOgm+OpW4JJob13P3v9cC7pGncddV2CDX8Ea6hA4u0F+7SSAtqB186nOMECtGTrPunV+18OEhy4eV+VCspUU/D2mu1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600513; c=relaxed/simple;
	bh=O74nKorjjjYbawiM/zepyV3dpVqB8zVQLl01qtUoxJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P68DVmGRXb78pKVAPpvfVVacJB5+d3gl4Nsi5I6qzCKQ9VLGBVutxkx/bqPvyH6rorz/8UL88+zklprDzqoTKDajUSAuuxrc/hYr0A4MAKBuzjpDjmkRCBtF2/oUa+WAT8RdGDnnFaZJphAcGHFsdFzWHO7NIv91ho4Tv+B0+jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHcpK7oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882C8C4AF0B;
	Fri, 28 Jun 2024 18:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719600511;
	bh=O74nKorjjjYbawiM/zepyV3dpVqB8zVQLl01qtUoxJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PHcpK7ooH9D+C+qMf5zlrdJIenjwIt0DIniqjxJJzMAsm6Kt4gTBgw0DHMRdQ1uq1
	 U1vFg61ZmiFdQ+1LVCft6SYJwDWj3p+W5y3s1xUhdWPVnO8v9S9KkeD/k0fUtwbsFD
	 cnLru4UV25gxPUaqU3oBTwK2YW9QnfquODRB53ld15HP151plg3d9T2IkKgKyNFZXj
	 okmO4z0IAO14Z0/I4V/TP1ZyENxlpBRbBuxcGo+8BOmrmADXSKkT/0FQClxZrFjFjD
	 +M2he7xgrXwO94irnu8Tq/4w5O+a+/Pf8aFuqoiuKlWrDbaLjdwjI5REbLrf59o9CA
	 zI6cfDc/A3qyQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-25c98395938so135730fac.3;
        Fri, 28 Jun 2024 11:48:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzf8uM118GC1jLE3wkjbCMHFZPViylrUDqvaG05IgD3IPm1xpBxirH1PqiyAxpfSruu1EGT1MN84BUVL4NNYYUcHW7z1uLWhFJaUHz
X-Gm-Message-State: AOJu0YyEbC5ywqPnStQkzvpqpHVgwcFXeQ1pdnxulq9Uref3htDN4LRz
	g4PNocqqZEFUvB0ENXFyAnFPLzGESQXYLZHw6lcmmgqmu0Yil5QpwTy3uqWqsLT5G2MtfMHjBsZ
	xUz7wUHw+h+g8wLwmHebiARsIiv8=
X-Google-Smtp-Source: AGHT+IHAPevpOc/Kde96geQuxUjIszE0YxsYUdZ74D8YKLdaEqNaOVcuuJaZC5/hrhtWudI4/h4T4LIYoGabCTOBCA0=
X-Received: by 2002:a05:6870:b50b:b0:255:1fea:340d with SMTP id
 586e51a60fabf-25cf3686c8bmr19950818fac.0.1719600510724; Fri, 28 Jun 2024
 11:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628095955.34096-1-christian.loehle@arm.com> <20240628095955.34096-4-christian.loehle@arm.com>
In-Reply-To: <20240628095955.34096-4-christian.loehle@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Jun 2024 20:48:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jaEt2yo9OvYqpzfcbPtAvTk63tKXjm6QCi7zeKuU2SUA@mail.gmail.com>
Message-ID: <CAJZ5v0jaEt2yo9OvYqpzfcbPtAvTk63tKXjm6QCi7zeKuU2SUA@mail.gmail.com>
Subject: Re: [PATCH 3/3] cpuidle: teo: Don't count non-existent intercepts
To: Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org, 
	vincent.guittot@linaro.org, qyousef@layalina.io, peterz@infradead.org, 
	daniel.lezcano@linaro.org, ulf.hansson@linaro.org, anna-maria@linutronix.de, 
	dsmythies@telus.net, kajetan.puchalski@arm.com, lukasz.luba@arm.com, 
	dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 12:02=E2=80=AFPM Christian Loehle
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
> v3:
> Drop counting KTIME_MAX as hit and reword commit accordingly
>
>  drivers/cpuidle/governors/teo.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/=
teo.c
> index 200a3598cbcf..c2d73507d23b 100644
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
> @@ -415,6 +417,14 @@ static int teo_select(struct cpuidle_driver *drv, st=
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

This is going to select the shallowest state anyway AFAICS, so is it
useful to check constraint_idx in this case?

> +       }
>
>         /*
>          * If there is a latency constraint, it may be necessary to selec=
t an
> --

