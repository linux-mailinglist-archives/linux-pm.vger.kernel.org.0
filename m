Return-Path: <linux-pm+bounces-32630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5880DB2C280
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 14:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 444184E43AA
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559473314DD;
	Tue, 19 Aug 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmmIcCtS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92027A451;
	Tue, 19 Aug 2025 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604623; cv=none; b=YujVoyoraboutrySXg8zOfugWt5a5KErxiUrB/3yQ3UFkNfwUyexHtnoQxyrFlKPv4PzlLQzTb/A9qk6iVypnV5qK4W6bCux8G+QT1EJhdzcoSme+f7Iz6vLbU99QWP7rf/gT6ZiUXmND8DAqsFyCxNNfzLowJjUB7yd4Hp/NeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604623; c=relaxed/simple;
	bh=fhR9sbVwW3bOwxbPQt0UV+PievZMI3zWcq5ZJwZ4MOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSjA01g9pukVB9bHjYos0uc9Jl9QUX0VgkzR3LBvxHbdQ/mU2xJDhc0ev3AyCjJwLLm41EIouI2SP8WgGiG/A/3WUG/J3kaOw07CO73Gd3bBTEDIUNBSJRH3OmcpMZN62PaJebYdGKa9AFuwVcoXVGU/BMkoAAblkbbxlavQ9Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmmIcCtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFB4C4AF09;
	Tue, 19 Aug 2025 11:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755604622;
	bh=fhR9sbVwW3bOwxbPQt0UV+PievZMI3zWcq5ZJwZ4MOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jmmIcCtSCRaSWk4xc2FzjWTLHp2YiSAfXNrWVYjNL9tIRJl4CN9w/ufARVbKV2Csc
	 gcEC1IT846+dapPjZWAYRigEPYSrLjhd6mT4TEdXYnVxIwTFgFYbynGfEqu8E0n/Gy
	 u6EJmjSPUWxMqCGjMG+//zDWtAfkqMuXWmPsRbYL6oHDRc+f0UpjkMhkDJcSfjQTcJ
	 qyppDr2zNzoRcGPG4itCz857x4FMiC0Vz8s39vWXsvV0DIgK6EvJtw6C9caPQWi2d8
	 iOZxqXsqlIZK30WfPqZu6wkheuaLwCo+COQrLkhzmm1zFbMpgcbOkPfa/VKStO6/bl
	 eym8xekMZg63A==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-74381efd643so1145235a34.1;
        Tue, 19 Aug 2025 04:57:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU923IDXyglcxUlCLGoWAb7Ey1OpCrGJ/j3sJ6JfkDzEAzkBRgsye04qcBUPmhs13jj3Nv+VWf3xMpGpX0=@vger.kernel.org, AJvYcCXGuvKt+vybbOptQzcxRHgNaJwWlmNS0GTCIaxPIvHo60WyZso3IiU8GEG+sc0JjQ54F2YpBpcVc74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4LH3PCd6eOTrV6+db2xZy/xpIpK5yACdXsWXUJpQQ0OSMdNq
	ZYR3HBQcshGB3Q4/WtV8e5NV0dfHWmPnPlOlvrG/fvmEzzEOp7MJK+eNeJDTVl+tZtS83pFnMJx
	zeZDXnu5pauCGegvH7Z0xRMrijHszgog=
X-Google-Smtp-Source: AGHT+IFDlwYdPggXeHiN1f2P4TFhkB9XkvB/EeonKfBQu3iR1bUJH9YdqCajNweQ91VkJKSW1Xyf5srSwfaWKDqiWXQ=
X-Received: by 2002:a05:6830:3509:b0:73e:bb60:2d0c with SMTP id
 46e09a7af769-744e0ac7b6dmr1461088a34.23.1755604621916; Tue, 19 Aug 2025
 04:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2804546.mvXUDI8C0e@rafael.j.wysocki> <2244365.irdbgypaU6@rafael.j.wysocki>
 <9104c434-9025-4365-8127-28014ddddc8d@arm.com> <CAJZ5v0iTaa62WGXCLcgiRyzcj2GBXmYcvLa8AtQZD5bQcxTw5g@mail.gmail.com>
 <3fa10040-7e48-4100-9d70-cbbac406abde@arm.com>
