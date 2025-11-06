Return-Path: <linux-pm+bounces-37533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78AEC3C094
	for <lists+linux-pm@lfdr.de>; Thu, 06 Nov 2025 16:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF92B3A2226
	for <lists+linux-pm@lfdr.de>; Thu,  6 Nov 2025 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A375126B0AE;
	Thu,  6 Nov 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncPzq2lD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82E269D06
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442516; cv=none; b=DQuGZP2pWlfei/Cxw1HRe8g7mXdCr0nNVVGBmQGhP8F+bXgTiYIgTF8lGYDO+vfcnJqGKjHC/oTzMfQQQGs7q/SEFBCpYCwL6hQ//Bye+2GO7r3+HVCcCf4G80/dYFuN/l6EnCG6daOXUsKKWLZBQQ/AmmlHo3v+YM/pwP010C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442516; c=relaxed/simple;
	bh=yd0ptuqj5EOWnQTKBLRgYw21Xrbhl4jlvzCMVEe8+ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1MpBPSB8mbwLWDX/D70vyzVmg47imBSlEWtQ4tBzL43TfNBH14YDg3zX+HCMh6sBji1FzO3TnQOpIGpkkMH8n0zXFPfhKwBCxLRA0BOSi3pdxsxVgHzDPYB5+FDnjjfL4TwrBWvemAcR9Tsia0s7QBPDndg/10gYrmczJYRWzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncPzq2lD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE212C19422
	for <linux-pm@vger.kernel.org>; Thu,  6 Nov 2025 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762442516;
	bh=yd0ptuqj5EOWnQTKBLRgYw21Xrbhl4jlvzCMVEe8+ps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ncPzq2lD32fD90zumvDmO3MpetLwKDZaXyFqO2p5t86I+VlhCimzlkqnSqJC5bBZp
	 ldzZMgSywEIJ+bxso2/2oaArOlAbCzn3D3ykvCjJMf6IvRqHnVFS3Q1Wwku5o6fAlH
	 P2pDtjt9vjkAonJc5fUZ3nbB0gIS1otdUVwqxFTWbLVYKn5dIxs6qLzd2fqbjgdmON
	 EIJs0dxXNDBnR9wTZWkiRPnuy/hkiv8BpP/XuTSDyx78yXlZHpbeE+8IevKJrExjRp
	 AqfxRDLoNlY7xEwRNAGM/EicomIIbJOFBKx3RNQS5JCezps7DLvXvY0vrdKn5HaQkn
	 k78jJNq4bUUYA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30cce892b7dso577377fac.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2025 07:21:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9kJl0u9R0cAzkfJjUPwCMXvZkzKfxk5e/ax4EmEHQgGjwZWdBpLvhxFh0rc9X5+MhJ00tasLyeg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza5ZJBRu9IAfjUWuZuJsrWCDcXT3yy75ylm3dP5r6MNkUToSeJ
	8GOE2nR3ZOY0DskNETvmvpuLvfaokBIc02/HCOe3uhMuPRzBoip7ltHXi0qPTvUyI9Inj+D6eDL
	KgXybNLa0fwqhuRT3X6/B6CmPVC1C3xs=
X-Google-Smtp-Source: AGHT+IFN5p3HvzarTtvyXC7HSDCaQ+DNDkkb9BQrRRRzNWRvQQE4GfU7P8cjHDN2LzRIqK8DK6SZbu3oeJRXC9zJHUo=
X-Received: by 2002:a05:6870:e312:b0:315:8b80:aa4a with SMTP id
 586e51a60fabf-3e19bb4b1femr4501348fac.48.1762442515136; Thu, 06 Nov 2025
 07:21:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQsU_qdcCx1m4w5g@mail.gmail.com>
 <a50064b2-e6aa-4237-a715-12f21a65e9a6@arm.com> <ed1e64dc-91c9-44d9-b3d3-9f142bcf7a8d@arm.com>
 <CAEmPcwtM_K68cmgXftH7vm1S1N+8u7PA80cp10Ddo74sMCULCA@mail.gmail.com> <e2266a73-6672-41ef-bdb7-c1d6c49acd46@arm.com>
