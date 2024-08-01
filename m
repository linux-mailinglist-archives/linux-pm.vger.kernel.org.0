Return-Path: <linux-pm+bounces-11809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33496944B2D
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 14:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CA81C22864
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 12:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6D19F475;
	Thu,  1 Aug 2024 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="BUF1CdTk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1076187FF8
	for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2024 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514980; cv=none; b=aUT9mH2NdS/z/QJNpAMP7B953tOlTdaeuZZEW/8+aYmSlmlNuhDllnKdgy3ntHZu3fjMYm9ANfu1uhgbXD3WblJUgbRuBVSjs3Sccc/8nI+F5IT6ULY6QE1hxUx32NLPmN4B9aapGy7RRlJq1mtVftGFWQQ1xgzeR2+c3QOytvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514980; c=relaxed/simple;
	bh=g5DHu5RJMTLuFdQ44MEmo0o/uTW9ufErsvnXI/72fvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJOi141tzBk5jhGpbgWj61sCZe10yn/24aC6McEaSxJ8QRDTriXC4MNa5GnQ6rvFBQRnfD2u/BxrGyBcCoRxlyIVeG2Yat35eL8glDejBmoe1Rw3bv4zPnjo7PnZ72MUySq05pvR8jz+8lzSKeUHmmP785mACNFkjoOmZv6nHjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=BUF1CdTk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso48116085e9.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2024 05:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1722514977; x=1723119777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RqX8odwP8AmztIj6m+TamXbMYW2RHtH3tk3d8dZAmKA=;
        b=BUF1CdTk93fQQPceWU7u8QDiily4dPM9idD9ftRCr7bPoubkNrhu82skN2JeCkWPSo
         lCXEZQVgqNWWSPVEfNpYSS+O7W5JLfcl87F0GuP05jXeNIP0qR4GaE/9W1B+L7chdwp/
         /Cy3tivtNth1HPdvRxZt6jXkVAZxqWs9wU+fpEN9cnW16g72eg0Zl1sbIMPlg+04V94P
         Be9HIQ0euL4lxl+Pz6Edq3msPPLYb14cQyK7WPZse7/OWoW67r2LTv4rj3cPQp6LEu07
         XQrPXXZtsazcv76tYk765C37a4IsEV7v7dLfJvDPrU/NuzaYX3YTXCdpHCxXf0vMO8M/
         30CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722514977; x=1723119777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqX8odwP8AmztIj6m+TamXbMYW2RHtH3tk3d8dZAmKA=;
        b=ijdk/MFb5cVKNHO+uNLfMHD1rdkBnTnw/4EO0kOlF7rvRUzy3DL4Srg4RWUlAtT7bO
         rBqc2l4316r9CkwM86E+r3lvJdrGaR00kEe8QLbPKG+r9UfbFYeWsUzalwudUVlr8vSY
         0/wHqKDnlQYvKov4q/AjB7WjGnPnhh06vdxqfcbNRtFHM+V7IbewpM3HPbYm/uBUykfD
         YlYbLRp+XaDu93YFyDktMa19WaJEz7aZ8ljKrFh2royg4b/Z4ctIar62mVPWW9YI+DFa
         OVo6IDIQqXabKb+Nj+/I6ZWoBmNav/vmStar7X5w2tDfvSBHEeHFSde7B0z8MsOrGTOd
         Qg+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCsf2ij3guIoHNLnbTXdB7JMFOZTVSIl8BzOx7xBvEhct2rA5Jw3sb0uq3uyBsd+paOG5tHAJhFBKvzQzD9L0wj0D6pWwO19o=
X-Gm-Message-State: AOJu0YyVQaRJyTGOOkiNVHB6piPMUrMQGCNNKt19t9fZRYZQd1vS9gkg
	aL2Zi8R2YdCSuvk/RnPLCYt+S06WznrOpdCUTuxlf2XkLF8mLIA9PY9cS38jH+0=
X-Google-Smtp-Source: AGHT+IGeiC3fh5i9LeMzD5ltOB9+hyMcxT83VGY3ayL1RdjKTYMPQQxqGUDgDPhduntC3Ms8FJGumQ==
X-Received: by 2002:a05:600c:512a:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-428a9bdc8e7mr23716115e9.11.1722514976913;
        Thu, 01 Aug 2024 05:22:56 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282babaa2esm57062665e9.25.2024.08.01.05.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:22:56 -0700 (PDT)