In-Reply-To: <3fa10040-7e48-4100-9d70-cbbac406abde@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Aug 2025 13:56:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h1iT5XpeTUqfM2MSbZR_wMv7VaVxmEa4jEjtx+FH-XaA@mail.gmail.com>
X-Gm-Features: Ac12FXx9O3eQ9klZMDQ-s7qeat7CVAoh2gFEca7fJvIQn3VLs0VBNSAESeHHS7g
Message-ID: <CAJZ5v0h1iT5XpeTUqfM2MSbZR_wMv7VaVxmEa4jEjtx+FH-XaA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] cpuidle: governors: menu: Special-case nohz_full CPUs
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 11:10=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 8/18/25 18:41, Rafael J. Wysocki wrote:
> > On Thu, Aug 14, 2025 at 4:09=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 8/13/25 11:29, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> When the menu governor runs on a nohz_full CPU and there are no user
> >>> space timers in the workload on that CPU, it ends up selecting idle
> >>> states with target residency values above TICK_NSEC all the time due =
to
> >>> a tick_nohz_tick_stopped() check designed for a different use case.
> >>> Namely, on nohz_full CPUs the fact that the tick has been stopped doe=
s
> >>> not actually mean anything in particular, whereas in the other case i=
t
> >>> indicates that previously the CPU was expected to be idle sufficientl=
y
> >>> long for the tick to be stopped, so it is not unreasonable to expect
> >>> it to be idle beyond the tick period length again.
> >>>
> >>> In some cases, this behavior causes latency in the workload to grow
> >>> undesirably.  It may also cause the workload to consume more energy
> >>> than necessary if the CPU does not spend enough time in the selected
> >>> deep idle states.
> >>>
> >>> Address this by amending the tick_nohz_tick_stopped() check in questi=
on
> >>> with a tick_nohz_full_cpu() one to avoid using the time till the next
> >>> timer event as the predicted_ns value all the time on nohz_full CPUs.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>  drivers/cpuidle/governors/menu.c |   12 +++++++++++-
> >>>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>>
> >>> --- a/drivers/cpuidle/governors/menu.c
> >>> +++ b/drivers/cpuidle/governors/menu.c
> >>> @@ -293,8 +293,18 @@
> >>>        * in a shallow idle state for a long time as a result of it.  =
In that
> >>>        * case, say we might mispredict and use the known time till th=
e closest
> >>>        * timer event for the idle state selection.
> >>> +      *
> >>> +      * However, on nohz_full CPUs the tick does not run as a rule a=
nd the
> >>> +      * time till the closest timer event may always be effectively =
infinite,
> >>> +      * so using it as a replacement for the predicted idle duration=
 would
> >>> +      * effectively always cause the prediction results to be discar=
ded and
> >>> +      * deep idle states to be selected all the time.  That might in=
troduce
> >>> +      * unwanted latency into the workload and cause more energy tha=
n
> >>> +      * necessary to be consumed if the discarded prediction results=
 are
> >>> +      * actually accurate, so skip nohz_full CPUs here.
> >>>        */
> >>> -     if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
> >>> +     if (tick_nohz_tick_stopped() && !tick_nohz_full_cpu(dev->cpu) &=
&
> >>> +         predicted_ns < TICK_NSEC)
> >>>               predicted_ns =3D data->next_timer_ns;
> >>>
> >>>       /*
> >>>
> >>>
> >>>
> >>
> >> OTOH the behaviour with $SUBJECT possibly means that we use predicted_=
ns from
> >> get_typical_interval() (which may suggest picking a shallow state base=
d on
> >> previous wakeup patterns) only then to never wake up again?
> >
> > Yes, there is this risk, but the current behavior is more damaging IMV
> > because it (potentially) hurts both energy efficiency and performance.
> >
> > It is also arguably easier for the user to remedy getting stuck in a
> > shallow idle state than to change governor's behavior (PM QoS is a bit
> > too blunt for this).
> >
> > Moreover, configuring CPUs as nohz_full and leaving them in long idle
> > may not be the most efficient use of them.
>
> True, on the other hand the setup cost for nohz_full is so high, you'd ex=
pect
> the additional idle states disabling depending on the workload isn't too =
much
> to ask for...

Apparently, there are cases in which there is enough idle time to ask
for a deep idle state often enough, but as a rule the idle periods are
relatively short.  In those cases, one would need to change the QoS
limit back and forth in anticipation of the "busier" and "calmer"
periods in the workload, which would be kind of equivalent to
implementing an idle governor in user space.

> Anyway feel free to go ahead.

Thank you!

