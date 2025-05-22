Return-Path: <linux-pm+bounces-27511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D52D4AC0AE5
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 13:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CC64E12D8
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD93C28A3FC;
	Thu, 22 May 2025 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIa/Wk9C"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745CF28A1DC;
	Thu, 22 May 2025 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747914888; cv=none; b=faaey8VwI52yuRl4vSTHy/AKmZk/HZNhwH1VwiVED95mi9qyffbOORFxDxDR89MyfK5gn8XsOw2LUJGxCnjXliF1zeTisX9vUWmxpOlyz8v5TXNSilmERYo96qwVsBGHuE1XcLAXQkuRNmvLP+mK0yFBg3ZfntpvXSUlf7FnvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747914888; c=relaxed/simple;
	bh=Nryi9QMkPLKZdjBmO37cvNvIiUIaiZZgJ1/+v4pk0d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VikqW7HMGNG1+jChKdOwvo+tpwsWWrIE2ozNA06N5F8Le21dtG8BWjKWs02EpTKIAOPyF65riF2KzXaboM7JkprPXIUxkvbgORQ18Tz70k1sHMsrqVGBJG1/+Fd5fO2c7lOXcWt16CmJWvFOhQcje/H4Gy+ECrUMHWXkRJdtnGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIa/Wk9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D776FC4CEE4;
	Thu, 22 May 2025 11:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747914887;
	bh=Nryi9QMkPLKZdjBmO37cvNvIiUIaiZZgJ1/+v4pk0d8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PIa/Wk9CjnaF3EyPtT2yfVbpH2Z65JH/9xkgqm3jEDkoVpf2g9r/U3uxEG1CRexGf
	 tqRaswH6pXE7VkAw1TQvDMT/r8tykf2aoDwDZ5elmKuH7thq2BUG+U+HMguiaAc99S
	 rmKpu4r0e6PPKhLX04ttwL03pzdht8uE+/egbj6ny9xxgoZPKWqBl0kysTaZsTTD5C
	 7tndUIt/j0Pri+Eq3WEvFj2YNJ/GahAPWb5wyE+35tw35laWkimPfsjjndZ1OLchoG
	 k8XL3DOWYhItT2unOcmqehajtBxcOfSre/HIhAxwKCFWJNSzZbFJDA2xbR7RN1dPNW
	 hzeg4uOK0z5Lw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-606440d92eeso3811771eaf.2;
        Thu, 22 May 2025 04:54:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgjJArXxEkv5oiYqAMjXijZQEAM3rTavDv5ZkZY+MZmzzuPptVsmJDf6meTIfySLg8tRybz5sVWUJk4c1O@vger.kernel.org, AJvYcCW+RCRQF9BJKGgdRIz5LgUT4wA9eEvYdv4aWEjgeZrGvZds0T/41QS9+fd5uB3+pGXp/pSHYemNFlU=@vger.kernel.org, AJvYcCWGZgvjepXr1X5JuDLl3mB4+NmzYHM0DgCwhVOx2IEbsvT7XsOf5MohTlTwwU1lv0WklIxmWwzIeR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywVPATnezHyGbFaVFsslU9sON+biia7x/mFSmFlfZzTyAtNsXW
	b1Vn7vvBTOuBA3aSDK2c6fxPkLcyabX7QL+2D3yAAb7oqq1r8l67iEy/T2x8ofwn4Lz33Iz2+ob
	pubK2T/dwPM9yxwVKUYf6najWHOareLk=
X-Google-Smtp-Source: AGHT+IG+KzzlVR5WjMP68KLNL7UutmcZ1GBLYAe3Zls3GG+S92wBlVefQFR7vROwlcJ9qGU+spgYeWgkBLpmk6P7mOw=
X-Received: by 2002:a05:6820:2705:b0:606:26bd:7208 with SMTP id
 006d021491bc7-609f37bc37dmr15131315eaf.7.1747914887086; Thu, 22 May 2025
 04:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522-userspace-governor-doc-v1-1-c8a038e39084@sony.com>
 <15871c67-0d18-430f-935e-261b2cda855b@gmail.com> <CAJZ5v0gz3Y+RGqBf9E1hzq9rwfrryd98Xpk51DtLd-uck5y-rw@mail.gmail.com>
 <b62c0462-8185-4eb8-8ac6-7f2abc387768@gmail.com>
In-Reply-To: <b62c0462-8185-4eb8-8ac6-7f2abc387768@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 May 2025 13:54:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jrwDJ-TQuay_OkwfsWr2z9COg=oDY7q0FqRBC-3_br2Q@mail.gmail.com>
X-Gm-Features: AX0GCFvq_DNusbqq8SXDC-zaNsRp6E6EsPke3RrXzEnZGLbMYlcVyN8Q9_5afVs
Message-ID: <CAJZ5v0jrwDJ-TQuay_OkwfsWr2z9COg=oDY7q0FqRBC-3_br2Q@mail.gmail.com>
Subject: Re: [PATCH] cpufreq, docs: (userspace governor) add that actual freq
 is >= scaling_setspeed
To: Russell Haley <yumpusamongus@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Shashank Balaji <shashank.mahadasyam@sony.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shinya Takumi <shinya.takumi@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 1:15=E2=80=AFPM Russell Haley <yumpusamongus@gmail.=
com> wrote:
>
>
>
> On 5/22/25 4:47 AM, Rafael J. Wysocki wrote:
> > On Thu, May 22, 2025 at 10:51=E2=80=AFAM Russell Haley <yumpusamongus@g=
mail.com> wrote:
> >>
> >>
> >> On 5/22/25 3:05 AM, Shashank Balaji wrote:
> >>> The userspace governor does not have the CPUFREQ_GOV_STRICT_TARGET fl=
ag, which
> >>> means the requested frequency may not strictly be followed. This is t=
rue in the
> >>> case of the intel_pstate driver with HWP enabled. When programming th=
e
> >>> HWP_REQUEST MSR, the min_perf is set to `scaling_setspeed`, and the m=
ax_perf
> >>> is set to the policy's max. So, the hardware is free to increase the =
frequency
> >>> beyond the requested frequency.
> >>>
> >>> This behaviour can be slightly surprising, given the current wording =
"allows
> >>> userspace to set the CPU frequency". Hence, document this.
> >>>
> >>
> >> In my opinion, the documentation is correct, and it is the
> >> implementation in intel_pstate that is wrong. If the user wanted two
> >> separate knobs that control the minimum and maximum frequencies, they
> >> could leave intel_pstate in "active" mode and change scaling_min_freq
> >> and scaling_max_freq.
> >>
> >> If the user asks for the frequency to be set from userspace, the
> >> frequency had damn well better be set from userspace.
> >
> > The userspace governor requests a frequency between policy->min and
> > policy->max on behalf of user space.  In intel_pstate this translates
> > to setting DESIRED_PERF to the requested value which is also the case
> > for the other governors.
>
> Huh.  On this Skylake box with kernel 6.14.6, it seems to be setting
> Minimum_Performance, and leaving desired at 0.
>
> > echo userspace | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_=
governor
> userspace
> > echo 1400000 | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_se=
tspeed
> 1400000
> > sudo x86_energy_perf_policy &| grep REQ
> cpu0: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg =
0
> cpu1: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg =
0
> cpu2: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg =
0
> cpu3: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg =
0
> cpu4: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg =
0
> cpu5: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg =
0
> cpu6: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg =
0
> cpu7: HWP_REQ: min 14 max 40 des 0 epp 128 window 0x0 (0*10^0us) use_pkg =
0

OK, let me double check the code.

