Return-Path: <linux-pm+bounces-35803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5592BBC489C
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 13:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E66154E5710
	for <lists+linux-pm@lfdr.de>; Wed,  8 Oct 2025 11:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD042F6191;
	Wed,  8 Oct 2025 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NX4a40xh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369D72F6180
	for <linux-pm@vger.kernel.org>; Wed,  8 Oct 2025 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922627; cv=none; b=k6gXnob5SYtuCaCQzrfXXjwyqo0LHmsL9jheA/TzG8bMpf332o5KoNq6/rn2CvlsUGc0V0jo5u95lBNYZO2VW9foVIBgDihQCx/WNmO51jViW8jVQu8W9iJmknMSTAmSDiH3GiGoY95yfK4H6b5euPtbyUzjohFED+sMIA6iZlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922627; c=relaxed/simple;
	bh=KEhEuKwCPJ3dLWcFCbexBiSGqiFxn45TrcIsnxqvYiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlqfofhQnOY9s8SJRi3el6A7VTVNc/jKLDtpMNvAy6WjyIYAySyKfZIEjTZ1nsDmAGPbAo4Aj8MhyHZ7L5KU1SPq9+54WLudeOyMUJYoVTg6ew8I5wwmC/VU6a4R/2BRU6TRDMznySMaPGU1JhxI1+Oh2Ai7AVXiKbCqx4oDZbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NX4a40xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC156C116B1
	for <linux-pm@vger.kernel.org>; Wed,  8 Oct 2025 11:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759922626;
	bh=KEhEuKwCPJ3dLWcFCbexBiSGqiFxn45TrcIsnxqvYiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NX4a40xhNABgkz8Z6R4NxHZTvgo+0Pl0SBI1/3/MBCIgLwjbC3DX22waCZbvr+zoc
	 MKOuZHZ7vuBgQnXYr0pacrBsO1k4QySTbJXUsr429nqF+LX511+AaEi4vkWrQtihLH
	 XNWzvGZZ5o/M1npyU9eOHq3mNw2YD5Pq6m/XEVOD1lpnBMOS6HoIvaxpBI3X7bx5n+
	 0B5M5GZ1x3f/MjP2m1zbFiU5HNLSQZOvOIDtlebMtMjuw7FML6RK1WoeErIGEPBv8D
	 WLbmp3rMqDWaI3wmnhynko12/BTqMSyTbAnGtFmzG1WXWXn3Y2O/7rMb3aOIMx7K97
	 Z25KQjg+6DtmQ==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7a7c1ecd433so3985192a34.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Oct 2025 04:23:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVP0I98EJpTF5v5a++926wClivC1m3PIQUokPSsRzlFewHh2rxMA4L9sgtOlChjup0CQJkipOh8Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYpzAMnBOqKnrYX/JVHhsH+RCfhmBCRZD+JYJtzI+ZepWAfxWO
	IaFDpFPR49ctbozMgEKRfwEs+gk+61JHIGzBSmshP9SI0CGEEEXihD/MDSF3XxdiPPNO/8osUt6
	ldzA9LTfa5cLIB5vXA40ZsM98/7MndhA=
X-Google-Smtp-Source: AGHT+IFfHZ8HGqxj7f466AKKrLHNXLEqnoShIi3UA9a8omxTcg0b+75+V45dqCAudPzoBHdRpOZxL0eWLd6272/GIuA=
X-Received: by 2002:a05:6808:2201:b0:43f:ac2d:dd3a with SMTP id
 5614622812f47-4417b38ffd3mr1450551b6e.26.1759922626108; Wed, 08 Oct 2025
 04:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007063551.3147937-1-senozhatsky@chromium.org> <20251008101408.dj46r66gcfo26sgl@lcpd911>
In-Reply-To: <20251008101408.dj46r66gcfo26sgl@lcpd911>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 8 Oct 2025 13:23:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hBzgJP2L0yg4JtP2c=NxA=MqAY_m+9GJ9P8kszb1hWvw@mail.gmail.com>
X-Gm-Features: AS18NWDaaxCc6gY2WMGLj5YvkDBRtJ44YZ9x_aKJx5HSqrLThkqUCL3iGoGDloo
Message-ID: <CAJZ5v0hBzgJP2L0yg4JtP2c=NxA=MqAY_m+9GJ9P8kszb1hWvw@mail.gmail.com>
Subject: Re: [PATCHv2] PM: dpm: add module param to backtrace all CPUs
To: Dhruva Gole <d-gole@ti.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Tomasz Figa <tfiga@chromium.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 12:14=E2=80=AFPM Dhruva Gole <d-gole@ti.com> wrote:
>
> On Oct 07, 2025 at 15:35:40 +0900, Sergey Senozhatsky wrote:
> > Add dpm_watchdog_all_cpu_backtrace module parameter which
> > controls all CPU backtrace dump before DPM panics the system.
> > This is expected to help understanding what might have caused
> > device timeout.
>
> This will indeed be really helpful for debugging some nasty bugs!
>
> >
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  drivers/base/power/main.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index e83503bdc1fd..7a8807ec9a5d 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/cpufreq.h>
> >  #include <linux/devfreq.h>
> >  #include <linux/timer.h>
> > +#include <linux/nmi.h>
> >
> >  #include "../base.h"
> >  #include "power.h"
> > @@ -515,6 +516,11 @@ struct dpm_watchdog {
> >  #define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
> >       struct dpm_watchdog wd
> >
> > +static bool __read_mostly dpm_watchdog_all_cpu_backtrace;
> > +module_param(dpm_watchdog_all_cpu_backtrace, bool, 0644);
> > +MODULE_PARM_DESC(dpm_watchdog_all_cpu_backtrace,
> > +              "Backtrace all CPUs on DPM watchdog timeout");
> > +
>
> Have you considered runtime configurability instead of a module param?

This one can be updated at run time AFAICS.

