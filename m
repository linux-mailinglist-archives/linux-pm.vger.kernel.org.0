Return-Path: <linux-pm+bounces-27610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF93AC2A05
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 20:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E5CA2495B
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D455429AAF0;
	Fri, 23 May 2025 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2rPxkwA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4138298C00;
	Fri, 23 May 2025 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026679; cv=none; b=Cs3JMbHTYwAyJURbJTuCTw8V/xtQU7CqDZNYf0nx0pfZS1xdl/yfEGjGeSBF1RszJFu7/5TjdxS03po153US/HKFptiNTdEEHwPNKVBznMNTlSOf+Z/FZgj5P8mYQfCHHv12boDd6MV22ByEbvyOtUXZBvEQbwqmkhXbhwzVCZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026679; c=relaxed/simple;
	bh=cqvuXw8JxQP2yg9gluUQbHRnjg9G6e/x6ASyX8Gfs1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTbrSkSIcOdCcuS+5vd7PGZgyE+sxg17bPnWDtLCIqzyo1OcW9/yzgE9gj9dSY0biOti0h6lZzQzOzE0jpHcsJGxvHwRJTOf5OTsvHm3ohPpkWrhWBK4pD/2O8HPR+KE1UXdYkMIO7o6DGgvQCucuue0Fdtg1CWyfDL/GcQ68Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2rPxkwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE77C4CEF0;
	Fri, 23 May 2025 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748026679;
	bh=cqvuXw8JxQP2yg9gluUQbHRnjg9G6e/x6ASyX8Gfs1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b2rPxkwAH2/lLJrIrqAWjtilm/iXN88KmU3qqT5Rll3+jJ3FITeO/KDpkwxS8ClmZ
	 GwjTg6ru+RbuCIhG2uzgsoWO2Z9KK6n6X81nioSBhRLUQp73VZif3JisHTpU/kEk61
	 /xRZEcefAq0QeatKS8bJOR+AMDRJZailLa1GcxkukzAtylOC6HenNUp+l7KKuMCcQm
	 Zr2V5RBpzX8yt7TWPLgBC2BPHXBElVt27dZUEHkPlb18WT4PL2vAasKebxbWjmcgvC
	 4PHQqNXshk+RJl/yTnmFwi9YewJTZSmXGxQREbdBC7LfE69usR7av2fMSuLSNMo8We
	 dXUgbix8gqQ9A==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2e3dea42465so175206fac.0;
        Fri, 23 May 2025 11:57:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJj0atvYJkxbPrZCiAZGG29Tj6EDFPXC58T26lajdVwFnX/4voPvITT0rJZlFbl4aljFowZWf3cnU=@vger.kernel.org, AJvYcCWjmmo530kTfl7UeIe3/OGtayNxWtkb/IDPDG2v/KQ/apatBNKXYHqJq06SlhisNsfFK278lKQJ4PdSWdH4@vger.kernel.org, AJvYcCWwhHfQ6PWsY3L05y/iDx6hzGcy59ay+g8b920O+86ThW0GbhbWIGulJVe2S0m25NLITc2sRkWl/rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsVcJbMCM8R1ih9i93w8DhgljKIh1T54HNA/K16n/qOBi9NS4F
	kudgrtaIdrYhZF0sy90Y3e83iyoLJAnZRs39bNMl9TEAumJ85B1H1YGXnvEfYJirS4KS2Fj40zC
	YJmPw9eX7zdzobiB0hLGkDmeAl0UmqCc=
X-Google-Smtp-Source: AGHT+IGAKC9cTRLYyIRGCJjK5YQhhthRN+7EesmVWQybzqqwbFt9swBhieXOoFYYQLDMfpntR97g4JTzG2xigQ7c70c=
X-Received: by 2002:a05:6871:d68c:b0:2d6:8eb:8918 with SMTP id
 586e51a60fabf-2e83e2a76admr2849461fac.7.1748026678340; Fri, 23 May 2025
 11:57:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
 <15871c67-0d18-430f-935e-261b2cda855b@gmail.com> <CAJZ5v0gz3Y+RGqBf9E1hzq9rwfrryd98Xpk51DtLd-uck5y-rw@mail.gmail.com>
 <b62c0462-8185-4eb8-8ac6-7f2abc387768@gmail.com> <CAJZ5v0jrwDJ-TQuay_OkwfsWr2z9COg=oDY7q0FqRBC-3_br2Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jrwDJ-TQuay_OkwfsWr2z9COg=oDY7q0FqRBC-3_br2Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 20:57:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i_u7ds4sO-UdQ4gfX-8-z1-3NOOWAd3DS0b7E3uma0dA@mail.gmail.com>
