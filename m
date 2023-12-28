Return-Path: <linux-pm+bounces-1654-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A58D81FA66
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 18:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F291F22941
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 17:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F36F514;
	Thu, 28 Dec 2023 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="qBrGohN7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD980F9D1
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d5f40ce04so14682475e9.2
        for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 09:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1703785533; x=1704390333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t17zhnvUZMrwPe4M90D7rizbLoQ1mPsaQ/6pYkn8TPU=;
        b=qBrGohN71R+JQBJd22bnE4v8kJEYC5En0f8Pfn/rYOszoo9nOohLIXOaD50SS6RFAP
         MxMtDGBXDEQT48PcLzmuFp1lyT3J1kjdjvW7u/KVyHYwj6/RDK10Ys54RipesWkdYuS0
         KzEzNwE3RLwEczHjoyc3kzEserb090ehsL+Dr/SYGM/33aB1RQ9huJgszbwhvcZobRmn
         iClEsUo3oi2gULgWWFcWcVNxYx4P+Ebfm6ISNsW8PoEXTEsULB6b7Xm/ALg8oi6w5+mz
         oXbnZ9unNnznVeHLQ3J/3bO5QRWRGnDvkA2WTBNAMgMaogC8QAlfemuB5xXuSg3E/FhD
         ILlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703785533; x=1704390333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t17zhnvUZMrwPe4M90D7rizbLoQ1mPsaQ/6pYkn8TPU=;
        b=H9wWJsVZDnK9iSY5rUF9IbaADDzTl1G2GWfxQTs80D3GSnP00H9j/Q0DmZAYyJS55f
         /Rm4t3PQX+Mn6BSanO8wZyO5tlH8cBld+jw2CqeOY5JTG1yLlMMNIvM9jDNqui6H6qtI
         f6lgTKk78E06zDB0LNWUbfSh3v6xs0Tj2zXLJS87MdXRBHv1/Zr62yOoN+y2RT3owX6y
         V8pozjKH4E4ixDF83NeN2m4flC5RKDhg0TYYUuZDqPlv0PukOJHdPbOmKbNxOrtLedd9
         MDOE5bzzFYJMqx0hTOKR6pWcOcBa4U0L45rxQj3YyLY11mt3iNvGoWjbdOTxh8IOJ1Cl
         3JiA==
X-Gm-Message-State: AOJu0YwtV4MOTxhVpRzW+nRV8NENro5NymXsEOh2NOJIYTPwZaR4bDvl
	GdBs4DoNe1vzJa7+fLQfWqIFuJVTYbX17A==
X-Google-Smtp-Source: AGHT+IFll7vT6kM9borH5xvYjMHoCPQmIe/6bYQfqRFdoeP0QrW+l0VDdEWLy2iioeMbz2VHA3QEdA==
X-Received: by 2002:a05:600c:19c8:b0:40d:5f64:3498 with SMTP id u8-20020a05600c19c800b0040d5f643498mr1297942wmq.59.1703785532897;
        Thu, 28 Dec 2023 09:45:32 -0800 (PST)
Received: from airbuntu (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id q11-20020a05600c46cb00b0040d2d33312csm28200226wmo.2.2023.12.28.09.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 09:45:32 -0800 (PST)
Date: Thu, 28 Dec 2023 17:45:31 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 13/23] PM: EM: Add performance field to struct
 em_perf_state
Message-ID: <20231228174531.zackmuqatd5c2mup@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-14-lukasz.luba@arm.com>
 <20231217180016.wkkatrjuanuk5x52@airbuntu>
 <315089c4-7a22-4661-8581-2d052c25e158@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <315089c4-7a22-4661-8581-2d052c25e158@arm.com>

