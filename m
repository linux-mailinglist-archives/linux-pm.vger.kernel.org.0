Return-Path: <linux-pm+bounces-8831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF381901888
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 00:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FB8280F4A
	for <lists+linux-pm@lfdr.de>; Sun,  9 Jun 2024 22:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B7D1CF9B;
	Sun,  9 Jun 2024 22:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="rYrstpRz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977818EB0
	for <linux-pm@vger.kernel.org>; Sun,  9 Jun 2024 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717972431; cv=none; b=CK3Vc49XAE+Wy1iIdr1uGg1kOCQ/h8gOUSe5ftk1VlI+np1cl+k52mKbZipRId4uGi3Id6Ot25XPz9V/Y2UAx4+MWu6JQ4Cg3H/lNfaQTAAP2pZqNPt7rVsOFqR54o3SIe2ADePTgTKpBIpjgA8cMOAO3/d5D6WPegvWOpwQdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717972431; c=relaxed/simple;
	bh=8g3TSkHE1uXYn55WFoRu/IEFdwU9kbyHYT6DaHOmo3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fR1KT4+Zwu+zsqsF+MSQKOo1gqgPyyaMXKss2+UFibfi0aKCiyI5eP+gNKgxkfE77Kl6FydnqvJ7Q47HoV4/XNnS9sm7N7s9E3+8HuDOdPRUoh/7XfTgOIT4Ju/N+aXpCR5i/u0YTjNoUk8GQFxEaC5j2byRsrX7yjNgn4GY+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=rYrstpRz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso8350365e9.0
        for <linux-pm@vger.kernel.org>; Sun, 09 Jun 2024 15:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717972428; x=1718577228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkbZilJ766JsBJPln79PC2kt+4TOFMEz6FFO/bHlf/o=;
        b=rYrstpRzaKLkilMhT1fJVoBqygpb+xzfXnr8jficJKEDEBd89reSrwzRJrD8V2Ppk7
         NeSbSIzay7ZdJVsLH3lWyPCT8uZSg6nxO+BJq1FbxBduompcZN48aejQLQU59QFTNAkn
         XiG0YRIpm07PIV6TiXkeIcFDVVU9Hj1x51zS/SchhVqEZQb0qf88oiphVSVKplNjgHkG
         S3u1OUvHLffQLyk2Y3uBh+nuwkV2DK5m70KT4J0j9vhLYfdH8Rer0z6dktaJ9M7y+Gbg
         9fVuPqFX+OmQFHvpwyOJuqSUH4QzmeD/2oxYD4siguGuF1dz8naY/uKzs/Qzl0BIGabS
         G/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717972428; x=1718577228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkbZilJ766JsBJPln79PC2kt+4TOFMEz6FFO/bHlf/o=;
        b=OE6oTvLw5fjC9sTvO+8VHOUxy8s2CpqXHKrs8+K2W1rkt+oFxMAwIArmmfDu2w4YXx
         02QTzjs6uC41WNK2a04skB5xmB/Npbz89b4eA1WPcnDrLMKNzsZYHEHzbEOYrWhjNdbM
         PxYHaJay8pKqXu57Uci+XL/lVt6Wu66CnXWiNvqwh+cWuTkIrJnfieOHZtioVAm8X4Qx
         EPjTyHLwQ9Vh7fu/r0MboqOvFnZtTvOZcTz7WkprzCsO13f7D1BXm49ifeJETdel1x6l
         G3zWaUV/afglA/tV9gw4h62AYpobz3wzBFA7uzAMTwF6QFVIukBCu20z/witXx/p8AtA
         EBZg==
X-Forwarded-Encrypted: i=1; AJvYcCUVc1g83/3kFIRwRw5e921yumC5fWvTmQ8FFho0TgMl6s9w6UEmHRR/F8AsjAcn3Xs73rTqh9WUKVim1xyfBipOTb03dK1hWCE=
X-Gm-Message-State: AOJu0Yzzlyrir2OIkHaVrO0XDj163GBdyaMlEQN0KhxwDGZqInI3qKOI
	MTjwP0o6bty5kowpwPxKp+nSr9ZAcUQPGemumnk9tpt1HhlzUOxhBRgqZ71JgnE=
X-Google-Smtp-Source: AGHT+IFU4nKKmcH19ZhdblzBWvcEtv7VuGuyDDEZ+xh6GiEx1R+Sryr4La1jaasuiyCG5x/dj6GyCQ==
X-Received: by 2002:adf:ed52:0:b0:355:b9d2:4667 with SMTP id ffacd0b85a97d-35efea6fa89mr7128009f8f.29.1717972427659;
        Sun, 09 Jun 2024 15:33:47 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1ed08253sm2772387f8f.24.2024.06.09.15.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 15:33:47 -0700 (PDT)
Date: Sun, 9 Jun 2024 23:33:46 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] sched: Consolidate cpufreq updates
Message-ID: <20240609223346.4xlkcze3fg2bhhcn@airbuntu>
References: <20240530104653.1234004-1-qyousef@layalina.io>
 <1b44938c-9535-47e7-8cbc-2b844e5dfdff@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b44938c-9535-47e7-8cbc-2b844e5dfdff@arm.com>

On 06/05/24 13:24, Christian Loehle wrote:
> On 5/30/24 11:46, Qais Yousef wrote:
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
> > 2. task_tick_fair()
> > 3. update_blocked_averages()
> > 4. on syscall that changes policy or uclamp values
> > 
> > The update at context switch should help guarantee that DL and RT get
> > the right frequency straightaway when they're RUNNING. As mentioned
> > though the update will happen slightly after enqueue_task(); though in
> > an ideal world these tasks should be RUNNING ASAP and this additional
> > delay should be negligible.
> 
> Do we care at all about PREEMPT_NONE (and voluntary) here? I assume no.
> Anyway one scenario that should regress when we don't update at RT enqueue:
> (Essentially means that util of higher prio dominates over lower, if
> higher is enqueued first.)
> System:
> OPP 0, cap: 102, 100MHz; OPP 1, cap: 1024, 1000MHz
> RT task A prio=0 runtime@OPP1=1ms, uclamp_min=0; RT task B prio=1 runtime@OPP1=1ms, uclamp_min=1024
> rate_limit_us = freq transition delay = 1 (assume basically instant switch)
> Let's say CONFIG_HZ=100 for the tick to not get in the way, doesn't really matter.
> 
> Before:
> t+0:		Enqueue task A switch to OPP0
> Running A at OPP 0
> t+2us:		Enqueue task B switch to OPP1
> t+1000us:	Task A done, switch to task B.
> t+2000us:	Task B done
> 
> Now:
> t+0:		Enqueue task A switch to OPP0
> Running A at OPP 0
> t+2us:		Enqueue task B
> t+10000us:	Task A done, switch to task B and OPP1
> t+11000us:	Task B done
> 
> Or am I missing something?

I think this is the correct behavior where each task gets to run at the correct
frequency, no?

Generally if the system is overloaded with RT tasks with same priority are
likely to end up stuck on the same CPU for that long (ie no other CPU in the
system is able to pull one of the tasks), relying on frequency to save the day
is wrong IMO. Userspace must ensure not to starve such busy tasks with
0 uclamp_min if the system being overloaded is likely scenario. And they need
to manage priorities correctly to ensure these busy RT tasks are not a hogger
if something else finds this latency not acceptable.

Proper Hard RT systems disable DVFS generally as they introduce unacceptable
delays.

Note that with today's code Task B request is most likely dropped and both will
end up running at OPP0.


Cheers

--
Qais Yousef

