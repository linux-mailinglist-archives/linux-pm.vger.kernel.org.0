Return-Path: <linux-pm+bounces-13306-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB53967B85
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 19:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7AB2B20FD4
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A9418308E;
	Sun,  1 Sep 2024 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="yxrYVAI+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA02428387
	for <linux-pm@vger.kernel.org>; Sun,  1 Sep 2024 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725212160; cv=none; b=qCXl6IcxV5v7E8vVvHN0xXmPDLzuvx+DgOGlsrUelrr3ntrtM+37emXDrLE/xq4Lc2/CoatIiKdG2Cj76aUSXcQ+Mr+bbv1Oq3Q8rD0Myt3Prp/cNqbjnYjCfehsVZ1kBejpdKAdCE/qgOjGYeY3oQHt7UhgNOJQ+mDsNs4UBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725212160; c=relaxed/simple;
	bh=8fo5RF9hn9Cwx+3dapT7AvCdfyDW7Ccdnmkq86JSTdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVjYCcs4zvab1wwM2HQuNG9BCdMMugWDrnHa0EVlN1r2OU/SUmwo2+mpJ6FHEbXVFrefJREmokijXHxQ/p734eGOEm/XaZUHSSkDi81NNzJpyMm5TV74qSyPdzETsqp/9Inc70fzv7RjsJL14lUwjDW4JuqP8S/YJ+zs1U5S7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=yxrYVAI+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8682bb5e79so417285766b.2
        for <linux-pm@vger.kernel.org>; Sun, 01 Sep 2024 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1725212157; x=1725816957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BBXN7KTwAPMDesT9rI+sPHbVfqONlmGBvlSCIWfwlXo=;
        b=yxrYVAI+4s/+TLFPUiyJvuJfD1g4vmfH6/hb5NfdMxQIGMItIPzxP0x52uAf8SBrde
         f7nU4PMCSXlT69xouK5lt8Gzzc9vDuk7VPGW7efF+H9mJl+KrUGDNPeHcjumeHzux225
         s0+8jIEQ1Yu1++byXm8U1cM67ineeoXUe+KJI8ZEhaMRSB5dnt6fdep6NVSiBJoJ/FLN
         iojG3PYPq3bFzERNifRqI/zIk4gOwrDGfpzXImpAhmMZXuRYycuId9jlJ90k/VbzmwlR
         FwuSfk5czshAcy3nVSHfvydWOCIq1wdgnrCilD42c8HrCZnzTqk9uB4wv0ayeGT1eRov
         ++PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725212157; x=1725816957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBXN7KTwAPMDesT9rI+sPHbVfqONlmGBvlSCIWfwlXo=;
        b=nep+x3Bwrr9iQ0oUbfa6SELmH06n9g1aA7YLfPkZWJZJ0xDn2sjp+5snasqdkxadEf
         2K0LVif1WeIrTJhTrhL7f+A43wFurrXHaRJTv5x2gMTJ7++JxRCLHe9VtP/RGhNeBLe9
         O5gUDS8O8xHJ0Id4NyLdM8nNBIAsV/sw1Nd1JI/0XeLZbzWfsC74ONLXPElrDsmYu7I5
         tuHyichF2o+FchHyf4COlF/kmXSVXf5DnJ6QsYmeogg/cwAsTKgDRpSlnuSoeG7W1ISr
         ogwzR37FpTzhLm3OcleYIVgHQeLJeN7Z8Jm0JoSJ0GeT4NoApXBIoVdTZMrUhjCH/xql
         GpUg==
X-Forwarded-Encrypted: i=1; AJvYcCWRNS8+FQWUZA1BFM36e7edt7DWPwwc6h6qciHpOdbsBWnlUjQ7pD+wA2wGh+yKvLCBxKYygx/iCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvMtJtQegB7DoCtX81x1PZvMCNB0WA4I9fYvqO3/wgpgPR4MHo
	jmXEytf9oWdfexVpm2WD/cKsT1RhIegu3mMFfmLmQMR6la3dNq4ounYBS3WAeEk=
