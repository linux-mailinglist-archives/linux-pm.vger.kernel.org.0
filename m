Return-Path: <linux-pm+bounces-26912-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E93BCAB09B4
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 07:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 249261C03620
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 05:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3DE267F41;
	Fri,  9 May 2025 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCivhjdW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4525267B9B;
	Fri,  9 May 2025 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746768599; cv=none; b=ganEODzH87725j0RcDBpVRhwoPSPM4dfuVrOaSl8IomIkGneFdQEODGfsEtDo8lE7/nsAz4lPH71DRtlkLpQHy+c733SV6PeWOzGJB7cVQFKk8WG7UH/Z98YpxytiyxHa4g7zqRTLny+T9V/mm6DCbcdtcjudYEGbvd56JJOqyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746768599; c=relaxed/simple;
	bh=KhWQ+jRqzp9ACybx9mX/GMmftROOC+S9oSgLo0fnOBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tueSBhG/BsuK2xeU/HJ1kg4SHJhUOYKeuIU7a5A14Qrn3tUPaAaGKMv4a5DeRNeI25CUb8b0D0GCFs3SGbn+DRhR1OraBrvifikTNb1PfDBWRtuOeSsH5kdmr/H+ddUNYMozCMsSsJlyi5IgDnrA/dvBD204sn1Y5v9yO6NgN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCivhjdW; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c9376c4bddso200754685a.3;
        Thu, 08 May 2025 22:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746768596; x=1747373396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FjiY5A6s1JyFLIfKZGHNec3qZYKZdehnvSKZyBFilw=;
        b=WCivhjdW9PNcYArtFAdXGE9CBq/7Cs5AWQ9u8WBli2UynecbEelv/4HVylv6BIxUZ1
         Ld/q570Km5PxJFYorKZd291wpLfjszxtbT9sC9iuu0yQAb4JOnm5g+ZdhN8fgvI/jHih
         OsKmuVP57E8d0Qe4+sfIb2Iim7xs2omQNoFFEgho1xvISOtagWyeykW+EpPCp+v4AUnR
         O7Vfz0uu6N0gBFJclNySatrXA8s3dLzKip1AvsdoueO2bVOq3YofX/L+C3vbMolYNJmB
         KFMwfzJQt0AY+LDJeUnH9Yxuj5NMA8F24QIYX7TUAZ2F/8x+ShLS/I968gI1lttB9UnU
         R6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746768596; x=1747373396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FjiY5A6s1JyFLIfKZGHNec3qZYKZdehnvSKZyBFilw=;
        b=A7cpA5j/+isYLZXD9ECVjRTAJyDtfvTDvbZt5zqRsLiZdl3GIiJ9P8ult3Je19k6W9
         ldl1LlSRwP3uKlasWvwjc3xJEQvgsedOonJhWNmjKfu9BoPItTZVoE963s30JwV6wjaP
         0c9ErbGWNWj6AprJmA2QqBf9q7VFOyEpTeH57A0O9IYRWhMeGKQLKg9lL7738UZ9kdGL
         asoqra2/bS7G+Q/tqg6GQY5iQkSBMn7BUWKj9EgpaFteQRKDrbMDsZptaVJx67ZLTK9+
         wp6zg0oImf+pgB7XBEJiF+loC8xTWvT8RF3oEAzixv2RMSvyMbPF1/L2N6eoy9j/vI6z
         T+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyBFZfup7Drxq5LXi9MoIgYNJHAmpT7p96lg5w5coaOiXO9GNVfWsjkO67kkh1Hkp7qX9iU8LjzBo=@vger.kernel.org, AJvYcCXNNEmHIuYmwvWMX18/F3j3O58WUS+JndFRSkADuBpAn/LrrMtHiy1Bw859LKxXVZHA/4iH7hJrwOyKD/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/PlnN3dHoFsT9kkzEeRur6BtQtaGvfDuWJRnnNhLq+3q8nqLg
	UlRX+2BceHn8LNJmWoKKIpoe8JE0u2+41tgRJlrmIWILd6gkyzWl
