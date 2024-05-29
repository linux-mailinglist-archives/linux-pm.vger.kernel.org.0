Return-Path: <linux-pm+bounces-8357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA678D34E2
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 12:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED10287AD8
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 10:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2D816EBEF;
	Wed, 29 May 2024 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="kHMKpuyu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEB71667C1
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716979792; cv=none; b=L8YoF2T73vHykm9two+On7u9fnf+KHccBqZcPp4kkTzOp0tVa05UwFuVE+j37PuzYe7sKFnyGYos3rr5RO3qFRItIcVMz2rDp4iwRRib3Mhp3Ms9gEu5+hz/MoTlcZVBEN7978rIe/FUD4Hea25vy6PfatK4vdPKKDRKibAQljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716979792; c=relaxed/simple;
	bh=Pr/U/nVNuU9P9EoTL2TtKbrFCdG3F3QLoKpQx2KMmgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY7YjwV4DMmzXIIzN6Rv9jn94tI4scWMpxsSwvm5qUVAizkJ9A47ul5oVoB9c22IXaNmN62LXg7fwXQzeYDkDeQNnRjvM5oB+Sa2zwT9hpOMS0ZO0eEmAfLfyVFeXkD1mc6cj2xM3CpX0QYhv9vA5a1O0xO2/NDAu0GTSQ9RiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=kHMKpuyu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4210aa0154eso10460725e9.0
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 03:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716979789; x=1717584589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1/gFwOMitDXUQkYesnOGOUX+glSBcKx0J8m0m0l5u9g=;
        b=kHMKpuyuWee29Pz6TesobX2TFgdYVTeUuRbn1LZFeL6RGkCvva2hbQ8NMD0SoX4TYv
         ANyfWqoAyxG+VQVcstoQdmwdINfnsJpSy+NNrV35K06hBX8dVRFcw8eDiaz5/6OSaNxo
         mcpRTRcBSiyCtUoGCtBwQMjTrFi6UrWW8YAlzWgi6TrCAmJ/tzuhgMflYdaL//2JlcAZ
         49Tq2CO6y0JTs6vP8EigezdGPfaBO4nIPTsMLm4QOqDIXnmQ5srv8SWgMel41UiXU+40
         zmK7omzwu+ES3bzp5yPO3dQS6NllIK5eAHTGPxtm2unrEYZYbJFvJTAkGSwhxWO9f8vu
         zuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716979789; x=1717584589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/gFwOMitDXUQkYesnOGOUX+glSBcKx0J8m0m0l5u9g=;
        b=sp9TMioZoHXrKChtQDDdwp7oN/SZKXlfKhBDa6mwMOeagX3D6M4vkEVpIpqiklnSFE
         kaa+A6aULyn8Godccb+EjKg6vv7fnMyFXaSl/yyOfrKmP6E2qKauN1Oe2Kr8pIrr8fg9
         DEr+Yr0fubmfFek5Zk2IyJy6NjSoTWC8RW2cDpKYFag16uUedfDFm9m/EWg7BR6SjkA5
         0ashrdfJZIktQqDD9Rm9ftChF23vwrcy7bkzHM1i4NiaRx5mv84kI3R+QFBxUI88i7i5
         /alhZOZVQX24eyA4n1qEXquaPqFAGUMM3b50V8DOqpo4dAJ3srtFIY9vNNP10s9IyBNU
         7qVA==
X-Forwarded-Encrypted: i=1; AJvYcCUeZMJETf9wyF5RXISH4aVM2FqzRw7TtZRWNX1lR+Z5Yh0B2PZn/MhRlRIVC6DUfqr5E62i33fDoRF+AiC68AfviIpK2RT2mbI=
X-Gm-Message-State: AOJu0YzrF1OhRT99DOtKRY8zo9mqH+6CGhQhb0tYAjGIE27VVR1GstO1
	wfIiu6DaCdtFvWJ6lIgYI71gxh+Cyn8qVdkFEv10Wf3py9k4iWPgLrDP2ABIN+g=
X-Google-Smtp-Source: AGHT+IFyD/h5Hjxn5U5yKEN3VlaeOR/orKuvJr0VbxqBrufFoLdNJn3gbTOUdAoBrtJITGT96SwuaQ==
X-Received: by 2002:a05:600c:1391:b0:421:1e47:f809 with SMTP id 5b1f17b1804b1-4211e47f831mr52391005e9.36.1716979788856;
        Wed, 29 May 2024 03:49:48 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b58sm176585235e9.3.2024.05.29.03.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 03:49:48 -0700 (PDT)
Date: Wed, 29 May 2024 11:49:47 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: Questions about transition latency and LATENCY_MULTIPLIER
Message-ID: <20240529104947.o3pnahmcm7wzi6jb@airbuntu>
References: <20240528012110.n6se3mapwxgqa3r2@airbuntu>
 <20240529070947.4zxcdnu32d2u7cny@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529070947.4zxcdnu32d2u7cny@vireshk-i7>

Hi Viresh

On 05/29/24 12:39, Viresh Kumar wrote:
> HI Qais,
> 
> On 28-05-24, 02:21, Qais Yousef wrote:
> > Hi
> > 
> > I am trying to understanding the reason behind the usage of LATENCY_MULTIPLIER
> > to create transition_delay_us. It is set to 1000 by default and when I tried to
> > dig into the history I couldn't reach the original commit as the code has gone
> > through many transformations and I gave up finding the first commit that
> > introduced it.
> 
> The changes came along with the initial commits for conservative and ondemand
> governors, i.e. before 2005.

