Return-Path: <linux-pm+bounces-22751-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4AFA40F13
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 14:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031177ABAC3
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0B42036F0;
	Sun, 23 Feb 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmBYJiAr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836051E868;
	Sun, 23 Feb 2025 13:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740315680; cv=none; b=lwgfKg0dvW3+2xNpi9/h3HFeTNMS8/gADWQiJwkgM5vQkOj/xnN9Jxyy6rY1YV7SMc7cuDvgc9WNvCe2zWVg+LK9OtDE0tHclEus3b/bGqoeczD4H2oimQVNnEheatMlUrzYMykT5fILfUJM5BgWpY3M+QO8dUo6lYD2hC3Jkfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740315680; c=relaxed/simple;
	bh=sKe5IeM8+cfDgROqI0L15jfk/vv/YenY/wlArQgIrSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qt3tbsHoO6fqZWV47zwIfXTeiIoZaoR7H5g8B4TyDjG57A8oc9JQ/WbUMSChfE7jOQPw0LfpVFu44uWEZ3UKRqaVFS6Z3uCYK2ltwK/PMnvF5/uhF9yrxkWKmNrr2IfdYQTKRXXnB/3bP7P10Try8ASsHz38egGmoMSFVjcInx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmBYJiAr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3398C4CEEA;
	Sun, 23 Feb 2025 13:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740315680;
	bh=sKe5IeM8+cfDgROqI0L15jfk/vv/YenY/wlArQgIrSk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MmBYJiAr35JyOljFcq++P9nsKHMZ0qSsxXbQ7IM57P+ZHmIZN8JrqZvHW63lJHjES
	 SAHCh1D3q7uiI3V0djMwrQJMAhKPiOE9pebrXyCrX16U4OdcOMJfZHjs0HDdaIVlDY
	 VfIk/Kd74r0cPlHyUiWB7DmmtP4FxSubH0JO99hqp6KDxWK556TKmTBVwVMDbuC1Xl
	 k78hwfclTdQiwQsQCYFd7HbRFeG28Lojc6haIEViftB0pobzCUSYGYpTvi88NRgP7u
	 9W3YD+H3oGpM1QH5r1mMk+6n/0GG569xYU11dotz4HXJqvgKpGleevcan8iwDkT2Ws
	 uEAlVidwT4OEg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5fcd7d306f3so3051361eaf.3;
        Sun, 23 Feb 2025 05:01:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqUuRY4DnCu2irSs7pooWv8/t8SVtv4KR6aclnD0HyODrBzy5XxEsY2wzHODX1z/3VsOgAVtZW/nc=@vger.kernel.org, AJvYcCXWkctGCZnC0z3xZe2V75iHhrjA8ej379xhgKo6OprWfz/ytKlA63xacgdkT443MqI9c1QBLD3Tdk7y1ew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw03o/rNcJHgqZZZfoxrGOV0SkuMtWyWeVCJjAK9LDChKsO8drK
	WdjNExJxd/gVtyQGXG9ROLbzlMI0aNA7jxUsfiBEw3j+RMY63d2ta6gD5GKzNFEnnhh98loypXQ
	O81K5TzFUV3EhYwlZ4Kxcyx6TDic=
X-Google-Smtp-Source: AGHT+IESAboNOwdMHEcoi+cOoHdDGkNEv5t4PG9kSbgq6xtpViusvIO+fvYULftb5kvUWdw8zi3VJ0FYsAzLy8krPZU=
X-Received: by 2002:a05:6820:80b:b0:5fc:e355:15e8 with SMTP id
 006d021491bc7-5fd196d74e7mr6808828eaf.7.1740315679230; Sun, 23 Feb 2025
 05:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0hu=Gi82zS27MwKj-uhEciuD6JN8cZLd+75J3VKY796wg@mail.gmail.com>
 <20250222044506.351242-1-lizhi.xu@windriver.com>
In-Reply-To: <20250222044506.351242-1-lizhi.xu@windriver.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 23 Feb 2025 14:01:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gad9peEcVYGyV72TBOULnsv20J3DU_7GXQMKXgONCZww@mail.gmail.com>
X-Gm-Features: AWEUYZlov-znWA-o3uhC-wIWHX7X9r25TqoeYjmyKUKIjTo6Wf8rm3ncUX1NFIk
Message-ID: <CAJZ5v0gad9peEcVYGyV72TBOULnsv20J3DU_7GXQMKXgONCZww@mail.gmail.com>
Subject: Re: [PATCH V3] module: replace the mutex lock acquisition method
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: rafael@kernel.org, len.brown@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, pavel@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 5:45=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> w=
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
> Tested-by: syzbot+ace60642828c074eb913@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
> V1 -> V2: use -EAGAIN to replace -EPERM.
> V2 -> V3: replace lock_system_sleep to trylock and update comments
>
>  include/linux/suspend.h  |  2 ++
>  kernel/power/hibernate.c |  4 +++-
>  kernel/power/main.c      | 12 ++++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index da6ebca3ff77..a9ea3c0b44d7 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -468,6 +468,7 @@ extern void pm_wakep_autosleep_enabled(bool set);
>  extern void pm_print_active_wakeup_sources(void);
>
>  extern unsigned int lock_system_sleep(void);
> +extern unsigned int trylock_system_sleep(void);
>  extern void unlock_system_sleep(unsigned int);
>
>  #else /* !CONFIG_PM_SLEEP */
> @@ -496,6 +497,7 @@ static inline void pm_wakeup_clear(bool reset) {}
>  static inline void pm_system_irq_wakeup(unsigned int irq_number) {}
>
>  static inline unsigned int lock_system_sleep(void) { return 0; }
> +static inline unsigned int trylock_system_sleep(void) { return 0; }
>  static inline void unlock_system_sleep(unsigned int flags) {}
>
>  #endif /* !CONFIG_PM_SLEEP */
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 10a01af63a80..eb2c424a0577 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -1449,7 +1449,9 @@ static int hibernate_compressor_param_set(const cha=
r *compressor,
>         unsigned int sleep_flags;
>         int index, ret;
>
> -       sleep_flags =3D lock_system_sleep();
> +       sleep_flags =3D trylock_system_sleep();

Since this is not a kthread path and it doesn't call set_freezable()
on itself anywhere, the wrapper is not needed.
mutex_trylock(&system_transition_mutex) can be called from here
directly.

> +       if (!sleep_flags)
> +               return -EBUSY;
>
>         index =3D sysfs_match_string(comp_alg_enabled, compressor);
>         if (index >=3D 0) {
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 6254814d4817..6122c652638d 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -58,6 +58,18 @@ unsigned int lock_system_sleep(void)
>  }
>  EXPORT_SYMBOL_GPL(lock_system_sleep);
>
> +unsigned int trylock_system_sleep(void)
> +{
> +       unsigned int flags =3D current->flags;
> +       current->flags |=3D PF_NOFREEZE;
> +       if (!mutex_trylock(&system_transition_mutex)) {
> +               current->flags &=3D ~PF_NOFREEZE;
> +               return 0;
> +       }
> +       return flags;
> +}
> +EXPORT_SYMBOL_GPL(trylock_system_sleep);
> +
>  void unlock_system_sleep(unsigned int flags)
>  {
>         if (!(flags & PF_NOFREEZE))
> --

