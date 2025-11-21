Return-Path: <linux-pm+bounces-38388-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCD0C7B51B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 19:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059083A24EC
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8C326E71E;
	Fri, 21 Nov 2025 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PBoi56Uu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F036D4EE
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763749569; cv=none; b=gx7dpmdNN+zyhoxvQ4AC+m3DSlaaHXy2Y/hioQFLR/Q1jNXZCAFvChRqziRCv51UvPjEkW3fgW5kLXrJmtwW03S0Ijm6tNl4tQ9oGVBHQryQ/TOYAPxafTu3g3rHsP4Y8fTsKPURqH9LGJgY/hniJVcP44cAPhol2t6YHrFdk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763749569; c=relaxed/simple;
	bh=S7ncaFSXrDRUcpuxjCEObCqk6jdfJ1tSnsljVvQjV0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JS7JHpEoT/faHD5o+fz9aFOGnNIaAOhdxTDfvvlsB35ZqFExnOcmI2owyekX7qIbejMnDGYHejGCYqqihebVVgCh8pFRgpLBMjNQg4QhfGPAl03LGOCXjPPL9xLvCV07w0JsbEyCi5Frl2Z3XrN2arocO56Zs6chvlAp4qzO99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PBoi56Uu; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso1847890137.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 10:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763749566; x=1764354366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJNBnw2ilkZH7/4hlnEErRDhVEPM2ikqrSQ8rztPE3s=;
        b=PBoi56Uu9Fa9XQfgSy93It2OGJb/ZHlKzMgz+WuiN3oyorZ+lnQbw9Zo2trrVtPqfI
         +olKjdFqjmV7HDKUzod1TpwgvpsKVdJ8kSpqw6sX1ErEg39AG6ecKGzIqos6DHuP/xmD
         7x+Bkm1gSQ+rNeY0wQ5PW8eeRe/tcb27IKHxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763749566; x=1764354366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJNBnw2ilkZH7/4hlnEErRDhVEPM2ikqrSQ8rztPE3s=;
        b=IrHvdf5/8IQ/CG+WBg/f4iF/VSEkPbg7CKU14HigJI0oNHOZnBPumv/aUOLCC5PGjX
         blk6hWSB0LmGBLgjaoYgA+LDh8kFIvIBdWcVXKh13UdFlJWYKMyhbX3k1raAG/LUHX1M
         P74D/xDhLVqCgthsTUvBT5SbthNCBZzAPGLU3f7EKD+T/OIIw6+cBu4zaHAJVdTrrteA
         L8f64DatdjTCQe8vYiMTluqqjpWA0N0wLlWBTZdXP3M7AfNFGvvY9ejG8PWC9YQJnIb1
         Ely+QHC2s1vCVfi/yrtNDzgXAdfg0KWnsMcOZnJF/F/031jsf/fYoLmtsCOQQhO+2Zdz
         bYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtcZBOBxAIoyFEixlFTJOwIE4ivJnVDSSr2+feinE+sKNFyjX6Cll9KIGBjIhVu1TW9LFb7Rs5CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg1DmBUr/8nJHQ/rHDj5W83H7pqzBQD2lOkdq4zU+XIDsVrlCL
	ddQAYMpRzD+DW96+coDH1t0tikxki4/SCFk+3H8VIQMHFxEY/bJlud5OUW9FqMAY9gsjmRR2j51
	6uDI=
