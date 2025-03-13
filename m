Return-Path: <linux-pm+bounces-23995-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D85AA6000E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 19:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083503A9BCE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 18:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9891F03C2;
	Thu, 13 Mar 2025 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/wG2510"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E31531C5;
	Thu, 13 Mar 2025 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891851; cv=none; b=W/CxhHw/0N0E7E1Ji4hHP/O3FCKG2UtBsxz+XXVczqP5xGDxBbJzKgQvzWpLV184UZeoL760e1ksy87ac89QzlOHJhuLVg6m4vTPcTl5ffSstdOmSU+vZsROhc7LfJD+u+Xl4fUNeJHXt+Iq1nufKNZHLCc1Wc6QYBzT/Urpa3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891851; c=relaxed/simple;
	bh=wOmk2LDYhQbCJnXD67llNF+qbQsOwKFG1CXJpP8kogQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6UX13tf3e1/O786nA/ovKKfy0oPJ7p9cb7ot+MxYqNnKLo4Qo5qyu7BpIsigrSsq4xbaZLmQsJh3hTt7ifsrdYOdcU44rKo+jfm+5J5POVl7+LtxRrsbvk8CWfqWcCBNrn/l5ocI7UkFWMZW4oB+vJjaxAr7k0V/ggfZ32SamI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/wG2510; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CCBC4CEE3;
	Thu, 13 Mar 2025 18:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741891850;
	bh=wOmk2LDYhQbCJnXD67llNF+qbQsOwKFG1CXJpP8kogQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P/wG2510pSGVe3vmk+Np22K3hJype6nlIRoPWA++SjfwMGXz+M7DB+23CdGUyQwaY
	 TyzAWOl23Z/h3uNgWupzEstKMwdB14BgCitRsWaL0Gnz9hliZYE02rQO6jbVyROzCR
	 CtQIzFDN5lg/6Eq2cizH4Y6EjyB8YVHBABWwlG6j3Wx3hDcg2R1v70X87mlfZ+zt4g
	 5Y0gZef789uuW4NR0sFLY2zSORi7uHwMnX8HjZFj/byMqHfgKTHzTI1gBVqKUVU+5i
	 fVsiBVdGBZDhKys27I1zswi6VdEAvi+gV4GaJEzdpnb+HvsyO2aXVaozTzDB8xa7DG
	 MGWpgqRf0wuEQ==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f682a2c3c8so685609b6e.1;
        Thu, 13 Mar 2025 11:50:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWp4R/GhQaGyQ7cC6ezSX1LbNmutLHjKl6m24KYpudAbTr+zNqGlBzNTsjCY7L0KJSaHsDOczu76G4=@vger.kernel.org, AJvYcCXiUyGpLt3Qn9yf72aQk0chLAykBTr2kfqNQ2xiSFd7UaL85veC7S87ERyiPCtj3dZUGwQfPV29Aa5Ye+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsPXKvK0CnI6VXP9y0RgLlItPTV7+WUbOBdz56Xa0NsQnbVCYQ
	CdFkbGc+fXLlGh0TLocZadjAu8f9VUa8SLaNDaBMOkTafAaAlfJuKWpgD7CN/zSqsBIaIneVIhv
	BuHc++4I7PAqhOzyMlPXEJmkbkcI=
X-Google-Smtp-Source: AGHT+IGH7HtqwRS4eHXUymOx7wiwoh5XsHbMbmkNjEqwS7ZKOLQ5FH43VVXhEKixxxhGxJbuaKjDkS4IbwPBSmW1mzg=
X-Received: by 2002:a05:6808:148d:b0:3f8:1df6:413 with SMTP id
 5614622812f47-3fda15429f2mr491212b6e.1.1741891849972; Thu, 13 Mar 2025
 11:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22640172.EfDdHjke4D@rjwysocki.net> <2028801.yKVeVyVuyW@rjwysocki.net>
 <1411c47998e44f1509f91e83d0379775db3d4779.camel@linux.intel.com>
In-Reply-To: <1411c47998e44f1509f91e83d0379775db3d4779.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Mar 2025 19:50:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ghVNKKWbLnwhbriotbgtujy6_G0yiFm1PiCK2KyCPR+A@mail.gmail.com>
X-Gm-Features: AQ5f1JoJ-sAMGdDzTT2tNHTl5OTvg2Ur5mBrNphzDGgoFpqstqiSERAYNxXHiVI
Message-ID: <CAJZ5v0ghVNKKWbLnwhbriotbgtujy6_G0yiFm1PiCK2KyCPR+A@mail.gmail.com>
Subject: Re: [RFC][PATCH v0.3 6/6] cpufreq: intel_pstate: EAS support for
 hybrid platforms
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 7:46=E2=80=AFPM Tim Chen <tim.c.chen@linux.intel.co=
m> wrote:
>
> On Fri, 2025-03-07 at 20:42 +0100, Rafael J. Wysocki wrote:
> >
> >
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -44,6 +44,8 @@
> >  #define INTEL_CPUFREQ_TRANSITION_DELAY_HWP   5000
> >  #define INTEL_CPUFREQ_TRANSITION_DELAY               500
> >
> > +#define INTEL_PSTATE_CORE_SCALING            100000
> > +
>
> Minor nits.
>
> Suggest move the above define to
>
> #define HYBRID_SCALING_FACTOR_ADL       78741
> #define HYBRID_SCALING_FACTOR_MTL       80000
> #define HYBRID_SCALING_FACTOR_LNL       86957
> #define INTEL_PSTATE_CORE_SCALING       100000
>
> to keep the scaling factors at the same place.

It may be needed earlier, but I see your point.  Keeping them together
will make sense.

>
> > @@ -3425,6 +3539,8 @@
> >
> >               cpufreq_unregister_driver(intel_pstate_driver);
> >               intel_pstate_driver_cleanup();
> > +             /* Trigger EAS support reconfiguration in case it was use=
d. */
>
> May be clearer to say
>
>                 /* Disable EAS support in case it was used */

Sure.

> My first read of the comment thought that we are enabling EAS support.
>
> > +             rebuild_sched_domains_energy();
> >               return 0;
> >       }
> >
>
> Rest of patch looks good.

Thanks for the review!