In-Reply-To: <e2266a73-6672-41ef-bdb7-c1d6c49acd46@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 6 Nov 2025 16:21:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hwXo_jwAbeQTTpXZTSa38TJSZ6sRhxQijKcvNoGA11DQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmFPHBqVrlopF1BebHSz8_bJlbGqXNYdfaoHnJTQm49dLHFaEUWXUJux8k
Message-ID: <CAJZ5v0hwXo_jwAbeQTTpXZTSa38TJSZ6sRhxQijKcvNoGA11DQ@mail.gmail.com>
Subject: Re: Regression in TEO cpuidle governor between 6.6 and 6.12
To: Christian Loehle <christian.loehle@arm.com>
Cc: Reka Norman <rekanorman@chromium.org>, rafael@kernel.org, daniel.lezcano@linaro.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 11:47=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/5/25 06:22, Reka Norman wrote:
> > On Wed, Nov 5, 2025 at 10:24=E2=80=AFAM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 11/4/25 09:03, Christian Loehle wrote:
> >>> On 11/4/25 03:36, Reka Norman wrote:
> >>>> Hi,
> >>>>
> >>>> I=E2=80=99m seeing a regression in the TEO governor between 6.6 and =
6.12. At
> >>>> 6.12, when the system is idle it=E2=80=99s spending almost 100% of t=
ime in
> >>>> WFI, compared to about 6% at 6.6. At mainline it has improved compar=
ed
> >>>> to 6.12 but is still a lot worse than 6.6, spending about 50% in WFI=
.
> >>>>
> >>>> The system is a ChromeOS device with Mediatek MT8196.
> >>>>
> >>>> Bisecting showed the specific commit which caused the regression is:
> >>>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
> >>>>
> >>>> I=E2=80=99ve attached sysfs dumps showing the issue. All were taken =
a couple
> >>>> of minutes after boot, with the device having been idle since boot.
> >>>> The cases tested are:
> >>>> cpuidle_6_6.txt      =3D 6.6 kernel
> >>>> cpuidle_6_12.txt     =3D 6.6 kernel with teo commits up to 6.12
> >>>> cpuidle_mainline.txt =3D 6.6 kernel with teo commits up to mainline
> >>>>
> >>>> Summary of the percentage time spent in each state (averaged across =
CPUs):
> >>>>
> >>>> |            |   6.6 |  6.12 | mainline |
> >>>> |------------|------:|------:|---------:|
> >>>> | WFI        |  6.02 | 99.94 |    56.84 |
> >>>> | cpuoff     | 11.02 |     0 |     0.65 |
> >>>> | clusteroff | 82.96 |  0.05 |    42.51 |
> >>>> | s2idle     |     0 |     0 |        0 |
> >>>>
> >>>> Any help would be much appreciated. Let me know if there's any other
> >>>> debugging information I should provide.
> >>>>
> >>>
> >>> That's not good.
> >>> If the system is mostly idle (only boot activity but dumps are taken =
after
> >>> ~3mins?), what is causing the wakeups? Even in 6.6 There are definite=
ly more
> >>> than I would've expected?
> >
> > Sorry, I just realised those dumps were taken at the login screen,
> > which is doing some animation. The new data is all from the home
> > screen, which should be more idle. I also attached before and after
> > dumps to eliminate boot activity. Now it=E2=80=99s more like 2% WFI at =
6.6.
> >
> >>> I noticed that clusteroff and cpuoff have equal residency, which is
> >>> obviously a bit awkward for cpuidle, but shouldn't be relevant to you=
r issue.
> >>>
> >>> I'm a bit puzzled by your bisect results.
> >>> 4b20b07ce72f ("cpuidle: teo: Don't count non-existent intercepts")
> >>> made the intercept logic *less* prone to count (false) intercepts, ye=
t it
> >>> seems to count more of them? (resulting in more WFI).
> >>> I'll think about it some more, for now of course a trace would be ver=
y
> >>> helpful. (cpuidle events, ipi_raise, irqs?)
> >
> > Traces attached.
> >
> >>> Are there ever any latency constraints set?
> >
> > Could you explain how I can tell? (I can=E2=80=99t see anything in our
> > codebase obviously setting cpu_dma_latency or
> > pm_qos_resume_latency_us, but I=E2=80=99m guessing that=E2=80=99s not c=
onclusive.)
> >
> >>>
> >>> FWIW the mainline results look the most reasonable, from a 30000 feet=
 view
