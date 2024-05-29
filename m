Return-Path: <linux-pm+bounces-8337-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5748D2DD3
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 09:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382D31F24B94
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2024 07:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FED11649BE;
	Wed, 29 May 2024 07:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qLzVCfvm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7279916192F
	for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966593; cv=none; b=uhVOBNxjqwBmfNgNBS201Ps+cjEoYGYHDj80gJnASC7s9d6fR4b3sFEFtmrC3C+Xg4pT+/hJ31Lb9Vhmij+wmQoQ+p9jObiUff1rtyaKKKFt2jG8koSSsG5IGSgWf5/dooqlFp4W5/z6ehkls4r3nbx+0AE5x+oY60dqPhcAVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966593; c=relaxed/simple;
	bh=XfaFWKu7oi4Neymy5/WAUYtnx6Hwuj7EMkKj1osWQxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPHhQgRc+XURzw72lM2lrPo84vK6IEp9gswOSbfxiCUsSjji95tpjGsaYF889EYyWHkk6Uoii9sbA27ZSwqTcFa1QqntHojQ2G3zc7RaZD1WJU13rDNI76hXFY8krKWk3O2rpeavaAxPFdKWD0zWpGQyi19vchcyGqaclQ/59wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qLzVCfvm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f449f09476so3645475ad.1
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2024 00:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716966590; x=1717571390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YfBLr2Fq0mXBI98PC9MxWEJ6lX7NEiIePEepGikvn2Q=;
        b=qLzVCfvmBO50vwXYmETujCr2L5xuJhnhC7GMfYE3N6A7E6Szh4OoKCkIk7PBPuhIjc
         4pwoRYAVz8kpBo0NLwTalAOX04CZXsE9u/74uIj+BbeW82xithArOGgmr6EFYuZp4RuW
         PLEYE2/dTe4U+3t8BTtDVWurUtnpav+toBccoTrRWqRUwCXB2tAvcW88/CD1nfpx35rG
         2wsRn3W6TmrZ4voI3bZcfqyzoqMFenunRQH23FWrLfXlacstx2jH4dri1axY47Lp2CXC
         9wzPcB4ZBfsdgLSnoHcJ0/KMbgm0dd/lcKeIEv/ME7bIK4O6dTlXVHquGImnjrMArIFz
         kBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966590; x=1717571390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YfBLr2Fq0mXBI98PC9MxWEJ6lX7NEiIePEepGikvn2Q=;
        b=GRGIME8vjXMqCS9RpJcHbesql9w+h9agsel8l5Py6hjDFCj0IpFy4Vlve8nCDS+JPK
         J3Kc4+S/lg+tvK6f6Rd8zSWVQmRA+v9MNo/kOLRlhvGd2BFJGUExb8fg2rE4kbVn/FVp
         G65ctEhzy8PeQCO1cMCoRu7hZVZ1ZIRpbteKo847JuIhufsung9NtEgQpDMJ5w2hgDmr
         1Rua/AsUnTPACBvVIbfENmnHD35XGM++2upI3suZ4jzt3wAC0ai38TIe7nqwxkK41wth
         RkmYJ0U+37he0/5EKwPucwiyNS07lkxqLJnavE8ZCQI1gGOyT7baKCNFLFSXaw7HNqZz
         b/bw==
X-Forwarded-Encrypted: i=1; AJvYcCUDchZhrlHD3LJPwjhS33Iyd7dXgMgiKxE+3Q8acn+0T7Z33/uO4YZLQY5x+UZ+QqJBawG0PM4xu9/u2eX2VTglGOL5W7IWyHo=
X-Gm-Message-State: AOJu0YyX8fm/SdKnw2tpVCllzsupDyi8YWgRhSHosRCYvi8lbimU7RA2
	9ZojG3ZmjagO/j8MhZpnhDVSWt/CBaiJhD0xkaMl+eMror1/ViRbUoSvWTHBPMM=
X-Google-Smtp-Source: AGHT+IHTai1Wf/bfUCzbnNhmze+7eirkLIlslk7bczKV8arj21k0uHlqRjM8dak5Buu6wHOSQM9dhg==
X-Received: by 2002:a17:902:db09:b0:1f5:e4ea:9869 with SMTP id d9443c01a7336-1f5e4ea9b7bmr3831925ad.9.1716966590325;
        Wed, 29 May 2024 00:09:50 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f47737d71csm67837305ad.303.2024.05.29.00.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:09:49 -0700 (PDT)
