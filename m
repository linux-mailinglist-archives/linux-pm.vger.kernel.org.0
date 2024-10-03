Return-Path: <linux-pm+bounces-15097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C75E98EC6C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 11:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09931C2133D
	for <lists+linux-pm@lfdr.de>; Thu,  3 Oct 2024 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B081A146A97;
	Thu,  3 Oct 2024 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V18XLltV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B23AC2B
	for <linux-pm@vger.kernel.org>; Thu,  3 Oct 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727948885; cv=none; b=kCiAJlNREW1RodWP9G6mcx7jNkT4AkNL3A3rRHl7Jd//7nxvK35gjpIJj0yTlBYVqspH/12DaUKNoAvhDikd/bZG+komLUZVAbEzuNI3QhRW0830cjbd9nH4ZIZHqKuABR018DaVGvPYwHUbx978QT/+LU+qQZbfnYW0xkf4hbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727948885; c=relaxed/simple;
	bh=SIeEpVSBefV9U+2eDCv2V0waDUEws1Q//fEl0frYGgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAjcfqHoT+0cjUfgUuCAfh4aCop3VZl1gdaPv8VUfXv1SaJ9CewjEZW6ONHFi3QQtPcisA3Ptr1MYEnxbjQIXlbA6A2SRBd5HJhODhkunLGwNNddYyGPvzPusPcAfxnvxT0jPXCXgcPCyTpAbDxElBBhwX9wsMZFCQoUCWgvg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V18XLltV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d56155f51so82240266b.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2024 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727948882; x=1728553682; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5CFsPHtLrJf+vHnalSd1JxuKBY+VdQMavFuJV9UtbEc=;
        b=V18XLltVVcZTpS0/zlsmeQlTdud3qlvP/8sd2VN/849N8VUboChQlyd8RUMBXLTKkO
         J9Rpr8RtOiRvvtjGXflvIF1fLv/GZSnuNyhHBM06SALMETqtQ8ThfYx7sJ5zGOGslqvE
         nhLIcRSktPXcoUACj0KKKgau6Xz4CEo7w79rFsAmQpma/JLc3oLMYEG99rdpdU1yhM+v
         wPVN1OqsKrmsN766rjL1jLOb0ZLwL4bBepcmkxrWwt1Io2kStMYtdSEuGtBIPC/FZIMj
         LnapvTVhHriIgXxAIL0lGQCPyZZ6pYFrwVOgUxrrysU/xvuD80f7MvnuO2G4fE74fmf2
         Y2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727948882; x=1728553682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CFsPHtLrJf+vHnalSd1JxuKBY+VdQMavFuJV9UtbEc=;
        b=gdGPVYUnCNJhHxlMVkwLsDA8faoofLTDGTaLMpyw75uoD5YLL59pKTX9cXPjmc+jAE
         jYDf85IZi8QZqHru4S33CepK8JCM/8zyHYmVljGqcrsu7sfFzojfkiAGh7GpHGKCjghm
         UoJ9XqZvhl6M9ood5C/H/Sk9N2g6CLuZMPbEyFd4ju0E5F2szHLJgEJjNL7+M/dNsV08
         TXioUpt9jPg8UoBxGZmAsgnVP1KefekiBqLclWe/nEhSU0HZo9UMnlzXP3cSRvURSl2O
         TaJWYt5KXgfeIH/Ba57xOhGMqk9efipUdnwjTb40iQL79xP0eO6eH1u3FrKKE5yWouKP
         JpXw==
X-Forwarded-Encrypted: i=1; AJvYcCUwLkR23fJmYLKgNtCNZQHWh8JCrQunLlOODN9NWuhIVHMDaO/k+uft0ffHNNFJ26e4vbFjDsaPnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnmV9H21OMN30jJ8spmEXJBqjAmgMqMTMypPKglpUDHPhPRDqi
	l7+3gc2v3IKoknxJfzap6RC09wkE3NBbmnmGe0c19FlrhvvbTlxlpQqWYx7qGFjxQ+o1etskAkj
	qmg==
X-Google-Smtp-Source: AGHT+IEltl18S2VzGqkQFdD4PfVtJi8u0kItMR+1qOuHbZiGw6nKi84syWPZmXhoI99aIB//u6x36g==
X-Received: by 2002:a17:907:8015:b0:a99:9e9:a3dc with SMTP id a640c23a62f3a-a9909e9a5cfmr137474466b.2.1727948881784;
        Thu, 03 Oct 2024 02:48:01 -0700 (PDT)
Received: from google.com (40.162.204.35.bc.googleusercontent.com. [35.204.162.40])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99102a57a1sm61062466b.67.2024.10.03.02.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 02:48:01 -0700 (PDT)
Date: Thu, 3 Oct 2024 09:47:58 +0000
From: Quentin Perret <qperret@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	juri.lelli@redhat.com, mingo@redhat.com, dietmar.eggemann@arm.com,
	vschneid@redhat.com, vincent.guittot@linaro.org,
	Johannes.Thumshirn@wdc.com, adrian.hunter@intel.com,
	ulf.hansson@linaro.org, bvanassche@acm.org, andres@anarazel.de,
	asml.silence@gmail.com, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, qyousef@layalina.io, dsmythies@telus.net,
	axboe@kernel.dk
