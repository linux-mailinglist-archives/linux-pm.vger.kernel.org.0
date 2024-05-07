Return-Path: <linux-pm+bounces-7576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5178BDFF4
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 12:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB12289FEE
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FE414EC7E;
	Tue,  7 May 2024 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="E/o9YTuf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9B7828B
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078530; cv=none; b=n3/VJfc9Ea4ja0KV+x3PqJxPym9smejksMmNiPTYL1/aZaQ83tkI+YQY8DMqT6+ItteipR0vuX5m5idGJzUo06lRfUl/xb3wzzL/ubObseqBHKadyRO8L9KHl8RvHttREHfhsAWsEy7TW0ZVbnlVWqWjZHNj/FnFCKAtt9C+b1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078530; c=relaxed/simple;
	bh=U5VgfOOP6YcgNQcpBS/3Hv+gg9zIwZpEKcCDlvS0cGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsqbvZukP3cZI9FQCStxamH45ZpfHkPwaNBFsWp9BMaGsX3/inCFgwopO/Ac/bv1IyoDJbLGwZogbllTKgwclYPvsQIkZIwrUpkUegNQdY5R1V6mKGalfyBt2mnO4hC8JRp9/apW5E6RZ7JjEschfewnUjLKWhdP8fXgQwoFjv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=E/o9YTuf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41ecffed96cso16489695e9.1
        for <linux-pm@vger.kernel.org>; Tue, 07 May 2024 03:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715078527; x=1715683327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXzvyFG6l9gTH5dCnOcuMruwGnZepx9teig8QB5iF2w=;
        b=E/o9YTufLkZ0xMxexdfkMsCaAjTTCHkOi1CIMx0E8a0u1tjv7jzICEttAxmDqyZ5z7
         JbJQgIak1bgefKBe+MEniElFkQ/NVw7XEZZdAaqUOJI7niQd2gele80ghwHs9dLktpAX
         4KG6hqahm3jOhP1uEewVwsYIaI+V3nKxfKjtqXNf3ibEhSj9cRPDFhKDcMvmtZYFExh6
         mx9S5yWJxzuFXRZaoZZamZwBEQM5MJkxp6fvlg9z6JNqzUCUwGZjfF+bZ7OejeVw1GI7
         obgVdt5tiZkRf1cjI6Lr0HFqWv/lytQ1iYltoLlxG1NaXTD4nm4Tzr0AozDDZyDiqVFN
         tgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715078527; x=1715683327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXzvyFG6l9gTH5dCnOcuMruwGnZepx9teig8QB5iF2w=;
        b=AgfhPWsatRobjq4dYPvR6RfpKnQ1UMXF/6rH0tgUKAW9b1DU734+kaFGQRipsFeO+f
         J8tvuJ4ft5aYCuSRPCTPwOvKV8T5y/Zz/NYNKSX53Un58COtKb1FkvXbu1qE9jbhxx+A
         5HroEmuEaj9NgOg20HAs+3ZJsYycLw9n8b9ynto6f5ewOYL6OUaec1xwGzCUd7K6UgxI
         +cEcIqSRpMAnTbWuTaahxNsr5CDiYMx5bShoe9/HH0la1MKXm8CZoDsYnEiZ+nh29QE2
         zMI40ZYzuZ+oEzB2yUfcARQFYaElN2yMilP7zlRkB73YTtzNvcxNPXcp5peoj0DBbRtw
         MUow==
X-Forwarded-Encrypted: i=1; AJvYcCUj9n36u97oEnZMglha52LPxK7lNOsgwxbjZCu9UnJX8ZdR8X0Q0wA7Bt4DxQDO7zNaGVMm0wp3KdX5VvFh1vWz/YV0etLiQos=
X-Gm-Message-State: AOJu0YxKCAaPZ8W9VHsRJf1W/XxOEmVAEbS2DjvEBYizBG44wBB+bEa7
	4TqgW+ectQAtSvJ3byzaWfVEScs8acQJnujApyzuEGUVh2tulzCpVYOwPg62rjLbX7QMfpUXqq9
	g