X-Gm-Gg: ASbGnctT83izQgFeOcs3csbhCNTdcj9gcceCk6x21B4wxB9cIBV71AAJDnfPWj9zz+I
	p5cRYDelkMW9aWXRsk9ZPMsmkdB5JI/zRIfLZUREMusT8Nf5llY4X0ZkQRHFZAif/KWziiijtlU
	cfF+Z0l9wM/ULSQRUc5eCES0B9Tv7IKMRc0SeYeYUYZ+gZmmAWj4tQ31g4PR1wH4+B3poV6YRNF
	GlIG5unB011RJ4wt5ce2T69+0J/0AqmrjwEO1Il/gYA2rRB3TvoFQ9YB/4MqYxYHsth1eGdQyPr
	fmrLoMho4qWxyW7ajg5bctMNh0k2ewDdY0w/
X-Google-Smtp-Source: AGHT+IGqKaXBDx7D+415LmvcxrCVps/+1mN6t+Zmb6KW8pkUykVEh5mmk/Wa62mfVviY4+S9vqvHsQ==
X-Received: by 2002:a05:620a:4549:b0:7ca:d9e8:d722 with SMTP id af79cd13be357-7cd010f7058mr286344485a.17.1746768596541;
        Thu, 08 May 2025 22:29:56 -0700 (PDT)
Received: from localhost ([142.186.8.171])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd00f98942sm91970985a.49.2025.05.08.22.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 22:29:56 -0700 (PDT)
Date: Fri, 9 May 2025 01:32:39 -0400
From: Seyediman Seyedarab <imandevel@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3] cpufreq: fix locking order in store_local_boost to
 prevent deadlock
Message-ID: <6nfpd4jvx7dmpl5hqk5nokxprxbcccah66x2mptgwxtyxmb74r@qiosxhaw3tew>
References: <20250430160943.2836-1-ImanDevel@gmail.com>
 <20250502050639.2a4mbdav4mdlhbp2@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502050639.2a4mbdav4mdlhbp2@vireshk-i7>

