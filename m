Return-Path: <linux-pm+bounces-7893-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 722A18C7313
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 10:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AD11F22723
	for <lists+linux-pm@lfdr.de>; Thu, 16 May 2024 08:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CD114290E;
	Thu, 16 May 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbFaGmCI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96941420BB;
	Thu, 16 May 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848950; cv=none; b=Wa8pVH/byg4/P1cJc3Vk6tiRvf5dggoq538bGMNq/eWe3Mf+QtB2cS2nESOU0zuWpuOIi46fWygE7lVMQQ6k/iiUd+MNxbSEHpCzusxXuLHRQM1AYIHi2kJipzJCB9CxwgUMVda2oszGb+UPGnGhZJrPPuJlWUIqlDoI9miY+VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848950; c=relaxed/simple;
	bh=3ZpZsR6/16+tn0TZWLuuwEPsrm0WVS4oOlmAnDVesfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dr290ScjjIiS2z9yRnR8R3Lkva8lvtJd8gRF+QUNQK4pv32LvBBhxUQjZMd5XuctIOD38kfeahH+RsM1x9UoLk8Wgeix472kdMlC0PjMZFcV7ovfhWNQPw+/pK38pB2pbqs63lKTOI8uzSkoOvt4M/DCrxqOQ8tF+w0qrapJAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbFaGmCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE4BC4AF07;
	Thu, 16 May 2024 08:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715848950;
	bh=3ZpZsR6/16+tn0TZWLuuwEPsrm0WVS4oOlmAnDVesfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GbFaGmCIjgOPOkG9toXL3AQ6m2KofRDe2JjF+zw3SS9ZFffhRJ2Q2QBy6LWz+oBGd
	 UeOFPH6SFG8s8t/RuyJtn9hF8+D80pEhuLqWNv6V/9yXK0aLj7u12Cis74jBiGFthM
	 OErxTztBFxC6WP7+9DnaWpGJ3nr0aPozlz8XBWGbtHdh4PfECI1eWW3ZKT4R+Lrr6i
	 ymvQJ2dueGHXZU4hkVdCjniNxS8KcL3JpzxjcDsPkFFQvOAZCKNPGYPzu2bZ/029Jc
	 54R+ZLm7XWA9ZAHMHLrIPOiHYDM5pcN6f+Hie96I5zMZzQxPfH68cXr8dfbK7cO5Qi
	 YQsz/0VxSXtfg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ac970dded6so784451eaf.0;
        Thu, 16 May 2024 01:42:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZS+7xWu+7eMEKgCRZTYZGlRTWveTzQmpuHnwRkOgVpKAzD5icKrM6rnWI2XBVVBvKgP9gElbOlvpK6Ceus/j8VQ+Ye35Dlu6zWqvW8GCmDfWcF7r0BYDQTORZ3qaMeAYqjVe1CY0=
X-Gm-Message-State: AOJu0Yy2pL1fV7RcAqAglW1Vg80PB/Yo3l6a/g+Xq7j4gV6EoCwGdF7y
	j/Ty+CL9To3vrqErnrYZfI0A+ZsIeEhDpzsnTosRuiqlltXOidVH170Sfctuy17zbzul2PUbuCP
	XrtMsRCBzn/+qIQS61Sm58jx/DJU=
X-Google-Smtp-Source: AGHT+IFVqRk/Q7FVPniA7J+O/Coz6lel+XjmqUxUokxKOzC/Wi4yTOwKqHNhbs4ieQPijRuGYUwRcvEcXkBOWVIUbck=
X-Received: by 2002:a05:6871:5b18:b0:23e:5301:4348 with SMTP id
 586e51a60fabf-241732f6ca1mr20444031fac.5.1715848949574; Thu, 16 May 2024
 01:42:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR01MB5120A03DFF0EA1CE70E7334E92ED2@PUZPR01MB5120.apcprd01.prod.exchangelabs.com>
 <CYYPR12MB86551771F1670A5F9EAC47859CED2@CYYPR12MB8655.namprd12.prod.outlook.com>
In-Reply-To: <CYYPR12MB86551771F1670A5F9EAC47859CED2@CYYPR12MB8655.namprd12.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 May 2024 10:42:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gqTnj4Dk844gMMG+rnBvbpA_dGErghTM1PokaDScdBSQ@mail.gmail.com>
Message-ID: <CAJZ5v0gqTnj4Dk844gMMG+rnBvbpA_dGErghTM1PokaDScdBSQ@mail.gmail.com>
Subject: Re: [PATCH v4] cpufreq: amd-pstate: fix the memory to free after epp exist
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "zhida312@outlook.com" <zhida312@outlook.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, 
	Peng Ma <andypma@tencent.com>, "Huang, Ray" <Ray.Huang@amd.com>, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 10:28=E2=80=AFAM Yuan, Perry <Perry.Yuan@amd.com> w=
rote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: zhida312@outlook.com <zhida312@outlook.com>
> > Sent: Thursday, May 16, 2024 2:31 PM
> > To: rafael@kernel.org; viresh.kumar@linaro.org
> > Cc: Peng Ma <andypma@tencent.com>; Huang, Ray <Ray.Huang@amd.com>;
> > Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; linux-
> > pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH v4] cpufreq: amd-pstate: fix the memory to free after e=
pp
> > exist
> >
> > From: andypma <andypma.tencent.com>

The name and e-mail address in the From: header must be the same as in
the Signed-off-by tag, so I've fixed that up.

> > the cpudata memory from kzmalloc in epp init function is not free after=
 epp
> > exist, so we should free it.
> >
> > Signed-off-by: Peng Ma <andypma@tencent.com>
> >
> > Changes from v3 to v4:
> >       update subject used git command "git format-patch -1 -v x"
> >
> > Changes from v2 to v3:
> >       update Signed-off-by to Peng Ma <andypma@tencent.com>.
> >       set a space between if and "(".
> >
> > Changes from v1 to v2:
> >       check whether it is empty before releasing
> >       set driver_data is NULL after free
> > ---
> >  drivers/cpufreq/amd-pstate.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.=
c
> > index 6a342b0c0140..1b7e82a0ad2e 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -1441,6 +1441,13 @@ static int amd_pstate_epp_cpu_init(struct
> > cpufreq_policy *policy)
> >
> >  static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)  {
> > +     struct amd_cpudata *cpudata =3D policy->driver_data;
> > +
> > +     if (cpudata) {
> > +             kfree(cpudata);
> > +             policy->driver_data =3D NULL;
> > +     }

This does not need to be conditional, because you can pass NULL to
kfree(), but it is correct and since Mario has ACKed it ->

> > +
> >       pr_debug("CPU %d exiting\n", policy->cpu);
> >       return 0;
> >  }
> > --
> > 2.41.0
>
> Looks good now
>
> Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>

-> applied as 6.10 material (with edited subject and changelog).

Thanks!

