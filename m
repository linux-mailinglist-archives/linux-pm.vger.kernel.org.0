Return-Path: <linux-pm+bounces-38310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BF987C7501E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 16:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 574BC356A15
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 15:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B2A3624B3;
	Thu, 20 Nov 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5hTsl68"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C035F8AF
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652128; cv=none; b=uMObzTHquPGjshhbvdRKg52kp5Z/bs/mCQJG/VTMVccoJJTjTEqxCKDY6P6nbAZ4UjMjyTa6lbAJyjZF01mQwOyv2UFzYpA8wQ8URVaM8bn6iVavbaYVZrrIfX0YG/yVsaslOfWQ8x1ddBBR3fDDcYqqkGh0Ezd0JX97gkg51Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652128; c=relaxed/simple;
	bh=3nD/G2WXq9Ca6uWHngy/j8DhuH1UdNn7Czmh+0EizUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TO1AI3ldwfmIcgK2gW0QYMmLwu4jXyPtqLUO5zLBUTRpEMQpIGbo/VbaJTv1iGQ7ek4n6ieuGtDG44TKGWf9P51bQfn2kCQeyHgnCdGW22PfoamQLaTRHMNtYIynW4BKds9zfSY8juIAYUC15/8nXT/rQvCK5Q5nBf8hiPGkEHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5hTsl68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7229AC4CEF1
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763652128;
	bh=3nD/G2WXq9Ca6uWHngy/j8DhuH1UdNn7Czmh+0EizUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m5hTsl68e3D53rSaiWrjn5YBN/U8SDGAokSDPIt4w8Orim88lFxvpYniqHfWTRXeG
	 IakND91Dpbl1dN4nEUgBSevHU8alYOLGNJYRF2LZz47I4i6CXot989fEpTbVcJNibC
	 iPgKnpb+sACKLQlf0myiVoXBp6pMclA4i50erjr9qPCvEQhnOMDoJpy5ba/ATtuTe/
	 HaFMHez/SoNkRqgsnz0BjrVbBhOjyWbw2cVQWGmt1Hhx/ubaeoGFOQYWXIwWb1z3SX
	 SRb4Vpa9d1yNLKEtf7kPFFi/U9f8TSLLdBuh4QvunCOsE70s8wemjVjydRm9PslSYU
	 CX30aFRi1lcYg==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c6e9538945so1091896a34.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 07:22:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVofaQBZctv6EwA0j9BE83PCWLDqKf6ZYtzYYRSJhqSfHEifWwbXvMLyOF2eHNWyXf2ru90DFmYxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxzsLBNqyqKiN3xrHq13NyVm2HV8u1J9utNyklWuNtVxytzY0H
	Whehc0eVNaaaACvveNp/+lhLwFw9ONrYkvVziEdcVPJwyUidLbVQ+95ur1JMWAnBW0x5TJp8aMH
	8QBKh9OuQCzhdfs4op3nIoiMGXppPYrI=
X-Google-Smtp-Source: AGHT+IHzGXHTevbDHhRrdVftBCpuaVfRzpXrEdWTxileshA5PMdfCZPaHjhZ5N9tpthi7YQvujoeIOXkH73X9Rxe1mE=
X-Received: by 2002:a05:6808:f91:b0:450:f45e:f4ae with SMTP id
 5614622812f47-45101cf2fe3mr1282210b6e.9.1763652127793; Thu, 20 Nov 2025
 07:22:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4701737.LvFx2qVVIh@rafael.j.wysocki> <69115878-ec5e-4f7c-bb3e-9f61cce75c70@arm.com>
 <003f01dc59a7$2bd98b40$838ca1c0$@telus.net> <CAJZ5v0ic91RriXEHJkEFn0EkPKykmdEANimbKjAtdR0SwCZ4OA@mail.gmail.com>
 <f46bb011-83b1-4037-bc6f-eb7e72800e38@arm.com> <CAJZ5v0i2hf_npzB+btX53VBDP+29Xy3sbuo5y36mOTZVe39O+Q@mail.gmail.com>
 <CAJZ5v0hYX_9ywZ=sAQ7fDW9XqZ-nCRUE+kkr28aP3nN_itoJwA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hYX_9ywZ=sAQ7fDW9XqZ-nCRUE+kkr28aP3nN_itoJwA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Nov 2025 16:21:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hVy1GHifXaweMy6E1=oGb1QhVPAv2S+3DJCMqLB2vgfw@mail.gmail.com>
X-Gm-Features: AWmQ_bl-c0nugWMZUxGf0LPTYa2WTgom2mVNxNQq-ECJrGjRSd6RsZW2BrK4D-4
Message-ID: <CAJZ5v0hVy1GHifXaweMy6E1=oGb1QhVPAv2S+3DJCMqLB2vgfw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] cpuidle: governors: teo: Assorted improvements
To: Christian Loehle <christian.loehle@arm.com>
Cc: Doug Smythies <dsmythies@telus.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>, 
	Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 2:57=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Nov 20, 2025 at 2:38=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Thu, Nov 20, 2025 at 2:35=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> > >
