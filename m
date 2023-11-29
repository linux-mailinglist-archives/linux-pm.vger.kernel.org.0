Return-Path: <linux-pm+bounces-508-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DADB87FDA94
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9271F20F85
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E1335268;
	Wed, 29 Nov 2023 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zkxPXLmb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C896130
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:57:20 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28580df78f7so4673220a91.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 06:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269840; x=1701874640; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lBDvY8xfUiRwWpZzeQ9H8DFnchFRqEtZ7Anhmfk/MaE=;
        b=zkxPXLmb23azapQ/eQ8IEBlsSmpL6+lP1nyoU3BCwoybWPAMQFXW56YBSk2mEdgFSC
         5kogP68//JiZLHhPGjE2b3I8TzJReSgFChkxux/sAEjXN7NT+oUoTTXefc4woRyyffcZ
         FqwMIDms+mXepeiTp/pt4k/446zTH9HACbLlViKKk6kaUp1DlIxYpiImRMidgbDIE3oe
         9VWHTOKzpCFrqs09Tt79HEGdDuwiayCh2SSoBEm2xtGx5cf+qUOcJA7i6j/aY1kQfSQe
         7V3vzxYTmyes+aW2NnxY5sffdaQIjkSJcSWjjZTZ2aapeB2wRMhsmdfzlO/GrcaJajK2
         OUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269840; x=1701874640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBDvY8xfUiRwWpZzeQ9H8DFnchFRqEtZ7Anhmfk/MaE=;
        b=Zrd2bcCCTCM2YMguYDzEI/8izKf1t6pjXWXqbhyJuVIGwQk4SsmWdOGMH62pOBoYiL
         mekUr9XPgWhIMAAZ56YB4tH1sXqHNjWXyuxyJ8Vp6wmLAzJS7TvJc76Ol0h1Hz/zapCv
         Cew1vVVFdB65wGwKcSeCnDBPE7sB7Hj+vjr78zqko+/WJ8y7yiGwG/01SgTYQv8GzDHA
         xIXDidXq6P6ahg0mVlzPcIMjSDL3c6o0XhXfVB1iuJzDzUqJ6Y6eq6VFPk6jXpG8euDC
         /t8BEuEd/1a+YXPZFIIhxcsa65J3YT9Lmng/jcMRPkuz0OZu3eoCrf7Cw/XXmVsjEWff
         J2yw==
X-Gm-Message-State: AOJu0YwW8fnsYwvrrBHd2VeIyKgOJxl210b3xBeGrJSIfze7sQI0EzuD
	o+0Ri0Nk0J2ttXvQG91S1OA/y6OABbsOjCfSdmqGYQ==
X-Google-Smtp-Source: AGHT+IEHJzKIugJyAirnHA8jm9ZsrM79uoKWJCmfioIMr8438yJMfCRcgL5l4g9Ssds+KQR6JrFMN1Np/NBF2zPVw/0=
X-Received: by 2002:a17:90b:17c7:b0:285:9b51:64f with SMTP id
 me7-20020a17090b17c700b002859b51064fmr16079874pjb.36.1701269839853; Wed, 29
 Nov 2023 06:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
 <20231109101438.1139696-2-vincent.guittot@linaro.org> <ZWYM0hn28RHjAalh@arm.com>
 <ZWYOg1gIIgI1qXn7@arm.com>
In-Reply-To: <ZWYOg1gIIgI1qXn7@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 29 Nov 2023 15:57:08 +0100
Message-ID: <CAKfTPtA2g-rDPBJkoXpcHrz4vcYAivequkLvWUXgwQpqFcZkOQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] topology: Add a new arch_scale_freq_reference
To: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	sudeep.holla@arm.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com, 
	lukasz.luba@arm.com, pierre.gondois@arm.com, beata.michalska@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, conor.dooley@microchip.com, suagrfillet@gmail.com, 
	ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ionela,

On Tue, 28 Nov 2023 at 17:00, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> On Tuesday 28 Nov 2023 at 15:52:52 (+0000), Ionela Voinescu wrote:
> > Hi Vincent,
> >
> > I have a small request on this patch, which is useful for [1].
> > I'll detail what is needed lower in the code.
> >
> > [1] https://lore.kernel.org/lkml/ZWYDr6JJJzBvsqf0@arm.com/
> >
> > On Thursday 09 Nov 2023 at 11:14:32 (+0100), Vincent Guittot wrote:
> > > @@ -279,13 +278,13 @@ void topology_normalize_cpu_scale(void)
> > >
> > >     capacity_scale = 1;
> > >     for_each_possible_cpu(cpu) {
> > > -           capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
> > > +           capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
> >
> > The only affected code that I could find is here and below.
> >
> > The above line would have to change to:
> > capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu) ?: 1;
> >
> > >             capacity_scale = max(capacity, capacity_scale);
> > >     }
> > >
> > >     pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
> > >     for_each_possible_cpu(cpu) {
> > > -           capacity = raw_capacity[cpu] * per_cpu(freq_factor, cpu);
> > > +           capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
> >
> > and here:
> > capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu) ?: 1;
> >
> > I think it's nicer to start with capacity_freq_ref as 0 and compensate here
> > for uninitialized capacity_freq_ref.
> >
> > Let me know if this is alright of if you'd prefer us to make this change
> > in a separate patch.
> >
> > Thanks,
> > Ionela.
> >
>
> Correction - both will need to be:
> capacity = raw_capacity[cpu] * (per_cpu(capacity_freq_ref, cpu) ?: 1);

Yes, this one is better to keep the same behavior when cpufreq driver
is never loaded

I think this change should come as an additional patch either on top
of this series or directly as part of [1] which is the main user of
the change. I assume that's because you want arch_freq_get_on_cpu()
returns 0 until everything has been initialized

Vincent

>
> Thanks,
> Ionela.

