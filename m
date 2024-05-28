Return-Path: <linux-pm+bounces-8303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A157D8D2554
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 22:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5421C28199B
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 20:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC26178363;
	Tue, 28 May 2024 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owCVVocN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9136E29402;
	Tue, 28 May 2024 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926453; cv=none; b=aMyetZNLczYP+hUdizCNDSrEyMmIdLNn2f7HoPverYBTkZ1RreSbzC9At+TD87wn2dljY4tQ7vDrOoRvU5oFlv+IaMt6V4TCPBtfJxcy4GWmzsACg8uFayIQHN9LyqfeJ6IhuvEKyP9FXMZg3MiM1FG9YskDRMwb1j0NvtJvKHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926453; c=relaxed/simple;
	bh=nTbDhwyviaLMbfaJtiOxxx3LkcPgQ3xSCNmD1vg86bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnN9HbOjcwumjUKl7ZXc/hYANa7ZolbzFA67232K+YOzcxfKfb5hm6qQVypuM/jHc1Pc5zp34shnUzMiLVGxOgAgAsqCbl08eHbHxktR7wt2xCN0ADOHq2CPCfa7+oay8tNH8WZv1mV2zaq/+/1fRoefpOF1Ilq8o0g/FXkpjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owCVVocN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0171CC32786;
	Tue, 28 May 2024 20:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716926453;
	bh=nTbDhwyviaLMbfaJtiOxxx3LkcPgQ3xSCNmD1vg86bc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=owCVVocN8NuAMtXNRgBZCZEwTvdQgWHpV6mACAUokIiIrngzZfjuB3G9VyJrF646h
	 fCdLJF/pw+uYGcJVHiivPj9lXGa6est3vPsUl6I7qjWSdV/CeqqGUWk3/zcE9eEhh/
	 7EQyGb6H/HaI9r461E4YKqVCNbjUjF+GUUYc6PI2woCnSrNUtNZODMEac/EDR3V3Wh
	 Ehzzr/PWHRo4MxDWkgn+b75H4AnSF7iLpcjytXTjQr9A71tr68vPLrjbr2hNj2Hun+
	 pD9zuzMmuacu/fE76SvZoDAuRx2xNz3IkgIP1BooALKCtTh+gbxhuiZUxya0Uuj57B
	 g9f74EizWzWaA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b2fbe85f82so191202eaf.1;
        Tue, 28 May 2024 13:00:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOirMGAHOUMeWR7jxe6w/1D2jn5z2GaQYF7VoMTzXHqirhscs2+90njtukflOdrIPUacG0QSadSMuJdE7im2GepGXdW5NqQUas2JvKo+VdbHuX7upiSEZJo4I0RYMhyBPCXa16Z5E=
X-Gm-Message-State: AOJu0YxEGl7t7P3ixH6GO3RVm/ss9Ad2We12MiZb6JoaYaU4xEjKowuF
	ipUWgxeNvZWIGB1pbAQlIvtwWo1UuLB7bUAEdzRAp8r7SZ+7QQhxARt37gcrg0Jod3V2zr1XlBV
	tmM7x2vKXcuuBVQugGjedwEWl2cE=
X-Google-Smtp-Source: AGHT+IHllD0tfHn/GT604/S3e6+vho1OzOixWyheh0PHIwshIZefDo1hz6aL0GVlHXEZ/M7BizLCS7+NA7hMMir+LUs=
X-Received: by 2002:a4a:ba86:0:b0:5b2:8017:fb68 with SMTP id
 006d021491bc7-5b95cde3ec5mr14458580eaf.0.1716926452133; Tue, 28 May 2024
 13:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528121124.3588248-1-arnd@kernel.org> <0edd0485-274a-4b3f-8ecb-60708963db8a@amd.com>