X-Google-Smtp-Source: AGHT+IH7xmYFVMjw6pKYg40WLjly23kzrWCNbQw//RjLCm1t832Y5KCbXETGqptcdCiQK7P1WIaHcw==
X-Received: by 2002:a17:907:3e83:b0:a86:6fb3:fda5 with SMTP id a640c23a62f3a-a89fae1b889mr121955266b.32.1725212156658;
        Sun, 01 Sep 2024 10:35:56 -0700 (PDT)
Received: from airbuntu ([176.29.222.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988ff0465sm458214666b.29.2024.09.01.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 10:35:55 -0700 (PDT)
Date: Sun, 1 Sep 2024 18:35:52 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] sched: cpufreq: Rename map_util_perf to
 sugov_apply_dvfs_headroom
Message-ID: <20240901173552.h2pkra5fhkidzxd4@airbuntu>
References: <20240808234415.554937-1-qyousef@layalina.io>
 <bfcedd2d-6459-4611-8c4a-08cfdbdfbc5c@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfcedd2d-6459-4611-8c4a-08cfdbdfbc5c@arm.com>

On 08/16/24 16:44, Christian Loehle wrote:
> On 8/9/24 00:44, Qais Yousef wrote:
> > We are providing headroom for the utilization to grow until the next
> > decision point to pick the next frequency. Give the function a better
> > name and give it some documentation. It is not really mapping anything.
> > 
> > Also move it to cpufreq_schedutil.c. This function relies on updating
> > util signal appropriately to give a headroom to grow. This is tied to
> > schedutil and scheduler and not something that can be shared with other
> > governors.
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> > 
> > Changes in v3:
> > 
> > 	1. Add Reviewed-by from Vincent
> > 
> > Changes in v2:
> > 
> > 	1. Add Acked-by from Viresh and Raphael (Thanks!)
> > 	2. Move the function to cpufreq_schedutil.c instead of sched.h
> > 	3. Name space the function with sugov_ to indicate it is special to
> > 	   this governor only and not generic.
> > 
> >  include/linux/sched/cpufreq.h    |  5 -----
> >  kernel/sched/cpufreq_schedutil.c | 20 +++++++++++++++++++-
> >  2 files changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> > index bdd31ab93bc5..d01755d3142f 100644
> > --- a/include/linux/sched/cpufreq.h
> > +++ b/include/linux/sched/cpufreq.h
> > @@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
> >  {
> >  	return freq * util / cap;
> >  }
> > -
> > -static inline unsigned long map_util_perf(unsigned long util)
> > -{
> > -	return util + (util >> 2);
> > -}
> >  #endif /* CONFIG_CPU_FREQ */
> >  
> >  #endif /* _LINUX_SCHED_CPUFREQ_H */
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index eece6244f9d2..575df3599813 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -178,12 +178,30 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >  	return cpufreq_driver_resolve_freq(policy, freq);
> >  }
> >  
> > +/*
> > + * DVFS decision are made at discrete points. If CPU stays busy, the util will
> > + * continue to grow, which means it could need to run at a higher frequency
> > + * before the next decision point was reached. IOW, we can't follow the util as
> > + * it grows immediately, but there's a delay before we issue a request to go to
> > + * higher frequency. The headroom caters for this delay so the system continues
> > + * to run at adequate performance point.
> > + *
> > + * This function provides enough headroom to provide adequate performance
> > + * assuming the CPU continues to be busy.
> > + *
> > + * At the moment it is a constant multiplication with 1.25.
> > + */
> > +static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util)
> > +{
> > +	return util + (util >> 2);
> > +}
> > +
> >  unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> >  				 unsigned long min,
> >  				 unsigned long max)
> >  {
> >  	/* Add dvfs headroom to actual utilization */
> > -	actual = map_util_perf(actual);
> > +	actual = sugov_apply_dvfs_headroom(actual);
> 
> Maybe you can even get rid of the comment above now.
> sugov_apply_dvfs_headroom(actual) is pretty self-explanatory.

It was actually not clear to folks based on previous discussion. And I already
doing many changes on how dvfs headroom is done on another series. So I think
it is worth it.

> 
> Anyway
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thanks for having a look!

> 
> >  	/* Actually we don't need to target the max performance */
> >  	if (actual < max)
> >  		max = actual;
> 

