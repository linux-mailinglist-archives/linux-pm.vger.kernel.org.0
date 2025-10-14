Return-Path: <linux-pm+bounces-36083-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 347AEBDA845
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 17:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC31B4E11DC
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 15:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1F8302CC4;
	Tue, 14 Oct 2025 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU6uACkr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F8302CAE
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457271; cv=none; b=CuCceUzoLlt5YkVdqOZbiNaDBd30YKVa1PocJ1j4c9ELTyG/x51ya1F2afEL2x2IAzOIF6mBwX65hIsPezZEopyNZCHpvgLr5xxOFSqxndfUh5biSEilGxtpUMO+tcp0ALTq7VY5z7xnCbCQq+yPpeAcCxB1tnDWa3heoinXAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457271; c=relaxed/simple;
	bh=rsZ3BaDupSqS8qeP47Vi26VGfO+VXssPsBRIxY84eVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qi+q0UtjX4ghk/PTyoXLHaVJrswyGjxprC1Q84jbmkbFAp1nt4HiuJKW2kgYFEFHewDPfpRyBZuoRb5rMck2ugIABmHcmes3/6OVnLpgkxrYZ9Ll1Ed89bhpAbUaIe9FQAf+rFoulXBGKUiQN5hX8eLvFnJKNW//WvurIZbWTPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU6uACkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23DBC19424
	for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760457271;
	bh=rsZ3BaDupSqS8qeP47Vi26VGfO+VXssPsBRIxY84eVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fU6uACkrVd4N0qr8x3kB6IWjCYHHjN9/O49RCJGq71hfjQTiwFTQETs5US4VoDLaD
	 n7HpBPHfXFuGosGw442+FihGTuWqG8cxcQPaDHxLeKsud8Z1KT0EjVDAjgUeDnwaD1
	 5R5LljJ6coDbyAmxImCfJq+ZwO0FuZG2sHYy0gEZ4//755M1IPLMIwBoaBN2rTT6bY
	 EXvMs84PGRq4lDjx/KzTjmo9z2132Q854sMp5pL6biMMN64zdszBXb9ZAyCc030g6X
	 Js1UZvSrhP26/s97ZPEBRMY/AFhEpubPSW1Tjq3HcoQyNdDkWqkMGnxzUYrxjIXkEL
	 ygHrqWtVHLv2A==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-650304a9e4cso1059743eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 08:54:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCViBD32xqZgnSuxsVkyrPEEtWtl6cy9DvDulTgL7Y39lblLLeUiMx4XleCQ+gAXS/SH9Vn3EXKbog==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlyJB1bSbMTPopK7tpBCuy7zUbeUg2TMsGzU4Xht9RhGhDf6V8
	neYElPYJE69TlK8BtC30+G7JN5yihSBO/XqsUIjrmtwL+sLEyVZCHjwyuPOMZksiSwi+XTpTBRM
	5w7N0xAiSY198kWUCeMn9LLMqkil218A=
X-Google-Smtp-Source: AGHT+IHF2NDlkSbOEFkhgIxTV+2pfbPIavGMBPl+ZxHrdWz0+VRE//WMkSLvbFlqn/CWFM8NAerN1gBNmKRcgn2v5lM=
X-Received: by 2002:a05:6808:30a6:b0:441:8f74:f26 with SMTP id
 5614622812f47-4418f741dc9mr9287921b6e.64.1760457270166; Tue, 14 Oct 2025
 08:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com> <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com> <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
