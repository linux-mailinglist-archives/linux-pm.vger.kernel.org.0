Return-Path: <linux-pm+bounces-19568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D7D9F8FE4
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 11:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E36616F1D0
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672BC1B041E;
	Fri, 20 Dec 2024 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="AfjSsE3E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2571A4E98
	for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689363; cv=none; b=MSpt3RRxMZA4eqOGSz5BnDbV5Bl2ZxtjDRSLgiT8lI3RwXZyAR4vZAR4zXGwmQBCFPjzkRbyy5Xm2IT040BgcuMF+mlhv1TN5GBt3pU35KgEQiFwJhzjIN5zCiKwyd3jS8bBbIF+t6jVMmB5xTQxojmLmxCQTbQLAqrxaoYne5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689363; c=relaxed/simple;
	bh=yoNxh/m4jHDclCjhR+pnB2q9IhCVFygOpJyUDV3X55I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+jnE9S2uyPHpjcf7FvlyKTMDboOWqc+kv5E1JKg0FfNv8QFfqzlROFCQY60Db3D1bCH42/DEjCBWDe0JOX1mAx2SHBgvWQb2hs5b0c4yQ8QIlb949KyzBZ+BikRcKz0cu1lCzFZ49Dliu1ZqAl/m5B6xnLdz8FIdT7cfu0yP0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=AfjSsE3E; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-72739105e02so1861645b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 02:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1734689360; x=1735294160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWD46z8mCKxB7nZv4dYW/rXeeoZekpd1lRTfgizfnfQ=;
        b=AfjSsE3EczBAd13Tz0b7b/JdNwHAEr+/5IaqyzGLqU+antYsvrMWNRbZY+1Fr/kHZz
         prQjKvz/kbwgXV2v5CuKzPTB44ooVzM4zhkP4kVtwFQivjVBJnlArHp/CIn1P/p7AB3E
         QG5H29uZppO2i7fCMti6gT9wkGQ2TiA0LTbz01IEDgw/1dBzST3fHxr2x+dUTbi9C3ih
         tQSvqZa/A1RIFww4FWCGJIL2GU7he1GLgzZvRXU1mj1stHik/7BcnT57VsIi7tDwNWH/
         6H1Xq/vo3JaGs/bCf55xWoTezAMDUmYgiDtlCkAwOEfU8IAnnenJ7l0tSQZLWYcOlU3G
         G6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734689360; x=1735294160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWD46z8mCKxB7nZv4dYW/rXeeoZekpd1lRTfgizfnfQ=;
        b=OF0LobgxytJaoKmZY1MDR3/bMcddSAqBoliz2gD0zYBkeelCUzeQLeb/w2M9Cjdo65
         uVNZKf3hYcr4sNEmuCxaZ65kGh5Xl2fYr3WTumwXs9togrFMss7d9nEkbTxs4fWzK4cV
         KH8L+sXZOXKhbD768qvNSmWBtYP+ApUgNcjAHJu5+Cmrl/j6qRGiwLMXEi10ytMdGPmP
         jIM9TnHsjHuQoRgLmGeRQsXZT61O36FZNCP7VH+EhQF3lmYTuhD2jCbdp3Bh5MjRjLcc
         xAp4rJqSLBSVkWnFPRW+WYnzAvOL/7j+B01MwjqiCO32+v3807vcNHQSWQVq2ECj0XGj
         vjEg==
X-Forwarded-Encrypted: i=1; AJvYcCVSjqZpdqoRZjNCcC1Gx1/IgX7lD3UWJ0OGwkzT9UCouhUXZe5bX/Kzn1Lf9rrFbwstsp8A8WmlKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2RRe7nGKKYbBnM0RbQe5Gz0/vwCowBJFQNCKdxROd+sClK6Fd
	jrMZ7F2zH28jc8TdHeBVdAZldwImlv1HSs8u+eiFnWUUp0wTU3uqC8hI1wz/61bFLZgrSTe1bj7
	Vr60gUgTh6flWFn3C+YdQbdrtSxlU3giNDLyiuw==
X-Gm-Gg: ASbGncvKny5g52oJkwkhwn16omyDRXIknnoOejKj8F4bunSHcUfYITklDCZ0eqrIFCk
	pBO4TKtl3mnK+fYSMTtCrYwcBtFAXJWz/lDVWRdg=
