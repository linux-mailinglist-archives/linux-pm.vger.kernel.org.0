Return-Path: <linux-pm+bounces-26988-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 434E1AB24C3
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 19:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E4C1BA0055
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B242417C6;
	Sat, 10 May 2025 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkjWxZNz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37201C5F13;
	Sat, 10 May 2025 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746896875; cv=none; b=czuwdc1RQIt+sPXEf9l3CpJmVf3nj31qQ1zcBeQlCCzfeBQCGcu/nMQQqyXvCQ+9r102tkqL/90tWBQUlQKoTha9uvpNw3UwGnIa0DKhgLwhEOnhAvlTN6+w73uqdoLFmyb+lFJfi3qmlqfTJv6Zij7RbPo8YfQQ8cZF8RkciDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746896875; c=relaxed/simple;
	bh=YHdZExlPi8JRaqBx4SwzcjgNQQKrlGLt+p5Cn+/Tt20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/Kh2u7lL88+ZeqJpDLxudY0rrQdpt5HmcFwO5V6TfXwR8mi2fG0pMFINsQ2yAuvqFDvcuX3+M64fZHTvxKJTNfHSLbStfZ8KmeOdmTNNWpn8NWaq9zR5pHCpeApBlsAdlmq6PLDDa4kKhxwhytAcgpwDPRRekd6OCOk2vTLs/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkjWxZNz; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f5365bdbaeso30142676d6.3;
        Sat, 10 May 2025 10:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746896873; x=1747501673; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2yoVnhpnR5W4cCH43dm1CPgOkwqMQqiWPXQzcbBDh/w=;
        b=RkjWxZNzAhc2cL2/jo0DDeHyHjFsULmHy8WZgDQowVgbyfG8HUmpssGuQM7BILOeEr
         ftX9GH8J3fGkOu/RDpORI+N2Yi+pVXNj3x1eJe9vcdKZ8GfkwzHmMKA2FOwH+lrVOhII
         IH8fJR+xxz6c1e7L1HTsriouNzaGquok0guXwJfbIUk4ElJbECRwsOk1Qa8MyRBFYTv4
         smT1CdsBe5wdgdY3F3uUYFc6fk8qUGogxyV+g1cjHdP1ZMK0ogVLGw2wIgBl314qm4Hi
         dTItYYOQ5YQ7+ktyEW9mgokPFOtwLFmnVbuZsXykZ7AZG3SwAg72Ofu28I6wxoEW1Nb8
         K56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746896873; x=1747501673;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yoVnhpnR5W4cCH43dm1CPgOkwqMQqiWPXQzcbBDh/w=;
        b=KP/UWJgDtKl7thRgITy/NJbe7KMzXxan5aliVgcGo8yAJ5UFV6R+3+4H85qiMvVbIy
         fTjub8MBqKdO1DIJ7E0bRg6UHykrA6r8r5gOH7tGtrArh+R+sBOy3UmClYf6JTLvGXEC
         kYuKBEDS66D1iIqrmxfTJ5dsBNpiihDquyMkua7KViqy4RGQ2LWwihmisHRABqRDHAA5
         7mHi2vxZRvfZZKCAkSPtL26To1pI5JFAgC/HWdXZxGcVuGu8pct4ZMYYbz3pdBGINEj7
         Eb2FN8MaPuF1Gw5LC/n6tTh2AEfxkYclR84I6YjY/GOVEzLytkoekSspW9PXsn6jUXsZ
         Wnsg==
X-Forwarded-Encrypted: i=1; AJvYcCWOgELJqw3J30BlF0462WNOr2AiXdAmU9kZpW3gvQQWdi67L6DxJJO1s9GOYIZ/YWExW/R4Ym7IWIw=@vger.kernel.org, AJvYcCWb3cI+zVyCWPZ7yNtpAry9tdR1LlMeDtehEt6Fh2iZtVyH/rgiXNYhZGcavLD7tN4sH+At4RI2nv3bJB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzzqWiufVY7cx6nZ23Sv4M4AyQkNW4wSb2RSOw5ubUeHl391+p
	Ksth82oRepG4qhi/EUsBQernGcQLcAqd7KIh/tACggr/7Kf7JC2E
X-Gm-Gg: ASbGnctKBYOqWL+FuplSRDDpLCCtDHcDYQ5Kx+uxAo4Hnd0p4ZV0XBOvRSG0+lans65
	y6iRdeumFyml1JCLGhe47fGs08Z+DwzZuYGKh6iLifPoKPHkxXt+UFaLfDyXlXSSC7k1C8zOw+M
	rW0buNIhdgQ1E/kFPQfNayaKobzS1Z+AwNCMS8bzpd4izh1yYItuz07EDF078pJZuhD/DlnVlP0
	NguCb/+ZM0kG2rz46BLi5tvZfm3BRSForjJhW/bgy7a7sNkhjYqEPy2NUI5dl7pzSk0Rv/LLYcZ
	lUOIyCaYUSMS32hKmUb1oo+utqtUvfjQOnkWN1y4en0gYVk=
