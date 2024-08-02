Return-Path: <linux-pm+bounces-11836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B36945EF7
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 15:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED03E1C21EB9
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62A71E4858;
	Fri,  2 Aug 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKhfVyWf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBB11E4852;
	Fri,  2 Aug 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607144; cv=none; b=J8mnQQetKwVkzfza3PrZJISbL+On0BNsYvYQ4T18ACt4b16Op3U3F49DIvhlZVS/UzDiec5uz/XCE9BZgFHkh8La3GN9RrzqEY07HvzySC6FrHXADUuOVnnr+Cyw9WFEwBhTsBE6sSbYjw5YZtwMFoOpTJdExXSGYgrHRodz4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607144; c=relaxed/simple;
	bh=OtZg7MVfiNOFgZg+v5YJ0GgQErWHG85VkskMVbpKfmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6CBq9J/Zetl4RBZEuh4ZyFuCw6KofyeFnSTKO65UyzBp/+dx1bqj3dvEbo5+FPMkGd0TWVSi+MB19BmJh07e/NMc4Oo31RZljHORDBDMRRA+H/Y391raJ9FX+nALXxVagxpa0lPY2nSVAxfbaulVXjIoAyQRR7lkWePzdqwvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKhfVyWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61BAC4AF0B;
	Fri,  2 Aug 2024 13:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722607143;
	bh=OtZg7MVfiNOFgZg+v5YJ0GgQErWHG85VkskMVbpKfmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qKhfVyWfky100NMk/l4OGSi8M00JQIU4LGnplGdmwiMdJgwsaWd2EAualisNipZz+
	 wjLQrB4MbQIatAsLLdjxtBupSY804nKNz4PQpzvy4uebNJ82LsnsyNJq5ImR651OuC
	 K1QvJmH9UthRgsH7PI0jaxiztyr8ceTN+K5EOw1CKZpz6vb72PWwjGBhrBxD7M7RoY
	 Ux/EQ3KXDtrdLGtanYMr6a0j6mJrxHbYWo1ydFYTcK3FN5tZ/OqKj3xiV7ohnvlgBi
	 lx600L0cCOgo/QrVW966m6nEtGfRFoGVzoKKYff81K6oow04TzKM/8pNLMeRDHpYnp
	 9TGXIO9gt4BDw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-260ec349a63so359817fac.0;
        Fri, 02 Aug 2024 06:59:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmI/dynnU4/By/WkZfSROYM3Q3hsw7Gg4/4JSpd6ys2G1/VSSQ3ZYD7rW6LT2D99n2ZnhTcLze1WKvLFcLL0WwZ2aijIACE81IgAN08gLEvSVQmMRxrxhfFvrVjI4rTUuPSK4NujU=
X-Gm-Message-State: AOJu0YxZGLex5ICSja3USeHBf+aom37sQHHFMUvrX7g+fCzWvw/djnBy
	CNEAgInmZNYu2zOWnG3cqn1TGoLdy6y2PX57Lx+duqzsnyryLlHdHekKd7e+pFh+K5cijy6Aksn
	7QwrITTRcuo2yO2lFfYT0hYdyfXg=
X-Google-Smtp-Source: AGHT+IGakvfJekOSTLu6GhweD8EcCIbzmpdgELx0sCnUAQaLD1UAGhd/53SjnfZnaUeAHEoF/M+4C0ySaL6V1vyxbl0=
X-Received: by 2002:a05:6870:eca8:b0:260:edbc:d7fc with SMTP id
 586e51a60fabf-26891b2857bmr2509524fac.4.1722607143157; Fri, 02 Aug 2024
 06:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728192659.58115-1-qyousef@layalina.io>
