Return-Path: <linux-pm+bounces-13356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0209688F3
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 15:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74118284BB0
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426E819C56F;
	Mon,  2 Sep 2024 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="uWAc7ME2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF9841A80
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284049; cv=none; b=jdw1JScNLpNwwEqjSlbNrB8dHeDXHvVhTso4PHq+Mf3A5a139hmQPuQ4nRzEqM7FT1jb8nLeSIJWIYBgjtPhy8KNiO4v1M92Mu3Xo2ovkpjt9U4rsoWvFdO5cgVnLsUwGNWW7MYKNaTuOhSFNbHH4VWBbulUbQMPjE39somIEdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284049; c=relaxed/simple;
	bh=3kiYIQERd/jBydvZ1sy4TY5Rv42z/k4yehzEKKj9agA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2H3OgEtSXYxwhVrfuL+deA4hf/U6NDeXW/oZnLPUg95c9oT7gYApmjoI3Xxx8thQKZ+9XOG38zYio3r3G16+GnLnA71FW4VoWTp0xP+BDrsjsk5LDk+O6oWSLpuIzQrmsJZz8LovaWhQrYOes7fPTMfQBOD/RzU4G9d8vWL23U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=uWAc7ME2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8684c31c60so476453166b.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 06:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1725284046; x=1725888846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jE4PLRYXZuFOg+XHgRbqfn2bb2XHzdA1oNDs3KvmBeA=;
        b=uWAc7ME2cS5TDVWLX6mDSaEtjzXu2hv7cGgX0T9O+Tn9JpQfZq2nNSic5/U30gbU0+
         8HaVGjFOslgZzjb/+AdA78CkhNrKXRTyKv0W5F5Uhyh6krWb3uLfst4CWHY4yUr4SRoa
         jlQtCEpOsSHCV9rh6kS4ZCJJnDyBa3dFkj4WC3uS6HK6wQRsZUq1wNCVgU0CtgpmBRg7
         xL1/bLsTfJBvC8yB8VZLrUArYx4s3QM12T3q2P+TOCDZM7WMg1q1i39yh8ivEic86msG
         reITVVzFqFooYPN0Gv6QD+gaD5GSg+lZu4zCmnSGY/Pq2zAQXZ4Z4wf58x4wV0sI0KwM
         ma9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725284046; x=1725888846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jE4PLRYXZuFOg+XHgRbqfn2bb2XHzdA1oNDs3KvmBeA=;
        b=A9eT40uyt49VlEpCd+JwaEC0BB/MtphaELCwJV60NZICXI7KRS5sIanR/9cnydlpLE
         ONErPAwMfmdQasIoYpJztXF9lTRU1ozLfMVmrIdWxV2DiJ7+y1DHh53uUV+XeuDk6jQS
         acxQ5buX4syKzxcJsosdmElF4Qc6lcyy/7FQcU+xmU/0+ZiMxfM2sUtXem5dMHSZNwwa
         ApQ5+WUAA5pIRroXtioEngdnDuHdYUtWnGgzUqcADdf5C7y+asG21Sd3VQwDJwtC3aVu
         XvExa+D0zPqPTSHNDGLRERN6OwdOOFK1kdFMFYnwqc8ZZZ8KfSLtcchq6nn9FyiDhgJo
         vb+w==
X-Forwarded-Encrypted: i=1; AJvYcCXkid2Yyr602f5keNP6bsLqzQ/94l/jVDQyxTzLjqJ6TDTu/jhpISZHX+o26HCctAhKEabnIZPs0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGWLQiAO1x2IF19PKzN732hRv0j9skDuPe7K65Qc4W08xQ0I1U
	xC0xtt/RT89gOyxB2zObfPFOPWOTs7Et2HT/IGL4/5EQzmI3VqgkaaPuTrIrw/4=
X-Google-Smtp-Source: AGHT+IGsuer3UkqtNQarWn4zbYtPqCd2uHypIPD3fPqprX72fol+JVfGoYPgo8sqPmh+28zHcHgxeQ==
X-Received: by 2002:a17:906:6a1d:b0:a86:7f6e:5fe4 with SMTP id a640c23a62f3a-a897fad8082mr837505366b.67.1725284045598;
        Mon, 02 Sep 2024 06:34:05 -0700 (PDT)
