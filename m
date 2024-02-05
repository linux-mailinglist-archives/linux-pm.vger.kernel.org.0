Return-Path: <linux-pm+bounces-3445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCE984A8D5
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 23:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3621F2FE15
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 22:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7CD495EC;
	Mon,  5 Feb 2024 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="J0a3c7vS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8A2495D6
	for <linux-pm@vger.kernel.org>; Mon,  5 Feb 2024 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170057; cv=none; b=iBB55w9GJxoCPOg/Y6XHVwQIjrlxIwRadcn5G2Mw4E4buT368XbE2LJghPMr3Sv1iPq7q1A9J/APNE4tVO59iV25Tfn7s68uyR/tKHnsIodFZee6++4Rn+IrSFMe3m8evr4tL7YO70ijbSlfHYXvOI7SxIXX73DYfDupk/1OR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170057; c=relaxed/simple;
	bh=KVLbdtcvvaRSgN5gQozZaogwWueF7opXRhVnd4wm9FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFeb5YGLT8KbzjfTAsySR55nolL07snIVX0hhymPkcMLBppsiSwMs7GkCD3RPthIK6fF7ydCVfeE5dtytRw+4cN0h5fa1U4O/1h0dKCHfceGaaemkq1Nty5qUMRP0janQMN/f1kHZAhRqFI8hn3bLcVjq3k6Ve2afRMFFoF1q5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=J0a3c7vS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b189ae5e8so2555156f8f.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Feb 2024 13:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707170053; x=1707774853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJG9p3OAfhgHtIwPepd82NCHlUMu8iwvMVaHA0OKEWc=;
        b=J0a3c7vSUUdUE77NgNkzaEpveQPd93qe1FG9O/k+BrqA9SSRg/ExeBVgsF5302klSp
         PgJqe49qqOWijNZnR9nt1dC2SkgxpGvLppq5RBHKyd5itZn8EIWGi8xROS0LLHLLvLWt
         bGzuxU0wIZ1Cp6xGhm9q6eJqOuaQUwAmKGpwzOLIqDWi5Xs+ZTs9eA9cwv4fhZB+YLsg
         PP0MGCdhVmi+lJ6W/3bUWQ7q84Bv1p7Xx5e8n5hky9TqFpJrWpnvwamLXnWDvNlZrExd
         bHpFAgKFffMlHjF1L1OAVpUaYhtQndLnUEOKzWFt2yZaT404FDaj/cStg5I+O0UsPHxq
         1b7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707170053; x=1707774853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJG9p3OAfhgHtIwPepd82NCHlUMu8iwvMVaHA0OKEWc=;
        b=M0ZETs4ZqmSSmMK0rJwL1jJTGtNqm9QmRm2K5DE1b00yjk5gnI+U6KrIYpmz3UMSjk
         oFF951WogPysWU+Rtaq0kgsk5frsJhoySVD2LRKgT3RyVWKpELpv1SHJoD1vCEvVRalu
         UaHwbZwwTegJOmGk5orgBSjBCNg9av8WgjSNEuy9vB9kwDStnSkKQu4p1o5wZo3xq+6X
         xC7EV3buMYMA7ZZTxxed1LLx8madpgeidJIe9nYURUihzzQytb7McHXpCz+M62iLXH36
         EkY/tOQsO/7H/Vcp5HgdasFWUcSOPY7K2aWUUr4Wq3jJJ/DX3HSjul/oO0qnnELrYwpc
         1Unw==
X-Gm-Message-State: AOJu0YxRXfytnumxfXPCKM8SbaPaA+U16KnTnSKznbOELEEZD/3MSVkw
	LZsb4xOXwLKKmg+fTs2qzj0fEvZ2/WaUJwstWOiFiNaxJmfzYPCO5n595EE1uxyWeI0Fkmh3UM7
	V
X-Google-Smtp-Source: AGHT+IGqUCnla9965GAGUHJeOJCUyaMBeqetovxkgY0647ee/GZDHFAn7XycGxzkeRTzC/j0kyJbyw==
X-Received: by 2002:adf:a2d1:0:b0:33b:1a3f:a699 with SMTP id t17-20020adfa2d1000000b0033b1a3fa699mr143950wra.62.1707170052774;
        Mon, 05 Feb 2024 13:54:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUt6XYUS8FSatEDUB8oWqGn0r0F8pDlWUKCOpRxEid5RL4eptqMhEJpB6H3iVATcdhPJpw+62TWpC9YEr6GmCGPyVCAIHuSCWV81+kopFG+pHasoorO86IL8BBDA64tWhINknFhfxOfeQmdc/Hu77Cje0If2gcdSMzDNMcTnxDXy+RweSrhV8dajJLE+z9/7J5Dgw76QZCWKqC2TaWjIlaFzLfZJjjPTfPVz+TQaSJypSonGtobr2PTXIhuXExdY2gh7vic17eFxNaPGN27dKxIY1sFyupLTed7I1c4jQ==
