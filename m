Return-Path: <linux-pm+bounces-27682-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64571AC4E0E
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 14:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588111BA095B
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 12:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CEB202983;
	Tue, 27 May 2025 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSI+l+Gz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910827260E;
	Tue, 27 May 2025 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748347213; cv=none; b=ICrKCnezZ8kjWDmIrzORE3qqxuf2n/iE5+CJLi1oG2oYplCrSf/K1hVqUM8ppRbKAb/ZCTdiQ61b5IlLVmdRacJku0dF95nI2h4G1chvDJGI5a3T2UAjAEJQSFUcxJp6cHRCX/3TgoMROgD/pBORgAzNFHo5PV6KVHiCp+6sfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748347213; c=relaxed/simple;
	bh=qLapHneOi+oKFJ5y90jzyILYX7eOBr5+CBwaFdeeheA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EH3cUiwfJ1VJTCagAGY5tULGGK16YKROLZub69BnRwyfdSV5H37KNyZFiVV2zedvYw09DbSX0FsS6VCwiLp0pK1KRQfyaOIo9e6tE0fbIh6HbdOkr7LkZaygM3diVpyN/kZEZwNqagen+fnuoEh+oqKh+a5UW1k2BF+nAkDbHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSI+l+Gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08819C4CEEE;
	Tue, 27 May 2025 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748347213;
	bh=qLapHneOi+oKFJ5y90jzyILYX7eOBr5+CBwaFdeeheA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kSI+l+GzqCel77prqLwS7xz2muMHOSoXwb9KNu8Wi5eT+xMmcs3VsmvVuiAYgT9aO
	 8Yt+IU5DdO3uGV6KTeKCA1Y5BehvCavUfEdn1X1+eXIii2h88KgOjV/3ep8hqNT/is
	 emXWe5UbgFGLO98FK5JeWSYsGXzp5v7qWJGWlGlXGCuc+hnhQOXH0O8ZaqnQtFFY7T
	 MC03kD61+/i7r9Yd9URlGLON6NPjYHpQcTHstWaY0aPFjfbfzherwUrKdBRdup1jEq
	 mISnjmxyyPmN89tD2edgBRqQhp/NYYDyOUZ/idCBJEeSydNnmBdR4+m6fUKLajGupu
	 imnXQBLNPjngA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-60638c07cabso1411905eaf.3;
        Tue, 27 May 2025 05:00:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5yDUabpcZzpK0qchngo/zFo5y/bQZ4082f1ntjMGv/GCx0yI10t5mWyyCXddcmFRIbNK52XQpQBk=@vger.kernel.org, AJvYcCVtMLbR45Orkd3mT//9ydhqG+1fK1X4W+r3Tk5+duhM537eD9xLnrmHTz/lfQqp57fhHXCIeujP/RSXTDZP@vger.kernel.org, AJvYcCXFXlgYCygK30Jc7MJgmqJjn25qOcKuWyRkpU57SkDEPm0HsdGhEInz1QZMeKptvspluQzbhNXTsww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIa6SNMAFgB5Bvc6je1kzqFg4EctE6n38Jw+suAjCnY/CuqcH3
	VMYHn6ijzcf/YYaVs8Zs5rSYbHw8bbiJa29RWYm/DIbiVzbJIOPJHE9rFD8zZv1U1kR0ZthhXDU
	kDBPdUgnbygfCYld8pB2b1LC9GP5XcOY=
X-Google-Smtp-Source: AGHT+IH1H/K9aIlXXOO/y7HLOTl7zAEeo6HfQFr7ujuFdt4n8dLkaY+8mKMTorG3P80nKepGALTJbXBe04FTHAZXQ4I=
X-Received: by 2002:a05:6820:818d:b0:609:f2f3:5f60 with SMTP id
 006d021491bc7-60b9f8a9766mr6494225eaf.0.1748347212322; Tue, 27 May 2025
 05:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
 <15871c67-0d18-430f-935e-261b2cda855b@gmail.com> <CAJZ5v0gz3Y+RGqBf9E1hzq9rwfrryd98Xpk51DtLd-uck5y-rw@mail.gmail.com>
 <b62c0462-8185-4eb8-8ac6-7f2abc387768@gmail.com> <aC_4yLsFVVszI_FA@JPC00244420>
 <CAJZ5v0g1o03La9aWJF1rheC9CM8SU2iC52auEAnaBpUCMunpJA@mail.gmail.com> <aDV2HPfybqnbzJ9N@JPC00244420>
