Return-Path: <linux-pm+bounces-12152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E3395064B
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 15:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2A4284B77
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA5719B3EC;
	Tue, 13 Aug 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnPPpfP9"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D319B3C6
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555177; cv=none; b=omLDxc49ibhM+Jh5q0W5PM2Hqqk5xYIlW98yp4IW2DRhbU9VSsBI/z4Vnh2T4DTckT9yldXufpXPuPGvGGpz2G4nOK/Ovxecjn9/aUsvN0hYO/Ykb4Q8sFJGiDfH3lLAtKeGeZyHde93HIwnPsYLMV68SeuoMO+34WEGr0c00u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555177; c=relaxed/simple;
	bh=UqxTkUGvtwG+g+4y+gpOh7+zfsZW7IT7gQu8DIUoAp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgXJ3NHPs/I3Etjj2PG0bpbfTfitsveG5/GV9upN/8AyX2trNalyIBlPxwvjYJO9w0Wx+dxtrpH08LaZdAsrcAh36BRTHb3OV8rlGMstCCOGG8fnbz6G2usa7dExR04wHqlQkBWkPPoMdA+tVxdtMRCkJmtofdNGq5U9Uvu75Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UnPPpfP9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723555175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lg7+Ggc3snS1DhVjmDqwGKcDB4EJn3V1wuE3H5dT92A=;
	b=UnPPpfP9A2FUPa4RxwkDvVRjbzkokDyBqfue50t3YbaL8iRryvbvMEdUa0S24r2LloMEwv
	MaGo3Px7+zrkYo1xdbsJBCSFw51HdACNUVld0KixkDai/RnOoXf81ZLkX2+qxewFkEtUYR
	gildcWPPEox5kyjslzKIzujx9ZQAPQQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-eyPyUWcvNhCUvZYzWoYX7Q-1; Tue, 13 Aug 2024 09:19:33 -0400
X-MC-Unique: eyPyUWcvNhCUvZYzWoYX7Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3716fb9129eso430209f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 06:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555172; x=1724159972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg7+Ggc3snS1DhVjmDqwGKcDB4EJn3V1wuE3H5dT92A=;
        b=hIaTJdbdgEgLoSROBm5H2NvztHO5sd9nVwE1GlT00aXai48EGTa1J7opah2J5FJCic
         0qaq9ljJ1TT4YSs2t9KOwGC5ZEEGOarssjABSE4/ateo+LJy9FKHIhK72pAIZhPL5Ze5
         of72cN18aTD0D+3rWfHX2RlDzIpCLJE5/O8KP8eMxKp8iaHvBV1dGr3nq34f+SDbVHAL
         BHzwzBrUM+xOV3NABCCBdJpeZZW3gK92LWKV9k3qsf5ylbGs27f4D0oHA9CZGl725sTw
         31p9DJ9wd0sZ2W4NjunTcQPh1ySiCv0CY66iIxLvxje18dYd3yYhsBXUZuSZLmS2L5Sd
         Au8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTcbVQXJM9tdPj1xBhDK7TBPabTXLnFqi8IljXagCNbR0dALgOJAJ1cHw49Tnf3fG6t8wFutFPhJU5jIn5yi23xc+crAtVHzc=
X-Gm-Message-State: AOJu0YwsfwETTwOdVTaPxvoJYQN/UXwFVIADXUm+n+sOS5BzYwTtpaNw
	ovQ1RsTbj0vLTvpEhYiTSnrhyJ3PzqnoeLF9aJaVgr4B8XTrEJvJlp1TBBmsbxgfE/NUPgiyZ9Y
	2dQRA6SpErIoKB9z2VRRL6cccu0xh+aDeN0GbnpMXuYMGfe5gCWyvFs79
X-Received: by 2002:a5d:6202:0:b0:36b:33ec:ac40 with SMTP id ffacd0b85a97d-3716ccf4511mr2234674f8f.16.1723555172470;
        Tue, 13 Aug 2024 06:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbvjrw6+c7B5jqqiO5v/YBG2lt/jSLU5V6GqBRYBZPORVTMNlwkmbnwha4bsrKICbkvO5wkg==
