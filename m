Return-Path: <linux-pm+bounces-8497-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74EE8D728C
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jun 2024 00:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C531C20C19
	for <lists+linux-pm@lfdr.de>; Sat,  1 Jun 2024 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611512BD1E;
	Sat,  1 Jun 2024 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="bHaksFIh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD601F5E6
	for <linux-pm@vger.kernel.org>; Sat,  1 Jun 2024 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717281622; cv=none; b=XSKjmRDub8DhtmGHCjakMhiGWw0rbWgCp4eUvGjVTX4xkMa7h2oxd0/M6xC01v84olJWPIFuXp0T56p6U39otWH6Z81CPnPCZ7G7FS8l3SOZvHjy4bYRpqRPx36CWS9ZXOWyMRRFG7t5n9JEoT3e67XNI15oCQ4ZQpYIgJYq0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717281622; c=relaxed/simple;
	bh=W2C84SLg0Pn4h2sxtZ6Q8X6xsLLM2bE6McGd4h8wP2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMFZCfalMZYdv0pwxjft8Nt2Xk/5Z5efF+jQMcbDY0SVv/dwd1LHP63ifaBQtJCCQRGzc+3PicAOP2ECxLeqkRcBK9xOP6de96p2sacmbCFrj2/BnEH+CsJRGAwLhNbH+wM24nJttgO8Gd58zR8ugVAWLmBeTXOHO+5vBsUlyaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=bHaksFIh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4212e899814so16279335e9.1
        for <linux-pm@vger.kernel.org>; Sat, 01 Jun 2024 15:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717281619; x=1717886419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DW54dtexIyCzuXyNF0cUY9kxjBpfAJ8MrU77GRtz9rI=;
        b=bHaksFIhBOO/HPJmsnNIokQtNY9rZa2xGu6cjkwPEIa/2M8CP74RsFmL80QOo2msAv
         IlCx58v3k2Q4dpvFGmUpj0mFKzrN9LCje+Y7zsstlvKHWH5jl6ATQiFSOXsiT4cCJJkO
         TNQoPHEd1OcWX9BGxkF+9kvBxWednhhT/010EhYG/LpV/Mq7ExN+bterbHDqmSyObUsk
         D609MRGO8vd2NyWWKicK7dme8RQCBnKiWrsYVlOQBd1zfgKNfopP9Nz/fbR+ch1PhXNQ
         Z6MZUoRmocwnlCD65yi1vhN8VjCczSb8dwG2M7XMWHPUeyEYXsByrq8OtRydlOsNAi+5
         DENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717281619; x=1717886419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DW54dtexIyCzuXyNF0cUY9kxjBpfAJ8MrU77GRtz9rI=;
        b=FtGsIII1kvVi8cJz6Z5VXkDj5MgoJFw3XjryuV0IAo+J9QO8Bld4YimmcMXBT+hXuK
         g5kt5UcRXh7VOCgpEqmdlFdDuTEEJPDbIhllR2ACKZuAsd6W2KalqpmC+4gYcQo/ClWu
         YsyvhEQed1Kc/9/aUUKt6+SpAW1kP1NSzY3tcuDJbbHtzv7YQUP9gtNtW0xI+i/gU2UM
         J3UmR2CbdVHdvN+MdmknxakjZjZpzFj7Pe71G8mEECT58F2R2n+ljeT6GcWe9qP5Dgne
         tTt4+6g/bWQB6AjbdZLClOiZg6YKskOmQivdsfR1NMDmP+m8Hty+/NoIAaEBZN24NwZD
         jXdw==
X-Forwarded-Encrypted: i=1; AJvYcCUngNW8nOKEVSbWqxKWVIpYy4N/pYenTKT1iC1aLX1vE/WM9oEltqykLDMtjjTFVYs2yO8NrYRAIdvGytP/+/QfeiRfGOlSJ9A=
X-Gm-Message-State: AOJu0YzTFrWmPcAhO0ezim7FikqwDi8mqroXTDPtTxN0S9hoINggommL
	PcAWtZz0QSrPMyrV1nfvWG2MHgRx3+oEpifSElBc74OOyksbYI7JKocixbgPAXs=
X-Google-Smtp-Source: AGHT+IH0tU6JP0VtcTkbX56KtUiGoj9Mxrg3pH2DYMlhPGEKUkeAZcSECAlOU3L0XP49igIoLrob/A==
X-Received: by 2002:a05:600c:5113:b0:420:1585:7a99 with SMTP id 5b1f17b1804b1-4212e0bda0fmr43418625e9.38.1717281618721;
        Sat, 01 Jun 2024 15:40:18 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42127069305sm95128755e9.22.2024.06.01.15.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 15:40:18 -0700 (PDT)
Date: Sat, 1 Jun 2024 23:40:17 +0100
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] sched: Consolidate cpufreq updates
Message-ID: <20240601224017.qku2mhbaz4vsh3a3@airbuntu>
References: <20240530104653.1234004-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530104653.1234004-1-qyousef@layalina.io>

On 05/30/24 11:46, Qais Yousef wrote:

> +static __always_inline void
> +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> +{

I found a problem here. We should check if prev was sugov task. I hit a
corner case where we were constantly switching between RT task and sugov.

	if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
		/* Sugov just did an update, don't be too aggressive */
		return;
	}

> +#ifdef CONFIG_CPU_FREQ
> +	/*
> +	 * RT and DL should always send a freq update. But we can do some
> +	 * simple checks to avoid it when we know it's not necessary.
> +	 *
> +	 * iowait_boost will always trigger a freq update too.
> +	 *
> +	 * Fair tasks will only trigger an update if the root cfs_rq has
> +	 * decayed.
> +	 *
> +	 * Everything else should do nothing.
> +	 */
> +	switch (current->policy) {
> +	case SCHED_NORMAL:
> +	case SCHED_BATCH:
> +		if (unlikely(current->in_iowait)) {
> +			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
> +			return;
> +		}
> +
> +#ifdef CONFIG_SMP
> +		if (unlikely(rq->cfs.decayed)) {
> +			rq->cfs.decayed = false;
> +			cpufreq_update_util(rq, 0);
> +			return;
> +		}
> +#endif
> +		return;
> +	case SCHED_FIFO:
> +	case SCHED_RR:
> +		if (prev && rt_policy(prev->policy)) {
> +#ifdef CONFIG_UCLAMP_TASK
> +			unsigned long curr_uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
> +			unsigned long prev_uclamp_min = uclamp_eff_value(prev, UCLAMP_MIN);
> +
> +			if (curr_uclamp_min == prev_uclamp_min)
> +#endif
> +				return;
> +		}
> +#ifdef CONFIG_SMP
> +		/* Stopper task masquerades as RT */
> +		if (unlikely(current->sched_class == &stop_sched_class))
> +			return;
> +#endif
> +		cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
> +		return;
> +	case SCHED_DEADLINE:
> +		if (current->dl.flags & SCHED_FLAG_SUGOV) {
> +			/* Ignore sugov kthreads, they're responding to our requests */
> +			return;
> +		}
> +		cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
> +		return;
> +	default:
> +		return;
> +	}
> +#endif
> +}

