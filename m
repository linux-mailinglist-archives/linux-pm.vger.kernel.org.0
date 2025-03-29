Return-Path: <linux-pm+bounces-24601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6098EA7560F
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 12:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAAF164F7C
	for <lists+linux-pm@lfdr.de>; Sat, 29 Mar 2025 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67E012EBE7;
	Sat, 29 Mar 2025 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEzktlo+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5C282F5;
	Sat, 29 Mar 2025 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743248943; cv=none; b=UB0492A4E68U8ZJh6MbZg4nMiPIUNqt8SAliNh0tdNc7UTULr0KCz+oEcyvWv9DFFPyJZ7JoRlfpLbamnweXaFlTaGNaVxAidx/3hbR7jDEtaqZ6g4lXRooWnlXTBrBcaa7u19Dsi8703VReWobHkSSSM3oT0GhS6ts1ovf46Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743248943; c=relaxed/simple;
	bh=R3ysMq8tXrd0iXqg/79CSxJMvQiFIWNUV5ThYj7cluA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQOR9kClHRylDE/3eZj8HwSR38S6hLFmTWqA3hcuH71t8d0XeiCLvjm8YHA6fBRyP+Qm5s53xQBU+5cY2VRJuQwXg9U5ihvhjpQoY7BpW/35OvaZHfSf2+lR58TfrIhA8h+86XNvLnjj9ivS/PVTmWcVQkVC9PqEz/9pyuY1P3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEzktlo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A75C4CEEB;
	Sat, 29 Mar 2025 11:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743248943;
	bh=R3ysMq8tXrd0iXqg/79CSxJMvQiFIWNUV5ThYj7cluA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZEzktlo+SBHTzFg/pOyCBDVmLJ2P5x+gYsqaLp4bGBsM5AQQrvmTvg4NIU635bFdw
	 AaJvO90N3WTQp5IRsXRHx/Z4cxgtRN7vJeWH2Jlv2wlgZWgVNJ0GfYjtEtAA6fOPRf
	 gVxG1foI/TxOFx9dJ9EErEENQKzVkkBixeOfHHhwGVB/4E/70nImv/k99RHQ0U7c+5
	 ewJS9OwntzTmF0+9aKpDMOLkaz0uJQk2ADZ0w2OUVFxQqpMyeYxmgXhM91lg5p0BzX
	 3KnkToMWMIQtJ6uFczMvIF8sjfupQiGQ6IzO6k9FgskK4V1CkhvapVhbJpC9S8nyNa
	 WGsBMnPutQxAQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c75830b455so1909395fac.1;
        Sat, 29 Mar 2025 04:49:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU29RUb8xSRceQtL2wc0lb7tCJrm7F5N5OhjKtxgEPb6FWl7epdnpEkkKOdEvffoBme97SJ+aJfkKA=@vger.kernel.org, AJvYcCUCG5/ETD4hoys/6AVzy1kltKQz+ljNRwjsDPn27B3D/OhM9Wg+IQWh0sP6PhjIW+2B6gG7eL6s68UivZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbMD8Yy4CDc1Wsolyj9M/7FQBq5jqkA4WR7AmeweOR4zS2ByaY
	rbXH0152u7523STGwvfpPV3kDSFb7bPA7JW1y/KXI+I1ci3fTvH9ECxTZRVQnogta9sSzdPGI27
	MfDRe29r2N1879JeEDHVhm/7SMAw=
X-Google-Smtp-Source: AGHT+IEMk6cUowGpKB06ZKnQ6ugmoXr0Fd3zU8OJ8t4VtZQHXXcooyhsjt1dof/cGqAkvywb9jVtCNqSgt3g2GfbAYU=
X-Received: by 2002:a05:6871:1ca:b0:2c2:3da4:6389 with SMTP id
 586e51a60fabf-2cbcf56f67dmr1393331fac.23.1743248942327; Sat, 29 Mar 2025
 04:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4651448.LvFx2qVVIh@rjwysocki.net> <1928789.tdWV9SEqCh@rjwysocki.net>
 <Z-dUm_z8daM_nQoy@mail-itl>
In-Reply-To: <Z-dUm_z8daM_nQoy@mail-itl>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 29 Mar 2025 12:48:50 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h_UzXkT5eS9FPq-UBqTsprhHuGK_YHDVRyPNPcYcKC4A@mail.gmail.com>
X-Gm-Features: AQ5f1Jo2UkPdGxRMnhKgIBB75PtQHeJttpo2X-cbaVMa39Pk6fuAo8nL-RAp8TE
Message-ID: <CAJZ5v0h_UzXkT5eS9FPq-UBqTsprhHuGK_YHDVRyPNPcYcKC4A@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] cpufreq: Reference count policy in cpufreq_update_limits()
To: =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= <marmarek@invisiblethingslab.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 29, 2025 at 3:02=E2=80=AFAM Marek Marczykowski-G=C3=B3recki
<marmarek@invisiblethingslab.com> wrote:
>
> On Fri, Mar 28, 2025 at 09:39:08PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Since acpi_processor_notify() can be called before registering a cpufre=
q
> > driver or even in cases when a cpufreq driver is not registered at all,
> > cpufreq_update_limits() needs to check if a cpufreq driver is present
> > and prevent it from being unregistered.
> >
> > For this purpose, make it call cpufreq_cpu_get() to obtain a cpufreq
> > policy pointer for the given CPU and reference count the corresponding
> > policy object, if present.
> >
> > Fixes: 5a25e3f7cc53 ("cpufreq: intel_pstate: Driver-specific handling o=
f _PPC updates")
> > Closes: https://lore.kernel.org/linux-acpi/Z-ShAR59cTow0KcR@mail-itl
> > Reporetd-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
>
> Reported

Right, thanks!

> I wanted to propose also Tested-by tag, but technically it's not me who
> tested it: https://forum.qubes-os.org/t/kernel-latest-6-13-6-boot-loop/32=
926/18

You can ask the original tester whether or not they would be willing
to give a tag, though.

> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2781,6 +2781,12 @@
> >   */
> >  void cpufreq_update_limits(unsigned int cpu)
> >  {
> > +     struct cpufreq_policy *policy __free(put_cpufreq_policy);
> > +
> > +     policy =3D cpufreq_cpu_get(cpu);
> > +     if (!policy)
> > +             return;
> > +
> >       if (cpufreq_driver->update_limits)
> >               cpufreq_driver->update_limits(cpu);
> >       else
> >
> >
> >
>
> --
> Best Regards,
> Marek Marczykowski-G=C3=B3recki
> Invisible Things Lab

