Return-Path: <linux-pm+bounces-26971-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 464FAAB1B30
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 19:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3897189C2DE
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CC823026D;
	Fri,  9 May 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGESCjhp"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCD1228CB0;
	Fri,  9 May 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810241; cv=none; b=i8VoJSZNmQyvMj16AXrxGqRt86f1HY31ALDhb+ZLpU79tDa7JHnYU8nSsI1jQfjy+xUWg2rE3b+DL3ifkTZhl9BwUxSicYCgl+N8rKRffVgCKE18HFYs7n5F6tMRxnEIMU1SaTFE25j+DxUg9Dw/x1FC1yOiFJjJ41iG0H8pveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810241; c=relaxed/simple;
	bh=cxOuPrTubtaM2OWU2dmQeoVyLD36Fn4cYNvgvQMHmWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPgOmJrfc5xLF5g9DgEMvslo4i6lGY/vzeYoRE/kDGX4fIAUpgTqWcVjE5v6DXGAyYPfPl0E7cimv/+YW3iabjd7EnXPH693MpDriXWrettFwjFTOy7+NoQRJcY2a83XOKKUrk+xHKddYZWjXfJtjDpJNzWnI7whTyn8MwFa9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGESCjhp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363A9C4CEE4;
	Fri,  9 May 2025 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746810241;
	bh=cxOuPrTubtaM2OWU2dmQeoVyLD36Fn4cYNvgvQMHmWU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cGESCjhphBC1HXCg4XvWaInawGSQdzvW3Lxes/DTenTv97ppIGUfrNfxYbEE8tDID
	 q/D4dg6of2DY9B1m6jNhqgnJvD3vs4ww1filylZzgCpYJSGHUds8NH8d3eX3egu8FT
	 R8QSYcKGVFgt/z1IeKqIg7WKaPVKDhPC8Oq+xgQekTZI1Oxo8C8C9mq1RDTNdxwSh2
	 T6BygRm1I6QFVp8zu2k3CkNfTHq2TmyllzFOOUhrggviTctialBRM0wCOjqA9vvuBw
	 g3Lp5LF22AzoxkzzNm6nNYcSIqpxY942FPNw2+sYEyybqdbedZxPIQYZ02zI5qfYgl
	 UrMkgjpQTvr5w==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-601b6146b9cso1265744eaf.0;
        Fri, 09 May 2025 10:04:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcMR7ULu6O+tiTzg2/KzntkJVrfI2xgbGXugLGT7RuxFeRYW6QdNmKFf420v7oKecE69RM0gnsomOHLbs=@vger.kernel.org, AJvYcCW+ZCrAqiDcWxF4Odqa67oPfmccaYmSBVU4qdGMND9iUCYm8uaR64lilSJxvntdw1C/cNRF8UtyKT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3S/X1E0bTRNceRxeOj9/ydJMRP3EDZQ7VLcCdZpGM/70NnLx
	4qqeDLpUQLKaIGXm8IOEux83zrKh2+Q9jGptGwT/tcNn45jUwA1UbEbAxIubQqDq3A65rOgzFz1
	UwwIeY4XioA3RpaYqBZjTnobLMyo=
X-Google-Smtp-Source: AGHT+IEuJ3UyJU2Ke571Dvw0ehpoP2qMb7YoHey7MtgBT4f3jUmYaxRmXBS6WsvDgsKz3hRnlqfMZOwu30053cxbSkk=
X-Received: by 2002:a05:6820:1e16:b0:606:107a:ebd8 with SMTP id
 006d021491bc7-6084b64f985mr2203296eaf.5.1746810240473; Fri, 09 May 2025
 10:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430160943.2836-1-ImanDevel@gmail.com> <20250502050639.2a4mbdav4mdlhbp2@vireshk-i7>
 <6nfpd4jvx7dmpl5hqk5nokxprxbcccah66x2mptgwxtyxmb74r@qiosxhaw3tew>
