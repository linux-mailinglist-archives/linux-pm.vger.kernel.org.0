Return-Path: <linux-pm+bounces-124-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9874F7F5FDD
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 14:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F804281CC4
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 13:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C7D24B20;
	Thu, 23 Nov 2023 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Lqi+60Kv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7608A1
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 05:15:06 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40b2c9ee8ecso5679915e9.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700745305; x=1701350105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jo0VusAlTEB88f2sT0ODs9DnrUfyK3YpWUuHjmpc9uU=;
        b=Lqi+60KvDiXwNLjA78wrxV55qinBfpY+X4OQ/G8GlS0RJt5pjv67fvFWWNXd+S48ml
         ss7fwMJF+3Ag9zOjWUTqVg9F/MxFa+hXKVq23IxJaMo2dMAdFcr6pV3ZdFSLmUOFkeQl
         fFIx8IytyGYdYbu25GNyeHHFp7lb5/dv0z3CE8+Upm3A+ChUFQ+austUv2grBnLmm8U2
         shOymWzYakbHQfCjx5P+2h8ks2qZ1Lynt0UdeLYoB9bzjs+6cqhjDmdWXVHENy0grLkC
         RBkuz+hBOaYVdCCeOUix3r7cRmRr8tWJciXRYCKgX1pErRvGZK3LRFxQRP2MZZXRwGHC
         lcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700745305; x=1701350105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jo0VusAlTEB88f2sT0ODs9DnrUfyK3YpWUuHjmpc9uU=;
        b=htuzYcpJmksuEsFvHYPg5NplWryX613d9IftZNpY2m2xTViFCswX7Jr+/W5USVBd6I
         e+0zUWA5CpLCONjHF1KavesmDMlKZoFAGcdPODWbtg+mGyrf3Pvgrv9ItRFpagxvDQIv
         QqQHnD75mU/tYQfExpNbgl6tyhVLJdcXZSIynCNiUvGQycSBLcvCLEZ1vxe1h2B8w5a6
         +A9mPzROCk+wLIDcpwh+cGocj0J3CfHPCYY5skXnm2ULiEiuNZpR35ZNmk+mxDC+2vdc
         ZGtIORw1TGdci9OGj2DhlP2z6VABlwAKp+HNvIbBYsM3+BQdig2qct4Cj7pUOa6i3FGj
         OIgw==
X-Gm-Message-State: AOJu0YweVZAcGAtRDgvV7SO4qoST1Wz2opZgOutncN1lCoNcS8PeAzm1
	uXGKzNYPVA7nTqJuub2iS/42SA==
X-Google-Smtp-Source: AGHT+IHFIPlBypH+y70zykSYD0JH2A79f5qgCQNwz67TkR62W5bTrpuIgu0rn8dZjMQZnDZ7iGdCLg==
X-Received: by 2002:a05:600c:1990:b0:401:b504:b6a0 with SMTP id t16-20020a05600c199000b00401b504b6a0mr4303066wmq.3.1700745305079;
        Thu, 23 Nov 2023 05:15:05 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id o36-20020a05600c512400b0040596352951sm2722938wms.5.2023.11.23.05.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:15:04 -0800 (PST)
Date: Tue, 21 Nov 2023 22:09:55 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Subject: Re: [PATCH v3 1/2] sched/schedutil: Rework performance estimation
Message-ID: <20231121220955.uxk2zanxfemwyfz6@airbuntu>
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
 <20231103131821.1176294-2-vincent.guittot@linaro.org>
 <20231114205422.k5m6y4m5vnw7dvzj@airbuntu>
 <CAKfTPtDMEes6V2xRHavAwWrVuiZBdFAsaaxv9=-psAZCTPQWKg@mail.gmail.com>
 <20231121211725.gaekv6svnqdiq5l4@airbuntu>
 <CAKfTPtDzAZMcuWOYYOOAjCyvrOQiqyHZJBFVbACAvTqo+pU1gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDzAZMcuWOYYOOAjCyvrOQiqyHZJBFVbACAvTqo+pU1gQ@mail.gmail.com>

On 11/23/23 08:47, Vincent Guittot wrote:

> > > > And is it right to mix irq and uclamp_min with bw_min which is for DL? We might
> > >
> > > cpu_bw_dl() is not the actual utilization by DL task but the computed
> > > bandwidth which can be seen as min performance level
> >
> > Yep. That's why I am not in favour of a dvfs headroom for DL.
> >
> > But what I meant here is that in effective_cpu_util(), where we populate min
> > and max we have
> >
> >         if (min) {
> >                 /*
> >                  * The minimum utilization returns the highest level between:
> >                  * - the computed DL bandwidth needed with the irq pressure which
> >                  *   steals time to the deadline task.
> >                  * - The minimum performance requirement for CFS and/or RT.
> >                  */
> >                 *min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
> >
> > So if there was an RT/CFS task requesting a UCLAMP_MIN of 1024 for example,
> > bw_min will end up being too high, no?
> 
> But at the end, we want at least uclamp_min for cfs or rt just like we
> want at least DL bandwidth for DL tasks

The issue I see is that we do

static void sugov_get_util()
{
..
	util = effective_cpu_util(.., &min, ..); // min = max(irq + cpu_bw_dl(), rq_uclamp_min)
	..
	sg_cpu->bw_min = min; // bw_min can pick the rq_uclamp_min. Shouldn't it be irq + cpu_bw_dl() only?
	..
}

If yes, why the comparison in ignore_dl_rate_limit() is still correct then?

	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)

And does cpufreq_driver_adjust_perf() still need the sg_cpu->bw_min arg
actually? sg_cpu->util already calculated based on sugov_effective_cpu_perf()
which takes all constraints (including bw_min) into account.


Thanks!

--
Qais Yousef

