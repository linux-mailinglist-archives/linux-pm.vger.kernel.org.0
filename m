Return-Path: <linux-pm+bounces-29612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDA2AEA58C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 20:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA10C56313A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 18:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3602ED862;
	Thu, 26 Jun 2025 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1EaHyFqW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FCF1DF739
	for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963380; cv=none; b=JIyOAaHHxgB+/PhfNJq9nRmd9VJK2fC/Tg27WE0BO6NSEq7BCt3khhQpvP9JMwOrmjIYpwCfF4bpnYyiAUSEKqWRAY6E0LHFWhJDhPfPpl9YRuIo41UGZgfgYzlXjSq7jXytCi1qSXOGs1hS0QALfWqlXdhqH+/kq+0rFTW4RBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963380; c=relaxed/simple;
	bh=9xeIc23WgDLTXH2EjxYMq+4YkKAUpGaPH147t0+R5Q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsvKRwvfgo/opn2Bfk4OSZceKgv2JVZitwjN78EHsd+PI32lP9UAhsesmDxmdNVBwOEtZG8ypdqwgauTjpoeXuIHZrWvrNeJwI1GkDWXpXaJb6aqVi7m7KrABfxATrENpDM0a99E+AAtKKvJggpPlm2a1q011rka9NiEsprkt3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1EaHyFqW; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a7fc24ed5cso61781cf.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 11:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750963378; x=1751568178; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hfiM5bCuQxjyqjIUXTrhK8ewP3OgmuvSafU7HnQFZn0=;
        b=1EaHyFqWQCoh/6MJJQEDq+RBqJ9keSZ1ff/1TQe+8Ac3f9uMdqtEJWtmeXQ3f+BJoQ
         Lr2I+5nviWLCNdyqTlzG5jdchKEI+NzFQ0qK4dXY404XjUXZPg8h/2MjzNCXxOw1Cyc1
         kPpEI1T7/0VdeLf4sgp5h1+nzuc0QNCrOTOlhx5waIRRTPq5XgMGfRLqjB3BYuiXPwzb
         40dLXB+AQFSLIqCcnvvzta9ofD5pfdDYjTknMEgwU7r2+4S7BE9Z3q3HipVjcjXzlCQK
         XlzC0N91PLklwmgxDRhQzbDfDcOkKYmYa3fsZgayP3WzA9gLFRBBc//7ldbbs2tWJzn3
         x5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750963378; x=1751568178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfiM5bCuQxjyqjIUXTrhK8ewP3OgmuvSafU7HnQFZn0=;
        b=JYRJl+l/mtY/sbP55HfDrsFfckmx6PsS1vgGtKSUbgLL7rzEQg/aAEz7XXno28m/L5
         FA1Uh5V/Jdg3CbaaUmpsSYhy/RLSjA8aEZFzKmr9ZiTVGKfBS6e/zLaE956zfgbY6Upw
         IYcT/X1Rr9PTtMoMsBCgAlTpPxMkwkXJM9O6bIfIQMhrSNCCMvopzAkNq/x/esGbccj8
         vrCq8w34a8iRv+lKfsiVKbqAa/UpxVv5YzeZg36tcaDu1WouULfEhCwC7JpaTYrqjRZZ
         IUC+hOWzsvPQ+urY32mZops+XKv4N94Xrqt1Y/xHITAiym3iDivmj+VDgVO6Kg0gLTTs
         ZRpw==
X-Forwarded-Encrypted: i=1; AJvYcCXgTldX9GoAusxNRlico0GYnqkxtHXuZDjscPxgOKW5MeZXPlXWTfeIrgAUf1ERmSE47zsfWHpUIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxsO5XrHFpYkAB7UEg6l8mih2nWAP+zZpx5wtFSknB4XQt0YCN
	3JJ08PIc5BITAuozhtKNLjDroS19OOzs/C3eVoamYDfXkd2yYMBJCebr0+dBknyX5isdmiJQzUk
	U7wqruKCHN/4E7uSpXIidWtgbxYnSddQPp9UdMdIm
X-Gm-Gg: ASbGncs1TyIhV0bJa+XHWtcADkCRpXcc7ZkWflZ8WfjwBy1wHkPjiKf65bthgZYnwgd
	QdcPXcIPqp48IoUZVMZsrgZAOjYoEKGSix29iFy4D0ZpXyoZ3ZTnGiuctV0tS8QW05ApACAJHQQ
	1EFqyufh9EfP69VAmzz2uEb0wpocI/XP8/1CId9CDKJY7dlUqvno90PEUcL68bcwQILuL3u+M=