X-Google-Smtp-Source: AGHT+IEYIITqOgQxrCWh1lel6GOYmhCydE2lsfrPColCJnRFg9YORDdTjUMJNKf8r2+LbIE4SSEZwdwGATzgerwqs+A=
X-Received: by 2002:a05:6a00:44cc:b0:725:df1a:275 with SMTP id
 d2e1a72fcca58-72abdeb7016mr3766779b3a.23.1734689360341; Fri, 20 Dec 2024
 02:09:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219192144.2744863-1-naresh.solanki@9elements.com>
 <4239407f-2676-45c4-9730-70493e56e36c@amd.com> <CABqG17hUvdo4ShQzWPWpfNqJFiDCDHmApPnHahtTt83B1Thg9Q@mail.gmail.com>
 <CABqG17i93frSsRp4wHCPZSNn-yW9sookHvTy6qCExZXKs2D3gA@mail.gmail.com> <754bdf5a-8047-47c3-bacc-238d2d2a593f@amd.com>
In-Reply-To: <754bdf5a-8047-47c3-bacc-238d2d2a593f@amd.com>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Fri, 20 Dec 2024 15:39:09 +0530
Message-ID: <CABqG17j8gmewS5egmyMwHpWM3vL4ourE+4oqorQ+A8w7PAAyrQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Refactor max frequency calculation
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	Huang Rui <ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mario

Based on linux-next:
2024-12-20 11:02:53,078 INFO: =F0=9F=94=8B Kernel sysfs files
+---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------+
|   CPU # |   CPU Min Freq |   CPU Nonlinear Freq |   CPU Max Freq |
Scaling Min Freq |   Scaling Max Freq | Energy Performance Preference
 |   Prefcore |   Boost |
|---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------|
|       0 |         599000 |              2000000 |        5095000 |
         2000000 |            5095000 | performance
 |        208 |       1 |
|       1 |         599000 |              2000000 |        5095000 |
         2000000 |            5095000 | performance
 |        196 |       1 |
|       2 |         599000 |              2000000 |        5095000 |
         2000000 |            5095000 | performance
 |        202 |       1 |
|       3 |         599000 |              2000000 |        5095000 |
         2000000 |            5095000 | performance
 |        208 |       1 |
|       4 |         599000 |              1401000 |        5095000 |
         1401000 |            5095000 | performance
 |        128 |       1 |
|       5 |         599000 |              1401000 |        5095000 |
         1401000 |            5095000 | performance
 |        128 |       1 |
|       6 |         599000 |              1401000 |        5095000 |
         1401000 |            5095000 | performance
 |        128 |       1 |
|       7 |         599000 |              1401000 |        5095000 |
         1401000 |            5095000 | performance
 |        128 |       1 |
|       8 |         599000 |              1401000 |        5095000 |
         1401000 |            5095000 | performance
 |        128 |       1 |
|       9 |         599000 |              1401000 |        5095000 |
         1401000 |            5095000 | performance
 |        128 |       1 |
|      10 |         599000 |              2000000 |        5095000 |
         2000000 |            5095000 | performance
 |        208 |       1 |
|      11 |         599000 |              2000000 |        5095000 |
         2000000 |            5095000 | performance
 |        196 |       1 |
|      12 |         599000 |              2000000 |        5095000 |
         2000000 |            5095000 | performance
 |        202 |       1 |
|      13 |         599000 |              2000000 |        5095000 |
         2000000 |            5095000 | performance
 |        208 |       1 |
|      14 |         599000 |              1401000 |        5095000 |
         1401000 |            5095000 | performance
 |        128 |       1 |
|      15 |         599000 |              1401000 |        5095000 |
         1401000 |            5095000 | performance
 |        128 |       1 |
|      16 |         599000 |              1401000 |        5095000 |
         1401000 |            5095000 | performance
 |        128 |       1 |
|      17 |         599000 |              1401000 |        5095000 |
         1401000 |            5095000 | performance
 |        128 |       1 |
|      18 |         599000 |              1401000 |        5095000 |
         1401000 |            5095000 | performance
 |        128 |       1 |
|      19 |         599000 |              1401000 |        5095000 |
         1401000 |            5095000 | performance
 |        128 |       1 |
+---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------+

Based on V3 changes:
+---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------+
|   CPU # |   CPU Min Freq |   CPU Nonlinear Freq |   CPU Max Freq |
Scaling Min Freq |   Scaling Max Freq | Energy Performance Preference
 |   Prefcore |   Boost |