X-Gm-Features: AX0GCFsmu84jWApvusyzlX9DbY-yDpT3dGz3j-GMy0KXKoQujzk_4lQKDXmHuGw
Message-ID: <CAJZ5v0i_u7ds4sO-UdQ4gfX-8-z1-3NOOWAd3DS0b7E3uma0dA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
To: Russell Haley <yumpusamongus@gmail.com>
Cc: Shashank Balaji <shashank.mahadasyam@sony.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shinya Takumi <shinya.takumi@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 1:54=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, May 22, 2025 at 1:15=E2=80=AFPM Russell Haley <yumpusamongus@gmai=
l.com> wrote:
> >
> >
> >
> > On 5/22/25 4:47 AM, Rafael J. Wysocki wrote:
> > > On Thu, May 22, 2025 at 10:51=E2=80=AFAM Russell Haley <yumpusamongus=
@gmail.com> wrote:
> > >>
> > >>
> > >> On 5/22/25 3:05 AM, Shashank Balaji wrote:
> > >>> The userspace governor does not have the CPUFREQ_GOV_STRICT_TARGET =
flag, which
> > >>> means the requested frequency may not strictly be followed. This is=
 true in the
> > >>> case of the intel_pstate driver with HWP enabled. When programming =
the
> > >>> HWP_REQUEST MSR, the min_perf is set to `scaling_setspeed`, and the=
 max_perf
> > >>> is set to the policy's max. So, the hardware is free to increase th=
e frequency
> > >>> beyond the requested frequency.
> > >>>
> > >>> This behaviour can be slightly surprising, given the current wordin=
g "allows
> > >>> userspace to set the CPU frequency". Hence, document this.
> > >>>
> > >>
> > >> In my opinion, the documentation is correct, and it is the
> > >> implementation in intel_pstate that is wrong. If the user wanted two
> > >> separate knobs that control the minimum and maximum frequencies, the=
y
> > >> could leave intel_pstate in "active" mode and change scaling_min_fre=
q
> > >> and scaling_max_freq.
> > >>
> > >> If the user asks for the frequency to be set from userspace, the
> > >> frequency had damn well better be set from userspace.
> > >
> > > The userspace governor requests a frequency between policy->min and
> > > policy->max on behalf of user space.  In intel_pstate this translates
> > > to setting DESIRED_PERF to the requested value which is also the case
> > > for the other governors.
> >
> > Huh.  On this Skylake box with kernel 6.14.6, it seems to be setting
> > Minimum_Performance, and leaving desired at 0.
> >
> > > echo userspace | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scalin=
g_governor
> > userspace
> > > echo 1400000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_=
setspeed
> > 1400000
> > > sudo x86_energy_perf_policy &| grep REQ
> > cpu0: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pk=
g 0
> > cpu1: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pk=
g 0
> > cpu2: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pk=
g 0
> > cpu3: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pk=
g 0
> > cpu4: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pk=
g 0
> > cpu5: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pk=
g 0
> > cpu6: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pk=
g 0
> > cpu7: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pk=
g 0
>
> OK, let me double check the code.

I stand corrected, HWP_MIN_PERF is indeed set in accordance with the
target frequency, not HWP_DESIRED_PERF.

The reason why is because running at a frequency below the target
might cause insufficient performance to be delivered which would break
the assumptions of the schedutil governor.

However, setting HWP_DESIRED_PERF to 0 may be a mistake because it may
cause the CPU to always run above the target frequency which is not
desirable from the power perspective.

What can be done is to set HWP_MIN_PERF and HWP_DESIRED_PERF to the same va=
lue.

[Note that intel_cpufreq_adjust_perf() used by the schedutil governor
actually sets HWP_DESIRED_PERF in accordance with the target
frequency, but it also sets HWP_MIN_PERF to the minimum sufficient
perf value supplied by schedutil.  Since intel_cpufreq_fast_switch()
and intel_cpufreq_target() only get one target frequency, they cannot
really say if any frequency below the target will be sufficient.]

