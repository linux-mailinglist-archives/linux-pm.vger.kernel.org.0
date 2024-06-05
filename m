Return-Path: <linux-pm+bounces-8650-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEEF8FD0A0
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 16:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE541F21C0A
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC22A17BCB;
	Wed,  5 Jun 2024 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IItoganz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230219D889;
	Wed,  5 Jun 2024 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717597066; cv=none; b=H/aYyp3D9bsGBXwbZQo6qfvKl55pqufClvXIggqltCWiDo2dK/JD9WrNkxE0ei8aV/xoOMqSFfBs39oJiWGgbILfSDEI/SjQqi7wPhPLHpzFBot4B9hz9mgHJrepYlgc3tu87zWqKO80YBlkl6obM6/Gs5PxphTZwQcXvmK5fU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717597066; c=relaxed/simple;
	bh=XEx/RmLIAYzNyNyRLPZfdvmzntgVOQycajzJ1rdomLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leO6HSKmax8X/6KjeU8FRozdFp//xZq1V3leg0C/bgvFz4urJQTAL/2y1LzHeCV4PbAxoDDASOyIgHGeYgJKVCzu5hahdi1nloJCjoJBu7LXzHpbaLu+ukoCLoEtDEHTtpNQ5BAvuZ+1xyxR16is+L4YgM4JTSos7/zjHY0dVqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IItoganz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F0EC32782;
	Wed,  5 Jun 2024 14:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717597066;
	bh=XEx/RmLIAYzNyNyRLPZfdvmzntgVOQycajzJ1rdomLo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IItoganzLnx0lSwTSZIHuhQhh9O5JJ0bM1Bsa8/zvIK1CJb/oftCjbeBNCPDaBnbP
	 KEzP7mM7r2ThKIKnYWXAHR7m6RCdj9mhakmpBTif8brruizBiJpiJC/02N2Q+nk13h
	 OK/gnO7gOLQ6/EXHHDyzXJsnfn3ZXawD9oyfHJigMWU5eHacEYHM4q+ptgc5jhxKwm
	 stHox8ATBR4qHK9fIoLHPOgJlfbU88Czk5JH6BGUn/b2mzHHkjZuUbjaNEluygb4ZS
	 guYBQ92b0jm6f4XOKVP2CXrO8owT1sr7aLJ8GOBM68pdDudVnCnSvzNhwxnI8zqwjc
	 Ef6uIAPZg6zrA==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ba8e1b9018so18225eaf.0;
        Wed, 05 Jun 2024 07:17:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLMHaBf4+2j0qKO1cRSanQqR8u+IZ+Tvl6I1vBgW7JFBEQ6P/4VxVWpfZ9F5B5iwB1u0nKttXBzQIO4Q0lU3CMryxIS9RU/bAJfj8UTv6nXXie48O07n+sC8fOrENmHQxG34ZWd9E=
X-Gm-Message-State: AOJu0Yw7aMw8R0JEjOcQWJeyPyNNpLocp1hozhDwWTKVHxcni7T5vff4
	REoHpnixSHSgtPbdRZkA5pnD0ydKZ8HQ6P8l/YjkNh6xgiuXIx/wKxXwutOynGyU2dpa0+8RRpc
	MCTlh7KvWl/NHBYqbzFJjZkkrGdI=
X-Google-Smtp-Source: AGHT+IGDu6kwEQ0DTB9/+Bnljb2JjaovmKHQ6zpd9xLNAkVHUxl1PjvZohg0OWijUcexk+5pWFxsv909XanZ1RZ5Czw=
X-Received: by 2002:a4a:a7c9:0:b0:5ba:6669:ba6e with SMTP id
 006d021491bc7-5ba78ff8903mr2780302eaf.1.1717597065543; Wed, 05 Jun 2024
 07:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603081331.3829278-1-beata.michalska@arm.com>
 <20240603081331.3829278-2-beata.michalska@arm.com> <20240603114811.oio3uemniib5uaa2@vireshk-i7>
 <CAJZ5v0j1bqhmKrJirw+WgEVDdszZ9xQSgmfazVKMVa8H6_5TSw@mail.gmail.com> <ZmAjfyGWtti17WiO@arm.com>
In-Reply-To: <ZmAjfyGWtti17WiO@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Jun 2024 16:17:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jyYZh45tngb176yhvWdS+KEurNM7=scF6HArU54_u0Fw@mail.gmail.com>
Message-ID: <CAJZ5v0jyYZh45tngb176yhvWdS+KEurNM7=scF6HArU54_u0Fw@mail.gmail.com>
Subject: Re: [PATCH 1/1] cpufreq: Rewire arch specific feedback for cpuinfo/scaling_cur_freq
To: Beata Michalska <beata.michalska@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, len.brown@intel.com, 
	ionela.voinescu@arm.com, vanshikonda@os.amperecomputing.com, 
	sumitg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 10:36=E2=80=AFAM Beata Michalska <beata.michalska@ar=
