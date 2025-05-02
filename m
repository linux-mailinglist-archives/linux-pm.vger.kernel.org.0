Return-Path: <linux-pm+bounces-26542-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 888B3AA6A0B
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 07:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6704E1BA208B
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 05:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C6E1B3935;
	Fri,  2 May 2025 05:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSnf0PGN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66BD4C8E
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 05:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746162405; cv=none; b=LhJRr8a/RJA8uOQnrxWR9Q7i4gQbbQa4UzGdbwi+MSJUrtxUqUlYgl8gb47cFQHIHhGoO3Imk836XpVpmRs9vR9GQy+cVT6fgzwKtYsJX49rM8sXAOY99SKFfDUYP10q7IRx1H81vYtyP/rv7DhP98eEUusR/kdXT7abc78W5RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746162405; c=relaxed/simple;
	bh=9ZiB3IL38HWldjWT5LqovTTFiCQgbLC+OMOMx6NpS40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qrr8J4OeGnJWyeE1bNEoVdGM6EFz5Fo/IcztzNI/ESW/OAxVZzHSeVCuRAohvCiP1/9LWO8sLGm2eYwp5xfw6TV99xyB+eZmTRVXKA8LnK5ANbAYqTtIfw1qX/UP3SxH3cPNdzCqTt4YE8G4gNz7Dnm/CCv28epZ2pdToJHEDf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YSnf0PGN; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7369ce5d323so1582423b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 01 May 2025 22:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746162402; x=1746767202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/grUUpAeYIKlzRvakzNU+F1AJvJq3WlXjsn/sgH48DI=;
        b=YSnf0PGNskAGFezRtFrPbvSdT93W/5CaykNQb64PKloeleNxW/MAp0CnGQFlvD7khb
         v2+sKSEiYlO1iM5243Ip5BrD14k4BlbSRCR3nMjPo2uXnoUMxh427H0Z00KxfzKc8U1c
         RTNS8dTNoXTZ9UYFpyVZLYVl21JncgF1la47axq0k/ACy42BofqurmaY3aTMDnWm8K0D
         JJYbfBBF6oclNPzyWBVcL5w6ccU/Zg1n8XA+YOLAxnaSZ8lzBmf9cp4wOH+eXBlJhQtp
         bmPGuFPYq+KMlDCP5XneBGSfiR0CMDyvLqZpf3j20cKIHT+oilvszb5r0ZRrSMsMSZsS
         A5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746162402; x=1746767202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/grUUpAeYIKlzRvakzNU+F1AJvJq3WlXjsn/sgH48DI=;
        b=ihLTyKZiRGbi163PcSaEeN7K9LivRkfXYLLXkSmwBOjadqUlxMVivgak3qYsWMyuAQ
         q6loRZnsT8t7EQdpAnNW3ePcXMgex3ckdj94/ZUtcVhWSbBiVvZF7R+RyGWnxR++QKru
         ZKpT/Fu3tnyPWUG7rr744Q1vaSLmkDupvj6aDiUNtiRJDX2/UQqrRr7nPWKuaKVEgCID
         cDMZbScXR4XgpTTd7vifFcXBqpFbDFyxrWolFEof+YiQK0UJinKfTcZ2fS76zEM5A6EU
         BBLb1VkEq3qLGuNGNIeGsBC/L11l+4WR9YPPAsc4E/f4eQPZCfUhMpdwkvXJ5Y7y1KHm
         t73A==
X-Forwarded-Encrypted: i=1; AJvYcCU81HsD+oW1YyuBZ4sx4Itv1lUEK9nKWnxlHtGskme/tjaoauqYE8m0TmLGKH6/vyNgJJyaj0H7qQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YypzgzpsbktCXkWed2iQEPedBCXTiucuxnagB1LAY10ipRmtbwm
	EmChaz+w+NLEt7islGVUtQ1Xk1qm4gMPA9x9hpTpjsu15ohS4wAZXY9XqsAzmqs=
X-Gm-Gg: ASbGncu8S4M7TF9vrztIXvmwrWLieF3ug5BVEP+dqxZ0uA+qly5kFWi1zhqaOqOgq/c
	J6oCcqTLrn6Ni0oTSHEF2uCuLPOuHu2OhRMY42WFqHkBi3hxH00ug1BxfYeiTXxF4BTRexvHU4y
	BRC4y231QxXz+kdSmY8QgMn5IgQkfbI3p+U9i4shm+k+SpiAv5eQDe7TuBvhYHhYLIhOpVJDk5F
	Qg0fb2rMq9eGZv54HlXdWfQVRDgDo8ypL5yE31j8YQ7oYhVgVljqon95DDXLJ25sN+6nV4aVn3f
	EAglzSYS+b+AD1aWYtefKrUZvofJeD+2NBpd2EmMxA==
X-Google-Smtp-Source: AGHT+IEOJiAVSKAjJMccaJnGL2AgSp42k41Qardkh/MDnhjWK4eld/C+RTrDT33wzYWavJoELEolJw==
X-Received: by 2002:a05:6a21:3514:b0:1f5:a577:dd24 with SMTP id adf61e73a8af0-20cdee3f3dcmr2337675637.25.1746162402149;
        Thu, 01 May 2025 22:06:42 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fa85e4e27sm537304a12.60.2025.05.01.22.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 22:06:41 -0700 (PDT)
