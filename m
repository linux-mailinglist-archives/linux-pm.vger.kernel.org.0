Return-Path: <linux-pm+bounces-38386-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D8AC7B28C
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 18:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8723A2760
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 17:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4720F352925;
	Fri, 21 Nov 2025 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0nYCLPb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F6F34DCF5
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747928; cv=none; b=F0P7YinB6dOlN/yuZzq0wIBzBI+4dTy/jd6vVY+2LqLhURQnjaaEqUkVnqeMlFpmztUBdypLAlpZYy0Nzv/0oEUhWa9xqorUe1QnNOx+bsppoUke+pox8pGh0m1vcg8zW5f2tCnt+VuxWhtF5hdPBWt1YG1+/6XdcVDZMhed1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747928; c=relaxed/simple;
	bh=l/emk33IJaQCRnpjtlYSMRe3l46rJi3OHWQwgkyXmuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Few8GUIpU1t+/EfOMTvnBsKCPAkSLFhYoJ0GupkqggNHndQJOpOxm8SGzCD0xPydsra83OOdy3ckMtGJ6bsxIqnkNpXbilamoKppf7rrGBHIsfPYbH5rDd81m/aLnKvnuDqsSGXA3tVlQOjktfZ0WVrUSbIhHmyu1UmYzAjJ9jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H0nYCLPb; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so3302094a12.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 09:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763747924; x=1764352724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yauXV5Vo3Xp9GxqEkp8nUzj236IDpantD/jBpBsr8Nc=;
        b=H0nYCLPb+2fDyt3Ri6QSi+v4r7hquxj+2Dsc81K8/6Gysl8Q4S8YNf5i+LkkMWY5dJ
         zJyBb7kmjUBaH/VMT3FYTBK3aY+3FrU0+ttNR3iOBLmhlcCiTTLUpjjxPJyoGM6MgSUI
         TauMJ0kMR3uGXcxK4KIPhxfIOfiWMiClH7tOH/uhlvi0gFNIoGjTHGE5HskFyWYsEh2G
         4p1bNryQ4vwqmrgdYVFWxfVpRhn/u9kMDJm+bWkTklxajYbl20eDwpX9CHe5Mk/cThce
         HPLpEn17/hjCjwUvqkq8a/l3Zn9Adb/DOYtvkyeMLhrKb7QZv5lqkrrS6qr2F+LfHGU7
         DzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747924; x=1764352724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yauXV5Vo3Xp9GxqEkp8nUzj236IDpantD/jBpBsr8Nc=;
        b=uAbGvyoyR5u5MPFHyDiLngBDEptJflS40u6PGBA5Xpy5agFM+mJQ3cOQlon/oKOLkS
         CArSJORoWCx7FvwKZCzc3P1l74CJrmEGH2XJxXH29CIP/roiR7jMvrCgG78EFaLv4rGZ
         9fj8i1vdiI9X2xkhme78LiQVh8grtdXIS7kHllON8SoxGmlDipiKJ5BjT3K+fCW+Sowl
         TnIySIOtiEoH5ni6UhVONf07iZ4UrMEy+oWpZRz9Kp3fsWowDrFw2WkI4v3wgFynEuGg
         Qto/p15Vz9sIgYLdkrbKN4mBgA+0lIkNwlX7CmmmOxMJ1KQjkJYqjiG4piOuUUSuA6Yx
         SDvw==
X-Forwarded-Encrypted: i=1; AJvYcCV7ygoH+4ccULpam51qKpfLg3+zjxz4aUr3B4nJ8KfTuy8UDttSHbUsLG/qNfd90fIitvPWJqddAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnLZQr1AoK9GLuHD32RLOnvtzj7BDOnfLGaeXGARiGea6jtJu
	YmZ0/ilr6vLLJgC6LfuDpGKMe6KKotcbz06dSmHQvssJuwRTNHNmgYahs96Hi1AYvGHZ3cZYiHT
	JY1qtksu1p9+/D1AfwA32EuZEP0NobI+GN7Sc1Kbdjg==
X-Gm-Gg: ASbGncu2YRN0RrOSRHhHrTlRXED95QSm1eiur8KLLNwjNba2LZy/c86dkT+LEyi2iZC
	AKtlH2Yqg+AIDCXXUFJj7KIoaWKD3GiTRGC4y+MYtUkDpslMq457MF+2PUB0EgHQkjQf5Crn+YL
	n4osD6LvdJJfoxFSQ2fFWQC/qbJM5uv4tv+Q1OJuwsDYemVEdOq+C46iewT9HfhEu3Mh5bRxyrn
	2TfTpRl8MdFctXyRzusnJ57t0VaKly2Rsxx23oCrwI3w5AgctAXi2JEAszKu/i6OllxJVFUFasN
	z8MKOBsdQ2hWxtzav3AyPTlz
