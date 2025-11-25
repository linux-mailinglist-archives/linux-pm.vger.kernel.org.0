Return-Path: <linux-pm+bounces-38590-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB40C85144
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 14:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8963A2CAA
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85C32255D;
	Tue, 25 Nov 2025 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jj3mOwhp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D7A31D74B
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 13:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075733; cv=none; b=OBXnEOu+InoIMV64d1Y3ljry4mwbKiZEx/a4+GzVDaUlbqeUyfxm79Ir1TvXwGxu5htk3AKee2Jz76cxu0dFGpSIeydGWFarYxqNlog/O1bvfZyeDrOHhW7bVovga/Qm2/tQX2nePfAGegRF5/QlkEuGAJ780rLJ+krMIkLJ5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075733; c=relaxed/simple;
	bh=TigqVkS6DQDndoYNbK0oWMBbwRulRVW/005MhYv1R2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SD2yaFCX3aafXLcOoIUXT5FXZBTz64Af1VIQ6tw4Hpmir9/Sr/6rWE9RcjodVA/uzPif7NmnXaEweOnGdRvowvBOo4Zs4KJzj45U3QH2wp3VzC5arGVK9wlcdnu3huNHNXnAO/GHuH7I8TVqqaY8MnM5FPdmwmcmIDj5DDqZ17I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jj3mOwhp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297d4a56f97so81473365ad.1
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 05:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764075731; x=1764680531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFo2hKIzH9XpgOYPVJKvzh8kRjtMBOJ9wnX7O+zKcGI=;
        b=Jj3mOwhp2tfMnGj/UmhBwmldBszh+6+EL5UlzWg4u/nUn8gyer1SW8Qy/CIjru7fQH
         nBEYcnmMI6oDFW3p/5SGGrD6JYRIah6VIZMH7jZTt3Vz0SuqPeKQ5dI6ij6KGXpMwjr3
         rz0F6xbijSl//FA4bhN36ZOdIt5txjRhu64sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075731; x=1764680531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFo2hKIzH9XpgOYPVJKvzh8kRjtMBOJ9wnX7O+zKcGI=;
        b=MwTZ3ZtkYrHHYAKVePdbAfxaryKN8TTxVZ6vLEBbXAGQEzS5NFm/NFKOsJnlmx9BKM
         LEOOS/R3HcDL4P20ViSTi90oml6Io9dWH9lXEdWVDgkd1AA13MZQBDqB4Jdsolvplwbz
         EP9aUSEwNhxb/XoDJB1aOyyvlfxhKnjhJg25YF6xwE7YlD2Aqs/sYRhCDuoEsRUp0YSJ
         ySX+kqWf0mBCUifh4Ytla7J4bf32IEpngz7IbnzkvL7/gHwbwuS0R/H6X7NTcv1aBTKt
         itiVM4ObBLDP5C0AFD+6qsdwyxRTJsvDXqJWrHE3BKOCPQZKZI6yGxRko35lupRmSC6J
         mnKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgAg0ZH0DQMc6bRYQ/c05tZ26RGqlZtLkOtB+Raj6OxLxSn5daqDfonpTt9boLDjSxX0VKpMYmHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIFR3/Jaa4bBzx8neUnkpkj/Py/MZ/Dnvr2JGnVlHdNIrSWQ77
	Fo+EhVdxqGjj1RlL5WgYLQkwUQkrw1FYkM7kCGy5kVdAidBTmdMSVADUN5Bg+O39Le+cktH8qQg
	PFXw=
X-Gm-Gg: ASbGncuxq3+9PTj4Wvz5aS9JeOzeJjcLO/FpifPvw5V5oC6j1flqVZm7g3cI1dPR0Nt
	UO2s2oOP9TWNTtxpDkT04Nc01J6aB/QTgc1G4jr6/QdNZ6QUDsXCwWuwl/bTklKkIjZlhSvXjzr
	QrwEkvlIB1cculpGH9tjjcsPNB52JLB6eC2gN405l7s3ysekh2iWvGUxp3lrgntsEgs+6Y8WaSn
	OfHGbNtBVCV8Qp6lEzXbx8PFAKWZe+Gi7NJIR0NeWnCd89S5wRXUdb5+aX5WrkMdLHKqJqn3fkC
	OFWPblz2x0+wMP3vIeTq4HbpW30Y4THOuAr7/vEqKV+FuhvqTc15hqnxyM5W6Lx4bI+jQ1MQF3E
	8HFZadX8U8jAaOi5T4mZw/mywYe7WaN1H92IEbfykWy7HKAfTX9Kfc20e0PCCPBZ+JWCaIn/Xjg
	EOSYAjdwyk5kCK6YDEo+XRpdZ6fEaz3BPSggKljkQecx+53Q==