X-Google-Smtp-Source: AGHT+IGqh36l+6kuJJE5CEbGau4VWqBUInbRy4qPuGyWpT5UuwSKGfcIIXyNoBceSS9C3SPgXOrpG+xw3rS8GIwd0mM=
X-Received: by 2002:a05:622a:550e:b0:494:b4dd:befd with SMTP id
 d75a77b69052e-4a7fd83e4bemr439141cf.8.1750963378089; Thu, 26 Jun 2025
 11:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619000925.415528-1-pmalani@google.com> <20250619000925.415528-3-pmalani@google.com>
 <ff65b997-eb14-798f-1d2f-c375bf763e71@hisilicon.com> <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
In-Reply-To: <CAFivqm+hjfDwPJCiHavnZSg2D+OaP5xbQnidmwxQ3HD32ic6EA@mail.gmail.com>
From: Prashant Malani <pmalani@google.com>
Date: Thu, 26 Jun 2025 11:42:45 -0700
X-Gm-Features: Ac12FXxljkUoYaZYMRu3QdS2eFLy6gfKMCxgPpjl4x3N1vnCa5oVFTafnr9GBMA
Message-ID: <CAFivqmKKve8f_i8Po3v3SqQ9tt68yO_qvCyogBbZ7wPE-Y_6Mg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Dont read counters for idle CPUs
To: Jie Zhan <zhanjie9@hisilicon.com>
Cc: Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ionela Voinescu <ionela.voinescu@arm.com>, Beata Michalska <beata.michalska@arm.com>, 
	z00813676 <zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"

(re-sending without HTML)

Hi,

Just a friendly ping on this thread/series. It would be great to get
some feedback from the maintainers/stakeholders here.

Thanks,


On Thu, 19 Jun 2025 at 22:07, Prashant Malani <pmalani@google.com> wrote:
>
> Hi Jie,
>
> Thanks for taking a look at the patch.
>
> On Thu, 19 Jun 2025 at 20:53, Jie Zhan <zhanjie9@hisilicon.com> wrote:
> > On 19/06/2025 08:09, Prashant Malani wrote:
> > > AMU performance counters tend to be inaccurate when measured on idle CPUs.
> > > On an idle CPU which is programmed to 3.4 GHz (verified through firmware),
> > > here is a measurement and calculation of operating frequency:
> > >
> > > t0: ref=899127636, del=3012458473
> > > t1: ref=899129626, del=3012466509
> > > perf=40
> >
> > In this case, the target cpu is mostly idle but not fully idle during the
> > sampling window since the counter grows a little bit.
> > Perhaps some interrupts happen to run on the cpu shortly.
> >
> > Thus, the actual issue is the accuracy of frequency sampling becomes poor
> > when the delta of counters are too small to obtain a reliable accuracy.
> >
> > Would it be more sensible to put a minimum threshold of the delta of
> > counters when sampling the frequency?
>
> I'm happy to throw together a patch if there is some safe
> threshold the experts here can agree on for the minimum delta for
> the ref counter. I would caution that with this sort of approach we
> start running into the familiar issue:
> - What value is appropriate? Too large and you get false
> positives (falling back to the idle invalid path when we shouldn't), and
> too less and you get false negatives (we still report inaccurate
> counter values).
> - Is the threshold the same across platforms?
> - Will it remain the same 5/10 years from now?
>
> >  BTW, that ABI
> > doesn't seem to be synchronous at all, i.e. the cpu might be busy when we
> > check and then become idle when sampling.
> >
>
> I don't think this is necessarily an issue. The ABI doesn't need to be
> synchronous; it is merely a snapshot of the scheduler view of that CPU
> at a point in time. Even the current method of perf counters sampling
> is purely hueristic. The CPU might be idle for the 2 usec the
> sampling is done, and servicing traffic before and after that.
> This is inherent whenever you are sampling any system state.
>
> I would imagine it is more reliable to trust the kernel scheduler's view
> of whether a CPU is idle, than relying on counters and a calculation
> method which are sensitive and unreliable for idle systems
> (i.e stray interrupts can throw off the calculations).
>
> That said, I'm happy to go with the approach folks on this list recommend.
>
> Cheers,
>
> --
> -Prashant



-- 
-Prashant

