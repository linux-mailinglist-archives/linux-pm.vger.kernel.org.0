Return-Path: <linux-pm+bounces-38571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7780C84DCF
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6813B0457
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FC03195E0;
	Tue, 25 Nov 2025 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eO1fUeDw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95E318152
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072225; cv=none; b=d7ItkRLTNOMjhll+n1NYo/QOa19usBHJFguH/pQbCHPhaEMTzK2bNigEOf/PaUHRf7EhWITrELropuxKJVicluGBpWt6VKWD9DMM8GWuAZohBWZ2P27lWYIYEoFatggcvdHcwhyo60jRhddmjgs6CKdurksSi01apfc5Zsg+btQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072225; c=relaxed/simple;
	bh=gks/Cj1ebqB5LimvzRxhe80HHPnQkVYfO9iXc8p2v+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGTLzSv0ZmvAzQ62h0GwsNo3HR91lT6oVge1O84x5TJGBw7t0Scl8Pz4f/hEGEACAGwzpIwd10caFPkbCZznHUe9ku/NmoqxWQgIJSEPzvBjDsqi61CdFF16v71W3/7jlle8Pi7hGKTtxGGYe8BPly7LBaLXi+tou9KJ7mOyNCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eO1fUeDw; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so5705327b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 04:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764072223; x=1764677023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZQ435f+B4jguPWQPHLejoQMqWDb5LYsSpvscBlrH1I=;
        b=eO1fUeDwab1x2la9I70xLAdQZBy1xhALkYYZzWHpUltOTqK0xzynlSAuvW3Dn5bFxX
         pqUc9OaaDBEPgCKWZZYgWUZPLn4vUQkGlIM5cV0Wp2SZB3IWeyI/2g2+H4nD2dIzRyXc
         6V96QbWJlJJYYqIZc4xWczx+78XUDyoGEuMDor342Mlng0OUtxAVksylFLhbmfCt8qPy
         U1bCqXbcc1DJdWFDDnbbhfePEvdw61N7ZE3wIKOmb5eCkkJOb0cotZb8oxqFJOcfvArx
         LLU0btAjnX2bson5bcmAIwtfTHXfRsgAlspeZ2UvLQzKGHa7pc2tDvVVaoQHlfAyIpB0
         i8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764072223; x=1764677023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ZQ435f+B4jguPWQPHLejoQMqWDb5LYsSpvscBlrH1I=;
        b=TC8qe4bISe4lWiL20so5ytl9Y1QSE7UGoM2p3OXZzKLuDVJQJZXAziK0LdyE/Bzk4X
         iLzftKCrnjKd5nkOVMYR1m/Ku3u0Zp10hf8TZyy++1fbIm/WRmVoXk6I1tGYunufwHn0
         0kn+zOzoo8JY34r2QJ+u7R8THcoTJH1oq0uZ9H6LLSKW5ZE3cLKHzOuode/T0ecq79Xs
         ZbxGHCuwIl16uh1LAp1ZmxKcRYXU8Y8jY/sTKNkumNDyI69s6Wjsrc71aLn+Z42x9+TM
         FuwPHqZJC7rbf+/gLYoPDcbo0tPK6EKnpR9ICorY7hIC1szzD5Vo1Uj/0fy1lM7Vq7NC
         9T/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOQANfQl3TSaLO7Zdcd/WkYSnaJMwhGju26NpDP4mbccvF2uoUv8Fi0Oe7sdiU/3RNK2qjUvB9Zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSeR+Kn6XN3OyowBw9M7OCnZElhs/qV8Hu6wJAiH78xqKgIKfI
	lnI5JS0IUF7eTlfe5TZnEMHVljjGKHq09WLHvSw8gA98cubi2GhTU8FSjTFykRDB2tkFzhwsT8+
	lpbrBmTG2Wm1Z6MIZzBZ+7tbHNt+hl9EL/ZQMyUTg
X-Gm-Gg: ASbGncuOOKWCNSjNKxUPPVO7qzPbh4IIq//+ersSbBQgyrCj7no4R42J6e1wYj+K2SG
	MgisViT+ABnaVRtsTAT2VenoRHRRUvbYQGjDuZBNSjElnAG0CTD8Y+ZMw3Pr6sdbAVPENzPP9M1
	rypFVL+IFD6lb7OnnAzJ2m0zbo1JfWkhhl+5vxRqQtLbupjbvrv5CMAsqW8eGZVNXPEf59hzxUv
	2Ay0R6v7p1tddG/H20K+B/T0x2twKoAvDR2BoCxneR8kDsZrWHVj6Z3a/2DT/3A3jQXp1xA00aT
	+HR8gzYmAQWi7/7t4/DCkxb++Q==
