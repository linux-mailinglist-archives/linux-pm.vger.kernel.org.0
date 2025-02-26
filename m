Return-Path: <linux-pm+bounces-23006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F02A463F6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 16:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F97B188E323
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C4921D3E7;
	Wed, 26 Feb 2025 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMId5dGZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A59821D3E6;
	Wed, 26 Feb 2025 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582097; cv=none; b=m32tv+5ahp5++xdeJEbc41RH6Au2mqyi6vdKQPYatVXEdYqBpn7IOhi0F2Uv1TEjhUSLNXJF1Zb4n6D8Ym9aAFNP7LAkE2kG06V4EDJ0ZRqDxcR+6pWRQSC0POQJmDbIgnz1xe8WDu/v8yA1WGt1DGQUjbgiG/IYu3re2EkWoXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582097; c=relaxed/simple;
	bh=33XeyLXQjZxA2YWGTddxSjB5mDjUVglXOocdu2S4T9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKMEl+8q2U6w+GSu4BoOUBuqhTmAhUTlWhMQIVh4cug6Ho+qdFT/KoxSd1roh9pT9SxPJD+MVSdK7KmUYykYKz8STICT7gIak+uecWKIoRLg9N1/9JKK5bbVEkXwwDOrVppVhsOhl0YCLxbYQxD4xA9TWYWZIkVoz/gRnDnZ0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMId5dGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500F9C4CEE9;
	Wed, 26 Feb 2025 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740582097;
	bh=33XeyLXQjZxA2YWGTddxSjB5mDjUVglXOocdu2S4T9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IMId5dGZKGXMIMdbfYmiUjxGkHhvVzMueDIY+4ecPRY1m6UtXMrIL1yEbCjf/4j9E
	 sX85bD+yIy8h8a0vgMvN6k7m52xyz7QYtJcFMQK6FjzzVe4xTnaAvpdSnB/k9bzCwg
	 J361KAbHXnL1W3kIqfVhzLFWdllPYTqSrt8hI4U5FmZEbb8WDWZXj2YRYwCSMn5Ttp
	 giizz60N6L5nbUnhyppWTvG4WN0TYdh9ysIDgR3kFcUEukn2tpChO6QedqKgGuQqdc
	 7iyPpWb/5OoqwoArEtXf2c/iHGptU34t2dBRM0281mx5JpTImELVx7/MZRWNLqp6WD
	 aJlz0tMaMB5Qw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2bc71717d3fso3976869fac.2;
        Wed, 26 Feb 2025 07:01:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWekqhmoZ8cWyfWYRhHh5vF7cAOhDI2NnVpQeeO9B5BG5Gl98nTUSjMZJpCclW47nw/SqZsWLR6HPfBERM=@vger.kernel.org, AJvYcCXCgwvAWKk/3Sqfd3OeNqYQYtikeryOvkoUrwa2S6NQ4d/RV8iFI0B9PE/Ty2N153Cqq7w5vKJUz1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3yqYCQvEMpaxYYqkk/kjoXd/VQH8GjLShF5L8boyO7fGyzgXC
	w97O066PJUy3gTMGcUFfKc9Xk6OkCMKym+7Ignsrz2aUaQWL+WApdWdQX5w3Swa6B1PxBX98jCN
	QYC33MGRJW5Ulb1clG5eYUTK0WNE=
X-Google-Smtp-Source: AGHT+IHs7wl4wQ/NhNBp7mt5ww6ofEVLSPI6lJxC4pdR1mOx9KqeIHS9dAw6lkuQ4xrT5J/YtJ+Dl+952d2Toffg/7c=
X-Received: by 2002:a05:6870:55cf:b0:2bc:68a1:98b0 with SMTP id
 586e51a60fabf-2c13028da93mr2166182fac.4.1740582096485; Wed, 26 Feb 2025
 07:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0gad9peEcVYGyV72TBOULnsv20J3DU_7GXQMKXgONCZww@mail.gmail.com>
 <20250224013139.3994500-1-lizhi.xu@windriver.com>