> >>> anyway:
> >>> Cluster       State           above   below   usage   above%  below%
> >>> LITTLE        cpuoff-l        ~75     ~65     ~140    23%     20%
> >>> LITTLE        clusteroff-l    ~800    0       ~100    89%     0%
> >>> MID   cpuoff-m        ~3=E2=80=934    ~15     ~20     15%     55%
> >>> MID   clusteroff-m    ~1300   0       ~4000   24%     0%
> >>> BIG   cpuoff-b        0       1       1       =E2=80=94       =E2=80=
=94
> >>> BIG   clusteroff-b    ~800    0       ~1900   30%     0%
> >>>
> >>> (WFI seems mostly the correct choice for little CPUs, that's fine, th=
e energy
> >>> savings compared to cpuoff should be marginal anyway.)
> >>>
> >>> Do you mind trying:
> >>> 13ed5c4a6d9c cpuidle: teo: Skip getting the sleep length if wakeups a=
re very frequent
> >>> on 6.12?
> >>>
> >>
> >> So just thinking out loud, the only case I can actually thing of to ex=
plain your
> >> bisect to 4b20b07ce72f ("cpuidle: teo: Don't count non-existent interc=
epts")
> >> is that the workload essentially changed dramatically because of our c=
alls
> >> to tick_nohz_get_sleep_length() now.
> >> I'm not sure how likely I think that is, but I'm lacking imagination f=
or another
> >> cause. That's why results with
> >> 13ed5c4a6d9c ("cpuidle: teo: Skip getting the sleep length if wakeups =
are very frequent")
> >> would be interesting.
> >
> > I'm not completely sure whether I resolved the conflicts correctly. So
> > if anything seems off about the results, would you mind sharing a
> > ported patch I can try?
> >
> > I've attached sysfs dumps and traces for 6.6, 6.12 and mainline as
> > before (which should be more idle this time), as well as:
> > 6_12_patch            =3D 6.12 with 13ed5c4a6d9c =E2=80=9Ccpuidle: teo:=
 Skip
> > getting the sleep length if wakeups are very frequent=E2=80=9D
> > 6_12_no_intercept     =3D 6.12 with intercept logic removed
> > mainline_no_intercept =3D mainline with intercept logic removed
>
> I wanted to send the below out now, I'm not quite done looking through th=
e traces yet, sorry!
> The system is running 100HZ tick, 6.12 never seems to turn the tick off.

Which is most likely because it always expects an idle duration below
the tick period.

> The majority of the wakeups are just ticks, not 'intercepts' though.

What about scheduler IPIs?  How often do they occur?

A tick wakeup is regarded as an "artificial" one (but only if the
sleep length is large enough which is kind of questionable), so it
counts as a "hit" on the idle state corresponding to the sleep length.
However, an IPI in the range of the target residency of a shallower
state would count as an "intercept".

> Without the intersect logic everything is fine, teo selects deep idle sta=
tes very liberally, so we

"Intercept" I suppose?

> don't have any weird timer effects (wakeups then are not too common and a=
re the EC SPI irq and
> scheduler IPIs, nothing super unexpected).

But in that case idx is always the deepest enabled state and the only
thing that can change this selection is tick_nohz_get_sleep_length().
The statistics are not taken into account at all except for
tick_intercepts.

