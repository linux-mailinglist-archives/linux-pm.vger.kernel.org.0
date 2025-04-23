Return-Path: <linux-pm+bounces-26052-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07990A98F45
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 17:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD573A7308
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 15:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D192828152F;
	Wed, 23 Apr 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pumysTh4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D81EFFB9;
	Wed, 23 Apr 2025 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420382; cv=none; b=u51nUI0kx/SS0+IxUNkoiMtbw5CtEGS2+L4c77NG6IVVOR00ioqq+eJkb2+VDxkO+sy0t8jEE9XdyemhiNp1wGMrfgD1mX6p9UKfp7PzwLJ+Pw8ySE8Jeh2jgBtOjqzOKPGApJ/4Jd6PPgoNIaNgKCoq0h+HolZjIvzQQH4dVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420382; c=relaxed/simple;
	bh=PI9alPs7eZbWTU2ubwZMmiT0X340KjFzyFfxau0rlks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h21z6ijHRz6ADsWXIkR4M2C0zid3ZbJzG8rh+aMXB6wbsxBFgT79Sl9jM1/HDwmk4SxKeXvgK/BJNqPz/qf9LbLW6aXixeSeJ8dUHO0rD1NtZ2em6a8EzwArZtV3UiorsJOknx64O934UMNfe/XMbuBcEJdNjzHxut1uDgK2i3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pumysTh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED00C4CEEC;
	Wed, 23 Apr 2025 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745420382;
	bh=PI9alPs7eZbWTU2ubwZMmiT0X340KjFzyFfxau0rlks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pumysTh4Dl3MCG4w6e6jhckG9aTlSsq9hPf30c+A43MaI3eKD1hCNW2i7TAWt0CC4
	 oMlXo9avL8TnRXkaOqvSEBK+oQYKqm/vyfi2FJMRdRcrbPbGHwZTg1yFUscerHMDw/
	 9IdDRFbHTk0xn66aSPocNw85eFiUALnpcekcRp7j90biAAtD7uTGchcZuv2jLqO2/l
	 zXhuiFsL0nPA951K4UNXZSHhAV6+mw4WTPY0HJa93zjvHyBAIR5Il+9vKRN2VvVcS2
	 tOLMaGEl30n8Kma0N+pSrMZach5hx+36fVbZs12O1n0dNQNEcU9d1liuByNj2/74Pv
	 8qDmaHVpYID6A==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2d4f832069cso2801494fac.0;
        Wed, 23 Apr 2025 07:59:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/TpzP9HITFyZYAEA+wgjnJbGlPiZrvzzzvQihdZWbiV71k6M0SdX6/AvxM606ZjdHHabIKcL6CZqmNHw=@vger.kernel.org, AJvYcCUNomdNEkEJrYQd4kQDKMz5kaSLO03KIR0e29AnKIVpluEwRVM4S+K3RhwiamX75pyizYyCN2b3duk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp1OCCsbU58Cl8e1DOc9dkp+V92RojkMactuJ/pDkzsuXvCABk
	FUnSQgwav9/dhtIafUk2B14mq0dWdBvAHE7jgP8ayQj9QFQ9vtFaY1ZLUJjKwGALCQGZVAdkpw3
	wJT6t91KUZHg77lCRNrWCT+/YE1s=
X-Google-Smtp-Source: AGHT+IEi4b7GkXDMLFgoprp2YCPSMHwdAOZRnIFz87Hu+GggCSafcOFLaFGD1MB7vwWbMLs0d2tQUBD3ooEv+xqymhY=
X-Received: by 2002:a05:6871:331e:b0:2c2:174b:c829 with SMTP id
 586e51a60fabf-2d526a4d2aamr10234856fac.15.1745420381757; Wed, 23 Apr 2025
 07:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745315548.git.viresh.kumar@linaro.org> <d8651db6d8687a0e37d527267ebfec05f209b1b7.1745315548.git.viresh.kumar@linaro.org>
 <CAJZ5v0hWUdRdbPL2=qybaEsNfPzAqdxW+xBrjwy4HaBXnTwD0g@mail.gmail.com> <CAJZ5v0jFy9ch4ZcW_zQs6GfvB=LCnzm94d35ifMpdv=VrqTHQA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jFy9ch4ZcW_zQs6GfvB=LCnzm94d35ifMpdv=VrqTHQA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 23 Apr 2025 16:59:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jenM_pYUkTv-qPV21tok15R+KfT497itPO=fLUywDKqw@mail.gmail.com>
