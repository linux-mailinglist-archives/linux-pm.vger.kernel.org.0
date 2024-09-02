Return-Path: <linux-pm+bounces-13345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176CC96878B
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 14:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EC6280D37
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA4419E994;
	Mon,  2 Sep 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VP3FvDl7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697B19E989
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280259; cv=none; b=my7yvrbkMLa8iC8DPH/NG+nUMm9HE5fGTLfIzUa7pE6wpXeQnHKVUmMulsXxPlnOq9eev5Qy4/+YVoSSaSMLPbFGc/9mlKVeZ/Mwnt+e6H7NYH0Cos8DTnYD4Yr7C6SzdzRSKON21FLH3m8K+IByCL9+A0iMAb0yikgvEnXg6Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280259; c=relaxed/simple;
	bh=tM3qG/ci31a7cFZ/xJBtVOjjB74muXemCxxJ+8UpGp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrwJzXnzuQC/SMBsuMcL1mU4gksjUa0NwZhm+mAmfy0sCegXfb3me3kRFGtmS7t9TySIK0NHA+hsTLbHMfGGNgey7QWiSkJaSbrzYMsEKDRE3m2z0LsqPlbQGgCzywdl12y+grWzvDmWd30SrfBZMZxb4CvVxbTJZZzYivGMk2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VP3FvDl7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2021c08b95cso37971945ad.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 05:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725280258; x=1725885058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tM3qG/ci31a7cFZ/xJBtVOjjB74muXemCxxJ+8UpGp8=;
        b=VP3FvDl7LaWUq0gNFeriWxYXFHLjcaFmTAAwLy9ljwYBvh+0Lfb+DnROA4IawFqy1M
         MmBHJ+JVS4/Prycq082cAX+lUFVnlx0RC3XxyciyllKQeWNGtXvKPDS9G7V8rpG6yCCw
         S9z6OgmIFfanUeA1XtejTvuCmY9m6FwPOVVG+UyYYRa80T1HjuCCHOPdLVRcDfDkjU4x
         41dlzwPElznoYc/kNSxQmXUqzAh4/3OuV2UuegooPFh2RSZaHhmANJBS3rK68GmdhNm8
         KqDfgyn5X1OUY/6GOVdIzrEV4m1dpwO0jwZkJ40Xa4Ym8kciwd+b6pKqOZnXqfEBOox2
         Dv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725280258; x=1725885058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tM3qG/ci31a7cFZ/xJBtVOjjB74muXemCxxJ+8UpGp8=;
        b=iWpzwu3rR97XUlsRoAfdQ73KEfd9eolWy+cBQ5xaDgkzqLO82F/5YFRytK2tFtfb8d
         E1uIhB/JwZ0oTPit5VFWSQAbwHfVG+eKDOCezYA1MgtX1v8fRJojGqn+kW9vnIJJ4zei
         5jeVmgvthc5Kb93uhJMO6SJF9nWm8Y5QJRIZ53nwNtNiWKx+LKhc9/Z3azTkHWorLvdG
         c3GBwvhxw484K//bfuHvNCgQ5I8RkanQRbBU0ZakC2Jf9NQqClqmw6z5bF9bocItGq+o
         +BlIr8DdqKxw56Rbw3+mhPhTOI6QXVvQoCUNfq1REev4Zh4eTcvz05Ke1pa/C1RS+1hB
         9v1g==
X-Forwarded-Encrypted: i=1; AJvYcCXbucaXTpKQgL0xbVSMVyNRq4E7EeuKwqBtsp3mMCnAam03gZ6NwPCrc0dlVfYlzhhPgcBuhiWCRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwTKeqbuEyyYSSqPOrqpiKq0abjhb8B+Tuz7xqnIHByeysdkcZ
	LcshPMZ8bJi23b6xJCk2NzZhcHI860Q0me3TMqdNkggiJFthVS5uvHqlmoDtwezLRryTX2+0Q/w
	3jSukE/x8vrZJBs6l0rrjx08EFtH6iTckfnMwVA==
X-Google-Smtp-Source: AGHT+IEXvZIaAkwXaFZIyyKALQVsidIRGXrJUb6IY+ewKFKKFGwxGlpjLdLzBOWWPUKgUFSLvqbMgCdNTeaqvYqXPsw=
X-Received: by 2002:a17:902:e741:b0:205:85f1:7fb6 with SMTP id
 d9443c01a7336-20585f181admr27721715ad.23.1725280257577; Mon, 02 Sep 2024
 05:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728184551.42133-1-qyousef@layalina.io> <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com> <20240901175149.46yfk335niccmfq4@airbuntu>
In-Reply-To: <20240901175149.46yfk335niccmfq4@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 2 Sep 2024 14:30:46 +0200
Message-ID: <CAKfTPtBahrD5L8CbB4BijAvnwq=yG375TWDUuEvNipyTDYGQTA@mail.gmail.com>
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Hongyan Xia <hongyan.xia2@arm.com>, 
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 19:51, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 08/13/24 10:27, Vincent Guittot wrote:
> > On Tue, 13 Aug 2024 at 10:25, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
> > > > Hi Qais,
> > > > the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
> > > > freq updates still bothered me so let me share my thoughts even though
> > > > it might be niche enough for us not to care.
> > > >
> > > > 1. On fast_switch systems, assuming they are fine with handling the
> > > > actual updates, we have a bit more work on each context_switch() and
> > > > some synchronisation, too. That should be fine, if anything there's
> > > > some performance regression in a couple of niche cases.
> > > >
> > > > 2. On !fast_switch systems this gets more interesting IMO. So we have
> > > > a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
> > > > update request. This task will preempt whatever and currently will
> > > > pretty much always be running on the CPU it ran last on (so first CPU
> > > > of the PD).
> > >
> > > The !fast_switch is a bit of concern for me too but not for the same
> > > reason and maybe the opposite of yours IIUC your proposal below:
> > >
> > > With fast_switch we have the following sequence:
> > >
> > > sched_switch() to task A
> > > cpufreq_driver_fast_switch -> write new freq target
> > > run task A
> > >
> > > This is pretty straight forward but we have the following sequence
> > > with !fast_switch
> > >
> > > sched_switch() to task A
> > > queue_irq_work -> raise an IPI on local CPU
> > > Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
> > > with 1 CPU per PD)
> > > sched_switch() to sugov dl task
> > > __cpufreq_driver_target() which can possibly block on a lock
> > > sched_switch() to task A
> > > run task A
> > >
> >
> > sent a bit too early
> >
> > > We can possibly have 2 context switch and one IPi for each "normal"
> > > context switch which is not really optimal
> >
> > It would be good to find a way to skip the spurious back and forth
> > between the normal task and sugov
>
> Hmm I think we use affinity to keep the sugov running on policy->related_cpus.
> Relaxing this will make it less of a problem, but won't eliminate it.

yes, but it's not a problem of relaxing affinity here

The problem is that the 1st switch to task A will be preempted by
sugov so the 1st switch is useless. You should call cpufreq_update
before switching to A so that we skip the useless switch to task A and
directly switch to sugov 1st then task A

>
> I'll have a think about it, is this a blocker for now?
>
>