In-Reply-To: <20250224013139.3994500-1-lizhi.xu@windriver.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Feb 2025 16:01:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gEbKt-4FKm2D04CMxmw9CgJzx01WbHXK4Jg86Xfy7Phw@mail.gmail.com>
X-Gm-Features: AQ5f1Jogl_r1k4NsP24xXV-f_wgt-7iumVMjJyP-sbm9KXKZ9gAVdXKuoYgHT84
Message-ID: <CAJZ5v0gEbKt-4FKm2D04CMxmw9CgJzx01WbHXK4Jg86Xfy7Phw@mail.gmail.com>
Subject: Re: [PATCH V4] module: replace the mutex lock acquisition method
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: rafael@kernel.org, len.brown@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, pavel@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 2:31=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> w=
rote:
>
> syzbot reported a deadlock in lock_system_sleep. [1]
>
> The write operation to "/sys/module/hibernate/parameters/compressor"
> conflicts with the registration of ieee80211 device, resulting in a deadl=
ock
> in the lock param_lock.
>
> Replace the method of acquiring the lock system_transition_mutex with try=
lock,
> it is arguably better to fail a write to the module param with -EBUSY tha=
n to
> fail ieee80211_register_hw() IMV.
>
> Since this is not a kthread path and it doesn't call set_freezable()
> on itself anywhere, mutex_trylock(&system_transition_mutex) can be called
> from here directly.
>
> [1]
> syz-executor895/5833 is trying to acquire lock:
> ffffffff8e0828c8 (system_transition_mutex){+.+.}-{4:4}, at: lock_system_s=
leep+0x87/0xa0 kernel/power/main.c:56
>
> but task is already holding lock:
> ffffffff8e07dc68 (param_lock){+.+.}-{4:4}, at: kernel_param_lock kernel/p=
arams.c:607 [inline]
> ffffffff8e07dc68 (param_lock){+.+.}-{4:4}, at: param_attr_store+0xe6/0x30=
0 kernel/params.c:586
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #3 (param_lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>        __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
>        ieee80211_rate_control_ops_get net/mac80211/rate.c:220 [inline]
>        rate_control_alloc net/mac80211/rate.c:266 [inline]
>        ieee80211_init_rate_ctrl_alg+0x18d/0x6b0 net/mac80211/rate.c:1015
>        ieee80211_register_hw+0x20cd/0x4060 net/mac80211/main.c:1531
>        mac80211_hwsim_new_radio+0x304e/0x54e0 drivers/net/wireless/virtua=
l/mac80211_hwsim.c:5558
>        init_mac80211_hwsim+0x432/0x8c0 drivers/net/wireless/virtual/mac80=
211_hwsim.c:6910
>        do_one_initcall+0x128/0x700 init/main.c:1257
>        do_initcall_level init/main.c:1319 [inline]
>        do_initcalls init/main.c:1335 [inline]
>        do_basic_setup init/main.c:1354 [inline]
>        kernel_init_freeable+0x5c7/0x900 init/main.c:1568
>        kernel_init+0x1c/0x2b0 init/main.c:1457
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> -> #2 (rtnl_mutex){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>        __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
>        wg_pm_notification drivers/net/wireguard/device.c:80 [inline]
>        wg_pm_notification+0x49/0x180 drivers/net/wireguard/device.c:64
>        notifier_call_chain+0xb7/0x410 kernel/notifier.c:85
>        notifier_call_chain_robust kernel/notifier.c:120 [inline]
>        blocking_notifier_call_chain_robust kernel/notifier.c:345 [inline]
>        blocking_notifier_call_chain_robust+0xc9/0x170 kernel/notifier.c:3=
33
>        pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
>        snapshot_open+0x189/0x2b0 kernel/power/user.c:77
>        misc_open+0x35a/0x420 drivers/char/misc.c:179
>        chrdev_open+0x237/0x6a0 fs/char_dev.c:414
>        do_dentry_open+0x735/0x1c40 fs/open.c:956
>        vfs_open+0x82/0x3f0 fs/open.c:1086
>        do_open fs/namei.c:3830 [inline]
>        path_openat+0x1e88/0x2d80 fs/namei.c:3989
>        do_filp_open+0x20c/0x470 fs/namei.c:4016
>        do_sys_openat2+0x17a/0x1e0 fs/open.c:1428
>        do_sys_open fs/open.c:1443 [inline]
>        __do_sys_openat fs/open.c:1459 [inline]
>        __se_sys_openat fs/open.c:1454 [inline]
>        __x64_sys_openat+0x175/0x210 fs/open.c:1454
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #1 ((pm_chain_head).rwsem){++++}-{4:4}:
>        down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
>        blocking_notifier_call_chain_robust kernel/notifier.c:344 [inline]
>        blocking_notifier_call_chain_robust+0xa9/0x170 kernel/notifier.c:3=
33
>        pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
>        snapshot_open+0x189/0x2b0 kernel/power/user.c:77
>        misc_open+0x35a/0x420 drivers/char/misc.c:179
>        chrdev_open+0x237/0x6a0 fs/char_dev.c:414
>        do_dentry_open+0x735/0x1c40 fs/open.c:956
>        vfs_open+0x82/0x3f0 fs/open.c:1086
>        do_open fs/namei.c:3830 [inline]
>        path_openat+0x1e88/0x2d80 fs/namei.c:3989
>        do_filp_open+0x20c/0x470 fs/namei.c:4016
>        do_sys_openat2+0x17a/0x1e0 fs/open.c:1428
>        do_sys_open fs/open.c:1443 [inline]
>        __do_sys_openat fs/open.c:1459 [inline]
>        __se_sys_openat fs/open.c:1454 [inline]
>        __x64_sys_openat+0x175/0x210 fs/open.c:1454
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #0 (system_transition_mutex){+.+.}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3163 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3282 [inline]
>        validate_chain kernel/locking/lockdep.c:3906 [inline]
>        __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
>        lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
>        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>        __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
>        lock_system_sleep+0x87/0xa0 kernel/power/main.c:56
>        hibernate_compressor_param_set+0x1c/0x210 kernel/power/hibernate.c=
:1452
>        param_attr_store+0x18f/0x300 kernel/params.c:588
>        module_attr_store+0x55/0x80 kernel/params.c:924
>        sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
>        kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
>        new_sync_write fs/read_write.c:586 [inline]
>        vfs_write+0x5ae/0x1150 fs/read_write.c:679
>        ksys_write+0x12b/0x250 fs/read_write.c:731
>        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>        do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> other info that might help us debug this:
>
> Chain exists of:
>   system_transition_mutex --> rtnl_mutex --> param_lock
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(param_lock);
>                                lock(rtnl_mutex);
>                                lock(param_lock);
>   lock(system_transition_mutex);
>
>  *** DEADLOCK ***
>
> Reported-by: syzbot+ace60642828c074eb913@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dace60642828c074eb913
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
> V1 -> V2: use -EAGAIN to replace -EPERM.
> V2 -> V3: replace lock_system_sleep to trylock and update comments
> V3 -> V4: use system_transition_mutex directly
>
>  kernel/power/hibernate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 10a01af63a80..b129ed1d25a8 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1446,10 +1446,10 @@ static const char * const comp_alg_enabled[] =3D =
{
>  static int hibernate_compressor_param_set(const char *compressor,
>                 const struct kernel_param *kp)
>  {
> -       unsigned int sleep_flags;
>         int index, ret;
>
> -       sleep_flags =3D lock_system_sleep();
> +       if (!mutex_trylock(&system_transition_mutex))
> +               return -EBUSY;
>
>         index =3D sysfs_match_string(comp_alg_enabled, compressor);
>         if (index >=3D 0) {
> @@ -1461,7 +1461,7 @@ static int hibernate_compressor_param_set(const cha=
r *compressor,
>                 ret =3D index;
>         }
>
> -       unlock_system_sleep(sleep_flags);
> +       mutex_unlock(&system_transition_mutex);
>
>         if (ret)
>                 pr_debug("Cannot set specified compressor %s\n",
> --

Applied as 6.15 material under a new subject and with edits in the changelo=
g.

Thanks!

