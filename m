Return-Path: <linux-pm+bounces-7583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6396F8BE294
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 14:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D781C21F78
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2024 12:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D7915B155;
	Tue,  7 May 2024 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1fyWSmI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5F853E18
	for <linux-pm@vger.kernel.org>; Tue,  7 May 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086441; cv=none; b=VTQ5/XSdNqtTgOudUWY7L22qUtBFHtC9ZD8ROQLEW3nmzu9f13bLgnCFMVmThfYUm+M5TIBmMRW911IYUt8ZeyOe+UPjFcf9iql0DN2wC0dIfCSBIjcYgJo1428JvOEsrjC7sggAXp3uhZkIVNq+GS5UrIoraatqd51r/s6joNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086441; c=relaxed/simple;
	bh=qXGfUlEuyq9acMc9wdmCRc4sbAYNXOqxy6N3x85FJp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRGS/8PwPaDH2XU22FJHh8RokCNQwrsDGTAbxfL870Dg6RHdRDIqhMst3vDGD2za/a5C1gxrlt6QxH5Bn0m12BBZIccFXDVKcUYIP2AKlzpAdtA5hdKZlDYhXUnlmWAKW6qdXYMhuwuzM3kPi7eGGomowrML8pTfYTirFf3rCLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p1fyWSmI; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so1721903a12.1
        for <linux-pm@vger.kernel.org>; Tue, 07 May 2024 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715086439; x=1715691239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qXGfUlEuyq9acMc9wdmCRc4sbAYNXOqxy6N3x85FJp4=;
        b=p1fyWSmIMV6WffZikb6G1wqkSZMCY7myfNh1fNyjCbb9jzDJcHPZLgOm+wQOJbbR7a
         4CLeJE1ySGhOQ9yCDPeOySnYKqTOZKsYOibVbag0uPl4NSQ91RtGaYYQ3U+TFZJ5OOcI
         +tRhWWIHLVfIjP35MU/Y6vSA1McsViuuTDlfpklgYOUubH0nIlMs9dLZerjYYEaLUks4
         E1Teej5kd4vMc/ki4ZwX1ERPzpjV8TIb1iKhp1H3BzTPG9XfKtjj4viXBcNws9mVzk3D
         vM3v4Mg0Av7LnvKJWx5NC4bsb+QUWKb0xGtcgnE9mMZ4Gvrbqi9sn76EM1ZD/igZEomW
         T8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715086439; x=1715691239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXGfUlEuyq9acMc9wdmCRc4sbAYNXOqxy6N3x85FJp4=;
        b=iy+592rftIdfM6Bx8LgTDtA+J4RKEvktg7bM8g8j1qhwlztY2MzUPOuq97y8e5Sy++
         EYfPqtSSwKcjDnuptrnIR37/ip4eFoiOnTJfKeOdzLtP9qODpUFyPudMU6bvh6ewvPAq
         xBptUVSDiW/TqqEKzUWU9aS6vhROZCP2zzx0hqSvmR0B3loJeCs6RtXK9OTNgYCfi88z
         CA6Tncxl9pfTW+niHWWHkw9GoTM05DjOtI5hlsOXNHn8/93adtdvVumrV0QEWmxP0oma
         BlRlUgqiBpImSN9YGzHqTacZAPxtk3Bo1N3L8McxBkcUCnjQchtft7kEqjmcQpAO5aUe
         jQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqDpUV17XgA7Y+12inR+vyMtIbCj/QywbQ50aGzzi10ovPpVtXOIV6MNWvJ7BZZdadp7uEeFkKyeCvJmGbAWwsZ/1x5jM+A8A=
X-Gm-Message-State: AOJu0YyvyNNjbiRf0VZH2TK/V47I9rtnwXPz0UaxTozVMJqv5nFzrAq/
	VSXVIGs1eusmi3YN5kQoj1Oc5WxTpUyWoJlWVPPngwzwhKBVxLWfVcxhZZZUY34XyyIu+J6GYhA
	rKkIqR94A5Sr8SfslX84g7SGeWv02OaclMa9Ezw==
X-Google-Smtp-Source: AGHT+IF3096jy/BSNmowrhBG7/4P6Cfwvb5f60E87UNKn0QswOMKfkSoKQ0PEOrgiFEyqfvYve9FVZFHeqzt4AK+nAo=
X-Received: by 2002:a17:90a:930c:b0:2a1:f586:d203 with SMTP id
 p12-20020a17090a930c00b002a1f586d203mr10241315pjo.41.1715086438068; Tue, 07
 May 2024 05:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505233103.168766-1-qyousef@layalina.io> <CAKfTPtDvBAFauUfyWZhYRUz6f42iMAJcwcdDDQh+V8+QfDwc2Q@mail.gmail.com>
 <20240507110809.a45amdmhy5vr5cuw@airbuntu>
