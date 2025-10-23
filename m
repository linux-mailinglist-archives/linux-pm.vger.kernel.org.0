Return-Path: <linux-pm+bounces-36749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 929CCC02A4C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 19:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8156189FE8A
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 17:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89DE343209;
	Thu, 23 Oct 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvvgHPmW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3E33FE29
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238374; cv=none; b=Hus/t4DgFJea9qUQ+SBr0TZyeKkVDcM7nCiX1/rX3knl1w0cjEajxv3lgascL5yp0l57shWUPRVv/sGWMVSfJbcgi941MqgDtLesMP1aFgkW8XQ3jfjEWIresw80JZ2rIKrGXie8qILf4wC/OS9gZ4edHaMNWqQOtwDAaL0/Fo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238374; c=relaxed/simple;
	bh=YY6kRpNmd8dl7oFFOoorQW2xHd3JC+1v0+OJXJv8TBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hc4K/MO/HHOkEBIyTdbf4kIktll8LzRmlYo4PwUq+m0KF5DyoIzhGF8qBkcbtpvE6nb8Ekd5Ct2GpImQwSAqakiBvRLEadrXoqZhXOIifPDsyNQT2FyaiwhWhGKmVX9rwyYgkMc9HFrqAapHK/0fb9uYAAwsPTw5zCfX0ZRH/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvvgHPmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88748C113D0
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 16:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761238374;
	bh=YY6kRpNmd8dl7oFFOoorQW2xHd3JC+1v0+OJXJv8TBE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uvvgHPmWaketdKAwhNIm3Ol+uKqtmQoYZX8a22R3w7kN2YaNV5d81l7AViQpYWJ8u
	 C59V03q7vZXV+PG5fxwUs+h4iAIt2JSGI3v1AnUOPSC7mh3Q7zhy39W3lGoxNpXNNV
	 6bK1d4cvMYpwNdcr7cmRWEXhUUEAKcBkhLGPaZwWvntRpY9UptTF7Lk4VXvRmeUSqi
	 2e4TUoDCyJIxFGrfpDMzIAWK2rmjp/XwETNg1iks+IWXoj3YAyrIycG1ffFmH42ab5
	 BHZnogUtXyRUsIGbc8SBQs1wdlIbnMYYirDQJm48SSENkIrAsfKnpXh0p9VYvgRSu9
	 oh9tJw+G5ddsw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-651cda151f0so575338eaf.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 09:52:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEsI7C/iZNVW7vjuLsOjVXj7FeYBUXdCgmzDeTrXwaidOBLZeUWJnaN2suTOoZMYSBVMsL3K0qeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNm6bbrJLbKedJy4IGalFDWbOki/8RCJFV6fJl6kANhefw4dk4
	Wuhbv1hLTa3Ul/hIVb68Eses7ATIO/EadzzrBH8LgmmB+EXBW7Vvg2I9DcpZnRt7ERgOq6aU9V8
	HBGVigRAeHzd/m77z90m3G3i16IRBeYY=
X-Google-Smtp-Source: AGHT+IEVOwqyMDHBoizFrpcSD0zS6S82A5hx6oqhxOS9knu8P2OEsTjlf0/AZWUZNCFXMraZoQv8a6I7j3Xa/aCrjnc=
X-Received: by 2002:a05:6808:1a0d:b0:441:d0be:3f0c with SMTP id
 5614622812f47-443a314f73bmr11465579b6e.46.1761238373795; Thu, 23 Oct 2025
 09:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2804546.mvXUDI8C0e@rafael.j.wysocki> <5043159.31r3eYUQgx@rafael.j.wysocki>
 <004501dc43c9$ec8aa930$c59ffb90$@telus.net> <5040239.GXAFRqVoOG@rafael.j.wysocki>
 <001a01dc4436$80b80aa0$82281fe0$@telus.net>