X-Gm-Features: ATxdqUE34QXILGElk2qzcKZx9l4Vl8xqq63yauPDLify1DF26yZwrRlMqFVYrS4
Message-ID: <CAJZ5v0jenM_pYUkTv-qPV21tok15R+KfT497itPO=fLUywDKqw@mail.gmail.com>
Subject: Re: [PATCH 2/6] cpufreq: acpi: Re-sync CPU boost state on system resume
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Nicholas Chin <nic.c3.14@gmail.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 4:40=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Apr 23, 2025 at 4:26=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Tue, Apr 22, 2025 at 11:54=E2=80=AFAM Viresh Kumar <viresh.kumar@lin=
aro.org> wrote:
> > >
> > > During suspend/resume cycles, platform firmware may alter the CPU boo=
st
> > > state.
> > >
> > > If boost is disabled before suspend, it correctly remains off after
> > > resume. However, if firmware re-enables boost during suspend, the sys=
tem
> > > may resume with boost frequencies enabled=E2=80=94even when the boost=
 flag was
> > > originally disabled. This violates expected behavior.
> > >
> > > Ensure the boost state is re-synchronized with the kernel policy duri=
ng
> > > system resume to maintain consistency.
> > >
> > > Fixes: 2b16c631832d ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq=
_cpu_init()")
> > > Reported-by: Nicholas Chin <nic.c3.14@gmail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220013
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > >  drivers/cpufreq/acpi-cpufreq.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cp=
ufreq.c
> > > index 7002e8de8098..0ffabf740ff5 100644
> > > --- a/drivers/cpufreq/acpi-cpufreq.c
> > > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > > @@ -893,8 +893,19 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_=
policy *policy)
> > >         if (perf->states[0].core_frequency * 1000 !=3D freq_table[0].=
frequency)
> > >                 pr_warn(FW_WARN "P-state 0 is not max freq\n");
> > >
> > > -       if (acpi_cpufreq_driver.set_boost)
> > > -               policy->boost_supported =3D true;
> > > +       if (acpi_cpufreq_driver.set_boost) {
> > > +               if (policy->boost_supported) {
> > > +                       /*
> > > +                        * The firmware may have altered boost state =
while the
> > > +                        * CPU was offline (for example during a susp=
end-resume
> > > +                        * cycle).
> > > +                        */
> > > +                       if (policy->boost_enabled !=3D boost_state(cp=
u))
> > > +                               set_boost(policy, policy->boost_enabl=
ed);
> > > +               } else {
> > > +                       policy->boost_supported =3D true;
> >
> > IIUC policy->boost_enabled is false at this point, so say that
> > boost_state(cpu) returns true and say cpufreq_boost_enabled() returns
> > false.
>
> This cannot happen for CPU 0 because of acpi_cpufreq_boost_init() ->
>
> > cpufreq_online() will see policy->boost_enabled =3D=3D
> > cpufreq_boost_enabled(), so it won't do anything regarding boost, and
> > say that this happens for all online CPUs.
>
> -> so if boost_state(0) returns true, policy->boost_enabled will be
> set for all policies to start with due to the code in
> cpufreq_online(), but this is far from obvious.
>
> I would at least say in the changelog that set_boost() need not be
> called directly at the policy initialization time because of the
> above.

I also think that acpi_cpufreq_resume() may be a better place for
re-syncing the boost state with policy->boost_enabled because it may
do that for CPU 0 as well as for the non-boot CPUs.