Date: Thu, 1 Aug 2024 13:22:55 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Metin Kaya <metin.kaya@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Hongyan Xia <hongyan.xia2@arm.com>,
	John Stultz <jstultz@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] sched: Consolidate cpufreq updates
Message-ID: <20240801122255.2vtvx3pwqgbcnefq@airbuntu>
References: <20240728184551.42133-1-qyousef@layalina.io>
 <315f8c55-9368-4f2a-81ee-2d7dcb05bc14@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <315f8c55-9368-4f2a-81ee-2d7dcb05bc14@arm.com>

On 07/29/24 17:01, Metin Kaya wrote:
> On 28/07/2024 7:45 pm, Qais Yousef wrote:
> > Improve the interaction with cpufreq governors by making the
> > cpufreq_update_util() calls more intentional.
> 
> [snip]
> 
> > We also ensure to ignore cpufreq udpates for sugov workers at context
> 
> Nit: s/udpates/updates/
> 
> > switch if it was prev task.
> 
> [snip]
> 
> > +static __always_inline void
> > +__update_cpufreq_ctx_switch(struct rq *rq, struct task_struct *prev)
> > +{
> > +#ifdef CONFIG_CPU_FREQ
> > +	if (prev && prev->dl.flags & SCHED_FLAG_SUGOV) {
> > +		/* Sugov just did an update, don't be too aggressive */
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * RT and DL should always send a freq update. But we can do some
> > +	 * simple checks to avoid it when we know it's not necessary.
> > +	 *
> > +	 * iowait_boost will always trigger a freq update too.
> > +	 *
> > +	 * Fair tasks will only trigger an update if the root cfs_rq has
> > +	 * decayed.
> > +	 *
> > +	 * Everything else should do nothing.
> > +	 */
> > +	switch (current->policy) {
> > +	case SCHED_NORMAL:
> > +	case SCHED_BATCH:
> > +	case SCHED_IDLE:
> > +		if (unlikely(current->in_iowait)) {
> > +			cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT | SCHED_CPUFREQ_FORCE_UPDATE);
> > +			return;
> > +		}
> > +
> > +#ifdef CONFIG_SMP
> > +		/*
> > +		 * Send an update if we switched from RT or DL as they tend to
> > +		 * boost the CPU and we are likely able to reduce the freq now.
> > +		 */
> > +		rq->cfs.decayed |= prev && (rt_policy(prev->policy) || dl_policy(prev->policy));
> > +
> > +		if (unlikely(rq->cfs.decayed)) {
> > +			rq->cfs.decayed = false;
> > +			cpufreq_update_util(rq, 0);
> > +			return;
> > +		}
> > +#else
> > +		cpufreq_update_util(rq, 0);
> > +#endif
> > +		return;		/* ! */
> > +	case SCHED_FIFO:
> > +	case SCHED_RR:
> > +		if (prev && rt_policy(prev->policy)) {
> > +#ifdef CONFIG_UCLAMP_TASK
> > +			unsigned long curr_uclamp_min = uclamp_eff_value(current, UCLAMP_MIN);
> > +			unsigned long prev_uclamp_min = uclamp_eff_value(prev, UCLAMP_MIN);
> > +
> > +			if (curr_uclamp_min == prev_uclamp_min)
> > +#endif
> > +				return;
> > +		}
> > +#ifdef CONFIG_SMP
> > +		/* Stopper task masquerades as RT */
> > +		if (unlikely(current->sched_class == &stop_sched_class))
> > +			return;
> > +#endif
> > +		cpufreq_update_util(rq, SCHED_CPUFREQ_FORCE_UPDATE);
> > +		return;		/* ! */
> > +	case SCHED_DEADLINE:
> > +		/*
> > +		 * This is handled at enqueue to avoid breaking DL bandwidth
> > +		 * rules when multiple DL tasks are running on the same CPU.
> > +		 * Deferring till context switch here could mean the bandwidth
> > +		 * calculations would be broken to ensure all the DL tasks meet
> > +		 * their deadlines.
> > +		 */
> > +		return;		/* ! */
> > +	default:
> > +		return;		/* ! */
> > +	}
> 
> Nit: would it be more conventional to replace marked `return` statements
> above with `break`s?

Thanks Metin. I think return and break are both fine here.

> 
> > +#endif
> > +}
> > +
> > +/*
> > + * Call when currently running task had an attribute change that requires
> > + * an immediate cpufreq update.
> > + */
> > +void update_cpufreq_current(struct rq *rq)
> > +{
> > +	__update_cpufreq_ctx_switch(rq, NULL);
> > +}
> > +
> 
> [snip]
> 

