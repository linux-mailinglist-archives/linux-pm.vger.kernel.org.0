Return-Path: <linux-pm+bounces-7577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BFD8BE0AC
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 13:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20ACE28784E
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 11:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34FF1509A5;
	Tue,  7 May 2024 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="qJE9aFs8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF981514C9
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080094; cv=none; b=f7BonGMCoaLjUlny/7IVTnsDxsY8zo4LS8m19mYJWzduzQPavpaTGRpV/AmAOx2qctcR+OD7YPPQ8C7MNy3HMBQEmI6DYSPT/4GVTBL3KdBpT93j2KMFnDcJjAWMxElfsP4M38amkLGb6YjlC2avp7U8lJhLsM1Ee5UEjaTuuck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080094; c=relaxed/simple;
	bh=wgwN7Ttr0fa3OT9yy31fE52kq4GfZtJlD1jQlZ43+Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3Gl2Ukdin+TDO46s/vvYAnNXVzsh2mp+feal5lL0XQA6Bgn42P8Y9RaJXmR6qekUeDBZjgmdvi9AjeH0lyhPLeRfdtLfhM4sSS/+F8F03CdGmMIOLOqpfSKdb40ig20gGt96lWyV2TbsBZ97fqVkXgW6DmVvWNXTBIqKwYExuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=qJE9aFs8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41b782405bbso20876835e9.1
        for <linux-pm@vger.kernel.org>; Tue, 07 May 2024 04:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1715080091; x=1715684891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k8mqDNEITnsn9Q4RGgt2BjeW3oNLVA+O9O0NFCLad1A=;
        b=qJE9aFs8K2NNjMqGK4fHxJfz3pByqki+4Qr0H+LIG7BcQ/FYvZxqC6ffGNH5Py8a2W
         efFZoU/JzHbNk+TkxmmROoxxGB+6n/2o6frEecZonP1EiB3Z8RFilfLPBIEmSTKrJwgV
         /UnnC6jThDiQgDXGlHR7R5LOapP1qCc4G2XNWhThscCUwXuvc0+TODfESEuLqanlf1p9
         pgolInQ3yt0FCGXsj9A1BjTtthlxsuO6ZkjU06ARTDVeSUOEfewi62IbIZWp2N/9xYHR
         KHzoeioYDzVTGhQIgomBlOG10yEPc5fdlj3TEY9xhVwkRzO6C3VROgPdS/PbgMeoAFa9
         uWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715080091; x=1715684891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8mqDNEITnsn9Q4RGgt2BjeW3oNLVA+O9O0NFCLad1A=;
        b=fKcb8uAr1DTd8/mPYwqPo1FhsXyGB9GnWwuOwS73AUAX/2ukKFbos8mOs5U/NbNqLV
         0Kd/FrNNLZIUGNfl8VaC79IU2XBLYqeSoVmlsbq+hlbzyTgRHOMNPUTNs6Te4nOY2rH4
         zJPAwbTmVWLnT0JRxq69e6Tk7N5ia53af5vzcimsafqS4Kq6wV7Sp3m955Lc/wepmkk5
         wx/Vfcqg6Lv+Y6H2lgHlArXqsSeIAq3/OUSWFJN0AUooyRNaDtL4cYb83mcrig+XT1a+
         Ng5tC44B41gfjb6cib9Fn72v2OYiG0Uuox7aJFR4wPbQ5z1D2Wfrx6vI3+0Cx0XHDILI
         RGTg==
X-Forwarded-Encrypted: i=1; AJvYcCUW7DKmyRQVpaZ4as5rK8TpWgYcOs2GMtv4Eagit7i4xLOLl/Dww6BdjoIfAhNVTQq2O444TmWymEVP7Lb5vLd2lacmSNprxA4=
X-Gm-Message-State: AOJu0Ywbmui671tRQI3TZ6GwBt2JDTCr+Awc1ndNt8r0Ce5GrcjT9pGX
	Yb+gTNpiFzg2whQIz9MJV+0vwhfrIulZ3nzZ0jfmIyqK8cx/SbkZcWr8zxyVnUc=