X-Google-Smtp-Source: AGHT+IEwQzUr+WPNmHd8pSO2aHlUlJakrkwXToj6yKou3S87UBLoS3VKq0/TORQePW3TDQ05vb4nxw==
X-Received: by 2002:a05:600c:46ca:b0:41c:11fe:4de3 with SMTP id q10-20020a05600c46ca00b0041c11fe4de3mr10030220wmo.24.1715078527041;
        Tue, 07 May 2024 03:42:07 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c469100b0041b083e16e2sm23107663wmo.2.2024.05.07.03.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 03:42:06 -0700 (PDT)
Date: Tue, 7 May 2024 11:42:04 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Consolidate cpufreq updates
Message-ID: <20240507104204.ugnyrpwhrbtjkv7d@airbuntu>
References: <20240505233103.168766-1-qyousef@layalina.io>
 <20240506100509.GL40213@noisy.programming.kicks-ass.net>
 <20240507005659.d4rzzaoq3isanndf@airbuntu>
 <20240507080230.GP40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240507080230.GP40213@noisy.programming.kicks-ass.net>

On 05/07/24 10:02, Peter Zijlstra wrote:
> On Tue, May 07, 2024 at 01:56:59AM +0100, Qais Yousef wrote:
> 
> > Yes. How about this? Since stopper class appears as RT, we should still check
> > for this class specifically.
> 
> Much nicer!
> 
> > static inline void update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> > {
> > #ifdef CONFIG_CPU_FREQ
> > 	if (likely(fair_policy(current->policy))) {
> > 
> > 		if (unlikely(current->in_iowait)) {
> > 			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
> > 			return;
> > 		}
> > 
> > #ifdef CONFIG_SMP
> > 		/*
> > 		 * Allow cpufreq updates once for every update_load_avg() decay.
> > 		 */
> > 		if (unlikely(rq->cfs.decayed)) {
> > 			rq->cfs.decayed = false;
> > 			cpufreq_update_util(rq, 0);
> > 			return;
> > 		}
> > #endif
> > 		return;
> > 	}
> > 
> > 	/*
> > 	 * RT and DL should always send a freq update. But we can do some
> > 	 * simple checks to avoid it when we know it's not necessary.
> > 	 */
> > 	if (task_is_realtime(current)) {
> > 		if (dl_task(current) && current->dl.flags & SCHED_FLAG_SUGOV) {
> > 			/* Ignore sugov kthreads, they're responding to our requests */
> > 			return;
> > 		}
> > 
> > 		if (rt_task(current) && rt_task(prev)) {
> 
> doesn't task_is_realtime() impy rt_task() ?
> 
> Also, this clause still includes DL tasks, is that okay?

Ugh, yes. The earlier check for dl_task() is not good enough. I should send
a patch to fix the definition of rt_task()!

I think at this stage open coding the policy check with a switch statement
is the best thing to do

static inline void update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
{
#ifdef CONFIG_CPU_FREQ
	/*
	 * RT and DL should always send a freq update. But we can do some
	 * simple checks to avoid it when we know it's not necessary.
	 *
	 * iowait_boost will always trigger a freq update too.
	 *
	 * Fair tasks will only trigger an update if the root cfs_rq has
	 * decayed.
	 *
	 * Everything else should do nothing.
	 */
	switch (current->policy) {
	case SCHED_NORMAL:
	case SCHED_BATCH:
		if (unlikely(current->in_iowait)) {
			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
			return;
		}

#ifdef CONFIG_SMP
		if (unlikely(rq->cfs.decayed)) {
			rq->cfs.decayed = false;
			cpufreq_update_util(rq, 0);
			return;
		}
#endif
		return;
	case SCHED_FIFO:
	case SCHED_RR:
		if (rt_policy(prev)) {
#ifdef CONFIG_UCLAMP_TASK
			unsigned long curr_uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
			unsigned long prev_uclamp_min = uclamp_eff_value(prev, UCLAMP_MIN);

			if (curr_uclamp_min == prev_uclamp_min)
#endif
				return;
		}
#ifdef CONFIG_SMP
		/* Stopper task masquerades as RT */
		if (unlikely(current->sched_class == &stop_sched_class))
			return;
#endif
		cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
		return;
	case SCHED_DEADLINE:
		if (current->dl.flags & SCHED_FLAG_SUGOV) {
			/* Ignore sugov kthreads, they're responding to our requests */
			return;
		}
		cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
		return;
	default:
		return;
	}
#endif
}

