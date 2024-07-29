Return-Path: <linux-pm+bounces-11598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CFA93FF8A
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 22:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A871F238D0
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2024 20:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28900189F27;
	Mon, 29 Jul 2024 20:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZvp5sLU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB1189F20
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285072; cv=none; b=X/wdOBt+d8Y0cANmNW2fIGrEtpTnnMmbsOMqe+V3CcDaWehlclECz8CXUGFMv9PchCZpaBCSuNcJ7SdS7MspjAFxlYccHDYCsTDIvkq4g5R7ETzM6DvvxU7rXx01TIBfkVxRj43u2OkkUQ3s+4RW2pEZ00zKNR2UIpWk+/MUGRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285072; c=relaxed/simple;
	bh=NFUu5rr3iCl/P53sbMxDPvnBVxA7hgc3t2H3XecYsTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wss39zdwZDRHj8S+j5WCyLYgCzS1qlIKP4LshJNXAlqC43FmKQ5Kzvuniw1dSoagFQh5IfgJQhCoAJ2YONhF9jZau75jjRAR2XZJ3POmnd6deOvJkmJSnn6UPRvCbJgSIiWJLHZlgCeCDfmdq+Yd2wTsUNM8Tp6UTFlsz0FcM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZvp5sLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88365C4AF0B
	for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 20:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722285071;
	bh=NFUu5rr3iCl/P53sbMxDPvnBVxA7hgc3t2H3XecYsTQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FZvp5sLUwcdDUgCqvxR3097u52w8KlZdLyyBLWqM6CBkWaGyc9fZm+z7NH+82ZTIS
	 Kj4M2xsZEVGPpb1uEDqrDs9LAIm1zY04Zc9Gx7L5NmzOtgbCSMXWYpl/qKNH6op/X3
	 GLkH0t5rwC9iFMuYK9avIp1TU3JdMfVHPI6Gcd+dP0z90gaGv0xa87uDSILUvso1/E
	 rSDp6IxQJM19U85KAmVV0vPWD0o+BaaFNPcq/L0rjXTPM6OITbVQJWucbY2GIZG1rN
	 X8LIIs7SXK7a/0V3MroLbUiWCTwNFIbThJQ2mm/vJ8yDDOZ+ALpIMcu/AZ5bQ9tDas
	 O9Shk+eJLhaKA==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7093ee8d87eso150783a34.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2024 13:31:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5bu64Dc8mOPFcCIVcGfbklwFfdWiROeYhx5rU3CigiSKMQ0AkuR/iDiQ9lToLSzhxKASXmZgJ+SG/Oaw2Y8Riud4RVBGMKZ4=
X-Gm-Message-State: AOJu0YyPgw6DJIQTxPYKCN8z6S3OZj9UNxAagH3mm+1wH3B4g8L4EVfw
	7SutP9hae7zzvBfegqiXQDv4X9Zx8ckJ4aSQsiaq7wE1Fc55yBQlwgfaEVuZNAjqnjxKGfITbGs
	e+q0U6H1YtJiUCiW/w28oAeRoQx8=
X-Google-Smtp-Source: AGHT+IExlKvk0EmIyntsDw+uOhCxWbsxhgLMNJa5gDs9r6g5+jj8Ks7KK9G0J0bVv9TTdrP8Ai5HOtvdbK3uQV+QhF4=
X-Received: by 2002:a4a:e3d7:0:b0:5cd:13e0:b0d3 with SMTP id
 006d021491bc7-5d5b155fe79mr8435455eaf.2.1722285070733; Mon, 29 Jul 2024
 13:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <872ea739-632a-4344-9e3d-49f8fb846f8a@gmail.com>
 <CAJZ5v0hD+6YR9HvtrSu_bDGZKMr2D2c1FKmDiDPwqDWV7wc_WA@mail.gmail.com> <CAOESE2QC2mUEQGZjsQq4Fe=AmUxTKG6=aqS==ykbowqTCGOyaQ@mail.gmail.com>
