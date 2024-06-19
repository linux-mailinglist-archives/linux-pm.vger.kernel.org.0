Return-Path: <linux-pm+bounces-9618-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFCC90F647
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 20:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B921C23291
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1315156C6C;
	Wed, 19 Jun 2024 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olp51VWv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9965A1BF37;
	Wed, 19 Jun 2024 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822754; cv=none; b=JNZPgJsggcpcfrYZWKBaqsCORaYiPx25hSytz24D90E5UzLBDgYQtGu2dOcIz+BadOjmsMkJmzS0XTpGG4TlpI7rjZKnBEGGQX953FF+Av2lVYkDBJ4IT+NP/F07VgR4eVlNq0UWe/9eN+QqJ3u6TBYbtSf/MlJoDlI+GdKBswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822754; c=relaxed/simple;
	bh=LnvttFyoAWSkuawVy/9codAPfnxNDkMkJ4iJyuXHu4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1G9Q0Q9EwO38rEHdE/tL6qYfa1mIAWNEOeLh+53J1/ZxITLBZiqXm4aSKhEgVo8N9qJ60AXzdcKDdJYV3QK7Y2FstU+3xeLoneN8ZZrZFYjSki0AsZ0raa0jP0ZsPT3TCsQMUx1LmOIBIYIL5PaaYXBwEwkpAqVejQKuqtYpQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olp51VWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E48C4AF09;
	Wed, 19 Jun 2024 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718822754;
	bh=LnvttFyoAWSkuawVy/9codAPfnxNDkMkJ4iJyuXHu4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=olp51VWvhKIb+U3wldz9Dp/v31KChoierAHu85CMI/y69b52vQxdiddvOFMTAVKHR
	 u01IegGbZbnVg6ULCnZup6NSJ/4RtdzmYXGJd2ybRDIb9O5o4GsUXDmIn8z/fGXZcS
	 JceBYxafdv0jhPYHZkgb9/Qyr5z67HAyssWXSVf4xRpa0LlTP2jHsS3pwDmyBqP3ha
	 HAv0SZ5mPqfMgW+gpv1sW89Z2fj/1DWiI7WX8szW8eNkzS8klqdhB8EHVv+MxN2MMx
	 4C3ROaSBWvx7Uextb8O26EZUDkeUHrXZasPHsd2+RH6NOrI0UK/r5JXSmj5IEGADII
	 rfaflBhmNyOyQ==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5bae827df63so1502eaf.3;
        Wed, 19 Jun 2024 11:45:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/9F/e3UV3XIByQINNb8Hgdn/pzKaW73bkCMPMoWgTxH2Q4h2eiIm9MzbzrN0gR43OerPBY/ZETO8wc3saFeibbTwIHaMJSK6J0tbphevGZ0hF8VDoBhVHEH0hEk2jsgzLG+6le6g=
X-Gm-Message-State: AOJu0YwWBtGSCTp/cgfptqkcCl3nHGyq466fav9wP8TSO21MSXPARAph
	xdQdhe7g2/oVvSKVatlBUYQBjA1MF1hgegw/FZSkoITBuvofYvVpYmzyt55sxQ/ETy61dd82Vdq
	b5vTTgHr0sW4jD6YYjwQSEf5ePOE=
X-Google-Smtp-Source: AGHT+IGNKmtp8sSF77RfefKSh6NOj/ZLCbev2ggM8c8woGdyv9hH/XPACV482/vYzxoqoRVOJefsJJaAYygHx0ECG9g=
X-Received: by 2002:a4a:bc8f:0:b0:5be:9981:bb69 with SMTP id
 006d021491bc7-5c1adbed14dmr3732672eaf.1.1718822753279; Wed, 19 Jun 2024
 11:45:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619031250.2936087-1-tj@kernel.org> <20240619031250.2936087-2-tj@kernel.org>
In-Reply-To: <20240619031250.2936087-2-tj@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Jun 2024 20:45:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i=0QqkvjA9mnqcX6Yv-T+rQ7ZKvuF1HPJL8pG2kqicGQ@mail.gmail.com>
Message-ID: <CAJZ5v0i=0QqkvjA9mnqcX6Yv-T+rQ7ZKvuF1HPJL8pG2kqicGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq_schedutil: Refactor sugov_cpu_is_busy()
To: Tejun Heo <tj@kernel.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	mingo@redhat.com, peterz@infradead.org, David Vernet <dvernet@meta.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 5:13=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> sugov_cpu_is_busy() is used to avoid decreasing performance level while t=
he
> CPU is busy and called by sugov_update_single_freq() and
> sugov_update_single_perf(). Both callers repeat the same pattern to first
> test for uclamp and then the business. Let's refactor so that the tests
> aren't repeated.
>
> The new helper is named sugov_hold_freq() and tests both the uclamp
> exception and CPU business. No functional changes. This will make adding
> more exception conditions easier.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

for this particular change.

> ---
>  kernel/sched/cpufreq_schedutil.c | 38 +++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index eece6244f9d2..972b7dd65af2 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -325,16 +325,27 @@ static unsigned long sugov_iowait_apply(struct sugo=
v_cpu *sg_cpu, u64 time,
>  }
>
>  #ifdef CONFIG_NO_HZ_COMMON
> -static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
> +static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
>  {
> -       unsigned long idle_calls =3D tick_nohz_get_idle_calls_cpu(sg_cpu-=
>cpu);
> -       bool ret =3D idle_calls =3D=3D sg_cpu->saved_idle_calls;
> +       unsigned long idle_calls;
> +       bool ret;
> +
> +       /* if capped by uclamp_max, always update to be in compliance */
> +       if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
> +               return false;
> +
> +       /*
> +        * Maintain the frequency if the CPU has not been idle recently, =
as
> +        * reduction is likely to be premature.
> +        */
> +       idle_calls =3D tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
> +       ret =3D idle_calls =3D=3D sg_cpu->saved_idle_calls;
>
>         sg_cpu->saved_idle_calls =3D idle_calls;
>         return ret;
>  }
>  #else
> -static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return =
false; }
> +static inline bool sugov_hold_freq(struct sugov_cpu *sg_cpu) { return fa=
lse; }
>  #endif /* CONFIG_NO_HZ_COMMON */
>
>  /*
> @@ -382,14 +393,8 @@ static void sugov_update_single_freq(struct update_u=
til_data *hook, u64 time,
>                 return;
>
>         next_f =3D get_next_freq(sg_policy, sg_cpu->util, max_cap);
> -       /*
> -        * Do not reduce the frequency if the CPU has not been idle
> -        * recently, as the reduction is likely to be premature then.
> -        *
> -        * Except when the rq is capped by uclamp_max.
> -        */
> -       if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> -           sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
> +
> +       if (sugov_hold_freq(sg_cpu) && next_f < sg_policy->next_freq &&
>             !sg_policy->need_freq_update) {
>                 next_f =3D sg_policy->next_freq;
>
> @@ -436,14 +441,7 @@ static void sugov_update_single_perf(struct update_u=
til_data *hook, u64 time,
>         if (!sugov_update_single_common(sg_cpu, time, max_cap, flags))
>                 return;
>
> -       /*
> -        * Do not reduce the target performance level if the CPU has not =
been
> -        * idle recently, as the reduction is likely to be premature then=
.
> -        *
> -        * Except when the rq is capped by uclamp_max.
> -        */
> -       if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> -           sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
> +       if (sugov_hold_freq(sg_cpu) && sg_cpu->util < prev_util)
>                 sg_cpu->util =3D prev_util;
>
>         cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
> --
> 2.45.2
>
>

