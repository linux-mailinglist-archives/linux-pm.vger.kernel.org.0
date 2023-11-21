Return-Path: <linux-pm+bounces-134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE47F611C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 15:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EE2281EF1
	for <lists+linux-pm@lfdr.de>; Thu, 23 Nov 2023 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E23A2FC3B;
	Thu, 23 Nov 2023 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="QaxrnGOP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA050B9
	for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 06:10:25 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c878e228b4so11550011fa.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Nov 2023 06:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700748624; x=1701353424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43S2JKE+XlknJ7InMXn72r82rK7OdZlK6EXXoJcK908=;
        b=QaxrnGOPE1u1Bcz5geVkJpyyAk9FFayQKerfYtl5JPw9v8EEvs+WeooNyX/oB5lsdZ
         AxnrFHYtmPZqktmY8HByDMDGdANuNNnp0Rpai0FXCv35o6eIE7vH91Os2KoWd3HODdTe
         M/67FEYXkV+DojfdGF4gLZgd03M1t917bKN3FLFm+FIIMyoi9eUjKwQ0B/Tq9zGq1OJE
         tzEkCDwZEU8ARGMzKCALqMu3s9oGlsHw5cBnidqtZkQnK/ZJEYP24TwDcdQjIBkGv5GL
         aF470SyaNBwhWibJVE6cjdjXyfX1hhk0oKYEmv1/+YRL2a1LWuSzaXGJpuem32xJ4QWq
         YHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700748624; x=1701353424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43S2JKE+XlknJ7InMXn72r82rK7OdZlK6EXXoJcK908=;
        b=dBJ2SMYjOneOSdM2U9Gipy9me4xtAKERMgeeqpdlO9xk+ygoP+znphAFDKRKWhs+jf
         mqktNKSGAkrvEvsc6z8Uy9kSFSPDa8ZqQsySWAqKu7CIONvizxUFpuh2Y3+dABTtKCvY
         FKuR8Cx7CqzN8lEJvuqzn46aJVjQaCoVgP++IllP8Nuo+oz4bkBrRsy4pHj6LBNF7lWF
         n6hR5YAsedFNF/k+4H0HflGqawWy/xEzFqFSoxyaZRKFhem1tDux4/gFPqp5gB5+5/oa
         y5576g0CqVXnXfGJcbFy07ynaqNCQoaoy31l3SpIiWOrltnH1DNrc2hMlqiH8vyACm6T
         0khw==
X-Gm-Message-State: AOJu0Yy7/zrAJKFUd7aZJJwNg62MxAKCvbT2sntO54/jtKZXLap7Tl4g
	K5vz4o12RWW7LcyIbDfxBYGq0Q==
X-Google-Smtp-Source: AGHT+IGR67MWtHuwOUSa+u9XjVDIwxf3b32UIItBRs2GxWoQZuo7TGo/Wf88EpY0wZmq4V317MYyOQ==
X-Received: by 2002:a2e:9842:0:b0:2c8:8025:1c8e with SMTP id e2-20020a2e9842000000b002c880251c8emr3716596ljj.17.1700748624167;
        Thu, 23 Nov 2023 06:10:24 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b0040b379e8526sm1386686wmo.25.2023.11.23.06.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:10:23 -0800 (PST)
Date: Tue, 21 Nov 2023 23:01:50 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	lukasz.luba@arm.com
Subject: Re: [PATCH] sched/pelt: avoid underestimate of task utilization
Message-ID: <20231121230150.eq2kc72bvyn6ltur@airbuntu>
References: <20231122140119.472110-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122140119.472110-1-vincent.guittot@linaro.org>

On 11/22/23 15:01, Vincent Guittot wrote:
> It has been reported that thread's util_est can significantly decrease as
> a result of sharing the CPU with other threads. The use case can be easily
> reproduced with a periodic task TA that runs 1ms and sleeps 100us.
> When the task is alone on the CPU, its max utilization and its util_est is
> around 888. If another similar task starts to run on the same CPU, TA will
> have to share the CPU runtime and its maximum utilization will decrease
> around half the CPU capacity (512) then TA's util_est will follow this new
> maximum trend which is only the result of sharing the CPU with others
> tasks. Such situation can be detected with runnable_avg wich is close or
> equal to util_avg when TA is alone but increases above util_avg when TA
> shares the CPU with other threads and wait on the runqueue.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

So effectively if have two always running tasks on the same CPU their util_est
will converge to 1024 instead of 512 now, right?

I guess this is more accurate, yes. And I think this will hit the same
limitation we can hit with uclamp_max. If for example there are two tasks that
are 650 if they run alone, they would appear as 1024 now (instead of 512) if
they share the CPU because combined running there will be no idle time on the
CPU and appear like always running tasks, I think.

If I got it right, I think this should not be a problem in practice because the
only reason these two tasks will be stuck on the same CPU is because the load
balancer can't do anything about it to spread them; which indicates the system
must be busy anyway. Once there's more idle time elsewhere, they should be
spread and converge to 650 again.

Not my forte, but LGTM anyway.


Cheers

--
Qais Yousef

