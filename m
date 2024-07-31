Return-Path: <linux-pm+bounces-11727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E409B94240A
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 03:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBB41C20C68
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 01:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62E0539A;
	Wed, 31 Jul 2024 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPfME1Xw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E042F37;
	Wed, 31 Jul 2024 01:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722387959; cv=none; b=hFjDxHWBWAN1pmlY4ziY+YNPGaeBK10FR1vySbt7VI1NdLn3It+G+DNUWmMzYXIpoAUT+VMWg71OTtKvWWZfeN9RS+RaQ+xuo0zdhR4Ts9rn8qTnRLrOmobtS9f2vj8gGffbe/C40Y+rn8JXzOlmFgg1knawNsd0dvcSxAvhH4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722387959; c=relaxed/simple;
	bh=di3rbEeVr0sa9MFEnfNsUReIXLyPPC9C92q/Sp/gq8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0RcZ8Qb83T95bCu/kzGtIci+bGhh+qpb/aAQEczZYrwnBJ8pSdT7D28mbY4jnS54YWdD6jN38teGmeFMnV9goiFLFlU4/JUTgJGTQX9N85RHK4wTjSw+7MP8I7hffEs/pgvkYOBgpprGcjeVyyxHoRNHRGoGvWBsLQraIJ3avs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPfME1Xw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd70ba6a15so37094615ad.0;
        Tue, 30 Jul 2024 18:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722387957; x=1722992757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmWYrFFBXc+W/UjXwhIBzE2u4A4ubZF2p/m+px8209Q=;
        b=gPfME1XwtkdBKvYjMPRx1L1R4hLCRwv7pHoF1eZcAUXz2ySWpxq5KeoFnWYBgaF4H9
         CLVA1Y7Thgf7eBwW7ySDqEJteATs+ZG64vU/o5cgEbkZrToeKtFy88VDlNxosVT5h+e0
         BKWdoGdRzbdv4jIaWLBro+JupuqZ0XCC2SlzVMgS8pSGqm/UD1A+2BGUv38zMT9Eu4jJ
         TheYv0LjlfLAv161/VQVqmYDp4e3zrDCQxaShLcONgRufYrvPsx3N40dWj6VvZlyTVbe
         Bcyp+5B6WCaRLnebK49rOEMUfH0qEBCi6biom1N/1936gMDzuLLwvpci2xKS18VpaRdq
         x3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722387957; x=1722992757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmWYrFFBXc+W/UjXwhIBzE2u4A4ubZF2p/m+px8209Q=;
        b=ljEPKmwYeKVdZXxD8eGGv+7X1is5oN6nto+emqkOLoreOP5QbX6IPDZoeBcrTebeJa
         NV5Lyut5SXO3SebKMY76pn2yDw08nAxeG2RdBGYoSpftRbjuhO6ZzjZyIyG+Wexo8M1o
         oNOMJ0QnQUBu4Tnk30CXFLJ0sj+bW0+4W7bbYUb7wfz16k3EY7sLKCKyxXxWgzhluDQ9
         u5bxF63tweao06Xe3UR8imQXTxCiXONjbYSsAW/AUY9qX89pGnjdt0EeChoQmTXzm6G+
         ETw5h7jbD5Scu29WLHLGL5hBoGClnF3Wj/ZFfV9rEtvTQUW/WsUzHNF9KWVfIrUzkRlj
         n1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCU88qtJsz5rMBNRqeADaXofYn7aqcBmfTISeLoNCsjnOMUbaXXYp8kvBD/yakKuh87s3uTHpFNW6LUi1BEavRl0aPoqSZHM7DvWsUuSlpv3g74FW1g/rlYgntMjiUwEAD2qw8OoC5U=
X-Gm-Message-State: AOJu0YyyHhiFwBRq7tU0mvPLm4JYcqbxCCt+Bd23+hhqSZbL/FKczuKJ
	VAQU1kVBc0MTFbkL7u/0ijS/B6kg34hRZ1w2bPGEiCDXFDIiVUNaXX975A==