X-Google-Smtp-Source: AGHT+IENSpI7pWEv/zOY8SFJG/SrQuPlv0EWb7KIMGwQLde0iFVdUo3hfe/Sduo66AKmivzZ1BYWQbM60WSBBgkz7pI=
X-Received: by 2002:a05:7022:671f:b0:11a:436c:2d56 with SMTP id
 a92af1059eb24-11c9d7090ffmr9719353c88.2.1764072222454; Tue, 25 Nov 2025
 04:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com> <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
 <CAKfTPtBBtMysuYgBYZR2EH=WPR7X5F_RRzGmf94UhyDiGmmqCg@mail.gmail.com>
 <CAKchOA03GKXMUbfVvEXtyp3=-t0mWOzQVHNkB6F9QsMfTzCofA@mail.gmail.com>
 <6e50830f-a1b8-452a-86a7-1621cd3968ce@arm.com> <4345086e-d68b-47eb-adfa-939a7c6514ba@arm.com>
 <CAKfTPtAxu5yac6teiFcPkrR-6Ui=J1Q1q7+-PQ6iNjEZP_yuyg@mail.gmail.com> <CAKfTPtCafw+VzSbfGtC+hxjxy=ioN9CmbsJMiRum777ds6GhSw@mail.gmail.com>
In-Reply-To: <CAKfTPtCafw+VzSbfGtC+hxjxy=ioN9CmbsJMiRum777ds6GhSw@mail.gmail.com>
From: Yu-Che Cheng <giver@google.com>
Date: Tue, 25 Nov 2025 20:03:05 +0800
X-Gm-Features: AWmQ_bm0UVfth-_ShndO7kosqnsSnBe65ZEeMUdRyIPLfb6pgXf3DtegRpl4_0s
Message-ID: <CAKchOA1mBWw=vihSKL8=gWqK=UzxUO5ohWM+HY17ykZ1ew8y5w@mail.gmail.com>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Christian Loehle <christian.loehle@arm.com>, Yu-Che Cheng <giver@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian and Vincent,

