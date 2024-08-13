Return-Path: <linux-pm+bounces-12156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0F69506FD
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A4E281CE2
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5961A19D08C;
	Tue, 13 Aug 2024 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VU5R7IC9"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6819D06E
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557438; cv=none; b=KBbPGKGmKRMoKcHLQHxYkgxA+A7qFlZcsRMtuSkJBC3pXeULi9TR3iZvNyO7eaz6Q1JiR1SCC18sR2pCkXkiFiGFUPNEf0IvjnWv3wy1MkuhqvzldIYjxAWOA4nK+rx/SSTJ+44T2fRnOKG6MZdFC1U4oHFGgK6G1TtxbcLYEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557438; c=relaxed/simple;
	bh=RcMqqTEfTSLr+++tDYyI0Q1bjZz9OT1eaU6LMXSMTm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDpeh67rZ3YXqfq8FIVmTZeLOXn5fMQHYoMUXGdNTyXeIOvyVYhfZ8Gg6RbxXWpdaJsijt8zgFIs1UBnCxPeKzcGtO2Eb2+u6Sws+YVoopnW6jOiM9rexB9nAXRv/fEJsz92w6ICwvhbtLrmoiBc/52TW00KrYFn4ZldCBrxLhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VU5R7IC9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723557435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vabtoVHWKvV/1SG/be91JzWWAjd+sf4Dx+EYtZWiLoc=;
	b=VU5R7IC9pqYOG8wHHSH3nkrJIUow64vXIIEXT5cETVy+TA13qi6VqdNpzK2bsynA2LYny5
	wyFgCifYgG/jYddW9cbZAH8JcMWlhwpfpMMk+Ca1NZrLoJ62iM558tC8wxUrw0KpklAYsc
	OeonwY4Bp4vA203UflJQq+LCb8gWsCY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-RrwdTZNPNUKDIyH9okmd_w-1; Tue, 13 Aug 2024 09:57:09 -0400
X-MC-Unique: RrwdTZNPNUKDIyH9okmd_w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-429c224d9edso32551605e9.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 06:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723557428; x=1724162228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vabtoVHWKvV/1SG/be91JzWWAjd+sf4Dx+EYtZWiLoc=;
        b=G0wZkwiE/KYJCq46e9tQ0Zd7zt12VBUKbIs0J2TOxLRtNkkaLUQaCca3VAPDm0fHI5
         KAGsZCB4ypwFjydBtqNHeAvJGgLCUvZQUDcEXnc4izfqE5feVL3IEvO+XpYkKeWaTprN
         GQRHn9q123Z6AGkjTC3UIc/v9RQHeosHvsUTwmGu7Dm2rzHLQ9aCBE5K4ZyRE8gYLRCt
         vcnI15HFebbSNQRfuS6jdqeYHZpAUYCvHtGjmMMEiO2FDrynTKjc8o/l+U3kkLQKOz+X
         dtqSe5UtojQ0pqIG9p5gZ9YYpxcqHVJxTwsL35zgMChI/fAsdui//fw11+0gk3DEuLQc
         wb2w==
X-Forwarded-Encrypted: i=1; AJvYcCUehRmlXejlOs+78VnxGoYtH3YifwzrTQJ2QkXZEWwmlKT/xl2a7hpWxD44fYcY1RXhnaJkep+8rBpXIGYkLYynrNM3YQrUJ+0=
X-Gm-Message-State: AOJu0YydVUk5Rvx4uYeAuSmJUtuquG99lktjl3zC1q8jqtjX57kaE1pm
	1bSDqWlB1/j/MjcIm9+JPQg9nK7tFk0+RzKEp0hA5yuJu0rHdzuDAN0t+xHPnLvLrZq1WZPJ5CW
	vtG70ZGPD6ocBcJ9RSnGYkR0lXn/4nc/b7itMQsbo+W8xqPKbR9ae32bZ
X-Received: by 2002:a05:600c:4ed2:b0:429:a3e:c785 with SMTP id 5b1f17b1804b1-429d481e867mr26475035e9.21.1723557428435;
        Tue, 13 Aug 2024 06:57:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGE61Ix61B1P0ouSqVuqS620H57DJ6X6CEjFHpczsLuKHS/td3xxFMWW04FQ2c39NHm585rw==
