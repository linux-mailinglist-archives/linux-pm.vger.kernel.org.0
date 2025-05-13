Return-Path: <linux-pm+bounces-27079-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADA8AB56A9
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9E361B46F90
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 14:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C3A28DF3E;
	Tue, 13 May 2025 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZxQtcR4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4AB27FB39;
	Tue, 13 May 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747144883; cv=none; b=YRyEccW/i88J1BRd8SHsR9/U4Q3jtvtuPVl8E76+W8QyfEomdms/O/FeskDjRAA7rfSig1YnYKBu61Ydo8tnXiVcAWeRBXKQaLCFTTw4gHPeH69dnrC/Sc6Ldva0wNn/TX3Y7fTYZ8bqHT3A0aOU+x2V1hbwAB3dlGj8GSxolcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747144883; c=relaxed/simple;
	bh=v6Rm2EsNBVuAl6TS+dj1EgQWTYT0Iby5wb5SCwSNQ9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCLxCP6L1vGHMfu0DJDK+P8PtgDXfpi1vCbMXGSWMF49/Cdfg9fiXOC7lxrVtl8vy9CSytdatNDpA9tyxHqwzaBQa8ysOgkKgGRz5pgnwY7YJ5d66ol2uXsq/7yZNwOghN/ehn2QXll3u0HHznK2CzCxVTWKbaF1FUGjNNBXPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZxQtcR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02A9C4CEE9;
	Tue, 13 May 2025 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747144882;
	bh=v6Rm2EsNBVuAl6TS+dj1EgQWTYT0Iby5wb5SCwSNQ9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EZxQtcR4ph0vkw7ikUX3c3CAB6v+eQVzr3qIDlvRDcziv2s5bBkhhaoVnOuRfzJyj
	 S5Hci/qa0OoTL7/D/roCg6VR3Q+ligKXGIWR5wEOQ97EvKhweh8dQ4+5aEgL17iqMP
	 3fBIGP0LJ3fHhZY4bTB+g3VSyEmNDiUksrO3ODKpcHn2dEg4ToQjCtHjErpQjUkuKd
	 OtZup+TjT1kBkRZ3mRVJWT6OIzYeUlOPlxt+sfpS4otUX5RrTxJqoUzUBH+4bAKk+Z
	 NRkEXmePxe8PD7QLY6aumvcmpebFTCyhlxWww/N7yLkzJT2NFM1HcPoOfvzGM5vJsA
	 +MmfoZaP0nfmA==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2d071fcd89bso2022182fac.3;
        Tue, 13 May 2025 07:01:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YxFDJV+UxcSRc/kOnRBdck1b0hiPuNPjZAGIJaCTXJrisWB/YE2
	M7vTo+T4OiASfcSBPsKNE+DXQajaC31QsK3+AUT7ylc6H/UqGa5nlAq6Pzn8rbxDJUDyB9MBdpM
	jUe98c6KbtmtcGxrzV1r5KY5IWOY=
X-Google-Smtp-Source: AGHT+IH7Fv0nO3ps9l44Deuibp7LvKppm8chuSm6AFepZ8q20wlIH8lneFlf9aFpFkWUm78CukuKszd9bhPMZzk5MJI=
X-Received: by 2002:a05:6870:ac11:b0:2d5:1894:8c29 with SMTP id
 586e51a60fabf-2dba435d651mr8383878fac.23.1747144880719; Tue, 13 May 2025
 07:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2999205.e9J7NaK4W3@rjwysocki.net> <CAJZ5v0jLpKEgAodWx8G0k127vMUe-J1rGkCEreRP7a1dQXT2vA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jLpKEgAodWx8G0k127vMUe-J1rGkCEreRP7a1dQXT2vA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 May 2025 16:01:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gcgMJ-qihgc3_OF4djxAy8K0i-cmnjRe4AQrc_YEu4DQ@mail.gmail.com>
