Return-Path: <linux-pm+bounces-13307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCB1967B8F
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 19:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AEB1F214E8
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2024 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9401514AD38;
	Sun,  1 Sep 2024 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="vlRdhOCs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2623A6
	for <linux-pm@vger.kernel.org>; Sun,  1 Sep 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725213116; cv=none; b=Sh7S/Yn5aORHrsc2rCId9CKUd2iuxed5IK7LVK5G9sLZ6SMz/eMXYcr2L9duEElzy8GNeOIaryTifd3RKUZ8Y0+30dF/B0N1WXP+ha7TfNvtRVS9jbQxijJq2A6N7ii8D3bi/dq16SS4ieClV3e+5SKYxJ9GWU+F90PSjK8zsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725213116; c=relaxed/simple;
	bh=Tn6tHZIhVIU8zRTnyxfsgdnTgYxw83yj+IEMUQM3pv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YymaKYrwEugW8rPNaKTN7UnV4QGOZ2OsaZbrXFFREjSzpJ/YFALyPyyJ39fPM4vDlGrKLrQb+9CtvQnfOWxJo4PLK1u3YRW9//TGgrDdoFrV0ZHztOw0re8jYIaK5G+qHZ2wmvg8reihQYIr2i+mMDM911+YKbb36j6sqmHFAwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=vlRdhOCs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a86a37208b2so393206866b.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Sep 2024 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1725213113; x=1725817913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iRaHoHzfShs9AbyvrFmo6S/xkJsBUX6uusSCB+QrMFI=;
        b=vlRdhOCs75cyxVEfYdG+vGJwIyZef0z6jmPKwN+vnZOkRxXqs0/i78sUXgxzcnmF98
         7lRUMoIuPrhIGMf122IlhpgmoP/PbsJ0mnOU0GMnYybB+9dpTkJDQviqAQxmJ0cyFcQC
         9CBZQ810nnVD5vGTP14sRBkTO73n1QzuyKSxk+hJE3uD3OlP7BMTRFqW5K2QsAqcUAzL
         x1iH9Wx1dW9B+6mYAxri4WNk92JQjZsBWsYa/TT+JoOqVPuQ6pTZZZMgbB1fylZtP57I
         2LgGHVGmIhKVg993/tpfKakAmKp+Jcwe4T3HK3BjTjQn6oZSFoSpkbQxbjjU9cXItcpC
         qtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725213113; x=1725817913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRaHoHzfShs9AbyvrFmo6S/xkJsBUX6uusSCB+QrMFI=;
        b=iZ1HxpEaV1cFOkfbmGIrIkgc3KU3xgupJgmxmfhgY2fAsnayyOJmpqlOKw7VGxMAy2
         Gyf8XCKGRf8Hbqc1SpDOhhVXvFr5KhY4lHo/k2ELtUcxe+b/kWEJM5HFkWIvSp+OnGzS
         UUIWjTHr8tbID14cUi0RdTgmyP2+nXCbXXEE2yMf5RMyocSOIoZmuxbK8ScfraFvsYyb
         1DBPgRyTfSFDKs+F4fqzwKPL/aoaRnRBW2XaS/rRgN8Xp5GidKNNn1VUcg+Fz4VPcQzC
         pBGrKe0HV2ZOiTN6MfZyEU8+EkjmAVvftS1jgQZNMzHvz+GYMQEf0Qm/JgjGmmHJ9WQk
         UN9A==
X-Forwarded-Encrypted: i=1; AJvYcCXExq6qJlKYftlQogTr/KHsgX7xLh6iCY3kwa9WIy4NZjOojI3m+tpfOU3oQKLVx9KrxI9khA/hew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxywEZn0bC+PO5+jmo5wEqKgzGNYwOS/bQT0amOXMIe0BnCvBr9
	Xu85CpYeFjLpWuE61r4Nye99KSmrg+3+qyuXPtSjsdBP4C5a62lerQsICGjB8Kg=
X-Google-Smtp-Source: AGHT+IFRRDbGvFCHQXdboqdVjJadxSjBkeetzH05dZheYKJemWnppoFoaTieZCL7fGuQhPEAeiLn9Q==
X-Received: by 2002:a17:906:dc95:b0:a86:789f:c756 with SMTP id a640c23a62f3a-a897fa754cbmr735860166b.53.1725213113103;
        Sun, 01 Sep 2024 10:51:53 -0700 (PDT)
Received: from airbuntu ([176.29.222.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89890219aasm460154066b.65.2024.09.01.10.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 10:51:52 -0700 (PDT)
Date: Sun, 1 Sep 2024 18:51:49 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Christian Loehle <christian.loehle@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
Message-ID: <20240901175149.46yfk335niccmfq4@airbuntu>
References: <20240728184551.42133-1-qyousef@layalina.io>
 <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>

On 08/13/24 10:27, Vincent Guittot wrote:
> On Tue, 13 Aug 2024 at 10:25, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
> > > Hi Qais,
> > > the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
> > > freq updates still bothered me so let me share my thoughts even though
> > > it might be niche enough for us not to care.
> > >
> > > 1. On fast_switch systems, assuming they are fine with handling the
> > > actual updates, we have a bit more work on each context_switch() and
> > > some synchronisation, too. That should be fine, if anything there's
> > > some performance regression in a couple of niche cases.
> > >
> > > 2. On !fast_switch systems this gets more interesting IMO. So we have
> > > a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
> > > update request. This task will preempt whatever and currently will
> > > pretty much always be running on the CPU it ran last on (so first CPU
> > > of the PD).
> >
> > The !fast_switch is a bit of concern for me too but not for the same
> > reason and maybe the opposite of yours IIUC your proposal below:
> >
> > With fast_switch we have the following sequence:
> >
> > sched_switch() to task A
> > cpufreq_driver_fast_switch -> write new freq target
> > run task A
> >
> > This is pretty straight forward but we have the following sequence
> > with !fast_switch
> >
> > sched_switch() to task A
> > queue_irq_work -> raise an IPI on local CPU
> > Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
> > with 1 CPU per PD)
> > sched_switch() to sugov dl task
> > __cpufreq_driver_target() which can possibly block on a lock
> > sched_switch() to task A
> > run task A
> >
> 
> sent a bit too early
> 
> > We can possibly have 2 context switch and one IPi for each "normal"
> > context switch which is not really optimal
> 
> It would be good to find a way to skip the spurious back and forth
> between the normal task and sugov

Hmm I think we use affinity to keep the sugov running on policy->related_cpus.
Relaxing this will make it less of a problem, but won't eliminate it.

I'll have a think about it, is this a blocker for now?



