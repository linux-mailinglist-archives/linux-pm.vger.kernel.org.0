Return-Path: <linux-pm+bounces-19019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129879ECD1D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 14:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669FB281AD5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091E7229151;
	Wed, 11 Dec 2024 13:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jiiwCirL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F16523FD06
	for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923529; cv=none; b=Iw5XnmA+K9jlcs/8dFQuH/y7ub94H254hmGwCjjNBYarZtOtp7AElb+xvNbHbGF3VsWQl450f7raFZ1iX/TMEnKlNc18jPtLnLnUibkyL9y2polSn+jSbrRvc7O2U3wzdz7Tjq9uRlPEmp3JScV/yHE+woXV4FLT2Wfq+9zDTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923529; c=relaxed/simple;
	bh=F7ClRSDPlmowTlTkYA2vtwRH/X0CYiJxPiRuh6lXYdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDj53idhspIBkLEDoE4D9jRIff/ShwiGigxfIuIEiwz5davjBjCNr5PkApSuCHpXPUpupQg0AkZYy/Uoc0QAp35dVOY5d850oLsACrkAfPsLZcNMUbvH391hruqNQgQZ348RB41Jimz9UwU3utXiW/8+IEvnGDJsZDweySZFAnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jiiwCirL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728f1e66418so449291b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2024 05:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733923526; x=1734528326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52qsJbrEZBJTL67kYW0LzbQH1uz/zTKWXiiEV8CLW5g=;
        b=jiiwCirLVcSDzUznPwnq5orItEpouivq+veabgM6hG/c4RtINN/C0wJj0+nGyAtdAp
         LoDXc4bZQT58825+ghJWYMKNFaerYWm4P/tHMdT+9PwtFDlIGLoeN1/2IP/5yJg0pAS3
         LEddRTOSqjUsvAwgkM1IJYMfKMH/8Z2zX22LKA+mSnqIAyH2YXLTIgz2UnHPf4XW/1r5
         XlgUKsGEaEvNZztb/De04RlZrLlUzs653D7iXEDXSq/zqgx5U/PyT6+9zRbU2+sxZsu6
         5DD7YPhxeoAFmTSK6Igxlda/sz1Uk2/x7EyLaD4tbzQdCMqoBixO5N4C1w5XTsDCZgMs
         /pJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733923526; x=1734528326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52qsJbrEZBJTL67kYW0LzbQH1uz/zTKWXiiEV8CLW5g=;
        b=Rg0A5wVMlzz23EENMtwnB0Vk0Kyxj7NZ12XlhzvP6ufJatRR2XHPGUu8G0jbNi6J7q
         LlQqXgnJe7AHSdiJi+UwhyuPFFqBWJtZvNtZdzU6dyAfni9+yjm99VvSLSRnIoze4jXt
         IqOu20z7ZcSHa1DzqNrTGvOaZDejxJZ7k4u8wJF2JBKv/N5aRPPBkYeW6Nmf04NSQ9U8
         FYb2dSWOGSjlb8+vI50VfyQcZiHi1XMJZ62HV72ydctILdOB+OIsXrzmLC+6X2Q30u/W
         21NOhCoQA0ewMptGAZ7wxBqmtUMqPNk22Zam70E2hIjBLBzcigLefkaFM/VN52oTMz8e
         1G/g==
X-Forwarded-Encrypted: i=1; AJvYcCUhG/gt8JzdYa0I92Wrnh7jtvQ51SwgbMIAH4mQxhDmfzZINFI8nChzs1dKhbxOQxYoNan/9X9VVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFIy4SnKa9O9D39FRwONf0EQsA+jpg9Nn9FB3MyqKwgANNHrjR
	QmHd6Hhp7RAJMAnrDmrkz/96ygujdcKT6tes0q5s5uzC9xzIel/9IkdJoV5gdtx6fzG9bnMp5CT
	e54GFDCxMFtqDOv/Scxpj2JM00X8OrRJa4djh2Q==
X-Gm-Gg: ASbGncuw/XXb/JBHokhN18nRXd5aSbHgYNtYOOEWMLDvnuZOmRyBysHWhL5p63Bf3cl
	EaAi9r7TAHEXN0ZNoPjjEfFM8J0xVhlwIDr1AHeXVaDSa3GOFTbhXqBDq2vtgMUXo
X-Google-Smtp-Source: AGHT+IGTCHkH/wdKKewfl7Mq3kAimCKhjttvHwdMKbWRkk/0ABXJnggUAYQVK6V95ADdRM3Tir/W2Qni7OFgz2q4CqY=
X-Received: by 2002:a05:6a20:d50c:b0:1e1:3a97:bdb0 with SMTP id
 adf61e73a8af0-1e1c12aabc8mr5272462637.9.1733923526475; Wed, 11 Dec 2024
 05:25:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5861970.DvuYhMxLoT@rjwysocki.net> <2989520.e9J7NaK4W3@rjwysocki.net>
 <4d601707-8269-4c2b-86d2-62951ea0353c@arm.com> <CAJZ5v0jvOYACAn-of=e7zirfzQ5gT+CTPM2w29T-jPzk7Z+SOg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jvOYACAn-of=e7zirfzQ5gT+CTPM2w29T-jPzk7Z+SOg@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 11 Dec 2024 14:25:14 +0100
