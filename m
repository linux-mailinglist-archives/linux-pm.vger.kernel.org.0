Return-Path: <linux-pm+bounces-38296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 531F6C7399C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 12:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46FB94E1B1C
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F9A326D74;
	Thu, 20 Nov 2025 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPjfxgzL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E794930F537
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636551; cv=none; b=IUa8NHU5SS93A8K2ueuCxm2hMNWvCzph4lAZDeZQ5qu4cgBOerhlBK24mA2Rnukz4dJSW3g6Yed8eCwPTpAl0+MqWfSUTxWF66l3yQYDzgkcb7XKCTdqA+nSLhZ0an4zSLyDINJedzXZPDUn+GEkaPu2dwaxtmh6YSp/zMDmZI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636551; c=relaxed/simple;
	bh=FouX50HAHbiEHzayrYTP+d/rs5gRoDac17a03UaJvAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4cpUxkYUYonSuwuNJ6RHJhyZ57hTAmsxs/64b7xcbU3BqUS3xm109/9VWcaHtT3mOpMneQ7sTgBXGMUxJoGcOzUr7fJ+T2e7gSf5hSyrXEbN8W0Zy283SmA2juLXqjTnML15ChwZDF9VU7Ou0iTlu2jx1z4mrEEYb1PNFz5jCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPjfxgzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF7EC19422
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 11:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763636550;
	bh=FouX50HAHbiEHzayrYTP+d/rs5gRoDac17a03UaJvAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RPjfxgzL2WT4dpK0R2jmCEq7yI0v1Ap9wqbrTl8JhsQ026vSqv7jnbEJP4J1sW1Uw
	 wEBVSWZ9j6IDsH+bNRsrq8Kc/mCjNpXUeZYvvj4wYRhN20cF2Gi4EY6U642khRtmc3
	 Bm4tmU9KujiAZaL9/mInRyz8phLozupTpcbtMUpz75HyTyIrl6BH8VA6MTHv3rPDjy
	 1l6y/3ODl+6TJWrSByg8ugJCyRiO/xsmhK1dF4i59f8WxCIUZ8CV+G3c5x4jslUm+/
	 aRVcV5DFAKgxIi0fZn0e4yl5zhLXNvjEWN4B6DSIU864MJyhv76LPUPrbxfHn/ZYHL
	 YPlKzZTZOv1jw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-65763315216so291245eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 03:02:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUB+53mFWjCjJRPD4kdapeamfShgpnTDR7efiuVatq7JZ6gtXax+z07xuaYsVaQHppNuIF5nPn1xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmPuP3yHkxDU12G58ZWQW+fEswlhfk+EzWV9m08+TtlAENQJVt
	q+eDfRZIIR78rjxHNPfOfgZT3qigoKxsWL52Y17iS97IffU3O8c6aAa6mBFoWfAVejbdoO2tSv2
	//3x65wJKcAwLf5v/1pUjcaRB2D/v3ME=
X-Google-Smtp-Source: AGHT+IF9nKidG0i0gEkzI6ThqgzNl3O7eLP6Rom8/Fp7Z75dNL4HI+iLgk2Zl2i3tLlQhwdENynLiF0biN2LhoJa6uQ=
X-Received: by 2002:a4a:e904:0:b0:657:7272:e011 with SMTP id
 006d021491bc7-657849dfe0bmr1003438eaf.5.1763636549736; Thu, 20 Nov 2025
 03:02:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4701737.LvFx2qVVIh@rafael.j.wysocki> <69115878-ec5e-4f7c-bb3e-9f61cce75c70@arm.com>
 <003f01dc59a7$2bd98b40$838ca1c0$@telus.net>
