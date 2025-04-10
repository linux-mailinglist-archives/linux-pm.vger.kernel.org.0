Return-Path: <linux-pm+bounces-25173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E32CA84D01
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 21:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3084E090C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 19:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BC028FFC8;
	Thu, 10 Apr 2025 19:26:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75EE28F935;
	Thu, 10 Apr 2025 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744313188; cv=none; b=dn42ws4ywSjiJ61vouRSgnwwuDVDefT914swtXBZN201G2x96M8D1C+gogRZzru/OB26RJmjwG0NTe/Bq49dwLx/DtAkkqMpc4Yfxxm0XWm5nn6vMkOH0D3BWMdL/v1jsHs3v6oYepqnu5QFDJEKQz5O1AUmR7iOZXqcv/9FdkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744313188; c=relaxed/simple;
	bh=WcolyHHWLRHRWuZRJTI/3OSHs7abBfLi4BT8QsbhgAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmqQKHF2MIBzPODjj893iawsGl7I5vPIO1wRKss3bcnLGyd8EK9pd+KReCGvz1L1F8U15qi/EnPvgvSzMXTwDzcClUsr18W8Jc9paarfcMTkeDuTBXPwwWf5RoBeDFrk0/CbiDd90RSpKR4bYkdUrT5aqii8lp8m0vWGd0e/sn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso16804425ad.2;
        Thu, 10 Apr 2025 12:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744313186; x=1744917986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWD/IFLs9J7mtfPAH3Pos16ipUjDet53kUJ8hQIRX0g=;
        b=w80T+Ak35gQewzHISxGYuTr0mVw30qOIQi8/12lTfd9n5Fh7KBnyyziqV1wOLVlJMt
         lGwutdv09bXMH9NFsxH0NGh0t6wsuRx8o2SSSzVBa8I2+kqeswpOgOSH1LQ1C6z5guH8
         xmGTFwyJHHhd5OpbjStCAH3R5Lk9UM4W7N21ELk9xRV7rqJmw+NpbjovZ5atgrf+E7DC
         nqGnTBsNNNqvPYxH5s51Je6mAUJdIqugFxLNirrf5ir/mhRpPokDf8mrPkWH4oBLR7l8
         AIpy+jEYuE8HivgzJvzmIo0Snp8EvwhbEsM9fy9ErQDrh3fmNQHk+Xydw0gEfDKGmKcV
         WjGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXE4Sd4YjYeDKk6rcE1YND5xMOwSDGTggHG87EA/h7eQiS666SSDz9k9RFVIPT1o36pxnl7G3vmhjcH94=@vger.kernel.org, AJvYcCXggpr9YLEBtH1AQNCWvQhLlg/YaJ9GSpDtSiRsdd10RrNspAwN0wnG3jcCxcnhPiRke1k3Y+HfrtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRmtVqR/pRVpfd7Gn0P7As5ERGbigFuYUKAVIwZsENGD2N7m8
	bc/TnI2hEBpjtefZbCDIViJ3gwz0yAB/C0HrIOvhL0rUK0WEWHF6
X-Gm-Gg: ASbGncuz3LsuyqkJTKZyI1ZRWQ+Bpc5hVIseFutRKRpGR7xasDKI8BLzJHy3sAmOTKl
	K4dtrEpvFuwkXyLosDDgxYSQnw7SpouksLMcGQDAbIwpG/vFxuqwJcc0Fcel7LPT+q6Q3JCEyDs
	TAoi1fvaa3guo2msVh/NlkwBYUnIwFkPAC3ECLpS0PCLCmzgu35MBuSk9afK9Ka0z+7iqPwyWo0
	dWKBH6YFbTbeYfYpGTUHRBltch203osx0qw+jPieCwzzzfMBmRP4YPflV62/KQG191NKahjORgh
	mnLW3bH11Nj+bjoL8TLCpSH1LsUCCgfXRn/eTS7qypEKaPCaulOZNxN1MVM=