X-Gm-Gg: ASbGnctr0Bp+PAh2oDrG69pq8xtXAOco/uD9TsAibwgbWySA8m479LHGWR5WCXvQLLf
	ZFZWNmM5IhpXprr/0l2BymN1otUt2xAJq2SWM/9P1CDHdJMTr5bFfyKPcDqPCpFVL2Dfye1eSiX
	GgVUDYDRHUT4kjhLs1aSCkZGCjaHOHy7KEmNYorhWQ6u5y7mUAig+uGd9GQiqHI34IkiGvMqxso
	2GdgpmOzqcpFn5F9pGfbfo4SR5Qr4mg0UL3FDYFFx778dVBeOUj+kO7C9aORN3fnfOeXHt70n7s
	YcQWIjT3Fva5fnI8ewcWUYfWfQysJBponB1JmqWsF6b0ipUshA7VzWDzUQG4cXy7ujVeul7NsGs
	0kPhcjjirkRo2+dqi7MEPn3gPaymsXFqzl8IGNKEZ/oXanu5hYeGAkHWAq8Jp3od0EmF3Sv0JXo
	reBcAdXhiXGpVA4SdU3/BITZpLCZP5pFuwhS7GvvnrTTf3Ew==
X-Google-Smtp-Source: AGHT+IG+F+tPaQp3zZyd0KGYo7Agwp+mzOED95JmC2o2EWr2RsWqqmkruICkRVYJgy1rQ3YYgIlwJA==
X-Received: by 2002:a05:6102:50a6:b0:5db:a311:2436 with SMTP id ada2fe7eead31-5e1c4129f79mr3511366137.16.1763749566131;
        Fri, 21 Nov 2025 10:26:06 -0800 (PST)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93c564c8261sm2726251241.10.2025.11.21.10.26.04
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 10:26:04 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dfaceec8deso1518051137.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 10:26:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUms00/+yeF+P6Hz97ydZBbfNcG7/NXkew8t1sGDZOopm3CyEuY0bhsI79n6sEZKOwsuk5Iiwhyeg==@vger.kernel.org
X-Received: by 2002:a05:6102:e0a:b0:5d6:85a:229f with SMTP id
 ada2fe7eead31-5e1c412732dmr3356465137.15.1763749564202; Fri, 21 Nov 2025
 10:26:04 -0800 (PST)
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
 <6e50830f-a1b8-452a-86a7-1621cd3968ce@arm.com> <CAKfTPtB-+DeZQyLNRQjvCyM2KjDK2cLpM29UmW++oe=Tcu5AoA@mail.gmail.com>
In-Reply-To: <CAKfTPtB-+DeZQyLNRQjvCyM2KjDK2cLpM29UmW++oe=Tcu5AoA@mail.gmail.com>
From: Yu-Che Cheng <giver@chromium.org>
Date: Sat, 22 Nov 2025 02:25:26 +0800
X-Gmail-Original-Message-ID: <CAKchOA09xSFogHAZm9F2uC+YVf_XNMXEmRwUbHwAFsoeiCBk0A@mail.gmail.com>
X-Gm-Features: AWmQ_bld6OeY65mD9BD3AOENEDUmJdGcxg7KIWSFVA5QfzzhwaPjw3w-fXb4f7E
Message-ID: <CAKchOA09xSFogHAZm9F2uC+YVf_XNMXEmRwUbHwAFsoeiCBk0A@mail.gmail.com>
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

On Sat, Nov 22, 2025 at 1:58=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 21 Nov 2025 at 17:35, Christian Loehle <christian.loehle@arm.com>=
 wrote:
> >
> > On 11/21/25 15:37, Yu-Che Cheng wrote:
> > > Hi Vincent,
> > >
> > > On Fri, Nov 21, 2025 at 10:00=E2=80=AFPM Vincent Guittot <vincent.gui=
ttot@linaro.org>
> > > wrote:
> > >>
> > >> On Fri, 21 Nov 2025 at 04:55, Sergey Senozhatsky
> > >> <senozhatsky@chromium.org> wrote:
> > >>>
> > >>> Hi Christian,
> > >>>
> > >>> On (25/11/20 10:15), Christian Loehle wrote:
> > >>>> On 11/20/25 04:45, Sergey Senozhatsky wrote:
> > >>>>> Hi,
> > >>>>>
> > >>>>> We are observing a performance regression on one of our arm64
> > > boards.
> > >>>>> We tracked it down to the linux-6.6.y commit ada8d7fa0ad4
> > > ("sched/cpufreq:
> > >>
> > >> You mentioned that you tracked down to linux-6.6.y but which kernel
> > >> are you using ?
> > >>
> > >
> > > We're using ChromeOS 6.6 kernel, which is currently on top of linux-v=
6.6.99.
> > > But we've tested that the performance regression still happens on exa=
ctly
> > > the same scheduler codes (`kernel/sched`) as upstream v6.6.99, compar=
ed to
> > > those on v6.6.88.
> > >
> > >>>>> Rework schedutil governor performance estimation").
> > >>>>>
> > >>>>> UI speedometer benchmark:
> > >>>>> w/commit:   395  +/-38
> > >>>>> w/o commit: 439  +/-14
> > >>>>>
> > >>>>
> > >>>> Hi Sergey,
> > >>>> Would be nice to get some details. What board?
> > >>>
> > >>> It's an MT8196 chromebook.
> > >>>
> > >>>> What do the OPPs look like?
> > >>>
> > >>> How do I find that out?
> > >>
> > >> In /sys/kernel/debug/opp/cpu*/
> > >> or
> > >> /sys/devices/system/cpu/cpufreq/policy*/scaling_available_frequencie=
s
> > >> with related_cpus
> > >>
> > >
> > > The energy model on the device is:
> > >
> > > CPU0-3:
> > > +------------+------------+
> > > | freq (khz) | power (uw) |
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> > > |     339000 |      34362 |
> > > |     400000 |      42099 |
> > > |     500000 |      52907 |
> > > |     600000 |      63795 |
> > > |     700000 |      74747 |
> > > |     800000 |      88445 |
> > > |     900000 |     101444 |
> > > |    1000000 |     120377 |
> > > |    1100000 |     136859 |
> > > |    1200000 |     154162 |
> > > |    1300000 |     174843 |
> > > |    1400000 |     196833 |
> > > |    1500000 |     217052 |
> > > |    1600000 |     247844 |
> > > |    1700000 |     281464 |
> > > |    1800000 |     321764 |
> > > |    1900000 |     352114 |
> > > |    2000000 |     383791 |
> > > |    2100000 |     421809 |
> > > |    2200000 |     461767 |
> > > |    2300000 |     503648 |
> > > |    2400000 |     540731 |
> > > +------------+------------+
> > >
> > > CPU4-6:
> > > +------------+------------+
> > > | freq (khz) | power (uw) |
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> > > |     622000 |     131738 |
> > > |     700000 |     147102 |
> > > |     800000 |     172219 |
> > > |     900000 |     205455 |
> > > |    1000000 |     233632 |
> > > |    1100000 |     254313 |
> > > |    1200000 |     288843 |
> > > |    1300000 |     330863 |
> > > |    1400000 |     358947 |
> > > |    1500000 |     400589 |
> > > |    1600000 |     444247 |
> > > |    1700000 |     497941 |
> > > |    1800000 |     539959 |
> > > |    1900000 |     584011 |
> > > |    2000000 |     657172 |
> > > |    2100000 |     746489 |
> > > |    2200000 |     822854 |
> > > |    2300000 |     904913 |
> > > |    2400000 |    1006581 |
> > > |    2500000 |    1115458 |
> > > |    2600000 |    1205167 |
> > > |    2700000 |    1330751 |
> > > |    2800000 |    1450661 |
> > > |    2900000 |    1596740 |
> > > |    3000000 |    1736568 |
> > > |    3100000 |    1887001 |
> > > |    3200000 |    2048877 |
> > > |    3300000 |    2201141 |
> > > +------------+------------+
> > >
> > > CPU7:
> > >
> > > +------------+------------+
> > > | freq (khz) | power (uw) |
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D+
> > > |     798000 |     320028 |
> > > |     900000 |     330714 |
> > > |    1000000 |     358108 |
> > > |    1100000 |     384730 |
> > > |    1200000 |     410669 |
> > > |    1300000 |     438355 |
> > > |    1400000 |     469865 |
> > > |    1500000 |     502740 |
> > > |    1600000 |     531645 |
> > > |    1700000 |     560380 |
> > > |    1800000 |     588902 |
> > > |    1900000 |     617278 |
> > > |    2000000 |     645584 |
> > > |    2100000 |     698653 |
> > > |    2200000 |     744179 |
> > > |    2300000 |     810471 |
> > > |    2400000 |     895816 |
> > > |    2500000 |     985234 |
> > > |    2600000 |    1097802 |
> > > |    2700000 |    1201162 |
> > > |    2800000 |    1332076 |
> > > |    2900000 |    1439847 |
> > > |    3000000 |    1575917 |
> > > |    3100000 |    1741987 |
> > > |    3200000 |    1877346 |
> > > |    3300000 |    2161512 |
> > > |    3400000 |    2437879 |
> > > |    3500000 |    2933742 |
> > > |    3600000 |    3322959 |
> > > |    3626000 |    3486345 |
> > > +------------+------------+
> > >
> > >>>
> > >>>> Does this system use uclamp during the benchmark? How?
> > >>>
> > >>> How do I find that out?
> > >>
> > >> it can be set per cgroup
> > >> /sys/fs/cgroup/system.slice/<name>/cpu.uclam.min|max
> > >> or per task with sched_setattr()
> > >>
> > >> You most probably use it because it's the main reason for ada8d7fa0a=
d4
> > >> to remove wrong overestimate of OPP
> > >>
> > >
> > > For the speedometer case, yes, we set the uclamp.min to 20 for the wh=
ole
> > > browser and UI (chrome).
> > > There's no system-wide uclamp settings though.
> >
> > (From Sergey's traces)
> > Per-cluster time=E2=80=91weighted average frequency base =3D> revert:
> > little (cpu0=E2=80=933, max 2.4=E2=80=AFGHz): 0.746=E2=80=AFGHz =3D> 1.=
132=E2=80=AFGHz (+51.6%)
> > mid (cpu4=E2=80=936, max 3.3=E2=80=AFGHz): 1.043=E2=80=AFGHz =3D> 1.303=
=E2=80=AFGHz (+24.9%)
> > big (cpu7, max 3.626=E2=80=AFGHz): 2.563=E2=80=AFGHz =3D> 3.116=E2=80=
=AFGHz (+21.6%)
> >
> > And in particular time spent at OPPs (base =3D> revert):
> > Big core at upper 10%: 29.6% =3D> 61.5%
> > little cluster at 339=E2=80=AFMHz: 50.1% =3D> 1.0%
> >
> > Interesting that a uclamp.min of 20 (which shouldn't really have
> > much affect on big CPU at all, with or without headroom AFAICS?)
> > makes such a big difference here?
>
> Yu-che, could you give us the capacity-dmips-mhz of each cpu (it's in the=
 DT) ?
>
> it could be that :
> the diff for big 21%
> the diff for mid (24% * mid capacity ratio) ~ 20%
> and probably for Little too (51% * little capacity ratio) ~ 20%
>
> The patch fixes a problem that sometime the min clamping was wrongly
> added to the utilization
>

Sure. The capacity-dmips-mhz for CPU0-3, CPU4-6, CPU7 are 714, 835,
1024 respectively.
That is, the corresponding cpu_capacity are 472, 759, 1024 respectively.
It looks like the frequency differences are indeed close to 20% after
multiplying the cpu capacity ratio.

> >
> > >
> > > But we also found other performance regressions in an Android guest V=
M,
> > > where there's no uclamp for the VM and vCPU processes from the host s=
ide.
> > > Particularly, the RAR extraction throughput reduces about 20% in the =
RAR
> > > app (from RARLAB).
> > > Although it's hard to tell if this is some sort of a side-effect of t=
he UI
> > > regression as the UI is also running at the same time.
> > >
> > I'd be inclined to say that is because of the vastly different DVFS fro=
m the
> > UI workload, yes.

