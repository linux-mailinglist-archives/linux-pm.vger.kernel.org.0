Return-Path: <linux-pm+bounces-27802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2464CAC7B53
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 11:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710E33AAF81
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 09:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA19927D771;
	Thu, 29 May 2025 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzEy89k2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB927CCE0
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511938; cv=none; b=Vv7rAxlrTXzi0Z7uR/2nolxxFF6NVxD+nYC18bhCxFK6hCDRKojQw1vZp4m5Ke+R/4+3wBScojtSXEwIAYxZiOBeNbhzRP0hCIRr8Qi0GL2K4/zZHIoul2214/Xnwf43mPMaTD6LzOJSmyoQ/bXiEz1EFWLo/YDTLaZSKUyh0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511938; c=relaxed/simple;
	bh=6rOawsiypQlt8ssdI4FIAnpRFneFPULI+9tJfk0rPMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OuMWMN9Rbj7KvIuTpZuSHti+693+Vn15EPwxVVAr03BdCBeCGR2K7lyB6O5b2TqUqnvENNW92VahgPzFQtX31ImpC7ovqetV13IN1coyhlauwstbKOhIh9uf2FMkaCNIVTkK3go6sirzCMxW0ReJmsfZ7gyLdhGHwISz/hD58fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzEy89k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC06C4CEEB
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 09:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748511938;
	bh=6rOawsiypQlt8ssdI4FIAnpRFneFPULI+9tJfk0rPMU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OzEy89k2r2abxjfYQxXQ8HmN6plOWcqmCMTqX+LnnS343njZartrwY1Ulu2lrF3Kz
	 z+sJPFeJrSHHdsWb2oBw1cL/VNhyotD2JEp/JuOodh4FhzV03gXcElFkYhmKtIqpz1
	 gg9qixBc8fs68i25YfcEwSYsczBVZ2HwSA48DV2Kjzn7p6yEmgXALHwdfx7KhRdia1
	 1uQjW6jyU1iOMO3Rhh9RHwQ33El8NYiaxsE3esjw8HMBzl5Xqq0fPY3UO5RFOFi+3S
	 LX1p7cpRGBCva8FXxNhZxs5jyUZ80mFuAmkWUZdlDGT+dDVrpx8JaDUlxtgK2B+/CN
	 oz+VxZp5qwh9w==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6060a70ba80so374110eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 02:45:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXiggU+meHJwmS28vEi2Vy2E0vylOMBtoZyvir6n+IUG8JtLtx8FJD6VAxGvjo2+4DYHpkV+e4sCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LA3AdwwRr4e0UYBEcVExlGT/m7t9SoY8/TMxJL4GnhfiKBMf
	0D8UJLCSHzZ6tnhxRgOytkHYeGrUnchtl7Urkxt3aYo81EuhD2XM0iMgn/kl7eI0xaOiUyLD7SP
	cjvMLGwWC4uR2S+WulTJYD4+Kxck2q/c=
X-Google-Smtp-Source: AGHT+IGDivsZUcPzHVW20wIK7NtHV65T8gnyWnixCKZwSWlBSN3Fodtk5FEJUKUsYhhpVnwmrryUkq1Pzj/uPwJ99Es=
X-Received: by 2002:a05:6820:1986:b0:60b:d330:88eb with SMTP id
 006d021491bc7-60bd3308942mr4348618eaf.8.1748511937545; Thu, 29 May 2025
 02:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8PR04MB864266B4BF3B629C96464DC98766A@AS8PR04MB8642.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB864266B4BF3B629C96464DC98766A@AS8PR04MB8642.eurprd04.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 May 2025 11:45:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hjenzF_8=vfbaE-HeVhyWA9Q608NAH0dcvA1t=RGHyeQ@mail.gmail.com>
X-Gm-Features: AX0GCFuYAknjudAsXi4UY6RnWJZyTBrton347kjknIoHdzLil5SpMJ6bgI1KmRM
Message-ID: <CAJZ5v0hjenzF_8=vfbaE-HeVhyWA9Q608NAH0dcvA1t=RGHyeQ@mail.gmail.com>
Subject: Re: cpufreq can't scaling frequency after cpu cooling event
To: Jacky Bai <ping.bai@nxp.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 29, 2025 at 9:43=E2=80=AFAM Jacky Bai <ping.bai@nxp.com> wrote:
>
> Hi Rafael,
>
> In the latest kernel, I saw below patch was added in cpufreq subsystem.
>
> commit 4f751f25ab892810968ced5c10fa193dd16c4c6d
> Author: Rafael J. Wysocki mailto:rafael.j.wysocki@intel.com
> Date:   Wed Apr 16 16:12:37 2025 +0200
>
>     cpufreq: Avoid using inconsistent policy->min and policy->max
>
>     Since cpufreq_driver_resolve_freq() can run in parallel with
>     cpufreq_set_policy() and there is no synchronization between them,
>     the former may access policy->min and policy->max while the latter
>     is updating them and it may see intermediate values of them due
>     to the way the update is carried out.  Also the compiler is free
>     to apply any optimizations it wants both to the stores in
>     cpufreq_set_policy() and to the loads in cpufreq_driver_resolve_freq(=
)
>     which may result in additional inconsistencies.
> ...
>
> With those changes, the cpufreq can't scaling the cpu frequency anymore a=
fter cpu
> cooling event. The root cause of this issue is that below 'WRITE_ONCE' ch=
anges may
> have some potential issue. When the CPU temperature is higher than therma=
l passive cooling
> threshold, the thermal framework will trigger cpu cooling to limit the cp=
ufreq policy->max.
> For example, if the CPU supports three setpoint: 1.2GHz, 1.4GHz, and 1.6G=
Hz. The policy->max
> will be limited to 1.2GHz if the temperature continuously increasing and =
higher than the
> passive cooling threshold. Then if the CPU temperature decrease and lower=
 than the threshold,
> the cpu cooling will be canceled, the policy->max need to set back to hig=
h frequency.
>
> But with below WRITE_ONCE changes, if the policy->max=3D1.2GHz, the new_d=
ata.max is 1.6GHz
> or 1.8GHz, The__resolve_freq return value is 1.2GHz all the time, the pol=
icy->max will be fixed at
> 1.2GHz forever even the new_data.max has a value large than current polic=
y->max.
>
> static int cpufreq_set_policy(struct cpufreq_policy *policy,
>                               =C2=A6struct cpufreq_governor *new_gov,
>                               =C2=A6unsigned int new_pol)
> {
> ...
>          /*
>           * Resolve policy min/max to available frequencies. It ensures
>           * no frequency resolution will neither overshoot the requested =
maximum
>           * nor undershoot the requested minimum.
>           *
>           * Avoid storing intermediate values in policy->max or policy->m=
in and
>           * compiler optimizations around them because they may be access=
ed
>           * concurrently by cpufreq_driver_resolve_freq() during the upda=
te.
>           */
>          WRITE_ONCE(policy->max, __resolve_freq(policy, new_data.max, CPU=
FREQ_RELATION_H));

This is not how the code looks currently in the mainline though.

> ...
> }
>
> Please help check it or suggest how to fix it.

See commit b79028039f44 ("cpufreq: Fix setting policy limits when
frequency tables are used").

Or is there anything still missing?

