Return-Path: <linux-pm+bounces-25630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AAFA91D20
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 15:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3D17A67C3
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 13:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2515F17A2E3;
	Thu, 17 Apr 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYC9e/a9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A115FA7B;
	Thu, 17 Apr 2025 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894886; cv=none; b=Qzb9IN+ZLodIaa4iGH1S8R0Vu9JwnQJ7hDcbkTUuuebtB3K9L+k8zsLdq8L/xdLlxvg21K948jeoDTBs1XcWrj0VdXvESNQs2PnTEpbHIfqAfGQiMrWCYTmvKqBayy352k4nIMrXXfgvgj+D4xBm6SLgry1fQZmenMDkUmiNz44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894886; c=relaxed/simple;
	bh=KWnWVfOA8c1Wv+4gBL063mnR9c9nhvCmbY4Ut2JRHDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHQJr0v5HG2iZYAP0r3VNNmpguKjAEYjOrfEF6grDw3S3s/fRr50/tSuIRb9q20bOLv+0IG1bd5ZbivGK2Q+2HV3+YTsXT55nq1pdzIpaeVzQVfNIqNy2NUsRyLZFHeauqr06h19I4rQXDOPCO3eA5s7yzoFEthpMN40bk4V63I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYC9e/a9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE41BC4CEEA;
	Thu, 17 Apr 2025 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744894885;
	bh=KWnWVfOA8c1Wv+4gBL063mnR9c9nhvCmbY4Ut2JRHDU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fYC9e/a9vcPImM0qEXijPfQ1ABcyZ/YSN0M5omRfHnQdKjTQ/MTG1pAZ0gcZOjxmf
	 gJgBXfQsGVUa+gFtKGaWb9jxY+bxpsUkvgwmPKGxwaEYGtwY5tHXLyYDYueE9Wznfe
	 mogT4qQpQN93bCm/kSx771bVkBG9QkVUanbzbbcCYpOiqyDxWCcbWr8+NBBXbtdwYJ
	 l+TEgSazXJ6xudLSSaIpWoaQ3Y64azRqpZEpv8VzEqj+dmYoPrt0xZMY3h35zwSDmA
	 /DPNiFTmT/exx4m+vkS3irGJNU3sAfYWDfGsJw+hMiri2Bkv64q1lfCkD/q4KNbDv4
	 nb8vOAFmnJs9A==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso450793fac.2;
        Thu, 17 Apr 2025 06:01:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9YPgSltNvq77+BfybfPkL7PCBzFGKxYtlOewq7YMGJzzdGLgW/1tCZm2gJriCAuEUfRyEWQIixB4jPKY=@vger.kernel.org, AJvYcCWkavvn50GOR1WKHI/EcWll8VogSTKqaQ/kKaFgdHYXnXqgkQyVIcePG0NffiEfTs1L1IqAkoAcSXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Qnl9C/PUSGeYMXZAgKaztigRYk04ka8WREDGvUtuWx0TsMCi
	wctaHeKR1cyJ+zHvNreTpNg0kbLUsmLo8hVq7CDoqyjvNb46LGIyeIhzkyNDKBKr5faXI7F5q4p
	DTAtSTgS7tfrh/3YlcApHFp+s/LU=
X-Google-Smtp-Source: AGHT+IHOwV/UB7P82bRaQrXpDMI4M9ZvLUWLgqZFXu0lDZJnl1aeIwkdOWHX+F3XBWb05sq3u4gNN+OwtYP4tLLq6bo=
X-Received: by 2002:a05:6870:1708:b0:2bc:7d6f:fa86 with SMTP id
 586e51a60fabf-2d4d2d58f98mr3838358fac.35.1744894883674; Thu, 17 Apr 2025
 06:01:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3344336.aeNJFYEL58@rjwysocki.net> <8554829.NyiUUSuA9g@rjwysocki.net>
 <e439a75c-fe36-4fba-b394-c154adeff15a@arm.com>
In-Reply-To: <e439a75c-fe36-4fba-b394-c154adeff15a@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Apr 2025 15:01:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jxoKaGOsXqUqd=n95ATxzDTueSy_je_ktxOdm6B=+20A@mail.gmail.com>
X-Gm-Features: ATxdqUFqVAGSUxvggDc1DQyXBFEDUMLQGnrSY7wE1mYSzgRkQRC0XbcSOOwjyZ4
Message-ID: <CAJZ5v0jxoKaGOsXqUqd=n95ATxzDTueSy_je_ktxOdm6B=+20A@mail.gmail.com>
Subject: Re: [RFT][PATCH v1 3/8] cpufreq/sched: Allow .setpolicy() cpufreq
 drivers to enable EAS
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

On Thu, Apr 17, 2025 at 2:19=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 4/16/25 19:01, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Some cpufreq drivers, like intel_pstate, have built-in governors that
> > are used instead of regular cpufreq governors, schedutil in particular,
> > but they can work with EAS just fine, so allow EAS to be used with
> > those drivers.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v0.3 -> v1
> >      * Rebase on top of the new [1-2/8].
> >      * Update the diagnostic message printed if the conditions are not =
met.
> >
> > This patch is regarded as a cleanup for 6.16.
> >
> > ---
> >  drivers/cpufreq/cpufreq.c |   13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -3054,7 +3054,16 @@
> >
> >       guard(cpufreq_policy_read)(policy);
> >
> > -     return sugov_is_governor(policy);
> > +     /*
> > +      * For EAS compatibility, require that either schedutil is the po=
licy
> > +      * governor or the policy is governed directly by the cpufreq dri=
ver.
> > +      *
> > +      * In the latter case, it is assumed that EAS can only be enabled=
 by the
> > +      * cpufreq driver itself which will not enable EAS if it does not=
 meet
> > +      * the EAS' expectations regarding performance scaling response.
> > +      */
> > +     return sugov_is_governor(policy) || (!policy->governor &&
> > +             policy->policy !=3D CPUFREQ_POLICY_UNKNOWN);
> >  }
> >
> >  bool cpufreq_ready_for_eas(const struct cpumask *cpu_mask)
> > @@ -3064,7 +3073,7 @@
> >       /* Do not attempt EAS if schedutil is not being used. */
> >       for_each_cpu(cpu, cpu_mask) {
> >               if (!cpufreq_policy_is_good_for_eas(cpu)) {
> > -                     pr_debug("rd %*pbl: schedutil is mandatory for EA=
S\n",
> > +                     pr_debug("rd %*pbl: EAS requirements not met\n",
> >                                cpumask_pr_args(cpu_mask));
>
> I'd prefer to have at least "EAS cpufreq requirements" printed here.

Sure.

> with that caveat
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
>
> Maybe we should amend the EAS documentation to reflect this?

Yes, the documentation should be updated.  Which piece of it in
particular I need to look at?

> (And also emphasise that EAS will make cpufreq assumptions as if sugov
> was the governor regardless.)

Right.