> > > On 11/20/25 11:02, Rafael J. Wysocki wrote:
> > > > On Wed, Nov 19, 2025 at 11:52=E2=80=AFPM Doug Smythies <dsmythies@t=
elus.net> wrote:
> > > >>
> > > >> On 2025.11.13 07:22 Christian Loehle wrote:
> > > >>> On 11/12/25 16:21, Rafael J. Wysocki wrote:
> > > >>>> Hi,
> > > >>>>
> > > >>>> This is a bunch of teo cpuidle governor improvements, some of wh=
ich are related
> > > >>>> to a bug report discussed recently:
> > > >>>>
> > > >>>> https://lore.kernel.org/linux-pm/CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9=
U57THQsU_qdcCx1m4w5g@mail.gmail.com/
> > > >>>>
> > > >>>> The first patch fixes a bug that may cause an overly deep idle s=
tate
> > > >>>> to be selected when the scheduler tick has been already stopped.
> > > >>>>
> > > >>>> Patch [2/4] removes an unnecessary function argument.
> > > >>>>
> > > >>>> Patch [3/4] makes teo_update() to use s64 as the data type for i=
ts local
> > > >>>> variables more consistently.
> > > >>>>
> > > >>>> The last patch reworks the governor's decay implementation to al=
so decay
> > > >>>> metric values lower than 8.
> > > >>>>
> > > >>>
> > > >>> Tested-by: Christian Loehle <christian.loehle@arm.com>
> > > >>>
> > > >>> Test results below, although there really isn't anything interest=
ing in there.
> > > >>> teo-1 to teo-4 (patches 1 to 4 respectively are essentially indis=
tinguishable from
> > > >>> teo-m =3D mainline)
> > > >>
> > > >> I tested the 4 patch set also, and also found no differences in re=
sults above
> > > >> repeatability noise levels.
> > > >>
> > > >> Additionally, I added another patch (patch 5 of 4):
> > > >> "cpuidle: governors: teo: Rework the handling of tick wakeups" [1]
> > > >> Similar findings.
> > > >>
> > > >> Additionally, I added another patch (patch 6 of 4):
> > > >> "sched/idle: disable tick in idle=3Dpoll idle entry" [2]
> > > >> And found only one significant improvement, for only one test,
> > > >> but only for the TEO idle governor:
> > > >>
> > > >> Kernel 6.18-rc4:
> > > >> For a 6 pair fast ping-pong test (meaning no work per token stop):
> > > >> teo: 5.53 uSec per loop, reference test
> > > >> 4 of 4 patches: 5.53 uSec per loop, 0%
> > > >> 5 of 4 patches: 5.54 uSec per loop, 0.2% (noise)
> > > >> 6 of 4 patches: 4.77 uSec per loop, 13% better
> > > >> 6 of 4 patches (again): 4.81 uSec per loop, 13% better
> > > >> menu: 5.29 uSec per loop, 4.4% better
> > > >> menu + patch 6 of 4: 5.28 uSec per loop, 4.5% better
> > > >>
> > > >> Idle state 0 usage:
> > > >> 18% with patch 6, teo
> > > >> 11% with menu
> > > >> ~1% with mainline and not patch 6, teo.
> > > >>
> > > >> Idle state 1 usage:
> > > >> almost 0 with patch 6, teo
> > > >> ~6% with menu
> > > >> 27% with mainline and not patch 6, teo.
> > > >>
> > > >> Power: About 100 watts. Patch 6 and teo does increase power use by=
 about a watt or 2.
> > > >>
> > > >> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 C=
PUs.
> > > >>
> > > >> For clarity my branch log:
> > > >> 3993913d7f81 (HEAD -> rjw-teo) sched/idle: disable tick in idle=3D=
poll idle entry
> > > >> d9b12b8d62bf cpuidle: governors: teo: Rework the handling of tick =
wakeups
> > > >> e47178c87272 cpuidle: governors: teo: Decay metrics below DECAY_SH=
IFT threshold
> > > >> 7fe32e411c2b cpuidle: governors: teo: Use s64 consistently in teo_=
update()
> > > >> 490e6118e45d cpuidle: governors: teo: Drop redundant function para=
meter
> > > >> 8f627f86062e cpuidle: governors: teo: Drop incorrect target reside=
ncy check
> > > >> 6146a0f1dfae (tag: v6.18-rc4, origin/master, origin/HEAD, master) =
Linux 6.18-rc4
> > > >>
> > > >> [1] https://lore.kernel.org/linux-pm/6228387.lOV4Wx5bFT@rafael.j.w=
ysocki/
> > > >> [2] https://lore.kernel.org/linux-pm/aQiWfnnSzxsnwa2o@tpad/
> > > >
> > > > Thanks for the feedback, much appreciated!
> > > >
> > > > I will likely have some more teo updates in the next cycle.
> > >
> > > You're welcome, looking forward to reviewing them too.
> > > I haven't tried to see what this would ideally look like for the -sta=
ble branches.
> > > Just backport everything until the most recent applicable Fixes:?
> >
> > I've added a list to this commit:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/com=
mit/?h=3Dlinux-next&id=3D14c66155c4609f1a1207d4e716c5e722b8bf920e
>
> Which somehow got incorrect git commit hashes, so I need to regenerate
> it.  Sorry for the confusion.

Done, and it's this commit now:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?h=3Dlinux-next&id=3D083654ded547238c70e0d4f57115cd1c91245b6e

