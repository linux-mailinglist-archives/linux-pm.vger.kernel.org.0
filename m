Return-Path: <linux-pm+bounces-8528-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E628D8440
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 15:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A38289F47
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jun 2024 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D0312D766;
	Mon,  3 Jun 2024 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R83iDg97"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634151E4A2;
	Mon,  3 Jun 2024 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422205; cv=none; b=VNzpkXupP0HO0brBlj2DMY83YnoABM1I5NuIhTpPDKIyYiiMI0E6CCPTZUuzWL89I3s3/l3YYeXzjemBMyPV8XeXNBvvzJrbm/xMirEhs4xXDEiJpTmdr2gGBa5k6PnWLbMzGvYW+ZeInC2FHlzUVDImpV/SfjSQXND7LBbuWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422205; c=relaxed/simple;
	bh=h8Ofj8K4e+BTkQzzttTwJ0M9l8oUEQowz/5cfcCkpdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BiBSnRcZJOZhkR5WftOYhWUIdbRgSeMRgNdA/GxbGkgSLLI04/UOKFktPku/xU45JtdLpqzVXYFCg1ocKBTlaUNc8HnMgmPR4LVmqKxMYx63zulukUMVgzggKx+k0C8kGVjKV317Jj18PsqA1C5FAtie3iiD7lQk0NyALt3AB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R83iDg97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A86C32781;
	Mon,  3 Jun 2024 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717422205;
	bh=h8Ofj8K4e+BTkQzzttTwJ0M9l8oUEQowz/5cfcCkpdI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R83iDg979Ny/Cvx771e038nDC1MGkQ1EybRvGkDJw6MDEwWgPagdhBHwfZtX85TbL
	 t9EmPK7tTZrYANH4qj2Adsdt9Iv1I+xsWcj4FJ+cmZiG9KRTQcTogz1/Rz/s3T3tPw
	 fzmLG2X0ziqDBUhJn9CWBwfnZ/6O82MTRjJ2LuX+UgxWqqzuyEnNdz6+ANpD1Ug+mP
	 LznIiZ5kBQHQnaGfVbBvaSRJofT3DnCqvxUqkfYTmQFfM7W0oo8kGjNvODN0L4q+HT
	 MniI+I7RTysD9lQrESjP859D2tNzL4Jhw/XGlY4KeMdjBMg/Sb/N4LsMeQBB8S3Ps7
	 PlCfGnYD552wg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ba3201c209so65403eaf.3;
        Mon, 03 Jun 2024 06:43:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpVXNE1xT3CWNCc5axe36fSeNn5mJvVJXF/hT5RgeFz3BBU/UKLCH4h+OG4FxEl804p9t8Tq6pcz+5biWwmcLWP74ljGLOXHWSTbPRskvDAYQQIe2ZqDBUnSZ5GPEiUsy2Ucrl5Dk=
X-Gm-Message-State: AOJu0YzfAcaYWSm9CX9i35QqjI9+nDrQGuxFBbjNPWmNAkn4FfmdOlqD
	SZrlQ9pyxq+foNKiyrZtUx7g4C8DfG11Jns6f3e1RpmZrUGppj2t/SRIszgs/d6cS9Uo48LW/OH
	0EK8qixvCR1SsbHT6WSJbjjjWLTQ=
X-Google-Smtp-Source: AGHT+IEWM5TA89pH8jZ9tKeiIYCH61QlC02EvkKdKvNEBD5hfm/gUVpb0gbCxz8WjGrxQGu4C9AolcAgJC8MA1fn0BI=
X-Received: by 2002:a05:6820:d86:b0:5af:be60:ccdc with SMTP id
 006d021491bc7-5ba053a8cebmr9838281eaf.0.1717422204079; Mon, 03 Jun 2024
 06:43:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603081331.3829278-1-beata.michalska@arm.com>
 <20240603081331.3829278-2-beata.michalska@arm.com> <20240603114811.oio3uemniib5uaa2@vireshk-i7>
In-Reply-To: <20240603114811.oio3uemniib5uaa2@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Jun 2024 15:43:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j1bqhmKrJirw+WgEVDdszZ9xQSgmfazVKMVa8H6_5TSw@mail.gmail.com>
Message-ID: <CAJZ5v0j1bqhmKrJirw+WgEVDdszZ9xQSgmfazVKMVa8H6_5TSw@mail.gmail.com>
Subject: Re: [PATCH 1/1] cpufreq: Rewire arch specific feedback for cpuinfo/scaling_cur_freq
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Beata Michalska <beata.michalska@arm.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael@kernel.org, len.brown@intel.com, 
	ionela.voinescu@arm.com, vanshikonda@os.amperecomputing.com, 
	sumitg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 1:48=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> Hi Beata,
