Return-Path: <linux-pm+bounces-128-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525007F6056
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 14:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAFA281D83
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F69724B5C;
	Thu, 23 Nov 2023 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuNSM3c+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D5D43
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 05:33:04 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b2018a11efso904108b3a.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 05:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700746384; x=1701351184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yvVEsznFGOEcHL++JvtqHDNKFWEmCpdzy05jYiWZejk=;
        b=TuNSM3c+IKndbuqfknq5r3rhJZwn758kINi3ElXTqbNwseMoxPuVALWc+a7p85knKL
         Q1ZUNWD9wo/39D6ATE2bXlgRP6vatdYD6vopADg0Uy56abCeWtYMflg3i+yCXsyR3qRU
         tqY9Z+223WCJAY0DEYPUwvfrRokgqTZjyWOIPQDnElZ3A6YeC2l22Wx1BbkhTJO/Cy++
         oewVm+bvqByQIcn7LGFyLLIvXK1bIjYCq0rdUbHa3q34+jqddTCvWBdzquiGTAW7BWGR
         2FzwusRw86Ra/5vQf6BOOa9EEqE+z7vfGfZBUmkx04UyyM1zion94Cx0Co+1F2jPGXgW
         A0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746384; x=1701351184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvVEsznFGOEcHL++JvtqHDNKFWEmCpdzy05jYiWZejk=;
        b=NNtq5N6fZ+avizobDVotQf4/ahPT8xnTMt1VasvVi7Z5GgFY2g/AKdEePwpBPclvCv
         QT/nAYtZNa0AML8xVlDs4wuArVaIPU07fCuQfuohd2jDEfEwpHJXyrxzvP/x27nN1OUJ
         QO6dRwApICFVR9nOGo9GDwQOIbDmpld9igFkxJp78N22mSHbuNvvTaUJo30jgPqjrEbM
         ZnmQZTKbsa02BVf0CpQ2SvYw5wCjr8nHMqwJOPWRIyVSVIxy6EsA/uERmjmtalAvH75Q
         elDkJhB8cYCEFOXBd7Q2PiD5HyZvquaWlneAMEUnykGk++TF2YgEpOjy+kURC8eDkma2
         gjtA==
X-Gm-Message-State: AOJu0Yz4LFKM4ZLWDhR+DMGHDjtpmi/7xVa+P1Uc3H5skVlL3HXzMxDE
	C9QdInASQSizpWlJXHE9rLSka/dnzfN4k2JZ6J3i+g==
X-Google-Smtp-Source: AGHT+IGeJ8HWTjPQII5hKN4+VrgDmeYXnjKUIUFadHHOWbUsRdPsUh0SMrOCZbLFTxSuF/OxQ+sqNEP5Tm3v5rMIUPY=
X-Received: by 2002:a05:6a20:7d90:b0:14c:a2e1:65ec with SMTP id
 v16-20020a056a207d9000b0014ca2e165ecmr6520553pzj.38.1700746384045; Thu, 23
 Nov 2023 05:33:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
 <20231103131821.1176294-2-vincent.guittot@linaro.org> <20231114205422.k5m6y4m5vnw7dvzj@airbuntu>
 <CAKfTPtDMEes6V2xRHavAwWrVuiZBdFAsaaxv9=-psAZCTPQWKg@mail.gmail.com>
 <20231121211725.gaekv6svnqdiq5l4@airbuntu> <CAKfTPtDzAZMcuWOYYOOAjCyvrOQiqyHZJBFVbACAvTqo+pU1gQ@mail.gmail.com>
 <20231121220955.uxk2zanxfemwyfz6@airbuntu>
In-Reply-To: <20231121220955.uxk2zanxfemwyfz6@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 23 Nov 2023 14:32:52 +0100
Message-ID: <CAKfTPtAHbYCyqA6jLqkoWgQ2X625tann8Mpy0QttgQo5OPvS9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sched/schedutil: Rework performance estimation
To: Qais Yousef <qyousef@layalina.io>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, rafael@kernel.org, 
	viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, wyes.karny@amd.com, 
	beata.michalska@arm.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Nov 2023 at 14:15, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 11/23/23 08:47, Vincent Guittot wrote:
>
> > > > > And is it right to mix irq and uclamp_min with bw_min which is for DL? We might
> > > >
> > > > cpu_bw_dl() is not the actual utilization by DL task but the computed
> > > > bandwidth which can be seen as min performance level
> > >
> > > Yep. That's why I am not in favour of a dvfs headroom for DL.
> > >
> > > But what I meant here is that in effective_cpu_util(), where we populate min
> > > and max we have
> > >
> > >         if (min) {
> > >                 /*
> > >                  * The minimum utilization returns the highest level between:
> > >                  * - the computed DL bandwidth needed with the irq pressure which
> > >                  *   steals time to the deadline task.
> > >                  * - The minimum performance requirement for CFS and/or RT.
> > >                  */
> > >                 *min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
> > >
> > > So if there was an RT/CFS task requesting a UCLAMP_MIN of 1024 for example,
> > > bw_min will end up being too high, no?
> >
> > But at the end, we want at least uclamp_min for cfs or rt just like we
> > want at least DL bandwidth for DL tasks
>
> The issue I see is that we do
>
> static void sugov_get_util()
> {
> ..
>         util = effective_cpu_util(.., &min, ..); // min = max(irq + cpu_bw_dl(), rq_uclamp_min)
>         ..
>         sg_cpu->bw_min = min; // bw_min can pick the rq_uclamp_min. Shouldn't it be irq + cpu_bw_dl() only?
>         ..
> }
>
> If yes, why the comparison in ignore_dl_rate_limit() is still correct then?
>
>         if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)

yes, this is to ensure enough performance for the deadline task when
the dl bandwidth increases without waiting the rate limit period which
would prevent the system from providing enough bandwidth to the
deadline scheduler. This remains true because it's still at least
above cpu_bw_dl()

>
> And does cpufreq_driver_adjust_perf() still need the sg_cpu->bw_min arg
> actually? sg_cpu->util already calculated based on sugov_effective_cpu_perf()
> which takes all constraints (including bw_min) into account.

cpufreq_driver_adjust_perf() is used for systems on which you can't
actually set an operating frequency but only a min and a desired
performance level and let the hw move freely in this range.

>
>
> Thanks!
>
> --
> Qais Yousef

