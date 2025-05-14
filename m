Return-Path: <linux-pm+bounces-27134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE97AB6BA3
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 14:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52178160484
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D6927814B;
	Wed, 14 May 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMTcc+ea"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE7427780B;
	Wed, 14 May 2025 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226634; cv=none; b=TbnoSHEPYCEKrqKif1afVCCNwWw4DjoDm+dXvuOWB9Jotb4gvPTDluqb1de1lVA9bJHGpuCOVwIva2Mt1LI7+DPhQc5fwF1aedFvgK780/DmgUUMLNzsbIk9fkMs3Jlw6a3KQJRv9Y2XqrJNn1QKyTGLCjOhSImbQZH9lWpItVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226634; c=relaxed/simple;
	bh=RkK5HYfym0mSKygNHtg7/x99esDPYM69w7wrfurgeaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3oxIVvLOpFxrQwqbgdI4fgvn9iiiIigx2kNghn8f0WxlwtKzBLRq+gsCnYDxqEMHjInhmkkymQSG7gKoi3jr3xVCZyoQ4P+QcSj5jWRcS15zUtUoy8jSM+HEZplODkivHyD/u63N5bxQV/XXpQIOw2dyWa8FDsiw9axCFytQTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMTcc+ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32264C4AF09;
	Wed, 14 May 2025 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747226634;
	bh=RkK5HYfym0mSKygNHtg7/x99esDPYM69w7wrfurgeaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oMTcc+eaTWI1qALlf6gg0aDwGjDJbshwil0B+5L/0/BQOkZe1ykiWiQTz+XsPqwbv
	 aToVfbgy0odLjMzK60nqvZhwsRBUIJZj+mWWrbR0mtaQILxD9RiEbjOySXZmQ+Flav
	 7qK+csjYV4WqBwIH6KxOnugnek4uXLKuLDcVmW8tJ/8yQeaTiJaPUpeUHlDLVJySbn
	 omur8hyCk954p4yJztocT19oTbci7VRfyuecJc9HExJxpOBDt8GwwDxO6xNSJetg+X
	 1Sz26ZQwisoJoSYjCh5vCw9S/tSMQ5eVwPHG3vROuB26qgNqg22XUjh2SIqhXxaTwT
	 AtBDNW2VT0mbw==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-604f0d27c24so3384301eaf.2;
        Wed, 14 May 2025 05:43:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUm6S2ouCT8Il9a7rd0SwmLfabs3aX3QFSCR+tqCB7itQO4pxbdqZxBrsFi1AqCZZsjjD0lb2lKljKZwgo=@vger.kernel.org, AJvYcCXR/h6yMfPMn+LI6MGDJV8pIyLQZGu9ICoFMuLl+cxyNRyAFyT0IsqzSuiKKAAgWDKdVl878lnyYgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiPH0vG/duLzQjpbTU4FSJhjBYnm0SN5soHlKmd7MLhfjEC8Dh
	vZlHcy81XRi8f2WqyQbGUqO8niLDvL2uD/2wo3LaZSiMRRAYasgex0psoEDktFD5twhXljxAgBP
	RnqGAD56+StmanbAoRT0pDkkOR3o=
X-Google-Smtp-Source: AGHT+IFLPiLLdFHgnurhnXU+t42N4mH7EOXOgwJUCUxANYYKeRbm6LctYuTcImfBsxEDZo9qcxyNJ1w7cOf5a/dWweg=
X-Received: by 2002:a05:6820:1b09:b0:609:de23:cfbb with SMTP id
 006d021491bc7-609df2560c5mr1452035eaf.8.1747226633512; Wed, 14 May 2025
 05:43:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250513015726.1497-1-ImanDevel@gmail.com>
