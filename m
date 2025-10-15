Return-Path: <linux-pm+bounces-36202-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4D0BDF4D7
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 17:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63A244F75B2
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949412F3C07;
	Wed, 15 Oct 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOTcC6WT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F984224AF7
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541426; cv=none; b=dIDXJ/CgQ8bIihXyELobMhSRM5KgapZTIAGTBvPxaAgbB1oLE7Ou60XQYQF39h7Ep4qukZVWvUM4i2F0a+jvFQpyeIy+mkZft5mawvcGWTPlbB42ijSuEpcQ9MXd2wVwaK+I/YE2Hcq0mms5LJ38vvUDJt81VceQuM9eJIWJQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541426; c=relaxed/simple;
	bh=b4q/upuIqsm3HCwj0XidMAB9eaJvKCEgDcHB7OpJZyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpBiylCEeA7nyQgYHTPls2PbA8AFnefFIJr82XtnvcqNlHVi3S4SHBEsU364BFwTAmMFyxWUStESg/SdTXqM4ie8VYTZU/vaKLHzc84/uYRY//YyWjEFmrTeVbhCR0Z/1wQrgDKMmt9SEBHdSMSsbfxFsItkLCBxVab3nTmQ26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOTcC6WT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9E7C4CEFB
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760541426;
	bh=b4q/upuIqsm3HCwj0XidMAB9eaJvKCEgDcHB7OpJZyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EOTcC6WTCfuDanq+Le8A6VEazsMqpYEQQZ6AqAqVMWPguN990lRcrNKbsNTBLBRmI
	 TZ+Ens8PQItgm+QDjs2US1NrAoscT5uaathpQct4WFPVVYUUc/nYJ14qeecYNkdgwf
	 XL3JdX6UQzjmvKfy47z+VS5GbQX1qBZVaek8kl8M3rk9Cc7jmdd1HdDz85uVnHXlSv
	 TqNzXPqVPe0Alw6pAE7BwjbDIJz6wtfZiYAMprsFjB0Z3CrFdSSia4NJjVqskVjS/u
	 QEY/4K03ohrDRSm963vqFZeCzUw8SGoolGb5PyxOvsRS5GGix+zHG1lrIrPrF9LS7e
	 LyK/BEQMLBtdw==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-44181f9e5b4so2850739b6e.0
        for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 08:17:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOOQTk/Wb5J8Su5pE0OTeyXGDP0M+2NtAEHyTH3P3Y98I9ujxMkfyiwhiNeAdRJOkmXAN8htNb1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Mbg9DVodzBgu8ShU3VwerpjLpECjw0JGrXngR8jTBlkgehvK
	rgZBvD8hp+Bw0H7g/VZPeXrtYP05A84wq703xRNVnGklIppM2SS7LT620caoYgD+qfX/hU56xbA
	cKgs8mWG8T15hRkgLcVSpVyXW96G6ucM=
X-Google-Smtp-Source: AGHT+IFMR58Qg/JZT+0QqdxB1ZxpdHOrnh0BlxNXsfE+P1hCi0YPQH3UQJy2ha1gwNqOZynA/x8g10IhdojMBdc4vj0=
X-Received: by 2002:a05:6808:11c6:b0:43f:afc9:b889 with SMTP id
 5614622812f47-4417b4080edmr12381872b6e.50.1760541425227; Wed, 15 Oct 2025
 08:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2404176.ElGaqSPkdT@rafael.j.wysocki> <3394529.aeNJFYEL58@rafael.j.wysocki>
 <012930da-7b24-4670-981b-f5eab98c93d7@arm.com>
