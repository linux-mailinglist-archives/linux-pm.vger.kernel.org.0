Return-Path: <linux-pm+bounces-31027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFC6B093D8
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 20:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6719FA46383
	for <lists+linux-pm@lfdr.de>; Thu, 17 Jul 2025 18:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FB12FBFEC;
	Thu, 17 Jul 2025 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPlld6RI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6251925BC;
	Thu, 17 Jul 2025 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752776610; cv=none; b=iTj3a5NsF1KNVQIcyq3XUSpJCKn2fv9rAqrPEZ4THif4nzLINx5fUB6XBzXN4K1OB25SLEPJND3hoS2YR/sLx5efW1Kfg2xD06P06vRay7wyYKSru+ogDIhMhgCrpwaQTEFc3yuAIInPO7ISYh9N2ZH0Qzqfbnf/AJSCjBPQg0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752776610; c=relaxed/simple;
	bh=cmEx9GcDqNc3lsRf0Y1I5pNd4JYcHwEIEV5g1PJ2m/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFSHiOi76x5AxMtssVzLz6Z8VX2MiKVVQ/ipY8O9YfIAjH2jBE78dRaIGksiqdD9sIG7pcYmbqFtWLXxzC8rdHlx9gTv9itHu4wwjyzkkxsBxatolf04XzKVAHwVmzwtHjQW96tsSIMe9uBb8fqyT3Vge7T7Idk0SvEeNVMENys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPlld6RI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A65C4CEF0;
	Thu, 17 Jul 2025 18:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752776610;
	bh=cmEx9GcDqNc3lsRf0Y1I5pNd4JYcHwEIEV5g1PJ2m/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oPlld6RIedFVE8cp1DCPzH9GIjhQ5JIm/MqNS2+o2bAsCTW2umpLCChmRkAIr5JqT
	 l5cnL9ZBtdJjnDTcXK3aPp7lkVy27EhZ1lfojiJMY+64CRKgGqMZ12keNh242ihX96
	 NkWz+AKXGIpmcVQAXNauEDZ/nUhJHXY4lgQu+iIZysPJVjJ4eE0nMkJ8YegcKRrkA1
	 tQafrAbrqC+2xqvEWokmBNK9SYvfg4dsC7p86oh+QAKaF7ge2+Jl40eIimXijZ14NJ
	 Xy4MkwYwB7y0yRaDFynuYbPRRb0VEuISkUFLxkHF3N2oZXO6TtYoExM28evz65sSh0
	 oxQcIDdvkmzkQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-615a02ebcc7so388612eaf.3;
        Thu, 17 Jul 2025 11:23:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwp2/CjCALqi2X5WbyVOFX0cvd9zaTBD2p2RpZ54tuiJM6+9dYsEVMAwJsUuGv2kcxFbwaQhtzu6I=@vger.kernel.org, AJvYcCWSGIAX5dTXFiD/CyvTYGTG6eFJ/ZF2w+7cBxhHuPyOMWoxa+t4J95BSUUyHD3e4JRit5nQ+OAIvifWrEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPeKTU4/CYyP+Yv31dVZKuJOYHkxIzWZ4woDTX3uUH/KzWaMEM
	e2Uf0VOPTHv1CXlVzShwoYCijxeQcAHogF69uWIoejD23g+46D7kwgSH1z+HxwjkV9Ne0KtS0Ev
	Sjekpb1Kw7sVAlA3Qysu9RZPQqf59l00=
X-Google-Smtp-Source: AGHT+IE6y506rUVjoZSAgM7zFpUSPFqp74G5jVT4nt+KBmG+TBjlc2XF10rPaDz0vFC3eHRBMQqYa2u+Y0FmH2lPBb0=
X-Received: by 2002:a05:6820:178f:b0:615:ae24:916c with SMTP id
 006d021491bc7-615ae24982cmr2761844eaf.4.1752776609065; Thu, 17 Jul 2025
 11:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa1c6faa96344fa9803675b179d7a329@xiaomi.com>