In-Reply-To: <20250513015726.1497-1-ImanDevel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 May 2025 14:43:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gS72-yJ2=EwEb4qz2m47RAhU1Va+UnGNJAjTsT1AJiQQ@mail.gmail.com>
X-Gm-Features: AX0GCFuiZGmk5nUYxUtq4FjjEGITyDcDkkHk819fqPtLOpfSDIUh6xmwxhv1ANQ
Message-ID: <CAJZ5v0gS72-yJ2=EwEb4qz2m47RAhU1Va+UnGNJAjTsT1AJiQQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: drop redundant cpus_read_lock() from store_local_boost()
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 3:55=E2=80=AFAM Seyediman Seyedarab <imandevel@gmai=
l.com> wrote:
>
> Lockdep reports a possible circular locking dependency[1] when
> cpu_hotplug_lock is acquired inside store_local_boost(), after
> policy->rwsem has already been taken by store().
>
> However, the boost update is strictly per-policy and does not
> access shared state or iterate over all policies. Since policy->rwsem
> is already held, this is enough to serialize against concurrent
> topology changes for the current policy.
>
> Remove the cpus_read_lock() to resolve the lockdep warning and
> avoid unnecessary locking.
>
>  [1]
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>  WARNING: possible circular locking dependency detected
>  6.15.0-rc6-debug-gb01fc4eca73c #1 Not tainted
>  ------------------------------------------------------
>  power-profiles-/588 is trying to acquire lock:
>  ffffffffb3a7d910 (cpu_hotplug_lock){++++}-{0:0}, at: store_local_boost+0=
x56/0xd0
>
>  but task is already holding lock:
>  ffff8b6e5a12c380 (&policy->rwsem){++++}-{4:4}, at: store+0x37/0x90
>
>  which lock already depends on the new lock.
>
>  the existing dependency chain (in reverse order) is:
>
>  -> #2 (&policy->rwsem){++++}-{4:4}:
>         down_write+0x29/0xb0
>         cpufreq_online+0x7e8/0xa40
>         cpufreq_add_dev+0x82/0xa0
>         subsys_interface_register+0x148/0x160
>         cpufreq_register_driver+0x15d/0x260
>         amd_pstate_register_driver+0x36/0x90
>         amd_pstate_init+0x1e7/0x270
>         do_one_initcall+0x68/0x2b0
>         kernel_init_freeable+0x231/0x270
>         kernel_init+0x15/0x130
>         ret_from_fork+0x2c/0x50
>         ret_from_fork_asm+0x11/0x20
>
>  -> #1 (subsys mutex#3){+.+.}-{4:4}:
>         __mutex_lock+0xc2/0x930
>         subsys_interface_register+0x7f/0x160
>         cpufreq_register_driver+0x15d/0x260
>         amd_pstate_register_driver+0x36/0x90
>         amd_pstate_init+0x1e7/0x270
>         do_one_initcall+0x68/0x2b0
>         kernel_init_freeable+0x231/0x270
>         kernel_init+0x15/0x130
>         ret_from_fork+0x2c/0x50
>         ret_from_fork_asm+0x11/0x20
>
>  -> #0 (cpu_hotplug_lock){++++}-{0:0}:
>         __lock_acquire+0x10ed/0x1850
>         lock_acquire.part.0+0x69/0x1b0
>         cpus_read_lock+0x2a/0xc0
>         store_local_boost+0x56/0xd0
>         store+0x50/0x90
>         kernfs_fop_write_iter+0x132/0x200
>         vfs_write+0x2b3/0x590
>         ksys_write+0x74/0xf0
>         do_syscall_64+0xbb/0x1d0
>         entry_SYSCALL_64_after_hwframe+0x56/0x5e
>
> Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 731ecfc17..759dd178a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -622,10 +622,7 @@ static ssize_t store_local_boost(struct cpufreq_poli=
cy *policy,
>         if (!policy->boost_supported)
>                 return -EINVAL;
>
> -       cpus_read_lock();
>         ret =3D policy_set_boost(policy, enable);
> -       cpus_read_unlock();
> -
>         if (!ret)
>                 return count;
>
> --

Applied as 6.16 material, thanks!

