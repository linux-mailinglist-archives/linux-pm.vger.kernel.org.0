Return-Path: <linux-pm+bounces-36235-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF76EBE288B
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 11:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51916351C28
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C25D3277A9;
	Thu, 16 Oct 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmX/S44e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1EB326D77
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608357; cv=none; b=BiVAs98vCxus9TM7KCoUgJxQ5OBAiThx4QSi7gnPzQ2tSvFd1GV9zeQOicMVJ54pBbPkovLX45A52nP7hg2Z4bmKcaY6JOk+YnY7lW9T0Yj3O+xbnTH5GLLjW+1KtcLuEMNJHSjs11OGyia66WL2Gp0L/TU3MoXxFie5/YqK/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608357; c=relaxed/simple;
	bh=NZq77HFZD20VILf0AyJ5tjTga2D94ZLlRW5jpJXb/R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDLPZeLu2KkSS2sOWwECIUOOXab/LEdAUvR9sdRNlPktJyoalB7oqYjjVFgO5OLPn1U4jqBmtAvSnUll5r3HQDhYXCKHcULATG/ISwqJJCDxTmYl2tEM9RyFmNUQFgpe2/7zw7SBG+2K9r/iMZc2ZdUL7J4T0uZLKj7SE5fNM6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmX/S44e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF60CC4CEF9
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 09:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760608356;
	bh=NZq77HFZD20VILf0AyJ5tjTga2D94ZLlRW5jpJXb/R0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jmX/S44ekOViTNCTeINKfD7UxTFESGVL+FxIck7g5JWoBPj5xLZN+xNlU68fRQ4ZN
	 cPEY//ewooYEwy1lnqqh0EAuf0n2BRHs1SVLnHYOELqVipw7ppL00ol8ZHI7aoaqOC
	 aqyoN3D5PbLz8bd/vicMcbWTgMDK7IXNO0/h7bxxArFggFVt9hUuQOu8T31kh3Uo4U
	 4T5iQiozCXH8oIZY5x1U/8JgT11pFcpx5Vv/s2aWxqb09G7EEy0xbfC8aiKQQHSZwd
	 sXRVK3MfADDAEnpfN8Sb0oLTUlOmslTMhOdtOFvgHfiUXXaAoZFg88DtF+Ep/k3gKh
	 9ZN146nBVEVGA==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7b6d6a1e4e4so329830a34.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 02:52:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdKyeUnKPyQeQFL0E6xMLUIqX/6EG/XbBUty2H6kaPOFtpeHiJgQjQX6tMQWff+CPm+fNfFlYEyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK7Y22wqGInsu+ZnGuCg72zbI9FeoTuqTrenpI/8r0m+EmzU+S
	0qGlBdVyMD/dSJ3GxF9WW1SucwvZfAG64a0/atXeBqI2xPGkl8aIPzkZzg1cq48g90oNOu0u0ko
	Em0uQFxH57U6Czf1ONPDFAM3ILiwPXto=
X-Google-Smtp-Source: AGHT+IFIOaY5cMCN8dH+Jk11CimFFk7TIWnyxWKiWeryJcloGMVroLTVkhTqydgzGuh51Mk0UCE5+92V+dq1ygEnwOg=
X-Received: by 2002:a05:6808:5386:b0:441:8f74:f1d with SMTP id
 5614622812f47-4418f741bdbmr12511218b6e.55.1760608356179; Thu, 16 Oct 2025
 02:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3394529.aeNJFYEL58@rafael.j.wysocki> <20251016074849.1046580-1-tianyaxiong@kylinos.cn>
 <f48b80d5-0098-424d-9a7c-ae07017ab2bb@arm.com>