Message-ID: <CAKfTPtAdo7OADEFuMeg1PpO=rk=bXmiw1Avj7frsoNWZuceewA@mail.gmail.com>
Subject: Re: [RFC][PATCH v021 4/9] sched/topology: Adjust cpufreq checks for EAS
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Pierre Gondois <pierre.gondois@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Dec 2024 at 12:29, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Dec 11, 2024 at 11:33=E2=80=AFAM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 11/29/24 16:00, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Make it possible to use EAS with cpufreq drivers that implement the
> > > :setpolicy() callback instead of using generic cpufreq governors.
> > >
> > > This is going to be necessary for using EAS with intel_pstate in its
> > > default configuration.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > This is the minimum of what's needed, but I'd really prefer to move
> > > the cpufreq vs EAS checks into cpufreq because messing around cpufreq
> > > internals in topology.c feels like a butcher shop kind of exercise.
> >
> > Makes sense, something like cpufreq_eas_capable().
> >
> > >
> > > Besides, as I said before, I remain unconvinced about the usefulness
> > > of these checks at all.  Yes, one is supposed to get the best results
> > > from EAS when running schedutil, but what if they just want to try
> > > something else with EAS?  What if they can get better results with
> > > that other thing, surprisingly enough?
> >
> > How do you imagine this to work then?
> > I assume we don't make any 'resulting-OPP-guesses' like
> > sugov_effective_cpu_perf() for any of the setpolicy governors.
> > Neither for dbs and I guess userspace.
> > What about standard powersave and performance?
> > Do we just have a cpufreq callback to ask which OPP to use for
> > the energy calculation? Assume lowest/highest?
> > (I don't think there is hardware where lowest/highest makes a
> > difference, so maybe not bothering with the complexity could
> > be an option, too.)
>
> In the "setpolicy" case there is no way to reliably predict the OPP
> that is going to be used, so why bother?
>
> In the other cases, and if the OPPs are actually known, EAS may still
> make assumptions regarding which of them will be used that will match
> the schedutil selection rules, but if the cpufreq governor happens to
> choose a different OPP, this is not the end of the world.

Should we add a new cpufreq governor fops to return the guest estimate
of the compute capacity selection ? something like
cpufreq_effective_cpu_perf(cpu, actual, min, max)
EAS needs to estimate what would be the next OPP; schedutil uses
sugov_effective_cpu_perf() and other governor could provide their own

>
> Yes, you could have been more energy-efficient had you chosen to use
> schedutil, but you chose otherwise and that's what you get.

Calling sugov_effective_cpu_perf() for another governor than schedutil
doesn't make sense. and do we handle the case when
CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not selected

>
> > >
> > > ---
> > >  kernel/sched/topology.c |   10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > Index: linux-pm/kernel/sched/topology.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/kernel/sched/topology.c
> > > +++ linux-pm/kernel/sched/topology.c
> > > @@ -217,6 +217,7 @@ static bool sched_is_eas_possible(const
> > >       bool any_asym_capacity =3D false;
> > >       struct cpufreq_policy *policy;
> > >       struct cpufreq_governor *gov;
> > > +     bool cpufreq_ok;
> > >       int i;
> > >
> > >       /* EAS is enabled for asymmetric CPU capacity topologies. */
> > > @@ -251,7 +252,7 @@ static bool sched_is_eas_possible(const
> > >               return false;
> > >       }
> > >
> > > -     /* Do not attempt EAS if schedutil is not being used. */
> > > +     /* Do not attempt EAS if cpufreq is not configured adequately *=
/
> > >       for_each_cpu(i, cpu_mask) {
> > >               policy =3D cpufreq_cpu_get(i);
> > >               if (!policy) {
> > > @@ -261,11 +262,14 @@ static bool sched_is_eas_possible(const
> > >                       }
> > >                       return false;
> > >               }
> > > +             /* Require schedutil or a "setpolicy" driver */
> > >               gov =3D policy->governor;
> > > +             cpufreq_ok =3D gov =3D=3D &schedutil_gov ||
> > > +                             (!gov && policy->policy !=3D CPUFREQ_PO=
LICY_UNKNOWN);
> > >               cpufreq_cpu_put(policy);
> > > -             if (gov !=3D &schedutil_gov) {
> > > +             if (!cpufreq_ok) {
> > >                       if (sched_debug()) {
> > > -                             pr_info("rd %*pbl: Checking EAS, schedu=
til is mandatory\n",
> > > +                             pr_info("rd %*pbl: Checking EAS, unsuit=
able cpufreq governor\n",
> > >                                       cpumask_pr_args(cpu_mask));
> > >                       }
> > >                       return false;
> >
> > The logic here looks fine to me FWIW.
> >
> >

