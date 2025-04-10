Return-Path: <linux-pm+bounces-25171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438FA84CB1
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 21:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662897B2741
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 19:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14A228F94F;
	Thu, 10 Apr 2025 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcKCuong"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0128CF66;
	Thu, 10 Apr 2025 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312576; cv=none; b=qWrCd3EyRGZI8TvG8CGkSoC4juUpdiH1QYkjVZ8wisqhB/tjzNoGkAsbO6vc7QmeIe7qQDphDHL0FMHT/DpGE9sGHmfIFCG2eT2qN6de5kW6AGTmGMD2H6E9PAyqSEmop06V9BXFTNj6vMNsNpBrldC6FeLgC3eparCKEj5CIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312576; c=relaxed/simple;
	bh=eXB0gLYXMhzpCiJzyoTjnpTxga6WGoXYi9P2stnOHRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGXU4GHF+JYeSOyxPnFss64a2aDUEmvhoTZv1BWl0yRh55hv2+XKEvaP4TSA4i1/TN0ZkD8kzflc5ezPI1taWvUEyKtzQTNPBPM2DamZYdp8rbXg1ZBMNlqpssl2Pu3FzyY4C8SPXtfAPIJ2Raeoytk03Iww6RkzQ8b1g8Kb4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcKCuong; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E1BC4CEED;
	Thu, 10 Apr 2025 19:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744312576;
	bh=eXB0gLYXMhzpCiJzyoTjnpTxga6WGoXYi9P2stnOHRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mcKCuongpHbNiI8syLFB9uMZiSar+ZdqKrxtoTrx4ook4nqmhNVvJYHhLXqwHn256
	 /6gapHfTqjiYAF1kNNNcOQtGtcsySfQYghBSNbtDeeD8EzjAi98jX0ynHoh8avm982
	 MnLYzkyPyAqmY7OSWJwG8tcadmL1FyeNx4qVh5C2iptEDHktubEl5i+X/9CG6cnu8c
	 eAwGs2tkn5plVXy1ExhxYivpfZ/DnfRMu0gcnY0EkfmvpUHKZ5eS97kuXnd3vLpThy
	 TXrwXSjjMifzM9ocmCyP8v0tFeGhwDdEHF/5Vywej37tlE2DsKyDJOPZQS9+HRckYE
	 PPlbV/1cOdYOQ==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72c1818c394so693995a34.2;
        Thu, 10 Apr 2025 12:16:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQckeCCq16xD9kT4b96nXTsxzoO6SQiSRoHb/yPAiMbQG9SvzVLUSCgsYPaGmedAXdvEmOjkHoF4k=@vger.kernel.org, AJvYcCXeDjNHV6xjxA8lkmvA3/AIA9/lIIStEqw1hRvLJXzyjo4BwkFFtpm210FIcI9gRxPouBC28IsOHGcKD0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY4rzYTEf7Mbc5Vy1zhoRKfx51F/euh9WVq4iH2oXaD3wxAuCP
	cRYknXnSuW0xyaRGUMshqBFSAqbBgg1nQAWEbX+854zLnaQ6Lnr+XrsQ9qKfiDx6vm1czYd2CBT
	2/J8h5yVO3MP6kqmiNNJP/f2wUJE=
X-Google-Smtp-Source: AGHT+IFUGe4N+sckYuOfB96euN95iBjAjrgVAHROSXlPfyXbt8wqWK2y3y6miD1mX2A3h2eX04f3VagKPlGBaG3tlUE=
X-Received: by 2002:a05:6830:6713:b0:72b:9bb3:67cd with SMTP id
 46e09a7af769-72e863da72emr94412a34.12.1744312575370; Thu, 10 Apr 2025
 12:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212015734.41241-1-sultan@kerneltoast.com>
 <20241212015734.41241-2-sultan@kerneltoast.com> <Z_Tlc6Qs-tYpxWYb@linaro.org>
In-Reply-To: <Z_Tlc6Qs-tYpxWYb@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Apr 2025 21:16:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hR_ekOYE_bJz=U66G2puVYBubMNd+BBQoZJZ8sxg4SxQ@mail.gmail.com>
X-Gm-Features: ATxdqUFpp7ZGLllfNdShA6ZAPjqNccThuQ5ynRrZX5_AdnNDXYKm7UihM-H0OmQ
Message-ID: <CAJZ5v0hR_ekOYE_bJz=U66G2puVYBubMNd+BBQoZJZ8sxg4SxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: schedutil: Fix superfluous updates caused by need_freq_update
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Sultan Alsawaf <sultan@kerneltoast.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for kind of a retroactive response.

On Tue, Apr 8, 2025 at 10:59=E2=80=AFAM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> Hi,
>
> On Wed, Dec 11, 2024 at 05:57:32PM -0800, Sultan Alsawaf wrote:
> > From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>
> >
> > A redundant frequency update is only truly needed when there is a polic=
y
> > limits change with a driver that specifies CPUFREQ_NEED_UPDATE_LIMITS.
> >
> > In spite of that, drivers specifying CPUFREQ_NEED_UPDATE_LIMITS receive=
 a
