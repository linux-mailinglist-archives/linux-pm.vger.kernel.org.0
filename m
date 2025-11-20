Return-Path: <linux-pm+bounces-38305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE44C746FD
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 15:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A41034E86F1
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 13:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D95B3451D6;
	Thu, 20 Nov 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdUEacN9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D15343D77
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647066; cv=none; b=NIL+zwJRfOpGplLXbZIw8UtqgqXQ8gCVlsDwBqU62yor8UWRaFY3Re7Y1hjZVEssXzk4JGShfe8cNAYMk3QOX5wgLgUZCamcsxVPuLjSq+5QM7fsSVpCDXZsKLmsvIyN3oOWg4ZsPtLkJ8FsTLOxQYejW/c8C4moo+iY5irK67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647066; c=relaxed/simple;
	bh=UT0k1dtJWVvckHv331/WEIwbmkIxSr+DPesLSilGUzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2Uiq0XaVgi3/jIcFDLPA8BJQcsu6lEG5iydN70/bn0jweVY/Fvv31Jo0U6luGUErAWKEsbdS3jpG2EBRgKVDB2GLe0QIi2M9vvH2xI/glDLX6jE59xxtYyG6JGYhMb5G0rk52gUthr01UmsRlwzM5/m0T3CaGq7hKkL/kkxgNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdUEacN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30533C116D0
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763647066;
	bh=UT0k1dtJWVvckHv331/WEIwbmkIxSr+DPesLSilGUzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GdUEacN9yBrW3Jtgpj/tbap8/IOYjGrm8CrDKKLJWH6wufgrBYo1NNnUPhQOiIlbO
	 FBQ1Sgq9W6rs/XhADu4TDsSOwwXGqKBs2FDXDO0k/hz20hCrRHP4iMOmTEx+BtCuR6
	 C1197Dsa3wSrmgDtvFvzYmzsapi8AAfHqiPRsXVlkssIMpz/tN3rrruBeDuCmkXZzX
	 JlpPp/dXRVTGXtEveJ5F4xPHPTOdxarkM0jud7YU401jLfiOJACMGRWnwFoQWK6NM4
	 2AF8rLyvsjq1tZp2TtZNy4gD9Elcu9f6M1LU1QHLYHcWDCFU156JC04xfVaKWV83G1
	 PLKJT93o8mQbw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6567a0d456bso350054eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 05:57:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/26nOqDnY7JZO+uI7/3mEXz0ypi0sPSitSwollYT74auTnBJCGv257AE5aWUhkXhVhIootLtSbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrZjaApSlyWx6n5bP4p778PzWUzbxDUADTtBdwW5Bhpyv5BNgR
	IvvuJDSOMlSHvWmoUIbBIKfz+myzfR4pnorbdBtHlnvdY5OeiY/Ko5+tUGcnl7hdTAfsVg28oc6
	uVKDeN+5Tkzx2Nyj5k6zaBuUodtKAm0w=
X-Google-Smtp-Source: AGHT+IErrlhV4qhj1v1sYxUCHDvhPe4nLvND1XYxosjzzB4yUTjEhlBt4cZ9DuaGU7IvY9SKsuwrZDnimbJaLJ1JrME=
X-Received: by 2002:a4a:e904:0:b0:657:7272:e011 with SMTP id
 006d021491bc7-657849dfe0bmr1204938eaf.5.1763647065351; Thu, 20 Nov 2025
 05:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4701737.LvFx2qVVIh@rafael.j.wysocki> <69115878-ec5e-4f7c-bb3e-9f61cce75c70@arm.com>
 <003f01dc59a7$2bd98b40$838ca1c0$@telus.net> <CAJZ5v0ic91RriXEHJkEFn0EkPKykmdEANimbKjAtdR0SwCZ4OA@mail.gmail.com>
 <f46bb011-83b1-4037-bc6f-eb7e72800e38@arm.com> <CAJZ5v0i2hf_npzB+btX53VBDP+29Xy3sbuo5y36mOTZVe39O+Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0i2hf_npzB+btX53VBDP+29Xy3sbuo5y36mOTZVe39O+Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Nov 2025 14:57:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hYX_9ywZ=sAQ7fDW9XqZ-nCRUE+kkr28aP3nN_itoJwA@mail.gmail.com>
X-Gm-Features: AWmQ_bnJ5Qk7y9DggMHhPVD6kgqNHMpJrt6e-pYWc5aOPKzn56SDN30H3K_eICU
Message-ID: <CAJZ5v0hYX_9ywZ=sAQ7fDW9XqZ-nCRUE+kkr28aP3nN_itoJwA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] cpuidle: governors: teo: Assorted improvements
To: Christian Loehle <christian.loehle@arm.com>
Cc: Doug Smythies <dsmythies@telus.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Reka Norman <rekanorman@chromium.org>, 
	Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 2:38=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Nov 20, 2025 at 2:35=E2=80=AFPM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > On 11/20/25 11:02, Rafael J. Wysocki wrote:
> > > On Wed, Nov 19, 2025 at 11:52=E2=80=AFPM Doug Smythies <dsmythies@tel=
us.net> wrote:
> > >>
> > >> On 2025.11.13 07:22 Christian Loehle wrote:
> > >>> On 11/12/25 16:21, Rafael J. Wysocki wrote:
> > >>>> Hi,
> > >>>>
> > >>>> This is a bunch of teo cpuidle governor improvements, some of whic=
h are related
> > >>>> to a bug report discussed recently:
> > >>>>
> > >>>> https://lore.kernel.org/linux-pm/CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U5=
7THQsU_qdcCx1m4w5g@mail.gmail.com/
> > >>>>
> > >>>> The first patch fixes a bug that may cause an overly deep idle sta=
te
> > >>>> to be selected when the scheduler tick has been already stopped.
> > >>>>
> > >>>> Patch [2/4] removes an unnecessary function argument.
> > >>>>
> > >>>> Patch [3/4] makes teo_update() to use s64 as the data type for its=
 local
> > >>>> variables more consistently.
> > >>>>
> > >>>> The last patch reworks the governor's decay implementation to also=
 decay
> > >>>> metric values lower than 8.
> > >>>>
> > >>>
> > >>> Tested-by: Christian Loehle <christian.loehle@arm.com>
> > >>>
> > >>> Test results below, although there really isn't anything interestin=
g in there.
> > >>> teo-1 to teo-4 (patches 1 to 4 respectively are essentially indisti=
nguishable from
> > >>> teo-m =3D mainline)
> > >>
> > >> I tested the 4 patch set also, and also found no differences in resu=
lts above
> > >> repeatability noise levels.
> > >>
> > >> Additionally, I added another patch (patch 5 of 4):
> > >> "cpuidle: governors: teo: Rework the handling of tick wakeups" [1]
> > >> Similar findings.
> > >>
> > >> Additionally, I added another patch (patch 6 of 4):
> > >> "sched/idle: disable tick in idle=3Dpoll idle entry" [2]
> > >> And found only one significant improvement, for only one test,
> > >> but only for the TEO idle governor:
> > >>
> > >> Kernel 6.18-rc4:
> > >> For a 6 pair fast ping-pong test (meaning no work per token stop):
> > >> teo: 5.53 uSec per loop, reference test
> > >> 4 of 4 patches: 5.53 uSec per loop, 0%
> > >> 5 of 4 patches: 5.54 uSec per loop, 0.2% (noise)
> > >> 6 of 4 patches: 4.77 uSec per loop, 13% better
> > >> 6 of 4 patches (again): 4.81 uSec per loop, 13% better
> > >> menu: 5.29 uSec per loop, 4.4% better
> > >> menu + patch 6 of 4: 5.28 uSec per loop, 4.5% better
> > >>
> > >> Idle state 0 usage:
> > >> 18% with patch 6, teo
> > >> 11% with menu
> > >> ~1% with mainline and not patch 6, teo.
> > >>
> > >> Idle state 1 usage:
> > >> almost 0 with patch 6, teo
> > >> ~6% with menu
> > >> 27% with mainline and not patch 6, teo.
> > >>
> > >> Power: About 100 watts. Patch 6 and teo does increase power use by a=
bout a watt or 2.
> > >>
> > >> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 CPU=
s.
> > >>
> > >> For clarity my branch log:
> > >> 3993913d7f81 (HEAD -> rjw-teo) sched/idle: disable tick in idle=3Dpo=
ll idle entry
> > >> d9b12b8d62bf cpuidle: governors: teo: Rework the handling of tick wa=
keups
> > >> e47178c87272 cpuidle: governors: teo: Decay metrics below DECAY_SHIF=
T threshold
> > >> 7fe32e411c2b cpuidle: governors: teo: Use s64 consistently in teo_up=
date()
> > >> 490e6118e45d cpuidle: governors: teo: Drop redundant function parame=
ter
> > >> 8f627f86062e cpuidle: governors: teo: Drop incorrect target residenc=
y check
> > >> 6146a0f1dfae (tag: v6.18-rc4, origin/master, origin/HEAD, master) Li=
nux 6.18-rc4
> > >>
> > >> [1] https://lore.kernel.org/linux-pm/6228387.lOV4Wx5bFT@rafael.j.wys=
ocki/
> > >> [2] https://lore.kernel.org/linux-pm/aQiWfnnSzxsnwa2o@tpad/
> > >
> > > Thanks for the feedback, much appreciated!
> > >
> > > I will likely have some more teo updates in the next cycle.
> >
> > You're welcome, looking forward to reviewing them too.
> > I haven't tried to see what this would ideally look like for the -stabl=
e branches.
> > Just backport everything until the most recent applicable Fixes:?
>
> I've added a list to this commit:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commi=
t/?h=3Dlinux-next&id=3D14c66155c4609f1a1207d4e716c5e722b8bf920e

Which somehow got incorrect git commit hashes, so I need to regenerate
it.  Sorry for the confusion.

