Return-Path: <linux-pm+bounces-33584-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1B9B3EE4F
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 21:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E259487F0B
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 19:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E2F25783F;
	Mon,  1 Sep 2025 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDyRO9s2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A34832F763;
	Mon,  1 Sep 2025 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753724; cv=none; b=Sb32W8fMqvr3e167MWZAwTvAVSkigvt3typtunhwPyDO42OH5QR4ndPOScdrNX4TyWt0h1jBmPqlzaYjXvjg6010Dq1in0TwLo4IDHz5hq/shc2FzQq0i7rigwuLXP2dWu1enJwFBKAfqZpp5a0IXAYrG9KMCA0pxpxuA5OxQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753724; c=relaxed/simple;
	bh=wM0cePjIfc+T53YWy7/DFsGTMX45/2gZpHps+dRmsBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjGBnnH27KLxvLgcjJF5yV9hrmsrKEvWVIZMGZE881rz15ovitLBayDk2mkiaUnlo4TyzUG5f54/M1y2SyS49jCLvmYx/YVurLZyRSQ7J85CAIADmQhpZNe707Coq3Lpw4LFbomqhc5Y/LwWqeQhldfKIejMc7NK2GxkgNB9MfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDyRO9s2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CE1C4CEF0;
	Mon,  1 Sep 2025 19:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756753724;
	bh=wM0cePjIfc+T53YWy7/DFsGTMX45/2gZpHps+dRmsBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oDyRO9s20upILrUYyPcPe5bOVHw8fGJnJaM0Mj7IArzavVw/0k8W17E+lb5485kc/
	 76D3TRXTqKhXfe9a0ZxwlPKAM+bI+F+nxFD6JVQTNLV7nrdoWAYp9OpVLVt8n/URq8
	 3tSre1AbvZEgqqMu+UdEY7X63R2TduWWKJhgPYZMTPLAqX3Qxc0LCp7h+F9ZIY+HLL
	 CXwQDUaU/Girnzp+63aHO0vAGjTvgA7LmruLnWB8+Q2mU4VZ80NBz/8lY1H281cv4o
	 J59DIx4VijDETX3cnxisEIN/00Rt79yT/3VPPzXfXfOM1jjEy20PJi/UmVFFpwfpBX
	 MsgHKd5sdUc3g==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-61e06547f73so3898013eaf.2;
        Mon, 01 Sep 2025 12:08:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcz9FuQUajgoF9o3M23QbJGImI/KZgr6vhs7dUjrDUKUYOAX3bBXBP/Z2xKIGEspI8XnsjigQyovFYDn4=@vger.kernel.org, AJvYcCV37jxbaQfbzjwdoqXZsf5Ey9xvmf/ekiK/ob66X6tbQz8yD4VRAfUgiOr+YjYr5BB65GKcZBcBVkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+kvL8NZVfa9VlhxDEesJqMDxSqdVcSfTJkQDBZtJ2ITzGnoP9
	DGHRa9hWeDTi1UxenFigqKRXfqPUwfA4dTdvBHqGDQAGbflgsZARnSF7ILAyTWOrgmNph2+noEI
	BFWFIA+hl2ftxrhnJIEUC3VvuMEEQsU8=
X-Google-Smtp-Source: AGHT+IE60JuKtbMSjdGdYdQMC7YkhrIqe9iBtkLpXC0xkt4XPBjefUj75yxhQvq8rRCg4rQG9YvnC/jl4A1f6QNCWDA=
X-Received: by 2002:a05:6820:80f:b0:61e:14fe:dae7 with SMTP id
 006d021491bc7-61e335e2d72mr4559867eaf.1.1756753723667; Mon, 01 Sep 2025
 12:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2804546.mvXUDI8C0e@rafael.j.wysocki> <5939372.DvuYhMxLoT@rafael.j.wysocki>
 <CAJZ5v0gniATfcckSwfJBmLf9O345Ersw-TUMVFWTSWxTN5K+0A@mail.gmail.com> <ce8b4488-a165-4847-8f2b-e2ee65746e00@arm.com>
In-Reply-To: <ce8b4488-a165-4847-8f2b-e2ee65746e00@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Sep 2025 21:08:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gKrvO3WGmgEJu=tW7M-tJKK4FW0HOBjP8VLrtQq5ep8A@mail.gmail.com>
X-Gm-Features: Ac12FXxbqFP5A2o1L2scNWGVtYVTIADgme5Q1_12iDlxyhTKsAxchWpXujpNCBU
Message-ID: <CAJZ5v0gKrvO3WGmgEJu=tW7M-tJKK4FW0HOBjP8VLrtQq5ep8A@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: governors: teo: Special-case nohz_full CPUs
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 11:30=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 8/29/25 20:37, Rafael J. Wysocki wrote:
> > On Thu, Aug 28, 2025 at 10:16=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> >>
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> This change follows an analogous modification of the menu governor [1]=
.
> >>
> >> Namely, when the governor runs on a nohz_full CPU and there are no use=
r
> >> space timers in the workload on that CPU, it ends up selecting idle
> >> states with target residency values above TICK_NSEC, or the deepest
> >> enabled idle state in the absence of any of those, all the time due to
> >> a tick_nohz_tick_stopped() check designed for running on CPUs where th=
e
> >> tick is not permanently disabled.  In that case, the fact that the tic=
k
> >> has been stopped means that the CPU was expected to be idle sufficient=
ly
> >> long previously, so it is not unreasonable to expect it to be idle
> >> sufficiently long again, but this inference does not apply to nohz_ful=
l
> >> CPUs.
> >>
> >> In some cases, latency in the workload grows undesirably as a result o=
f
> >> selecting overly deep idle states, and the workload may also consume
> >> more energy than necessary if the CPU does not spend enough time in th=
e
> >> selected deep idle state.
> >>
> >> Address this by amending the tick_nohz_tick_stopped() check in questio=
n
> >> with a tick_nohz_full_cpu() one to avoid effectively ignoring all
> >> shallow idle states on nohz_full CPUs.  While doing so introduces a ri=
sk
> >> of getting stuck in a shallow idle state for a long time, that only
> >> affects energy efficiently, but the current behavior potentially hurts
> >> both energy efficiency and performance that is arguably the priority f=
or
> >> nohz_full CPUs.
> >
> > This change is likely to break the use case in which CPU isolation is
> > used for power management reasons, to prevent CPUs from running any
> > code and so to save energy.
> >
> > In that case, going into the deepest state every time on nohz_full
> > CPUs is a feature, so it can't be changed unconditionally.
> >
> > For this reason, I'm not going to apply this patch and I'm going to
> > drop the menu governor one below.
> >
> > The only way to allow everyone to do what they want/need I can see
> > would be to add a control knob for adjusting the behavior of cpuidle
> > governors regarding the handling of nohz_full CPUs.
>
> But then what's the advantage instead of just using
> /sys/devices/system/cpu/cpuX/power/latency
> for the nohz_full CPUs (if you don't want the current 'over-eagerly
> selecting deepest state on nohz_full')?

The difference is that PM QoS prevents the CPU from entering
high-latency idle states at all (depending on the limit value),
whereas the governor will sometimes ask for a deep idle state
(depending on the actual wakeup pattern).  If wakeup patterns in the
workload change over time, it may be quite cumbersome to have to
update PM QoS every time to follow those changes (and the operator may
not even be aware of them).