> > frequency update _all the time_, not just for a policy limits change,
> > because need_freq_update is never cleared.
> >
> > Furthermore, ignore_dl_rate_limit()'s usage of need_freq_update also le=
ads
> > to a redundant frequency update, regardless of whether or not the drive=
r
> > specifies CPUFREQ_NEED_UPDATE_LIMITS, when the next chosen frequency is=
 the
> > same as the current one.
> >
> > Fix the superfluous updates by only honoring CPUFREQ_NEED_UPDATE_LIMITS
> > when there's a policy limits change, and clearing need_freq_update when=
 a
> > requisite redundant update occurs.
> >
> > This is neatly achieved by moving up the CPUFREQ_NEED_UPDATE_LIMITS tes=
t
> > and instead setting need_freq_update to false in sugov_update_next_freq=
().
> >
> > Signed-off-by: Sultan Alsawaf (unemployed) <sultan@kerneltoast.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sc=
hedutil.c
> > index 28c77904ea74..e51d5ce730be 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -83,7 +83,7 @@ static bool sugov_should_update_freq(struct sugov_pol=
icy *sg_policy, u64 time)
> >
> >       if (unlikely(sg_policy->limits_changed)) {
> >               sg_policy->limits_changed =3D false;
> > -             sg_policy->need_freq_update =3D true;
> > +             sg_policy->need_freq_update =3D cpufreq_driver_test_flags=
(CPUFREQ_NEED_UPDATE_LIMITS);
> >               return true;
> >       }
> >
> > @@ -96,7 +96,7 @@ static bool sugov_update_next_freq(struct sugov_polic=
y *sg_policy, u64 time,
> >                                  unsigned int next_freq)
> >  {
> >       if (sg_policy->need_freq_update)
> > -             sg_policy->need_freq_update =3D cpufreq_driver_test_flags=
(CPUFREQ_NEED_UPDATE_LIMITS);
> > +             sg_policy->need_freq_update =3D false;
> >       else if (sg_policy->next_freq =3D=3D next_freq)
> >               return false;
> >
>
> This patch breaks cpufreq throttling (e.g. for thermal cooling) for
> cpufreq drivers that:
>
>  - Have policy->fast_switch_enabled/fast_switch_possible set, but
>  - Do not have CPUFREQ_NEED_UPDATE_LIMITS flag set
>
> There are several examples for this in the tree (search for
> "fast_switch_possible"). Of all those drivers, only intel-pstate and
> amd-pstate (sometimes) set CPUFREQ_NEED_UPDATE_LIMITS.
>
> I can reliably reproduce this with scmi-cpufreq on a Qualcomm X1E
> laptop:
>
>  1. I added some low temperature trip points in the device tree,
>     together with passive cpufreq cooling.
>  2. I run a CPU stress test on all CPUs and monitor the temperatures
>     and CPU frequencies.
>
> When using "performance" governor instead of "schedutil", the CPU
> frequencies are being throttled as expected, as soon as the temperature
> trip points are reached.
>
> When using "schedutil", the CPU frequencies stay at maximum as long as
> the stress test is running. No throttling happens, so the device heats
> up far beyond the defined temperature trip points. Throttling is applied
> only after stopping the stress test, since this forces schedutil to
> re-evaluate the CPU frequency.
>
> Reverting this commit fixes the problem.
>
> Looking at the code, I think the problem is that:
>  - sg_policy->limits_changed does not result in
>    sg->policy->need_freq_update without CPUFREQ_NEED_UPDATE_LIMITS
>    anymore, and
>  - Without sg->policy->need_freq_update, get_next_freq() skips calling
>    cpufreq_driver_resolve_freq(), which would normally apply the policy
>    min/max constraints.
>
> Do we need to set CPUFREQ_NEED_UPDATE_LIMITS for all cpufreq drivers
> that set policy->fast_switch_possible?

I think that it is generally needed for ->fast_switch() because the
new limits don't take effect without running ->fast_switch().

But if that is the case, the behavior can just be made conditional on
policy->fast_switch_enabled.

> If I'm reading the documentation
> comment correctly, that flag is just supposed to enable notifications if
> the policy min/max changes, but the resolved target frequency is still
> the same.

If the policy min/max change and the resolved target frequency is
beyond the new limits. it needs to be changed.

The flag effectively says "Call my ->fast_switch() if the policy
limits have changed regardless of whether or not there is another
reason to call it."

> This is not the case here, the target frequency needs to be
> throttled, but schedutil isn't applying the new limits.
>
> Any suggestions how to fix this? I'm happy to test patches with my setup.

Replace cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS) in
sugov_should_update_freq() with sg_policy->policy->fast_switch_enabled
and (if this works), CPUFREQ_NEED_UPDATE_LIMITS can be deleted.