In-Reply-To: <003f01dc59a7$2bd98b40$838ca1c0$@telus.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Nov 2025 12:02:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ic91RriXEHJkEFn0EkPKykmdEANimbKjAtdR0SwCZ4OA@mail.gmail.com>
X-Gm-Features: AWmQ_blgBu8uVi62DQdYH_oR-IveXrh7y7WiO2EWht9APILmATP7KN0yXzRX318
Message-ID: <CAJZ5v0ic91RriXEHJkEFn0EkPKykmdEANimbKjAtdR0SwCZ4OA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] cpuidle: governors: teo: Assorted improvements
To: Doug Smythies <dsmythies@telus.net>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Reka Norman <rekanorman@chromium.org>, Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 11:52=E2=80=AFPM Doug Smythies <dsmythies@telus.net=
> wrote:
>
> On 2025.11.13 07:22 Christian Loehle wrote:
> > On 11/12/25 16:21, Rafael J. Wysocki wrote:
> >> Hi,
> >>
> >> This is a bunch of teo cpuidle governor improvements, some of which ar=
e related
> >> to a bug report discussed recently:
> >>
> >> https://lore.kernel.org/linux-pm/CAEmPcwsNMNnNXuxgvHTQ93Mx-q3Oz9U57THQ=
sU_qdcCx1m4w5g@mail.gmail.com/
> >>
> >> The first patch fixes a bug that may cause an overly deep idle state
> >> to be selected when the scheduler tick has been already stopped.
> >>
> >> Patch [2/4] removes an unnecessary function argument.
> >>
> >> Patch [3/4] makes teo_update() to use s64 as the data type for its loc=
al
> >> variables more consistently.
> >>
> >> The last patch reworks the governor's decay implementation to also dec=
ay
> >> metric values lower than 8.
> >>
> >
> > Tested-by: Christian Loehle <christian.loehle@arm.com>
> >
> > Test results below, although there really isn't anything interesting in=
 there.
> > teo-1 to teo-4 (patches 1 to 4 respectively are essentially indistingui=
shable from
> > teo-m =3D mainline)
>
> I tested the 4 patch set also, and also found no differences in results a=
bove
> repeatability noise levels.
>
> Additionally, I added another patch (patch 5 of 4):
> "cpuidle: governors: teo: Rework the handling of tick wakeups" [1]
> Similar findings.
>
> Additionally, I added another patch (patch 6 of 4):
> "sched/idle: disable tick in idle=3Dpoll idle entry" [2]
> And found only one significant improvement, for only one test,
> but only for the TEO idle governor:
>
> Kernel 6.18-rc4:
> For a 6 pair fast ping-pong test (meaning no work per token stop):
> teo: 5.53 uSec per loop, reference test
> 4 of 4 patches: 5.53 uSec per loop, 0%
> 5 of 4 patches: 5.54 uSec per loop, 0.2% (noise)
> 6 of 4 patches: 4.77 uSec per loop, 13% better
> 6 of 4 patches (again): 4.81 uSec per loop, 13% better
> menu: 5.29 uSec per loop, 4.4% better
> menu + patch 6 of 4: 5.28 uSec per loop, 4.5% better
>
> Idle state 0 usage:
> 18% with patch 6, teo
> 11% with menu
> ~1% with mainline and not patch 6, teo.
>
> Idle state 1 usage:
> almost 0 with patch 6, teo
> ~6% with menu
> 27% with mainline and not patch 6, teo.
>
> Power: About 100 watts. Patch 6 and teo does increase power use by about =
a watt or 2.
>
> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 CPUs.
>
> For clarity my branch log:
> 3993913d7f81 (HEAD -> rjw-teo) sched/idle: disable tick in idle=3Dpoll id=
le entry
> d9b12b8d62bf cpuidle: governors: teo: Rework the handling of tick wakeups
> e47178c87272 cpuidle: governors: teo: Decay metrics below DECAY_SHIFT thr=
eshold
> 7fe32e411c2b cpuidle: governors: teo: Use s64 consistently in teo_update(=
)
> 490e6118e45d cpuidle: governors: teo: Drop redundant function parameter
> 8f627f86062e cpuidle: governors: teo: Drop incorrect target residency che=
ck
> 6146a0f1dfae (tag: v6.18-rc4, origin/master, origin/HEAD, master) Linux 6=
.18-rc4
>
> [1] https://lore.kernel.org/linux-pm/6228387.lOV4Wx5bFT@rafael.j.wysocki/
> [2] https://lore.kernel.org/linux-pm/aQiWfnnSzxsnwa2o@tpad/

Thanks for the feedback, much appreciated!

I will likely have some more teo updates in the next cycle.

