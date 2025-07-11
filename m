Return-Path: <linux-pm+bounces-30667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C0AB016F3
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 10:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010F67636F3
	for <lists+linux-pm@lfdr.de>; Fri, 11 Jul 2025 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6A3205E3B;
	Fri, 11 Jul 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h64zm/xk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067351F239B;
	Fri, 11 Jul 2025 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224122; cv=none; b=IrmQHSuB/vGcfinRcozMbR0DAgmKo0peYuuAi9Fon9Ym0/Y94RGmHISKfTIydZAe3wRRHg+TjAbJGlQpB6fUo+zqfd0Kbt4Bj2p0JVLzZ7yaiDI8Xx/nQaLaQbmYMxxVDkYH19/FoKBJGdVBtRcU+9uUg/UGlLi4GvEn7m5drUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224122; c=relaxed/simple;
	bh=loy3lNsxbPb9DHQq7vIZKoCcn6QeSDg3L4Elq2CLoO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqjYHiVPug4+UR37Kj1W9WfCjiVp+Lq1wJtS2MRwWj6XfFQr0HQDsgfU3QvRRkGFL3oAmW4lvCX8qrKxpotBU8dxSYRWWnBcvEH6ozSmVHfMcOik7GhZ4V5ywm2w4nYaGPvjqCGIwenD4cZcP9gx2vbAWO9EIqWL666LbTsVGXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h64zm/xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCE4C4CEF9;
	Fri, 11 Jul 2025 08:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752224121;
	bh=loy3lNsxbPb9DHQq7vIZKoCcn6QeSDg3L4Elq2CLoO0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h64zm/xkMMYI+HpFRuVwDUxbZ168EkS7OurmJdd1eAwD6mnlh65AF9BEgPLqZdZGb
	 6bWjE5QJ9fzij8IlxTsK6bQwl3F0gktl7CphaowJWf2mb1wNEVItwFjOQFjATq6mDB
	 ASXiOydlx0W6WKJLSRyvW9UlmkWvkPne0e4mCUdUILVFh++ggk124TCOIEJGe0qSxF
	 czCoO7rEAxCt9SFDwLcQfz4sfR82izJxuHOyFFVMTgDhe7JXgM2xP33prk0U3QcJc9
	 lClUMd7EfqO/5uZqpSCtkPvPsHTwNT/ks5aFUw/TLJa1RWXUdILd2V2gV7r33Kh0c0
	 3yNHRgheyWMQQ==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-40d12821c1cso1013302b6e.2;
        Fri, 11 Jul 2025 01:55:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcvUaZuTfGhcYg6VL3wi0RW1JsjbXYeyzpYTiOA8OCaqiOo/L/8tLsj03c6gPdJuz8w5CB8p1XYGQ=@vger.kernel.org, AJvYcCWlnNOkZWJ76muuJXtWT2ciIf1zD0UaSR9LAvaF7wfI4x7uEX9VsgCUZU2Sb85i9+F7gvNGtOTyuUXsJ4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4fMBskR3XD5YHV04keTJixwshxeK2GcVBoS1D9qCxGEuZSuZV
	MCxi2LrPHdZ0yO1WHAie6Y/g4L82lSwVPQs8RPyVCun6a6S5ajE/BvjX9j/LI+JjAsfWEtJ3H3p
	0zYQy1pipwwtr1esg/OYz9AbG4lOGsnA=
X-Google-Smtp-Source: AGHT+IHF295SJMswONlGGhVG6s+cfw1BmuHvYHXC+K168RDQ3aB2xngUJDikeriCenEk/hFj0WmolFFX8R+ynFegg5w=
X-Received: by 2002:a05:6808:6787:b0:3f8:150b:f571 with SMTP id
 5614622812f47-4150f4c4849mr1829595b6e.21.1752224120794; Fri, 11 Jul 2025
 01:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cbd9533b091576a62f597691ced375850d7464a.camel@decadent.org.uk>
 <CANDhNCoYPX_5m-v_sR4TJ3Xj5TVtrMLP8Bswo_-_+BMXwWUkjg@mail.gmail.com> <CANDhNCqK26S7p0nypKOytgvzKUL8CMMr4-JbN-8PkNc=Em6VYA@mail.gmail.com>