X-Received: by 2002:a5d:6202:0:b0:36b:33ec:ac40 with SMTP id ffacd0b85a97d-3716ccf4511mr2234651f8f.16.1723555171933;
        Tue, 13 Aug 2024 06:19:31 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([2a00:23c6:4a1d:e001:d365:918d:a79e:2a1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750ef58sm139499255e9.16.2024.08.13.06.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:19:31 -0700 (PDT)
Date: Tue, 13 Aug 2024 14:19:29 +0100
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
Message-ID: <ZrtdYXW2VullBiop@jlelli-thinkpadt14gen4.remote.csb>
References: <3c726cf5-0c94-4cc6-aff0-a453d840d452@arm.com>
 <20240809012410.marjxrio3sjequnn@airbuntu>
 <ZrXIb7BFOWY11DKt@jlelli-thinkpadt14gen4.remote.csb>
 <CAKfTPtD_QzYVeTbQ-j2mOsKmCcjUaxo403M_HYCWbT2RjjGb7w@mail.gmail.com>
 <25da50cb-776f-42db-9821-e86a441259c0@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25da50cb-776f-42db-9821-e86a441259c0@arm.com>

On 13/08/24 11:17, Christian Loehle wrote:
> On 8/13/24 08:54, Vincent Guittot wrote:
> > On Fri, 9 Aug 2024 at 09:42, Juri Lelli <juri.lelli@redhat.com> wrote:
> >>
> >> On 09/08/24 02:24, Qais Yousef wrote:
> >>> Adding more sched folks to CC
> >>>
> >>> On 08/06/24 14:41, Christian Loehle wrote:
> >>>> Convert the sugov deadline task attributes to use the available
> >>>> definitions to make them more readable.
> >>>> No functional change.
> >>>>
> >>>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> >>>> ---
> >>>>  kernel/sched/cpufreq_schedutil.c | 6 +++---
> >>>>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >>>> index eece6244f9d2..012b38a04894 100644
> >>>> --- a/kernel/sched/cpufreq_schedutil.c
> >>>> +++ b/kernel/sched/cpufreq_schedutil.c
> >>>> @@ -654,9 +654,9 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
> >>>>              * Fake (unused) bandwidth; workaround to "fix"
> >>>>              * priority inheritance.
> >>>>              */
> >>>> -           .sched_runtime  =  1000000,
> >>>> -           .sched_deadline = 10000000,
> >>>> -           .sched_period   = 10000000,
> >>>> +           .sched_runtime  = USEC_PER_SEC,
> >>>> +           .sched_deadline = 10 * USEC_PER_SEC,
> >>>> +           .sched_period   = 10 * USEC_PER_SEC,
> >>>
> >>> I think NSEC_PER_MSEC is the correct one. The units in
> >>> include/uapi/linux/sched/types.h is not specified. Had to look at
> >>> sched-deadline.rst to figure it out.
> 
> Huh, that's what I used, see below.
> 
> >>
> >> In practice it's the same number :). But, you are correct, we want
> >> 1ms/10ms and unit is nanoseconds, so NSEC_PER_MSEC.
> > 
> > Yes NSEC_PER_MSEC is the correct unit
> 
> Thank you Qais, Juri and Vincent, but if I'm not missing something we
> have a contradiction.
> This patch should indeed be NSEC_PER_MSEC and I'll send a v2 but:
> - Documentation/scheduler/sched-deadline.rst talks about microseconds:
> SCHED_DEADLINE [18] uses three parameters, named "runtime", "period", and
>  "deadline", to schedule tasks. A SCHED_DEADLINE task should receive
>  "runtime" microseconds of execution time every "period" microseconds, and
>  these "runtime" microseconds are available within "deadline" microseconds
>  from the beginning of the period.
> 
> - sched_setattr / sched_getattr manpages talks about nanoseconds:
>        sched_deadline
>               This field specifies the "Deadline" parameter for deadline
>               scheduling.  The value is expressed in nanoseconds.
> 
> - include/uapi/linux/sched/types.h doesn't mention any unit.
> I will add that to the v2 series.
> 
> - kernel/sched/deadline.c works with nanoseconds internally (although
> with the precision limitation in microseconds).
> 
> No conversion so
> attr->sched_deadline (uapi) == dl_se->dl_deadline (kernel) etc.
> So Documentation/scheduler/sched-deadline.rst is false or what is it that
> I'm missing?
> 

As you say above, internal resolution is essentially down to 1us
(microsecond) and we also check that parameters are at least 1us or
bigger [1].

syscalls and internal mechanics work with nanoseconds, but I don't think
this is a contradiction.

1 - https://elixir.bootlin.com/linux/v6.10.4/source/kernel/sched/deadline.c#L3065


