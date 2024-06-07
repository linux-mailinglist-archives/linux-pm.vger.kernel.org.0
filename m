Return-Path: <linux-pm+bounces-8784-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DCF900655
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 16:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B378D1F222EA
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2024 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC45188CAD;
	Fri,  7 Jun 2024 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ni87Lu/1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9513F436;
	Fri,  7 Jun 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770124; cv=none; b=uVtKH91qxEerQU+q4WIGFK/LOQiPwjDmgbzA9SyyjK8s6SJX1IJXWKbonFX+3arDt42eCy5nyPCxIEPgIbqZppyUCfhFaVfBntwGK45ot5ZgX9ZS+gp9Has+gUqvFura9qHx6clCbjRToUJn1o1nvavc/94d4tOtPyIl/bM/OSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770124; c=relaxed/simple;
	bh=lN9LGnrgukjSjfQdaXfz6zoh1opVnc8Kbq0knfFwjw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSql0RloPVEb5SDM2v0Y1yCynVh+pZYidHkKAPcLGZJexgIegCJ9eR7prRvJauVMgtWUIf5K2ecdUZ+Bv2dn147r7+Z3ydds5F6d9DV/AshsOcPRSrQnvE9AbGozhUN+hnKZdsYVuDlcVHDax66hxeFkbe+ViwgxpFcSaFjxFMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ni87Lu/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94912C4AF09;
	Fri,  7 Jun 2024 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717770123;
	bh=lN9LGnrgukjSjfQdaXfz6zoh1opVnc8Kbq0knfFwjw4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ni87Lu/1s8fiBFXiewQHZBjZuWU0h4ZRzUgqvYVPBs74xJk03T4u3R51nIN7hsPU5
	 11Ac35LQK5xSx9u4GKn33t2vYRArPw0xPDRKzk7jUm27VjFMzteZwmC2Aj4nodnVV1
	 RsJ+B9GOESPVazKgDToSOJsCAdoFf88EkzKyUfn9oLC+2ZWIq01KjtyBQte4diylQz
	 vTbzr+AHY6+FFMTgW8cj73aCAzw4+V3rmAa7HB4B1sSbHn5byldjGSPscp22hM9O+R
	 rlLI+sP+TFOim3uEjIh02jvuUhArBO32G0ZVhqHBCxiwlrTNKDB19UfepT9F8qf4B6
	 kYvAFZloGMwzg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ba77a212adso107594eaf.3;
        Fri, 07 Jun 2024 07:22:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzpgVZmu6flofI75ma5PMqJHQS5nbYdkiUsjxpxCVGzaLrU0tXroesLFoK5eK60o6VwLOKgpSxzu8PU+h51cyNzeNP1q9fvUzWOq475VQtNyTgkRiHR+5wIXCywgfnbC78RsFJ784=
X-Gm-Message-State: AOJu0YwO4rPDJHxZ8WXI4D7olHiLJpM3uwPTCm7axp49K42nqipJEAk3
	QDxY2WIkBxccCf3FrHUQB4ybinppvQ4bhwIM20hBdRaAdfAV6YkpCs+j9EAG/7GbiEK1ag3Iwy3
	Mq2EFnAW2LPy4W8c+jHzb0OrFaxg=
X-Google-Smtp-Source: AGHT+IHrM4ProVsLq7TgVqRCERzD299+z5L7cTWF4rF+2zQvdtv5DTX/4oA2KtO7uwrtYe1Vz2O5sTGbf/mom2XM5ac=
X-Received: by 2002:a05:6820:708:b0:5ba:6669:ba6e with SMTP id
 006d021491bc7-5baaed4f14dmr2423032eaf.1.1717770122391; Fri, 07 Jun 2024
 07:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603081331.3829278-1-beata.michalska@arm.com>
 <20240603081331.3829278-2-beata.michalska@arm.com> <20240603114811.oio3uemniib5uaa2@vireshk-i7>
 <CAJZ5v0j1bqhmKrJirw+WgEVDdszZ9xQSgmfazVKMVa8H6_5TSw@mail.gmail.com> <20240606085513.pptx5dtjcvvg3zo4@vireshk-i7>
