Return-Path: <linux-pm+bounces-4130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B30885BDF5
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 14:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7BFE28ADC9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5887B6A8A7;
	Tue, 20 Feb 2024 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="YD0GOg8o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD2B6A32C
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708437513; cv=none; b=We/z+M5qM6pQjbVp5T2eFnGcqabAc1eF56xi7+6ANZUZ9yrBXG8P9Q8eyYMggn+Y8PHFJ8vau3YlvCKBzMWYDa9rgDkJBwz4Il7How4fUiMPs8JSoVfRe4CAKN69KeXFe2UlN88NVfkTzqxiZX4lfHlC/yeTRJi51G4jzVAwYzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708437513; c=relaxed/simple;
	bh=BoxnzxQC/c4gl7Bj8WGMe/ITa9TT35V3+eTrZOEVWfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MltTRBJK0s+rHFcYWkIha+4oSJLL/VQNuKDKOrL2ns4Tk+96yUzjIv4ASxifuNPgtA9w0zHHm3D2mp7T9mq3TXRfJGasJ3CMy4+P+ZkvY7nn/1kwazdgAWRdXLNGCCMMOlmYS9HvuzeBVhW34iaAijPIwZFNcaURozpFbsiy518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=YD0GOg8o; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412698ac6f9so9901245e9.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 05:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708437510; x=1709042310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QRfMYkyP1Z8eQDMkqJr/zSgdS64E6BSeGEZqSZMFz+o=;
        b=YD0GOg8omvZH0YAFiB0lZoS5Pk/WphVe3goM9ertu+ISo3zjnENaG1oezF661Xg1Ae
         kAz3ygg+FNF775NS3mRzuENGMg0GCIqQtNTB3JBO+G0QQY1ZPWPZ57MDJxRWhJFIpL4X
         r1WGOR6/zeu8mRSSmmEWWL+LSXB4m2HcI4eyDb+6fCCN0PX5e1Stuj4qeas0xvKfGNSO
         an7s55X1PxuXL3z4IdFdaUZKazSX1o8BG+hfcNg5R6Jqjk4u7wT+BZXC9bJ2Euf4kjQd
         7768UVc8dW45Js6yRtFD+FuFFkHZBvDcgyQY1yJut7pPVS1V1cHiBOpYeq2qtjPhxWZH
         5l3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708437510; x=1709042310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRfMYkyP1Z8eQDMkqJr/zSgdS64E6BSeGEZqSZMFz+o=;
        b=iaw7FplEvyQJ0s/TuUAK7WWSMPIQNhyo5OkcpBN8CwYjxmYKoeIthUGZipFdQqiCcC
         4bbricpKWEGBO65u/kP4vFrYJxsGRmkLCRIQYQK4Y8zObJQMDc1zlf+XQLZy9HKwjut3
         SK5eEsFzYr+H59QvvRbxbXs0JJ1uxcYFJQCOylaqD5SX2rmJQxG0NJjWEm3W/tMtuU9I
         f29jLT6csgBvqc6E97hTMOV3rmEErt2jpxKk71Dp31xKY6TE/NihO2AiQzSaepkpCwYT
         LqboWWBa6dFAOmztFBmtQdmL429wHSMpFql6lqRXDzaAEU4yQyLcY0TsciJeRWFJnke2
         fT7A==
X-Forwarded-Encrypted: i=1; AJvYcCVKkMxj/RneR+C9yw2jPsxbt7ewwHgqKgD6opQbVV83J270IuHT1hoGF7qOM1tpWwxY3hYqKgBDpFHIxIK9oF2CLnrRRYQZCJc=
X-Gm-Message-State: AOJu0Yz7WA2ia8P+K12eHbs8vczpGFxs+xmF4Kxno3w0hYLir79qmgdK
	L/JiDkozLHyCcMWJaBMTYnTb53pZtwREtKg0QBcqw/pTc0qkfMlsMHMrhtUDRg8=