X-Google-Smtp-Source: AGHT+IH5VUXeKXDFaWzqSMjOTFrzQR4663IwnMB1GfJiRrUq6R9h6K2CpqHIPq/0RtRk0jyCDkkVGH5zykoQu+QEC+I=
X-Received: by 2002:a05:6402:350c:b0:641:27d8:ec3f with SMTP id
 4fb4d7f45d1cf-645546a328amr2824474a12.29.1763747924057; Fri, 21 Nov 2025
 09:58:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com> <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
 <CAKfTPtBBtMysuYgBYZR2EH=WPR7X5F_RRzGmf94UhyDiGmmqCg@mail.gmail.com>
 <CAKchOA03GKXMUbfVvEXtyp3=-t0mWOzQVHNkB6F9QsMfTzCofA@mail.gmail.com> <6e50830f-a1b8-452a-86a7-1621cd3968ce@arm.com>
In-Reply-To: <6e50830f-a1b8-452a-86a7-1621cd3968ce@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 21 Nov 2025 18:58:32 +0100
X-Gm-Features: AWmQ_bm0LV7v7253_x3q6L4l6YJCTgvF1RffJ2LVMbmE1Sm1KAZlgXeDxmfr_kI
Message-ID: <CAKfTPtB-+DeZQyLNRQjvCyM2KjDK2cLpM29UmW++oe=Tcu5AoA@mail.gmail.com>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Christian Loehle <christian.loehle@arm.com>
Cc: Yu-Che Cheng <giver@chromium.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Nov 2025 at 17:35, Christian Loehle <christian.loehle@arm.com> w=
rote:
>
> On 11/21/25 15:37, Yu-Che Cheng wrote:
> > Hi Vincent,
> >
> > On Fri, Nov 21, 2025 at 10:00=E2=80=AFPM Vincent Guittot <vincent.guitt=
ot@linaro.org>
> > wrote:
> >>
> >> On Fri, 21 Nov 2025 at 04:55, Sergey Senozhatsky
> >> <senozhatsky@chromium.org> wrote:
> >>>
> >>> Hi Christian,
> >>>
> >>> On (25/11/20 10:15), Christian Loehle wrote:
> >>>> On 11/20/25 04:45, Sergey Senozhatsky wrote:
> >>>>> Hi,
> >>>>>
> >>>>> We are observing a performance regression on one of our arm64
> > boards.
> >>>>> We tracked it down to the linux-6.6.y commit ada8d7fa0ad4
> > ("sched/cpufreq:
> >>
> >> You mentioned that you tracked down to linux-6.6.y but which kernel
> >> are you using ?
> >>
> >
> > We're using ChromeOS 6.6 kernel, which is currently on top of linux-v6.=
6.99.
> > But we've tested that the performance regression still happens on exact=
ly
> > the same scheduler codes (`kernel/sched`) as upstream v6.6.99, compared=
 to
> > those on v6.6.88.
> >
> >>>>> Rework schedutil governor performance estimation").
> >>>>>
> >>>>> UI speedometer benchmark:
> >>>>> w/commit:   395  +/-38
> >>>>> w/o commit: 439  +/-14
> >>>>>
> >>>>
> >>>> Hi Sergey,
> >>>> Would be nice to get some details. What board?
> >>>
> >>> It's an MT8196 chromebook.
> >>>
> >>>> What do the OPPs look like?
> >>>
> >>> How do I find that out?
> >>
> >> In /sys/kernel/debug/opp/cpu*/
> >> or
> >> /sys/devices/system/cpu/cpufreq/policy*/scaling_available_frequencies
> >> with related_cpus
> >>
> >
> > The energy model on the device is:
> >
> > CPU0-3:
> > +------------+------------+
> > | freq (khz) | power (uw) |
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+
> > |     339000 |      34362 |
> > |     400000 |      42099 |
> > |     500000 |      52907 |
> > |     600000 |      63795 |
> > |     700000 |      74747 |
> > |     800000 |      88445 |
> > |     900000 |     101444 |
> > |    1000000 |     120377 |
> > |    1100000 |     136859 |
> > |    1200000 |     154162 |
> > |    1300000 |     174843 |
> > |    1400000 |     196833 |
> > |    1500000 |     217052 |
> > |    1600000 |     247844 |
> > |    1700000 |     281464 |
> > |    1800000 |     321764 |
> > |    1900000 |     352114 |
> > |    2000000 |     383791 |
> > |    2100000 |     421809 |
> > |    2200000 |     461767 |
> > |    2300000 |     503648 |
> > |    2400000 |     540731 |
> > +------------+------------+
> >
> > CPU4-6:
> > +------------+------------+
> > | freq (khz) | power (uw) |
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+
> > |     622000 |     131738 |
> > |     700000 |     147102 |
> > |     800000 |     172219 |
> > |     900000 |     205455 |
> > |    1000000 |     233632 |
> > |    1100000 |     254313 |
> > |    1200000 |     288843 |
> > |    1300000 |     330863 |
> > |    1400000 |     358947 |
> > |    1500000 |     400589 |
> > |    1600000 |     444247 |
> > |    1700000 |     497941 |
> > |    1800000 |     539959 |
> > |    1900000 |     584011 |
> > |    2000000 |     657172 |
> > |    2100000 |     746489 |
> > |    2200000 |     822854 |
> > |    2300000 |     904913 |
> > |    2400000 |    1006581 |
> > |    2500000 |    1115458 |
> > |    2600000 |    1205167 |
> > |    2700000 |    1330751 |
> > |    2800000 |    1450661 |
> > |    2900000 |    1596740 |
> > |    3000000 |    1736568 |
> > |    3100000 |    1887001 |
> > |    3200000 |    2048877 |
> > |    3300000 |    2201141 |
> > +------------+------------+
> >
> > CPU7:
> >
> > +------------+------------+
> > | freq (khz) | power (uw) |
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+
> > |     798000 |     320028 |
> > |     900000 |     330714 |
> > |    1000000 |     358108 |
> > |    1100000 |     384730 |
> > |    1200000 |     410669 |
> > |    1300000 |     438355 |
> > |    1400000 |     469865 |
> > |    1500000 |     502740 |
> > |    1600000 |     531645 |
> > |    1700000 |     560380 |
> > |    1800000 |     588902 |
> > |    1900000 |     617278 |
> > |    2000000 |     645584 |
> > |    2100000 |     698653 |
> > |    2200000 |     744179 |
> > |    2300000 |     810471 |
> > |    2400000 |     895816 |
> > |    2500000 |     985234 |
> > |    2600000 |    1097802 |
> > |    2700000 |    1201162 |
> > |    2800000 |    1332076 |
> > |    2900000 |    1439847 |
> > |    3000000 |    1575917 |
> > |    3100000 |    1741987 |
> > |    3200000 |    1877346 |
> > |    3300000 |    2161512 |
> > |    3400000 |    2437879 |
> > |    3500000 |    2933742 |
> > |    3600000 |    3322959 |
> > |    3626000 |    3486345 |
> > +------------+------------+
> >
> >>>
> >>>> Does this system use uclamp during the benchmark? How?
> >>>
> >>> How do I find that out?
> >>
> >> it can be set per cgroup
> >> /sys/fs/cgroup/system.slice/<name>/cpu.uclam.min|max
> >> or per task with sched_setattr()
> >>
> >> You most probably use it because it's the main reason for ada8d7fa0ad4
> >> to remove wrong overestimate of OPP
> >>
> >
> > For the speedometer case, yes, we set the uclamp.min to 20 for the whol=
e
> > browser and UI (chrome).
> > There's no system-wide uclamp settings though.
>
> (From Sergey's traces)
> Per-cluster time=E2=80=91weighted average frequency base =3D> revert:
> little (cpu0=E2=80=933, max 2.4=E2=80=AFGHz): 0.746=E2=80=AFGHz =3D> 1.13=
2=E2=80=AFGHz (+51.6%)
> mid (cpu4=E2=80=936, max 3.3=E2=80=AFGHz): 1.043=E2=80=AFGHz =3D> 1.303=
=E2=80=AFGHz (+24.9%)
> big (cpu7, max 3.626=E2=80=AFGHz): 2.563=E2=80=AFGHz =3D> 3.116=E2=80=AFG=
Hz (+21.6%)
>
> And in particular time spent at OPPs (base =3D> revert):
> Big core at upper 10%: 29.6% =3D> 61.5%
> little cluster at 339=E2=80=AFMHz: 50.1% =3D> 1.0%
>
> Interesting that a uclamp.min of 20 (which shouldn't really have
> much affect on big CPU at all, with or without headroom AFAICS?)
> makes such a big difference here?

Yu-che, could you give us the capacity-dmips-mhz of each cpu (it's in the D=
T) ?

it could be that :
the diff for big 21%
the diff for mid (24% * mid capacity ratio) ~ 20%
and probably for Little too (51% * little capacity ratio) ~ 20%

The patch fixes a problem that sometime the min clamping was wrongly
added to the utilization

>
> >
> > But we also found other performance regressions in an Android guest VM,
> > where there's no uclamp for the VM and vCPU processes from the host sid=
e.
> > Particularly, the RAR extraction throughput reduces about 20% in the RA=
R
> > app (from RARLAB).
> > Although it's hard to tell if this is some sort of a side-effect of the=
 UI
> > regression as the UI is also running at the same time.
> >
> I'd be inclined to say that is because of the vastly different DVFS from =
the
> UI workload, yes.

