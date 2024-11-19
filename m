Return-Path: <linux-pm+bounces-17762-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A912B9D2959
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 16:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6031F23709
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B96C1CF5E0;
	Tue, 19 Nov 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymX2kNy3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D0D22067
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029252; cv=none; b=Xy4tNDcpiYE3vffc7PtnBHTo2DRmldV1lU+ZzCtdLJr/+F29gGv9C9F5WbXfdIz3K4GM2hCKz8+U+Zwd62KhR1GYxeV8xDxdxvp2kTMcAH9lMqS72M6DQNs4iLaqWcQjChtCBR/3Ivf51S1+qTjcmSn5PrawxHjFeXgcZEE7Bow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029252; c=relaxed/simple;
	bh=JB07XI8CadfPuQn3HSCNnBK7RTpzzgM8OCQI+wDxnCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqXtCnOyU8dpMzIv/kGZuBqxBH2oOyrebSMwRiNOl/Uz9gd73VgQRotEAxcM+zU4rYh6kxcYGoTd8niqNyhN5AZE/o+zR/6n7Jm5f8zvh+b6G9L2LgquLecyyV4DKEM8M4rqvloYDOJkNHeUjOjUBmIjCEqVXuNyUwcqoY6+znM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ymX2kNy3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e5130832aso2560358b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 07:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732029250; x=1732634050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbP2zECf3I/U1yfK8rubw5LsFQnbznjdfPmmJXFu4GY=;
        b=ymX2kNy3ek1/WYQt2FDf73yjtqdjZrXbDd0nYZdZB5WGbhBMYvqypLcioOVCXttu8j
         Im6BSlQ0Y3JLRoDP1w78irNZA7824V8o/64iZlyQDABnerTW35QOeMB36dptZ2/FoSQM
         J//H3oCFRWKsKkU7zUrJ3+UU6ae7HnTqHAsCT3fhSMhWkb2/1qkAtHewppXy/Ht8QRZ1
         yV/3Lf+Sbz+Par0czpdUA4B2Q8xqg18K0nhln1vMu5YMuATt647ni/cl3oRCVzZxd/q6
         flyiL6AksGRInAFkp6jN+cu5NFhc6+aofnSr/qbNBY97CmQ/M/AZTXlJ8pjJrcHPHiBj
         iV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732029250; x=1732634050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbP2zECf3I/U1yfK8rubw5LsFQnbznjdfPmmJXFu4GY=;
        b=AgM24zi4kPc5064P6wlhJWGu4zt/NHQZjHmvqCSkyhqpT7i8Tog7aXdjGn/dNm34+C
         N3EUb7AribQW8nzyYTs5R5Lx9ais2GrCpr8ur3IVqnCtxE5B/ejV+97PzesykwMD/LVd
         rYtS7CwvKWhe9ycMVtAN/WrROcW89EXxJnfq2S4nY/LrampijWr2tfLpBSP/lFegO07c
         ZJVk5FboUJWmssToBMJQVG0CuHKDs2sGsKyTYfvnIxc60HCjRa98OSX901aJTmojjV1Y
         k2Uo7/wfL6fPbxAOAiZ6KJKgQfsEpgGFL6koCRGUqQ9cbRM/+KbmBCv2o2FGAl6xZsrZ
         A1nA==
X-Forwarded-Encrypted: i=1; AJvYcCU+gDjqVzcwUbs0KzUtJzc153geV25OHdaUqwi+nvkCW4eCqX6qAqX0ySKyFW4hCV/nCx9Gwha5bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGRt8xk4VEIYHI8jpTjMfVga5Yvk6bKWra2jd8q19RdakiPKoP
	y4dLfUXwNF06Hzf8KAj0p4QshXYdkDUwD9nMxRro0MHnRI/VZxHWzeYNMdTmsZ/4noqzJ+GUs2D
	hWHkawUQsRfKqI8xYz/tsgxXtEhQyG7NXIiK46Q==
X-Google-Smtp-Source: AGHT+IFO77at1wdVNatwNKHEVVVGw9oCwK3U5IquzPKe7W0kg+1R9bkbd9FczHC4EPqdnAvTKnbJGxRaMogY/3e7nho=
X-Received: by 2002:a17:90a:d2cc:b0:2ea:4578:46cd with SMTP id
 98e67ed59e1d1-2ea457877c7mr11495717a91.21.1732029250033; Tue, 19 Nov 2024
 07:14:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3607404.iIbC2pHGDl@rjwysocki.net> <1889415.atdPhlSkOF@rjwysocki.net>
 <64a63f1c-088d-43dc-85c3-cecf8b59764f@arm.com> <CAJZ5v0hrj0jQ9mi20XRK3bTfaMDgUS3HyGnk=2x0UfF26jN1pQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hrj0jQ9mi20XRK3bTfaMDgUS3HyGnk=2x0UfF26jN1pQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 19 Nov 2024 16:13:59 +0100
