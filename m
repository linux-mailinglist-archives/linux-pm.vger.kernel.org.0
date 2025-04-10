Return-Path: <linux-pm+bounces-25131-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4896A84811
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 17:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6266167DCD
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F81B1E9B0F;
	Thu, 10 Apr 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry7BWx4X"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5747C1E1A16;
	Thu, 10 Apr 2025 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299294; cv=none; b=W9PVxFYVWBjDKXouj8LbUutMuoK9BLO9o0CUdbTn7t+aFmbYxCflU8dOf2mL2Gk1r0Rk05EHGeVC/Mkiz34M/SGG1HbrjRZXt1a0TBzt2uYmYNeIV7TagFn6xPs1IgR9eWxlxh0PpZhSpn18t5lM8E5lS2EsMFjx3UT7V+URBJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299294; c=relaxed/simple;
	bh=Zv+Um0ud9dyGlFs+NxyqU2VYlQwgrjWX8XbkLklXQMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHF5zbqqjRikhvcNE8j/qOc3zFXA1bDG/UuS3mhYxFyNf8n8MxzluyWeGbwb0IRxvxPscBN3Cg7ktVo1VgizHqQOQum/zOvrK08yvICsP7sXMNQzi7zJpORsAZY1dpcigLy7cqRp/cEEy1+4yFHX2G3w3PT2iAkwZThySNsRRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry7BWx4X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2262C4CEE9;
	Thu, 10 Apr 2025 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744299292;
	bh=Zv+Um0ud9dyGlFs+NxyqU2VYlQwgrjWX8XbkLklXQMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ry7BWx4XZb4pF7DKL87KtGi6rEUTHbfD/nwTyaFSoaxoEPu2Dao6EShPoLS8gGuGS
	 bYiRCMpP6doJr0PUkrPLdJ/re6PV/r3A+i/7oL+BNnJWLWqRKvTnSQrQgTe/fcJKPj
	 g/M4slMc2IvSxAQTCIoULVcPPZS/pdWOSvK0rVJL2e6VwDhWxEnEKKLjhnBWo9bngX
	 9lChs2a+EvBDxfFEYMkvWPww6i5js+jn0/mfoXS56pVHpnKgE1YxaWIPUjPUBIFEKF
	 Z5ztIE/Dx9Ixpiw+v+k7NRskNryVnlH4dICfA5aGq6+3P+FhgbhPxUJnrisVRRf9H/
	 oRVMfx6EdlTiA==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2c1c9b7bd9aso539967fac.0;
        Thu, 10 Apr 2025 08:34:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrBy+cblsnyra88B6kn2sjzxd+bTYqldQh4jq7DMxlttBO7rzkdiAIUe9Z0wXfQJiBbchDNKIMSc0=@vger.kernel.org, AJvYcCXkqePN14cUA1g2dPOwG3UPHUbgCSSnnrogdQnf9eYLAFB+5kxx4xIJJr3mwO5I9RIVbC1UJMvnMyR4FZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnuPeesgakx3cAXzJpdKzWnQrKVPZdfuoPIrKZdr+mVlgHSM72
	o0MVjOFfqjPSMUwAz3ltfjrKcVN6cUWmTRQVa1ktDH5NCbUVC7r4DZTxDqnshn7AlWFoJVs5gox
	hWP2z698v83gt7yP76ZapYpn2PFI=
X-Google-Smtp-Source: AGHT+IE4pxDce+3DuPfmtgFYtz5PPOwwmefMW3guIZlO6Tzul/1CkZr1Lmkt8rKNDj0krYw+/X7DRVOn9u4lv1uZCr0=
X-Received: by 2002:a05:6871:64c9:b0:2bc:9787:affe with SMTP id
 586e51a60fabf-2d0b5bb97e1mr1746144fac.10.1744299291966; Thu, 10 Apr 2025
 08:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410024439.20859-1-sultan@kerneltoast.com>
In-Reply-To: <20250410024439.20859-1-sultan@kerneltoast.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 10 Apr 2025 17:34:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jKyy-3cELyDQTynE3Dv29V15F5f+w0A-H_nu+4LuaaYw@mail.gmail.com>
X-Gm-Features: ATxdqUGv-blLo91PP0wa4Y8Aq0RZu24wohJZpW2y1vTEU0c4WIIHykq1K6JyWLE
Message-ID: <CAJZ5v0jKyy-3cELyDQTynE3Dv29V15F5f+w0A-H_nu+4LuaaYw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Don't ignore limit changes when util
 is unchanged
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 4:45=E2=80=AFAM Sultan Alsawaf <sultan@kerneltoast.=
com> wrote:
>
> From: Sultan Alsawaf <sultan@kerneltoast.com>
>
> When utilization is unchanged, a policy limits update is ignored unless
> CPUFREQ_NEED_UPDATE_LIMITS is set. This occurs because limits_changed
> depends on the old broken behavior of need_freq_update to trigger a call
> into cpufreq_driver_resolve_freq() to evaluate the changed policy limits.
>
> After fixing need_freq_update, limit changes are ignored without
> CPUFREQ_NEED_UPDATE_LIMITS, at least until utilization changes enough to
> make map_util_freq() return something different.
>
> Fix the ignored limit changes by preserving the value of limits_changed
> until get_next_freq() is called, so limits_changed can trigger a call to
> cpufreq_driver_resolve_freq().
>
> Reported-and-tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> Link: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org
> Fixes: 8e461a1cb43d6 ("cpufreq: schedutil: Fix superfluous updates caused=
 by need_freq_update")
> Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 1a19d69b91ed3..f37b999854d52 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -82,7 +82,6 @@ static bool sugov_should_update_freq(struct sugov_polic=
y *sg_policy, u64 time)
>                 return false;
>
>         if (unlikely(sg_policy->limits_changed)) {
> -               sg_policy->limits_changed =3D false;
>                 sg_policy->need_freq_update =3D cpufreq_driver_test_flags=
(CPUFREQ_NEED_UPDATE_LIMITS);
>                 return true;
>         }
> @@ -171,9 +170,11 @@ static unsigned int get_next_freq(struct sugov_polic=
y *sg_policy,
>         freq =3D get_capacity_ref_freq(policy);
>         freq =3D map_util_freq(util, freq, max);
>
> -       if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->need_fr=
eq_update)
> +       if (freq =3D=3D sg_policy->cached_raw_freq && !sg_policy->limits_=
changed &&
> +           !sg_policy->need_freq_update)
>                 return sg_policy->next_freq;
>
> +       sg_policy->limits_changed =3D false;

AFAICS, after this code modification, a limit change may be missed due
to a possible race with sugov_limits() which cannot happen if
sg_policy->limits_changed is only cleared when it is set before
updating sg_policy->need_freq_update.

>         sg_policy->cached_raw_freq =3D freq;
>         return cpufreq_driver_resolve_freq(policy, freq);
>  }
> --
> 2.49.0
>

