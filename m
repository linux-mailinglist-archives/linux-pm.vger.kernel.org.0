Return-Path: <linux-pm+bounces-26984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48187AB23A3
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 13:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F051889AB6
	for <lists+linux-pm@lfdr.de>; Sat, 10 May 2025 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304DD2561D8;
	Sat, 10 May 2025 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLy9V/lw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0533A154BE2;
	Sat, 10 May 2025 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746877302; cv=none; b=UqZOl3SHP5xf+L/tf41ibjNSsYuh7OwDlEpwjq24vrAXIKSPnldbp9Rn/Hf8m7lALPn9tKcRor7bSBOhcGUDCasox5gnoQ+fzZjCZKluL8bgg13dB+qs0+HrplAfQPpDD4Ae+e6oiACZWvP3i8cojORwNuSS6ZrF51MLF0+665Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746877302; c=relaxed/simple;
	bh=kVK/PSoNGqJPH38XY7o5IfZvHp89So8dh+8ziUJtp4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Plhc7TIv8o7gH85Jlir0UoviE3ARP+o1pqOKxEuQZt70o41n4weCTYfSfgOjdITHHs3YBneUq7jR+gA+CE8iZCtUlhSAQmLT06yj/RHVsJC2m4HVwak9v+9hwLfk7NAkH+nK52jnx1c3QHwSof8OtczPShIseoMfH6c8JEcV7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLy9V/lw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4B4C4CEED;
	Sat, 10 May 2025 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746877301;
	bh=kVK/PSoNGqJPH38XY7o5IfZvHp89So8dh+8ziUJtp4w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kLy9V/lwbvaLKIntaqHz+6sd1iun1vE8LcazKFwCuYRF02pPR6/ugneq0TdwQsfpy
	 dhNqrbhDivjCdqmnH4E+Xv0ZlSVpAySMUCwoopEUm1RRQGX25mn7I2KPURLu3zrYOx
	 vxVwqaEW0sFGZvuPpSmeHRYzrTQHIjCufi+uKcz0/9NMYx2HIOlU2teC+st+HYGo2Q
	 OWstNSrnFOkyXUFkPF8GETOkf2jP2+lZZP51i2qm9WJO65cAZa1mS+kJwLCyk4bIyt
	 zKxzSVEPahy0nRMXBLSDd98X5wq2sjfFOSypJKaEzMMVMsKVlqOdX2xGUJvYRGmu3W
	 6xyR25v2S/WsQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-606668f8d51so1889242eaf.0;
        Sat, 10 May 2025 04:41:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtIooPbQ37mZuF73TBpMeLvcYWirY5zVX3bpKuvRQ4ObfjjUEesLOR+h6BySfB2iYOTKUuVZjacX6Rplk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRDQah50fZEIrvAddbncyfspg9HWsEeDYBDTsUPo/J+BZa212M
	gZFCy60e8kWdBFgnTXy8kWPYrSJ+Va38xMmfIJXSU4PSJy65drWEWoJsSLtdWen6exrBDJw5NZG
	u/7KEM+mylcWKY2Xr6vNF+FSSv4E=
X-Google-Smtp-Source: AGHT+IHzMAM8tBLzYw99n/QURfp1IhtztbbMlnCg6t3RSjHv9i9xIWiGdiXFHCu7VCCOvCt0xPfE51Cqza96waPj4PI=
X-Received: by 2002:a05:6820:208c:b0:604:99a6:4e90 with SMTP id
 006d021491bc7-60868ad8738mr3786406eaf.0.1746877300770; Sat, 10 May 2025
 04:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430160943.2836-1-ImanDevel@gmail.com> <20250502050639.2a4mbdav4mdlhbp2@vireshk-i7>
 <6nfpd4jvx7dmpl5hqk5nokxprxbcccah66x2mptgwxtyxmb74r@qiosxhaw3tew> <CAJZ5v0gf00GoUUraqY75M5G9bxPkJ5WQ30m5tnksVvA=kTnabg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gf00GoUUraqY75M5G9bxPkJ5WQ30m5tnksVvA=kTnabg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 10 May 2025 13:41:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hFBAi7dNhQC1DJG1Fg44LaR-j-vsxO5=G8VbDj15Kr5Q@mail.gmail.com>