In-Reply-To: <0edd0485-274a-4b3f-8ecb-60708963db8a@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 May 2024 22:00:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iqkR24RjiXET6qKRHeOLxYqKSgrpsp_N87wuJrtdTcAg@mail.gmail.com>
Message-ID: <CAJZ5v0iqkR24RjiXET6qKRHeOLxYqKSgrpsp_N87wuJrtdTcAg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: amd-pstate: remove global header file
To: Mario Limonciello <mario.limonciello@amd.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Huang Rui <ray.huang@amd.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Perry Yuan <perry.yuan@amd.com>, Wyes Karny <wyes.karny@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Meng Li <li.meng@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 7:49=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 5/28/2024 07:09, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When extra warnings are enabled, gcc points out a global variable
> > definition in a header:
> >
> > In file included from drivers/cpufreq/amd-pstate-ut.c:29:
> > include/linux/amd-pstate.h:123:27: error: 'amd_pstate_mode_string' defi=
ned but not used [-Werror=3Dunused-const-variable=3D]
> >    123 | static const char * const amd_pstate_mode_string[] =3D {
> >        |                           ^~~~~~~~~~~~~~~~~~~~~~
> >
> > This header is only included from two files in the same directory,
> > and one of them uses only a single definition from it, so clean it
> > up by moving most of the contents into the driver that uses them,
> > and making shared bits a local header file.
> >
> > Fixes: 36c5014e5460 ("cpufreq: amd-pstate: optimize driver working mode=
 selection in amd_pstate_param()")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks!
>
> Acked-by: Mario Limonciello <mario.limonciello@amd.com>

Applied as 6.10-rc material, thanks!

> > ---
> >   MAINTAINERS                                   |  1 -
> >   drivers/cpufreq/amd-pstate-ut.c               |  3 +-
> >   drivers/cpufreq/amd-pstate.c                  | 34 ++++++++++++++++++=
-
> >   .../linux =3D> drivers/cpufreq}/amd-pstate.h    | 33 ----------------=
--
> >   4 files changed, 35 insertions(+), 36 deletions(-)
> >   rename {include/linux =3D> drivers/cpufreq}/amd-pstate.h (82%)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 070a39b2b098..35a75ab8ef05 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1107,7 +1107,6 @@ L:      linux-pm@vger.kernel.org
> >   S:  Supported
> >   F:  Documentation/admin-guide/pm/amd-pstate.rst
> >   F:  drivers/cpufreq/amd-pstate*
> > -F:   include/linux/amd-pstate.h
> >   F:  tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> >
> >   AMD PTDMA DRIVER
> > diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-psta=
te-ut.c
> > index f04ae67dda37..fc275d41d51e 100644
> > --- a/drivers/cpufreq/amd-pstate-ut.c
> > +++ b/drivers/cpufreq/amd-pstate-ut.c
> > @@ -26,10 +26,11 @@
> >   #include <linux/module.h>
> >   #include <linux/moduleparam.h>
> >   #include <linux/fs.h>
> > -#include <linux/amd-pstate.h>
> >
> >   #include <acpi/cppc_acpi.h>
> >
> > +#include "amd-pstate.h"
> > +
> >   /*
> >    * Abbreviations:
> >    * amd_pstate_ut: used as a shortform for AMD P-State unit test.
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.=
c
> > index 1b7e82a0ad2e..91993647e09e 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -36,7 +36,6 @@
> >   #include <linux/delay.h>
> >   #include <linux/uaccess.h>
> >   #include <linux/static_call.h>
> > -#include <linux/amd-pstate.h>
> >   #include <linux/topology.h>
> >
> >   #include <acpi/processor.h>
> > @@ -46,6 +45,8 @@
> >   #include <asm/processor.h>
> >   #include <asm/cpufeature.h>
> >   #include <asm/cpu_device_id.h>
> > +
> > +#include "amd-pstate.h"
> >   #include "amd-pstate-trace.h"
> >
> >   #define AMD_PSTATE_TRANSITION_LATENCY       20000
> > @@ -53,6 +54,37 @@
> >   #define CPPC_HIGHEST_PERF_PERFORMANCE       196
> >   #define CPPC_HIGHEST_PERF_DEFAULT   166
> >
> > +#define AMD_CPPC_EPP_PERFORMANCE             0x00
> > +#define AMD_CPPC_EPP_BALANCE_PERFORMANCE     0x80
> > +#define AMD_CPPC_EPP_BALANCE_POWERSAVE               0xBF
> > +#define AMD_CPPC_EPP_POWERSAVE                       0xFF
> > +
> > +/*
> > + * enum amd_pstate_mode - driver working mode of amd pstate
> > + */
> > +enum amd_pstate_mode {
> > +     AMD_PSTATE_UNDEFINED =3D 0,
> > +     AMD_PSTATE_DISABLE,
> > +     AMD_PSTATE_PASSIVE,
> > +     AMD_PSTATE_ACTIVE,
> > +     AMD_PSTATE_GUIDED,
> > +     AMD_PSTATE_MAX,
> > +};
> > +
> > +static const char * const amd_pstate_mode_string[] =3D {
> > +     [AMD_PSTATE_UNDEFINED]   =3D "undefined",
> > +     [AMD_PSTATE_DISABLE]     =3D "disable",
> > +     [AMD_PSTATE_PASSIVE]     =3D "passive",
> > +     [AMD_PSTATE_ACTIVE]      =3D "active",
> > +     [AMD_PSTATE_GUIDED]      =3D "guided",
> > +     NULL,
> > +};
> > +
> > +struct quirk_entry {
> > +     u32 nominal_freq;
> > +     u32 lowest_freq;
> > +};
> > +
> >   /*
> >    * TODO: We need more time to fine tune processors with shared memory=
 solution
> >    * with community together.
> > diff --git a/include/linux/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
> > similarity index 82%
> > rename from include/linux/amd-pstate.h
> > rename to drivers/cpufreq/amd-pstate.h
> > index d58fc022ec46..e6a28e7f4dbf 100644
> > --- a/include/linux/amd-pstate.h
> > +++ b/drivers/cpufreq/amd-pstate.h
> > @@ -1,7 +1,5 @@
> >   /* SPDX-License-Identifier: GPL-2.0-only */
> >   /*
> > - * linux/include/linux/amd-pstate.h
> > - *
> >    * Copyright (C) 2022 Advanced Micro Devices, Inc.
> >    *
> >    * Author: Meng Li <li.meng@amd.com>
> > @@ -12,11 +10,6 @@
> >
> >   #include <linux/pm_qos.h>
> >
> > -#define AMD_CPPC_EPP_PERFORMANCE             0x00
> > -#define AMD_CPPC_EPP_BALANCE_PERFORMANCE     0x80
> > -#define AMD_CPPC_EPP_BALANCE_POWERSAVE               0xBF
> > -#define AMD_CPPC_EPP_POWERSAVE                       0xFF
> > -
> >   /********************************************************************=
*
> >    *                        AMD P-state INTERFACE                      =
 *
> >    ********************************************************************=
*/
> > @@ -108,30 +101,4 @@ struct amd_cpudata {
> >       bool    suspended;
> >   };
> >
> > -/*
> > - * enum amd_pstate_mode - driver working mode of amd pstate
> > - */
> > -enum amd_pstate_mode {
> > -     AMD_PSTATE_UNDEFINED =3D 0,
> > -     AMD_PSTATE_DISABLE,
> > -     AMD_PSTATE_PASSIVE,
> > -     AMD_PSTATE_ACTIVE,
> > -     AMD_PSTATE_GUIDED,
> > -     AMD_PSTATE_MAX,
> > -};
> > -
> > -static const char * const amd_pstate_mode_string[] =3D {
> > -     [AMD_PSTATE_UNDEFINED]   =3D "undefined",
> > -     [AMD_PSTATE_DISABLE]     =3D "disable",
> > -     [AMD_PSTATE_PASSIVE]     =3D "passive",
> > -     [AMD_PSTATE_ACTIVE]      =3D "active",
> > -     [AMD_PSTATE_GUIDED]      =3D "guided",
> > -     NULL,
> > -};
> > -
> > -struct quirk_entry {
> > -     u32 nominal_freq;
> > -     u32 lowest_freq;
> > -};
> > -
> >   #endif /* _LINUX_AMD_PSTATE_H */
>

