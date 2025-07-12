Return-Path: <linux-pm+bounces-30713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 463F3B028EE
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 04:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6E7A46813
	for <lists+linux-pm@lfdr.de>; Sat, 12 Jul 2025 02:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202B7A59;
	Sat, 12 Jul 2025 02:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnoQGQRt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A617993
	for <linux-pm@vger.kernel.org>; Sat, 12 Jul 2025 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752286768; cv=none; b=E2WoH4yhB2ZqO1PLjb3dVv1EZHD+bkPSWDcrvrxbWtWPD5zsxKQHxTyxy0HejTKcoLXX/oegE6mbxVM1IZiJvuaV5UEAYJVt0Lq7mNvR41LAPIiwg4TnjkPjLa9fkRlIQvlwnU6qqg5ougioTAOYm6wihyd8rIAHY8E6RNNQwGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752286768; c=relaxed/simple;
	bh=MvNLqhKnm9tWE58Gy7d2l/AjmUMR9CdzU5l3kGcW4VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZgsKRs4ZzpI18nE2qRVjbcWYoSjVxPod7ZrPPmZVv+wxMNFQA/gTBaAT0ydc3+32+2VVM+yruzOYRKI6ZRHSNtWBqYHejbGEGdS0YNVoN25+X4u2pSZEp4T+tKQ8q6toXiLO7+DgG26K6g6K6tK6j4yqTjNI6+GLKhl3VGOERhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnoQGQRt; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553b6a349ccso3286662e87.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Jul 2025 19:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752286764; x=1752891564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGsy4dRD4YlqKx46rnboov0LsZI/I/Oxbnuh0sVluT0=;
        b=TnoQGQRt1eh4sYPhYXTqN0bwal1iSxxDqCEuAiAusIgba5QZMlpTz3spC7ISOdbLdP
         PQCLv536iL4QgcmCJ0SQkpApAEG11SjxPRpteuE5iUxBy9t7+0tXaZXoKnMe7OB1aOai
         OJiiQVQmZm4ug0W1YLwqV/03kgItNNGhwcfTfSCbT6Giw1xAKOljVc/GKhO3VF9spTFl
         fTLKmjKj55w+SKzvX861xRXQiF1pinECObx2TzuER8e7okRsIERWFmQbOQo3JOhUVoys
         QRzKjNBbiRt9wLm8NCgeRvt8QjCWkTNpZYW8cnDyiF2xqiLCpSCCdu8X+vx8EOW0Bjjw
         QYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752286764; x=1752891564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGsy4dRD4YlqKx46rnboov0LsZI/I/Oxbnuh0sVluT0=;
        b=WH1crRiIRY2FrKShUmrbz85ml9FS2G8ni4ITReTJ9lVydUZaG8XpLOpesTuZ7dwVPw
         oe4ot1VWmp4crLoBWZY267V8Z44qWhqvIeJeSPmFzLHkCKy/vpJjARMfIVr10hoLJGxa
         bl1bfmi9BIB9bBnO2BqiTpdeq1S3AqnEIkyt3DgJ3DIwoJQ1bxhqCg6fD6yAgTCGPAhH
         kSSpcuqkjkZX9diGNBuWQ4obmKMgfoBsGQj5v3UrNWA/kD3hK5C76atqu5eaoNokX7Od
         B8TbaPXXIIchaYcdY0dvkUCL716ay+n4x5HY9wZDdrsXMdaUxqR3o+LMF1cs9gCVPi7G
         349g==
X-Forwarded-Encrypted: i=1; AJvYcCXjuUUOloVDymXlkhMHuAamYr7nLTfVaUNiWkZbUutKiJnEkcJfIaAvNkeeToNwqNuCPBjusIKwgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3H3l1PTsfZB3RJocMSOwfTlqHpc/RFIF1qK8cI3E1Ki1nvpLB
	w77hx3AW/rJ4H8a/+XEtucn7A0jzzqb0DpmrVQ14Xz1kOyiCmwWRjP36gB041icAGpK1kUSju6C
	81IOPlpm9NM40wBuvY0ltryDoLZ/AZSQOm6U4ruQ=
X-Gm-Gg: ASbGncuIKm2gT3MYdCNbwA2peu+sy3Asbd+P2sI/91qObpnmLjzi6DJMngl2DM+s0w4
	koogA9SqoJvgEa+1UKpexC8eo3m18rYOUYoHxtSj8ugMRAxiSaA57NOedZPYvnd4Knf36emEs2Z
	Mm3KDtU7NzRynEZkw0N18dz4uMj0EE4cAFIspoCIzt3hyojSM7oagxamoXbC5eWATF8WLvRlh1Y
	v8BO6rRWdksXI8locwOmyYj0L7ppAxTMMzI
X-Google-Smtp-Source: AGHT+IERGSMZprnmjmswl+nIzfWcSM0tYb29xmZk/NuCanGaERTLD7955zRy3xM1RQTP+jgABlNVrDjD85FH1QjzX90=
X-Received: by 2002:ac2:4e01:0:b0:553:358e:72a8 with SMTP id
 2adb3069b0e04-55a046001d9mr1640746e87.38.1752286764221; Fri, 11 Jul 2025
 19:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3cbd9533b091576a62f597691ced375850d7464a.camel@decadent.org.uk>
 <CANDhNCoYPX_5m-v_sR4TJ3Xj5TVtrMLP8Bswo_-_+BMXwWUkjg@mail.gmail.com>
 <CANDhNCqK26S7p0nypKOytgvzKUL8CMMr4-JbN-8PkNc=Em6VYA@mail.gmail.com> <CAJZ5v0j+s35bwjcRf3R7T6Om0CGd6HsYqC_S4b7a7Mj4HNwJQA@mail.gmail.com>
