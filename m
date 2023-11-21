Return-Path: <linux-pm+bounces-129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABE17F6082
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 14:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE443B215C8
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6A924B5C;
	Thu, 23 Nov 2023 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="t7YTy+tv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEC91B6
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 05:40:09 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4083f613275so5970395e9.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 05:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700746808; x=1701351608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eVDsDxYliWC5xW8ZDSuWoJIog0SBBE+nKOkI20zAozo=;
        b=t7YTy+tvGV9s/CeFP0DyVTNRRMQFjk6NpifKhiavcJ4m2A7tV+raYH4TpyCrCYR1IG
         nfh8UQxbQr4axmAdHl4m1D8Y57vnbPLlPje2ffpJJcNxkax3LOAKPuWnGIlCb6ZpEaD0
         2H2/wKotaTuu2hjMWs9vq+hsL1Yq/9q7UImwJ5QGihxdUwWstkLEpZ/ASDa7o2wiIeqX
         wMh52fsfTC+utyaUI+81OsNbnq1Cj0/Q2dUQ/F/1ky72A76kS7amxKpUHXY9IXYmc7nz
         jbB8w2ARlbX1Fpcd+IRmr6vVZaRkQZjDdiqrP7CjK0dan94xxWIBSXtG4o6nQzI0rWgS
         w/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746808; x=1701351608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVDsDxYliWC5xW8ZDSuWoJIog0SBBE+nKOkI20zAozo=;
        b=d4DHphJznhwrbsCbuh3nFfIZPbFMsEv9Nn/LykHGjt73Fi3OYCFLd9vc1e+mkKJUS1
         afj+WRPspQMkHeMQNJ4xr8MjDrODc3tj1deMenPe+g8JKUhF7ZPfv5dcxFZba8cBXMuk
         GybyoR6njsZBvCl1Wlkz0NKCzczxxqU4vPv54pcqHcKxTlTen82Ke42jHGsQtsR/AZbs
         sBYuWcOSxj6ftHSTok8aGVBHiunoVF7TMqbOXh6p0hyCFHHwncCn3vgagMLPlsycuYNA
         2AxrOp3wUGW5d0E9VFlg08Vh6OFpOQJemED4m0OtByxxiIDcV/s+4xUQfrraI1Rlvk0Y
         vfwA==
X-Gm-Message-State: AOJu0Yw9oinFP8IvBUw03yCEHmlxMw+SbyCpKVY6jnE3hF7bqIurqTjw
	9x/N2WaonAWuTI1b3NroLU1knQ==
X-Google-Smtp-Source: AGHT+IEPVFwZh3UkjWjulXsoLjw+PU6cdUqbZg/3GBbWo2gxUgSRxk8s7yyP+GiRcEQX+WQY0Ymehw==
X-Received: by 2002:a05:600c:5490:b0:408:3f61:cb4f with SMTP id iv16-20020a05600c549000b004083f61cb4fmr3646255wmb.23.1700746807827;
        Thu, 23 Nov 2023 05:40:07 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id m6-20020a056000180600b00332e73f8231sm25946wrh.39.2023.11.23.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:40:07 -0800 (PST)
Date: Tue, 21 Nov 2023 22:31:34 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Subject: Re: [PATCH v3 1/2] sched/schedutil: Rework performance estimation
Message-ID: <20231121223134.iewtzozmz6bz5jr5@airbuntu>
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
 <20231103131821.1176294-2-vincent.guittot@linaro.org>
 <20231114205422.k5m6y4m5vnw7dvzj@airbuntu>
 <CAKfTPtDMEes6V2xRHavAwWrVuiZBdFAsaaxv9=-psAZCTPQWKg@mail.gmail.com>
 <20231121211725.gaekv6svnqdiq5l4@airbuntu>
 <CAKfTPtDzAZMcuWOYYOOAjCyvrOQiqyHZJBFVbACAvTqo+pU1gQ@mail.gmail.com>
 <20231121220955.uxk2zanxfemwyfz6@airbuntu>
 <CAKfTPtAHbYCyqA6jLqkoWgQ2X625tann8Mpy0QttgQo5OPvS9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAHbYCyqA6jLqkoWgQ2X625tann8Mpy0QttgQo5OPvS9w@mail.gmail.com>

On 11/23/23 14:32, Vincent Guittot wrote:
> On Thu, 23 Nov 2023 at 14:15, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 11/23/23 08:47, Vincent Guittot wrote:
> >
> > > > > > And is it right to mix irq and uclamp_min with bw_min which is for DL? We might
> > > > >
> > > > > cpu_bw_dl() is not the actual utilization by DL task but the computed
> > > > > bandwidth which can be seen as min performance level
> > > >
> > > > Yep. That's why I am not in favour of a dvfs headroom for DL.
> > > >
> > > > But what I meant here is that in effective_cpu_util(), where we populate min
> > > > and max we have
> > > >
> > > >         if (min) {
> > > >                 /*
> > > >                  * The minimum utilization returns the highest level between:
> > > >                  * - the computed DL bandwidth needed with the irq pressure which
> > > >                  *   steals time to the deadline task.
> > > >                  * - The minimum performance requirement for CFS and/or RT.
> > > >                  */
> > > >                 *min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
> > > >
> > > > So if there was an RT/CFS task requesting a UCLAMP_MIN of 1024 for example,
> > > > bw_min will end up being too high, no?
> > >
> > > But at the end, we want at least uclamp_min for cfs or rt just like we
> > > want at least DL bandwidth for DL tasks
> >
> > The issue I see is that we do
> >
> > static void sugov_get_util()
> > {
> > ..
> >         util = effective_cpu_util(.., &min, ..); // min = max(irq + cpu_bw_dl(), rq_uclamp_min)
> >         ..
> >         sg_cpu->bw_min = min; // bw_min can pick the rq_uclamp_min. Shouldn't it be irq + cpu_bw_dl() only?
> >         ..
> > }
> >
> > If yes, why the comparison in ignore_dl_rate_limit() is still correct then?
> >
> >         if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)
> 
> yes, this is to ensure enough performance for the deadline task when
> the dl bandwidth increases without waiting the rate limit period which
> would prevent the system from providing enough bandwidth to the
> deadline scheduler. This remains true because it's still at least
> above cpu_bw_dl()

Okay I think I get it now. I think renaming bw_min to perf_min or something
along those lines in the next opportunity would be a good thing.

> 
> >
> > And does cpufreq_driver_adjust_perf() still need the sg_cpu->bw_min arg
> > actually? sg_cpu->util already calculated based on sugov_effective_cpu_perf()
> > which takes all constraints (including bw_min) into account.
> 
> cpufreq_driver_adjust_perf() is used for systems on which you can't
> actually set an operating frequency but only a min and a desired
> performance level and let the hw move freely in this range.

I see. Thanks for the explanation.


Cheers

--
Qais Yousef

