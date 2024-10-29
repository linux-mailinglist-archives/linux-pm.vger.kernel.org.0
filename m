Return-Path: <linux-pm+bounces-16657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509469B4858
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 12:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823DF1C2111E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2024 11:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC370205155;
	Tue, 29 Oct 2024 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdtekhKL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB75204F9E;
	Tue, 29 Oct 2024 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201485; cv=none; b=oUuYJmg0e4X4aPOlPoltNBjnncGgs4nfsuXEIoq5cjINlQxYZdQqTY2vpBmTIcB5TrhVnmEPwcg6NVBZ/pztLmnj4iK7F6guLeNGQhthNo//VfH16pONjOMB7nMSASSaEpch+AtcrdIOMUq6GK2Tgu13Ju6mB+SoG2QTrrvwX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201485; c=relaxed/simple;
	bh=b3iDHqbap1LmKFhPTuu1Qqk4svOtioflicE0/GgpTbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9iJDaiVoDokt7Vb6ErywK8xy9DQ2+JrWWjnuJIKGd7xHgcK6V1I8eKf6UisMW0NyDBoILLdo6PrMVxio5+5xrWWZo3tmiKZG584ixc3JMWAhJsQxc1Q9T8pUWlnsBv8b1cll/jkpiiB/PMjskOMeZbvySL/YomRWX9/M9O9o8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdtekhKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B37C4CEEA;
	Tue, 29 Oct 2024 11:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730201484;
	bh=b3iDHqbap1LmKFhPTuu1Qqk4svOtioflicE0/GgpTbA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FdtekhKLhC3d/47DQcpqir6P9jrHeh/KQ3dbRMElLhUWBbCPiD/wxpAj6swRfKlcv
	 l9y/mwOJ5uivr4TmsTKzbyOOz2zaC76a2fNCHcxdG0YV0vacvF4rQ4BbN80Ecf+CNc
	 cAezVQPUku0aL6ZYvrHAksowSYgq2HszMc80q/rxdUdHBA5zHC2gvQy4qc5gvApgV4
	 v05AE1JGw7pQE7KYADRciW6kB1I+IiFmKim8zeHXAUjPSkAn0QXEFHJjlZPQRMXmhq
	 gZV8fcIXD3EMTR1ulwX6Gfp2ENkLhpapFwHK+Ug9chxCxWpA5bc2kmvZAJa+sWXMXS
	 3hkh0rhoZSv3g==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-288fa5ce8f0so2571372fac.3;
        Tue, 29 Oct 2024 04:31:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqBcN3XPan4564gS4yEwelbT4dRG7B5Gyuw+4SliuZGd4pFnm8IBa88uAGv+JdPDgu7bxHsfpSljWfajY=@vger.kernel.org, AJvYcCWlSow1qvEdw+pKp3Fs4++ZOIymCKb8UOrFAtwZuHcNgY8HaPpneE0XP1JZrxZ4pSml4DBCdfOl20s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKKJWdqov2Md2QBTZ6aZmSPvje16jRjiun7NL5tMMLVrRZTAu
	mLjCH0g/c6xRH8fQLM5cye5+uq7KzQN2wEqJwOAoxNy8dxSQlWAz7zkCI7s4DSxYl4qVI11SDdm
	ur/OXsHJ3Vh8kOh5z1abniNqBGbk=
X-Google-Smtp-Source: AGHT+IEkBtXhRClA2cm6t78kcyGJpyo2fCtEeh/HZcjhxwG2r5DEwf1//i8B3FFywZwUiFp2Jvl4f95iRwVJ4NKyimU=
X-Received: by 2002:a05:6870:82a5:b0:288:59d3:2a03 with SMTP id
 586e51a60fabf-29051dd1728mr9737620fac.39.1730201484141; Tue, 29 Oct 2024
 04:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-2-beata.michalska@arm.com> <20241029070429.m7q5dkumitoyqxq2@vireshk-i7>
In-Reply-To: <20241029070429.m7q5dkumitoyqxq2@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 29 Oct 2024 12:31:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i2KUPXfeAKhkimetOMpx+5opgt26URJF8cstnZsaeZwA@mail.gmail.com>
Message-ID: <CAJZ5v0i2KUPXfeAKhkimetOMpx+5opgt26URJF8cstnZsaeZwA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Beata Michalska <beata.michalska@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	ionela.voinescu@arm.com, sudeep.holla@arm.com, will@kernel.org, 
	catalin.marinas@arm.com, rafael@kernel.org, sumitg@nvidia.com, 
	yang@os.amperecomputing.com, vanshikonda@os.amperecomputing.com, 
	lihuisong@huawei.com, zhanjie9@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 8:04=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Apologies for the delay from my side. September was mostly holidays
> for me and then I was stuck with other stuff plus email backlog and
> this series was always a painful point to return to :(
>
> On 13-09-24, 14:29, Beata Michalska wrote:
> > Currently the CPUFreq core exposes two sysfs attributes that can be use=
d
> > to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
> > and scaling_cur_freq. Both provide slightly different view on the
> > subject and they do come with their own drawbacks.
> >
> > cpuinfo_cur_freq provides higher precision though at a cost of being
> > rather expensive. Moreover, the information retrieved via this attribut=
e
> > is somewhat short lived as frequency can change at any point of time
> > making it difficult to reason from.
> >
> > scaling_cur_freq, on the other hand, tends to be less accurate but then
> > the actual level of precision (and source of information) varies betwee=
n
> > architectures making it a bit ambiguous.
> >
> > The new attribute, cpuinfo_avg_freq, is intended to provide more stable=
,
> > distinct interface, exposing an average frequency of a given CPU(s), as
> > reported by the hardware, over a time frame spanning no more than a few
> > milliseconds. As it requires appropriate hardware support, this
> > interface is optional.
>
> From what I recall, the plan is to:
> - keep cpuinfo_cur_freq as it is, not expose for x86 and call ->get()
>   for ARM.

Yes.

> - introduce cpuinfo_avg_freq() and make it return frequency from hw
>   counters for both ARM and Intel and others who provide the API.

Yes.

> - update scaling_cur_freq() to only return the requested frequency or
>   error in case of X86

Yes.

Preferably, -ENOTSUPP for "setpolicy" drivers without the .get() callback.

>   and update documentation to reflect the same.
>   Right now or after some time ? How much time ?

After some time, I think at least two cycles, so people have the time
to switch over, but much more may be necessary if someone is stuck
with RHEL or similar user space.

Anyway, x86 will be the only one affected and there may be a Kconfig
option even to allow it to be changed at the kernel build time.

The documentation for cpuinfo_avg_freq() needs to be added along with it.

> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 04fc786dd2c0..3493e5a9500d 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -752,6 +752,16 @@ __weak unsigned int arch_freq_get_on_cpu(int cpu)
> >       return 0;
> >  }
> >
> > +__weak int arch_freq_avg_get_on_cpu(int cpu)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> > +static inline bool cpufreq_avg_freq_supported(struct cpufreq_policy *p=
olicy)
> > +{
> > +     return arch_freq_avg_get_on_cpu(policy->cpu) >=3D 0;
> > +}
>
> And why aren't we simply reusing arch_freq_get_on_cpu() here ?
>
> --
> viresh

