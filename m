Return-Path: <linux-pm+bounces-1868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8421C82492E
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 20:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9F91F24F03
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 19:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F802C681;
	Thu,  4 Jan 2024 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="tGBIwFg6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BF32C1A8
	for <linux-pm@vger.kernel.org>; Thu,  4 Jan 2024 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a28ee72913aso119489566b.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Jan 2024 11:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1704397223; x=1705002023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fTZHAYU4/5zK1CnYbSxkoDODTsetzakdQ8YutPSLziM=;
        b=tGBIwFg6hLsHjVi8DTl9WCjle6LH4p55BK3N/rrX3LLVQjYteKoS2Q0p/ykCX+Ku4I
         57EsvhOLwBsLBtrcklMfAPjic6U73h1plmALOKdmGyXmFxinZub4TFUUsZ9g6rjHo8MK
         28c2bNw2Xf9QFxCuVj8d5VBqm4Xw3H6YVfPe1qGhE+wuCtYFmFEO7YaZ4wmCy3sUSixh
         YgFP+fTIHyUBe0MUWWn0SfM9TXa+imcWxYYdODx4sQBj7VTypRHl3mi2nLHRFbDz/BVN
         O0RDYtL2eos54L4WZQm+b9w5edoDl5y/5aXhYwWJ0anWSjsURa7UzEF1j+A7PO9qXQFD
         VfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704397223; x=1705002023;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTZHAYU4/5zK1CnYbSxkoDODTsetzakdQ8YutPSLziM=;
        b=bb8w7Mpo4mtCJfIZDeTkJ8cIQLQeIAPFODGOQmWG6Bjms+Y7MjVaq7/cFLMWjPvko6
         2U18PfTnFtydJ2lnKHar5pqj7TbCxpNp3IbT37gAJyMBMGV5z15roMnIe2rqedCE/TpF
         qQtEwlNGQRtFkVdrA1vxqBVodVIr6pFuLiv++7AiBqibVSluQhYtB2DMyQ7kSUfDD/QD
         qmwRZ7kuH/SO+eORniCXwCga420Bt4WXnEj9Oj93y3yIxNd78HZJ6hfNwT1L55S9zsZx
         tvpfzjFPrzDtIzUyhFyjdGtQG7uvC+bJFO89L8OxiPvGkFWroPFU2ZO4ZQfNX180+/nB
         hYGA==
X-Gm-Message-State: AOJu0YwTSL/TvtqCXphgzgV1iiF5nyfqvMwZDLpl0hWFrc8ElAjpZS7z
	qEVJHEFKFP3lYQjsyScmJk9KY0QWcjh2Fw==
X-Google-Smtp-Source: AGHT+IHbrSZnDnUiv27Jyg9q5lq/BxQsEUGuuC63pb63tW15zYmY1XX5A33pAcPPfXWjmggFPk6U7g==
X-Received: by 2002:a17:906:1d9:b0:a28:b7c1:7210 with SMTP id 25-20020a17090601d900b00a28b7c17210mr961863ejj.7.1704397223238;
        Thu, 04 Jan 2024 11:40:23 -0800 (PST)
Received: from airbuntu (92.40.216.191.threembb.co.uk. [92.40.216.191])
        by smtp.gmail.com with ESMTPSA id k16-20020a170906681000b00a230f3799a4sm614ejr.225.2024.01.04.11.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:40:22 -0800 (PST)
Date: Thu, 4 Jan 2024 19:40:19 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
	Hongyan Xia <hongyan.xia2@arm.com>
Subject: Re: [PATCH 1/4] sched/fair: Be less aggressive in calling
 cpufreq_update_util()
Message-ID: <20240104194019.kgwpp5sipiudxfma@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-2-qyousef@layalina.io>
 <CAKfTPtAKainBfpPOKTJ21zQmmYw7O0Z0v8utfg=QTBtE1L5O_w@mail.gmail.com>
 <20231212124037.at47izy5xp6lsxh2@airbuntu>
 <20231229002529.sidy6wxmclhzlzib@airbuntu>
 <CAKfTPtCu7_Z8RCMeSJGzyu79Af-gypyqLyyWQkuZsMHgnf3CzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCu7_Z8RCMeSJGzyu79Af-gypyqLyyWQkuZsMHgnf3CzQ@mail.gmail.com>

On 01/03/24 14:41, Vincent Guittot wrote:
> On Fri, 29 Dec 2023 at 01:25, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 12/12/23 12:40, Qais Yousef wrote:
> > > On 12/12/23 12:06, Vincent Guittot wrote:
> > >
> > > > > @@ -6772,6 +6737,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > > > >  enqueue_throttle:
> > > > >         assert_list_leaf_cfs_rq(rq);
> > > > >
> > > >
> > > > Here and in the other places below,  you lose :
> > > >
> > > >  -       } else if (decayed) {
> > > >
> > > > The decayed condition ensures a rate limit (~1ms) in the number of
> > > > calls to cpufreq_update_util.
> > > >
> > > > enqueue/dequeue/tick don't create any sudden change in the PELT
> > > > signals that would require to update cpufreq of the change unlike
> > > > attach/detach
> > >
> > > Okay, thanks for the clue. Let me rethink this again.
> >
> > Thinking more about this. Do we really need to send freq updates at
> > enqueue/attach etc?
> 
> Yes, attach and detach are the 2 events which can make abrupt and
> significant changes in the utilization of the CPU.
> 
> >
> > I did an experiment to remove all the updates except in three places:
> >
> > 1. Context switch (done unconditionally)
> > 2. Tick
> > 2. update_blocked_averages()
> 
> From the PoV of util_avg, attach, detach, tick and
> update_blocked_averages are mandatory events to report to cpufreq to
> correctly follow utilization.

Okay, I'll re-instate the attach/detach updates.

Worth noting that unconditional calling is not a good idea after all. So I'll
make sure that context switch updates are protected with static key for
governors that don't register a hook, and that it is only called when we think
it's necessary. I did notice some overhead after all against reverse-misfit
patches.


Thanks!

--
Qais Yousef