Message-ID: <CAKfTPtCfsCwL=GO3oimvfN6ar7rCZ46euY7AjZBjy+p-HNmJEA@mail.gmail.com>
Subject: Re: [RFC][PATCH v0.1 5/6] sched/topology: Allow .setpolicy() cpufreq
 drivers to enable EAS
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 at 14:54, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Nov 11, 2024 at 12:54=E2=80=AFPM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 11/8/24 16:41, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Some cpufreq drivers, like intel_pstate, have built-in governors that
> > > are used instead of regular cpufreq governors, schedutil in particula=
r,
> > > but they can work with EAS just fine, so allow EAS to be used with
> > > those drivers.
> > >
> > > Also update the debug message printed when the cpufreq governor in
> > > use is not schedutil and the related comment, to better match the
> > > code after the change.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > I'm not sure how much value there is in refusing to enable EAS withou=
t
> > > schedutil in general.  For instance, if there are no crossover points
> > > between the cost curves for different perf domains, EAS may as well b=
e
> > > used with the performance and powersave governors AFAICS.
> >
> > Agreed, but having no cross-over points or no DVFS at all should be the
> > only instances, right?
>
> Not really.  This is the most obvious case, but there are other less
> obvious ones.
>
> Say there are two cross-over points: The  "performance" and
> "powersave" governors should still be fine with EAS in that case.
>
> Or what if somebody has a governor in user space that generally
> behaves like schedutil?
>
> Or what about ondemand?  Is it alway completely broken with EAS?

The only requirement from EAS is to know which OPP and its cost will
be selected by cpufreq gov for an utilization level of the CPU.
sched_util provides it with sugov_effective_cpu_perf(). Any other gov
that can provide such estimate of the OPP and associated cost should
be ok

powersave and perf should be pretty obvious not so sure for ondemand

>
> > For plain (non-intel_pstate) powersave and performance we could replace
> > sugov_effective_cpu_perf()
> > that determines the OPP of the perf-domain by the OPP they will be
> > choosing, but for the rest?
>
> I generally think that depending on schedutil for EAS is a mistake.
>
> I would just print a warning that results may be suboptimal or
> generally not as expected if the cpufreq governor is not schedutil
> instead of preventing EAS from running at all.
>
> > Also there is the entire uclamp thing, not sure what the best
> > solution is there.
> > Will intel_pstate just always ignore it? Might be better then to
> > depend on !intel_pstate?
>
> Well, it can be made dependent on policy->policy =3D=3D
> CPUFREQ_POLICY_POWERSAVE if gov is NULL or similar, but honestly why
> bother?
>
> > > ---
> > >  kernel/sched/topology.c |    6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > Index: linux-pm/kernel/sched/topology.c
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > --- linux-pm.orig/kernel/sched/topology.c
> > > +++ linux-pm/kernel/sched/topology.c
> > > @@ -251,7 +251,7 @@ static bool sched_is_eas_possible(const
> > >               return false;
> > >       }
> > >
> > > -     /* Do not attempt EAS if schedutil is not being used. */
> > > +     /* Do not attempt EAS with a cpufreq governor other than schedu=
til. */
> > >       for_each_cpu(i, cpu_mask) {
> > >               policy =3D cpufreq_cpu_get(i);
> > >               if (!policy) {
> > > @@ -263,9 +263,9 @@ static bool sched_is_eas_possible(const
> > >               }
> > >               gov =3D policy->governor;
> > >               cpufreq_cpu_put(policy);
> > > -             if (gov !=3D &schedutil_gov) {
> > > +             if (gov && gov !=3D &schedutil_gov) {
> > >                       if (sched_debug()) {
> > > -                             pr_info("rd %*pbl: Checking EAS, schedu=
til is mandatory\n",
> > > +                             pr_info("rd %*pbl: Checking EAS, cpufre=
q governor is not schedutil\n",
> > >                                       cpumask_pr_args(cpu_mask));
> > >                       }
> > >                       return false;
> > >
> > >
> > >
> > >
> >
> >