X-Google-Smtp-Source: AGHT+IH6ma22oVCmGr3xQps11+oZUP5InQd+J+z6fviZUJ0QQXUGMMdCcf/RyGerWxqnEX1lzMyVXQ==
X-Received: by 2002:a05:600c:35d3:b0:412:6c39:1ddc with SMTP id r19-20020a05600c35d300b004126c391ddcmr2880917wmq.17.1708437509860;
        Tue, 20 Feb 2024 05:58:29 -0800 (PST)
Received: from airbuntu ([87.127.96.170])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d444b000000b0033b7ce8b496sm13678266wrr.108.2024.02.20.05.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 05:58:29 -0800 (PST)
Date: Tue, 20 Feb 2024 13:58:28 +0000
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] sched: cpufreq: Rename map_util_perf to
 apply_dvfs_headroom
Message-ID: <20240220135828.t4dhy5tmfrsrzn6y@airbuntu>
References: <20240205022006.2229877-1-qyousef@layalina.io>
 <CAJZ5v0g68atmQAbKFdm1bhp_Uvw6+C9SnJp9jZK0vEHA4mX7bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g68atmQAbKFdm1bhp_Uvw6+C9SnJp9jZK0vEHA4mX7bw@mail.gmail.com>

On 02/12/24 16:54, Rafael J. Wysocki wrote:
> On Mon, Feb 5, 2024 at 3:20 AM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > We are providing headroom for the utilization to grow until the next
> > decision point to pick the next frequency. Give the function a better
> > name and give it some documentation. It is not really mapping anything.
> >
> > Also move it to sched.h. This function relies on updating util signal
> > appropriately to give a headroom to grow. This is more of a scheduler
> > functionality than cpufreq. Move it to sched.h where all the other util
> > handling code belongs.
> >
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> >  include/linux/sched/cpufreq.h    |  5 -----
> >  kernel/sched/cpufreq_schedutil.c |  2 +-
> >  kernel/sched/sched.h             | 17 +++++++++++++++++
> >  3 files changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> > index bdd31ab93bc5..d01755d3142f 100644
> > --- a/include/linux/sched/cpufreq.h
> > +++ b/include/linux/sched/cpufreq.h
> > @@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
> >  {
> >         return freq * util / cap;
> >  }
> > -
> > -static inline unsigned long map_util_perf(unsigned long util)
> > -{
> > -       return util + (util >> 2);
> > -}
> >  #endif /* CONFIG_CPU_FREQ */
> >
> >  #endif /* _LINUX_SCHED_CPUFREQ_H */
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 95c3c097083e..abbd1ddb0359 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -179,7 +179,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> >                                  unsigned long max)
> >  {
> >         /* Add dvfs headroom to actual utilization */
> > -       actual = map_util_perf(actual);
> > +       actual = apply_dvfs_headroom(actual);
> >         /* Actually we don't need to target the max performance */
> >         if (actual < max)
> >                 max = actual;
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index e58a54bda77d..0da3425200b1 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -3002,6 +3002,23 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> >                                  unsigned long min,
> >                                  unsigned long max);
> >
> > +/*
> > + * DVFS decision are made at discrete points. If CPU stays busy, the util will
> > + * continue to grow, which means it could need to run at a higher frequency
> > + * before the next decision point was reached. IOW, we can't follow the util as
> > + * it grows immediately, but there's a delay before we issue a request to go to
> > + * higher frequency. The headroom caters for this delay so the system continues
> > + * to run at adequate performance point.
> > + *
> > + * This function provides enough headroom to provide adequate performance
> > + * assuming the CPU continues to be busy.
> > + *
> > + * At the moment it is a constant multiplication with 1.25.
> > + */
> > +static inline unsigned long apply_dvfs_headroom(unsigned long util)
> > +{
> > +       return util + (util >> 2);
> > +}
> >
> >  /*
> >   * Verify the fitness of task @p to run on @cpu taking into account the
> > --
> 
> This touches sched.h, so I'd prefer it to go in via tip and
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Thanks