Date: Wed, 29 May 2024 12:39:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: Questions about transition latency and LATENCY_MULTIPLIER
Message-ID: <20240529070947.4zxcdnu32d2u7cny@vireshk-i7>
References: <20240528012110.n6se3mapwxgqa3r2@airbuntu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528012110.n6se3mapwxgqa3r2@airbuntu>

HI Qais,

On 28-05-24, 02:21, Qais Yousef wrote:
> Hi
> 
> I am trying to understanding the reason behind the usage of LATENCY_MULTIPLIER
> to create transition_delay_us. It is set to 1000 by default and when I tried to
> dig into the history I couldn't reach the original commit as the code has gone
> through many transformations and I gave up finding the first commit that
> introduced it.

The changes came along with the initial commits for conservative and ondemand
governors, i.e. before 2005.

> Generally I am seeing that rate_limit_us in schedutil (which is largely
> influenced by this multiplier on most/all systems I am working on) is too high
> compared to the cpuinfo_transition_latency reported by the driver
> 
> For example on my M1 mac mini I get 50 and 56us. rate_limit_us is 10ms (on 6.8
> kernel, should become 2ms after my fix)
> 
> 	$ grep . /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_transition_latency
> 	/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:50000
> 	/sys/devices/system/cpu/cpufreq/policy4/cpuinfo_transition_latency:56000
> 
> AMD Ryzen it reads 0, and end up with LATENCY_MULTIPLIER (1000 = 1ms) as
> the rate_limit_us.
> 
> On Intel I5 I get 20us but rate_limit is 5ms which is requested explicitly by
> intel_pstate driver
> 
> 	$ grep . /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_transition_latency
> 	/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:20000
> 	/sys/devices/system/cpu/cpufreq/policy1/cpuinfo_transition_latency:20000
> 	/sys/devices/system/cpu/cpufreq/policy2/cpuinfo_transition_latency:20000
> 	/sys/devices/system/cpu/cpufreq/policy3/cpuinfo_transition_latency:20000
> 	/sys/devices/system/cpu/cpufreq/policy4/cpuinfo_transition_latency:20000
> 	/sys/devices/system/cpu/cpufreq/policy5/cpuinfo_transition_latency:20000
> 	/sys/devices/system/cpu/cpufreq/policy6/cpuinfo_transition_latency:20000
> 	/sys/devices/system/cpu/cpufreq/policy7/cpuinfo_transition_latency:20000
> 
> The question I have is that why so high? If hardware got so good, why can't we
> leverage the hardware's fast ability to change frequencies more often?

From my understanding, this is about not changing the frequency too often.
That's all. And it was historical and probably we didn't get better numbers with
this reduced to a lower value later on as well.

> This is important because due to uclamp usage, we can end up with less gradual
> transition between frequencies and we can jump up and down more often. And the
> smaller this value is, this means the better we can handle fast transition to
> boost or cap frequencies based on task's requirements when it context switches.
> But the rate limit generally is too high for the hardware and wanted to
> understand if this is pure historical or we still have reasons to worry about?

Maybe Rafael knows other reasons, but this is all I remember.

> From what I've seen so far, it seems to me this higher rate limit is helping
> performance as bursty tasks are more likely to find the CPU running at higher
> frequencies due to this behavior. I think this is something I can help these
> bursty tasks with without relying accidentally on this being higher.
> 
> Is there any worry on using cpuinfo_transition_latency as is if the driver
> doesn't provide transition_delay_us?

Won't we keep changing the frequency continuously in that case ? Or am I
misunderstanding something ?

> And does the kernel/driver contract need to cater for errors in driver's
> ability to serve the request? Can our request silently be ignored by the
> hardware?

cpufreq core maintains its state machine and the failures are used to inform the
user and / or stop DVFS. It is useful for a clean approach, not sure what we
will get / miss by ignoring the errors..

> Not necessarily due to rate limit being ignored, but for any other
> reason? It is important for Linux to know what frequency we're actually running
> at.

One is that we report to userspace two frequencies:
- scaling_cur_freq: The frequency that the software thinks the hardware runs at
  (last requested freq i.e.)

- cpuinfo_cur_freq: The real frequency hardware is running at. Can be calculated
  using counters, etc.

And there will be tools which are using them. So these are required.

> Some hardware gives the ability to read a counter to discover that. But
> a lot of systems rely on the fact that the request we sent is actually
> honoured. But failures can mean things like EAS will misbehave.

-- 
viresh