X-Google-Smtp-Source: AGHT+IGzagBZX4K0SpPFtHSrrkXACoqK/o8hAsfw3bOFS+taLIjxIC8CSn6OwqHp0IUgdlAFMQFgGA==
X-Received: by 2002:a17:903:1a2b:b0:21f:c67:a68a with SMTP id d9443c01a7336-22bea4c6c69mr241725ad.31.1744313185901;
        Thu, 10 Apr 2025 12:26:25 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccb574sm34519065ad.227.2025.04.10.12.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 12:26:25 -0700 (PDT)
Date: Thu, 10 Apr 2025 12:26:21 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: Don't ignore limit changes when util
 is unchanged
Message-ID: <Z_gbXSeo6kjOXhwE@sultan-box.localdomain>
References: <20250410024439.20859-1-sultan@kerneltoast.com>
 <CAJZ5v0jKyy-3cELyDQTynE3Dv29V15F5f+w0A-H_nu+4LuaaYw@mail.gmail.com>
 <Z_fru1i1OpAQ-hJq@sultan-box.localdomain>
 <CAJZ5v0iu_hMud6FRg6FiUVQ1cY6oYqrEmwpwPTeYJh5Yzh5Q8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iu_hMud6FRg6FiUVQ1cY6oYqrEmwpwPTeYJh5Yzh5Q8A@mail.gmail.com>

On Thu, Apr 10, 2025 at 08:47:38PM +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 10, 2025 at 6:03 PM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> >
> > On Thu, Apr 10, 2025 at 05:34:39PM +0200, Rafael J. Wysocki wrote:
> > > On Thu, Apr 10, 2025 at 4:45 AM Sultan Alsawaf <sultan@kerneltoast.com> wrote:
> > > >
> > > > From: Sultan Alsawaf <sultan@kerneltoast.com>
> > > >
> > > > When utilization is unchanged, a policy limits update is ignored unless
> > > > CPUFREQ_NEED_UPDATE_LIMITS is set. This occurs because limits_changed
> > > > depends on the old broken behavior of need_freq_update to trigger a call
> > > > into cpufreq_driver_resolve_freq() to evaluate the changed policy limits.
> > > >
> > > > After fixing need_freq_update, limit changes are ignored without
> > > > CPUFREQ_NEED_UPDATE_LIMITS, at least until utilization changes enough to
> > > > make map_util_freq() return something different.
> > > >
> > > > Fix the ignored limit changes by preserving the value of limits_changed
> > > > until get_next_freq() is called, so limits_changed can trigger a call to
> > > > cpufreq_driver_resolve_freq().
> > > >
> > > > Reported-and-tested-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > > > Link: https://lore.kernel.org/lkml/Z_Tlc6Qs-tYpxWYb@linaro.org
> > > > Fixes: 8e461a1cb43d6 ("cpufreq: schedutil: Fix superfluous updates caused by need_freq_update")
> > > > Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> > > > ---
> > > >  kernel/sched/cpufreq_schedutil.c | 5 +++--
> > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > > index 1a19d69b91ed3..f37b999854d52 100644
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -82,7 +82,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> > > >                 return false;
> > > >
> > > >         if (unlikely(sg_policy->limits_changed)) {
> > > > -               sg_policy->limits_changed = false;
> > > >                 sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
> > > >                 return true;
> > > >         }
> > > > @@ -171,9 +170,11 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> > > >         freq = get_capacity_ref_freq(policy);
> > > >         freq = map_util_freq(util, freq, max);
> > > >
> > > > -       if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
> > > > +       if (freq == sg_policy->cached_raw_freq && !sg_policy->limits_changed &&
> > > > +           !sg_policy->need_freq_update)
> > > >                 return sg_policy->next_freq;
> > > >
> > > > +       sg_policy->limits_changed = false;
> > >
> > > AFAICS, after this code modification, a limit change may be missed due
> > > to a possible race with sugov_limits() which cannot happen if
> > > sg_policy->limits_changed is only cleared when it is set before
> > > updating sg_policy->need_freq_update.
> >
> > I don't think that's the case because sg_policy->limits_changed is cleared
> > before the new policy limits are evaluated in cpufreq_driver_resolve_freq().
> 
> sugov_limits() may be triggered by a scaling_max_freq update, for
> instance, so it is asynchronous with respect to the usual governor
> flow.  It updates sg_policy->limits_changed and assumes that next time
> the governor runs, it will call into the driver, for example via
> cpufreq_driver_fast_switch(), so the new limits take effect.  This is
> not about cpufreq_driver_resolve_freq().