X-Google-Smtp-Source: AGHT+IGCPD1owgssnN8lIRwkXhCvXQPW2XNhujCZDGyUr5ROgJzEY9lthnAog/W9wUHSg3bCTJb4mA==
X-Received: by 2002:a05:6214:5883:b0:6f6:e701:9612 with SMTP id 6a1803df08f44-6f6e7019911mr107331236d6.34.1746896872529;
        Sat, 10 May 2025 10:07:52 -0700 (PDT)
Received: from localhost ([142.186.8.171])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f6e39f47ecsm27622046d6.41.2025.05.10.10.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 10:07:52 -0700 (PDT)
Date: Sat, 10 May 2025 13:10:37 -0400
From: Seyediman Seyedarab <imandevel@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3] cpufreq: fix locking order in store_local_boost to
 prevent deadlock
Message-ID: <ufcvwme2iycbtssrvrbrfbxzfo7jernzeqj45qm6ig3dr2qtud@glza233zaivs>
References: <20250430160943.2836-1-ImanDevel@gmail.com>
 <20250502050639.2a4mbdav4mdlhbp2@vireshk-i7>
 <6nfpd4jvx7dmpl5hqk5nokxprxbcccah66x2mptgwxtyxmb74r@qiosxhaw3tew>
 <CAJZ5v0gf00GoUUraqY75M5G9bxPkJ5WQ30m5tnksVvA=kTnabg@mail.gmail.com>
 <CAJZ5v0hFBAi7dNhQC1DJG1Fg44LaR-j-vsxO5=G8VbDj15Kr5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hFBAi7dNhQC1DJG1Fg44LaR-j-vsxO5=G8VbDj15Kr5Q@mail.gmail.com>

