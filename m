Return-Path: <linux-pm+bounces-34672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC29B57CA8
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 15:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFC1189B0F6
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 13:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F4E315D5C;
	Mon, 15 Sep 2025 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I97rt8Wy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED6315789
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757942336; cv=none; b=YULA+Pls8fyVV4uwKwsMIh2QDtkbSKPZsswk8OvmOf9Enaz8gvXrE6mYWGMlpClvkMufpeeSIo/jLhwmSt8EV6BvUF8yKTWk0JS7SGJbRgSlMB9W34VlMOb/MTR6LFVLL6yBGZoqUuJJugZK8EoNIiQ+oeeAwhLQ4Or38TaWNA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757942336; c=relaxed/simple;
	bh=coOwMyQHXkTz8FDu4+hP/GBgwN4J5NtDSuvxSzgJTgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkyiWGe7YnXX9tnFZTg9bOa6k5tAmxSa/Hh+d1p1O8Aaza8n9wVmIyp42ev5IvDUkVeYsEBEKRXhSTqu45A8HFJtMeZNhirYeIWNjDZ9LZ+KvN50bH91hH6oAVOSuHNB1bgHpVDaTSHL9fcnYgMLb+2LKvHq1zqyyUCSC1h/6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I97rt8Wy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423EDC4CEF5
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 13:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757942336;
	bh=coOwMyQHXkTz8FDu4+hP/GBgwN4J5NtDSuvxSzgJTgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I97rt8Wy/HHyb6Jf09V1zJXWto0w0vNSlKzz5aSR4qpNptlGuHqaQkNo+QA3hTBev
	 jlFmnqbGvrfkro5DdG45KAf5is9c8Jfk9ziGqqJqJ9+Oj9rD6RYruICf/5AppYF4Yz
	 H+lkblPSUv+O5NqNZymziuQKz/OeavBGHjeRCtqMYLCG+yKNtOL4IUlhodqyhuxzqT
	 yPOz+m4j/MKvbVsK5YvIgCa/nrL2mBmOEf+hNqhLQEJEstjZDoAR657PZfAzRgI130
	 C3r678zl49iNII/XPyPo/NbAvBglhMvR1kwAlG/Qg25fRtSlpdv2FmMWA3rU05tKgf
	 2xGuvSifuIE7g==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7459d088020so2012752a34.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 06:18:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYk/Lber6YtYHEjO0am60E6vcJ3chHufPlOiJRFg2JD9JfRXkQnDxMPOG773oYIMRQHR1HANrxVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsEEWMUzpH9CJLY1EaBD8uCG+velrHBiuqSUPhs6Ecr4AcMXWV
	PQvWoEev6RlwskI3pVzsSyPjc4FV+fhNAlcHglsbeGlhoa9ZvCNlw4eM8AGPihdLGc6iOAZC3vd
	ORydKBveNlmb0rfAlLl/mZJgWdD95cAE=
X-Google-Smtp-Source: AGHT+IEpcuRSc3MDHlFe9TDySxc24ll0ZsZy+5Xvb8x8nLaNBT9Lv9dKicdTazMGgmSAUaLhaDM/ulAOWO9IeV6FrUg=
X-Received: by 2002:a05:6830:8d2:b0:73e:94d4:ec6 with SMTP id
 46e09a7af769-75355daf04dmr7268800a34.28.1757942335532; Mon, 15 Sep 2025
 06:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910065312.176934-1-shawnguo2@yeah.net> <CAJZ5v0gL5s99h0eq1U4ngaUfPq_AcfgPruSD096JtBWVMjSZwQ@mail.gmail.com>
 <aMQbIu5QNvPoAsSF@dragon> <20250914174326.i7nqmrzjtjq7kpqm@airbuntu> <aMfAQXE4sRjru9I_@dragon>
