Return-Path: <linux-pm+bounces-13347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F069687BC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 14:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAC41C21824
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2024 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CF3187342;
	Mon,  2 Sep 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wPt4PGPJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF2318595A
	for <linux-pm@vger.kernel.org>; Mon,  2 Sep 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281000; cv=none; b=oOjXis7cY4ozx1RyvPetrilk6pC/DvmZx5jk3wTBj8n5ZJQOXHtZiCyi/udtDJSAWZG4bLcDarxMNQY0cAO4SRsPnMxHWqfIJMNN1sIjmfygisP4Wkw1RkyZzznkdiS5uok28YkK9BFw4eXntH6SB7KCNTCHcWdVmcmctFWqmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281000; c=relaxed/simple;
	bh=XmtoA1dxOzDS6roQ6BNIs04PwekYRQD9RJ6htg3/v6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbUJF9z7CcFvy4tZHjnvbBUJtYdC8/+V5SoiaYd1Hk696auKX8OmJEZbLadU3TNjAfxWC+Odjh4WxI6z9eOu+Q+MpMd/Sp1Arh5HMEHhEAPwUHZGoeEUGcdsCLydRD20ySQctnoys/BYpj7BCo3yopP48nwX57gOTNuCUOmHsSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wPt4PGPJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d88c5d76eeso1330022a91.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Sep 2024 05:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725280998; x=1725885798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XmtoA1dxOzDS6roQ6BNIs04PwekYRQD9RJ6htg3/v6I=;
        b=wPt4PGPJRvBxUgSLs3i8A5Tu98Y0IvbWPQHKJdTxk+RwYoxYS9kMkvROVH8C4uL2vD
         TXABtVhxPJzdR//P6r3YJBByUliNjIHd9wtZ6P+g/zdOuu2D62laXRpxPzo/SbJlAkaw
         CDRfEdQkiUyY0L/KAhXEI82L0pOJctErhxDNLMhkdcrAgRhO3mY4rk1vXP0Lg728akyw
         ljKnBFN4+6YzeFKpcpViXiK1+vp395xGPw9WPmJQtII6e8dv8wd/uFqqlfVs8tbZ/XLN
         nDKxSHqJcCYDyD69dFJDG4O5c5ugHKRls9jrWHIMYp6/wRGLkzHvrgB7aLaC8Cvd3mBZ
         cUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725280998; x=1725885798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmtoA1dxOzDS6roQ6BNIs04PwekYRQD9RJ6htg3/v6I=;
        b=gRKniR2s4rqPK9dgwyvaSL/z3kkEU5iR2VG2rOSjG1D9Rd+o4Q+c5u73/pjWZ1cZqZ
         4hsBS6B491m0VkEbF5vu9ByR8hrBNgcOqE7rRDHbpaKDu7oBAgHQN7DOtZIuPZUhDeOM
         XzTfVHzL/dW5qESc6QBgQn0Vudk8Q+Mk90uN7d5T0Xlw8XeoXtpY63TqPVSFH7ruEeb3
         IACytwm5gL3qRmzmSeLgo345Kevtzg33iTks3zt1ATLAygEixgqynH+EQLKklKBatdLD
         +SbHuns/dx+hMPbPKG+H0LhNK0tYnk69LswcwA+UxB5vyLlbPddkIRUndVRbzzF21OlC
         LIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw9EAfo54SQZgd2IZ85XeE2zCQJzi+lokhRRRMCceZdWh9RjuPrxKT5ypbiB0XAq5fTjitMJtzDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSxGQHrYge7Qkbn0OQBdn5YJYdODgsn0qUKpiLZ6YxHmlefCi
	asiNG8wd/m1XpuzXuABc1TGbR796N/MjA2TgtptQdxZD2TIfLVH8aQ/Ig/JyCOw+cff60ABT5Kv
	VWTvNlnXnFbjviU1fNu6ygAMinkINDCKD3ZSvMg==
X-Google-Smtp-Source: AGHT+IEtSBzuiPn8cwPFsnMtjISfPJE3LhaEPiYOtkJUA/snvFWxhOgQplzmnq8OTq6PPWXLEpJ7D5AgzgWDNRQ3Psc=
X-Received: by 2002:a17:90a:67cc:b0:2cf:2bf6:b030 with SMTP id
 98e67ed59e1d1-2d8564cb306mr12854219a91.33.1725280997722; Mon, 02 Sep 2024
 05:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728184551.42133-1-qyousef@layalina.io> <ca6b1db0-37d9-462e-87e4-d3bbd5eec7a3@arm.com>
 <CAKfTPtBWLe4hMBhJeSqvoW10dAF3Bgj+zcYGMgBfwUhkgytkEQ@mail.gmail.com>
 <CAKfTPtAJNjUe=4eQxq0M6==6O7dtJrw6rtwE6-xaWMJdSmfKcA@mail.gmail.com>
 <20240901175149.46yfk335niccmfq4@airbuntu> <CAKfTPtBahrD5L8CbB4BijAvnwq=yG375TWDUuEvNipyTDYGQTA@mail.gmail.com>
 <24a4a74f-0d46-420a-894c-9aa01ea4abcc@arm.com>