|---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------|
|       0 |         599000 |              2002000 |        5096000 |
         2002000 |            5096000 | performance
 |        208 |       1 |
|       1 |         599000 |              2002000 |        5096000 |
         2002000 |            5096000 | performance
 |        196 |       1 |
|       2 |         599000 |              2002000 |        5096000 |
         2002000 |            5096000 | performance
 |        202 |       1 |
|       3 |         599000 |              2002000 |        5096000 |
         2002000 |            5096000 | performance
 |        208 |       1 |
|       4 |         599000 |              1404000 |        5096000 |
         1404000 |            5096000 | performance
 |        128 |       1 |
|       5 |         599000 |              1404000 |        5096000 |
         1404000 |            5096000 | performance
 |        128 |       1 |
|       6 |         599000 |              1404000 |        5096000 |
         1404000 |            5096000 | performance
 |        128 |       1 |
|       7 |         599000 |              1404000 |        5096000 |
         1404000 |            5096000 | performance
 |        128 |       1 |
|       8 |         599000 |              1404000 |        5096000 |
         1404000 |            5096000 | performance
 |        128 |       1 |
|       9 |         599000 |              1404000 |        5096000 |
         1404000 |            5096000 | performance
 |        128 |       1 |
|      10 |         599000 |              2002000 |        5096000 |
         2002000 |            5096000 | performance
 |        208 |       1 |
|      11 |         599000 |              2002000 |        5096000 |
         2002000 |            5096000 | performance
 |        196 |       1 |
|      12 |         599000 |              2002000 |        5096000 |
         2002000 |            5096000 | performance
 |        202 |       1 |
|      13 |         599000 |              2002000 |        5096000 |
         2002000 |            5096000 | performance
 |        208 |       1 |
|      14 |         599000 |              1404000 |        5096000 |
         1404000 |            5096000 | performance
 |        128 |       1 |
|      15 |         599000 |              1404000 |        5096000 |
         1404000 |            5096000 | performance
 |        128 |       1 |
|      16 |         599000 |              1404000 |        5096000 |
         1404000 |            5096000 | performance
 |        128 |       1 |
|      17 |         599000 |              1404000 |        5096000 |
         1404000 |            5096000 | performance
 |        128 |       1 |
|      18 |         599000 |              1404000 |        5096000 |
         1404000 |            5096000 | performance
 |        128 |       1 |
|      19 |         599000 |              1404000 |        5096000 |
         1404000 |            5096000 | performance
 |        128 |       1 |
+---------+----------------+----------------------+----------------+-------=
-------------+--------------------+---------------------------------+------=
------+---------+


Regards,
Naresh

Regards,
Naresh Solanki



9elements GmbH, Kortumstra=C3=9Fe 19-21, 44787 Bochum, Germany
Email:  naresh.solanki@9elements.com
Mobile:  +91 9538631477

Sitz der Gesellschaft: Bochum
Handelsregister: Amtsgericht Bochum, HRB 17519
Gesch=C3=A4ftsf=C3=BChrung: Sebastian Deutsch, Eray Basar

Datenschutzhinweise nach Art. 13 DSGVO


