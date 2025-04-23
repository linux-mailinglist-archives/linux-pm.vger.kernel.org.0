Return-Path: <linux-pm+bounces-26051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA88A98D58
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 16:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3498E3A8668
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1541127F73E;
	Wed, 23 Apr 2025 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtxE8g1/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE13827F4F5;
	Wed, 23 Apr 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419220; cv=none; b=WOFulfxmN55nz0/CKlmhfL8KumskDgebDjHdI8UlKHutiT3Ds/+OSM7nV10UKt5MrLJfurTjq8MAPc/R+X9m4bxgmQfi0jmcXmXDTUGMelGIR9szqnDuUxD1oINz1uZfujOqF1o3DoKLtE6isjLBPoO/fW7BE45Hb9DZtsv+OTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419220; c=relaxed/simple;
	bh=iWJGqy5H8iXR0YJhyJq2G9sNh+8Y6FpC+938zCMyJgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyKxkyxWqEVoRVHNe6fiYEW0ZKXjpuKTftlnLIreFsvD7U7CR5wVXb1pH2qCzsK5VKbweIlp/tR6Q3pfYejDFvgVsYztA14XTZqr2LIvNRqOB0r+wFK5vtwdOWpS6aIPfEgDKpF9x61DDx7pi7PJSolu/kagUDEUphMFrkrz5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtxE8g1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5D9C4CEE3;
	Wed, 23 Apr 2025 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745419216;
	bh=iWJGqy5H8iXR0YJhyJq2G9sNh+8Y6FpC+938zCMyJgk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jtxE8g1/oO5hR38F+CxvLKzuPXsrTsXFSjtXjOmhsuQpnORR0N0qKVCeudDprn8S/
	 64XFFZ6mioK/MaFpSeWRh3zYPe0BLKpeXA9TYa4EcGslM0aSeokG+LwbUye2GpW6pf
	 TlLaEofHu4xlutfGRrMrGu3mLg1OddhqfYA1pu8ghaRUu6se8jTvbyNfYZARU46BBb
	 hPXQZ0GtjE86uFYAwnCL8qQKid5bIRqsEGMfb3MugVQZzaLQyOriTbt/BuqrYRfj1A
	 5WJBT/IG3RU75krKLreG1j3aFd7rugC2Dqi0OqbgDwOZXcUnYIyLnPv74ckfFXy8Tn
	 j9L8RGpDqc83g==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c7f876b320so4224060fac.1;
        Wed, 23 Apr 2025 07:40:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpiBUkOY/kDV6paIaeVuZ2VTGONDfpxfOcoX4ujbtRiuGQn6fcr2b5DiJj26Zsi3z+oOovRJoYlrw=@vger.kernel.org, AJvYcCVuFeXYbcNdIjji481UM14gEVnBnFbYWhnSyqjFxwz7tPgaY4/7s2vd0H9bun34IX9UMZS+TYFVp672juY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/ef977zCJcD4vC//RXV/xPdBxdRoIzbdcvCAxgCqJAvz0/QZ
	BYJfuf9UA8/esA7vaZRo6bXRaEoIk/WyQuLmKwLZJu/w4lp4uO6Rx7IJw3pAL080v1bI9/fOgWY
	AsIvy7r3e+DZQGf5yHjY1pl2Kr1M=
X-Google-Smtp-Source: AGHT+IH373maOnOzxY9wLz+CtIc4yR18PpNCKS0Q8+anv8KfyRwem1tB6xnC+r0+MOhz10gEPXdffKy/zMvBdXncw9Y=
X-Received: by 2002:a05:6870:eca2:b0:29e:2594:81e with SMTP id
 586e51a60fabf-2d526a2e955mr10845257fac.13.1745419215687; Wed, 23 Apr 2025
 07:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745315548.git.viresh.kumar@linaro.org> <d8651db6d8687a0e37d527267ebfec05f209b1b7.1745315548.git.viresh.kumar@linaro.org>
 <CAJZ5v0hWUdRdbPL2=qybaEsNfPzAqdxW+xBrjwy4HaBXnTwD0g@mail.gmail.com>
In-Reply-To: <CAJZ5v0hWUdRdbPL2=qybaEsNfPzAqdxW+xBrjwy4HaBXnTwD0g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Apr 2025 16:40:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jFy9ch4ZcW_zQs6GfvB=LCnzm94d35ifMpdv=VrqTHQA@mail.gmail.com>
X-Gm-Features: ATxdqUHlWTde2s4t2St_YDL0Wj7nuiDZM0S4dXLseFALgsWoHYbklbzMAhY56ks
Message-ID: <CAJZ5v0jFy9ch4ZcW_zQs6GfvB=LCnzm94d35ifMpdv=VrqTHQA@mail.gmail.com>
Subject: Re: [PATCH 2/6] cpufreq: acpi: Re-sync CPU boost state on system resume
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Nicholas Chin <nic.c3.14@gmail.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 4:26=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Apr 22, 2025 at 11:54=E2=80=AFAM Viresh Kumar <viresh.kumar@linar=
o.org> wrote:
> >
> > During suspend/resume cycles, platform firmware may alter the CPU boost
> > state.
> >
> > If boost is disabled before suspend, it correctly remains off after
> > resume. However, if firmware re-enables boost during suspend, the syste=
m
> > may resume with boost frequencies enabled=E2=80=94even when the boost f=
lag was
> > originally disabled. This violates expected behavior.
> >
> > Ensure the boost state is re-synchronized with the kernel policy during
> > system resume to maintain consistency.
> >
> > Fixes: 2b16c631832d ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_c=
pu_init()")
> > Reported-by: Nicholas Chin <nic.c3.14@gmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220013
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpuf=
req.c
> > index 7002e8de8098..0ffabf740ff5 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -893,8 +893,19 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_po=
licy *policy)
> >         if (perf->states[0].core_frequency * 1000 !=3D freq_table[0].fr=
equency)
> >                 pr_warn(FW_WARN "P-state 0 is not max freq\n");
> >
> > -       if (acpi_cpufreq_driver.set_boost)
> > -               policy->boost_supported =3D true;
> > +       if (acpi_cpufreq_driver.set_boost) {
> > +               if (policy->boost_supported) {
> > +                       /*
> > +                        * The firmware may have altered boost state wh=
ile the
> > +                        * CPU was offline (for example during a suspen=
d-resume
> > +                        * cycle).
> > +                        */
> > +                       if (policy->boost_enabled !=3D boost_state(cpu)=
)
> > +                               set_boost(policy, policy->boost_enabled=
);
> > +               } else {
> > +                       policy->boost_supported =3D true;
>
> IIUC policy->boost_enabled is false at this point, so say that
> boost_state(cpu) returns true and say cpufreq_boost_enabled() returns
> false.

This cannot happen for CPU 0 because of acpi_cpufreq_boost_init() ->

> cpufreq_online() will see policy->boost_enabled =3D=3D
> cpufreq_boost_enabled(), so it won't do anything regarding boost, and
> say that this happens for all online CPUs.

-> so if boost_state(0) returns true, policy->boost_enabled will be
set for all policies to start with due to the code in
cpufreq_online(), but this is far from obvious.

I would at least say in the changelog that set_boost() need not be
called directly at the policy initialization time because of the
above.