In-Reply-To: <CAJZ5v0j+s35bwjcRf3R7T6Om0CGd6HsYqC_S4b7a7Mj4HNwJQA@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 11 Jul 2025 19:19:12 -0700
X-Gm-Features: Ac12FXyI8kBc43hsn-fbzDpUZgjJ_pZte22xX3JWMIyKf8tOb-mAeqxBRTRIy8c
Message-ID: <CANDhNCr+7=1W9Oiq3AupXRVasU8FgLorzOnf3_RhYp-WK4qbyg@mail.gmail.com>
Subject: Re: User-space watchdog timers vs suspend-to-idle
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	linux-pm@vger.kernel.org, 1107785@bugs.debian.org, 
	Tiffany Yang <ynaffit@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:55=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> On Fri, Jul 11, 2025 at 12:34=E2=80=AFAM John Stultz <jstultz@google.com>=
 wrote:
> > On Thu, Jul 10, 2025 at 2:59=E2=80=AFPM John Stultz <jstultz@google.com=
> wrote:
> > > On Thu, Jul 10, 2025 at 12:52=E2=80=AFPM Ben Hutchings <ben@decadent.=
org.uk> wrote:
> > > > There seems to be a longstanding issue with the combination of user=
-
> > > > space watchdog timers (using CLOCK_MONOTONIC) and suspend-to-idle. =
 This
> > > > was reported at <https://bugzilla.kernel.org/show_bug.cgi?id=3D2005=
95> and
> > > > more recently at <https://bugs.debian.org/1107785>.
> > > >
> > > > During suspend-to-idle the system may be woken by interrupts and th=
e
> > > > CLOCK_MONOTONIC clock may tick while that happens, but no user-spac=
e
> > > > tasks are allowed to run.  So when the system finally exits suspend=
, a
> > > > watchdog timer based on CLOCK_MONOTONIC may expire immediately with=
out
> > > > the task being supervised ever having an opportunity to pet the
> > > > watchdog.
> > >
> > > So I don't know much about suspend-to-idle, but I'm surprised it's no=
t
> > > suspending timekeeping! That definitely seems problematic.
> >
> > Hrm. The docs here seem to call out that timekeeping is supposed to be
> > suspended in s2idle:
> >   https://docs.kernel.org/admin-guide/pm/sleep-states.html#suspend-to-i=
dle
> >
> > Looking at enter_s2idle_proper():
> > https://elixir.bootlin.com/linux/v6.16-rc5/source/drivers/cpuidle/cpuid=
le.c#L154
> >
> > We call tick_freeze():
> > https://elixir.bootlin.com/linux/v6.16-rc5/source/kernel/time/tick-comm=
on.c#L524
> >
> > Which calls timekeeping_suspend() when the last cpu's tick has been fro=
zen.
> >
> > So it seems like the problem might be somehow all the cpus maybe
> > aren't entering s2idle, causing time to keep running?
>
> Well, there is a suspend-to-idle path in which timekeeping is not suspend=
ed.
>
> It is the one in which cpuidle_enter_s2idle() returns 0 (or less)
> causing cpuidle_idle_call() to fall back to call_cpuidle() after
> selecting the deepest available idle state.
>
> This happens when the cpuidle driver in use doesn't implement
> ->enter_s2idle() callbacks for any of its states and the most
> straightforward remedy is to implement those callbacks in the given
> cpuidle driver (they must guarantee that interrupts will not be
> enabled, however).

It seems like in this case maybe would it be better to abort the
suspend if the hardware doesn't really support it?

> There are also cases in which suspending timekeeping is delayed for
> various reasons.  For instance, on some systems, if the temperature is
> too high, the platform will refuse to enter its deepest power state
> (ask platform designers which they thought that this would be a good
> idea), so the kernel waits for the temperature to drop before it
> attempts to go for proper suspend-to-idle.

Hrm. Practically how long would this thermal delay for s2idle be?

> Moreover, if there are wakeup events while suspended that do not cause
> the system to resume (you may regard them as "spurious"), timekeeping
> is resumed and suspended again every time this happens.

Ok,  I'd expect it to be resumed and suspended (though I'm wondering
if that should be rethought)

> So in general time may keep running at least somewhat in the
> suspend-to-idle flow, but this also happens during any system
> suspend-resume flow (timekeeping is only suspended after all devices
> have been suspended and it takes time to suspend them all and
> analogously for resume).

Yeah, for small amounts of time, I do expect that the suspend time
will be slightly shorter than the time that applications are frozen -
obviously to your point about the suprious irq case, that delta might
grow with suspend time, but I'm hoping we're still dealing with
relatively small amounts that won't confuse applications.

But from the bug report it sounds like timekeeping is just never
getting suspended at all, which is unexpected.

thanks
-john