In-Reply-To: <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Oct 2025 17:54:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
X-Gm-Features: AS18NWChJvr-GMb6g3ashFlNGeFNEltmJaQ_ewPgLPRRRWz5LjKbsRahtrKNCrE
Message-ID: <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
To: Christian Loehle <christian.loehle@arm.com>, Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 5:11=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 10/14/25 12:55, Sergey Senozhatsky wrote:
> > On (25/10/14 11:25), Christian Loehle wrote:
> >> On 10/14/25 11:23, Sergey Senozhatsky wrote:
> >>> On (25/10/14 10:50), Christian Loehle wrote:
> >>>>> Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
> >>>>> invalid recent intervals data") doesn't address the problems we are
> >>>>> observing.  Revert seems to be bringing performance metrics back to
> >>>>> pre-regression levels.
> >>>>
> >>>> Any details would be much appreciated.
> >>>> How do the idle state usages differ with and without
> >>>> "cpuidle: menu: Avoid discarding useful information"?
> >>>> What do the idle states look like in your platform?
> >>>
> >>> Sure, I can run tests.  How do I get the numbers/stats
> >>> that you are asking for?
> >>
> >> Ideally just dump
> >> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
> >> before and after the test.
> >
> > OK, got some data for you.  The terminology being used here is as follo=
ws:
> >
> > - 6.1-base
> >   is 6.1 stable with a9edb700846 "cpuidle: menu: Avoid discarding usefu=
l information"
> >
> > - 6.1-base-fixup
> >   is 6.1 stable with a9edb700846 and fa3fa55de0d6 "cpuidle: governors:
> >   menu: Avoid using invalid recent intervals data" cherry-pick
> >
> > - 6.1-revert
> >   is 6.1 stable with a9edb700846 reverted (and no fixup commit, obvious=
ly)
> >
> > Just to show the scale of regression, results of some of the benchmarks=
:
> >
> >   6.1-base:           84.5
> >   6.1-base-fixup:     76.5
> >   6.1-revert:         59.5
> >
> >   (lower is better, 6.1-revert has the same results as previous stable
> >   kernels).
> This immediately threw me off.
> The fixup was written for a specific system which had completely broken
> cpuidle. It shouldn't affect any sane system significantly.
> I double checked the numbers and your system looks fine, in fact none of
> the tests had any rejected cpuidle occurrences. So functionally base and
> base-fixup are identical for you. The cpuidle numbers are also reasonably
> 'in the noise', so just for the future some stats would be helpful on tho=
se
> scores.
>
> I can see a huge difference between base and revert in terms of cpuidle,
> so that's enough for me to take a look, I'll do that now.
> (6.1-revert has more C3_ACPI in favor of C1_ACPI.)
>
> (Also I can't send this email without at least recommending teo instead o=
f menu
> for your platform / use-cases, if you deemed it unfit I'd love to know wh=
at
> didn't work for you!)

Well, yeah.

So I've already done some analysis.

There are 4 C-states, POLL, C1, C6 and C10 (at least that's what the
MWAIT hints tell me).

This is how many times each of them was requested during the workload
run on base 6.1.y:

POLL: 21445
C1: 2993722
C6: 767029
C10: 736854

and in percentage of the total idle state requests:

POLL: 0,47%
C1: 66,25%
C6: 16,97%
C10: 16,31%

With the problematic commit reverted, this became

POLL: 16092
C1: 2452591
C6: 750933
C10: 1150259

and (again) in percentage of the total:

POLL: 0,37%
C1: 56,12%
C6: 17,18%
C10: 26,32%

Overall, POLL is negligible and the revet had no effect on the number
of times C6 was requested.  The difference is for C1 and C10 and it's
10% in both cases, but going in opposite directions so to speak: C1
was requested 10% less and C10 was requested 10% more after the
revert.

Let's see how this corresponds to the residency numbers.

For base 6.1.y there was

POLL: 599883
C1: 732303748
C6: 576785253
C10: 2020491489

and in percentage of the total

POLL: 0,02%
C1: 21,99%
C6: 17,32%
C10: 60,67%

After the revert it became

POLL: 469451
C1: 517623465
C6: 508945687
C10: 2567701673

and in percentage of the total

POLL: 0,01%
C1: 14,40%
C6: 14,16%
C10: 71,43%

so with the revert the CPUs spend around 7% more time in deep idle
states (C6 and C10 combined).

I have to say that this is consistent with the intent of the
problematic commit, which is to reduce the number of times the deepest
idle state is requested although it is likely to be too deep.

However, on the system in question this somehow causes performance to
drop significantly (even though shallow idle states are used more
often which should result in lower average idle state exit latency and
better performance).

One possible explanation is that this somehow affects turbo
frequencies.  That is, requesting shallower idle states on idle CPUs
prevents the other CPUs from getting sufficiently high turbo.

Sergey, can you please run the workload under turbostat on the base
6.1.y and on 6.1.y with the problematic commit reverted and send the
turbostat output from both runs (note: turbostat needs to be run as
root)?