X-Google-Smtp-Source: AGHT+IH4D0mZbxlaseFMClzF2hXzRJT5BLHOoE/CoOTOom7BwtP4i5xwc5qsAdaWuU9puxhR5uX/Iw==
X-Received: by 2002:a17:90a:e989:b0:2cf:ce3a:4fef with SMTP id 98e67ed59e1d1-2cfce3a523emr3279752a91.19.1722387957042;
        Tue, 30 Jul 2024 18:05:57 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc46b93fsm52258a91.34.2024.07.30.18.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 18:05:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 30 Jul 2024 15:05:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
	void@manifault.com, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mingo@redhat.com, peterz@infradead.org,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] sched_ext: Add cpuperf support
Message-ID: <ZqmN8w8YofaNY79C@slm.duckdns.org>
References: <20240619031250.2936087-1-tj@kernel.org>
 <20240619031250.2936087-3-tj@kernel.org>
 <20240724234527.6m43t36puktdwn2g@airbuntu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724234527.6m43t36puktdwn2g@airbuntu>

Hello, Qais.

On Thu, Jul 25, 2024 at 12:45:27AM +0100, Qais Yousef wrote:
> On 06/18/24 17:12, Tejun Heo wrote:
> > sched_ext currently does not integrate with schedutil. When schedutil is the
> > governor, frequencies are left unregulated and usually get stuck close to
> > the highest performance level from running RT tasks.
> 
> Have you tried to investigate why is that? By default RT run at max frequency.
> Only way to prevent them from doing that is by using uclamp
> 
> 	https://kernel.org/doc/html/latest/scheduler/sched-util-clamp.html#sched-util-clamp-min-rt-default
> 
> If that's not the cause, then it's likely something else is broken.

Nothing is necessarily broken. SCX just wasn't providing any signal to
schedutil before this patch, so schedutil ends up just going by with the
occasional signals from RT.

...
> What is exactly the problem you're seeing? You shouldn't need to set
> performance directly. Are you trying to fix a problem, or add a new feature?

I'm having a hard time following the question. When active, the BPF
scheduler is the only one who can tell how much each CPU is being used, and
the straightforward to integrate with schedutil is by indicating what the
current CPU utilization level is which is the signal that schedutil takes
from each scheduler class.

> > This gives direct control over CPU performance setting to the BPF scheduler.
> 
> Why would we need to do that?  schedutil is supposed to operate in utilization

Because nobody else knows? No one *can* know. Schedutil is driven by the
utilization signal from the scheduler. Here, the scheduler is implemented in
BPF. Nothing else knows how much workload each CPU is going to get. Note
that the kernel side does not have any meaningful information re. task <->
CPU relationship. That can change on every dispatch. Only the BPF scheduler
itself knows how the CPUs are going to be used.

> signal. Overriding it with custom unknown changes makes it all random governor
> based on what's current bpf sched_ext is loaded? This make bug reports and
> debugging problems a lot harder.

If schedutil is misbehaving while an SCX scheduler is loaded, it's the BPF
scheduler's fault. There isn't much else to it.

> I do hope by the way that loading external scheduler does cause the kernel to
> be tainted. With these random changes, it's hard to know if it is a problem in
> the kernel or with external out of tree entity. Out of tree modules taint the
> kernel, so should loading sched_ext.

Out of tree modules can cause corruptions which can have lasting impacts on
the system even after the module is unloaded. That's why we keep the
persistent taint flags - to remember that the current misbehavior has a
reasonable chance of being impacted by what happened to the system
beforehand. Kernel bugs aside, SCX schedulers shouldn't leave persistent
impacts on the system. In those cases, we usually mark the dumps which SCX
already does.

> It should not cause spurious reports, nor prevent us from changing the code
> without worrying about breaking out of tree code.

Oh yeah, we can and will make compatibility breaking changes. Not
willy-nilly, hopefully.

