Return-Path: <linux-pm+bounces-38380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F007C7AAF5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 16:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6F03A2AF0
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 15:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65037336EF7;
	Fri, 21 Nov 2025 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M4K/yU+3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927742D9EC7
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740467; cv=none; b=X25IAEKqwkMY2MUED9ZRvU4A1J6FYZRT4XyGVTJkFbt+U5mSzVIjmdHA03cXOEHMLrktPFWbgWA2o6WWJ2EpWrysxcHCPQpw4HjY5rVwdJa5PrC+JDU8pcYnd61GeII9KHXjC28RwZk5MiBjTTFCSFZfGi7qsJVsVEHGgHF86SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740467; c=relaxed/simple;
	bh=CSzS5noCEE5PWQvUphRjNHfuR40Fqs3MLNv0oZstaW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fh1gKrnQH3I5iMG8lG+bc1LGfeL1qqWUEJ2dZ1QZQApmuQ/JqJmiKdbO1DteBFZQH6MBr6f1oUCEpYCEzAWbp3extAb3yDbG3od9TtsCMDo7sLEZm2SQaLq0g2NlYa9C53oJ6O4lPFgzG7rhoy1fGggYdby70YVXbOv2B2xUkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M4K/yU+3; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-559966a86caso601299e0c.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 07:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763740464; x=1764345264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfT2bQElUpzvxBFgvql/qjDEiLfZvX/L5WNx/vnBEGM=;
        b=M4K/yU+3Ft3hnJ1leTcZuv7E7pV2xFUHh6gYx9I+6i8oOOdEAox+VH9i7Yx4ljPQOF
         Didziwc33ISsXTI2vtl1X3Ca/qDlzHQAtQoVOxOV9aBha7KJQoD0q42vpiQyBNTa+1WW
         P3bZ9Q2ioz43QX7VNqdAU5Xib2lSKKxKYFqBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763740464; x=1764345264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WfT2bQElUpzvxBFgvql/qjDEiLfZvX/L5WNx/vnBEGM=;
        b=HQO/B+vnJRfLjpsTyrNrQK8cGUFb/MUvN+1UfoluQV3CPJq5jAAj2fwyT21E5K9r4T
         nZ2G01xaU4MKVrpAmzag7tl7UN+2hs7oxGoubnPwon5nXMInrHHhXpz27TfVrgEwvzbQ
         58Pwy8AS1ObH63xkC/j+NIc75ekDLMIp7TaN6twmPb6VSov3kc25nUQAXrQzP8+5CUyO
         J9+z7G0yjWwioDSVi9AJ2BUVRW3HaxWo12duzqsPkAIguF7cwKZBPETcGTlDp0qYOedI
         KWDHG7eJLFJmHpjlYh5xG76X8O93P81M14F5FHawjZ7xoslY2eyA5ofVoArt+ciqfMBs
         FvHA==
X-Forwarded-Encrypted: i=1; AJvYcCVGejbP02lfhBrfqUMJdNq2DrEA33DfJDPwNlx2TD2riBpPvhozBE2pLp9BJoTCJNNoPYyVpxr4Fg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6jv4PXVTyEDENV2HW2l8DFMNtQl1rHJoOC4dblNV/IuwG6PVY
	ic2GnCETKUd3SMwLKPDhzjlxR5vUdkUWB4CS/9nY6XI/W0AlMBwEuQ66hLsaioxWbQKX4F5TraG
	9LAhFbQ==
X-Gm-Gg: ASbGnct1lc4ULjdJAxdagx6gF4Wp9ccMD3BF6IwElCDpqicH3PXZnS/4xyjUNGyDICr
	cI0XH2HsNBa+A/6ZGc2Q5ADd8hpm4Xf5Tf8eWk0w1ymKEIUvQM0o1uGyheYdN4bAITeRf4ga8QX
	X5o7UiNbLt44Rj5/d9ZSdCRjDnX+6qmMaMWOY4fA8Fv7x6XO9z0rCm2tM6hIFPDlIbq4jDJ6DfZ
	8tVIVotyhXFf9fnIcXhYdO8dDp3tpCCFpnpF/Pa2Cv1s++MYOIy03xJGIAqOLZzJeec3y3KwKT0
	77bYS4TGT4vINlZJKG/3UcDR2SS08B2yz1dLxm+rIzuauI2J6KQhLW9KUSwIqDGzJ8x00KcMkV8
	4f0+cAOH4tnMPwB/zWkj3i9naKpaV1OW/FJ7Rr8itXLcyAsoL804NgBZAvhoznLNjxVh7O+Z8rt
	worYw9AH5QeoJVZ2Q8aLbch9rHJ5lXz8QlN65jwVSRGv4eA+2Yg40G6Q6X
