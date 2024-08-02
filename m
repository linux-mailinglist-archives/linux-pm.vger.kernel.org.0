Return-Path: <linux-pm+bounces-11868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF2946648
	for <lists+linux-pm@lfdr.de>; Sat,  3 Aug 2024 01:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B48D282FED
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2024 23:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2116513B5B6;
	Fri,  2 Aug 2024 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="xhRgsLPu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C513A86A
	for <linux-pm@vger.kernel.org>; Fri,  2 Aug 2024 23:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722642901; cv=none; b=rtCDIknXVkU9NtWuWcvrzWIm1XN7zooE/CvZ4wHHXBXSP83awrOY58Xxip3DvWhJ6FZi9fhFeH1adNMmoxrA+g0OrvInNZ8EvlWNUAwN9bpn6hbJjGcfWcOJcx9+hFsiR12+3oW82rjEBK2H4JjxM5tCMeRBG4wbOaroxbNNtJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722642901; c=relaxed/simple;
	bh=A41wVtIXbGmKDgOKV5AUZW5JAkXvvwvQOFRAux9CEfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUjinCDWPwT0n4Wai1I1O1uLSDeUbfWQfMSlp4xoAUkTrYmqCkBB62XWXCS/6O71xN98mtR/PFroqFO+1JqMsD9fhhfFnh9WItioHVM2Bc4/FYgiD+xT6AVJyVl1Mene+Xyn9cF1LbPQv12PaTHSBipB9ZDyQLmJ74cl677KMww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=xhRgsLPu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3685b3dbcdcso4895635f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 02 Aug 2024 16:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722642896; x=1723247696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z89m9s96xTmBFnADBfEQnkgnX8RRHf9qk8tx0RP5GZ8=;
        b=xhRgsLPu7hcXsuTLzN2LIgae7fCLNTYGt++0vfndnE56gvSeuh5DXOHbv8y+THiEI/
         t7FIZ9NC6pjig4MW9QvhJcsPKHcMzUpXGO4uqRaFW59XI/Lb1Cvj/kHqujUHbXMjojyG
         K7YEmJxsZt3SL1NnfMW0VmL3UKugGJdXpkNCJKrwDS3lclbDr5wTusVCfr0E7bIcyF2A
         iv5mSfsVrTg1shW0U6l+NQ/xd173Ur+ot7E8K8tT686pZyMcWbSCdD+8saLOVntlJj5K
         If/zxoo7aa4kCIYmBhDqzuB2qOROMqaB7GJvx7ukJrw/B4p9sG33LsRsvLULRMbq+2D/
         Tk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722642896; x=1723247696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z89m9s96xTmBFnADBfEQnkgnX8RRHf9qk8tx0RP5GZ8=;
        b=Z9/hyRd+jhEQSB7EzlrR4QXtH71XuTHI+/qolD+wUNFdNih73bxaOcGXkU96DEXt8G
         8HeFpg7M5wUdOULTD4zzsil9o7a7R3d9NGjQifCyTYj5GV4GwLSXBJJ2JNtu41jc/ifD
         R1rAy+jOFq4q56JZps19NEOoTzEZkOwix3Be5tw/9BThvggppc70oPTjxCVo+tIIVnf5
         3a+t3G13yHHken/2Rn6YLf1BtBKGP9iQQYpCdBS/TMWNoo15EjVKJlN7yZlF8nVvuwhf
         REkjLnq59YY5gKJC7XpLgXWr7QENRdjfm+v6vqZdJVzWyZ2Nn9XWUoUF/ASB+rPdiswk
         uhcg==
X-Forwarded-Encrypted: i=1; AJvYcCXIy5D1/+A7AJ8c2/gdg2zLiFrnjXJ0lzf3bdd5BJaYio9kriohAJp2sMZTSVfH8mMwpxyTv8NqxwQSoj4XN6GfTSgozbd0+Zk=
X-Gm-Message-State: AOJu0YyYggHsXT0s2G3JZMyOvB4c9yqEl4Oezu22iRk5/2vzZvoV3eyZ
	arQSv59xPLp4STMlNf+9sUR38BZxV3wRdpq6ssAF1BJfXu55VQQda13JTbOBEXU=
X-Google-Smtp-Source: AGHT+IHpjsXdz9ar/ETJ5hdLOzW3O/nwByoJ7Vpv1etaCxLzgd12Z7Xbawfe7yv+hVobYD1K7iggtQ==
X-Received: by 2002:adf:e644:0:b0:367:8f29:f7b6 with SMTP id ffacd0b85a97d-36bbc1c0bc3mr3870105f8f.51.1722642895765;
        Fri, 02 Aug 2024 16:54:55 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd01ab49sm3004409f8f.40.2024.08.02.16.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 16:54:55 -0700 (PDT)
Date: Sat, 3 Aug 2024 00:54:54 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] sched: cpufreq: Rename map_util_perf to
 sugov_apply_dvfs_headroom
Message-ID: <20240802235454.nl5rixxibs6rpfue@airbuntu>
References: <20240220180820.2597581-1-qyousef@layalina.io>
 <CAKfTPtDO1r+_htQWTB3V-iXChozFtPCRMQpaRY8ecsMu1QDacA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDO1r+_htQWTB3V-iXChozFtPCRMQpaRY8ecsMu1QDacA@mail.gmail.com>

On 02/21/24 08:35, Vincent Guittot wrote:
> On Tue, 20 Feb 2024 at 19:08, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > We are providing headroom for the utilization to grow until the next
> > decision point to pick the next frequency. Give the function a better
> > name and give it some documentation. It is not really mapping anything.
> >
> > Also move it to cpufreq_schedutil.c. This function relies on updating
> > util signal appropriately to give a headroom to grow. This is tied to
> > schedutil and scheduler and not something that can be shared with other
> > governors.
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Seems this wasn't picked up and I totally missed that :(

> 
> > ---
> >
> > Changes in v2:
> >
> >         1. Add Acked-by from Viresh and Raphael (Thanks!)
> >         2. Move the function to cpufreq_schedutil.c instead of sched.h
> >         3. Name space the function with sugov_ to indicate it is special to
> >            this governor only and not generic.
> >
> >  include/linux/sched/cpufreq.h    |  5 -----
> >  kernel/sched/cpufreq_schedutil.c | 20 +++++++++++++++++++-
> >  2 files changed, 19 insertions(+), 6 deletions(-)
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
> > index eece6244f9d2..575df3599813 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -178,12 +178,30 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >         return cpufreq_driver_resolve_freq(policy, freq);
> >  }
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
> > +static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util)
> > +{
> > +       return util + (util >> 2);
> > +}
> > +
> >  unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> >                                  unsigned long min,
> >                                  unsigned long max)
> >  {
> >         /* Add dvfs headroom to actual utilization */
> > -       actual = map_util_perf(actual);
> > +       actual = sugov_apply_dvfs_headroom(actual);
> >         /* Actually we don't need to target the max performance */
> >         if (actual < max)
> >                 max = actual;
> > --
> > 2.34.1
> >