In-Reply-To: <CAOESE2QC2mUEQGZjsQq4Fe=AmUxTKG6=aqS==ykbowqTCGOyaQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jul 2024 22:30:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ja5VFPJgTy5ATVjq8KCsNCWChjDM2mm2swKE8=BaL27Q@mail.gmail.com>
Message-ID: <CAJZ5v0ja5VFPJgTy5ATVjq8KCsNCWChjDM2mm2swKE8=BaL27Q@mail.gmail.com>
Subject: Re: Need help setting asynchronous CPU frequencies.
To: Anish Rashinkar <rashinkar.anish@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 9:38=E2=80=AFPM Anish Rashinkar
<rashinkar.anish@gmail.com> wrote:
>
> Thank you for the reply.
>
> Yes, I already do keep CPUs 2 and 6 offline, but I would really like
> the performance of a whole additional core as well.
>
> I am working on a script which will help me automatically switch
> between 3 cores max frequency, and 4 cores at lower frequency when
> needed for example when I need the multithreaded performance or if my
> laptop is thermal throttling. But I would still really like to get
> that core running.
>
> You didn't specifically try to mention the solution of my problem,
> which would be being able to set different clock speeds on different
> cores. With whatever knowledge I have, I don't think that it is
> impossible to achieve this. If I am monitoring correctly, then
> different clock speeds are being set on different cores all the time
> based on the current power profile. So based on this, is there really
> no way to limit the maximum frequency allowed for a certain core/CPUs?
>
> If the hardware way is not possible, what about just pure software
> simulation? Like the kernel, manually injecting a few hundred million
> NOP instructions every second on a CPU? I don't think this will work
> as I have also tried isolating CPUs 2 and 6 using isolcpus parameter,
> and so running them at 100% halt, but that still causes the crash.

Yes, you can inject idle time on CPUs 2 and 6 using the thermal
powerclamp driver.  I forgot about this option, sorry.

>  And I have also heard that the kernel also takes care of the voltage
> scaling?

No, it doesn't.  It just asks the processor microcode to adjust performance=
.

> Is it really possible to tweak the voltages of the CPU
> through only software methods (access to FIVR is locked by the
> firmware)?

It would be unsafe to play with the voltage regulator directly anyway.

> On Mon, Jul 29, 2024 at 11:55=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Mon, Jul 29, 2024 at 6:35=E2=80=AFPM Anish Rashinkar
> > <rashinkar.anish@gmail.com> wrote:
> > >
> > > Sorry, I am really not sure if this is the correct place to ask this,
> > > but I have tried almost everywhere but to no success.
> >
> > No worries.
> >
> > > In short, one of my cores in my processor is defective/degraded. It
> > > can't run at max frequency or else it will crash. Either I have to lo=
ck
> > > down the frequency of all the cores to a lower value, or set that cor=
e
> > > offline.
> > >
> > > Access to turbo ratio limits is restricted by the firmware, or otherw=
ise
> > > it would have been easy to set the working cores to max frequency whi=
le
> > > keeping the defective core to a lower speed. Voltage controls are als=
o
> > > locked, which could have fixed the problem, and I have already put a =
lot
> > > of time trying to gain the access, but it's too risky (firmware moddi=
ng).
> > >
> > > It's an HP Elitebook 840 G5 laptop, with an Intel Core i5 8350U. 4 co=
res
> > > with 8 logical threads, It boosts up to 3600 MHz. I have to lock the
> > > whole processor frequency to around 3 - 3.1 GHz, but it is getting wo=
rse
> > > and might crash on that as well. Or if I choose to disable the core, =
I
> > > have to disable CPUs 2 and 6, which is the third core. I have noticed
> > > that disabling idle states (C states) gives me a bit more stability s=
o I
> > > can probably raise the frequency a bit more.
> > >
> > > All I want to know is if there is a way to run the 3 cores at max
> > > frequency, while running that one core at a lower 3 GHz frequency?
> >
> > If the processor is not capable of controlling frequency per-core,
> > which is very unlikely for a laptop one, then no.
> >
> > The problem is that all cores share one voltage regulator that is
> > necessary to raise the voltage in accordance with the frequency you
> > want to run at.
> >
> > In that case, the best you can do is to either take the defective core
> > offline (which requires taking CPUs 2 and 6 offline if I understand
> > the above correctly) and run the other cores at higher frequencies (if
> > you care about single-thread performance more than about the ability
> > to run 8 threads in parallel), or run all cores at lower frequencies
> > (if running more threads in parallel us more desirable).
> >
> > > All my attempts included trying to get the userspace governor working=
,
> > > but it is a big mess. Using tools like cpupower or cpufreq
> > > (cpufrequtils), I can't load the userspace governor directly. The
> > > userspace governor loads if I disable intel_pstate or put it to passi=
ve
> > > mode, but it doesn't seem to have any effect. After loading it, any
> > > frequency I set using cpupower/cpufreq doesn't apply. I also tried wi=
th
> > > intel_pstate hwp on/off. And I of course tried manually choosing the
> > > core in cpufreq but either the changes don't apply, or it gets applie=
d
> > > to all cores. I also kind of tried manually setting the frequencies i=
n
> > > the kernel files (/sys and those), but they didn't really work. I als=
o
> > > tried "intel_pstate=3Dper_cpu_perf_limits" kernel parameter, but that
> > > didn't really help (I couldn't get the intel_pstate folder under all
> > > CPUs, and instead I still got it under .../cpu/ like always).
> > >
> > > I am currently running Ubuntu 24.04 LTS.
> >
> > The distribution and kernel version do not matter here.
> >
> > Thanks!
>