m.com> wrote:
>
> On Mon, Jun 03, 2024 at 03:43:12PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jun 3, 2024 at 1:48=E2=80=AFPM Viresh Kumar <viresh.kumar@linar=
o.org> wrote:
> > >
> > > Hi Beata,
> > >
> > > Thanks for taking this forward.
> > >
> > > On 03-06-24, 09:13, Beata Michalska wrote:
> > > > Some architectures provide a way to determine an average frequency =
over
> > > > a certain period of time, based on available performance monitors (=
AMU on
> > > > ARM or APERF/MPERf on x86). With those at hand, enroll arch_freq_ge=
t_on_cpu
> > > > into cpuinfo_cur_freq policy sysfs attribute handler, which is expe=
cted to
> > > > represent the current frequency of a given CPU,as obtained by the h=
ardware.
> > > > This is the type of feedback that counters do provide.
> > >
> > > Please add blank line between paragraphs, it makes it easier to read
> > > them.
> > >
> > > > At the same time, keep the scaling_cur_freq attribute align with th=
e docs
> > > > and make it provide most recently requested frequency, still allowi=
ng to
> > > > fallback to using arch_freq_get_on_cpu for cases when cpuinfo_cur_f=
req is
> > > > not available.
> > >
> > > Please split this patch into two parts, they are very distinct change=
s
> > > and should be kept separate.
> > >
> > > > Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> > > > ---
> > > >  drivers/cpufreq/cpufreq.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index a45aac17c20f..3b0eabe4a983 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -758,7 +758,8 @@ static ssize_t show_scaling_cur_freq(struct cpu=
freq_policy *policy, char *buf)
> > > >       ssize_t ret;
> > > >       unsigned int freq;
> > > >
> > > > -     freq =3D arch_freq_get_on_cpu(policy->cpu);
> > > > +     freq =3D !cpufreq_driver->get ? arch_freq_get_on_cpu(policy->=
cpu)
> > > > +                                 : 0;
> > >
> > > This is getting trickier than I thought as I dived into more details
> > > of all the changes to the file.
> > >
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
> My reading on this (and I might be wrong) is that for x86,
> arch_freq_get_on_cpu() is utilizing the APERF/MPERF registers to get
> a rough/average frequency and as such it does, in a way, get a hw feedbac=
k
> and it does somewhat fall under "frequency the hardware actually runs at"=
.

But it is not expected to somewhat fall under that definition, it is
expected to be exactly the frequency the CPU is running at when the
file is accessed.

In the past, there was hardware that could provide that information.

> Because it is an average value, it might not provide an instant view on
> current frequency, but either way, the value provided here migh be a bit =
off
> anyway.

Well, not just a bit.  It may be off completely.

> But then, we could adjust the timewidnow being used to make it more
> accurate.

Not on x86 AFAICS because the time window is the scheduler tick period.

On x86 it is better to use a utility like turbostat to measure
frequency instead of the cpufreq sysfs (or /proc/cpuinfo for that
matter).

> I might be looking at it the wrong way though.
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
> >
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
> >
> > So the problem is that on Intel x86 with HWP and intel_pstate in the
> > active mode, say, "the frequency of the last P-state requested by the
> > scaling driver from the hardware" is actually never known, so exposing
> > it via scaling_cur_freq is not possible.
> >
> > Moreover, because cpuinfo_cur_freq is not present at all in that case,
> > scaling_cur_freq is the only way to allow user space to get an idea
> > about the CPU current frequency.  I don't think it can be changed now
> > without confusing users.
> >
> What's your take on leaving the scaling_cur_freq to resolve to
> arch_freq_get_on_cpu() when cpuinfo_cur_freq is not present ?

IIUC that's what happens right now on x86 and I don't see major
problems with it.

> This way nothing will change for the intel_pstate + HWP
> but it will allow using the info provided by arch_freq_get_on_cpu() for
> cpuinfo_cur_freq if one is provided and it will automatically ignore it f=
or
> scaling_cur_freq ? Though I guess it falls under "making all confused" th=
at you
> have described donw the line.

Well, it does.

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
> What would introducing new attribute mean for scaling_cur_freq on x86 the=
n ?

Nothing to start with, but later it might be possible to make it only
work for drivers that don't implement ->setpolicy(), ie. when
policy->cur is well defined, so scaling_cur_freq, if it were present,
would only return the last frequency requested by the driver.

> I do assume we would leave cpuinfo_cur_freq untouched without calling
> arch_freq_get_on_cpu() (as it is now). Then keeping scaling_cur_freq to a=
ctually
> use it - what would be the 3rd attribute meaning, if:
> - cpuinfo_cur_freq -> actual freq as seen by the hardware (but not the
>   counters?)

This is to be used only when the hardware can tell what frequency the
CPU is running at when it is asked for that value.

> - scaling_cur_freq -> last requested frequency and for some cases, feedba=
ck from
>   counters

Yes, but see above - I would prefer to limit it to the last requested
frequency in the future.

> - whatever_name_we_will_come_with -> average frequency based on counters =
?

Yes.

>   not always available

None of them would be always present, but at least one of them would
be present on any system.

>  It is still bit confusing.

Fair enough.