On Tue, Nov 25, 2025 at 12:41=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 24 Nov 2025 at 17:30, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Fri, 21 Nov 2025 at 17:43, Christian Loehle <christian.loehle@arm.co=
m> wrote:
> > >
> > > On 11/21/25 16:35, Christian Loehle wrote:
> > > > On 11/21/25 15:37, Yu-Che Cheng wrote:
> > > >> Hi Vincent,
> > > >>
> > > >> On Fri, Nov 21, 2025 at 10:00=E2=80=AFPM Vincent Guittot <vincent.=
guittot@linaro.org>
> > > >> wrote:
> > > >>>
> > > >>> On Fri, 21 Nov 2025 at 04:55, Sergey Senozhatsky
> > > >>> <senozhatsky@chromium.org> wrote:
> > > >>>>
> > > >>>> Hi Christian,
> > > >>>>
> > > >>>> On (25/11/20 10:15), Christian Loehle wrote:
> > > >>>>> On 11/20/25 04:45, Sergey Senozhatsky wrote:
> > > >>>>>> Hi,
> > > >>>>>>
> > > >>>>>> We are observing a performance regression on one of our arm64
> > > >> boards.
> > > >>>>>> We tracked it down to the linux-6.6.y commit ada8d7fa0ad4
> > > >> ("sched/cpufreq:
> > > >>>
> > > >>> You mentioned that you tracked down to linux-6.6.y but which kern=
el
> > > >>> are you using ?
> > > >>>
> > > >>
> > > >> We're using ChromeOS 6.6 kernel, which is currently on top of linu=
x-v6.6.99.
> > > >> But we've tested that the performance regression still happens on =
exactly
> > > >> the same scheduler codes (`kernel/sched`) as upstream v6.6.99, com=
pared to
> > > >> those on v6.6.88.
> > > >>
> > > >>>>>> Rework schedutil governor performance estimation").
> > > >>>>>>
> > > >>>>>> UI speedometer benchmark:
> > > >>>>>> w/commit:   395  +/-38
> > > >>>>>> w/o commit: 439  +/-14
> > > >>>>>>
> > > >>>>>
> > > >>>>> Hi Sergey,
> > > >>>>> Would be nice to get some details. What board?
> > > >>>>
> > > >>>> It's an MT8196 chromebook.
> > > >>>>
> > > >>>>> What do the OPPs look like?
> > > >>>>
> > > >>>> How do I find that out?
> > > >>>
> > > >>> In /sys/kernel/debug/opp/cpu*/
> > > >>> or
> > > >>> /sys/devices/system/cpu/cpufreq/policy*/scaling_available_frequen=
cies
> > > >>> with related_cpus
> > > >>>
> > > >>
> > > >> The energy model on the device is:
> > > >>
> > > >> CPU0-3:
> > > >> +------------+------------+
> > > >> | freq (khz) | power (uw) |
> > > >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
> > > >> |     339000 |      34362 |
> > > >> |     400000 |      42099 |
> > > >> |     500000 |      52907 |
> > > >> |     600000 |      63795 |
> > > >> |     700000 |      74747 |
> > > >> |     800000 |      88445 |
> > > >> |     900000 |     101444 |
> > > >> |    1000000 |     120377 |
> > > >> |    1100000 |     136859 |
> > > >> |    1200000 |     154162 |
> > > >> |    1300000 |     174843 |
> > > >> |    1400000 |     196833 |
> > > >> |    1500000 |     217052 |
> > > >> |    1600000 |     247844 |
> > > >> |    1700000 |     281464 |
> > > >> |    1800000 |     321764 |
> > > >> |    1900000 |     352114 |
> > > >> |    2000000 |     383791 |
> > > >> |    2100000 |     421809 |
> > > >> |    2200000 |     461767 |
> > > >> |    2300000 |     503648 |
> > > >> |    2400000 |     540731 |
> > > >> +------------+------------+
> > > >>
> > > >> CPU4-6:
> > > >> +------------+------------+
> > > >> | freq (khz) | power (uw) |
> > > >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
> > > >> |     622000 |     131738 |
> > > >> |     700000 |     147102 |
> > > >> |     800000 |     172219 |
> > > >> |     900000 |     205455 |
> > > >> |    1000000 |     233632 |
> > > >> |    1100000 |     254313 |
> > > >> |    1200000 |     288843 |
> > > >> |    1300000 |     330863 |
> > > >> |    1400000 |     358947 |
> > > >> |    1500000 |     400589 |
> > > >> |    1600000 |     444247 |
> > > >> |    1700000 |     497941 |
> > > >> |    1800000 |     539959 |
> > > >> |    1900000 |     584011 |
> > > >> |    2000000 |     657172 |
> > > >> |    2100000 |     746489 |
> > > >> |    2200000 |     822854 |
> > > >> |    2300000 |     904913 |
> > > >> |    2400000 |    1006581 |
> > > >> |    2500000 |    1115458 |
> > > >> |    2600000 |    1205167 |
> > > >> |    2700000 |    1330751 |
> > > >> |    2800000 |    1450661 |
> > > >> |    2900000 |    1596740 |
> > > >> |    3000000 |    1736568 |
> > > >> |    3100000 |    1887001 |
> > > >> |    3200000 |    2048877 |
> > > >> |    3300000 |    2201141 |
> > > >> +------------+------------+
> > > >>
> > > >> CPU7:
> > > >>
> > > >> +------------+------------+
> > > >> | freq (khz) | power (uw) |
> > > >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D+
> > > >> |     798000 |     320028 |
> > > >> |     900000 |     330714 |
> > > >> |    1000000 |     358108 |
> > > >> |    1100000 |     384730 |
> > > >> |    1200000 |     410669 |
> > > >> |    1300000 |     438355 |
> > > >> |    1400000 |     469865 |
> > > >> |    1500000 |     502740 |
> > > >> |    1600000 |     531645 |
> > > >> |    1700000 |     560380 |
> > > >> |    1800000 |     588902 |
> > > >> |    1900000 |     617278 |
> > > >> |    2000000 |     645584 |
> > > >> |    2100000 |     698653 |
> > > >> |    2200000 |     744179 |
> > > >> |    2300000 |     810471 |
> > > >> |    2400000 |     895816 |
> > > >> |    2500000 |     985234 |
> > > >> |    2600000 |    1097802 |
> > > >> |    2700000 |    1201162 |
> > > >> |    2800000 |    1332076 |
> > > >> |    2900000 |    1439847 |
> > > >> |    3000000 |    1575917 |
> > > >> |    3100000 |    1741987 |
> > > >> |    3200000 |    1877346 |
> > > >> |    3300000 |    2161512 |
> > > >> |    3400000 |    2437879 |
> > > >> |    3500000 |    2933742 |
> > > >> |    3600000 |    3322959 |
> > > >> |    3626000 |    3486345 |
> > > >> +------------+------------+
> > > >>
> > > >>>>
> > > >>>>> Does this system use uclamp during the benchmark? How?
> > > >>>>
> > > >>>> How do I find that out?
> > > >>>
> > > >>> it can be set per cgroup
> > > >>> /sys/fs/cgroup/system.slice/<name>/cpu.uclam.min|max
> > > >>> or per task with sched_setattr()
> > > >>>
> > > >>> You most probably use it because it's the main reason for ada8d7f=
a0ad4
> > > >>> to remove wrong overestimate of OPP
> > > >>>
> > > >>
> > > >> For the speedometer case, yes, we set the uclamp.min to 20 for the=
 whole
> > > >> browser and UI (chrome).
> > > >> There's no system-wide uclamp settings though.
> > > >
> > > > (From Sergey's traces)
> > > > Per-cluster time=E2=80=91weighted average frequency base =3D> rever=
t:
> > > > little (cpu0=E2=80=933, max 2.4=E2=80=AFGHz): 0.746=E2=80=AFGHz =3D=
> 1.132=E2=80=AFGHz (+51.6%)
> > > > mid (cpu4=E2=80=936, max 3.3=E2=80=AFGHz): 1.043=E2=80=AFGHz =3D> 1=
.303=E2=80=AFGHz (+24.9%)
> > > > big (cpu7, max 3.626=E2=80=AFGHz): 2.563=E2=80=AFGHz =3D> 3.116=E2=
=80=AFGHz (+21.6%)
> > > >
> > > > And in particular time spent at OPPs (base =3D> revert):
> > > > Big core at upper 10%: 29.6% =3D> 61.5%
> > > > little cluster at 339=E2=80=AFMHz: 50.1% =3D> 1.0%
> > >
> > > Sorry, should be 1.0% =3D> 50.1%
> >
> > Having in mind that we have uclamp min at 20% ~204, this means that
> > the tasks are not put in little cluster after the revert so the little
> > goes back to low freq but 204 is less than half of little capacity
>
> As Christian said, it would be good to have a trace with scheduler
> events. Having task and cpu util would be interesting too: perfetto
> should record all that for you
>

Here are the Perfetto traces during the Speedometer 2.0 workload. Both
of them are based on ChromeOS 6.6 kernel, while checking out the
`kernel/sched` directory to upstream/v6.6.88 or v6.6.99.

v6.6.88 (433 score):
https://ui.perfetto.dev/#!/?s=3D44cd047c79a32fdba44583312ec5118f1e1162f2
v6.6.99 (408 score):
https://ui.perfetto.dev/#!/?s=3D529eef4a60ddc921907ed380d901e47ddf3d42c9

Also attached the time_in_state of the CPU7 frequencies during the
workload, which looks highly correlated to the Speedometer performance
since its main thread is running on CPU7 most of the time.

v6.6.88 (433 score):
3626000 567
3600000 54
3500000 54
3400000 88
3300000 77
3200000 61
3100000 80
3000000 61
2900000 75
2800000 59
2700000 51
2600000 58
2500000 54
2400000 57
2300000 49
2200000 42
2100000 37
2000000 397
1900000 0
1800000 0
1700000 0
1600000 0
1500000 0
1400000 0
1300000 0
1200000 0
1100000 0
1000000 0
900000 0
798000 0

v6.6.99 (408 score):
3626000 459
3600000 55
3500000 46
3400000 88
3300000 53
3200000 80
3100000 82
3000000 111
2900000 90
2800000 83
2700000 69
2600000 61
2500000 50
2400000 73
2300000 66
2200000 47
2100000 42
2000000 487
1900000 0
1800000 0
1700000 0
1600000 0
1500000 0
1400000 0
1300000 0
1200000 0
1100000 0
1000000 0
900000 0
798000 0

> >
> >
> > >
> > > >
> > > > Interesting that a uclamp.min of 20 (which shouldn't really have
> > > > much affect on big CPU at all, with or without headroom AFAICS?)
> > > > makes such a big difference here?
> > >
> > > Can we get a sched_switch / sched_migrate / sched_wakeup trace for th=
is?
> > > Perfetto would also do if that is better for you.
> > >
> > > >
> > > >>
> > > >> But we also found other performance regressions in an Android gues=
t VM,
> > > >> where there's no uclamp for the VM and vCPU processes from the hos=
t side.
> > > >> Particularly, the RAR extraction throughput reduces about 20% in t=
he RAR
> > > >> app (from RARLAB).
> > > >> Although it's hard to tell if this is some sort of a side-effect o=
f the UI
> > > >> regression as the UI is also running at the same time.
> > > >>
> > > > I'd be inclined to say that is because of the vastly different DVFS=
 from the
> > > > UI workload, yes.
> > > >
> > >

Best regards,
Yu-Che