X-Google-Smtp-Source: AGHT+IGJ1qSCloviztG6zOtMfvTFJtumNUhNYusvk6eeIkf1VCdLE1KJVS+u8GneiDa/zQcgBD3LOg==
X-Received: by 2002:a17:903:1209:b0:298:3e3a:ae6 with SMTP id d9443c01a7336-29b6c6ae64fmr162242705ad.48.1764075729805;
        Tue, 25 Nov 2025 05:02:09 -0800 (PST)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com. [209.85.210.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b111adasm168682485ad.18.2025.11.25.05.02.08
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 05:02:08 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso6033774b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 05:02:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzxsG6eckWvqNMsVLkv0zliutVbeXvuow8OYxDfslHf0N5JFDFLLmnrBg/iU7JVizBvof8cCObIA==@vger.kernel.org
X-Received: by 2002:a05:7022:69a8:b0:11b:65e:f40 with SMTP id
 a92af1059eb24-11c9d709f69mr10782115c88.5.1764075726726; Tue, 25 Nov 2025
 05:02:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com> <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
 <2be3bf24-a707-48df-b224-22b5ab290006@arm.com>
In-Reply-To: <2be3bf24-a707-48df-b224-22b5ab290006@arm.com>
From: Yu-Che Cheng <giver@chromium.org>
Date: Tue, 25 Nov 2025 21:01:30 +0800
X-Gmail-Original-Message-ID: <CAKchOA31NGBWMdeSjky7MwOjU=dYmHVLbE7uUQHUXSZOzUHUeA@mail.gmail.com>
X-Gm-Features: AWmQ_bnGYnYvwZToS4iWnE0aV11bZtTOD6v7k6eS2rurzDMYiMJOuxPFEYEZqpA
Message-ID: <CAKchOA31NGBWMdeSjky7MwOjU=dYmHVLbE7uUQHUXSZOzUHUeA@mail.gmail.com>
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Tue, Nov 25, 2025 at 5:45=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Sergey,
>
> On 11/21/25 03:55, Sergey Senozhatsky wrote:
> > Hi Christian,
> >
> > On (25/11/20 10:15), Christian Loehle wrote:
> >> On 11/20/25 04:45, Sergey Senozhatsky wrote:
> >>> Hi,
> >>>
> >>> We are observing a performance regression on one of our arm64 boards.
> >>> We tracked it down to the linux-6.6.y commit ada8d7fa0ad4 ("sched/cpu=
freq:
> >>> Rework schedutil governor performance estimation").
> >>>
> >>> UI speedometer benchmark:
> >>> w/commit:   395  +/-38
> >>> w/o commit: 439  +/-14
> >>>
> >>
> >> Hi Sergey,
> >> Would be nice to get some details. What board?
> >
> > It's an MT8196 chromebook.
> >
> >> What do the OPPs look like?
> >
> > How do I find that out?
> >
> >> Does this system use uclamp during the benchmark? How?
> >
> > How do I find that out?
> >
> >> Given how large the stddev given by speedometer (version 3?) itself is=
, can we get the
> >> stats of a few runs?
> >
> > v2.1
> >
> > w/o patch     w/ patch
> > 440 +/-30     406 +/-11
> > 440 +/-14     413 +/-16
> > 444 +/-12     403 +/-14
> > 442 +/-12     412 +/-15
> >
> >> Maybe traces of cpu_frequency for both w/ and w/o?
> >
> > trace-cmd record -e power:cpu_frequency attached.
> >
> > "base" is with ada8d7fa0ad4
> > "revert" is ada8d7fa0ad4 reverted.
>
>
> I did some analysis based on your trace files.
> I have been playing some time ago with speedometer performance
> issues so that's why I'm curious about your report here.
>
> I've filtered your trace purely based on cpu7 (the single biggest cpu).
> Then I have cut the data from the 'warm-up' phase in both traces, to
> have similar start point (I think).
>
> It looks like the 2 traces can show similar 'pattern' of that benchmark
> which is good for analysis. If you align the timestamp:
> 176.051s and 972.465s then both plots (frequency changes in time) look
> similar.
>
> There are some differences, though:
> 1. there are more deeps in the freq in time, so more often you would
>     pay extra penalty for the ramp-up again
> 2. some of the ramp-up phases are a bit longer ~100ms instead of ~80ms
>     going from 2GHz to 3.6GHz

Agree. From the visualized frequency changes in the Perfetto traces,
it's more obvious that the ramp-up from 2GHz to 3.6GHz becomes much
slower and a bit unstable in v6.6.99, and it's also easier to go down
to a low frequency after a short idle.

> 3.
>
>
> There are idle phases missing in the trace, so we have to be careful
> when e.g. comparing avg frequency, because that might not be the real
> indication of the delivered computation and not indicate the gap in the
> score.
>
> Here are the stats:
> 1. revert:
> frequency
> count  1.318000e+03
> mean   2.932240e+06
> std    5.434045e+05
> min    2.000000e+06
> 50%    3.000000e+06
> 85%    3.600000e+06
> 90%    3.626000e+06
> 95%    3.626000e+06
> 99%    3.626000e+06
> max    3.626000e+06
>
> 2. base:
>            frequency
> count  1.551000e+03
> mean   2.809391e+06
> std    5.369750e+05
> min    2.000000e+06
> 50%    2.800000e+06
> 85%    3.500000e+06
> 90%    3.600000e+06
> 95%    3.626000e+06
> 99%    3.626000e+06
> max    3.626000e+06
>
>
> A better indication in this case would be comparison of the frequency
> residency in time, especially for the max freq:
> 1. revert: 11.92s
> 2. base: 9.11s
>
> So there is 2.8s longer residency for that fmax (while we even have
> longer period for finishing that Speedometer 2 test on 'base').
>
> Here is some detail about that run*:
> +---------------+---------------------+---------------+----------------+
> | Trace         | Total Trace         | Time at Max   | % of Total     |
> |               | Duration (s)        | Freq (s)      | Time           |
> +---------------+---------------------+---------------+----------------+
> | Base Trace    | 24.72               | 9.11          | 36.9%          |
> | Revert Trace  | 22.88               | 11.92         | 52.1%          |
> +---------------+---------------------+---------------+----------------+
>
> *We don't know the idle periods which might happen for those frequencies
>
>
> I wonder if you had a fix patch for the util_est in your kernel...
> That fix has been recently backported to 6.6 stable [1].
>
> You might want to try that patch as well, w/ or w/o this revert.
> IMHO it might be worth to have it on top. It might help
> the main Chrome task ('CrRendererMain') to stay longer on the biggest
> cpu, since the util_est would be higher. You can read the discussion
> that I had back then with PeterZ and VincentG [2].

No, the util_est fix isn't in our kernel yet.
It looks like after cherry-picking the fix, without the revert, the
Speedometer 2.0 score becomes even slightly higher than that on
v6.6.88 (450 ~ 460 vs 435 ~ 440).
On the other hand, with both the fix and the revert, the Speedometer
score becomes about 475 ~ 480, which is almost the same as using the
performance governor (i.e. pinning at the maximum frequency).
It looks like more tasks that originally run on the little cores are
migrated to the middle and big cores more often, which also makes CPU7
more likely to stay at a higher frequency during some short idle in
the main thread.

Also attach the Perfetto trace for both of them:

fix without revert:
https://ui.perfetto.dev/#!/?s=3Dff4d10bd58982555eada61648786adf6f7187ac3
fix with revert:
https://ui.perfetto.dev/#!/?s=3D05da3cedfb3851ad694f523ef59d3cd1092d74ae

>
> Regards,
> Lukasz
>
> [1]
> https://lore.kernel.org/stable/20251121130232.828187990@linuxfoundation.o=
rg/
> [2]
> https://lore.kernel.org/lkml/20230912142821.GA22166@noisy.programming.kic=
ks-ass.net/

Best regards,
Yu-Che