X-Received: by 2002:a05:600c:4ed2:b0:429:a3e:c785 with SMTP id 5b1f17b1804b1-429d481e867mr26474815e9.21.1723557427872;
        Tue, 13 Aug 2024 06:57:07 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([2a00:23c6:4a1d:e001:d365:918d:a79e:2a1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7a38a6sm228324985e9.42.2024.08.13.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:57:07 -0700 (PDT)
Date: Tue, 13 Aug 2024 14:57:05 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Qais Yousef <qyousef@layalina.io>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pm@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/cpufreq: Use USEC_PER_SEC for deadline task
Message-ID: <ZrtmMcU1405Niiks@jlelli-thinkpadt14gen4.remote.csb>
References: <3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com>
 <20240809012410.marjxrio3sjequnn@airbuntu>
 <ZrXIb7BFOWY11DKt@jlelli-thinkpadt14gen4.remote.csb>
 <CAKfTPtD_QzYVeTbQ-j2mOsKmCcjUaxo403M_HYCWbT2RjjGb7w@mail.gmail.com>
 <25da50cb-776f-42db-9821-e86a441259c0@arm.com>
 <ZrtdYXW2VullBiop@jlelli-thinkpadt14gen4.remote.csb>
 <459ae1ee-d114-4fdc-b728-33bde5d08e24@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459ae1ee-d114-4fdc-b728-33bde5d08e24@arm.com>

On 13/08/24 14:34, Christian Loehle wrote:
> On 8/13/24 14:19, Juri Lelli wrote:
> > On 13/08/24 11:17, Christian Loehle wrote:
> >> On 8/13/24 08:54, Vincent Guittot wrote:
> >>> On Fri, 9 Aug 2024 at 09:42, Juri Lelli <juri.lelli@redhat.com> wrote:
> >>>>
> >>>> On 09/08/24 02:24, Qais Yousef wrote:
> >>>>> Adding more sched folks to CC
> >>>>>
> >>>>> On 08/06/24 14:41, Christian Loehle wrote:
> >>>>>> Convert the sugov deadline task attributes to use the available
> >>>>>> definitions to make them more readable.
> >>>>>> No functional change.
> >>>>>>
> >>>>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >>>>>> ---
> >>>>>>  kernel/sched/cpufreq_schedutil.c | 6 +++---
> >>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >>>>>> index eece6244f9d2..012b38a04894 100644
> >>>>>> --- a/kernel/sched/cpufreq_schedutil.c
> >>>>>> +++ b/kernel/sched/cpufreq_schedutil.c
> >>>>>> @@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
> >>>>>>              * Fake (unused) bandwidth; workaround to "fix"
> >>>>>>              * priority inheritance.
> >>>>>>              */
> >>>>>> -           .sched_runtime  =  1000000,
> >>>>>> -           .sched_deadline = 10000000,
> >>>>>> -           .sched_period   = 10000000,
> >>>>>> +           .sched_runtime  = USEC_PER_SEC,
> >>>>>> +           .sched_deadline = 10 * USEC_PER_SEC,
> >>>>>> +           .sched_period   = 10 * USEC_PER_SEC,
> >>>>>
> >>>>> I think NSEC_PER_MSEC is the correct one. The units in
> >>>>> include/uapi/linux/sched/types.h is not specified. Had to look at
> >>>>> sched-deadline.rst to figure it out.
> >>
> >> Huh, that's what I used, see below.
> >>
> >>>>
> >>>> In practice it's the same number :). But, you are correct, we want
> >>>> 1ms/10ms and unit is nanoseconds, so NSEC_PER_MSEC.
> >>>
> >>> Yes NSEC_PER_MSEC is the correct unit
> >>
> >> Thank you Qais, Juri and Vincent, but if I'm not missing something we
> >> have a contradiction.
> >> This patch should indeed be NSEC_PER_MSEC and I'll send a v2 but:
> >> - Documentation/scheduler/sched-deadline.rst talks about microseconds:
> >> SCHED_DEADLINE [18] uses three parameters, named "runtime", "period", and
> >>  "deadline", to schedule tasks. A SCHED_DEADLINE task should receive
> >>  "runtime" microseconds of execution time every "period" microseconds, and
> >>  these "runtime" microseconds are available within "deadline" microseconds
> >>  from the beginning of the period.
> >>
> >> - sched_setattr / sched_getattr manpages talks about nanoseconds:
> >>        sched_deadline
> >>               This field specifies the "Deadline" parameter for deadline
> >>               scheduling.  The value is expressed in nanoseconds.
> >>
> >> - include/uapi/linux/sched/types.h doesn't mention any unit.
> >> I will add that to the v2 series.
> >>
> >> - kernel/sched/deadline.c works with nanoseconds internally (although
> >> with the precision limitation in microseconds).
> >>
> >> No conversion so
> >> attr->sched_deadline (uapi) == dl_se->dl_deadline (kernel) etc.
> >> So Documentation/scheduler/sched-deadline.rst is false or what is it that
> >> I'm missing?
> >>
> > 
> > As you say above, internal resolution is essentially down to 1us
> > (microsecond) and we also check that parameters are at least 1us or
> > bigger [1].
> > 
> > syscalls and internal mechanics work with nanoseconds, but I don't think
> > this is a contradiction.
> > 
> > 1 - https://elixir.bootlin.com/linux/v6.10.4/source/kernel/sched/deadline.c#L3065
> > 
> 
> All good then you reckon?
> Still the part about schedtool is wrong:
> 
> -->8--
> 
> diff --git a/Documentation/scheduler/sched-deadline.rst b/Documentation/scheduler/sched-deadline.rst
> index 9fe4846079bb..f7475d101e7a 100644
> --- a/Documentation/scheduler/sched-deadline.rst
> +++ b/Documentation/scheduler/sched-deadline.rst
> @@ -759,7 +759,7 @@ Appendix A. Test suite
>    # schedtool -E -t 10000000:100000000 -e ./my_cpuhog_app
>  
>   With this, my_cpuhog_app is put to run inside a SCHED_DEADLINE reservation
> - of 10ms every 100ms (note that parameters are expressed in microseconds).
> + of 10ms every 100ms (note that parameters are expressed in nanoseconds).
>   You can also use schedtool to create a reservation for an already running
>   application, given that you know its pid::

Right. Well, while we are at it, I actually wonder if we want to just rewrite
the example using chrt (which now supports DEADLINE). :)


