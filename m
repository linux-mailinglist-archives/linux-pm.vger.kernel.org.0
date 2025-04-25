Return-Path: <linux-pm+bounces-26259-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97572A9D440
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 23:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0687AFDE2
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 21:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA79227BAD;
	Fri, 25 Apr 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rv7JzYDM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92042225779;
	Fri, 25 Apr 2025 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617201; cv=none; b=TQhlT4KAHV3EOCP5qYP0smmVcBOaPJL52NCR+qQo0GPcD7gNUiOzsQNxp6bRx1otPgYwuzXA403CQKSVVbfRqXZUu/SmaIyuHJJ8EPcEM2woDJqVGIvDHLg/cyzG7I+Kz9ksrjKb94DXtNS/7RpAlp9SmcqvFSr+O176Mu6RMxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617201; c=relaxed/simple;
	bh=gpEjCaRQAeZ4xN2QXu04ciaWVtO8D/BOtpyF745Ope0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPmFsdvcrtLBJ0SAhq+9lZs4k60Uv3dlO44iVOce5JWK4XCYxbFYXro4Ikz/CxxmsUAi5OEkhE6ZL3/xBG0AjexuAUnK8C+bKKaa0ShuDHB0DZEAAWZmBXR8MjtAgR+VMWUErhUN6nbhlH6YZhcgRApbz3esfDq6qYNWs5ZW+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rv7JzYDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71009C4CEEE;
	Fri, 25 Apr 2025 21:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745617201;
	bh=gpEjCaRQAeZ4xN2QXu04ciaWVtO8D/BOtpyF745Ope0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rv7JzYDMADbddJKQpQPNdj/yCvWSTJJ4CV3A/h0Lh77pJm3MiYRY/rE53GjO5QM27
	 hr0HHCiUDrO3NNOs0aRWuQoBnv4FYiTinIAHGJvR4CsbCmY/xlraXldx7sRtmBDSSj
	 DCf1X5DFE4/koSPmuEnXsk9ApgHIJxHienuM7w0FJOXEg8p384hJMw7q4T4fcsEkkE
	 73wepkAfUYVc+FNAfQ2MIZkEugoiHsc8rVYplO0xXcLBU7kVDF/sMdqtk4sMT/Y5tr
	 i6lU8g4TAMFx/HcKt4w0H4dA+jj6iF28LgH/m9dVPEpzM/65QM3M8saKRD78XqLlC6
	 F8HHgkQyvqbnA==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3fa6c54cc1aso2063504b6e.1;
        Fri, 25 Apr 2025 14:40:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXA9hqGEVXjPRhx1OR9QBz2Ez0GijJ8DEHdAs5n7jk/o6hn6PifYEcy65g9VVRQbNaJ7tBTzqJKdYqIw7k=@vger.kernel.org, AJvYcCXw9o6Q1uaWR2ULKi/0jA/QwutOx/LjcU9KeJKPEKUg1GZnnb7iUbxChk4mLZhHb1Q7vcs8lceu8Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ACdIOzwqA5HIRRO2sZi2ZOul4smPwq4RUGev3R9rfrcQcbq1
	6oqmUwk3DKnP/g25s4FOc1nbPy34bi2bozvMNIId4Inkf/gKgh8KXpNVmDbB5clz4p/bpKgENfA
	ZT/8UFdCDitY4NTNW+AyiLKL+fqk=
X-Google-Smtp-Source: AGHT+IEsffxvzq9Yr0/TB+vgHWzntwUD/rbIhUb17/qPQ3R6onl2Y6tmBGAUOYjZgUCXM6MsgXDHEc83j3KOHFY9CAk=
X-Received: by 2002:a05:6808:2512:b0:3fa:d6d4:8160 with SMTP id
 5614622812f47-401f289418cmr2583961b6e.10.1745617200762; Fri, 25 Apr 2025
 14:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3344336.aeNJFYEL58@rjwysocki.net> <47159248.fMDQidcC6G@rjwysocki.net>
 <1c6b70d1-279c-4d9d-ae31-2751daed04f6@arm.com>
In-Reply-To: <1c6b70d1-279c-4d9d-ae31-2751daed04f6@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 25 Apr 2025 23:39:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iFD3FddYTiOwSJ3uAz8mduh134WE2U8spfJtBs4At6Pw@mail.gmail.com>
X-Gm-Features: ATxdqUF9mvv7igZMHI0jECB6e_wqgQfhBYsX95BGLNNQhV1xaEQdyY_JC5sdlMI
Message-ID: <CAJZ5v0iFD3FddYTiOwSJ3uAz8mduh134WE2U8spfJtBs4At6Pw@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 8/8] cpufreq: intel_pstate: EAS: Increase cost for
 CPUs using L3 cache
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 11:32=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 4/16/25 19:12, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > On some hybrid platforms some efficient CPUs (E-cores) are not connecte=
d
> > to the L3 cache, but there are no other differences between them and th=
e
> > other E-cores that use L3.  In that case, it is generally more efficien=
t
> > to run "light" workloads on the E-cores that do not use L3 and allow al=
l
> > of the cores using L3, including P-cores, to go into idle states.
> >
> > For this reason, slightly increase the cost for all CPUs sharing the L3
> > cache to make EAS prefer CPUs that do not use it to the other CPUs with
> > the same perf-to-frequency scaling factor (if any).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c |    8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -979,6 +979,7 @@
> >                          unsigned long *cost)
> >  {
> >       struct pstate_data *pstate =3D &all_cpu_data[dev->id]->pstate;
> > +     struct cpu_cacheinfo *cacheinfo =3D get_cpu_cacheinfo(dev->id);
> >
> >       /*
> >        * The smaller the perf-to-frequency scaling factor, the larger t=
he IPC
> > @@ -991,6 +992,13 @@
> >        * of the same type in different "utilization bins" is different.
> >        */
> >       *cost =3D div_u64(100ULL * INTEL_PSTATE_CORE_SCALING, pstate->sca=
ling) + freq;
> > +     /*
> > +      * Inrease the cost slightly for CPUs able to access L3 to avoid =
litting
>
> s/Inrease/Increase
> and I guess s/litting/littering
>
> > +      * it up too eagerly in case some other CPUs of the same type can=
not
> > +      * access it.
> > +      */
> > +     if (cacheinfo->num_levels >=3D 3)

This check actually doesn't work on Intel processors, I have a
replacement patch for this one.

> > +             (*cost)++;
>
> This makes cost(OPP1) of the SoC Tile e-core as expensive as cost(OPP0) o=
f a
> normal e-core.

If "a normal Ecore" is one using L3, then yes.

> Is that the intended behaviour?

Yes, it is.  I wanted the Ecores on L3 to appear somewhat more
expensive, but not too much.

It looks like *cost +=3D 2 would work better, though.

