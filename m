Return-Path: <linux-pm+bounces-945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FB980EB9F
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 13:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977041C20A5A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 12:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756E05E0D4;
	Tue, 12 Dec 2023 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="a+EPx4/8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA2483
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 04:23:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-33340c50af9so5627351f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 04:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702383822; x=1702988622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYhz0XOUOt14gyC7LrC7D+c8iRf0ZpwsoryRayowx4U=;
        b=a+EPx4/8v4diSab3QuQ7HeW6b/f8rr98gwP9e8dZqXZya5mR91zlQTCp0bLoksgi2j
         R8g7HAqfmkRhHzXAjvcjhPj0u89hAXdJJkzHtGWqwO0vAAH1oOTCySV/fkLa6Jm7ZAY/
         cw31TvheEDD6LUuDfWHspta3oLKifnEQKHZ/5FsfEP3HBf/QTW4Sp7StZBLck1fkvvqw
         Qc7Mhb0howN6vWOJ3XYepCG7VNxx1sIrJkE3RIr0lluygpLpXMkUG+jYlJmAevBrZ0PG
         7M8Bnwemn7WOlpskdY1dDPvdzwsNgoLmdArj/4/jIRHRHjuviv4VFDMU6Yt65EmQsSuF
         +EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702383822; x=1702988622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYhz0XOUOt14gyC7LrC7D+c8iRf0ZpwsoryRayowx4U=;
        b=Adnd2QIpPyfLTiQXSl+AmPpGLz/PEPWdPXNBC5GHPUQ5qUc5oBc9x9axRjhVi5K3BL
         pm1JHQ9FpaDj5Tb1WU4xaxkzprV7JHmNf8ZubqxSGJZ5qluPinf60uJacwA1xpzoGA2W
         dbL84uaT6jFJp7KU1E3EXl0Iz/QCQHaf2i8ND+HgDIym4YmFMLCjz63e/1xBwoO4vW7n
         14jNdnxq8XqcVkQXFkyo6YJV+AOvdZ5zN6qrC4vJ4mud3qeQjjmRFSWaANNO0Qxu8cKx
         EYf+3HQnMm4tsrH25k17UAJ0A/yktpUFmu8DF1u243Rjr+3m0o3zXLwrIgh+GxKqGN2q
         quqg==
X-Gm-Message-State: AOJu0YzvTiJkd50DJLbOj1XLWNjXiFnH0gIkYfJ3PvkYMhzmfvh+Ndia
	i5zbLZ2xGumHBYVLSaocWGz4Kw==
X-Google-Smtp-Source: AGHT+IEFxpriRDEi0v9aK9vmbk6+8njH5MaiygNoFKJAEbbjiErInjS6wX7ry9vE8PTEf4UTC3huIA==
X-Received: by 2002:adf:e2d1:0:b0:336:170f:9048 with SMTP id d17-20020adfe2d1000000b00336170f9048mr1565747wrj.16.1702383822412;
        Tue, 12 Dec 2023 04:23:42 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id m11-20020a056000008b00b0033332524235sm10672453wrx.82.2023.12.12.04.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:23:42 -0800 (PST)
Date: Tue, 12 Dec 2023 12:23:40 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 3/4] sched/schedutil: Ignore update requests for short
 running tasks
Message-ID: <20231212122340.sus7sbfqqkd4dxoh@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-4-qyousef@layalina.io>
 <f61a3329-4223-4995-8732-030430d19ea4@arm.com>
 <20231210222225.ukocvimws6ecgsmy@airbuntu>
 <a6c13b56-3ad9-419d-a22c-5a2e302200e0@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6c13b56-3ad9-419d-a22c-5a2e302200e0@arm.com>

On 12/11/23 11:15, Hongyan Xia wrote:
> > If the rq->util_avg is 1024, then for any task that is running, the requested
> > frequency should be max. If there's a task that is capped by uclamp_max, then
> > this task should not run at max.
> > 
> > So other tasks should have run at max; why you don't want them to run at max?
> 
> Because it saves power. If there's a 1024 task capped at 300 and a true 300
> task without uclamp on the same rq, there's no need to run the CPU at more
> than 600. Running it at 1024 ignores the uclamp_max and burns battery when
> it's not needed.

To fix this problem of tasks that are not 1024 but appearing 1024 the solution
doesn't lie on how the combined tasks perf hints are treated.

Note that tasks stuck on a CPU with small capacity (due to affinity or
extremely long balance_interval) can still appear as 1024 the same way
UCLAMP_MAX induces.

> > Is it only the documentation what triggered this concern about this corner
> > case? I'm curious what have you seen.
> 
> This is not a corner case. Having a uclamp_max task and a normal task on the
> same rq is fairly common. My concern isn't the 'frequency spike' problem
> from documentation. My concern comes from benchmarks, which is
> high-frequency square waves. An occasional spike isn't worrying, but the
> square waves are.

Fairly common in practice or you synthetic test setup to trigger it? We haven't
hit this problem in practice. Again, the solution is not related to how the
performance hints are applied.

Note if you have busy tasks running and sharing the CPU, the CPU should run at
max for non capped tasks. Please differentiate between the two problems.

> 
> > So worth a fix, not related to handling performance requests for multiple
> > tasks, and not urgently needed as nothing is falling apart because of it for
> > the time being at least.
> 
> Also, I think there's still an unanswered question. If there's a 1024 task

If there's a 1024 tasks on the rq then it'd run at max frequency and the system
will be overutilized and EAS disabled and work is spread according to load.

Cheers

--
Qais Yousef

> with a uclamp_min of 300 and a 300-util task with default uclamp on the same
> rq, which currently under max aggregation switches between highest and
> lowest OPP, should we filter out the high OPP or the low one? Neither is a
> short-running task. We could designate this as a corner case (though I don't
> think so), but wouldn't it be nice if we don't have any of these problems in
> the first place?
> 
> Hongyan