Date: Fri, 2 May 2025 10:36:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3] cpufreq: fix locking order in store_local_boost to
 prevent deadlock
Message-ID: <20250502050639.2a4mbdav4mdlhbp2@vireshk-i7>
References: <20250430160943.2836-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430160943.2836-1-ImanDevel@gmail.com>

On 30-04-25, 12:09, Seyediman Seyedarab wrote:
> Lockdep reports a possible circular locking dependency[1] when
> writing to /sys/devices/system/cpu/cpufreq/policyN/boost,
> triggered by power-profiles-daemon at boot.
> 
> store_local_boost() used to acquire cpu_hotplug_lock *after*
> the policy lock had already been taken by the store() handler.
> However, the expected locking hierarchy is to acquire
> cpu_hotplug_lock before the policy guard. This inverted lock order
> creates a *theoretical* deadlock possibility.
> 
> Acquire cpu_hotplug_lock in the store() handler *only* for the
> local_boost attribute, before entering the policy guard block,
> and remove the cpus_read_lock/unlock() calls from store_local_boost().
> Also switch from guard() to scoped_guard() to allow explicitly wrapping
> the policy guard inside the cpu_hotplug_lock critical section.
> 
>  [1]
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  6.15.0-rc4-debug #28 Not tainted
>  ------------------------------------------------------
>  power-profiles-/596 is trying to acquire lock:
>  ffffffffb147e910 (cpu_hotplug_lock){++++}-{0:0}, at: store_local_boost+0x6a/0xd0
> 
>  but task is already holding lock:
>  ffff9eaa48377b80 (&policy->rwsem){++++}-{4:4}, at: store+0x37/0x90
> 
>  which lock already depends on the new lock.
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #2 (&policy->rwsem){++++}-{4:4}:
>         down_write+0x29/0xb0
>         cpufreq_online+0x841/0xa00
>         cpufreq_add_dev+0x71/0x80
>         subsys_interface_register+0x14b/0x170
>         cpufreq_register_driver+0x154/0x250
>         amd_pstate_register_driver+0x36/0x70
>         amd_pstate_init+0x1e7/0x270
>         do_one_initcall+0x67/0x2c0
>         kernel_init_freeable+0x230/0x270
>         kernel_init+0x15/0x130
>         ret_from_fork+0x2c/0x50
>         ret_from_fork_asm+0x11/0x20
> 
>  -> #1 (subsys mutex#3){+.+.}-{4:4}:
>         __mutex_lock+0xc2/0x930
>         subsys_interface_register+0x83/0x170
>         cpufreq_register_driver+0x154/0x250
>         amd_pstate_register_driver+0x36/0x70
>         amd_pstate_init+0x1e7/0x270
>         do_one_initcall+0x67/0x2c0
>         kernel_init_freeable+0x230/0x270
>         kernel_init+0x15/0x130
>         ret_from_fork+0x2c/0x50
>         ret_from_fork_asm+0x11/0x20
> 
>  -> #0 (cpu_hotplug_lock){++++}-{0:0}:
>         __lock_acquire+0x1087/0x17e0
>         lock_acquire.part.0+0x66/0x1b0
>         cpus_read_lock+0x2a/0xc0
>         store_local_boost+0x6a/0xd0
>         store+0x50/0x90
>         kernfs_fop_write_iter+0x135/0x200
>         vfs_write+0x2ab/0x540
>         ksys_write+0x6c/0xe0
>         do_syscall_64+0xbb/0x1d0
>         entry_SYSCALL_64_after_hwframe+0x56/0x5e
> 
> Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> ---
> Changes in v3:
>  - Rebased over PM tree's linux-next branch
>  - Added a comment to explain why this piece of code is required
>  - Switched from guard() to scoped_guard() to allow explicitly wrapping
>    the policy guard inside the cpu_hotplug_lock critical section.
> 
> Changes in v2:
>  - Restrict cpu_hotplug_lock acquisition to only
>    the local_boost attribute in store() handler.
> 
> Regards,
> Seyediman
> 
>  drivers/cpufreq/cpufreq.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 21fa733a2..b349adbeb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -622,10 +622,7 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
>  	if (!policy->boost_supported)
>  		return -EINVAL;
>  
> -	cpus_read_lock();
>  	ret = policy_set_boost(policy, enable);
> -	cpus_read_unlock();
> -
>  	if (!ret)
>  		return count;
>  
> @@ -1006,16 +1003,28 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>  {
>  	struct cpufreq_policy *policy = to_policy(kobj);
>  	struct freq_attr *fattr = to_attr(attr);
> +	int ret = -EBUSY;
>  
>  	if (!fattr->store)
>  		return -EIO;
>  
> -	guard(cpufreq_policy_write)(policy);
> +	/*
> +	 * store_local_boost() requires cpu_hotplug_lock to be held, and must be
> +	 * called with that lock acquired *before* taking policy->rwsem to avoid
> +	 * lock ordering violations.
> +	 */
> +	if (fattr == &local_boost)
> +		cpus_read_lock();
>  
> -	if (likely(!policy_is_inactive(policy)))
> -		return fattr->store(policy, buf, count);
> +	scoped_guard(cpufreq_policy_write, policy) {
> +		if (likely(!policy_is_inactive(policy)))
> +			ret = fattr->store(policy, buf, count);
> +	}
>  
> -	return -EBUSY;
> +	if (fattr == &local_boost)
> +		cpus_read_unlock();
> +
> +	return ret;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