On 25/05/02 10:36AM, Viresh Kumar wrote:
> On 30-04-25, 12:09, Seyediman Seyedarab wrote:
> > Lockdep reports a possible circular locking dependency[1] when
> > writing to /sys/devices/system/cpu/cpufreq/policyN/boost,
> > triggered by power-profiles-daemon at boot.
> > 
> > store_local_boost() used to acquire cpu_hotplug_lock *after*
> > the policy lock had already been taken by the store() handler.
> > However, the expected locking hierarchy is to acquire
> > cpu_hotplug_lock before the policy guard. This inverted lock order
> > creates a *theoretical* deadlock possibility.
> > 
> > Acquire cpu_hotplug_lock in the store() handler *only* for the
> > local_boost attribute, before entering the policy guard block,
> > and remove the cpus_read_lock/unlock() calls from store_local_boost().
> > Also switch from guard() to scoped_guard() to allow explicitly wrapping
> > the policy guard inside the cpu_hotplug_lock critical section.
> > 
> >  [1]
> >  ======================================================
> >  WARNING: possible circular locking dependency detected
> >  6.15.0-rc4-debug #28 Not tainted
> >  ------------------------------------------------------
> >  power-profiles-/596 is trying to acquire lock:
> >  ffffffffb147e910 (cpu_hotplug_lock){++++}-{0:0}, at: store_local_boost+0x6a/0xd0
> > 
> >  but task is already holding lock:
> >  ffff9eaa48377b80 (&policy->rwsem){++++}-{4:4}, at: store+0x37/0x90
> > 
> >  which lock already depends on the new lock.
> > 
> >  the existing dependency chain (in reverse order) is:
> > 
> >  -> #2 (&policy->rwsem){++++}-{4:4}:
> >         down_write+0x29/0xb0
> >         cpufreq_online+0x841/0xa00
> >         cpufreq_add_dev+0x71/0x80
> >         subsys_interface_register+0x14b/0x170
> >         cpufreq_register_driver+0x154/0x250
> >         amd_pstate_register_driver+0x36/0x70
> >         amd_pstate_init+0x1e7/0x270
> >         do_one_initcall+0x67/0x2c0
> >         kernel_init_freeable+0x230/0x270
> >         kernel_init+0x15/0x130
> >         ret_from_fork+0x2c/0x50
> >         ret_from_fork_asm+0x11/0x20
> > 
> >  -> #1 (subsys mutex#3){+.+.}-{4:4}:
> >         __mutex_lock+0xc2/0x930
> >         subsys_interface_register+0x83/0x170
> >         cpufreq_register_driver+0x154/0x250
> >         amd_pstate_register_driver+0x36/0x70
> >         amd_pstate_init+0x1e7/0x270
> >         do_one_initcall+0x67/0x2c0
> >         kernel_init_freeable+0x230/0x270
> >         kernel_init+0x15/0x130
> >         ret_from_fork+0x2c/0x50
> >         ret_from_fork_asm+0x11/0x20
> > 
> >  -> #0 (cpu_hotplug_lock){++++}-{0:0}:
> >         __lock_acquire+0x1087/0x17e0
> >         lock_acquire.part.0+0x66/0x1b0
> >         cpus_read_lock+0x2a/0xc0
> >         store_local_boost+0x6a/0xd0
> >         store+0x50/0x90
> >         kernfs_fop_write_iter+0x135/0x200
> >         vfs_write+0x2ab/0x540
> >         ksys_write+0x6c/0xe0
> >         do_syscall_64+0xbb/0x1d0
> >         entry_SYSCALL_64_after_hwframe+0x56/0x5e
> > 
> > Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> > ---
> > Changes in v3:
> >  - Rebased over PM tree's linux-next branch
> >  - Added a comment to explain why this piece of code is required
> >  - Switched from guard() to scoped_guard() to allow explicitly wrapping
> >    the policy guard inside the cpu_hotplug_lock critical section.
> > 
> > Changes in v2:
> >  - Restrict cpu_hotplug_lock acquisition to only
> >    the local_boost attribute in store() handler.
> > 
> > Regards,
> > Seyediman
> > 
> >  drivers/cpufreq/cpufreq.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 21fa733a2..b349adbeb 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -622,10 +622,7 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
> >  	if (!policy->boost_supported)
> >  		return -EINVAL;
> >  
> > -	cpus_read_lock();
> >  	ret = policy_set_boost(policy, enable);
> > -	cpus_read_unlock();
> > -
> >  	if (!ret)
> >  		return count;
> >  
> > @@ -1006,16 +1003,28 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
> >  {
> >  	struct cpufreq_policy *policy = to_policy(kobj);
> >  	struct freq_attr *fattr = to_attr(attr);
> > +	int ret = -EBUSY;
> >  
> >  	if (!fattr->store)
> >  		return -EIO;
> >  
> > -	guard(cpufreq_policy_write)(policy);
> > +	/*
> > +	 * store_local_boost() requires cpu_hotplug_lock to be held, and must be
> > +	 * called with that lock acquired *before* taking policy->rwsem to avoid
> > +	 * lock ordering violations.
> > +	 */
> > +	if (fattr == &local_boost)
> > +		cpus_read_lock();
> >  
> > -	if (likely(!policy_is_inactive(policy)))
> > -		return fattr->store(policy, buf, count);
> > +	scoped_guard(cpufreq_policy_write, policy) {
> > +		if (likely(!policy_is_inactive(policy)))
> > +			ret = fattr->store(policy, buf, count);
> > +	}
> >  
> > -	return -EBUSY;
> > +	if (fattr == &local_boost)
> > +		cpus_read_unlock();
> > +
> > +	return ret;
> >  }
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> -- 
> viresh

Hi there,

Just following up to see if there's anything you'd like me to
change or address in the patch before it can move forward.
Please let me know if any updates are needed.

Regards,
Seyediman