...
> > +	/*
> > +	 * The heuristics in this function is for the fair class. For SCX, the
> > +	 * performance target comes directly from the BPF scheduler. Let's just
> > +	 * follow it.
> > +	 */
> > +	if (scx_switched_all())
> > +		return false;
> 
> Why do you need to totally override? What problems did you find in current util
> value and what have you done to try to fix it first rather than override it
> completely?

Because it's way cleaner this way. Otherwise, we need to keep calling into
update_blocked_averages() so that the fair class's util metrics can decay
(it often doesn't decay completely due to math inaccuracies but Vincent was
looking at it). When switched_all(), the fair class is not used at all and
keeping calling it to decay the utility metrics to zero seems kinda silly.

...
> > +/**
> > + * scx_bpf_cpuperf_cap - Query the maximum relative capacity of a CPU
> > + * @cpu: CPU of interest
> > + *
> > + * Return the maximum relative capacity of @cpu in relation to the most
> > + * performant CPU in the system. The return value is in the range [1,
> > + * %SCX_CPUPERF_ONE]. See scx_bpf_cpuperf_cur().
> > + */
> > +__bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu)
> > +{
> > +	if (ops_cpu_valid(cpu, NULL))
> > +		return arch_scale_cpu_capacity(cpu);
> > +	else
> > +		return SCX_CPUPERF_ONE;
> > +}
> 
> Hmm. This is tricky. It looks fine, but I worry about changing how we want to
> handle capacities in the future and then being tied down forever with out of
> tree sched_ext not being able to load.
> 
> How are we going to protect against such potential changes? Just make it a NOP?

So, if it's a necessary change, we just break the API and update the
out-of-tree schedulers accordingly. With BPF's CO-RE and supporting
features, we can handle quite a bit of backward compatibility - ie. it's
cumbersome but usually possible to provide BPF-side helpers that allow
updated BPF schedulers to be loaded in both old and new kernels, so it
usually isn't *that* painful.

> A bit hypothetical but so far these are considered internal scheduler details
> that could change anytime with no consequence. With this attaching to this info
> changing them will become a lot harder as there's external dependencies that
> will fail to load or work properly. And what is the regression rule in this
> case?

This is not different from any other BPF hooks and has been discussed many
times. As I wrote before, we don't want to change for no reason but we
definitely can change things if necessary.

> You should make all functions return an error to future proof them against
> suddenly disappearing.

Really, no need to be that draconian.

...
> > +__bpf_kfunc void scx_bpf_cpuperf_set(u32 cpu, u32 perf)
> > +{
> > +	if (unlikely(perf > SCX_CPUPERF_ONE)) {
> > +		scx_ops_error("Invalid cpuperf target %u for CPU %d", perf, cpu);
> > +		return;
> > +	}
> > +
> > +	if (ops_cpu_valid(cpu, NULL)) {
> > +		struct rq *rq = cpu_rq(cpu);
> > +
> > +		rq->scx.cpuperf_target = perf;
> > +
> > +		rcu_read_lock_sched_notrace();
> > +		cpufreq_update_util(cpu_rq(cpu), 0);
> > +		rcu_read_unlock_sched_notrace();
> > +	}
> > +}
> 
> Is the problem that you break how util signal works in sched_ext? Or you want
> the fine control? We expect user application to use uclamp to set their perf
> requirement. And sched_ext should not break util signal, no? If it does and
> there's a good reason for it, then it is not compatible with schedutil, as the
> name indicates it operates on util signal as defined in PELT.
> 
> You can always use min_freq/max_freq in sysfs to force min and max frequencies
> without hacking the governor. I don't advise it though and I'd recommend trying
> to be compatible with schedutil as-is rather than modify it. Consistency is
> a key.

It's not hacking the governor and uclamp should work the same way on top.
The BPF scheduler is the only thing that can tell how and how much a given
CPU is going to be used. There is no way for the kernel to project per-CPU
utilization without asking the BPF scheduler.

Thanks.

-- 
tejun