Thanks for the tip!

> 
> > Generally I am seeing that rate_limit_us in schedutil (which is largely
> > influenced by this multiplier on most/all systems I am working on) is too high
> > compared to the cpuinfo_transition_latency reported by the driver
> > 
> > For example on my M1 mac mini I get 50 and 56us. rate_limit_us is 10ms (on 6.8
> > kernel, should become 2ms after my fix)
> > 
> > 	$ grep . /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_transition_latency
> > 	/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:50000
> > 	/sys/devices/system/cpu/cpufreq/policy4/cpuinfo_transition_latency:56000
> > 
> > AMD Ryzen it reads 0, and end up with LATENCY_MULTIPLIER (1000 = 1ms) as
> > the rate_limit_us.
> > 
> > On Intel I5 I get 20us but rate_limit is 5ms which is requested explicitly by
> > intel_pstate driver
> > 
> > 	$ grep . /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_transition_latency
> > 	/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20000
> > 	/sys/devices/system/cpu/cpufreq/policy1/cpuinfo_transition_latency:20000
> > 	/sys/devices/system/cpu/cpufreq/policy2/cpuinfo_transition_latency:20000
> > 	/sys/devices/system/cpu/cpufreq/policy3/cpuinfo_transition_latency:20000
> > 	/sys/devices/system/cpu/cpufreq/policy4/cpuinfo_transition_latency:20000
> > 	/sys/devices/system/cpu/cpufreq/policy5/cpuinfo_transition_latency:20000
> > 	/sys/devices/system/cpu/cpufreq/policy6/cpuinfo_transition_latency:20000
> > 	/sys/devices/system/cpu/cpufreq/policy7/cpuinfo_transition_latency:20000
> > 
> > The question I have is that why so high? If hardware got so good, why can't we
> > leverage the hardware's fast ability to change frequencies more often?
> 
> From my understanding, this is about not changing the frequency too often.
> That's all. And it was historical and probably we didn't get better numbers with
> this reduced to a lower value later on as well.
> 
> > This is important because due to uclamp usage, we can end up with less gradual
> > transition between frequencies and we can jump up and down more often. And the
> > smaller this value is, this means the better we can handle fast transition to
> > boost or cap frequencies based on task's requirements when it context switches.
> > But the rate limit generally is too high for the hardware and wanted to
> > understand if this is pure historical or we still have reasons to worry about?
> 
> Maybe Rafael knows other reasons, but this is all I remember.
> 
> > From what I've seen so far, it seems to me this higher rate limit is helping
> > performance as bursty tasks are more likely to find the CPU running at higher
> > frequencies due to this behavior. I think this is something I can help these
> > bursty tasks with without relying accidentally on this being higher.
> > 
> > Is there any worry on using cpuinfo_transition_latency as is if the driver
> > doesn't provide transition_delay_us?
> 
> Won't we keep changing the frequency continuously in that case ? Or am I
> misunderstanding something ?

I have schedutil in mind, and it shouldn't. Other governors maybe. Should it be
up to the governor to scale this then?

For schedutil it shouldn't because utilization changes gradually. But we could
have events where tasks migrate between policies and if this task has big
util_avg then we can have big jumps. If this migration frequency is often, then
yeah we can end up with scenarios. But isn't this desired? We want the previous
policy to bring the frequency down ASAP to save power, and the new policy to go
up in frequency to accommodate for the new task.

Only issue I see is !fast_switch case schedutil needs to put some additional
delay due to kworker triggering and performing the actual request.

I haven't been looking at other governors to be honest. But if I am to propose
something I'll make sure they are not impacted.

> 
> > And does the kernel/driver contract need to cater for errors in driver's
> > ability to serve the request? Can our request silently be ignored by the
> > hardware?
> 
> cpufreq core maintains its state machine and the failures are used to inform the
> user and / or stop DVFS. It is useful for a clean approach, not sure what we
> will get / miss by ignoring the errors..

Ah, I am not requesting to ignore the error. I am worried it can be ignored
silently. Looks like this is not the case.

> 
> > Not necessarily due to rate limit being ignored, but for any other
> > reason? It is important for Linux to know what frequency we're actually running
> > at.
> 
> One is that we report to userspace two frequencies:
> - scaling_cur_freq: The frequency that the software thinks the hardware runs at
>   (last requested freq i.e.)
> 
> - cpuinfo_cur_freq: The real frequency hardware is running at. Can be calculated
>   using counters, etc.
> 
> And there will be tools which are using them. So these are required.

I was just trying to check with more frequent requests whether we are more
likely to encounter errors. And if we'd fail safe then as knowing the current
frequency is important for utilization invariance and EAS in general.

I'll look more at cpufreq core paths to verify. If you have big concerns please
let me know as I'm curious to explore how we can make things more responsive
but having heads up of the pitfalls would be much appreciated.

Thanks for the answers!


Cheers

--
Qais Yousef

> 
> > Some hardware gives the ability to read a counter to discover that. But
> > a lot of systems rely on the fact that the request we sent is actually
> > honoured. But failures can mean things like EAS will misbehave.
> 
> -- 
> viresh

