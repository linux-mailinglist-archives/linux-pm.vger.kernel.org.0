Return-Path: <linux-pm+bounces-29124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A363BAE12CC
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 07:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD30167DB4
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 05:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC4C20C02D;
	Fri, 20 Jun 2025 05:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvQC5cLr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769082045B5
	for <linux-pm@vger.kernel.org>; Fri, 20 Jun 2025 05:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750396061; cv=none; b=mtE+zW51o2ruvwmvuvb0/6lycCpckXOLgQ8mEKNkkkI+J5BqonyFdcKApWtPYjUjLRo2/A26B/G8w+HMB08tUNG6glKXxO9FTJLwTJCps+IU7hMQUORZCe127S6rfEZWfbA3VpAnGernh4am0qG8MXbIkhjo6BrKJ/iv6ZqMwXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750396061; c=relaxed/simple;
	bh=ZPuERBo7QO2fNDQJj5jXHz0tmCHpkUf1iA9mwFBPlG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUwCHkedwzmsiyfXuWZf4ee5TlsB0eX5UbXBM6DIPAtSELFtOnJWewOYICVqEgzn+7BqFTesuAuu8JWRP9JbCPXGifvSVLTDNuFPlmVxwcHh6cXwUssLgfcxkVjGt/kqSMoskxtudWHuWDxk1w+D9J2tKT18hG7eXIlIQ57szHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LvQC5cLr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a5ac8fae12so623631cf.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2025 22:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750396055; x=1751000855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi1dRNmW9v9kZJVKZuZ422d93WXoXenypsG/vpx2Hio=;
        b=LvQC5cLrrqMX83YgqGmgeZs1wmnttmNaSRCQAH16Z0b5BcPzZr/Ma5WYlAlheyno5K
         1Z14kIw5qMqNhrV45+HiJXZP4iELW4N7Wx1ecewMeVzWUBwd58e/nCNNYY1A+HZIQTcl
         R1zJR2EisTK0FNlLHLqeC1kc06ZTUHVg8kGeEoln0cW6qwrLGs3A9eJIZ+ppBf/yDUuk
         GrJTlLMGIje5hp+GKr42UeZwoB7GBUG4EmL5EUQUPhEKD0awF2uTo/1vKK4o11Yx0BYW
         8p8Cy+ToM92x5HLt1r4s6LfEMFZBEvQseyydg/yvsgFrQjxBuOnmfQDgmX2glkuNjhuv
         Iq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750396055; x=1751000855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zi1dRNmW9v9kZJVKZuZ422d93WXoXenypsG/vpx2Hio=;
        b=MfvMcsKNEGZ38mm1srSBGOvX9uGV2ExQpC+0CsrZ82YvrlECHpkPHyQYVegMWZscwL
         HYAAq8F05+WXxaX3fwo+LPBvsXlCGBBVQUVFcbwbYvEMr1JL4u0fUEAGIVl+tuHE2F16
         zbOlfw9shvUE5kg+kvaeNvQjJivpLczEo5sLT8LrRRey2N7ofrtIR9hBGUyenqPTEhas
         d0ZwrT3liI2i6xXmq4+NackvekzxexoDBVSc/4DU4gRo/CoQrOX2tHhJ2WSJZ1H1rzsG
         Whv1ELBEhkiPINmuYvqdy+p0K182u9WKzV3WI8nEfpKURdJKPi0CUSpKTim9GCarLHPG
         cARw==
X-Forwarded-Encrypted: i=1; AJvYcCUxNz2Y3rJYzug0pyTE/bAOC6dwuicE+KlCsUOnHuNNfqGP+9qwgEKOLjx33deqnGrfApKrrsUGPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmK5Ikgo8eFzUvKeNSVFFymkwwWTPaAYwvOjW423GLZLP8ykil
	Qi/atXdOwY8me0cZSYovFGzq3fUWa7lCgaa0yc7meOutThD/Hj323LEr3hvKnS/pPN7yhaxB6A/
	yP7G3p0AMHPDgZ33xaM7bPE+3lTSgNvVTVj9XvA7e
X-Gm-Gg: ASbGncvexD8K2k9vqP6yoA/VHbTFdahU98XZ1kLcXh3x/N984B8x1mYiOMUDWJYYV84
	z8jmjXgj1JCcUKA/BN8ytF3iAt/sme2wfjTFdV5+94H0o5gZZvBUIl9QkNfSY+ex9QgYnmB2OBq
	HNCfIDKArt2gxUDK4T5NV0e5UWMzKDSd3eNTJ0z01JxsekFHdEwZ76
X-Google-Smtp-Source: AGHT+IFledh2myvoe5r+ARqkEYbiZ5jZhea1V2mr5zrXadNweHTzgnx8nlQ1jaJYH0ez2W8L6+QMQxIRh9BKVE5yfw8=
X-Received: by 2002:ac8:590b:0:b0:49c:ffd4:abcc with SMTP id
 d75a77b69052e-4a76fb03819mr5144121cf.27.1750396054973; Thu, 19 Jun 2025
 22:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619000925.415528-1-pmalani@google.com> <20250619000925.415528-3-pmalani@google.com>
 <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com>
In-Reply-To: <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com>
From: Prashant Malani <pmalani@google.com>
Date: Thu, 19 Jun 2025 22:07:23 -0700
X-Gm-Features: AX0GCFtM9HJqUMIvrUxhg-F6u1n_14pB4HUhNmgkWCltVnwZImqNKjyQfZv2hHQ
Message-ID: <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
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

Thanks for taking a look at the patch.

On Thu, 19 Jun 2025 at 20:53, Jie Zhan <zhanjie9@hisilicon.com> wrote:
> On 19/06/2025 08:09, Prashant Malani wrote:
> > AMU performance counters tend to be inaccurate when measured on idle CPUs.
> > On an idle CPU which is programmed to 3.4 GHz (verified through firmware),
> > here is a measurement and calculation of operating frequency:
> >
> > t0: ref=899127636, del=3012458473
> > t1: ref=899129626, del=3012466509
> > perf=40
>
> In this case, the target cpu is mostly idle but not fully idle during the
> sampling window since the counter grows a little bit.
> Perhaps some interrupts happen to run on the cpu shortly.
>
> Thus, the actual issue is the accuracy of frequency sampling becomes poor
> when the delta of counters are too small to obtain a reliable accuracy.
>
> Would it be more sensible to put a minimum threshold of the delta of
> counters when sampling the frequency?

I'm happy to throw together a patch if there is some safe
threshold the experts here can agree on for the minimum delta for
the ref counter. I would caution that with this sort of approach we
start running into the familiar issue:
- What value is appropriate? Too large and you get false
positives (falling back to the idle invalid path when we shouldn't), and
too less and you get false negatives (we still report inaccurate
counter values).
- Is the threshold the same across platforms?
- Will it remain the same 5/10 years from now?

>  BTW, that ABI
> doesn't seem to be synchronous at all, i.e. the cpu might be busy when we
> check and then become idle when sampling.
>

I don't think this is necessarily an issue. The ABI doesn't need to be
synchronous; it is merely a snapshot of the scheduler view of that CPU
at a point in time. Even the current method of perf counters sampling
is purely hueristic. The CPU might be idle for the 2 usec the
sampling is done, and servicing traffic before and after that.
This is inherent whenever you are sampling any system state.

I would imagine it is more reliable to trust the kernel scheduler's view
of whether a CPU is idle, than relying on counters and a calculation
method which are sensitive and unreliable for idle systems
(i.e stray interrupts can throw off the calculations).

That said, I'm happy to go with the approach folks on this list recommend.

Cheers,

-- 
-Prashant

