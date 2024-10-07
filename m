Return-Path: <linux-pm+bounces-15263-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A201B992D8D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 15:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E11D2814E9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C329C1D1F5A;
	Mon,  7 Oct 2024 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6nEbxOf"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD6C7BB15
	for <linux-pm@vger.kernel.org>; Mon,  7 Oct 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308425; cv=none; b=rs7C7tV66vLoWl54YuTY6q2TBKonNNmwzarlfpAUwA4Ekysp92shEEyb24aUucCs0B/ssMapQed6Ksz7EBLzX9hoZevCcLFw38y3ZcdtkX/d6vRoqINDc2QiRHmKbtkgQ0qXcd3aarCmLZBppR9rLTRNzY1Q0p8EZc99C5cNzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308425; c=relaxed/simple;
	bh=KZ+4G1XHEdAZVwy9wafIGNJMH+3fSbVSPqFTCkMSOC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQGzXmtDmYfkrFN8amnV9hxEAWnKZJiRBA8I0XLYGOYfbLzSo371MlSiBb+o1HsZYNwn2QAsGXphvLeguwAOnnoiDHB68fGRGNj+mzaw7FqCoUVTjC6r/Z4JQRSCMPFS/pT4z1RNElsbKSKDVtiRS45WCgN5emJPE+/9hu0UHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6nEbxOf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728308423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9k79RozGYup9n/CkWKBDrupaPsKUfbpXyjWoGdRVkY=;
	b=E6nEbxOfbI1lf4XdVEEoga9B2Nd6ISXAbDQKenn9z0mdvQUQJpPfNt/3fhlbaGJA/qvIYs
	N7cFcidvmVgB1YmmJ2VAfxmc9Ohzl2lFA4mzSzE6F3mNlvKoqbvyRkZYeFMm00AIAsJWHd
	GVK1s7zALN0DqEAp8p4C4suuPibPLSo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-7xV9KWJbPo-esnFIaqU7uA-1; Mon, 07 Oct 2024 09:40:21 -0400
X-MC-Unique: 7xV9KWJbPo-esnFIaqU7uA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cceb06940so35108005e9.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Oct 2024 06:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728308420; x=1728913220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9k79RozGYup9n/CkWKBDrupaPsKUfbpXyjWoGdRVkY=;
        b=WQL3hxcBYbtBTLOeoia/lV2nbZbqGJBv65b4hIyJZTEMd3dfQxhE4R6fH4SIUR21Nl
         d0rly/FehyiT/IoWaloqdBgEbOGF1dV62tMrUkQgN9SNFlU2bji79bgF16rLlSqlX4yL
         O3Rv4wf936lZ7pi4cCM9ep+AfG9B2W8RMCL37RS6EQdo1UEqvRWVjiZ0kWr//P9WOvM5
         2eFCDiRjV4z8BhxmqrfvIzcdbmzWvRtPG210FtVvEQ7WYdG0F1YXKSLdjj4YnLDI+fuU
         ZAxHctM76xfnnQPHGfk/AzCE7D51Is8dnyB78bvvBSYxFLGR/3FFLgH7rhcitXvnYNMc
         oNWw==
X-Forwarded-Encrypted: i=1; AJvYcCWHOCSvX0rGkixByNKJTU2kNbA0ZIsHwGmm8mrrXOYz/pnmIjztdzIsXOG3jPP0FIx1QQPK4XbUrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/qLSHAFGPU/T8aXebGqxojWQIQmExrph9XP2E7iF9U00Kq2E
	qlQDMHQPFFa803lk+s/prEoP3zRl4cwx+6viVbuIoin/ZxGNrhsJIoVe5EP6cm4fbPHR+2H2lBN
	ylkV9EqjQixnO2//n6b+FPW0sS9bqjeTwPI2bzMRLYtk0csXviswixx4B
X-Received: by 2002:a05:600c:198c:b0:42c:bbd5:af70 with SMTP id 5b1f17b1804b1-42f85af8a0cmr84988215e9.30.1728308420553;
        Mon, 07 Oct 2024 06:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw/w093cBDLn/2XCKJ0z8FIs8qVnf8NSEBHPVRXhApXS41TizqFDG05krS8MeHA73VfKq1+g==
X-Received: by 2002:a05:600c:198c:b0:42c:bbd5:af70 with SMTP id 5b1f17b1804b1-42f85af8a0cmr84987955e9.30.1728308420048;
        Mon, 07 Oct 2024 06:40:20 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-206.as13285.net. [80.47.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b4475asm92665885e9.35.2024.10.07.06.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:40:19 -0700 (PDT)
Date: Mon, 7 Oct 2024 14:40:17 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Qais Yousef <qyousef@layalina.io>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCHv2] cpufreq/schedutil: Only bind threads if needed
Message-ID: <ZwPkwaRPKrDtZFZQ@jlelli-thinkpadt14gen4.remote.csb>
References: <a4a70646-98a4-4b85-955e-62d66ba68927@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a70646-98a4-4b85-955e-62d66ba68927@arm.com>

Hi,

On 27/09/24 09:59, Christian Loehle wrote:
> Remove the unconditional binding of sugov kthreads to the affected CPUs
> if the cpufreq driver indicates that updates can happen from any CPU.
> This allows userspace to set affinities to either save power (waking up
> bigger CPUs on HMP can be expensive) or increasing performance (by
> letting the utilized CPUs run without preemption of the sugov kthread).
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
> - v2: Add comment for the dl_task_check_affinity return (Juri)
> v1: https://lore.kernel.org/lkml/480f2140-ea59-4e1d-a68d-18cbcec10941@arm.com/
> 
>  kernel/sched/cpufreq_schedutil.c | 6 +++++-
>  kernel/sched/syscalls.c          | 7 +++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index c6ba15388ea7..10faab849a3e 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -691,7 +691,11 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>  	}
>  
>  	sg_policy->thread = thread;
> -	kthread_bind_mask(thread, policy->related_cpus);
> +	if (policy->dvfs_possible_from_any_cpu)
> +		set_cpus_allowed_ptr(thread, policy->related_cpus);
> +	else
> +		kthread_bind_mask(thread, policy->related_cpus);
> +
>  	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
>  	mutex_init(&sg_policy->work_lock);
>  
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index aa70beee9895..2ef1cb8626bc 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -1172,6 +1172,13 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
>  	if (!task_has_dl_policy(p) || !dl_bandwidth_enabled())
>  		return 0;
>  
> +	/*
> +	 * The special/sugov task isn't part of regular bandwidth/admission
> +	 * control so let userspace change affinities.
> +	 */
> +	if (dl_entity_is_special(&p->dl))
> +		return 0;
> +
>  	/*
>  	 * Since bandwidth control happens on root_domain basis,
>  	 * if admission test is enabled, we only admit -deadline

For the DEADLINE related bits,

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