Received: from airbuntu ([176.29.222.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb767sm564704466b.16.2024.09.02.06.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:34:05 -0700 (PDT)
Date: Mon, 2 Sep 2024 14:34:02 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
Message-ID: <20240902133402.dhyhnktol6pqj6jg@airbuntu>
References: <20240728184551.42133-1-qyousef@layalina.io>
 <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
 <20240901175149.46yfk335niccmfq4@airbuntu>
 <CAKfTPtBahrD5L8CbB4BijAvnwq=yG375TWDUuEvNipyTDYGQTA@mail.gmail.com>
 <20240902125815.vu3s25ciib34eu3a@airbuntu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240902125815.vu3s25ciib34eu3a@airbuntu>

On 09/02/24 13:58, Qais Yousef wrote:
> On 09/02/24 14:30, Vincent Guittot wrote:
> > On Sun, 1 Sept 2024 at 19:51, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 08/13/24 10:27, Vincent Guittot wrote:
> > > > On Tue, 13 Aug 2024 at 10:25, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
> > > > > > Hi Qais,
> > > > > > the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
> > > > > > freq updates still bothered me so let me share my thoughts even though
> > > > > > it might be niche enough for us not to care.
> > > > > >
> > > > > > 1. On fast_switch systems, assuming they are fine with handling the
> > > > > > actual updates, we have a bit more work on each context_switch() and
> > > > > > some synchronisation, too. That should be fine, if anything there's
> > > > > > some performance regression in a couple of niche cases.
> > > > > >
> > > > > > 2. On !fast_switch systems this gets more interesting IMO. So we have
> > > > > > a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
> > > > > > update request. This task will preempt whatever and currently will
> > > > > > pretty much always be running on the CPU it ran last on (so first CPU
> > > > > > of the PD).
> > > > >
> > > > > The !fast_switch is a bit of concern for me too but not for the same
> > > > > reason and maybe the opposite of yours IIUC your proposal below:
> > > > >
> > > > > With fast_switch we have the following sequence:
> > > > >
> > > > > sched_switch() to task A
> > > > > cpufreq_driver_fast_switch -> write new freq target
> > > > > run task A
> > > > >
> > > > > This is pretty straight forward but we have the following sequence
> > > > > with !fast_switch
> > > > >
> > > > > sched_switch() to task A
> > > > > queue_irq_work -> raise an IPI on local CPU
> > > > > Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
> > > > > with 1 CPU per PD)
> > > > > sched_switch() to sugov dl task
> > > > > __cpufreq_driver_target() which can possibly block on a lock
> > > > > sched_switch() to task A
> > > > > run task A
> > > > >
> > > >
> > > > sent a bit too early
> > > >
> > > > > We can possibly have 2 context switch and one IPi for each "normal"
> > > > > context switch which is not really optimal
> > > >
> > > > It would be good to find a way to skip the spurious back and forth
> > > > between the normal task and sugov
> > >
> > > Hmm I think we use affinity to keep the sugov running on policy->related_cpus.
> > > Relaxing this will make it less of a problem, but won't eliminate it.
> > 
> > yes, but it's not a problem of relaxing affinity here
> 
> If we have 1 CPU per PD, then relaxing affinity will allow it to run anywhere.
> I am just this will be safe on all platforms of course.
> 
> But yeah, I don't think this is a solution anyway but the simplest thing to
> make it harder to hit.
> 
> > The problem is that the 1st switch to task A will be preempted by
> > sugov so the 1st switch is useless. You should call cpufreq_update
> > before switching to A so that we skip the useless switch to task A and
> > directly switch to sugov 1st then task A
> 
> Can we do this safely after we pick task A, but before we do the actual context
> switch? One of the reasons I put this too late is because there's a late call
> to balance_calbacks() that can impact the state of the rq and important to take
> into account based on my previous testing and analysis.
> 
> Any reason we need to run the sugov worker as DL instead for example being
> a softirq?

I assume it performs non interrupt context safe operations. But I don't think
I've ever seen it sleep during an activation.