X-Gm-Features: AX0GCFtctmpLuypFLtk5Ny2JrEMqafth8YnYP7vVwtioEKYPgbRKcct9jYOiFec
Message-ID: <CAJZ5v0gcgMJ-qihgc3_OF4djxAy8K0i-cmnjRe4AQrc_YEu4DQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] cpufreq: intel_pstate: Enable EAS on hybrid
 platforms without SMT
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 2:51=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, May 6, 2025 at 10:49=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.=
net> wrote:
> >
> > Hi Everyone,
> >
> > This is a new (and most likely final) version of
> >
> > https://lore.kernel.org/linux-pm/3344336.aeNJFYEL58@rjwysocki.net/
> >
> > The most significant difference between it and the above is that schedu=
til is
> > now required for EAS to be enabled, like on the other platforms using E=
AS,
> > which means that intel_pstate needs to operate in the passive mode in o=
rder
> > to use it (the most straightforward way to switch it over to the passiv=
e mode
> > is to write "passive" to /sys/devices/system/cpu/intel_pstate/status).
> >
> > Accordingly, the changes that were needed for EAS to work without sched=
util are
> > not needed any more, so there is one patch less in the series because o=
f that
> > and patch [5/7] is simpler than its previous version because some chang=
es made
> > by it are not necessary any more.
> >
> > Another patch that has been dropped is
> >
> > https://lore.kernel.org/linux-pm/1964444.taCxCBeP46@rjwysocki.net/
> >
> > because it didn't take CPU online into account properly and it is not e=
ssential
> > for the current hardware anyway.
> >
> > There is a new patch, [7/7], which adds CAS/EAS/hybrid support descript=
ion to
> > the intel_pstate admin-guide documentation.
> >
> > The following paragraph from the original cover letter still applies:
> >
> > "The underlying observation is that on the platforms targeted by these =
changes,
> > Lunar Lake at the time of this writing, the "small" CPUs (E-cores), whe=
n run at
> > the same performance level, are always more energy-efficient than the "=
big" or
> > "performance" CPUs (P-cores).  This means that, regardless of the scale=
-
> > invariant utilization of a task, as long as there is enough spare capac=
ity on
> > E-cores, the relative cost of running it there is always lower."
> >
> > The first 2 patches depend on the current cpufreq material queued up fo=
r 6.16
> > in linux-pm.git/linux-next (and in linux-next proper) and are not reall=
y
> > depended on by the rest of the series, but I've decided to include them=
 into
> > this series because they have been slightly updated since the previous =
version,
> > mostly to take review feedback into account (I'm going to queue them up=
 for
> > 6.16 shortly because they don't appear to be objectionable).
> >
> > The next 2 patches (Energy Model code changes) were reviewed previously=
, but
> > they are only needed because of patch [5/7].
> >
> > Patch [5/7] has not changed much except that some changes made by the p=
revious
> > version have been dropped from it.  Also its changelog has been updated=
.  It
> > causes perf domains to be registered per CPU and in addition to the pri=
mary cost
> > component, which is related to the CPU type, there is a small component
> > proportional to performance whose role is to help balance the load betw=
een CPUs
> > of the same type.
> >
> > The expected effect is still that the CPUs of the "low-cost" type will =
be
> > preferred so long as there is enough spare capacity on any of them.
> >
> > Patch [6/7] has been updated to walk all of the cache leaves and look f=
or
> > the ones with level equal to 3 because the check used in the previous v=
ersion
> > does not always work.
> >
> > The documentation patch, [7/7], is new.
> >
> > Please refer to the individual patch changelogs for details.
>
> This series along with the fix at
>
> https://lore.kernel.org/linux-pm/2806514.mvXUDI8C0e@rjwysocki.net/
>
> is now present in the experimental/intel_pstate/eas-final brangh in
> linux-pm.git:
>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/l=
og/?h=3Dexperimental/intel_pstate/eas-final
>
> and it has been added to the bleeding-edge branch for 0-day build testing=
.

In order to test it, the kernel needs to be compiled with
CONFIG_ENERGY_MODEL set.

If at least some cores in the system are SMT-capable, SMT needs to be
turned off (either in the BIOS setup or by passing nosmt to the kernel
in the command line).

Finally, schedutil needs to be the cpufreq governor which requires
intel_pstate to operate in the passive mode (schedutil is the default
governor in that case).  The most straightforward way to switch it
into the passive mode is to write "passive" to
/sys/devices/system/cpu/intel_pstate/status (it may also be started in
the passive mode as described in
https://www.kernel.org/doc/html/latest/admin-guide/pm/intel_pstate.html).

Note that you can compare the default non-EAS configuration of
intel_pstate to the one with EAS enabled by switching it between the
"active" and "passive" modes via sysfs (no reboots needed).

Thanks!

