Return-Path: <linux-pm+bounces-31744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1E9B17F07
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 11:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69EC51884845
	for <lists+linux-pm@lfdr.de>; Fri,  1 Aug 2025 09:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511221CC51;
	Fri,  1 Aug 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJCY9CFh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FDC1FA859
	for <linux-pm@vger.kernel.org>; Fri,  1 Aug 2025 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754039784; cv=none; b=rvr7DGh2KoPEUYfQIDaszTLoOzknfldNZX1wHaX+smwylWfHZ0L+mNZylj1soza/hSsrTu2k3Q5BWdKQhSbG0xqbNinDHr3CcyXhELtgEgxz+ZeuyDF0PYtJDdJmD2YdxS5QaQ8OUk6pSF80q4SikJpQvLHpoWgvsi8EGAb43Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754039784; c=relaxed/simple;
	bh=fa9+ov28+MX2K1Kp1KjWa2+srlo/bIqCExyH063Zjkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlbHGKBFIgm6RuzrqzRgsXd62wF9fDVae/ftSK0TIwv9+UWtkdtQF0KWpGX9/1rJkKItT1nYcIttUeY7bLTFqL9ijCCuCClrkIDHRjjcRTSdfE4IXY4mPBnQIK7FogYQwxpNGoksS49C5lD4vZnWhJw31eUpHIwrX2/GNwHhRAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zJCY9CFh; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4aef56cea5bso100151cf.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2025 02:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754039781; x=1754644581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DsbZnKhWzsjIK8O2iDWXpNdpZv9uvnWsvlRdO5T4I/0=;
        b=zJCY9CFhgmk4yrH84k5T6hiEp68qdWEIzeQjnRTIJA2cy7Mmq4/N3bsnFZmZeyECbx
         BSv/hWZscOzgBFMb5TGYhSq5I64rlTBQgdj5BMyes/K5jAjyNOAsmnMCkN3NdGcybym/
         OrSCdReIaO1unr8gUtzlqEMTs8bC2wledbCxco2xCXS4bn/62UDKNmpWaeBMsks5P5q2
         WUCOHq9zB9SDYZnjLrlXxY/MixtRv1sr2DRen1xj53u/7dmRP1zQzcaQl8rg4lTtgwkU
         kmTAtGni3hdVxIUltOnvIfIUAUZJHve2/aZx1vE7nHk1D0kEZQZlXBGEiqAUpmaZE4j7
         Pbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754039781; x=1754644581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsbZnKhWzsjIK8O2iDWXpNdpZv9uvnWsvlRdO5T4I/0=;
        b=d5Fs6QRcZI7PTAKhskx8OBp9r4fvzts/B0Kw9Ps/6cUZRsyI0jpDuhDchKjLPzFK65
         6Dn9fHPnL4OUSUWltrCh/aYM7ZfFQ9Z6HxCRWaZafW1C8nbKM8IA2CvEVipB0lRuD04u
         VICUwNbEzbA4ksotWC05A79YRTWCfTCVdoJXIbECV62qxfJT1siO0aEVrZ4gw6dSN2Pq
         7SpIVpQy28xHs8BpJ843kBPkmmnQkyvPCYQMlFH6WLeY7R3TDxwU5rqM/MDzrTA49EqD
         vfnSXLDpcSVMVhR+k3IBoMiSGWjeZ++7V7LMqIs51g88nzyPKZSMS+mvaefpNC3m1puH
         jbkw==
X-Forwarded-Encrypted: i=1; AJvYcCWae8hEzGtSovmHhFPQIOo+QihwSddk8acj0YyyKXy/hQ+Ov5X17aBdhglp9PUk+wCSx93iiEYXoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxude3Lsd6SN0j0r+6BWbyrRfS7AWq/sk3nfGU249vt3GF252Wg
	oHvOBt+0xXW0fiLPNa9hvLOOLH+b79fs5/qq+G9eHqmdOSOZ91NqPPBIyNbOwOyncHcfdTROzak
	dY5pUr/RYfp19YmALYccfBaIezKBAYvwnXzINByV4
X-Gm-Gg: ASbGncsMZqUXlo2/UlEPeM1XG5R/uIa6KTkc5nXNLdnFr/KQv05pvE9MfBsvSb2an6c
	ioTOSefZjtdh6v+jrvKoqaeOBXATs13uHbCnEDuLwhndy1VQjTrhk6QE9HDGnBdoyoJxdAmLjos
	U4AdcvYoydgUtHUNAMe4Dsdc24QviSIeh5ojasWOgeHysl98oq6unVpvujtCyqO7kNdYOBScDld
	Tta+1s=