Subject: Re: [RFC PATCH 5/8] cpufreq/schedutil: Remove iowait boost
Message-ID: <Zv5oTvxPsiTWCJIo@google.com>
References: <20240905092645.2885200-1-christian.loehle@arm.com>
 <20240905092645.2885200-6-christian.loehle@arm.com>
 <CAJZ5v0hJWwsErT193i394bHOczvCQwU_5AVVTJ1oKDe7kTW82g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hJWwsErT193i394bHOczvCQwU_5AVVTJ1oKDe7kTW82g@mail.gmail.com>

On Monday 30 Sep 2024 at 18:34:24 (+0200), Rafael J. Wysocki wrote:
> On Thu, Sep 5, 2024 at 11:27 AM Christian Loehle
> <christian.loehle@arm.com> wrote:
> >
> > iowait boost in schedutil was introduced by
> > commit ("21ca6d2c52f8 cpufreq: schedutil: Add iowait boosting").
> > with it more or less following intel_pstate's approach to increase
> > frequency after an iowait wakeup.
> > Behaviour that is piggy-backed onto iowait boost is problematic
> > due to a lot of reasons, so remove it.
> >
> > For schedutil specifically these are some of the reasons:
> > 1. Boosting is applied even in scenarios where it doesn't improve
> > throughput.
> 
> Well, I wouldn't argue this way because it is kind of like saying that
> air conditioning is used even when it doesn't really help.  It is
> sometimes hard to know in advance whether or not it will help though.
> 
> > 2. The boost is not accounted for in EAS: a) feec() will only consider
> >  the actual task utilization for task placement, but another CPU might
> >  be more energy-efficient at that capacity than the boosted one.)
> >  b) When placing a non-IO task while a CPU is boosted compute_energy()
> >  assumes a lower OPP than what is actually applied. This leads to
> >  wrong EAS decisions.
> 
> That's a very good point IMV and so is the one regarding UCLAMP_MAX (8
> in your list).

I would actually argue that this is also an implementation problem
rather than something fundamental about boosting. EAS could be taught
about iowait boosting and factor that into the decisions.

> If the goal is to set the adequate performance for a given utilization
> level (either actual or prescribed), boosting doesn't really play well
> with this and it shouldn't be used at least in these cases.

There's plenty of cases where EAS will correctly understand that
migrating a task away will not reduce the OPP (e.g. another task on the
rq has a uclamp_min request, or another CPU in the perf domain has a
higher request), so iowait boosting could probably be added.

In fact if the iowait boost was made a task property, EAS could easily
understand the effect of migrating that boost with the task (it's not
fundamentally different from migrating a task with a high uclamp_min
from the energy model perspective).

> > 3. Actual IO heavy workloads are hardly distinguished from infrequent
> > in_iowait wakeups.
> 
> Do infrequent in_iowait wakeups really cause the boosting to be
> applied at full swing?
> 
> > 4. The boost isn't accounted for in task placement.
> 
> I'm not sure what exactly this means.  "Big" vs "little" or something else?
> 
> > 5. The boost isn't associated with a task, it therefore lingers on the
> > rq even after the responsible task has migrated / stopped.
> 
> Fair enough, but this is rather a problem with the implementation of
> boosting and not with the basic idea of it.

+1

> > 6. The boost isn't associated with a task, it therefore needs to ramp
> > up again when migrated.
> 
> Well, that again is somewhat implementation-related IMV, and it need
> not be problematic in principle.  Namely, if a task migrates and it is
> not the only one in the "new" CPUs runqueue, and the other tasks in
> there don't use in_iowait, maybe it's better to not boost it?
> 
> It also means that boosting is not very consistent, though, which is a
> valid point.
> 
> > 7. Since schedutil doesn't know which task is getting woken up,
> > multiple unrelated in_iowait tasks lead to boosting.
> 
> Well, that's by design: it boosts, when "there is enough IO pressure
> in the runqueue", so to speak.
> 
> Basically, it is a departure from the "make performance follow
> utilization" general idea and it is based on the observation that in
> some cases performance can be improved by taking additional
> information into account.
> 
> It is also about pure performance, not about energy efficiency.
> 
> > 8. Boosting is hard to control with UCLAMP_MAX (which is only active
> > when the task is on the rq, which for boosted tasks is usually not
> > the case for most of the time).

Sounds like another reason to make iowait boosting per-task to me :-)

I've always thought that turning iowait boosting into some sort of
in-kernel uclamp_min request would be a good approach for most of the
issues mentioned above. Note that I'm not necessarily saying to use the
actual uclamp infrastructure (though it's valid option), I'm really just
talking about the concept. Is that something you've considered?

I presume we could even factor out the 'logic' part of the code that
decides out to request the boost into its own thing, and possibly have
different policies for different use-cases, but that might be overkill.

Thanks,
Quentin