Received: from airbuntu (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id b11-20020a5d4b8b000000b0033af9b7db6esm541892wrt.22.2024.02.05.13.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 13:54:12 -0800 (PST)
Date: Mon, 5 Feb 2024 21:54:10 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] cpufreq: Change default transition delay to 2ms
Message-ID: <20240205215410.3opxw4ty2tpbsgbc@airbuntu>
References: <20240205022500.2232124-1-qyousef@layalina.io>
 <326b568d-d460-4a69-9336-28da328ffdcf@arm.com>
 <20240205120147.ui5zab2b2j4looex@airbuntu>
 <f782f0d4-99ba-4876-bd20-03aaae20c0e0@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f782f0d4-99ba-4876-bd20-03aaae20c0e0@arm.com>

On 02/05/24 17:35, Christian Loehle wrote:
> On 05/02/2024 12:01, Qais Yousef wrote:
> > Hi Christian
> > 
> > On 02/05/24 09:17, Christian Loehle wrote:
> >> On 05/02/2024 02:25, Qais Yousef wrote:
> >>> 10ms is too high for today's hardware, even low end ones. This default
> >>> end up being used a lot on Arm machines at least. Pine64, mac mini and
> >>> pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
> >>> it's too high for all of them.
> >>>
> >>> Change the default to 2ms which should be 'pessimistic' enough for worst
> >>> case scenario, but not too high for platforms with fast DVFS hardware.
> >>>
> >>> Signed-off-by: Qais Yousef <qyousef@layalina.io>
> >>> ---
> >>>  drivers/cpufreq/cpufreq.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >>> index 44db4f59c4cc..8207f7294cb6 100644
> >>> --- a/drivers/cpufreq/cpufreq.c
> >>> +++ b/drivers/cpufreq/cpufreq.c
> >>> @@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
> >>>  		 * for platforms where transition_latency is in milliseconds, it
> >>>  		 * ends up giving unrealistic values.
> >>>  		 *
> >>> -		 * Cap the default transition delay to 10 ms, which seems to be
> >>> +		 * Cap the default transition delay to 2 ms, which seems to be
> >>>  		 * a reasonable amount of time after which we should reevaluate
> >>>  		 * the frequency.
> >>>  		 */
> >>> -		return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
> >>> +		return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));
> >>>  	}
> >>>  
> >>>  	return LATENCY_MULTIPLIER;
> >>
> >> Hi Qais,
> >> as previously mentioned I'm working on improving iowait boost and while I'm not against
> >> this patch per se it does make iowait boosting more aggressive. ((Doubling limited by rate_limit_us)
> >> Since the boost is often applied when not useful (for Android e.g. periodic f2fs writebacks),
> >> this might have some side effects. Please give me a couple of days for verifying any impact,
> >> or did you do that already?
> > 
> > I don't understand the concern, could you elaborate more please?
> > 
> > Products already ship with 500us and 1ms which is lower than this 2ms.
> > 
> > On my AMD desktop it is already 1ms. And I think I've seen Intel systems
> > defaulting to 500us or something low too. Ideally cpufreq drivers should set
> > policy->transition_delay_us; so this path is taken if the driver didn't
> > populate that. Which seems to be more common than I'd like tbh.
> 
> I'm not disagreeing with you on that part. I'm just worried about the side
> effects w.r.t iowait boosting.

I don't see a reason for that. This value should represent hardware's ability
to change frequencies. It is not designed for iowait boost. And it being high
means folks with good hardware are getting crap performance as changing
frequency once every 10ms with today's bursty workloads means we leave a lot of
perf on the floor for no good reason. And as I tried to explain, already
platforms ship with low value as this is how the hardware behaves. We are not
making iowait boost more aggressive; but bringing the fallback behavior more
inline to what properly configured platforms behave already today.

> 
> > 
> > I never run with 10ms. It's too slow. But I had several tests in the past
> > against 2ms posted for those margin and removal of uclamp-max aggregation
> > series. Anyway. I ran PCMark storage on Pixel 6 (running mainlinish kernel) and
> > I see
> > 
> > 10ms: 27600
> > 2ms: 29750
> 
> Yes, decreasing the rate limit makes it more aggressive, nothing unexpected here.
> But let's be frank, the scenarios in which iowait boosting actually shows its
> biggest benefit you are either doing:
> - Random Read (small iosize), single-threaded, synchronous IO
> - anything O_DIRECT
> and I'd argue more than likely you are doing something wrong if you're actually in
> such a case in the real world. So I'm much more worried about boosting in scenarios
> where it doesn't help (e.g. on an Android quite frequently: f2fs page cache writeback).
> 
> Decreasing the default transition latency makes (sugov) iowait boosting much more aggressive,
> so I'm curious if this patch increases power consumption on systems that were at 10ms previously
> when in non-IO workloads.
> 
> Hope that clears that up. Again, not an argument against your change, just being cautious of
> the potential side effects and if they need some mitigations.
> 
> Kind Regards,
> Christian

