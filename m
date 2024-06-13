Return-Path: <linux-pm+bounces-9072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209DE9068A1
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 11:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F32E281648
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886DB13E036;
	Thu, 13 Jun 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8X2+ZrQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611EA13A3E3;
	Thu, 13 Jun 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270885; cv=none; b=AQqxFp6IrEI95aqZ+8dbZ9DffWfC4y2bMcSQp4nunXjFRwuHBm73Or9Dabv9ENw5E2+yOrVT+ZxCz9zNXJ6zkqrYiW+DPzXiwS9aHitTeaEIktQSriPDq6cRyxgpEs1Q+OvLMT86ksGKrN1zc4iGHwq/OOBYYy7TyvUm9ez233w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270885; c=relaxed/simple;
	bh=acgcbcDGq6xB3czgsyNKkLJFVT82kOwOZNtYOx6Racc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/19tI1m9YJBefwFQzJtnAJi7mrG2MSC+z0Hjp54y0+3QTQt5KvrGLFzDoxpShia7p1U6c9t9GRDba6PJT0Pqolc1qYbRd7QPgNLAo010iYO2nuS6xYQrc3JO+0QVVv1GfrWfCYkgClhiMVbi9x8eQ/T+awynHxN3Y53hdI4jyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8X2+ZrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE0AC4AF1D;
	Thu, 13 Jun 2024 09:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718270884;
	bh=acgcbcDGq6xB3czgsyNKkLJFVT82kOwOZNtYOx6Racc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P8X2+ZrQtjW2y1raSKUDlUG/eFFJlxwyuSvjBw2mFnGHKaTv+GleO7LcctrJisAfD
	 wjDqebYEfzhDiU9euaw2/sEDJQdKOh7hwaD/sExqKT01AHskmJkN0TqzxdSaeDXiTu
	 EigpwJG6wbdPufMaYKVg9M8HybwV15Are/nBeOno0Wj3SWBIWC3cQbfsk+U+TI2Qba
	 OFAOSY17ieE57Ex//f5hu2vOtiiu84wH/S0VI7oc6y9QjI4PS6aMG85VqSPiKOj5aT
	 G5FjKkRfjqa1H7LCRNsAhfh2/BwyK/1sum+qig2yzEm/TIeP3eQ/f548hZNnKZq4Eh
	 qByoO9CxohvJQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5bb10cfe7daso44483eaf.2;
        Thu, 13 Jun 2024 02:28:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6ah5z1QGOAoFqRlIuZBJSrC5IM+GGCeXmQznVv5iwflsEWIAt4I+ci+90XJV8i/80Y/0f8HJCPQebdIs35opeEUuOzQglwLBI2hj9Qkm5T+PchEydNQP3MAO91rXZ6z7of+f4Tz8=
X-Gm-Message-State: AOJu0YyEWZxmi2gAK/EhwumcHq4B7f2ER8JrUMMHtekxcVM5gMV0TRyO
	CnyJmYK6146D9dtiSfIl3yxw6jejGHwbxjFZVoEIoPBR4kSg7YqYSomINpR+U3iaq16euiZ1kDP
	8kzC8SR02UTrlDpZX5AqFWAcndSI=
X-Google-Smtp-Source: AGHT+IHONW/pZ2bf8O0TmFRXC4pvRWsKVXD/WylNA6AkeYAO/uUZqSD0JPYjCotHD1d3Pg0YtQqJc2Ha1g7kPFMUisk=
X-Received: by 2002:a05:6870:524d:b0:254:7e18:7e1a with SMTP id
 586e51a60fabf-25514f70c6cmr4598291fac.5.1718270883998; Thu, 13 Jun 2024
 02:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603081331.3829278-1-beata.michalska@arm.com>
 <20240603081331.3829278-2-beata.michalska@arm.com> <20240603114811.oio3uemniib5uaa2@vireshk-i7>
 <CAJZ5v0j1bqhmKrJirw+WgEVDdszZ9xQSgmfazVKMVa8H6_5TSw@mail.gmail.com>
 <20240606085513.pptx5dtjcvvg3zo4@vireshk-i7> <CAJZ5v0it5vZvzkbErkGOVruPbkxgr8VMTgQzsncpdQmvCOfBng@mail.gmail.com>
 <20240613082358.yq2lui6vc35xi53t@vireshk-i7>