In-Reply-To: <20240728192659.58115-1-qyousef@layalina.io>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Aug 2024 15:58:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jK0Y2wcgW9uqqAACkHNu5RB7RWky=TJC-RnBrdd8yO5A@mail.gmail.com>
Message-ID: <CAJZ5v0jK0Y2wcgW9uqqAACkHNu5RB7RWky=TJC-RnBrdd8yO5A@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: sched/schedutil: Remove LATENCY_MULTIPLIER
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 9:27=E2=80=AFPM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> The current LATENCY_MULTIPLIER which has been around for nearly 20 years
> causes rate_limit_us to be always in ms range.
>
> On M1 mac mini I get 50 and 56us transition latency, but due to the 1000
> multiplier we end up setting rate_limit_us to 50 and 56ms, which gets
> capped into 2ms and was 10ms before e13aa799c2a6 ("cpufreq: Change
> default transition delay to 2ms")
>
> On Intel I5 system transition latency is 20us but due to the multiplier
> we end up with 20ms that again is capped to 2ms.
>
> Given how good modern hardware and how modern workloads require systems
> to be more responsive to cater for sudden changes in workload (tasks
> sleeping/wakeup/migrating, uclamp causing a sudden boost or cap) and
> that 2ms is quarter of the time of 120Hz refresh rate system, drop the
> old logic in favour of providing 50% headroom.
>
>         rate_limit_us =3D 1.5 * latency.
>
> I considered not adding any headroom which could mean that we can end up
> with infinite back-to-back requests.
>
> I also considered providing a constant headroom (e.g: 100us) assuming
> that any h/w or f/w dealing with the request shouldn't require a large
> headroom when transition_latency is actually high.
>
> But for both cases I wasn't sure if h/w or f/w can end up being
> overwhelmed dealing with the freq requests in a potentially busy system.
> So I opted for providing 50% breathing room.
>
> This is expected to impact schedutil only as the other user,
> dbs_governor, takes the max(2*tick, transition_delay_us) and the former
> was at least 2ms on 1ms TICK, which is equivalent to the max_delay_us
> before applying this patch. For systems with TICK of 4ms, this value
> would have almost always ended up with 8ms sampling rate.
>
> For systems that report 0 transition latency, we still default to
> returning 1ms as transition delay.
>
> This helps in eliminating a source of latency for applying requests as
> mentioned in [1]. For example if we have a 1ms tick, most systems will
> miss sending an update at tick when updating the util_avg for a task/CPU
> (rate_limit_us will be 2ms for most systems).
>
> [1] https://lore.kernel.org/lkml/20240724212255.mfr2ybiv2j2uqek7@airbuntu=
/
>
> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> ---
>  drivers/cpufreq/cpufreq.c | 27 ++++-----------------------
>  include/linux/cpufreq.h   |  6 ------
>  2 files changed, 4 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 04fc786dd2c0..f98c9438760c 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -575,30 +575,11 @@ unsigned int cpufreq_policy_transition_delay_us(str=
uct cpufreq_policy *policy)
>                 return policy->transition_delay_us;
>
>         latency =3D policy->cpuinfo.transition_latency / NSEC_PER_USEC;
> -       if (latency) {
> -               unsigned int max_delay_us =3D 2 * MSEC_PER_SEC;
> +       if (latency)
> +               /* Give a 50% breathing room between updates */
> +               return latency + (latency >> 1);
>
> -               /*
> -                * If the platform already has high transition_latency, u=
se it
> -                * as-is.
> -                */
> -               if (latency > max_delay_us)
> -                       return latency;
> -
> -               /*
> -                * For platforms that can change the frequency very fast =
(< 2
> -                * us), the above formula gives a decent transition delay=
. But
> -                * for platforms where transition_latency is in milliseco=
nds, it
> -                * ends up giving unrealistic values.
> -                *
> -                * Cap the default transition delay to 2 ms, which seems =
to be
> -                * a reasonable amount of time after which we should reev=
aluate
> -                * the frequency.
> -                */
> -               return min(latency * LATENCY_MULTIPLIER, max_delay_us);
> -       }
> -
> -       return LATENCY_MULTIPLIER;
> +       return USEC_PER_MSEC;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d4d2f4d1d7cb..e0e19d9c1323 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -577,12 +577,6 @@ static inline unsigned long cpufreq_scale(unsigned l=
ong old, u_int div,
>  #define CPUFREQ_POLICY_POWERSAVE       (1)
>  #define CPUFREQ_POLICY_PERFORMANCE     (2)
>
> -/*
> - * The polling frequency depends on the capability of the processor. Def=
ault
> - * polling frequency is 1000 times the transition latency of the process=
or.
> - */
> -#define LATENCY_MULTIPLIER             (1000)
> -
>  struct cpufreq_governor {
>         char    name[CPUFREQ_NAME_LEN];
>         int     (*init)(struct cpufreq_policy *policy);
> --

Applied as 6.12 material, thanks!