X-Google-Smtp-Source: AGHT+IEJ9gZkrr+QV9xlixblkDKToRoKnuV69cDq/FKpB1m6r8hiV84seprZDaQlUudjazAfohOas/SZpHO/oK1O1Z4=
X-Received: by 2002:ac8:57c4:0:b0:48d:8f6e:ece7 with SMTP id
 d75a77b69052e-4af006c115emr3662741cf.3.1754039781021; Fri, 01 Aug 2025
 02:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFivqmKBgYVa6JUh82TS2pO915PUDYZMH+k-5=-0u1-K9-gMMw@mail.gmail.com>
 <aHTOSyhwIAaW_1m1@arm.com> <CAFivqmJ912sEdSih_DFkiWRm478XUJhNDe=s2M_UO2gVTu4e3w@mail.gmail.com>
 <CAJZ5v0irG16e2cM_tX_UeEJVmB_EdUvk-4Nv36dXoUS=Ud3U5A@mail.gmail.com>
 <CAFivqmLoDv_pWdmBG8ws-CMUBXcb9bS1TgMaxW9YZMqqHpRSyA@mail.gmail.com>
 <20250722032727.zmdwj6ztitkmr4pf@vireshk-i7> <CAFivqmLG0LriipbmM8qXZMKRRpH3_D02dNipnzj2aWRf9mSdCA@mail.gmail.com>
 <CAFivqmJ4nf_WnCZTNGke+9taaiJ9tZLvLL4Mx_B7uR-1DR_ajA@mail.gmail.com>
 <aIso4kLtChiQkBjH@arm.com> <CAFivqm+kbRbJsJ_Obb4bV6fgxbqAwOndLUCDwHvWWnpMYoNoNw@mail.gmail.com>
 <aIvSe9VtZ-zlYfbQ@arm.com>
In-Reply-To: <aIvSe9VtZ-zlYfbQ@arm.com>
From: Prashant Malani <pmalani@google.com>
Date: Fri, 1 Aug 2025 02:16:08 -0700
X-Gm-Features: Ac12FXyiyR_nWdM8AoeyrPqneFIz4IuACWU7woeh5UlvHMD9kIQ3YDAT9xAtfZw
Message-ID: <CAFivqmKR1dqVqTsoznH2-n8cyAM1=5zEGcEvmESU8RNGac-0sA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Beata Michalska <beata.michalska@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jie Zhan <zhanjie9@hisilicon.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"

HI Beata,

On Thu, 31 Jul 2025 at 13:31, Beata Michalska <beata.michalska@arm.com> wrote:

> Thank you for the info, but I'm exploring ways that will not increase the time
> window between the reads.

IMO this issue is intractable on non-RT OSes like Linux (at least,
Linux when it is not compiled for RT), since we basically need to
ensure atomicity for the reading of both ref and del registers together.
We can't disable preemption here, since some of
the code paths (like PCC regs) acquire semaphores [2].

This also explains why we don't see this issue while reading the same
registers from firmware (running an RTOS). There, the same readings
are accurate (whether the CPU is idle or loaded).

So mitigations like increasing the delay are the only practical recourse.
IAC, I hope this doesn't detract from the discussion regarding the patch
series in this thread, which is about the idle optimization
(which I think we should pursue).

> While we are at it, would you be able to drop me some numbers from your
> platform, preferably good and `bad` ones:
> both counter values, and the bits that are used for mapping performance to
> actual frequency (nominal freq/perf, reference perf)

Sure. There are two pathological scenarios.
The first is when the CPU is idle/mostly idle. Here are some counter readings
(I used ftrace for all of these, and the max possible frequency is 3.4GHz):

t0: del:2936200649, ref:972155370
t1: del:2936208538, ref:972157370
ref_perf:10
delivered_perf:39

t0: del:1733705541, ref:518550840
t1: del:1733713524, ref:518552820
ref_perf:10
delivered_perf:40

This scenario is handled by this patch series.

The second is the heavily loaded CPU case.
Here are the counter readings:
t0: del:93896505680, ref:27625620970
t1: del:93896521640, ref:27625625360
ref_perf:10
delivered_perf:36

t0: del:94258513479, ref:27795493670
t1: del:94258529230, ref:27795498090
ref_perf:10
delivered_perf:35

These aren't as bad, but still above the stated maximum.
These get addressed by [1].

And here is a "good" measurement when the CPU is loaded:
t0: del:102081104909, ref:30074917840
t1: del:102081121558, ref:30074922660
ref_perf:10
delivered_perf:34

HTH,

-Prashant

[1] https://lore.kernel.org/linux-pm/20250730220812.53098-1-pmalani@google.com/
[2] https://elixir.bootlin.com/linux/v6.16-rc7/source/drivers/acpi/cppc_acpi.c#L1509

-- 
-Prashant

