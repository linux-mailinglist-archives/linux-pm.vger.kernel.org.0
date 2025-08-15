Return-Path: <linux-pm+bounces-32421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A82B27821
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 07:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9551CC3136
	for <lists+linux-pm@lfdr.de>; Fri, 15 Aug 2025 05:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F242F23E347;
	Fri, 15 Aug 2025 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4MP8jAwg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306823C4F4
	for <linux-pm@vger.kernel.org>; Fri, 15 Aug 2025 05:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755234785; cv=none; b=oN3bQPxCE+bcPPKWwROtVROnDXD3rSNYtvjHk8JU36TCJNAQLynerl9Ie8zvbGWZFK1mio+A8wysn2bMa6UusQ19YngIaLxER1GpRQdhK4F5+DjaCCthhhMwtPjBb962bRbqqZ8k3wxKAkVuZ1PJoe+hHdIQLbnG91Wg6ilKBU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755234785; c=relaxed/simple;
	bh=asbWxOoHojySmFrLx18w24R1Ongn6WuKn2LRn6DzLwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctAMn7aAy/6Hc3x2iweQ4/NYGqC8wSSzLGD8YDsW3fIpmvWXQjjsd4D3uUH9SH8eAsY0E7xAIZiaCWmT6irt283R9Ggt6ooGFbP6ib5k0jAZOMwCvN2x0YA8HZnlSMOaydKI7WlrtHsugy5kmcCwtBW58q5zzuNKbZCz7uljj4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4MP8jAwg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-242d1e947feso119155ad.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Aug 2025 22:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755234783; x=1755839583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XGQ20RTBx/tdgXgITELcfzTQixi9kkZ3YBoW/JTOkqo=;
        b=4MP8jAwge1nbWQU34M4RmdLhQjA2wvm2PXqAlXQ1ID7U/R3j9oywchyt3uoy0VX/f+
         f1rHDVI6Tx5+zhlHiSTZbiIJDctgJFOjVHF36s2TJ8VViQAbtTH1+43UYjyRwVBF1fem
         W8hZzX0U5+h6OZox5GyCjDXD+DnCNdLjkR9ImahXI7qYGTf8tNe2Mu8xs3JetmKoCMRx
         Xbqk0x9batGp99rBAMYdQ4KHJYo1nIPTIW7E+hMcV5bxwyjEvvcqwUojkW0aGR5RlgwE
         1/z6zl9v1577yVMavXTU3n1mn6TRHf+O+iL4kN5cxMRbJVfrKnuSdzgsl4bmvQkMC6Fx
         RFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755234783; x=1755839583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGQ20RTBx/tdgXgITELcfzTQixi9kkZ3YBoW/JTOkqo=;
        b=LfWGpIhe0g/b8BCC8tRdn4mos2qgW4yH+nJ5piDqmok56VpMdYx8jF4Gdn4SeKtCAX
         ExCponOKrynWNJqGRcUGNAxBAZDWpj7Xnj7Dy7PmqlTaScPELsvFCZYbAefUma/26hOi
         t4qQ2EfWzbkyn02ROTUfGRMIUurQLYFwh1cjwVbudybbjTanqWnzkgc+WsqRoEjp7Lf9
         0WhDFAxFy/UnIN3+fuW84dWojULdtvmW4nJVdFMYmTTor9M0nPZ4fbBlFYtm3YyzCcX3
         Hl8pNyH0Ln9bQXyHYZ2Ra1YwwHLhGXGQKifUSAYl5Siv46N38agZjq09S88+zvgcLEMC
         CbKA==
X-Forwarded-Encrypted: i=1; AJvYcCWu4b42Lc8EH+XMXecT4MQdnqUV+R1qq9xHbv1A6obeTIUTVQwbKrFoHvVtlK5C92tTybh5hjBt6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLwBVq170cQRSQq0HAcEwI6rFAaH9fbkZmM0HkaK8/XIhhaiiL
	FpFHn9CZdaQQ1oJpwOA8aXbIujlLXGstrB+XPHMtC/zmkqwK+5i8g1Xd9DAWeYAdHg==
X-Gm-Gg: ASbGncv46x7pX7uLs8uWwGAUAdRlf0y9sy+1tmytTq6VGJWuBMy93v3N/2ur/gblqEM
	VrcBOFoblzqKshpQ+fcvXQ0/9TIKHCRS3NHV6bkHV4gnDHuqTxcmdCcmd+Ype42t4dtAwqSG+Dz
	nk5ybJau6dwnVIxyCfE37ySYsKnk5KS0mYvsFOXhjc+HHjC04lk81wcYRmR/BEVfM+OYftRN2HH
	jLsZZuBawQc0fAPh/y4lrp0rPql+D/mMyC4VeYv4EIMa4My5K55X/UjIKcvROdj+azZelg2Jova
	SppZ8Bdo3IvaLLROMLuZGMv3CqGnBMxsWAyQCR2XENKn5cNLe6kXRJbVHDhXF9cJgWWcvQJzQTk
	Z3l2Uyvsd81E5EGfDPC8HTY/PDXIM0Tw821Cf3Y4N5m3yuj/7SQjqkB7M5OboTCJlJ5Ys7vaoOS
	8FvwU=