X-Google-Smtp-Source: AGHT+IGCAzyDvaWBxw4XCpuHdgXTGEvv7wcdlJO4YZ0S+JL+Mvy4t/PMnVBWhF/71h6CKuhv8ITe6w==
X-Received: by 2002:a05:6122:792:b0:55b:d85:507a with SMTP id 71dfb90a1353d-55b8d6d9a8dmr874092e0c.7.1763740464238;
        Fri, 21 Nov 2025 07:54:24 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f7a1158sm2601094e0c.16.2025.11.21.07.54.21
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 07:54:23 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5d758dba570so1001736137.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 07:54:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU50kRn4thW1K0/IHHnIqikxtVJmZEoslRSFxEFSS4m5nxByNnMztgVcoUMpchEbm0XHVeAfKwMhA==@vger.kernel.org
X-Received: by 2002:a05:6102:5109:b0:5de:6dc:2296 with SMTP id
 ada2fe7eead31-5e1de2cfa42mr812358137.31.1763740460694; Fri, 21 Nov 2025
 07:54:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com> <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
 <CAKfTPtBBtMysuYgBYZR2EH=WPR7X5F_RRzGmf94UhyDiGmmqCg@mail.gmail.com>
In-Reply-To: <CAKfTPtBBtMysuYgBYZR2EH=WPR7X5F_RRzGmf94UhyDiGmmqCg@mail.gmail.com>
From: Yu-Che Cheng <giver@chromium.org>
Date: Fri, 21 Nov 2025 23:53:43 +0800
X-Gmail-Original-Message-ID: <CAKchOA3Kxc6M+nih7sEinOZnMX3qO60hF+jWHCfW5PZh10F-hA@mail.gmail.com>
X-Gm-Features: AWmQ_bmTRD3G8jYZB_E6oSM7wsgR8D-CwYDwL9AzeqFT7s6u44NVAeuBQjm6m6c
Message-ID: <CAKchOA3Kxc6M+nih7sEinOZnMX3qO60hF+jWHCfW5PZh10F-hA@mail.gmail.com>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Christian Loehle <christian.loehle@arm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukasz Luba <lukasz.luba@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry that I accidentally sent in non-plain-text mode... Resend the
email to the mailing list again.

Hi Vincent,

On Fri, Nov 21, 2025 at 10:00=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 21 Nov 2025 at 04:55, Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > Hi Christian,
> >
> > On (25/11/20 10:15), Christian Loehle wrote:
> > > On 11/20/25 04:45, Sergey Senozhatsky wrote:
> > > > Hi,
> > > >
> > > > We are observing a performance regression on one of our arm64 board=
s.
> > > > We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/c=
pufreq:
>
> You mentioned that you tracked down to linux-6.6.y but which kernel
> are you using ?
>

We're using ChromeOS 6.6 kernel, which is currently on top of linux-v6.6.99=
.
But we've tested that the performance regression also happens on
exactly the same scheduler codes (`kernel/sched`) as upstream v6.6.99,
compared to those on v6.6.88.

> > > > Rework schedutil governor performance estimation").
> > > >
> > > > UI speedometer benchmark:
> > > > w/commit:   395  +/-38
> > > > w/o commit: 439  +/-14
> > > >
> > >
> > > Hi Sergey,
> > > Would be nice to get some details. What board?
> >
> > It's an MT8196 chromebook.
> >
> > > What do the OPPs look like?
> >
> > How do I find that out?
>
> In /sys/kernel/debug/opp/cpu*/
> or
> /sys/devices/system/cpu/cpufreq/policy*/scaling_available_frequencies
> with related_cpus
>

The energy model on the device is:

CPU0-3:
+------------+------------+
| freq (khz) | power (uw) |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
|     339000 |      34362 |
|     400000 |      42099 |
|     500000 |      52907 |
|     600000 |      63795 |
|     700000 |      74747 |
|     800000 |      88445 |
|     900000 |     101444 |
|    1000000 |     120377 |
|    1100000 |     136859 |
|    1200000 |     154162 |
|    1300000 |     174843 |
|    1400000 |     196833 |
|    1500000 |     217052 |
|    1600000 |     247844 |
|    1700000 |     281464 |
|    1800000 |     321764 |
|    1900000 |     352114 |
|    2000000 |     383791 |
|    2100000 |     421809 |
|    2200000 |     461767 |
|    2300000 |     503648 |
|    2400000 |     540731 |
+------------+------------+

CPU4-6:
+------------+------------+
| freq (khz) | power (uw) |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
|     622000 |     131738 |
|     700000 |     147102 |
|     800000 |     172219 |
|     900000 |     205455 |
|    1000000 |     233632 |
|    1100000 |     254313 |
|    1200000 |     288843 |
|    1300000 |     330863 |
|    1400000 |     358947 |
|    1500000 |     400589 |
|    1600000 |     444247 |
|    1700000 |     497941 |
|    1800000 |     539959 |
|    1900000 |     584011 |
|    2000000 |     657172 |
|    2100000 |     746489 |
|    2200000 |     822854 |
|    2300000 |     904913 |
|    2400000 |    1006581 |
|    2500000 |    1115458 |
|    2600000 |    1205167 |
|    2700000 |    1330751 |
|    2800000 |    1450661 |
|    2900000 |    1596740 |
|    3000000 |    1736568 |
|    3100000 |    1887001 |
|    3200000 |    2048877 |
|    3300000 |    2201141 |
+------------+------------+

CPU7:

+------------+------------+
| freq (khz) | power (uw) |
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
|     798000 |     320028 |
|     900000 |     330714 |
|    1000000 |     358108 |
|    1100000 |     384730 |
|    1200000 |     410669 |
|    1300000 |     438355 |
|    1400000 |     469865 |
|    1500000 |     502740 |
|    1600000 |     531645 |
|    1700000 |     560380 |
|    1800000 |     588902 |
|    1900000 |     617278 |
|    2000000 |     645584 |
|    2100000 |     698653 |
|    2200000 |     744179 |
|    2300000 |     810471 |
|    2400000 |     895816 |
|    2500000 |     985234 |
|    2600000 |    1097802 |
|    2700000 |    1201162 |
|    2800000 |    1332076 |
|    2900000 |    1439847 |
|    3000000 |    1575917 |
|    3100000 |    1741987 |
|    3200000 |    1877346 |
|    3300000 |    2161512 |
|    3400000 |    2437879 |
|    3500000 |    2933742 |
|    3600000 |    3322959 |
|    3626000 |    3486345 |
+------------+------------+

> >
> > > Does this system use uclamp during the benchmark? How?
> >
> > How do I find that out?
>
> it can be set per cgroup
> /sys/fs/cgroup/system.slice/<name>/cpu.uclam.min|max
> or per task with sched_setattr()
>
> You most probably use it because it's the main reason for ada8d7fa0ad4
> to remove wrong overestimate of OPP
>

For the speedometer case, yes, we set the uclamp.min to 20 for the
whole browser and UI (chrome).
There's no system-wide uclamp settings though.

But we also found other performance regressions in an Android guest
VM, where there's no uclamp for the VM and vCPU processes from the
host side.
Particularly, the RAR extraction throughput reduces about 20% in the
RAR app (from RARLAB).
Although it's hard to tell if this is some sort of a side-effect of
the UI regression as the UI is also running at the same time.

> >
> > > Given how large the stddev given by speedometer (version 3?) itself i=
s, can we get the
> > > stats of a few runs?

By the way, it's speedometer version 2.0 (or 2.1).

> >
> > v2.1
> >
> > w/o patch     w/ patch
> > 440 +/-30     406 +/-11
> > 440 +/-14     413 +/-16
> > 444 +/-12     403 +/-14
> > 442 +/-12     412 +/-15
> >
> > > Maybe traces of cpu_frequency for both w/ and w/o?
> >
> > trace-cmd record -e power:cpu_frequency attached.
> >
> > "base" is with ada8d7fa0ad4
> > "revert" is ada8d7fa0ad4 reverted.