In-Reply-To: <20240613082358.yq2lui6vc35xi53t@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Jun 2024 11:27:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iOvpx=YtPtbM9RPaVh2n4+T=r91bM7OZt5k8q0Tzmk+w@mail.gmail.com>
Message-ID: <CAJZ5v0iOvpx=YtPtbM9RPaVh2n4+T=r91bM7OZt5k8q0Tzmk+w@mail.gmail.com>
Subject: Re: [PATCH 1/1] cpufreq: Rewire arch specific feedback for cpuinfo/scaling_cur_freq
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: ionela.voinescu@arm.com, Beata Michalska <beata.michalska@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	len.brown@intel.com, vanshikonda@os.amperecomputing.com, sumitg@nvidia.com, 
	vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:24=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 07-06-24, 16:21, Rafael J. Wysocki wrote:
> > On Thu, Jun 6, 2024 at 10:55=E2=80=AFAM Viresh Kumar <viresh.kumar@lina=
ro.org> wrote:
> > > What about this, hopefully this doesn't break any existing platforms
> > > and fix the problems for ARM (and others):
> > >
> > > - scaling_cur_freq:
> > >
> > >   Returns the frequency of the last P-state requested by the scaling
> > >   driver from the hardware.
> >
> > This would change the behavior for intel_pstate in the passive mode AFA=
ICS.
> >
> > ATM it calls arch_freq_get_on_cpu(), after the change it would return
> > policy->cur which would not be the same value most of the time.  And
> > in the ->adjust_perf() case policy->cur is not updated by it even.
>
> Yeah, we would need to do the below part to make it work.
>
> > >  For set_policy() drivers, use the ->get()
> > >   callback to get a value that can provide the best estimate to user.
> > >
> > >   To make this work, we can add get() callback to intel and amd pstat=
e
> > >   drivers, and use arch_freq_get_on_cpu().
> > >
> > >   This will keep the current behavior intact for such drivers.
> >
> > Well, the passive mode thing would need to be addressed then.
>
> Right. So this would keep the behavior of the file as is for all platform=
s and
> simplify the core.
>
> > > - cpuinfo_cur_freq:
> > >
> > >   Currently this file is available only if the get() callback is
> > >   available. Maybe we can keep this behavior as is, and expose this
> > >   now for both the pstate drivers (once above change is added). We
> > >   will be left with only one driver that doesn't provide the get()
> > >   callback: pasemi-cpufreq.c
> >
> > I would rather get rid of it completely.
>
> cpuinfo_cur_freq itself ? I thought such changes aren't allowed as they m=
ay end
> up breaking userspace tools.

cpuinfo_cur_freq is not always present anyway, so user space tools
need to be able to cope with the lack of it anyway.

> > >   Coming back to the implementation of the file read operation, I
> > >   think the whole purpose of arch_freq_get_on_cpu() was to get a
> > >   better estimate (which may not be perfect) of the frequency the
> > >   hardware is really running at (in the last window) and if a platfor=
m
> > >   provides this, then it can be given priority over the ->get()
> > >   callback in order to show the value to userspace.
> >
> > There was a reason to add it and it was related to policy->cur being
> > meaningless on x86 in general (even in the acpi-cpufreq case), but
> > let's not go there.
>
> Right.
>
> > Hooking this up to cpuinfo_cur_freq on x86 wouldn't make much sense
> > IMV because at times it is not even close to the frequency the
> > hardware is running at.  It comes from the previous tick period,
> > basically, and the hardware can adjust the frequency with a resolution
> > that is orders of magnitude higher than the tick rate.
>
> Hmm. If that is the concern (which looks valid), how come it makes sense =
to do
> the same on ARM ? Beata, Ionela ?
>
> I thought, just like X86, ARM also doesn't have a guaranteed way to know =
the
> exact frequency anymore and AMUs are providing a better picture, and so w=
e are
> moving to the same.
>
> If we don't want it for X86, then it can be done with help of a new drive=
r flag
> CPUFREQ_NO_CPUINFO_SCALING_FREQ, instead of the availability of the get()
> callback.
>
> > Well, this sounds nice, but the changes are a bit problematic.
> >
> > If you don't want 3 files, I'd drop cpuinfo_cur_freq and introduce
> > something else to replace it which will expose the
> > arch_freq_get_on_cpu() return value and will be documented
> > accordingly.
>
> Well it is still meaningful to show the return value of the ->get() callb=
ack
> where the hardware provides it.

But this is a valid point.

> > Then scaling_cur_freq can be (over time) switched over to returning
> > policy->cur in the cases when it is meaningful and -ENODATA otherwise.
> >
> > This would at least allow us to stop making up stuff.
>
> Maybe a third file, just for arch_freq_get_on_cpu() is not that bad of an=
 idea
> :)

/me thinks so.