In-Reply-To: <CANDhNCqK26S7p0nypKOytgvzKUL8CMMr4-JbN-8PkNc=Em6VYA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Jul 2025 10:55:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j+s35bwjcRf3R7T6Om0CGd6HsYqC_S4b7a7Mj4HNwJQA@mail.gmail.com>
X-Gm-Features: Ac12FXxgJ8BZVhGwM-_H_n7Ac6Jhlt3uJ9JRFFqbbVrtFpW9nWhXETA7Cf3SDXY
Message-ID: <CAJZ5v0j+s35bwjcRf3R7T6Om0CGd6HsYqC_S4b7a7Mj4HNwJQA@mail.gmail.com>
Subject: Re: User-space watchdog timers vs suspend-to-idle
To: John Stultz <jstultz@google.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, 
	1107785@bugs.debian.org, Tiffany Yang <ynaffit@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 12:34=E2=80=AFAM John Stultz <jstultz@google.com> w=
rote:
>
> On Thu, Jul 10, 2025 at 2:59=E2=80=AFPM John Stultz <jstultz@google.com> =
wrote:
> > On Thu, Jul 10, 2025 at 12:52=E2=80=AFPM Ben Hutchings <ben@decadent.or=
g.uk> wrote:
> > > There seems to be a longstanding issue with the combination of user-
> > > space watchdog timers (using CLOCK_MONOTONIC) and suspend-to-idle.  T=
his
> > > was reported at <https://bugzilla.kernel.org/show_bug.cgi?id=3D200595=
> and
> > > more recently at <https://bugs.debian.org/1107785>.
> > >
> > > During suspend-to-idle the system may be woken by interrupts and the
> > > CLOCK_MONOTONIC clock may tick while that happens, but no user-space
> > > tasks are allowed to run.  So when the system finally exits suspend, =
a
> > > watchdog timer based on CLOCK_MONOTONIC may expire immediately withou=
t
> > > the task being supervised ever having an opportunity to pet the
> > > watchdog.
> > >
> > > This seems like a hard problem to solve!
> >
> > So I don't know much about suspend-to-idle, but I'm surprised it's not
> > suspending timekeeping! That definitely seems problematic.
>
> Hrm. The docs here seem to call out that timekeeping is supposed to be
> suspended in s2idle:
>   https://docs.kernel.org/admin-guide/pm/sleep-states.html#suspend-to-idl=
e
>
> Looking at enter_s2idle_proper():
> https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/cpuidle/cpuidle=
.c#L154
>
> We call tick_freeze():
> https://elixir.bootlin.com/linux/v6.16-rc5/source/kernel/time/tick-common=
.c#L524
>
> Which calls timekeeping_suspend() when the last cpu's tick has been froze=
n.
>
> So it seems like the problem might be somehow all the cpus maybe
> aren't entering s2idle, causing time to keep running?

Well, there is a suspend-to-idle path in which timekeeping is not suspended=
.

It is the one in which cpuidle_enter_s2idle() returns 0 (or less)
causing cpuidle_idle_call() to fall back to call_cpuidle() after
selecting the deepest available idle state.

This happens when the cpuidle driver in use doesn't implement
->enter_s2idle() callbacks for any of its states and the most
straightforward remedy is to implement those callbacks in the given
cpuidle driver (they must guarantee that interrupts will not be
enabled, however).

There are also cases in which suspending timekeeping is delayed for
various reasons.  For instance, on some systems, if the temperature is
too high, the platform will refuse to enter its deepest power state
(ask platform designers which they thought that this would be a good
idea), so the kernel waits for the temperature to drop before it
attempts to go for proper suspend-to-idle.

Moreover, if there are wakeup events while suspended that do not cause
the system to resume (you may regard them as "spurious"), timekeeping
is resumed and suspended again every time this happens.

So in general time may keep running at least somewhat in the
suspend-to-idle flow, but this also happens during any system
suspend-resume flow (timekeeping is only suspended after all devices
have been suspended and it takes time to suspend them all and
analogously for resume).