X-Gm-Features: AX0GCFs8SUyfqBc5iPAdSoZAUvBVB7czX0GEH5ZELjSNTFUj4glAGV0m47t_e2Q
Message-ID: <CAJZ5v0hFBAi7dNhQC1DJG1Fg44LaR-j-vsxO5=G8VbDj15Kr5Q@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: fix locking order in store_local_boost to
 prevent deadlock
To: Seyediman Seyedarab <imandevel@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 7:03=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Fri, May 9, 2025 at 7:29=E2=80=AFAM Seyediman Seyedarab <imandevel@gma=
il.com> wrote:
> >
> > On 25/05/02 10:36AM, Viresh Kumar wrote:
> > > On 30-04-25, 12:09, Seyediman Seyedarab wrote:
> > > > Lockdep reports a possible circular locking dependency[1] when
> > > > writing to /sys/devices/system/cpu/cpufreq/policyN/boost,
> > > > triggered by power-profiles-daemon at boot.
> > > >
> > > > store_local_boost() used to acquire cpu_hotplug_lock *after*
> > > > the policy lock had already been taken by the store() handler.
> > > > However, the expected locking hierarchy is to acquire
> > > > cpu_hotplug_lock before the policy guard. This inverted lock order
> > > > creates a *theoretical* deadlock possibility.
> > > >
> > > > Acquire cpu_hotplug_lock in the store() handler *only* for the
> > > > local_boost attribute, before entering the policy guard block,
> > > > and remove the cpus_read_lock/unlock() calls from store_local_boost=
().
> > > > Also switch from guard() to scoped_guard() to allow explicitly wrap=
ping
> > > > the policy guard inside the cpu_hotplug_lock critical section.
> > > >
> > > >  [1]
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > > >  WARNING: possible circular locking dependency detected
> > > >  6.15.0-rc4-debug #28 Not tainted
> > > >  ------------------------------------------------------
> > > >  power-profiles-/596 is trying to acquire lock:
> > > >  ffffffffb147e910 (cpu_hotplug_lock){++++}-{0:0}, at: store_local_b=
oost+0x6a/0xd0
> > > >
> > > >  but task is already holding lock:
> > > >  ffff9eaa48377b80 (&policy->rwsem){++++}-{4:4}, at: store+0x37/0x90
> > > >
> > > >  which lock already depends on the new lock.
> > > >
> > > >  the existing dependency chain (in reverse order) is:
> > > >
> > > >  -> #2 (&policy->rwsem){++++}-{4:4}:
> > > >         down_write+0x29/0xb0
> > > >         cpufreq_online+0x841/0xa00
> > > >         cpufreq_add_dev+0x71/0x80
> > > >         subsys_interface_register+0x14b/0x170
> > > >         cpufreq_register_driver+0x154/0x250
> > > >         amd_pstate_register_driver+0x36/0x70
> > > >         amd_pstate_init+0x1e7/0x270
> > > >         do_one_initcall+0x67/0x2c0
> > > >         kernel_init_freeable+0x230/0x270
> > > >         kernel_init+0x15/0x130
> > > >         ret_from_fork+0x2c/0x50
> > > >         ret_from_fork_asm+0x11/0x20
> > > >
> > > >  -> #1 (subsys mutex#3){+.+.}-{4:4}:
> > > >         __mutex_lock+0xc2/0x930
> > > >         subsys_interface_register+0x83/0x170
> > > >         cpufreq_register_driver+0x154/0x250
> > > >         amd_pstate_register_driver+0x36/0x70
> > > >         amd_pstate_init+0x1e7/0x270
> > > >         do_one_initcall+0x67/0x2c0
> > > >         kernel_init_freeable+0x230/0x270
> > > >         kernel_init+0x15/0x130
> > > >         ret_from_fork+0x2c/0x50
> > > >         ret_from_fork_asm+0x11/0x20
> > > >
> > > >  -> #0 (cpu_hotplug_lock){++++}-{0:0}:
> > > >         __lock_acquire+0x1087/0x17e0
> > > >         lock_acquire.part.0+0x66/0x1b0
> > > >         cpus_read_lock+0x2a/0xc0
> > > >         store_local_boost+0x6a/0xd0
> > > >         store+0x50/0x90
> > > >         kernfs_fop_write_iter+0x135/0x200
> > > >         vfs_write+0x2ab/0x540
> > > >         ksys_write+0x6c/0xe0
> > > >         do_syscall_64+0xbb/0x1d0
> > > >         entry_SYSCALL_64_after_hwframe+0x56/0x5e
> > > >
> > > > Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> > > > ---
> > > > Changes in v3:
> > > >  - Rebased over PM tree's linux-next branch
> > > >  - Added a comment to explain why this piece of code is required
> > > >  - Switched from guard() to scoped_guard() to allow explicitly wrap=
ping
> > > >    the policy guard inside the cpu_hotplug_lock critical section.
> > > >
> > > > Changes in v2:
> > > >  - Restrict cpu_hotplug_lock acquisition to only
> > > >    the local_boost attribute in store() handler.
> > > >
> > > > Regards,
> > > > Seyediman
> > > >
> > > >  drivers/cpufreq/cpufreq.c | 23 ++++++++++++++++-------
> > > >  1 file changed, 16 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > > index 21fa733a2..b349adbeb 100644
> > > > --- a/drivers/cpufreq/cpufreq.c
> > > > +++ b/drivers/cpufreq/cpufreq.c
> > > > @@ -622,10 +622,7 @@ static ssize_t store_local_boost(struct cpufre=
q_policy *policy,
> > > >     if (!policy->boost_supported)
> > > >             return -EINVAL;
> > > >
> > > > -   cpus_read_lock();
> > > >     ret =3D policy_set_boost(policy, enable);
> > > > -   cpus_read_unlock();
> > > > -
> > > >     if (!ret)
> > > >             return count;
> > > >
> > > > @@ -1006,16 +1003,28 @@ static ssize_t store(struct kobject *kobj, =
struct attribute *attr,
> > > >  {
> > > >     struct cpufreq_policy *policy =3D to_policy(kobj);
> > > >     struct freq_attr *fattr =3D to_attr(attr);
> > > > +   int ret =3D -EBUSY;
> > > >
> > > >     if (!fattr->store)
> > > >             return -EIO;
> > > >
> > > > -   guard(cpufreq_policy_write)(policy);
> > > > +   /*
> > > > +    * store_local_boost() requires cpu_hotplug_lock to be held, an=
d must be
> > > > +    * called with that lock acquired *before* taking policy->rwsem=
 to avoid
> > > > +    * lock ordering violations.
> > > > +    */
> > > > +   if (fattr =3D=3D &local_boost)
> > > > +           cpus_read_lock();
> > > >
> > > > -   if (likely(!policy_is_inactive(policy)))
> > > > -           return fattr->store(policy, buf, count);
> > > > +   scoped_guard(cpufreq_policy_write, policy) {
> > > > +           if (likely(!policy_is_inactive(policy)))
> > > > +                   ret =3D fattr->store(policy, buf, count);
> > > > +   }
> > > >
> > > > -   return -EBUSY;
> > > > +   if (fattr =3D=3D &local_boost)
> > > > +           cpus_read_unlock();
> > > > +
> > > > +   return ret;
> > > >  }
> > >
> > > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >
> > > --
> > > viresh
> >
> > Hi there,
> >
> > Just following up to see if there's anything you'd like me to
> > change or address in the patch before it can move forward.
> > Please let me know if any updates are needed.
>
> I'm kind of wondering why local_boost needs cpus_read_lock() at all.
> Holding the policy rwsem blocks CPU online/offline already for this
> policy.
>
> Is that because ->set_boost() may need to synchronize with the other poli=
cies?

IOW, what can go wrong if the cpus_read_lock() locking is dropped from
there altogether?