>
> Thanks for taking this forward.
>
> On 03-06-24, 09:13, Beata Michalska wrote:
> > Some architectures provide a way to determine an average frequency over
> > a certain period of time, based on available performance monitors (AMU =
on
> > ARM or APERF/MPERf on x86). With those at hand, enroll arch_freq_get_on=
_cpu
> > into cpuinfo_cur_freq policy sysfs attribute handler, which is expected=
 to
> > represent the current frequency of a given CPU,as obtained by the hardw=
are.
> > This is the type of feedback that counters do provide.
>
> Please add blank line between paragraphs, it makes it easier to read
> them.
>
> > At the same time, keep the scaling_cur_freq attribute align with the do=
cs
> > and make it provide most recently requested frequency, still allowing t=
o
> > fallback to using arch_freq_get_on_cpu for cases when cpuinfo_cur_freq =
is
> > not available.
>
> Please split this patch into two parts, they are very distinct changes
> and should be kept separate.
>
> > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index a45aac17c20f..3b0eabe4a983 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -758,7 +758,8 @@ static ssize_t show_scaling_cur_freq(struct cpufreq=
_policy *policy, char *buf)
> >       ssize_t ret;
> >       unsigned int freq;
> >
> > -     freq =3D arch_freq_get_on_cpu(policy->cpu);
> > +     freq =3D !cpufreq_driver->get ? arch_freq_get_on_cpu(policy->cpu)
> > +                                 : 0;
>
> This is getting trickier than I thought as I dived into more details
> of all the changes to the file.
>
> Rafael,
>
> We probably need to decide on a policy for these two files, it is
> getting a bit confusing.
>
> cpuinfo_cur_freq:
>
> The purpose of this file is abundantly clear. This returns the best
> possible guess of the current hardware frequency. It should rely on
> arch_freq_get_on_cpu() or ->get() to get the value.

Let me quote the documentation:

"This is expected to be the frequency the hardware actually runs at.
If that frequency cannot be determined, this attribute should not be
present."

In my reading, this has nothing to do with arch_freq_get_on_cpu(), at
least on x86.

> Perhaps we can
> make this available all the time, instead of conditionally on ->get()
> callback (which isn't present for intel-pstate for example).

We could, but then on x86 there is no expectation that this file will
be present and changing this may introduce significant confusion
because of the way it is documented (which would need to be changed,
but people might be forgiven for failing to notice the change of
interpretation of this file).

> scaling_cur_freq:
>
> This should better reflect the last requested frequency, but since a
> significant time now it is trying to show what cpuinfo_cur_freq shows.

Well, not really.

> commit c034b02e213d ("cpufreq: expose scaling_cur_freq sysfs file for set=
_policy() drivers")
> commit f8475cef9008 ("x86: use common aperfmperf_khz_on_cpu() to calculat=
e KHz using APERF/MPERF")

"In the majority of cases, this is the frequency of the last P-state
requested by the scaling driver from the hardware using the scaling
interface provided by it, which may or may not reflect the frequency
the CPU is actually running at (due to hardware design and other
limitations).

Some architectures (e.g. x86) may attempt to provide information more
precisely reflecting the current CPU frequency through this attribute,
but that still may not be the exact current CPU frequency as seen by
the hardware at the moment."

So the problem is that on Intel x86 with HWP and intel_pstate in the
active mode, say, "the frequency of the last P-state requested by the
scaling driver from the hardware" is actually never known, so exposing
it via scaling_cur_freq is not possible.

Moreover, because cpuinfo_cur_freq is not present at all in that case,
scaling_cur_freq is the only way to allow user space to get an idea
about the CPU current frequency.  I don't think it can be changed now
without confusing users.

> What should we do ? I wonder if we will break some userspace tools
> (which may have started relying on these changes).

We will.

IIUC, it is desirable to expose "the frequency of the last P-state
requested by the scaling driver from the hardware" via
scaling_cur_freq on ARM, but it is also desirable to expose an
approximation of the actual current CPU frequency, so the only way to
do that without confusing the heck out of everybody downstream would
be to introduce a new attribute for this purpose and document it
precisely.

