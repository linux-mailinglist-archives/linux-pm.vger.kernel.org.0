Return-Path: <linux-pm+bounces-146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4FE7F6457
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 17:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7692D2818DA
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 16:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1603833088;
	Thu, 23 Nov 2023 16:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="pMsF96QQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7344010CF
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:46:01 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c871890c12so13583331fa.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700757959; x=1701362759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RYB3GDMpceXiTyLpxLaXoAVNVwI/N+VrNQUanssDFeg=;
        b=pMsF96QQ5IfSK4VvocIHqrfMQDMeFGinK6GH9Kxbgzh5ATEjFIt4Sa/MvYd3P9ocBS
         qc5RdOnoTfU2rqxVGpH9FwuVnLY/mToGrtPVoSKFt1rVFlHbuQS6Cj94P5kBm88toqZH
         0R4PVQQq4M4ymxd9eJfGMbfR0DfG3bFCJgkYe+TOQt2BvAtB8Y2xCFyh4mDgf1JNp3q0
         SD8VmzMrlGpAOdqeYzIgq4NfgAvzDRmyFTonIWQQfea8C1apFqlmsX56ouDRTp9bo+QY
         uLaMU5g8B2NSKGqGPSPs/NsCMf1mPIk9SCNc6s3UVnwph+2qKpRk3E7XaCTQ4ZD3wS82
         swew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757959; x=1701362759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYB3GDMpceXiTyLpxLaXoAVNVwI/N+VrNQUanssDFeg=;
        b=eudqeOZpTSlIxVLaKDkj6tnoXF1BpHWM9/1454w2ETJGt8eQNm/8BG+Su9UXwaXkfJ
         JlSdIw5ywRAZtXhGcmhG8TES4Y4Jflf2IhFXnfZBtfLpqWrehl99RytthMd8ed7uwEhn
         whhObwzml20SVZvWhHkA5Al6h2F29XVdcmRo37BpE9krbEHqEMXGjjNwQjfzo8FSlb34
         XL/qTajJ+pOTSjYZO63WhTA9C0EMPHVgQR7igFtvZh9vHQro9lQnJ8UcEeNyUVdCdKRX
         /olWHtgBUOxXlFNV9Y36FASHoyV6PtP2r5h6X7uNXP4uXQnkhg8xrjBhBtWV4lu8VAsZ
         tUGw==
X-Gm-Message-State: AOJu0YxWyuQXLo2I7u01g91f1O3VZlCFbO1GkIF0UsFbJrIpXjxDgbec
	5ySacnl4iRSvYn7geQ22rW/D9g==
X-Google-Smtp-Source: AGHT+IEnHI7QldwExJlJ4+fTCy4SAqth2gBb/QXFSAm8J4Dgon16wn2ChwK/DULzZcczh+4yvktrTw==
X-Received: by 2002:a2e:ab1a:0:b0:2c5:1d95:f7a1 with SMTP id ce26-20020a2eab1a000000b002c51d95f7a1mr4510389ljb.27.1700757959417;
        Thu, 23 Nov 2023 08:45:59 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id p34-20020a05600c1da200b00406408dc788sm3167145wms.44.2023.11.23.08.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:45:58 -0800 (PST)
Date: Thu, 23 Nov 2023 16:45:57 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: mingo@redhat.com, peterz@infradead.org,
	Vincent Guittot <vincent.guittot@linaro.org>, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched/pelt: avoid underestimate of task utilization
Message-ID: <20231123164557.ls7znaeb73w56tvy@airbuntu>
References: <20231122140119.472110-1-vincent.guittot@linaro.org>
 <20231121230150.eq2kc72bvyn6ltur@airbuntu>
 <77ec94ee-798d-4c5e-a673-616d25acca4a@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77ec94ee-798d-4c5e-a673-616d25acca4a@arm.com>

On 11/23/23 14:27, Lukasz Luba wrote:
> 
> 
> On 11/21/23 23:01, Qais Yousef wrote:
> > On 11/22/23 15:01, Vincent Guittot wrote:
> > > It has been reported that thread's util_est can significantly decrease as
> > > a result of sharing the CPU with other threads. The use case can be easily
> > > reproduced with a periodic task TA that runs 1ms and sleeps 100us.
> > > When the task is alone on the CPU, its max utilization and its util_est is
> > > around 888. If another similar task starts to run on the same CPU, TA will
> > > have to share the CPU runtime and its maximum utilization will decrease
> > > around half the CPU capacity (512) then TA's util_est will follow this new
> > > maximum trend which is only the result of sharing the CPU with others
> > > tasks. Such situation can be detected with runnable_avg wich is close or
> > > equal to util_avg when TA is alone but increases above util_avg when TA
> > > shares the CPU with other threads and wait on the runqueue.
> > > 
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > 
> > So effectively if have two always running tasks on the same CPU their util_est
> > will converge to 1024 instead of 512 now, right?
> > 
> > I guess this is more accurate, yes. And I think this will hit the same
> > limitation we can hit with uclamp_max. If for example there are two tasks that
> > are 650 if they run alone, they would appear as 1024 now (instead of 512) if
> > they share the CPU because combined running there will be no idle time on the
> > CPU and appear like always running tasks, I think.
> 
> Well they might not converge to 1024. It will just prevent them to not
> drop the highest seen util_est on them before this contention happen.

Right, we just ignore the decay and hold on to the last seen value.

> 
> > 
> > If I got it right, I think this should not be a problem in practice because the
> > only reason these two tasks will be stuck on the same CPU is because the load
> > balancer can't do anything about it to spread them; which indicates the system
> > must be busy anyway. Once there's more idle time elsewhere, they should be
> > spread and converge to 650 again.
> 
> It can be applicable for the real app. That chrome thread that I
> reported (which is ~950 util) drops it's util and util_est in some
> scenarios when there are some other tasks in the runqueue, because
> of some short sleeps. Than this situation attracts other tasks to
> migrate but next time when the big thread wakes-up it has to share
> the CPU and looses it's util_est (which was the last information
> that there was such big util on it).
> 
> Those update moments when we go via util_est_update() code path
> are quite often in short time and don't fit into the PELT world,
> IMO. It's like asynchronous force-update to the util_est signal,
> not the same way wrt how slowly util is built. I think Peter
> had something like this impression, when he asked me of often
> and fast this update could be triggered that we loose the value...
> 
> I would even dare to call this patch a fix and a candidate to
> stable-tree.

It seems a genuine fix yes. I am generally worried of the power impact of
util_est. But I tend to agree this is something worth considering for
a backport.


Cheers

--
Qais Yousef