In-Reply-To: <20240606085513.pptx5dtjcvvg3zo4@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 7 Jun 2024 16:21:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0it5vZvzkbErkGOVruPbkxgr8VMTgQzsncpdQmvCOfBng@mail.gmail.com>
Message-ID: <CAJZ5v0it5vZvzkbErkGOVruPbkxgr8VMTgQzsncpdQmvCOfBng@mail.gmail.com>
Subject: Re: [PATCH 1/1] cpufreq: Rewire arch specific feedback for cpuinfo/scaling_cur_freq
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Beata Michalska <beata.michalska@arm.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, len.brown@intel.com, 
	ionela.voinescu@arm.com, vanshikonda@os.amperecomputing.com, 
	sumitg@nvidia.com, vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 10:55=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 03-06-24, 15:43, Rafael J. Wysocki wrote:
> > On Mon, Jun 3, 2024 at 1:48=E2=80=AFPM Viresh Kumar <viresh.kumar@linar=
o.org> wrote:
> > > Rafael,
> > >
> > > We probably need to decide on a policy for these two files, it is
> > > getting a bit confusing.
> > >
> > > cpuinfo_cur_freq:
> > >
> > > The purpose of this file is abundantly clear. This returns the best
> > > possible guess of the current hardware frequency. It should rely on
> > > arch_freq_get_on_cpu() or ->get() to get the value.
> >
> > Let me quote the documentation:
> >
> > "This is expected to be the frequency the hardware actually runs at.
> > If that frequency cannot be determined, this attribute should not be
> > present."
> >
> > In my reading, this has nothing to do with arch_freq_get_on_cpu(), at
> > least on x86.
> >
> > > Perhaps we can
> > > make this available all the time, instead of conditionally on ->get()
> > > callback (which isn't present for intel-pstate for example).
> >
> > We could, but then on x86 there is no expectation that this file will
> > be present and changing this may introduce significant confusion
> > because of the way it is documented (which would need to be changed,
> > but people might be forgiven for failing to notice the change of
> > interpretation of this file).
>
> > > scaling_cur_freq:
> > >
> > > This should better reflect the last requested frequency, but since a
> > > significant time now it is trying to show what cpuinfo_cur_freq shows=
.
> >
> > Well, not really.
> >
> > > commit c034b02e213d ("cpufreq: expose scaling_cur_freq sysfs file for=
 set_policy() drivers")
> > > commit f8475cef9008 ("x86: use common aperfmperf_khz_on_cpu() to calc=
ulate KHz using APERF/MPERF")
> >
> > "In the majority of cases, this is the frequency of the last P-state
> > requested by the scaling driver from the hardware using the scaling
> > interface provided by it, which may or may not reflect the frequency
> > the CPU is actually running at (due to hardware design and other
> > limitations).
> >
> > Some architectures (e.g. x86) may attempt to provide information more
> > precisely reflecting the current CPU frequency through this attribute,
> > but that still may not be the exact current CPU frequency as seen by
> > the hardware at the moment."
>
> Right, with time the documentation is updated and now it has mixed
> the purpose of both these files IMO.
>
> > So the problem is that on Intel x86 with HWP and intel_pstate in the
> > active mode, say, "the frequency of the last P-state requested by the
> > scaling driver from the hardware" is actually never known, so exposing
> > it via scaling_cur_freq is not possible.
> >
> > Moreover, because cpuinfo_cur_freq is not present at all in that case,
> > scaling_cur_freq is the only way to allow user space to get an idea
> > about the CPU current frequency.  I don't think it can be changed now
> > without confusing users.
>
> Yes, this is a valid concern. The changes in documentation have been
> there for many years and changing the behavior now is not going to be
> an easy / right thing to do.
>
> > > What should we do ? I wonder if we will break some userspace tools
> > > (which may have started relying on these changes).
> >
> > We will.
> >
> > IIUC, it is desirable to expose "the frequency of the last P-state
> > requested by the scaling driver from the hardware" via
> > scaling_cur_freq on ARM, but it is also desirable to expose an
> > approximation of the actual current CPU frequency, so the only way to
> > do that without confusing the heck out of everybody downstream would
> > be to introduce a new attribute for this purpose and document it
> > precisely.
>
> Hmm, having 3 files would confuse people even more I guess. I wanted
> to get this sorted to have the same behavior for all platforms, but it
> seems somewhat difficult to achieve now.
>
> What about this, hopefully this doesn't break any existing platforms
> and fix the problems for ARM (and others):
>
> - scaling_cur_freq:
>
>   Returns the frequency of the last P-state requested by the scaling
>   driver from the hardware.

This would change the behavior for intel_pstate in the passive mode AFAICS.

ATM it calls arch_freq_get_on_cpu(), after the change it would return
policy->cur which would not be the same value most of the time.  And
in the ->adjust_perf() case policy->cur is not updated by it even.

>  For set_policy() drivers, use the ->get()
>   callback to get a value that can provide the best estimate to user.
>
>   To make this work, we can add get() callback to intel and amd pstate
>   drivers, and use arch_freq_get_on_cpu().
>
>   This will keep the current behavior intact for such drivers.

Well, the passive mode thing would need to be addressed then.

> - cpuinfo_cur_freq:
>
>   Currently this file is available only if the get() callback is
>   available. Maybe we can keep this behavior as is, and expose this
>   now for both the pstate drivers (once above change is added). We
>   will be left with only one driver that doesn't provide the get()
>   callback: pasemi-cpufreq.c

I would rather get rid of it completely.

>   Coming back to the implementation of the file read operation, I
>   think the whole purpose of arch_freq_get_on_cpu() was to get a
>   better estimate (which may not be perfect) of the frequency the
>   hardware is really running at (in the last window) and if a platform
>   provides this, then it can be given priority over the ->get()
>   callback in order to show the value to userspace.

There was a reason to add it and it was related to policy->cur being
meaningless on x86 in general (even in the acpi-cpufreq case), but
let's not go there.

Hooking this up to cpuinfo_cur_freq on x86 wouldn't make much sense
IMV because at times it is not even close to the frequency the
hardware is running at.  It comes from the previous tick period,
basically, and the hardware can adjust the frequency with a resolution
that is orders of magnitude higher than the tick rate.

>   And so, if the platform provides, we can use arch_freq_get_on_cpu()
>   first and then the get() callback.
>
> That would leave us to this change for the core, and yes a get()
> callback for intel-pstate and amd-pstate:
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 7c6879efe9ef..e265f8450160 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -756,12 +756,8 @@ __weak unsigned int arch_freq_get_on_cpu(int cpu)
>  static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char=
 *buf)
>  {
>         ssize_t ret;
> -       unsigned int freq;
>
> -       freq =3D arch_freq_get_on_cpu(policy->cpu);
> -       if (freq)
> -               ret =3D sprintf(buf, "%u\n", freq);
> -       else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
> +       if (cpufreq_driver->setpolicy && cpufreq_driver->get)
>                 ret =3D sprintf(buf, "%u\n", cpufreq_driver->get(policy->=
cpu));
>         else
>                 ret =3D sprintf(buf, "%u\n", policy->cur);
> @@ -795,7 +791,10 @@ store_one(scaling_max_freq, max);
>  static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
>                                         char *buf)
>  {
> -       unsigned int cur_freq =3D __cpufreq_get(policy);
> +       unsigned int cur_freq =3D arch_freq_get_on_cpu(policy->cpu);
> +
> +       if (!cur_freq)
> +               cur_freq =3D __cpufreq_get(policy);
>
>         if (cur_freq)
>                 return sprintf(buf, "%u\n", cur_freq);
>
>
> I think this will also make more sense from documentation's
> perspective, which says that:
>
> "In the majority of cases, this is the frequency of the last P-state
> requested by the scaling driver from the hardware using the scaling
> interface provided by it, which may or may not reflect the frequency
> the CPU is actually running at (due to hardware design and other
> limitations)."
>
> -- we do this at the core level.
>
> "Some architectures (e.g. x86) may attempt to provide information more
> precisely reflecting the current CPU frequency through this attribute,
> but that still may not be the exact current CPU frequency as seen by
> the hardware at the moment."
>
> -- and this at driver level, as a special case.

Well, this sounds nice, but the changes are a bit problematic.

If you don't want 3 files, I'd drop cpuinfo_cur_freq and introduce
something else to replace it which will expose the
arch_freq_get_on_cpu() return value and will be documented
accordingly.

Then scaling_cur_freq can be (over time) switched over to returning
policy->cur in the cases when it is meaningful and -ENODATA otherwise.

This would at least allow us to stop making up stuff.

