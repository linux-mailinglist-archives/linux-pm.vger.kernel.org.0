Return-Path: <linux-pm+bounces-24710-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E95A780D0
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 18:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7CE3A57AE
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 16:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F200F20B814;
	Tue,  1 Apr 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a37lBMXI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BE62080DD;
	Tue,  1 Apr 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743526070; cv=none; b=dZbvxxSZnL56m9pI5GQTL0wvzkaMByW/9FwEpgmU7qjieotwoAt7cjULKwwxVbnV3E7mVZZ2qmaVXQ4OhLVCO6frTbNN3k+fKKq7WjQ0THqHQi/1gkYf3LPmHnCk8vJE2+MsQuU1suifna8G4FZTgAsPgzKrt38Tq3uGESaCyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743526070; c=relaxed/simple;
	bh=B3B9jZQrulUU3xrFKjRP1uzIjhdZOihFD6DfSwoFHEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bu1olKJ9S3kaCDfJe0NWzh5S1huid7qBj3Kep5xE2IUPZ7eZ69QcE53j7jHbs7HmDiTUgpQZauYSrafiy7WKqB14pELzCXepzNfLj+pvfUTZJaTszK3a5FegTe1OKCOwFSFLF160Uw+2BlceViK8i0ddPskZJOGIHq6wnqmxW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a37lBMXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E23EC4CEE5;
	Tue,  1 Apr 2025 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743526070;
	bh=B3B9jZQrulUU3xrFKjRP1uzIjhdZOihFD6DfSwoFHEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a37lBMXIR3cCMuCg5+rqlnTbHLXD35aHRsqUYBnOy47DBsuM/nyzqe9ECLk0Gi9hX
	 +nmSIaxXCojZWnsuwwJvxoI6e654frUYb7fA/FuLFYikk4SPIvyAoz27Hlq9kPdl1F
	 60onUK7OUgNk575Z3hJnDnK++42fcF4Tt497OGhHU2U9Z56oiMIy7sD7i1YqnnD7xG
	 JeRmCtDk1CdKNhmuCslJChXSqEPcjWClONyTdFWK7u/RyozrJI+UA2d9PgX5w9de8C
	 ZPf8jqe76udLuSEIKvV61AhMndkzad7iOtiTF7sI/TD9Lvoy37ZrLvnuBwDdyucKgt
	 Z1l+6mT1BaJQA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fcef5dc742so1474232eaf.1;
        Tue, 01 Apr 2025 09:47:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUor77l/k571K+ulAZwRYnhgR2OHezZWQCOLM1MyfYsK0fzugoCR3kMs2sDHpLrBIc3H89rHPeLGwA=@vger.kernel.org, AJvYcCXVTY9aP5AyDG0u3+HwANuCnfIXukGhjQfi0hcMlx3Uq23OiwlalpRgTcoeGs2iPNtEhMkF/6mmawXXNkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpHimuEX4eLWTbLjioSW3eEzanQq2R56pBksrRZj1uBX5ugZxV
	99Twvi83NV9e2roJf6fRfwJjbp424dXKSybn4LmbxbFroK38LgZWcG7dpS6JdJNJd1ESz4IdwXn
	AM+U61+/dysbowMJAp6m61UjVfcU=
X-Google-Smtp-Source: AGHT+IGTzmM6gjGFqA3jlKl7ZZKEGN3H2NaBYk48zm+YLrtK7x0+vWCSX9CFBqbSFa8PlRbZdLnl0yUNPiEpcEiSoVY=
X-Received: by 2002:a05:6808:21a4:b0:3f8:8977:7294 with SMTP id
 5614622812f47-3ff0f5be71fmr6238968b6e.31.1743526069577; Tue, 01 Apr 2025
 09:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4651448.LvFx2qVVIh@rjwysocki.net> <1928789.tdWV9SEqCh@rjwysocki.net>
 <20250401083012.vjwkxjkmd5afyqjt@vireshk-i7>
In-Reply-To: <20250401083012.vjwkxjkmd5afyqjt@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Apr 2025 18:47:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iarkdUttUsDe=2rwzk6169H8-PKVPO=Cw8BsvhbXvwJQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqFcAkRM6Wiu7uUS7i22WgQVBNtc-lNL1FPI3QfbnDJon61g9aukJ_ch-0
Message-ID: <CAJZ5v0iarkdUttUsDe=2rwzk6169H8-PKVPO=Cw8BsvhbXvwJQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] cpufreq: Reference count policy in cpufreq_update_limits()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	=?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= <marmarek@invisiblethingslab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 10:30=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 28-03-25, 21:39, Rafael J. Wysocki wrote:
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
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for all of the ACKs!

