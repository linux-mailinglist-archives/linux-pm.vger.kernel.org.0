Return-Path: <linux-pm+bounces-29684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC6AEBE2E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 19:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40E43B59BA
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4332EA72E;
	Fri, 27 Jun 2025 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNO4M3jQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EFD2EA727
	for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751044051; cv=none; b=nJn2e2ztEgcwfVB70amm8xI1JXk7fHHGPBqyTa8AICYwc0PYKJ/x1WQEHZJIhijC0g+xqOhNk+hrYVumrb/zRPCKrfwC3A1VWbFuISdRW8cFRLfpVBUp/uoYoOeWGXS2dpIL9FEXmcrCCYCU9DOxgYvUbjMBDcGEppkO4pcfvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751044051; c=relaxed/simple;
	bh=otXY5bSrY5xQCnGv8vAhYSiPzAlIJ3HwVEv08LlcErs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEaVCsx+lbRwms439sAXb+1fHZY/JIj4e3Se6kaleAuyvPYVaj9scj3AAzBnO4JJK4IYIeGidP/4ofFOZm8x8V/gR54qWzrZOdN7pETp0i9zSpGETDO1AMfl1CgLObX9GGreWEXDcfTHCJNfT3fRnbdBl78EJ5VVgKT8bPQDuVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNO4M3jQ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a7f5abac0aso16611cf.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Jun 2025 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751044049; x=1751648849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RloYayd5wBONgu0eildPglcuE/QLMbxICUIKSWflWiY=;
        b=yNO4M3jQ40VH+iMh9KKuRKv0WfWe7MEwhS3lEO2O1cmhjJxn+47ENDXw5SXNQIiXeX
         g8s7JpCFyLxpUbNxAfqH73u8zs/KYkZ+yf/iccs4hB06q5yppvf0XWLdC11flDEqY0ue
         4Dut86CPS9+akIxzgBmMOpow8nlXA2OdtwJFY6LdzihGkeP35kw45pVbYLIkh1Zxt9bD
         4OimqKD8fX8qbIRImC0vr7o5XcqE1T2r6pkHLFyKWPGsitOua4or5h95wmHy+N61Ax2u
         2F98NBgVMG5qNCDJ1ND18uRTiaBjLKmWlz2gbFcRUPktZZNjKxNhyADq6DLm0j/O936M
         0Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751044049; x=1751648849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RloYayd5wBONgu0eildPglcuE/QLMbxICUIKSWflWiY=;
        b=JR4XSpQ0mZZV+sdHftVW63ng15ufc230fCgymkETYWdfvvrHZ9utGkpHHQX3gBQl6Z
         BSXkr/s2e9HxHKspUTSeE8Ic57SO9RnH68kvPDf+KhdTtxvfuXmV9eYjE2+mfjqkZjVc
         8TxhCQJ6EwgoKnIRskDZWCAIpMYxi20G5XJLU6HN4eGl9g5nXwq7muvsGi1xbMT7ar1T
         /FfV+3JWc5AYPvE9/UVZcrh+lUuClZjx18DAFx6/LK79lxoIF0H5FY4iFBU+pK7IJpjS
         GgFIly6Mlo+ZCnxAqhgBrXRdRJvLSKZdJWJnyXPH9ctHjl0kI6Bokt4KbtOwko54wALN
         qfcA==
X-Forwarded-Encrypted: i=1; AJvYcCUrcejbEAl5H6wlG+PrEgdKVyubOUN6FUgKdRP+9EqX664FMjRoR+AxZeDgwGjL3mgc5/wYUcCNrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtoiU1ruD0rSAhwLZOH5STrleMmMmeO1xQjSyL6JxgY1uFNsk/
	/gaQf7KweVFCr2mFQE4sEkhvNUYffRxme2Myw7GX69upnVHKcsJOyFXM+7VQmQqamOl6gKNNCYg
	n7aCsqt4h2/S3xxTOcvvWCLa6LOiz5gcMgNWn08G/
X-Gm-Gg: ASbGnctNRYfQMo2m/bPze/oJp3yC3S0QokqYlesLYmeigR6Uh8QhiTdsowQn9LczQVM
	Ph8ovc5Wck7eiH5HvJb4BLBSsn8/3AHP056SajHdulxPoKpB4/teDpsjr4QjsYJz+cpQLcXXdSt
	yVas1PVSIt4ghMG/orqKuuyVqv7FXG/WaZDEwfgc5z8g==
