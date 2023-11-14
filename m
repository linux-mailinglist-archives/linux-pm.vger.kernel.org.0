Return-Path: <linux-pm+bounces-49-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BD97F346D
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 18:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB18282793
	for <lists+linux-pm@lfdr.de>; Tue, 21 Nov 2023 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261512563;
	Tue, 21 Nov 2023 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="vBFX28TR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90EB113
	for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 09:02:43 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso8438548e87.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Nov 2023 09:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700586162; x=1701190962; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RY5bcl1x0MOfQG1a+xI6jyP9NlPUMrTJp9SfZPaMtRU=;
        b=vBFX28TR2bJC6tSdQXVe3UL/sE/o35fhE/8cq3/EVycTKBMmR2yN+slXCatW8C3WEJ
         FFNGr7fiV+y5eKVUOcP2HDENJyjQ2H5eFIi4zM8IQ9J0RIZ+4zrE4MO+r9Rtj23JEKT/
         K2QoTG7rOmrmKD+Q1he8kgRjZmPzMPjbPZSrPz/q2mwYJrQ+csUvOxLt47gFZVfXs1Lc
         dvKiOniDnHy1CfPiLs4YEO1zYuCm95sxXzXFnesAsD/4BkAEfQt2JHNSGCJmT+p+PEOZ
         /L5UQH9XOP1WWK22R4jWkZiausMJwcBT232LEwG6hSH4AjEmdN96qUtLrxH07wruebnQ
         VSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586162; x=1701190962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RY5bcl1x0MOfQG1a+xI6jyP9NlPUMrTJp9SfZPaMtRU=;
        b=Cq/EC1zq83umkaze5rvINxyQCeZYjKQ6NOJUPvxBt/OLMaRuKpNB5S9esCgRhkaSfx
         u3J+1Be2kLGd6XyHKo/nRuFKW9F2wcEb/oIsAcQKGCtOA06MbJpgh041yZwVvv+DU8ux
         MyVg6Xdx6uA879M3f6FhWXPV5BRLUmlN3TJuMUcuM26RJk9HnjY65j/DGBjfPmgE1+MK
         lmrIL9yK6GuAy6SbRhB0KmkiNMoUxAqdFvbrvJzoE3d+MnDheIqJOM/bOchXKsPxXhGO
         V4DrneOMr68T26CzVi28+vUiMmJnAbH9pRxU/HHxQBtfIowsz88mdWqk6lNSgrk0bTBK
         Upvw==
X-Gm-Message-State: AOJu0Yx2WIg07TB0FR3Qy8QOfi5P4Fv0tvMdh5hYOf+nwg8HMKZgWqGg
	yO3DiWnMKMToDWg/9/TJeB5eIg==
X-Google-Smtp-Source: AGHT+IHWCWoNHIImsBka/l40pqodUCB/BIiBTxP670O+sPPNIcGbx21bgGmTyfJmWQu0QXTVfIcyFg==
X-Received: by 2002:a2e:878d:0:b0:2c5:4a0:f3cb with SMTP id n13-20020a2e878d000000b002c504a0f3cbmr7237202lji.11.1700586158495;
        Tue, 21 Nov 2023 09:02:38 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b003fd2d3462fcsm703126wmi.1.2023.11.21.09.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:02:38 -0800 (PST)
Date: Tue, 14 Nov 2023 21:13:32 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Subject: Re: [PATCH v3 0/2] Rework interface between scheduler and schedutil
 governor
Message-ID: <20231114211332.c3yhmfm7vxgysi72@airbuntu>
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
 <CAJZ5v0g4N2UojiQqJn7fxWj2=h=6sgFfGEqEVx1wuh2VdvaH6Q@mail.gmail.com>
 <20231116143450.GF8262@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231116143450.GF8262@noisy.programming.kicks-ass.net>
X-Spam-Level: *

On 11/16/23 15:34, Peter Zijlstra wrote:
> On Mon, Nov 06, 2023 at 04:05:40PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Nov 3, 2023 at 2:18 PM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > Following the discussion with Qais [1] about how to handle uclamp
> > > requirements and after syncing with him, we agreed that I should move
> > > forward on the patchset to rework the interface between scheduler and
> > > schedutil governor to provide more information to the latter. Scheduler
> > > (and EAS in particular) doesn't need anymore to guess estimate which
> > > headroom the governor wants to apply and will directly ask for the target
> > > freq. Then the governor directly gets the actual utilization and new
> > > minimum and maximum boundaries to select this target frequency and
> > > doesn't have to deal anymore with scheduler internals like uclamp when
> > > including iowait boost.

Thanks a lot for taking over Vincent and helping with this! And sorry for
delayed review, was out travelling between holiday and LPC so haven't caught up
with the list properly yet..

Beside the comments on patch 1, it looks good to me. Do we want to generalize
the way the interface is called though so that scheduler is not tightly coupled
to schedutil? Speaking with Intel folks in LPC, it seemed they rely on firmware
to make a lot of decision and if we further generalize how the interface is
called (I think we need a new cpufreq wrapper akin to cpufreq_update_util()) to
allow governors to hook into it and do their own thing. This could allow them
to use uclamp and these min/max perf hints.

But I haven't thought this fully through. So something to consider separately
anyway to not hold this up unnecessarily. Maybe we do want to keep schedutil
tightly integrated and get people to switch to schedutil instead..

> > >
> > > [1] https://lore.kernel.org/lkml/CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com/
> > >
> > > Changes since v2:
> > > - remove useless target variable
> > >
> > > Changes since v1:
> > > - fix a bug (always set max even when returning early)
> > > - fix typos
> > >
> > > Vincent Guittot (2):
> > >   sched/schedutil: Rework performance estimation
> > >   sched/schedutil: Rework iowait boost
> > >
> > >  include/linux/energy_model.h     |  1 -
> > >  kernel/sched/core.c              | 82 ++++++++++++-------------------
> > >  kernel/sched/cpufreq_schedutil.c | 69 ++++++++++++++++----------
> > >  kernel/sched/fair.c              | 22 +++++++--
> > >  kernel/sched/sched.h             | 84 +++-----------------------------
> > >  5 files changed, 100 insertions(+), 158 deletions(-)
> > >
> > > --
> > 
> > For the schedutil changes in the series:
> > 
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > 
> > and I'm assuming this series to be targeted at sched.
> 
> Sure, I'll go queue it. Thanks!

Sorry for being late. If this wasn't queued already I think worth waiting to
iron out some comments on patch 1 first.


Thanks!

--
Qais Yousef