In-Reply-To: <aMfAQXE4sRjru9I_@dragon>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Sep 2025 15:18:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i8L8w_ojua1ir3CGcwGSvE+3Jj0Sh5Cs1Yi8i4BX1Lbw@mail.gmail.com>
X-Gm-Features: Ac12FXyAwdW-riCrTAP42SIBJxPCzjL2s62SpRjg0mEC2Yp-NeONok5neIsFcF4
Message-ID: <CAJZ5v0i8L8w_ojua1ir3CGcwGSvE+3Jj0Sh5Cs1Yi8i4BX1Lbw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: cap the default transition delay at 10 ms
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 9:29=E2=80=AFAM Shawn Guo <shawnguo2@yeah.net> wrot=
e:
>
> On Sun, Sep 14, 2025 at 06:43:26PM +0100, Qais Yousef wrote:
> > > > Why do you want to address the issue in the cpufreq core instead of
> > > > doing that in the cpufreq-dt driver?
> > >
> > > My intuition was to fix the regression at where the regression was
> > > introduced by recovering the code behavior.
> >
> > Isn't the right fix here is at the driver level still? We can only give=
 drivers
> > what they ask for. If they ask for something wrong and result in someth=
ing
> > wrong, it is still their fault, no?
>
> I'm not sure.  The cpufreq-dt driver is following suggestion to use
> CPUFREQ_ETERNAL,

Fair enough.

Actually, there are a few other drivers that fall back to
CPUFREQ_ETERNAL if they cannot determine transition_latency.

> which has the implication that core will figure out a reasonable default =
value for
> platforms where the latency is unknown.

Is this expectation realistic, though?  I'm not sure.

The core can only use a hard-coded default fallback number, but would
that number be really suitable for all of the platforms in question?

> And that was exactly the situation before the regression.  How does it
> become the fault of cpufreq-dt driver?

The question is not about who's fault it is, but what's the best place
to address this issue.

I think that addressing it in cpufreq_policy_transition_delay_us() is
a bit confusing because it is related to initialization and the new
branch becomes pure overhead for the drivers that don't set
cpuinfo.transition_latency to CPUFREQ_ETERNAL.

However, addressing it at the initialization time would effectively
mean that the core would do something like:

if (policy->cpuinfo.transition_latency =3D=3D CPUFREQ_ETERNAL)
        policy->cpuinfo.transition_latency =3D
CPUFREQ_DEFAULT_TANSITION_LATENCY_NS;

but then it would be kind of more straightforward to update everybody
using CPUFREQ_ETERNAL to set cpuinfo.transition_latency to
CPUFREQ_DEFAULT_TANSITION_LATENCY_NS directly (and then get rid of
CPUFREQ_ETERNAL entirely).

> > Alternatively maybe we can add special handling for CPUFREQ_ETERNAL val=
ue,
> > though I'd suggest to return 1ms (similar to the case of value being 0)=
. Maybe
> > we can redefine CPUFREQ_ETERNAL to be 0, but not sure if this can have =
side
> > effects.
>
> Changing CPUFREQ_ETERNAL to 0 looks so risky to me.  What about adding
> an explicit check for CPUFREQ_ETERNAL?
>
> ---8<---
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index fc7eace8b65b..053f3a0288bc 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -549,11 +549,15 @@ unsigned int cpufreq_policy_transition_delay_us(str=
uct cpufreq_policy *policy)
>         if (policy->transition_delay_us)
>                 return policy->transition_delay_us;
>
> +       if (policy->cpuinfo.transition_latency =3D=3D CPUFREQ_ETERNAL)
> +               goto default_delay;

Can't USEC_PER_MSEC be just returned directly from here?

> +
>         latency =3D policy->cpuinfo.transition_latency / NSEC_PER_USEC;
>         if (latency)
>                 /* Give a 50% breathing room between updates */
>                 return latency + (latency >> 1);

Side note for self: The computation above can be done once at the
policy initialization time and transition_latency can be stored in us
(and only converted to ns when the corresponding sysfs attribute is
read).  It can be even set to USEC_PER_MSEC if zero.

> +default_delay:
>         return USEC_PER_MSEC;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);
>
> --->8---