X-Google-Smtp-Source: AGHT+IHfIn/2qyi/BP2LcbO4Liai4hJXszJynHIfFVZxjB6pzjgudjP5yfk0uqdKYttjGQzdkn2KQRLHLLEkCzldxDg=
X-Received: by 2002:a05:622a:d0:b0:494:b833:aa42 with SMTP id
 d75a77b69052e-4a80675f5bemr706221cf.5.1751044048314; Fri, 27 Jun 2025
 10:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619000925.415528-1-pmalani@google.com> <20250619000925.415528-3-pmalani@google.com>
 <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com> <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
 <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com>
In-Reply-To: <ef3f933a-742c-9e8e-9da4-762b33f2de94@hisilicon.com>
From: Prashant Malani <pmalani@google.com>
Date: Fri, 27 Jun 2025 10:07:16 -0700
X-Gm-Features: Ac12FXwIUxZ0Aa04QLpPk6LjrweXUU0nZqRt-LeVwPBIJoLNPs9CENWzcAXt3xE
Message-ID: <CAFivqmLCW2waDnJ0nGbjBd5gs+w+DeszPKe0be3VRLVu06-Ytg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Beata Michalska <beata.michalska@arm.com>, 
	z00813676 <zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jie,

On Fri, 27 Jun 2025 at 00:55, Jie Zhan <zhanjie9@hisilicon.com> wrote:
>
>
> Hi Prashant,
>
> Sorry for a late reply as I'm busy on other stuff and this doesn't seem to
> be an easy issue to solve.
>

No worries, the ping was in general to all the people in the thread :)

> For the latest kernel, [1] provides a new 'cpuinfo_avg_freq' sysfs file to
> reflect the frequency base on AMUs, which is supposed to be more stable.
> Though it usually shows 'Resource temporarily unavailable' on my platform
> at the moment and looks a bit buggy.
>
> Most of the related discussions can be found in the reference links in [1].
> [1] https://lore.kernel.org/linux-pm/20250131162439.3843071-1-beata.michalska@arm.com/
>
> As reported, the current frequency sampling method may show an large error
> on 1) 100% load, 2) high memory access pressure, 3) idle cpus in your case.
>
> AFAICS, they may all come from the unstable latency accessing remote AMUs
> for 4 times but delaying a fixed 2us sampling window.

I tried applying [1] which consolidates the ref and del register reads
into 1 IPI, but that did not make a difference. The values still
fluctuate wildly.

>
> Increase the sampling windows seems to help but also increase the time
> overhead, so that's not favoured by people.
>

This experiment did not appear to help in our case. It's a point in
the direction that this method is inherently inaccurate during idle
situations.

> On 20/06/2025 13:07, Prashant Malani wrote:
> > Hi Jie,
> > On Thu, 19 Jun 2025 at 20:53, Jie Zhan <zhanjie9@hisilicon.com> wrote:
> >> On 19/06/2025 08:09, Prashant Malani wrote:
> >>> t0: ref=899127636, del=3012458473
> >>> t1: ref=899129626, del=3012466509
> >>> perf=40
> >>
> >> In this case, the target cpu is mostly idle but not fully idle during the
> >> sampling window since the counter grows a little bit.
> >> Perhaps some interrupts happen to run on the cpu shortly.
>
> Check back here again, I don't think it 'mostly idle'.
> Diff of ref counters is around 2000, and I guess the ref counter freq is
> 1GHz on your platform?  That's exactly 2us, so the target cpu is mostly
> busy.

I don't think the reference counter increment means that the CPU is
"busy" or "not idle". Per [2], it just means that the "processor is
active".

idle_cpu() returning true means that the CPU is just running the idle
task, and has nothing in its runqueue.
In our experiments, this is always the case at least when the cpu is
being brought online (which kind of makes sense).

> > I don't think this is necessarily an issue. The ABI doesn't need to be
> > synchronous; it is merely a snapshot of the scheduler view of that CPU
> > at a point in time. Even the current method of perf counters sampling
> > is purely hueristic. The CPU might be idle for the 2 usec the
> > sampling is done, and servicing traffic before and after that.
> > This is inherent whenever you are sampling any system state.
>
> Then the issue is not totally solved, just less often?
>

Yes. I don't think this can be completely solved, given the inherent
inaccuracy in hardware. What this *does* do is mitigate one of the
scenarios, while not impacting sampling when the CPU is actually doing
something useful; as such I don't see much downside to including it.

Best regards,

[1] https://patchew.org/linux/20240229162520.970986-1-vanshikonda@os.amperecomputing.com/20240229162520.970986-4-vanshikonda@os.amperecomputing.com/
[2] https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html?highlight=cppc#performance-counters

-- 
-Prashant