X-Google-Smtp-Source: AGHT+IHveQGN41PwPlfYDxUUUwq2EqsHNQwAF3RAIPfs5cqhD+TK20yYEi9P/XIeXarW3cFWaQnS/w==
X-Received: by 2002:a17:902:c94c:b0:240:2bd3:861 with SMTP id d9443c01a7336-24469a6a864mr2555385ad.10.1755234783271;
        Thu, 14 Aug 2025 22:13:03 -0700 (PDT)
Received: from google.com (167.212.233.35.bc.googleusercontent.com. [35.233.212.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32331191102sm3463989a91.30.2025.08.14.22.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:13:02 -0700 (PDT)
Date: Fri, 15 Aug 2025 05:12:58 +0000
From: Prashant Malani <pmalani@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Beata Michalska <beata.michalska@arm.com>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	z00813676 <zhenglifeng1@huawei.com>, sudeep.holla@arm.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
Message-ID: <aJ7B2labaxza9duY@google.com>
References: <aIso4kLtChiQkBjH@arm.com>
 <20250731111324.vv6vsh35enk3gg4h@vireshk-i7>
 <aIvQvLL34br6haQi@arm.com>
 <20250801044340.6ycskhhkzenkzt7a@vireshk-i7>
 <CAFivqm+gBBSCoVUxmeatu8TjwunzBtfjeDMNBL0JCsPhkFEg5A@mail.gmail.com>
 <20250811060551.ylc6uutni4x6jqtg@vireshk-i7>
 <aJo5vP_mfBn_vxSF@google.com>
 <CAJZ5v0jvYBUPjSmXas+S8rOG2WAb5u7rk92Gbu1s7A=tJr4VPA@mail.gmail.com>
 <aJpMHkrWJIyHtHL5@google.com>
 <CAJZ5v0hXUoqmxwjH0CN8gGDj=qnC3ZWrJc5VarkqRfh=0SCUWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hXUoqmxwjH0CN8gGDj=qnC3ZWrJc5VarkqRfh=0SCUWw@mail.gmail.com>

Thanks a lot for taking a look at this, Rafael.

On Aug 14 13:48, Rafael J. Wysocki wrote:
> 
> First off, AFAICS, using idle_cpu() for reliable detection of CPU
> idleness in a sysfs attribute code path would be at least
> questionable, if not outright invalid.  By the time you have got a
> result from it, there's nothing to prevent the CPU in question from
> going idle or waking up from idle. 

This is a heuristic-based optimization. The observation is that when
the CPU is idle (or near-idle/lightly loaded, since FFH actually wakes
up an idle CPU), the AMU counters as read from the kernel are unreliable.
It is fine if the CPU wakes up from idle immediately after the check.
In that case, we'd return the desired frequency (via PCC reg read), which
is what the frequency would be anyway (if the AMU measurement was
actually taken).

In a sense, the assumption here is no worse than what is there at
present; currently the samples are taken across 2us, and (theoretically)
if the difference between them is 0, we take the fallback path. There is
nothing to prevent the CPU from waking up immediately after that 2us
sample period.

> Moreover, the fact that the given
> CPU is idle from the scheduler perspective doesn't actually mean that
> it is in an idle state and so it has no bearing on whether or not its
> performance counters can be accessed etc.

The idle check isn't meant to guard against accessing the counters.
AFAICT it is perfectly valid to access the counters even when the CPU is
actually idle.

> 
> The way x86 deals with this problem is to snapshot the counters in
> question periodically (actually, in scheduler ticks) and fall back to
> cpu_khz if the interval between the two consecutive updates is too
> large (see https://elixir.bootlin.com/linux/v6.16/source/arch/x86/kernel/cpu/aperfmperf.c#L502).
> I think that this is the only reliable way to handle it, but I may be
> mistaken.

This is interesting. I think it may not work for the CPPC case, since
the registers in question are in some cases accessed through PCC reads
which require semaphores. I think it would be untenable to do that in
the tick handler (but I may be mistaken here). It's easier on x86
since those are always just MSRs.
We could probably do it for the FFH case, but then we're bifurcating
the computation method and IMO that's not worth the hassle.

Perhaps some of the ARM experts here can think of ways to do this that
I haven't considered.

Best regards,

-Prashant

