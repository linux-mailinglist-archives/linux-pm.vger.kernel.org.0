Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B57C799F74
	for <lists+linux-pm@lfdr.de>; Sun, 10 Sep 2023 21:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjIJTXd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 Sep 2023 15:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjIJTXd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 Sep 2023 15:23:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255E3184
        for <linux-pm@vger.kernel.org>; Sun, 10 Sep 2023 12:23:29 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so40166385e9.1
        for <linux-pm@vger.kernel.org>; Sun, 10 Sep 2023 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694373807; x=1694978607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xs8+9Z7+vXYDwM9oV3pdNRuvHzqaXIvBuS/TB/Fstm4=;
        b=F9x6SemRqPH0i9MpCj8Y3lV+Zjr5d7ULHg2+vjJlXU743c6d0SJ7MWsx2VsJj4Vfpm
         QCdURlQoQ/CMJuG7o/WKX53TUQIkfWagtpbcA9Sn34cMUO7EpVuxYrj0LaeTFWxIzLUL
         qfSxDdsOGhEBq8p0JieLMME0xUrVnHi8l/CheHDtRiS31LY8GR/cAY+nG1xv4hHKbP9c
         hrFOHOhTEPfyH1wQZjva78ZjyvC1AMJt6P2W2q2xdrG2rL0ETERg1T3sJTcrl/6rKyzX
         Fx2EiPTZoVFppJygbOXAUXXsnV/Oak+HxrfzVVTZTGD64MaAmXo9fEo2Rt5ovlah6zfT
         czFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694373807; x=1694978607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs8+9Z7+vXYDwM9oV3pdNRuvHzqaXIvBuS/TB/Fstm4=;
        b=cRBXRbXuD4nkFhSPwzc5I/NwiYl0nXoe8N2mw7wsw+5i+Tqq/lj8oCgHrT3wAQk+Pb
         oC10fvMCAxvKif+MdBn2xG0KkT/cwgxn0BZUKdTSQtn7tETpCdaNpX8C68toY6DPtxas
         nfxCAYB9NjAgOHYDBA268KZg51BD98cyQRPLFQjuUgtqbIxRr05D2lUNTInwEwaeb2Fs
         Cu6+Fi5XHt2K2/5DTmMCjM3qFflMTxZU7Nuns3aKOaCSPslmJPLnSWM8/8FBKr9YqVMH
         7mHZDY+Wf9bFdeo2QP1RDcN5Oxt4Mr71YxJeECB/Tdbu27Lz6yiYknp+SKYLAhXif4mW
         58eg==
X-Gm-Message-State: AOJu0YwtscWJlVXker+6V+r4dXvd2LSwDovQF3BgexNTJ/1WZpgo/Rnh
        +8GC/2kaPZIeYt7xo3eULfWaOQ==
X-Google-Smtp-Source: AGHT+IEHelYfu9bcUTGRxD685izlDteKDMgQbnUOrBXHIRc7SLjPJ6fed8B2Z5CwVp/S4mmrFp7Esg==
X-Received: by 2002:a05:600c:215:b0:401:b53e:6c56 with SMTP id 21-20020a05600c021500b00401b53e6c56mr6502360wmi.3.1694373807602;
        Sun, 10 Sep 2023 12:23:27 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c260d00b003fef19bb55csm7942635wma.34.2023.09.10.12.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 12:23:27 -0700 (PDT)
Date:   Sun, 10 Sep 2023 20:23:26 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 4/7] sched: cpufreq: Remove magic 1.25 headroom from
 apply_dvfs_headroom()
Message-ID: <20230910192326.3k7eefyu4stvmkwy@airbuntu>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-5-qyousef@layalina.io>
 <20230907113453.GB10955@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907113453.GB10955@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/07/23 13:34, Peter Zijlstra wrote:
> On Mon, Aug 28, 2023 at 12:32:00AM +0100, Qais Yousef wrote:
> > Instead of the magical 1.25 headroom, use the new approximate_util_avg()
> > to provide headroom based on the dvfs_update_delay; which is the period
> > at which the cpufreq governor will send DVFS updates to the hardware.
> > 
> > Add a new percpu dvfs_update_delay that can be cheaply accessed whenever
> > apply_dvfs_headroom() is called. We expect cpufreq governors that rely
> > on util to drive its DVFS logic/algorithm to populate these percpu
> > variables. schedutil is the only such governor at the moment.
> > 
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >  kernel/sched/core.c              |  3 ++-
> >  kernel/sched/cpufreq_schedutil.c | 10 +++++++++-
> >  kernel/sched/sched.h             | 25 ++++++++++++++-----------
> >  3 files changed, 25 insertions(+), 13 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 602e369753a3..f56eb44745a8 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -116,6 +116,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
> >  
> >  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> > +DEFINE_PER_CPU_SHARED_ALIGNED(u64, dvfs_update_delay);
> 
> This makes no sense, why are you using SHARED_ALIGNED and thus wasting
> an entire cacheline for the one variable?

Err, brain fart. Sorry.


Thanks

--
Qais Yousef