On 12/20/23 08:21, Lukasz Luba wrote:
> 
> 
> On 12/17/23 18:00, Qais Yousef wrote:
> > On 11/29/23 11:08, Lukasz Luba wrote:
> > > The performance doesn't scale linearly with the frequency. Also, it may
> > > be different in different workloads. Some CPUs are designed to be
> > > particularly good at some applications e.g. images or video processing
> > > and other CPUs in different. When those different types of CPUs are
> > > combined in one SoC they should be properly modeled to get max of the HW
> > > in Energy Aware Scheduler (EAS). The Energy Model (EM) provides the
> > > power vs. performance curves to the EAS, but assumes the CPUs capacity
> > > is fixed and scales linearly with the frequency. This patch allows to
> > > adjust the curve on the 'performance' axis as well.
> > > 
> > > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > > ---
> > >   include/linux/energy_model.h | 11 ++++++-----
> > >   kernel/power/energy_model.c  | 27 +++++++++++++++++++++++++++
> > >   2 files changed, 33 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> > > index ae3ccc8b9f44..e30750500b10 100644
> > > --- a/include/linux/energy_model.h
> > > +++ b/include/linux/energy_model.h
> > > @@ -13,6 +13,7 @@
> > >   /**
> > >    * struct em_perf_state - Performance state of a performance domain
> > > + * @performance:	Non-linear CPU performance at a given frequency
> > >    * @frequency:	The frequency in KHz, for consistency with CPUFreq
> > >    * @power:	The power consumed at this level (by 1 CPU or by a registered
> > >    *		device). It can be a total power: static and dynamic.
> > > @@ -21,6 +22,7 @@
> > >    * @flags:	see "em_perf_state flags" description below.
> > >    */
> > >   struct em_perf_state {
> > > +	unsigned long performance;
> > >   	unsigned long frequency;
> > >   	unsigned long power;
> > >   	unsigned long cost;
> > > @@ -207,14 +209,14 @@ void em_free_table(struct em_perf_table __rcu *table);
> > >    */
> > >   static inline int
> > >   em_pd_get_efficient_state(struct em_perf_state *table, int nr_perf_states,
> > > -			  unsigned long freq, unsigned long pd_flags)
> > > +			  unsigned long max_util, unsigned long pd_flags)
> > >   {
> > >   	struct em_perf_state *ps;
> > >   	int i;
> > >   	for (i = 0; i < nr_perf_states; i++) {
> > >   		ps = &table[i];
> > > -		if (ps->frequency >= freq) {
> > > +		if (ps->performance >= max_util) {
> > >   			if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
> > >   			    ps->flags & EM_PERF_STATE_INEFFICIENT)
> > >   				continue;
> > > @@ -246,8 +248,8 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> > >   				unsigned long allowed_cpu_cap)
> > >   {
> > >   	struct em_perf_table *runtime_table;
> > > -	unsigned long freq, scale_cpu;
> > >   	struct em_perf_state *ps;
> > > +	unsigned long scale_cpu;
> > >   	int cpu, i;
> > >   	if (!sum_util)
> > > @@ -274,14 +276,13 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
> > >   	max_util = map_util_perf(max_util);
> > >   	max_util = min(max_util, allowed_cpu_cap);
> > > -	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
> > >   	/*
> > >   	 * Find the lowest performance state of the Energy Model above the
> > >   	 * requested frequency.
> > >   	 */
> > >   	i = em_pd_get_efficient_state(runtime_table->state, pd->nr_perf_states,
> > > -				      freq, pd->flags);
> > > +				      max_util, pd->flags);
> > >   	ps = &runtime_table->state[i];
> > >   	/*
> > > diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> > > index 614891fde8df..b5016afe6a19 100644
> > > --- a/kernel/power/energy_model.c
> > > +++ b/kernel/power/energy_model.c
> > > @@ -46,6 +46,7 @@ static void em_debug_create_ps(struct em_perf_state *ps, struct dentry *pd)
> > >   	debugfs_create_ulong("frequency", 0444, d, &ps->frequency);
> > >   	debugfs_create_ulong("power", 0444, d, &ps->power);
> > >   	debugfs_create_ulong("cost", 0444, d, &ps->cost);
> > > +	debugfs_create_ulong("performance", 0444, d, &ps->performance);
> > >   	debugfs_create_ulong("inefficient", 0444, d, &ps->flags);
> > >   }
> > > @@ -171,6 +172,30 @@ em_allocate_table(struct em_perf_domain *pd)
> > >   	return table;
> > >   }
> > > +static void em_init_performance(struct device *dev, struct em_perf_domain *pd,
> > > +				struct em_perf_state *table, int nr_states)
> > > +{
> > > +	u64 fmax, max_cap;
> > > +	int i, cpu;
> > > +
> > > +	/* This is needed only for CPUs and EAS skip other devices */
> > > +	if (!_is_cpu_device(dev))
> > > +		return;
> > > +
> > > +	cpu = cpumask_first(em_span_cpus(pd));
> > > +
> > > +	/*
> > > +	 * Calculate the performance value for each frequency with
> > > +	 * linear relationship. The final CPU capacity might not be ready at
> > > +	 * boot time, but the EM will be updated a bit later with correct one.
> > > +	 */
> > > +	fmax = (u64) table[nr_states - 1].frequency;
> > > +	max_cap = (u64) arch_scale_cpu_capacity(cpu);
> > > +	for (i = 0; i < nr_states; i++)
> > > +		table[i].performance = div64_u64(max_cap * table[i].frequency,
> > > +						 fmax);
> > 
> > Should we sanity check the returned performance value is correct in case we got
> > passed a malformed table? Maybe the table is sanity checked and sorted before
> > we get here; I didn't check to be honest.
> 
> The frequency values are checked if they have asc sorting order. It's
> done in the em_create_perf_table(). There is even an error printed and
> returned, so the EM registration will fail.
> 
> > 
> > I think a warning that performance is always <= max_cap would be helpful in
> > general as code evolved in the future.
> 
> I don't see that need. There are needed checks for frequency values and
> this simple math formula is just linear. Nothing can happen when
> frequencies are sorted asc. The whole EAS relies on that fact:
> 
> Frequencies are sorted ascending, thus
> fmax = (u64) table[nr_states - 1].frequency
> is always true.

I saw that but wasn't sure if this is always guaranteed. It seems it is from
you're saying, then yes no issues here then.