X-Google-Smtp-Source: AGHT+IG7+BYmlx1YUSi8ZBop6jJNkdCxnKaUX8ds6YSdzUJw1Gi4NivrZ5UnIb3tDmcWBQpVWCdc8A==
X-Received: by 2002:a05:600c:35c5:b0:41b:da5b:a60d with SMTP id r5-20020a05600c35c500b0041bda5ba60dmr9537683wmq.6.1715080091343;
        Tue, 07 May 2024 04:08:11 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id l30-20020a05600c1d1e00b0041b086d664fsm19322046wms.6.2024.05.07.04.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 04:08:10 -0700 (PDT)
Date: Tue, 7 May 2024 12:08:09 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Consolidate cpufreq updates
Message-ID: <20240507110809.a45amdmhy5vr5cuw@airbuntu>
References: <20240505233103.168766-1-qyousef@layalina.io>
 <CAKfTPtDvBAFauUfyWZhYRUz6f42iMAJcwcdDDQh+V8+QfDwc2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDvBAFauUfyWZhYRUz6f42iMAJcwcdDDQh+V8+QfDwc2Q@mail.gmail.com>

On 05/07/24 10:58, Vincent Guittot wrote:
> On Mon, 6 May 2024 at 01:31, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > Improve the interaction with cpufreq governors by making the
> > cpufreq_update_util() calls more intentional.
> >
> > At the moment we send them when load is updated for CFS, bandwidth for
> > DL and at enqueue/dequeue for RT. But this can lead to too many updates
> > sent in a short period of time and potentially be ignored at a critical
> > moment due to the rate_limit_us in schedutil.
> >
> > For example, simultaneous task enqueue on the CPU where 2nd task is
> > bigger and requires higher freq. The trigger to cpufreq_update_util() by
> > the first task will lead to dropping the 2nd request until tick. Or
> > another CPU in the same policy triggers a freq update shortly after.
> >
> > Updates at enqueue for RT are not strictly required. Though they do help
> > to reduce the delay for switching the frequency and the potential
> > observation of lower frequency during this delay. But current logic
> > doesn't intentionally (at least to my understanding) try to speed up the
> > request.
> >
> > To help reduce the amount of cpufreq updates and make them more
> > purposeful, consolidate them into these locations:
> >
> > 1. context_switch()
> 
> I don't see any cpufreq update when switching from idle to CFS. We

You mean SCHED_IDLE to SCHED_NORMAL, right? Yes, if we switch policies even
from fair to RT an update could be missed.

I'll need to think more about it, but I think adding an update when we switch
policies in the syscall looks sufficient to me, if the task is on rq already.
Agreed?

> have to wait for the next tick to get a freq update whatever the value
> of util_est and uclamp
> 
> > 2. task_tick_fair()
> 
> Updating only during tick is ok with a tick at 1000hz/1000us when we
> compare it with the1048us slice of pelt but what about 4ms or even
> 10ms tick ? we can have an increase of almost 200 in 10ms

IMHO the current code can still fail with these setups to update frequencies in
time. If there's a single task on the rq, then the only freq update will happen
at tick. So this is an existing problem.

The way I see it is that setting such high TICK values implies low
responsiveness by definition. So the person who selects this setup needs to
cater that their worst case scenario is that and be happy with it. And this
worst case scenario does not change.

That said, the right way to cater for this is via my other series to remove the
magic margins. DVFS headroom should rely on TICK value to ensure we run at
adequate frequency until the next worst case scenario update, which relies on
TICK. Which is sufficient to handle util_est changes. See below for uclamp.

Wake up preemption should cause context switches to happen sooner than a tick
too as we add more tasks on the rq. So I think the worst case scenario is not
really changing that much. In my view, it's better to be consistent about the
behavior.

> 
> > 3. {attach, detach}_entity_load_avg()
> 
> At enqueue/dequeue, the util_est will be updated and can make cpu
> utilization quite different especially with long sleeping tasks. The
> same applies for uclamp_min/max hints of a newly enqueued task. We
> might end up waiting 4/10ms depending of the tick period.

uclamp_min is a property of the task. And waiting for the task that needs the
boost to run is fine IMHO. And I am actually hoping to remove uclamp max()
aggregation in favour of applying boosts/caps when tasks are RUNNING. But more
things need to be improved first.

We are missing a freq update when uclamp values change by the way. This is
a known bug and I keep forgetting to post a patch to fix it. Let me do this
along update freq when policy changes.

Thanks!