OK, though I think there's still a race in cpufreq_driver_resolve_freq().

> sugov_limits() runs after the driver's ->verify() callback has
> returned and it is conditional on that callback's return value, so the
> driver already knows the new limits when sugov_limits() runs, but it
> may still need to tell the hardware what the new limits are and that's
> why cpufreq_driver_fast_switch() may need to run.

Which is why CPUFREQ_NEED_UPDATE_LIMITS exists, right.

> Now, if sugov_should_update_freq() sees sg_policy->limits_changed set,
> it will set sg_policy->need_freq_update which (for drivers with
> CPUFREQ_NEED_UPDATE_LIMITS set) guarantees that the driver will be
> invoked and so sg_policy->limits_changed can be cleared.
> 
> If a new instance of sugov_limits() runs at this point, there are two
> possibilities.  Either it completes before the
> sg_policy->limits_changed update in sugov_should_update_freq(), in
> which case the driver already knows the new limits as per the above
> and so the subsequent invocation of cpufreq_driver_fast_switch() will
> pick them up, or it sets sg_policy->limits_changed again and the
> governor will see it set next time it runs.  In both cases the new
> limits will be picked up unless they are changed again in the
> meantime.
> 
> After the above change, sg_policy->limits_changed may be cleared even
> if it has not been set before and that's problematic.  Namely, say it
> is unset when sugov_should_update_freq() runs, after being called by
> sugov_update_single_freq() via sugov_update_single_common(), and
> returns 'true' without setting sg_policy->need_freq_update.  Next,
> sugov_update_single_common() returns 'true' and get_next_freq() is
> called.  It sees that freq != sg_policy->cached_raw_freq, so it clears
> sg_policy->limits_changed.  If sugov_limits() runs on a different CPU
> between the check and the sg_policy->limits_changed update in
> get_next_freq(), it may be missed and it is still not guaranteed that
> cpufreq_driver_fast_switch() will run because
> sg_policy->need_freq_update is unset and sugov_hold_freq() may return
> 'true'.
> 
> For this to work, sg_policy->limits_changed needs to be cleared only
> when it is set and sg_policy->need_freq_update needs to be updated
> when sg_policy->limits_changed is cleared.

Ah I see, thank you for the detailed explanation. So if I am understanding it
correctly: the problem with my patch is that CPUFREQ_NEED_UPDATE_LIMITS might
not be honored after a limits change, because CPUFREQ_NEED_UPDATE_LIMITS is only
honored when sg_policy->limits_changed is set. So there is the following race:

           CPU-A                    CPU-B
  sugov_should_update_freq()                    // sg_policy->limits_changed == false, sg_policy->need_freq_update == false
                                sugov_limits()  // sg_policy->limits_changed == true,  sg_policy->need_freq_update == false
  get_next_freq()                               // sg_policy->limits_changed == false, sg_policy->need_freq_update == false

  // cpufreq driver won't be invoked for the limits change if:
  // next_f == sg_policy->next_freq || (sugov_hold_freq() == true && next_f < sg_policy->next_freq)

Does that look right?

> It looks like you really want to set sg_policy->need_freq_update to
> 'true' in sugov_should_update_freq() when sg_policy->limits_changed is
> set, but that would render CPUFREQ_NEED_UPDATE_LIMITS unnecessary.
> 
> > Granted, if we wanted to be really certain of this, we'd need release semantics.
> 
> I don't think so, but feel free to prove me wrong.

Well, it appears that there really is synchronization missing between
cpufreq_set_policy() and schedutil, since cpufreq_set_policy() changes the live
policy->min and policy->max, and schedutil may observe either the old values in
there or garbage values due to load/store tearing.

Sultan