In-Reply-To: <fa1c6faa96344fa9803675b179d7a329@xiaomi.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Jul 2025 20:23:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iEKoozunNzeTHHqKCsvJ_ouUm+cFT_6mMohYCzAW39QQ@mail.gmail.com>
X-Gm-Features: Ac12FXzOwDZ8qdL0Wdm1FVEOOD4ybHlQdgA9aAHzxjaHTlml15X-1ufXUaAP-tU
Message-ID: <CAJZ5v0iEKoozunNzeTHHqKCsvJ_ouUm+cFT_6mMohYCzAW39QQ@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: menu: find the typical interval by a heuristic
 classification method
To: =?UTF-8?B?5pyx5oG65Lm+?= <zhukaiqian@xiaomi.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	"christian.loehle@arm.com" <christian.loehle@arm.com>, 
	"quic_zhonhan@quicinc.com" <quic_zhonhan@quicinc.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 12:12=E2=80=AFPM =E6=9C=B1=E6=81=BA=E4=B9=BE <zhuka=
iqian@xiaomi.com> wrote:
>
> The iterations of deviation calculation gives too less predictions on
> the idle interval by trying to find a single repeating pattern from the
> whole history. This is not always the case when the workload is flowing.
>
> This algorithm assumes there're multiple repeating patterns heuristically=
,
> and tries to determine which is the most promising one from the averages
> of different idle states. It also takes the occurrence sequence into
> consideration, and gives the prediction close to the recent idle.

Instead of saying "this algorithm", please describe it or give a
reference to a description of it that is not going to vanish from the
Web at one point.

> This increased the shallow idle states detected, but the difference in de=
ep
> sleep time didn't change a lot. The performance on my platform, as
> expected, has improved.
>
> Before:
> Multi-Core Score              7279
> Overall    above   under
>   34107    0.00    2.75
>    8200   59.90    7.02
>   29881   57.06    0.00
>
> After:
> Multi-Core Score              7365
> Overall    above   under
>   49913    0.00    6.43
>    7881   44.51   18.08
>   23108   52.38    0.00

It is unclear what the columns above mean and what's represented by
the numbers, so qualifying the improvement is rather hard.

> There's another re-classification method, which, instead of looking for t=
he
> repeating-interval, tends to find the repeating state. It gives a better =
result
> on performance gain, but may hurt the power consumption.
>
> if (best_state =3D=3D drv->state_count - 1 || state_avg[best_state] =3D=
=3D 0) {
> adj_weight[best_state] +=3D weights[i];
> adj_avg[best_state] +=3D value;
> adj_hit[best_state]++;
> } else if (best_diff < state_avg[best_state] * 2) {
> adj_weight[best_state] +=3D weights[i];
> adj_avg[best_state] +=3D value;
> adj_hit[best_state]++;
> } else {
> adj_weight[best_state + 1] +=3D weights[i];
> adj_avg[best_state + 1] +=3D value;
> adj_hit[best_state + 1]++;
> }
>
> Repeating State:
> Multi-Core Score              7421
> Overall    above   under
>   60857    0.00    8.30
>    3838   29.88   18.42
>   15318   39.05    0.00

I'm not sure what the above part of the changelog means at all.