On 25/05/10 01:41PM, Rafael J. Wysocki wrote:
> On Fri, May 9, 2025 at 7:03 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, May 9, 2025 at 7:29 AM Seyediman Seyedarab <imandevel@gmail.com> wrote:
> > >
> > > On 25/05/02 10:36AM, Viresh Kumar wrote:
> > > > On 30-04-25, 12:09, Seyediman Seyedarab wrote:
> > > > > Lockdep reports a possible circular locking dependency[1] when
> > > > > writing to /sys/devices/system/cpu/cpufreq/policyN/boost,
> > > > > triggered by power-profiles-daemon at boot.
> > > > >
> > > > > store_local_boost() used to acquire cpu_hotplug_lock *after*
> > > > > the policy lock had already been taken by the store() handler.
> > > > > However, the expected locking hierarchy is to acquire
> > > > > cpu_hotplug_lock before the policy guard. This inverted lock order
> > > > > creates a *theoretical* deadlock possibility.
> > > > >
> > > > > Acquire cpu_hotplug_lock in the store() handler *only* for the
> > > > > local_boost attribute, before entering the policy guard block,
> > > > > and remove the cpus_read_lock/unlock() calls from store_local_boost().
> > > > > Also switch from guard() to scoped_guard() to allow explicitly wrapping
> > > > > the policy guard inside the cpu_hotplug_lock critical section.
> > > > >
> > > > >  [1]
> > > > >  ======================================================
> > > > >  WARNING: possible circular locking dependency detected
> > > > >  6.15.0-rc4-debug #28 Not tainted
> > > > >  ------------------------------------------------------
> > > > >  power-profiles-/596 is trying to acquire lock:
> > > > >  ffffffffb147e910 (cpu_hotplug_lock){++++}-{0:0}, at: store_local_boost+0x6a/0xd0
> > > > >
> > > > >  but task is already holding lock:
> > > > >  ffff9eaa48377b80 (&policy->rwsem){++++}-{4:4}, at: store+0x37/0x90
> > > > >
> > > > >  which lock already depends on the new lock.
> > > > >
> > > > >  the existing dependency chain (in reverse order) is:
> > > > >
> > > > >  -> #2 (&policy->rwsem){++++}-{4:4}:
> > > > >         down_write+0x29/0xb0
> > > > >         cpufreq_online+0x841/0xa00
> > > > >         cpufreq_add_dev+0x71/0x80
> > > > >         subsys_interface_register+0x14b/0x170
> > > > >         cpufreq_register_driver+0x154/0x250
> > > > >         amd_pstate_register_driver+0x36/0x70
> > > > >         amd_pstate_init+0x1e7/0x270
> > > > >         do_one_initcall+0x67/0x2c0
> > > > >         kernel_init_freeable+0x230/0x270
> > > > >         kernel_init+0x15/0x130
> > > > >         ret_from_fork+0x2c/0x50
> > > > >         ret_from_fork_asm+0x11/0x20
> > > > >
> > > > >  -> #1 (subsys mutex#3){+.+.}-{4:4}:
> > > > >         __mutex_lock+0xc2/0x930
> > > > >         subsys_interface_register+0x83/0x170
> > > > >         cpufreq_register_driver+0x154/0x250
> > > > >         amd_pstate_register_driver+0x36/0x70
> > > > >         amd_pstate_init+0x1e7/0x270
> > > > >         do_one_initcall+0x67/0x2c0
> > > > >         kernel_init_freeable+0x230/0x270
> > > > >         kernel_init+0x15/0x130
> > > > >         ret_from_fork+0x2c/0x50
> > > > >         ret_from_fork_asm+0x11/0x20
> > > > >
> > > > >  -> #0 (cpu_hotplug_lock){++++}-{0:0}:
> > > > >         __lock_acquire+0x1087/0x17e0
> > > > >         lock_acquire.part.0+0x66/0x1b0
> > > > >         cpus_read_lock+0x2a/0xc0
> > > > >         store_local_boost+0x6a/0xd0
> > > > >         store+0x50/0x90
> > > > >         kernfs_fop_write_iter+0x135/0x200
> > > > >         vfs_write+0x2ab/0x540
> > > > >         ksys_write+0x6c/0xe0
> > > > >         do_syscall_64+0xbb/0x1d0
> > > > >         entry_SYSCALL_64_after_hwframe+0x56/0x5e
> > > > >
> > > > > Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> > > > > ---
> > > > > Changes in v3:
> > > > >  - Rebased over PM tree's linux-next branch
> > > > >  - Added a comment to explain why this piece of code is required
> > > > >  - Switched from guard() to scoped_guard() to allow explicitly wrapping
> > > > >    the policy guard inside the cpu_hotplug_lock critical section.
> > > > >
> > > > > Changes in v2:
> > > > >  - Restrict cpu_hotplug_lock acquisition to only
> > > > >    the local_boost attribute in store() handler.
> > > > >
> > > > > Regards,
> > > > > Seyediman
> > > > >
> > > > >  drivers/cpufreq/cpufreq.c | 23 ++++++++++++++++-------
> > > > >  1 file changed, 16 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > > index 21fa733a2..b349adbeb 100644
> > > > > --- a/drivers/cpufreq/cpufreq.c
> > > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > > @@ -622,10 +622,7 @@ static ssize_t store_local_boost(struct cpufreq_policy *policy,
> > > > >     if (!policy->boost_supported)
> > > > >             return -EINVAL;
> > > > >
> > > > > -   cpus_read_lock();
> > > > >     ret = policy_set_boost(policy, enable);
> > > > > -   cpus_read_unlock();
> > > > > -
> > > > >     if (!ret)
> > > > >             return count;
> > > > >
> > > > > @@ -1006,16 +1003,28 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
> > > > >  {
> > > > >     struct cpufreq_policy *policy = to_policy(kobj);
> > > > >     struct freq_attr *fattr = to_attr(attr);
> > > > > +   int ret = -EBUSY;
> > > > >
> > > > >     if (!fattr->store)
> > > > >             return -EIO;
> > > > >
> > > > > -   guard(cpufreq_policy_write)(policy);
> > > > > +   /*
> > > > > +    * store_local_boost() requires cpu_hotplug_lock to be held, and must be
> > > > > +    * called with that lock acquired *before* taking policy->rwsem to avoid
> > > > > +    * lock ordering violations.
> > > > > +    */
> > > > > +   if (fattr == &local_boost)
> > > > > +           cpus_read_lock();
> > > > >
> > > > > -   if (likely(!policy_is_inactive(policy)))
> > > > > -           return fattr->store(policy, buf, count);
> > > > > +   scoped_guard(cpufreq_policy_write, policy) {
> > > > > +           if (likely(!policy_is_inactive(policy)))
> > > > > +                   ret = fattr->store(policy, buf, count);
> > > > > +   }
> > > > >
> > > > > -   return -EBUSY;
> > > > > +   if (fattr == &local_boost)
> > > > > +           cpus_read_unlock();
> > > > > +
> > > > > +   return ret;
> > > > >  }
> > > >
> > > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > >
> > > > --
> > > > viresh
> > >
> > > Hi there,
> > >
> > > Just following up to see if there's anything you'd like me to
> > > change or address in the patch before it can move forward.
> > > Please let me know if any updates are needed.
> >
> > I'm kind of wondering why local_boost needs cpus_read_lock() at all.
> > Holding the policy rwsem blocks CPU online/offline already for this
> > policy.
> >
> > Is that because ->set_boost() may need to synchronize with the other policies?
> 
> IOW, what can go wrong if the cpus_read_lock() locking is dropped from
> there altogether?

I think ->set_boost() being per-policy makes cpus_read_lock()
unnecessary here. Since we already hold the policy lock, any
topology changes involving this policy should be blocked.
And because we're not iterating over all CPUs or policies to
set boost, we don't need to worry about CPU hotplug synchronization
in this case.

Regards,
Seyediman