In-Reply-To: <24a4a74f-0d46-420a-894c-9aa01ea4abcc@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 2 Sep 2024 14:43:06 +0200
Message-ID: <CAKfTPtBjJ4uN5CgBjCEPL198ME_TKgQu6bpVVU4-DKY6CNm4BQ@mail.gmail.com>
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
To: Christian Loehle <christian.loehle@arm.com>
Cc: Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Hongyan Xia <hongyan.xia2@arm.com>, 
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 14:35, Christian Loehle <christian.loehle@arm.com> wrote:
>
> On 9/2/24 13:30, Vincent Guittot wrote:
> > On Sun, 1 Sept 2024 at 19:51, Qais Yousef <qyousef@layalina.io> wrote:
> >>
> >> On 08/13/24 10:27, Vincent Guittot wrote:
> >>> On Tue, 13 Aug 2024 at 10:25, Vincent Guittot
> >>> <vincent.guittot@linaro.org> wrote:
> >>>>
> >>>> On Mon, 5 Aug 2024 at 17:35, Christian Loehle <christian.loehle@arm.com> wrote:
> >>>>> Hi Qais,
> >>>>> the idea of SCHED_CPUFREQ_FORCE_UPDATE and the possiblity of spamming
> >>>>> freq updates still bothered me so let me share my thoughts even though
> >>>>> it might be niche enough for us not to care.
> >>>>>
> >>>>> 1. On fast_switch systems, assuming they are fine with handling the
> >>>>> actual updates, we have a bit more work on each context_switch() and
> >>>>> some synchronisation, too. That should be fine, if anything there's
> >>>>> some performance regression in a couple of niche cases.
> >>>>>
> >>>>> 2. On !fast_switch systems this gets more interesting IMO. So we have
> >>>>> a sugov DEADLINE task wakeup for every (in a freq-diff resulting)
> >>>>> update request. This task will preempt whatever and currently will
> >>>>> pretty much always be running on the CPU it ran last on (so first CPU
> >>>>> of the PD).
> >>>>
> >>>> The !fast_switch is a bit of concern for me too but not for the same
> >>>> reason and maybe the opposite of yours IIUC your proposal below:
> >>>>
> >>>> With fast_switch we have the following sequence:
> >>>>
> >>>> sched_switch() to task A
> >>>> cpufreq_driver_fast_switch -> write new freq target
> >>>> run task A
> >>>>
> >>>> This is pretty straight forward but we have the following sequence
> >>>> with !fast_switch
> >>>>
> >>>> sched_switch() to task A
> >>>> queue_irq_work -> raise an IPI on local CPU
> >>>> Handle IPI -> wakeup and queue sugov dl worker on local CPU (always
> >>>> with 1 CPU per PD)
> >>>> sched_switch() to sugov dl task
> >>>> __cpufreq_driver_target() which can possibly block on a lock
> >>>> sched_switch() to task A
> >>>> run task A
> >>>>
> >>>
> >>> sent a bit too early
> >>>
> >>>> We can possibly have 2 context switch and one IPi for each "normal"
> >>>> context switch which is not really optimal
> >>>
> >>> It would be good to find a way to skip the spurious back and forth
> >>> between the normal task and sugov
> >>
> >> Hmm I think we use affinity to keep the sugov running on policy->related_cpus.
> >> Relaxing this will make it less of a problem, but won't eliminate it.
> >
> > yes, but it's not a problem of relaxing affinity here
> >
> > The problem is that the 1st switch to task A will be preempted by
> > sugov so the 1st switch is useless. You should call cpufreq_update
> > before switching to A so that we skip the useless switch to task A and
> > directly switch to sugov 1st then task A
>
> Not necessarily, if you relax them to all CPUs the sugov tasks for all PDs
> can run on CPU0, no matter which CPU task A is on.

You can't always run sugov on other CPUs than those impacted by the freq change

>
> There is some benefit on having all sugov threads on the littles for many
> platforms (i.e. restricting them), making a good mainline policy out of
> it isn't quite so obvious to me.

This is a particular case whereas we want this to work in all cases

>