In-Reply-To: <6nfpd4jvx7dmpl5hqk5nokxprxbcccah66x2mptgwxtyxmb74r@qiosxhaw3tew>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 19:03:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gf00GoUUraqY75M5G9bxPkJ5WQ30m5tnksVvA=kTnabg@mail.gmail.com>
X-Gm-Features: ATxdqUF9bTxyJDcbykjFd9xwRiJOtL6Pu5qGcvVG2O320-Jmf9UpGQ-n4HiL_Ys
Message-ID: <CAJZ5v0gf00GoUUraqY75M5G9bxPkJ5WQ30m5tnksVvA=kTnabg@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: fix locking order in store_local_boost to
 prevent deadlock
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 7:29=E2=80=AFAM Seyediman Seyedarab <imandevel@gmail=
.com> wrote:
>
> On 25/05/02 10:36AM, Viresh Kumar wrote:
> > On 30-04-25, 12:09, Seyediman Seyedarab wrote:
> > > Lockdep reports a possible circular locking dependency[1] when
> > > writing to /sys/devices/system/cpu/cpufreq/policyN/boost,
> > > triggered by power-profiles-daemon at boot.
> > >
> > > store_local_boost() used to acquire cpu_hotplug_lock *after*
> > > the policy lock had already been taken by the store() handler.
> > > However, the expected locking hierarchy is to acquire
> > > cpu_hotplug_lock before the policy guard. This inverted lock order
> > > creates a *theoretical* deadlock possibility.
> > >
> > > Acquire cpu_hotplug_lock in the store() handler *only* for the
> > > local_boost attribute, before entering the policy guard block,
> > > and remove the cpus_read_lock/unlock() calls from store_local_boost()=
.
> > > Also switch from guard() to scoped_guard() to allow explicitly wrappi=
ng
> > > the policy guard inside the cpu_hotplug_lock critical section.
> > >
> > >  [1]
> > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > >  WARNING: possible circular locking dependency detected
> > >  6.15.0-rc4-debug #28 Not tainted
> > >  ------------------------------------------------------
> > >  power-profiles-/596 is trying to acquire lock:
> > >  ffffffffb147e910 (cpu_hotplug_lock){++++}-{0:0}, at: store_local_boo=
st+0x6a/0xd0
> > >
> > >  but task is already holding lock:
> > >  ffff9eaa48377b80 (&policy->rwsem){++++}-{4:4}, at: store+0x37/0x90
> > >
> > >  which lock already depends on the new lock.
> > >
> > >  the existing dependency chain (in reverse order) is:
> > >
> > >  -> #2 (&policy->rwsem){++++}-{4:4}:
> > >         down_write+0x29/0xb0
> > >         cpufreq_online+0x841/0xa00
> > >         cpufreq_add_dev+0x71/0x80
> > >         subsys_interface_register+0x14b/0x170
> > >         cpufreq_register_driver+0x154/0x250
> > >         amd_pstate_register_driver+0x36/0x70
> > >         amd_pstate_init+0x1e7/0x270
> > >         do_one_initcall+0x67/0x2c0
> > >         kernel_init_freeable+0x230/0x270
> > >         kernel_init+0x15/0x130
> > >         ret_from_fork+0x2c/0x50
> > >         ret_from_fork_asm+0x11/0x20
> > >
> > >  -> #1 (subsys mutex#3){+.+.}-{4:4}:
> > >         __mutex_lock+0xc2/0x930
> > >         subsys_interface_register+0x83/0x170
> > >         cpufreq_register_driver+0x154/0x250
> > >         amd_pstate_register_driver+0x36/0x70
> > >         amd_pstate_init+0x1e7/0x270
> > >         do_one_initcall+0x67/0x2c0
> > >         kernel_init_freeable+0x230/0x270
> > >         kernel_init+0x15/0x130
> > >         ret_from_fork+0x2c/0x50
> > >         ret_from_fork_asm+0x11/0x20
> > >
> > >  -> #0 (cpu_hotplug_lock){++++}-{0:0}:
> > >         __lock_acquire+0x1087/0x17e0
> > >         lock_acquire.part.0+0x66/0x1b0
> > >         cpus_read_lock+0x2a/0xc0
> > >         store_local_boost+0x6a/0xd0
> > >         store+0x50/0x90
> > >         kernfs_fop_write_iter+0x135/0x200
> > >         vfs_write+0x2ab/0x540
> > >         ksys_write+0x6c/0xe0
> > >         do_syscall_64+0xbb/0x1d0
> > >         entry_SYSCALL_64_after_hwframe+0x56/0x5e
> > >
> > > Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> > > ---
> > > Changes in v3:
> > >  - Rebased over PM tree's linux-next branch
> > >  - Added a comment to explain why this piece of code is required
> > >  - Switched from guard() to scoped_guard() to allow explicitly wrappi=
ng
> > >    the policy guard inside the cpu_hotplug_lock critical section.
> > >
> > > Changes in v2:
> > >  - Restrict cpu_hotplug_lock acquisition to only
> > >    the local_boost attribute in store() handler.
> > >
> > > Regards,
> > > Seyediman
> > >
> > >  drivers/cpufreq/cpufreq.c | 23 ++++++++++++++++-------
> > >  1 file changed, 16 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index 21fa733a2..b349adbeb 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -622,10 +622,7 @@ static ssize_t store_local_boost(struct cpufreq_=
policy *policy,
> > >     if (!policy->boost_supported)
> > >             return -EINVAL;
> > >
> > > -   cpus_read_lock();
> > >     ret =3D policy_set_boost(policy, enable);
> > > -   cpus_read_unlock();
> > > -
> > >     if (!ret)
> > >             return count;
> > >
> > > @@ -1006,16 +1003,28 @@ static ssize_t store(struct kobject *kobj, st=
ruct attribute *attr,
> > >  {
> > >     struct cpufreq_policy *policy =3D to_policy(kobj);
> > >     struct freq_attr *fattr =3D to_attr(attr);
> > > +   int ret =3D -EBUSY;
> > >
> > >     if (!fattr->store)
> > >             return -EIO;
> > >
> > > -   guard(cpufreq_policy_write)(policy);
> > > +   /*
> > > +    * store_local_boost() requires cpu_hotplug_lock to be held, and =
must be
> > > +    * called with that lock acquired *before* taking policy->rwsem t=
o avoid
> > > +    * lock ordering violations.
> > > +    */
> > > +   if (fattr =3D=3D &local_boost)
> > > +           cpus_read_lock();
> > >
> > > -   if (likely(!policy_is_inactive(policy)))
> > > -           return fattr->store(policy, buf, count);
> > > +   scoped_guard(cpufreq_policy_write, policy) {
> > > +           if (likely(!policy_is_inactive(policy)))
> > > +                   ret =3D fattr->store(policy, buf, count);
> > > +   }
> > >
> > > -   return -EBUSY;
> > > +   if (fattr =3D=3D &local_boost)
> > > +           cpus_read_unlock();
> > > +
> > > +   return ret;
> > >  }
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > --
> > viresh
>
> Hi there,
>
> Just following up to see if there's anything you'd like me to
> change or address in the patch before it can move forward.
> Please let me know if any updates are needed.

I'm kind of wondering why local_boost needs cpus_read_lock() at all.
Holding the policy rwsem blocks CPU online/offline already for this
policy.

Is that because ->set_boost() may need to synchronize with the other polici=
es?