In-Reply-To: <20240507110809.a45amdmhy5vr5cuw@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 7 May 2024 14:53:46 +0200
Message-ID: <CAKfTPtDHWBKfksW4jQJ3KZVb7_GDXLZB1F7auYVZE1ddyDpgYQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Consolidate cpufreq updates
To: Qais Yousef <qyousef@layalina.io>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Valentin Schneider <vschneid@redhat.com>, Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 May 2024 at 13:08, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 05/07/24 10:58, Vincent Guittot wrote:
> > On Mon, 6 May 2024 at 01:31, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > Improve the interaction with cpufreq governors by making the
> > > cpufreq_update_util() calls more intentional.
> > >
> > > At the moment we send them when load is updated for CFS, bandwidth for
> > > DL and at enqueue/dequeue for RT. But this can lead to too many updates
> > > sent in a short period of time and potentially be ignored at a critical
> > > moment due to the rate_limit_us in schedutil.
> > >
> > > For example, simultaneous task enqueue on the CPU where 2nd task is
> > > bigger and requires higher freq. The trigger to cpufreq_update_util() by
> > > the first task will lead to dropping the 2nd request until tick. Or
> > > another CPU in the same policy triggers a freq update shortly after.
> > >
> > > Updates at enqueue for RT are not strictly required. Though they do help
> > > to reduce the delay for switching the frequency and the potential
> > > observation of lower frequency during this delay. But current logic
> > > doesn't intentionally (at least to my understanding) try to speed up the
> > > request.
> > >
> > > To help reduce the amount of cpufreq updates and make them more
> > > purposeful, consolidate them into these locations:
> > >
> > > 1. context_switch()
> >
> > I don't see any cpufreq update when switching from idle to CFS. We
>
> You mean SCHED_IDLE to SCHED_NORMAL, right? Yes, if we switch policies even
> from fair to RT an update could be missed.

No I mean going out of idle. On an idle cpu, nothing happens at CFS
task wakeup and we have to wait for the next tick to apply the new
freq. This happens for both short task with uclamp min or long
running/sleeping task (i.e. with high util_est)

>
> I'll need to think more about it, but I think adding an update when we switch
> policies in the syscall looks sufficient to me, if the task is on rq already.
> Agreed?
>
> > have to wait for the next tick to get a freq update whatever the value
> > of util_est and uclamp
> >
> > > 2. task_tick_fair()
> >
> > Updating only during tick is ok with a tick at 1000hz/1000us when we
> > compare it with the1048us slice of pelt but what about 4ms or even
> > 10ms tick ? we can have an increase of almost 200 in 10ms
>
> IMHO the current code can still fail with these setups to update frequencies in
> time. If there's a single task on the rq, then the only freq update will happen
> at tick. So this is an existing problem.

But any newly enqueued task can trigger a freq update without waiting
1/4/10ms whereas we need to wait for next tick with this patch

>
> The way I see it is that setting such high TICK values implies low
> responsiveness by definition. So the person who selects this setup needs to
> cater that their worst case scenario is that and be happy with it. And this
> worst case scenario does not change.
>
> That said, the right way to cater for this is via my other series to remove the
> magic margins. DVFS headroom should rely on TICK value to ensure we run at
> adequate frequency until the next worst case scenario update, which relies on
> TICK. Which is sufficient to handle util_est changes. See below for uclamp.
>
> Wake up preemption should cause context switches to happen sooner than a tick
> too as we add more tasks on the rq. So I think the worst case scenario is not
> really changing that much. In my view, it's better to be consistent about the
> behavior.
>
> >
> > > 3. {attach, detach}_entity_load_avg()
> >
> > At enqueue/dequeue, the util_est will be updated and can make cpu
> > utilization quite different especially with long sleeping tasks. The
> > same applies for uclamp_min/max hints of a newly enqueued task. We
> > might end up waiting 4/10ms depending of the tick period.
>
> uclamp_min is a property of the task. And waiting for the task that needs the
> boost to run is fine IMHO. And I am actually hoping to remove uclamp max()

But you will delay all CPU work and the running time fo the task

And what about util_est ?

> aggregation in favour of applying boosts/caps when tasks are RUNNING. But more
> things need to be improved first.
>
> We are missing a freq update when uclamp values change by the way. This is
> a known bug and I keep forgetting to post a patch to fix it. Let me do this
> along update freq when policy changes.
>
> Thanks!