In-Reply-To: <012930da-7b24-4670-981b-f5eab98c93d7@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Oct 2025 17:16:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gkE4i9VMfbwb9+F8KO+XecqXTis7atExbX3rfQvX2qOQ@mail.gmail.com>
X-Gm-Features: AS18NWB5NETBaQDarEqjk0RoAbuTxJZAHi-p2TS7pm66dP0UjULs3eAXiJgQKBQ
Message-ID: <CAJZ5v0gkE4i9VMfbwb9+F8KO+XecqXTis7atExbX3rfQvX2qOQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] cpufreq: intel_pstate: hybrid: Adjust energy model rules
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Yaxiong Tian <tianyaxiong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 5:13=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 10/15/25 14:48, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of using HWP-to-frequency scaling factors for computing cost
> > coefficients in the energy model used on hybrid systems, which is
> > fragile, rely on CPU type information that is easily accessible now and
> > the information on whether or not L3 cache is present for this purpose.
> >
> > This also allows the cost coefficients for P-cores to be adjusted so
> > that they start to be populated somewhat earlier (that is, before
> > E-cores are loaded up to their full capacity).
> >
> > In addition to the above, replace an inaccurate comment regarding the
> > reason why the freq value is added to the cost in hybrid_get_cost().
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c |   37 +++++++++++++++-----------------=
-----
> >  1 file changed, 15 insertions(+), 22 deletions(-)
> >
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -933,11 +933,8 @@ static int hybrid_active_power(struct de
> >                              unsigned long *freq)
> >  {
> >       /*
> > -      * Create "utilization bins" of 0-40%, 40%-60%, 60%-80%, and 80%-=
100%
> > -      * of the maximum capacity such that two CPUs of the same type wi=
ll be
> > -      * regarded as equally attractive if the utilization of each of t=
hem
> > -      * falls into the same bin, which should prevent tasks from being
> > -      * migrated between them too often.
> > +      * Create four "states" corresponding to 40%, 60%, 80%, and 100% =
of the
> > +      * full capacity.
> >        *
> >        * For this purpose, return the "frequency" of 2 for the first
> >        * performance level and otherwise leave the value set by the cal=
ler.
> > @@ -970,26 +967,22 @@ static bool hybrid_has_l3(unsigned int c
> >  static int hybrid_get_cost(struct device *dev, unsigned long freq,
> >                          unsigned long *cost)
> >  {
> > -     struct pstate_data *pstate =3D &all_cpu_data[dev->id]->pstate;
> > -
> > +     /* Facilitate load balancing between CPUs of the same type. */
> > +     *cost =3D freq;
> >       /*
> > -      * The smaller the perf-to-frequency scaling factor, the larger t=
he IPC
> > -      * ratio between the given CPU and the least capable CPU in the s=
ystem.
> > -      * Regard that IPC ratio as the primary cost component and assume=
 that
> > -      * the scaling factors for different CPU types will differ by at =
least
> > -      * 5% and they will not be above INTEL_PSTATE_CORE_SCALING.
> > +      * Adjust the cost depending on CPU type.
> >        *
> > -      * Add the freq value to the cost, so that the cost of running on=
 CPUs
> > -      * of the same type in different "utilization bins" is different.
> > -      */
> > -     *cost =3D div_u64(100ULL * INTEL_PSTATE_CORE_SCALING, pstate->sca=
ling) + freq;
> > -     /*
> > -      * Increase the cost slightly for CPUs able to access L3 to avoid
> > -      * touching it in case some other CPUs of the same type can do th=
e work
> > -      * without it.
> > +      * The idea is to start loading up LPE-cores before E-cores and s=
tart
> > +      * to populate E-cores when LPE-cores are utilized above 60% of t=
he
> > +      * capacity.  Similarly, P-cores start to be populated when E-cor=
es are
> > +      * utilized above 60% of the capacity.
> >        */
> > -     if (hybrid_has_l3(dev->id))
> > -             *cost +=3D 2;
> > +     if (hybrid_get_cpu_type(dev->id) =3D=3D INTEL_CPU_TYPE_ATOM) {
> > +             if (hybrid_has_l3(dev->id)) /* E-core */
> > +                     *cost +=3D 2;
> > +     } else { /* P-core */
> > +             *cost +=3D 4;
> > +     }
>
> Interesting, is there any reason in particular why you're looking to chan=
ge this?
> Is it just performance because of the extra headroom? (I recall that your=
 E-cores
> are always more efficient than your P-cores at comparable computing power=
).

Yes, it is performance mostly.

> How long does it take to trigger overutilized for you?

It depends, but sometimes it triggers really quickly due to LPE-core
load spikes.

> I still have the OU based on 'last idle time' observation patches lying a=
round,
> although I haven't found the time to do more extensive testing if it does=
n't
> regress some platform / workload combination. I will dust them off soon, =
although
> I'm not sure if they would help your case.
> Happy to try though if you had a particular workload in mind!

OK, good to know, thanks!