In-Reply-To: <aDV2HPfybqnbzJ9N@JPC00244420>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 May 2025 14:00:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h9d6XESiiZV+A2GNUcefSunV-D=3d-TU412mwW0vjYGA@mail.gmail.com>
X-Gm-Features: AX0GCFsknwzCCPo2oM2FuYiPgANRZkiiVNyCLYZm3KZKQoxjkqI9Z52D-sR3j0k
Message-ID: <CAJZ5v0h9d6XESiiZV+A2GNUcefSunV-D=3d-TU412mwW0vjYGA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Russell Haley <yumpusamongus@gmail.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shinya Takumi <shinya.takumi@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 27, 2025 at 10:22=E2=80=AFAM Shashank Balaji
<shashank.mahadasyam@sony.com> wrote:
>
> Hi Rafael,
>
> On Fri, May 23, 2025 at 09:06:04PM +0200, Rafael J. Wysocki wrote:
> > On Fri, May 23, 2025 at 6:25=E2=80=AFAM Shashank Balaji
> > <shashank.mahadasyam@sony.com> wrote:
> > > ...
> > > Consider the following on a Raptor Lake machine:
> > > ...
> > >
> > > 3. Same as above, except with strictuserspace governor, which is a
> > > custom kernel module which is exactly the same as the userspace
> > > governor, except it has the CPUFREQ_GOV_STRICT_TARGET flag set:
> > >
> > >         # echo strictuserspace > cpufreq/policy0/scaling_governor
> > >         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
> > >         cpu0: HWP_REQ: min 26 max 26 des 0 epp 128 window 0x0 (0*10^0=
us) use_pkg 0
> > >         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*=
10^0us)
> > >         # echo 3000000 > cpufreq/policy0/scaling_setspeed
> > >         # x86_energy_perf_policy -c 0 2>&1 | grep REQ
> > >         cpu0: HWP_REQ: min 39 max 39 des 0 epp 128 window 0x0 (0*10^0=
us) use_pkg 0
> > >         pkg0: HWP_REQ_PKG: min 1 max 255 des 0 epp 128 window 0x0 (0*=
10^0us)
> > >
> > >         With the strict flag set, intel_pstate honours this by settin=
g
> > >         the min and max freq same.
> > >
> > > desired_perf is always 0 in the above cases. The strict flag check is=
 done in
> > > intel_cpufreq_update_pstate, which sets max_pstate to target_pstate i=
f policy
> > > has strict target, and cpu->max_perf_ratio otherwise.
> > >
> > > As Russell and Rafael have noted, CPU frequency is subject to hardwar=
e
> > > coordination and optimizations. While I get that, shouldn't software =
try
> > > its best with whatever interface it has available? If a user sets the
> > > userspace governor, that's because they want to have manual control o=
ver
> > > CPU frequency, for whatever reason. The kernel should honor this by
> > > setting the min and max freq in HWP_REQUEST equal. The current behavi=
our
> > > explicitly lets the hardware choose higher frequencies.
> >
> > Well, the userspace governor ends up calling the same function,
> > intel_cpufreq_target(), as other cpufreq governors except for
> > schedutil.  This function needs to work for all of them and for some
> > of them setting HWP_MIN_PERF to the same value as HWP_MAX_PERF would
> > be too strict.  HWP_DESIRED_PERF can be set to the same value as
> > HWP_MIN_PERF, though (please see the attached patch).
> >
> > > Since Russell pointed out that the "actual freq >=3D target freq" can=
 be
> > > achieved by leaving intel_pstate active and setting scaling_{min,max}=
_freq
> > > instead (for some reason this slipped my mind), I now think the stric=
t target
> > > flag should be added to the userspace governor, leaving the documenta=
tion as
> > > is. Maybe a warning like "you may want to set this exact frequency, b=
ut it's
> > > subject to hardware coordination, so beware" can be added.
> >
> > If you expect the userspace governor to set the frequency exactly
> > (module HW coordination), that's the only way to make it do so without
> > potentially affecting the other governors.
>
> I don't mean to say that intel_cpufreq_target() should be modified. I'm
> suggesting that the CPUFREQ_GOV_STRICT_TARGET flag be added to the
> userspace governor. That'll ensure that HWP_MIN_PERF and
> HWP_MAX_PERF are set to the target frequency. intel_cpufreq_target()
> already correctly deals with the strict target flag. To test this, I
> registered a custom governor, same as the userspace governor, except
> with the strict target flag set. Please see case 3 above.
>
> If this flag is added to the userspace governor, then whatever the
> documentation says right now will actually be true. No need to modify
> the documentation then.

So please submit a patch to set CPUFREQ_GOV_STRICT_TARGET in the
userspace governor.

Thanks!