In-Reply-To: <001a01dc4436$80b80aa0$82281fe0$@telus.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 23 Oct 2025 18:52:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iinZJczWzp-kOmRnOCEv17FPVQZOjvs0zm4uQG-F024w@mail.gmail.com>
X-Gm-Features: AS18NWChh31LyIomfuDo4NhxKaKQN1tUlb2dm-_Wq_QG-k0iRZPZyb8vEXVOhS4
Message-ID: <CAJZ5v0iinZJczWzp-kOmRnOCEv17FPVQZOjvs0zm4uQG-F024w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] cpuidle: governors: menu: Avoid selecting states
 with too much latency
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Christian Loehle <christian.loehle@arm.com>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:03=E2=80=AFPM Doug Smythies <dsmythies@telus.net>=
 wrote:
>
> On 2025.10.23 07:51 Rafael wrote:
>
> > Hi Doug,
> >
> > On Thursday, October 23, 2025 5:05:44 AM CEST Doug Smythies wrote:
> >> Hi Rafael,
> >>
> >> Recent email communications about other patches had me
> >> looking at this one again.
> >>
> >> On 2025.08.13 03:26 Rafael wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >> ... snip...
> >>
> >>> However, after the above change, latency_req cannot take the predicte=
d_ns
> >>> value any more, which takes place after commit 38f83090f515 ("cpuidle=
:
> >>> menu: Remove iowait influence"), because it may cause a polling state
> >>> to be returned prematurely.
> >>>
> >>> In the context of the previous example say that predicted_ns is 3000 =
and
> >>> the PM QoS latency limit is still 20 us.  Additionally, say that idle
> >>> state 0 is a polling one.  Moving the exit_latency_ns check before th=
e
> >>> target_residency_ns one causes the loop to terminate in the second
> >>> iteration, before the target_residency_ns check, so idle state 0 will=
 be
> >>> returned even though previously state 1 would be returned if there we=
re
> >>> no imminent timers.
> >>>
> >>> For this reason, remove the assignment of the predicted_ns value to
> >>> latency_req from the code.
> >>
> >> Which is okay for timer-based workflow,
> >> but what about non-timer based, or interrupt driven, workflow?
> >>
> >> Under conditions where idle state 0, or Polling, would be used a lot,
> >> I am observing about a 11 % throughput regression with this patch
> >> And idle state 0, polling, usage going from 20% to 0%.
> >>
> >> From my testing of kernels 6.17-rc1, rc2,rc3 in August and September
> >> and again now. I missed this in August/September:
> >>
> >> 779b1a1cb13a cpuidle: governors: menu: Avoid selecting states with too=
 much latency - v6.17-rc3
> >> fa3fa55de0d6 cpuidle: governors: menu: Avoid using invalid recent inte=
rvals data - v6.17-rc2
> >> baseline reference: v6.17-rc1
> >>
> >> teo was included also. As far as I can recall its response has always =
been similar to rc3. At least, recently.
> >>
> >> Three graphs are attached:
> >> Sampling data once per 20 seconds, the test is started after the first=
 idle sample,
> >> and at least one sample is taken after the system returns to idle afte=
r the test.
> >> The faster the test runs the better.
> >>
> >> Test computer:
> >> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> >> Distro: Ubuntu 24.04.3, server, no desktop GUI.
> >> CPU frequency scaling driver: intel_pstate
> >> HWP: disabled.
> >> CPU frequency scaling governor: performance
> >> Ilde driver: intel_idle
> >> Idle governor: menu (except teo for one compare test run)
> >> Idle states: 4: name : description:
> >>   state0/name:POLL                desc:CPUIDLE CORE POLL IDLE
> >>   state1/name:C1_ACPI          desc:ACPI FFH MWAIT 0x0
> >>   state2/name:C2_ACPI          desc:ACPI FFH MWAIT 0x30
> >>   state3/name:C3_ACPI          desc:ACPI FFH MWAIT 0x60
> >
> > OK, so since the exit residency of an idle state cannot exceed its targ=
et
> > residency, the appended change (on top of 6.18-rc2) should make the thr=
oughput
> > regression go away.
>
> Indeed, the patch you appended below did make the
> throughput regression go away.
>
> Thank you.

OK, this is not an unreasonable change, so let me add a changelog to
it and submit it.

