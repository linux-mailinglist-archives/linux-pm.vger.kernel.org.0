Return-Path: <linux-pm+bounces-16955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2479BB608
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 14:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54E31F22D69
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6375870816;
	Mon,  4 Nov 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heEWASTd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2F42A9E;
	Mon,  4 Nov 2024 13:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726784; cv=none; b=RETu6fnZuuyG83M4DAX3yVXYvAEOfkdGT9X+8jQECgN7V0gnWu8kzorK4prR7u+RPCbLxy8IXGvRNd4PBuoer+FGg8MGIoD4kZT2Xdp6gf5t0cmwZGYOtbvY0OOK8HmFhjyoZcZ78Rq8tpDnvl4XnSKOYClSmrsLojar0LKQnRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726784; c=relaxed/simple;
	bh=2npuqEnFVOpXdcm9SyHNNBtDUbAK48QR2TgxQxgOq6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtTAmTRFmXOI18e57iRfGef7SVMFSqyf0uV/6H9LUWTgwSRAjf9TGCzivs2SQbNxG+3brFWNIMR8Gqc0jCgXeKZtI9lSJ4krebF1gMPihC7B4qEwJfH5h9Krhbc7lF/naHZKlW4INhK77SuwmPzzYAlD4G3lHzb/bfVJUaLhEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heEWASTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F88C4AF0B;
	Mon,  4 Nov 2024 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730726783;
	bh=2npuqEnFVOpXdcm9SyHNNBtDUbAK48QR2TgxQxgOq6A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=heEWASTdPKalH4KWz6yWC0fw1k0Hvpx4eSRAXXtfjQI2Ta4s3XfORXm6PMlDu9obR
	 5soBOxU1UXpU7WVp/8xuac0DzXiOeSEuRe0yBN4MFfO5XztMmqqVybcxOaHdMEBvK2
	 jJZUDpcvNBMX2jlP3APzItgOrYUKyNdv1afZX1fmY01q9shp/7llhziS0c2YUvBDiC
	 CoLMCaCeU5MStfCSKmcBzLBWbhtJ28OPmtK4UH7xt68368RTedY2fa3UxfBzO1g4/K
	 3EToh1KPh6HSJV8WGgSzTzTioRs9xA7WIknyUTzoKl6Zd6N65XBn8XipMVGSPNsAan
	 GspCFnxOWaEug==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-288d70788d6so1919841fac.1;
        Mon, 04 Nov 2024 05:26:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRZ8rnnMLpMj7z58qsACeHyHVDQGCMz93J0skCDUAbai+XjcRODLSBAfM2rr1b9SIn79WEsCZkDXQ=@vger.kernel.org, AJvYcCX+fi1tD2d0lCN1OhGABOzMdhMUWEFOXfr8O3JlARK3Q4LfX/UCpElQNDoyKhpPnaKJmsowUew3FvS/4rE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk0koEdDysbGLYmNHm1qQYu9L8bGNT7B3TuuuB4J120/CIIcMa
	IHoep7QqmL+mtwwxgQDXMsGFVkjUe+pyqwA/f6OP3ayavGfKlOf9gqu3eKHpwB70JlhQeXyAEzr
	v8C0O3OpjowUztZmyNAX5cVwGyyU=
X-Google-Smtp-Source: AGHT+IEwFMFBr+iB4p24SxLNYDDx9k2+p4Ugv/iXpHNmlITDGQD35niXPFjoyq6b6OZ+jyJiLBzBOtQjvO8fTG5dhZE=
X-Received: by 2002:a05:6870:d203:b0:261:2072:7b5d with SMTP id
 586e51a60fabf-29051d77f8cmr26903985fac.29.1730726782995; Mon, 04 Nov 2024
 05:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913132944.1880703-1-beata.michalska@arm.com>
 <20240913132944.1880703-2-beata.michalska@arm.com> <20241029070429.m7q5dkumitoyqxq2@vireshk-i7>
 <CAJZ5v0i2KUPXfeAKhkimetOMpx+5opgt26URJF8cstnZsaeZwA@mail.gmail.com> <Zyh_PG1lAEC4Q3Hr@arm.com>
In-Reply-To: <Zyh_PG1lAEC4Q3Hr@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 4 Nov 2024 14:26:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gCRKzaFrwkoBpLHQUxoP_+jAyhMiCkLQaBUpduk9yxtA@mail.gmail.com>
Message-ID: <CAJZ5v0gCRKzaFrwkoBpLHQUxoP_+jAyhMiCkLQaBUpduk9yxtA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq
 sysfs entry
