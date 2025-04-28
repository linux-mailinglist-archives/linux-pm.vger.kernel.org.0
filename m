Return-Path: <linux-pm+bounces-26322-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0706AA9F249
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 15:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8220F3B149A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC72826A091;
	Mon, 28 Apr 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGh3sS0D"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F4925E81D;
	Mon, 28 Apr 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846726; cv=none; b=C8/kaqfY37+kFGzRCnW0rayo2DJUXLBfq5GFV60LchJKAokmXSbwvM28rp6cqZ/U6m+LTN0LQq7/SKGaWqvJMkNLDsFHH+38XOjQDUAIVfd9UXQDvnyvRbTM/tPt0M8bjNaJomAWXjKUPF0GOPDNxK/NSZhmrx7VckeZs+2vIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846726; c=relaxed/simple;
	bh=Q5epIT9vkC2ffUHrmbmnekIOUXkIx6JfZPoEscs9+uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJ065xyzuvLz6Xp/8tXDwDDgWdMcxdFXbkoeW1kiWoHtJ3H+Gws2Xv3V+wASQlIcpRLY681TBba0aaNUOrEt93EspQmFWtABOUXJQnvCMcPzGVZD3R6M3gxknJbVgyHYvM2a0dAqW1Osvf+tkUQEHmoInd/D0hD+Qii1P+tXKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGh3sS0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB9FC4AF0F;
	Mon, 28 Apr 2025 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745846726;
	bh=Q5epIT9vkC2ffUHrmbmnekIOUXkIx6JfZPoEscs9+uc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JGh3sS0DYPTOEsAAb5z6YqdEk10MOsTYiw+aGr8e6Z1FcPxhklU7RTBklJ2EA+Huk
	 AmD0Jp36G7R1ghBag5iq8xSIgnNPzn5ka5KfqXHd2WKTeD23H/M0vKRstOEoCnwWwi
	 FWqFlMPw7ILU2WW0imCpV6lugGBUIj5bB/VHyz67RbhQ3KSQIfUp7WLqQP75kAsjl1
	 +GYpS2zMSw0RekI4m+vi1Fm/5K5QqBBSv+ulo53suvIz3jQesuK8ev+fKdFu9ClmWU
	 ZCva3OrFzSoGdnlBSMSOcL+T0bAMiAq0cSnsoDOYEt/BUScAHpThQVLoFHFo4Z5IN0
	 uX7tDSBMkkW6g==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72fffa03ac6so3722927a34.3;
        Mon, 28 Apr 2025 06:25:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpp92gcC2UQIa1n7YQT5eUi8tldigACxJAIkhhdCaGVhHQ7MmJ1TeeGJPc3kmZRTbuG6ZOeyiB2jzr3PM=@vger.kernel.org, AJvYcCWt1UJHrXYaZURlemp3ntJFaWLU19UdiAFLXU0mFQwDYX9uXSZQp5ZIEssan1z24Dw/KN0dbfwtNPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjam/91N+r10zG4/s5EiQN1C3n5+0k7eYQez+QsqHKqiSQgrsY
	8lvZ8I8IDoWECNOsFDRYsNxQldxJUs0keA8kwozNRmRQVAaRlE58UriE/MFlgPzvszSVe7049OY
	sA3+wXOjcfiqBjyr7LB0wclprFrk=
X-Google-Smtp-Source: AGHT+IHR4NEN3o+J4MxeKYIU+Wtc4tI7CeCDDEHAZRAaJ/veNsm+AmNtDEK/VbELg9D6XvQZRn7g3s0k2D0BRVh9e2E=
X-Received: by 2002:a05:6870:241d:b0:2a3:832e:5492 with SMTP id
 586e51a60fabf-2d9a34ed851mr6471027fac.25.1745846725508; Mon, 28 Apr 2025
 06:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428043356.3169-1-ImanDevel@gmail.com>
In-Reply-To: <20250428043356.3169-1-ImanDevel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 28 Apr 2025 15:25:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j8PvDdAc5WdFV-AM8V7srhsOdD3ACv=g0rhWhhbX19aA@mail.gmail.com>
X-Gm-Features: ATxdqUFRHRvv741ADdl4ebFkKnvfNwLZOQE6WiitTlvhX3LhTfSKWf3lEJL9gNY
Message-ID: <CAJZ5v0j8PvDdAc5WdFV-AM8V7srhsOdD3ACv=g0rhWhhbX19aA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: fix locking order in store_local_boost to
 prevent deadlock
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 6:31=E2=80=AFAM Seyediman Seyedarab <imandevel@gmai=
l.com> wrote:
>
> Lockdep reports a possible circular locking dependency[1] when
> writing to /sys/devices/system/cpu/cpufreq/policyN/boost,
> triggered by power-profiles-daemon at boot.
>
> store_local_boost() acquires cpu_hotplug_lock *AFTER* policy->rwsem
> has already been taken by the store() handler. However, the expected
> locking hierarchy is to acquire cpu_hotplug_lock before policy->rwsem.
> This inverted lock order creates a *theoretical* deadlock possibility.
>
> Take cpu_hotplug_lock in the store() before down_write(&policy->rwsem),
> and remove the internal cpus_read_lock/unlock pair
> inside store_local_boost().

The patch does more than this, though.  It adds CPU offline/online
locking to multiple cpufreq sysfs attributes where it is not needed.

>
>  [1]
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: possible circular locking dependency detected
>  6.15.0-rc3-debug #28 Not tainted
>  ------------------------------------------------------
>  power-profiles-/596 is trying to acquire lock:
>  ffffffffb147e910 (cpu_hotplug_lock){++++}-{0:0}, at: store_local_boost+0=
x6a/0xd0
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
>  drivers/cpufreq/cpufreq.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index acf19b004..6e672dcba 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -653,10 +653,7 @@ static ssize_t store_local_boost(struct cpufreq_poli=
cy *policy,
>
>         policy->boost_enabled =3D enable;
>
> -       cpus_read_lock();
>         ret =3D cpufreq_driver->set_boost(policy, enable);
> -       cpus_read_unlock();
> -
>         if (ret) {
>                 policy->boost_enabled =3D !policy->boost_enabled;
>                 return ret;
> @@ -1045,10 +1042,12 @@ static ssize_t store(struct kobject *kobj, struct=
 attribute *attr,
>         if (!fattr->store)
>                 return -EIO;
>
> +       cpus_read_lock();
>         down_write(&policy->rwsem);
>         if (likely(!policy_is_inactive(policy)))
>                 ret =3D fattr->store(policy, buf, count);
>         up_write(&policy->rwsem);
> +       cpus_read_unlock();

So you'd need to do this for local_boost only, not for all attributes
using store().

>
>         return ret;
>  }
> --