In-Reply-To: <f48b80d5-0098-424d-9a7c-ae07017ab2bb@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 Oct 2025 11:52:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gyGsTdJ+up-peX5_ggF-YKPep1j0uG6zRGn9UKiHA-KQ@mail.gmail.com>
X-Gm-Features: AS18NWBzrQKZ2xx_RsJlHjfpVp_38BOqEDjd4UwAt6g1GuPAcpajZCuz_AHU85c
Message-ID: <CAJZ5v0gyGsTdJ+up-peX5_ggF-YKPep1j0uG6zRGn9UKiHA-KQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] cpufreq: intel_pstate: hybrid: Adjust energy model rules
To: Christian Loehle <christian.loehle@arm.com>
Cc: Yaxiong Tian <tianyaxiong@kylinos.cn>, rafael@kernel.org, dietmar.eggemann@arm.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 11:00=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 10/16/25 08:48, Yaxiong Tian wrote:
> > =E5=9C=A8 2025/10/15 21:48, Rafael J. Wysocki =E5=86=99=E9=81=93:> From=
: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Instead of using HWP-to-frequency scaling factors for computing cost
> >> coefficients in the energy model used on hybrid systems, which is
> >> fragile, rely on CPU type information that is easily accessible now an=
d
> >> the information on whether or not L3 cache is present for this purpose=
.
> >>
> >> This also allows the cost coefficients for P-cores to be adjusted so
> >> that they start to be populated somewhat earlier (that is, before
> >> E-cores are loaded up to their full capacity).
> >>
> >> In addition to the above, replace an inaccurate comment regarding the
> >> reason why the freq value is added to the cost in hybrid_get_cost().
> >>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> ---
> >>   drivers/cpufreq/intel_pstate.c |   37 +++++++++++++++---------------=
-------
> >>   1 file changed, 15 insertions(+), 22 deletions(-)
> >>
> >> --- a/drivers/cpufreq/intel_pstate.c
> >> +++ b/drivers/cpufreq/intel_pstate.c
> >> @@ -933,11 +933,8 @@ static int hybrid_active_power(struct de
> >>                             unsigned long *freq)
> >>   {
> >>      /*
> >> -     * Create "utilization bins" of 0-40%, 40%-60%, 60%-80%, and 80%-=
100%
> >> -     * of the maximum capacity such that two CPUs of the same type wi=
ll be
> >> -     * regarded as equally attractive if the utilization of each of t=
hem
> >> -     * falls into the same bin, which should prevent tasks from being
> >> -     * migrated between them too often.
> >> +     * Create four "states" corresponding to 40%, 60%, 80%, and 100% =
of the
> >> +     * full capacity.
> >>       *
> >>       * For this purpose, return the "frequency" of 2 for the first
> >>       * performance level and otherwise leave the value set by the cal=
ler.
> >> @@ -970,26 +967,22 @@ static bool hybrid_has_l3(unsigned int c
> >>   static int hybrid_get_cost(struct device *dev, unsigned long freq,
> >>                         unsigned long *cost)
> >>   {
> >> -    struct pstate_data *pstate =3D &all_cpu_data[dev->id]->pstate;
> >> -
> >> +    /* Facilitate load balancing between CPUs of the same type. */
> >> +    *cost =3D freq;
> >>      /*
> >> -     * The smaller the perf-to-frequency scaling factor, the larger t=
he IPC
> >> -     * ratio between the given CPU and the least capable CPU in the s=
ystem.
> >> -     * Regard that IPC ratio as the primary cost component and assume=
 that
> >> -     * the scaling factors for different CPU types will differ by at =
least
> >> -     * 5% and they will not be above INTEL_PSTATE_CORE_SCALING.
> >> +     * Adjust the cost depending on CPU type.
> >>       *
> >> -     * Add the freq value to the cost, so that the cost of running on=
 CPUs
> >> -     * of the same type in different "utilization bins" is different.
> >> -     */
> >> -    *cost =3D div_u64(100ULL * INTEL_PSTATE_CORE_SCALING, pstate->sca=
ling) + freq;
> >> -    /*
> >> -     * Increase the cost slightly for CPUs able to access L3 to avoid
> >> -     * touching it in case some other CPUs of the same type can do th=
e work
> >> -     * without it.
> >> +     * The idea is to start loading up LPE-cores before E-cores and s=
tart
> >> +     * to populate E-cores when LPE-cores are utilized above 60% of t=
he
> >> +     * capacity.  Similarly, P-cores start to be populated when E-cor=
es are
> >> +     * utilized above 60% of the capacity.
> >>       */
> >> -    if (hybrid_has_l3(dev->id))
> >> -            *cost +=3D 2;
> >> +    if (hybrid_get_cpu_type(dev->id) =3D=3D INTEL_CPU_TYPE_ATOM) {
> >> +            if (hybrid_has_l3(dev->id)) /* E-core */
> >> +                    *cost +=3D 2;
> >> +    } else { /* P-core */
> >> +            *cost +=3D 4;
> >> +    }
> >>
> >>      return 0;
> >>   }
> >
> > Hi Rafael J. Wysocki:
> >
> > Is the increment of this cost for different types of CPUs by one instea=
d
> > of two?
> >
> > cost by increment of 2:
> >           0~40%  40%~60%  60%~80% 80%~100
> > LPE-core    2       3        4      5
> > E-core      4       5        6      7
> > P-core      6       7        8      9
> >
> > So, tasks only start being allocated to more powerful CPUs when
> > utilization exceeds 80%, but by that point the system is already in an
> >  overloaded state.
> >
> > cost by increment of 1:
> >           0~40%  40%~60%  60%~80% 80%~100
> > LPE-core    2       3        4      5
> > E-core      3       4        5      6
> > P-core      4       5        6      7
> >
> > This situation aligns with the description in your patch.
> >
> > The idea of this patch looks good to me.
>
> Agreed if you want the threshold to be 60% for both it should be +1 for l=
3
> and +2 for P-core.
> Good catch!

OK, I'll send an update of this patch then, but I won't resend the
first two patches in the series.  I don't think that they are
objectionable.