On Fri, 20 Dec 2024 at 02:38, Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/19/2024 14:15, Naresh Solanki wrote:
> > Hi Mario,
> >
> > On Fri, 20 Dec 2024 at 01:40, Naresh Solanki
> > <naresh.solanki@9elements.com> wrote:
> >>
> >> Hi Mario,
> >>
> >> On Fri, 20 Dec 2024 at 01:02, Mario Limonciello
> >> <mario.limonciello@amd.com> wrote:
> >>>
> >>> On 12/19/2024 13:21, Naresh Solanki wrote:
> >>>> The previous approach introduced roundoff errors during division whe=
n
> >>>> calculating the boost ratio. This, in turn, affected the maximum
> >>>> frequency calculation, often resulting in reporting lower frequency
> >>>> values.
> >>>>
> >>>> For example, on the Glinda SoC based board with the following
> >>>> parameters:
> >>>>
> >>>> max_perf =3D 208
> >>>> nominal_perf =3D 100
> >>>> nominal_freq =3D 2600 MHz
> >>>>
> >>>> The Linux kernel previously calculated the frequency as:
> >>>> freq =3D ((max_perf * 1024 / nominal_perf) * nominal_freq) / 1024
> >>>> freq =3D 5405 MHz  // Integer arithmetic.
> >>>>
> >>>> With the updated formula:
> >>>> freq =3D (max_perf * nominal_freq) / nominal_perf
> >>>> freq =3D 5408 MHz
> >>>>
> >>>> This change ensures more accurate frequency calculations by eliminat=
ing
> >>>> unnecessary shifts and divisions, thereby improving precision.
> >>>>
> >>>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> >>>
> >>> Thanks, this makes sense to me.
> >>>
> >>> But looking at it, we should have the same problem with lowest nonlin=
ear
> >>> freq as it goes through the same conversion process.  Would you mind
> >>> fixing that one too?
> >> Sure. Somehow my eyes missed that.
> >> Also observed that current calculations yields zero for lowest_nonline=
ar_freq.
> > Sorry I was wrong. it's not zero. Its roundoff version.
> >
> >> After fixing that, it reported frequency 2002 & 1404 depending on the =
core.
>
> Mmm, I wouldn't expect that.  Is your APU heterogenous?  Or is this a
> BIOS bug?
>
> Both with your v3 patch in place and your patch not in place can you
> send me the report generated from:
> https://gitlab.freedesktop.org/drm/amd/-/blob/master/scripts/amd-pstate-t=
riage.py
>
> >>
> >> On a side note, I'm also observing that the highest_perf is set to 196=
 which
> >> should not have been the case as I do have cores with value 208.
> >> Seems like amd_get_boost_ratio_numerator needs some addressing for tha=
t.
>
> Ah this is something that is quite confusing about how AMD client CPUs
> behave.  There is a feature called "Preferred cores" that uses the
> highest performance value to indicate rankings of the cores.  This means
> that you can't use the value in this register to calculate the
> frequency, you have to use the pre-defined scaling factor.
>
> The scaling factor is listed in arch/x86/kernel/acpi/cppc.c and the
> correct one is fetched for this calculation.
>
> >>
> >> Regards,
> >> Naresh
> >>>
> >>> Gautham, Perry,
> >>>
> >>> Is there something non-obvious I'm missing about why it was done this
> >>> way?  It looks like it's been there since the start.
> >>>
> >>>>
> >>>> Changes in V2:
> >>>> 1. Rebase on superm1.git/linux-next branch
> >>>> ---
> >>>>    drivers/cpufreq/amd-pstate.c | 9 ++++-----
> >>>>    1 file changed, 4 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-psta=
te.c
> >>>> index d7b1de97727a..02a851f93fd6 100644
> >>>> --- a/drivers/cpufreq/amd-pstate.c
> >>>> +++ b/drivers/cpufreq/amd-pstate.c
> >>>> @@ -908,9 +908,9 @@ static int amd_pstate_init_freq(struct amd_cpuda=
ta *cpudata)
> >>>>    {
> >>>>        int ret;
> >>>>        u32 min_freq, max_freq;
> >>>> -     u32 nominal_perf, nominal_freq;
> >>>> +     u32 highest_perf, nominal_perf, nominal_freq;
> >>>>        u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
> >>>> -     u32 boost_ratio, lowest_nonlinear_ratio;
> >>>> +     u32 lowest_nonlinear_ratio;
> >>>>        struct cppc_perf_caps cppc_perf;
> >>>>
> >>>>        ret =3D cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
> >>>> @@ -927,10 +927,9 @@ static int amd_pstate_init_freq(struct amd_cpud=
ata *cpudata)
> >>>>        else
> >>>>                nominal_freq =3D cppc_perf.nominal_freq;
> >>>>
> >>>> +     highest_perf =3D READ_ONCE(cpudata->highest_perf);
> >>>>        nominal_perf =3D READ_ONCE(cpudata->nominal_perf);
> >>>> -
> >>>> -     boost_ratio =3D div_u64(cpudata->highest_perf << SCHED_CAPACIT=
Y_SHIFT, nominal_perf);
> >>>> -     max_freq =3D (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHI=
FT);
> >>>> +     max_freq =3D div_u64((u64)highest_perf * nominal_freq, nominal=
_perf);
> >>>>
> >>>>        lowest_nonlinear_perf =3D READ_ONCE(cpudata->lowest_nonlinear=
_perf);
> >>>>        lowest_nonlinear_ratio =3D div_u64(lowest_nonlinear_perf << S=
CHED_CAPACITY_SHIFT,
> >>>
>