To: Beata Michalska <beata.michalska@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, ionela.voinescu@arm.com, sudeep.holla@arm.com, 
	will@kernel.org, catalin.marinas@arm.com, sumitg@nvidia.com, 
	yang@os.amperecomputing.com, vanshikonda@os.amperecomputing.com, 
	lihuisong@huawei.com, zhanjie9@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 9:01=E2=80=AFAM Beata Michalska <beata.michalska@arm=
.com> wrote:
>
> On Tue, Oct 29, 2024 at 12:31:11PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Oct 29, 2024 at 8:04=E2=80=AFAM Viresh Kumar <viresh.kumar@lina=
ro.org> wrote:
> > >
> > > Apologies for the delay from my side. September was mostly holidays
> > > for me and then I was stuck with other stuff plus email backlog and
> > > this series was always a painful point to return to :(
> > >
> > > On 13-09-24, 14:29, Beata Michalska wrote:
> > > > Currently the CPUFreq core exposes two sysfs attributes that can be=
 used
> > > > to query current frequency of a given CPU(s): namely cpuinfo_cur_fr=
eq
> > > > and scaling_cur_freq. Both provide slightly different view on the
> > > > subject and they do come with their own drawbacks.
> > > >
> > > > cpuinfo_cur_freq provides higher precision though at a cost of bein=
g
> > > > rather expensive. Moreover, the information retrieved via this attr=
ibute
> > > > is somewhat short lived as frequency can change at any point of tim=
e
> > > > making it difficult to reason from.
> > > >
> > > > scaling_cur_freq, on the other hand, tends to be less accurate but =
then
> > > > the actual level of precision (and source of information) varies be=
tween
> > > > architectures making it a bit ambiguous.
> > > >
> > > > The new attribute, cpuinfo_avg_freq, is intended to provide more st=
able,
> > > > distinct interface, exposing an average frequency of a given CPU(s)=
, as
> > > > reported by the hardware, over a time frame spanning no more than a=
 few
> > > > milliseconds. As it requires appropriate hardware support, this
> > > > interface is optional.
> > >
> > > From what I recall, the plan is to:
> > > - keep cpuinfo_cur_freq as it is, not expose for x86 and call ->get()
> > >   for ARM.
> >
> > Yes.
> That one indeed remains unchanged.
> >
> > > - introduce cpuinfo_avg_freq() and make it return frequency from hw
> > >   counters for both ARM and Intel and others who provide the API.
> >
> > Yes.
> Will add changes for Intel as well.
> >
> > > - update scaling_cur_freq() to only return the requested frequency or
> > >   error in case of X86
> >
> > Yes.
> >
> > Preferably, -ENOTSUPP for "setpolicy" drivers without the .get() callba=
ck.
> Right, my impression was that we want to leave that one as is.

For now, yes please.

> Will add appropriate changes.

In the future.

> > >   and update documentation to reflect the same.
> > >   Right now or after some time ? How much time ?
> >
> > After some time, I think at least two cycles, so people have the time
> > to switch over, but much more may be necessary if someone is stuck
> > with RHEL or similar user space.
> >
> > Anyway, x86 will be the only one affected and there may be a Kconfig
> > option even to allow it to be changed at the kernel build time.
> >
> So just for my clarification we want a config switch to control what
> scaling_cur_freq is to actually provide.

Something like:

    if (IS_ENABLED(CONFIG_CPUFREQ_CUR_FREQ_FROM_ARCH))) {
        freq =3D arch_freq_get_on_cpu(policy->cpu);
        if (freq)
            return sysfs_emit(buf, "%u\n", freq);
    }

    if (cpufreq_driver->setpolicy) {
        if (cpufreq_driver->get))
            return sysfs_emit(buf, "%u\n", cpufreq_driver->get(policy->cpu)=
);

        return -ENOTSUPP;
    }

    return sysfs_emit(buf, "%u\n", policy->cur);

And select CONFIG_CPUFREQ_CUR_FREQ_FROM_ARCH on x86 for now.

> It will keep the current behaviour as
> default until we are ready to flip it and ultimately drop that temporary =
config
> option ?

Yes.

> > The documentation for cpuinfo_avg_freq() needs to be added along with i=
t.
> That one is already provided unless you have smth else on mind ?
> Like updating scaling_cur_freq to reference the new sysfs attribute ?

I haven't checked super-thoroughly, but generally all documentation
needs to be consistent.