> Signed-off-by: Kaiqian Zhu <zhukaiqian@xiaomi.com>
> ---
>  drivers/cpuidle/governors/menu.c | 174 ++++++++++++++++---------------
>  1 file changed, 89 insertions(+), 85 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors=
/menu.c
> index 52d5d26fc7c6..52723ec1a0a6 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -99,109 +99,113 @@ static DEFINE_PER_CPU(struct menu_device, menu_devi=
ces);
>
>  static void menu_update(struct cpuidle_driver *drv, struct cpuidle_devic=
e *dev);
>
> -/*
> - * Try detecting repeating patterns by keeping track of the last 8
> - * intervals, and checking if the standard deviation of that set
> - * of points is below a threshold. If it is... then use the
> - * average of these 8 points as the estimated value.
> - */
> -static unsigned int get_typical_interval(struct menu_device *data)
> +static int get_actual_state(struct cpuidle_driver *drv,
> +    struct cpuidle_device *dev,
> +    int duration_us)
>  {
> -s64 value, min_thresh =3D -1, max_thresh =3D UINT_MAX;
> -unsigned int max, min, divisor;
> -u64 avg, variance, avg_sq;
> -int i;
> +int actual;
>
> -again:
> -/* Compute the average and variance of past intervals. */
> -max =3D 0;
> -min =3D UINT_MAX;
> -avg =3D 0;
> -variance =3D 0;
> -divisor =3D 0;
> -for (i =3D 0; i < INTERVALS; i++) {
> -value =3D data->intervals[i];
> -/*
> - * Discard the samples outside the interval between the min and
> - * max thresholds.
> - */
> -if (value <=3D min_thresh || value >=3D max_thresh)
> -continue;
> +for (int i =3D 0; i < drv->state_count; i++) {
> +if (duration_us < drv->states[i].target_residency)
> +break;
> +
> +actual =3D i;
> +}
> +
> +return actual;
> +}
> +
> +static unsigned int get_typical_interval(struct cpuidle_driver *drv,
> + struct cpuidle_device *dev,
> + struct menu_device *data)
> +{
> +int cnt =3D 0;
> +
> +int state_hit[CPUIDLE_STATE_MAX];
> +int state_avg[CPUIDLE_STATE_MAX];
> +int adj_weight[CPUIDLE_STATE_MAX];
> +int adj_avg[CPUIDLE_STATE_MAX];
> +int adj_hit[CPUIDLE_STATE_MAX];
> +int hit_thres =3D max(2, INTERVALS / drv->state_count);
> +int weights[INTERVALS] =3D {5, 3, 2, 1};
> +int weight =3D 0;
> +int high_state =3D -1;
>
> -divisor++;
>
> -avg +=3D value;
> -variance +=3D value * value;
> +/* Going through the history, and divide them by the actual state */
> +for (int i =3D 0; i < INTERVALS; i++) {
> +int actual =3D get_actual_state(drv, dev, data->intervals[i]);
>
> -if (value > max)
> -max =3D value;
> +/* Count the idle states hit in the history */
> +state_avg[actual] +=3D data->intervals[i];
> +state_hit[actual]++;
>
> -if (value < min)
> -min =3D value;
> +cnt++;
>  }
>
> -if (!max)
> +if (cnt < hit_thres)
>  return UINT_MAX;
>
> -if (divisor =3D=3D INTERVALS) {
> -avg >>=3D INTERVAL_SHIFT;
> -variance >>=3D INTERVAL_SHIFT;
> -} else {
> -do_div(avg, divisor);
> -do_div(variance, divisor);
> +/* calculate the average of each state */
> +for (int i =3D 0; i < drv->state_count; i++) {
> +if (state_hit[i] > 1)
> +state_avg[i] /=3D state_hit[i];
>  }
>
> -avg_sq =3D avg * avg;
> -variance -=3D avg_sq;
> +/* try to re-assign the data points by the closeness */
> +for (int i =3D 0; i < INTERVALS; i++) {
> +/* Starting from the recent history */
> +int idx =3D ((data->interval_ptr - i - 1) + INTERVALS) % INTERVALS;
> +unsigned int diff;
> +unsigned int best_diff =3D UINT_MAX;
> +unsigned int best_state, next_state;
> +unsigned int value =3D data->intervals[idx];
> +
> +for (int state =3D 0; state < drv->state_count; state++) {
> +diff =3D abs(state_avg[state] - value);
> +if (diff < best_diff) {
> +best_diff =3D diff;
> +best_state =3D state;
> +}
> +}
>
> -/*
> - * The typical interval is obtained when standard deviation is
> - * small (stddev <=3D 20 us, variance <=3D 400 us^2) or standard
> - * deviation is small compared to the average interval (avg >
> - * 6*stddev, avg^2 > 36*variance). The average is smaller than
> - * UINT_MAX aka U32_MAX, so computing its square does not
> - * overflow a u64. We simply reject this candidate average if
> - * the standard deviation is greater than 715 s (which is
> - * rather unlikely).
> - *
> - * Use this result only if there is no timer to wake us up sooner.
> - */
> -if (likely(variance <=3D U64_MAX/36)) {
> -if ((avg_sq > variance * 36 && divisor * 4 >=3D INTERVALS * 3) ||
> -    variance <=3D 400)
> -return avg;
> +if (best_diff < (state_avg[best_state] >> 2)) {
> +adj_avg[best_state] +=3D value;
> +adj_hit[best_state]++;
> +adj_weight[best_state] +=3D weights[i];
> +} else if (best_state < drv->state_count - 1) {
> +next_state =3D best_state + 1;
> +diff =3D abs(state_avg[next_state] - value);
> +if (diff < (state_avg[next_state] >> 2)) {
> +adj_avg[next_state] +=3D value;
> +adj_hit[next_state]++;
> +adj_weight[next_state] +=3D weights[i];
> +}
> +}
>  }
>
> -/*
> - * If there are outliers, discard them by setting thresholds to exclude
> - * data points at a large enough distance from the average, then
> - * calculate the average and standard deviation again. Once we get
> - * down to the last 3/4 of our samples, stop excluding samples.
> - *
> - * This can deal with workloads that have long pauses interspersed
> - * with sporadic activity with a bunch of short pauses.
> +/* We've adjusted the hit status by the closeness, if one state is still
> + * hit more often and selected recently, we can assume that state is mor=
e
> + * likely to happen in the future
>   */
> -if (divisor * 4 <=3D INTERVALS * 3) {
> -/*
> - * If there are sufficiently many data points still under
> - * consideration after the outliers have been eliminated,
> - * returning without a prediction would be a mistake because it
> - * is likely that the next interval will not exceed the current
> - * maximum, so return the latter in that case.
> - */
> -if (divisor >=3D INTERVALS / 2)
> -return max;
> -
> -return UINT_MAX;
> +for (int state =3D 0; state < drv->state_count; state++) {
> +if (adj_weight[state] > 1 && adj_hit[state] >=3D hit_thres) {
> +adj_avg[state] /=3D adj_hit[state];
> +
> +if (adj_weight[state] > weight) {
> +weight =3D adj_weight[state];
> +high_state =3D state;
> +} else if (adj_weight[state] =3D=3D weight) {
> +if (adj_hit[state] > adj_hit[high_state])
> +high_state =3D state;
> +}
> +}
>  }
>
> -/* Update the thresholds for the next round. */
> -if (avg - min > max - avg)
> -min_thresh =3D min;
> -else
> -max_thresh =3D max;
> +if (weight)
> +return adj_avg[high_state];
>
> -goto again;
> +return UINT_MAX;
>  }
>
>  /**
> @@ -225,7 +229,7 @@ static int menu_select(struct cpuidle_driver *drv, st=
ruct cpuidle_device *dev,
>  }
>
>  /* Find the shortest expected idle interval. */
> -predicted_ns =3D get_typical_interval(data) * NSEC_PER_USEC;
> +predicted_ns =3D get_typical_interval(drv, dev, data) * NSEC_PER_USEC;
>  if (predicted_ns > RESIDENCY_THRESHOLD_NS) {
>  unsigned int timer_us;
>
> --

If you want to change the get_typical_interval() algorithm, it needs
to be justified much better than in the changelog of this patch
because you are likely to affect at least some workloads adversely.

Moreover, there are obvious whitespace issues in the patch which need
to be addressed even before it can be reviewed.

Also this absolutely is not 6.17 material, so if you decide to pursue
it, please come back with it after 6.17-rc1 is out.

Thanks!

