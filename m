Return-Path: <linux-pm+bounces-22622-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFC8A3F328
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 12:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E49172478
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 11:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8C120897C;
	Fri, 21 Feb 2025 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMefEiHJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497A208964;
	Fri, 21 Feb 2025 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138105; cv=none; b=lYz5jrH2argSMf2/aCw0tkmq/2QunL6Qh57WFScPNBf8+Tu82cj2yTLreoljoxqPq6jHxfhG94hp1gFXAwCmwuA1Aoi8vM0CSLSd8AwKV0ZX9C7T0pW/5zh3sPymjy0CgSPWt5Gfx60ZdgYXUP4HYi/M1lwKg+vI+AhV2Ygvj24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138105; c=relaxed/simple;
	bh=cxSMk+k7WC7scwDG31gLO45S/n0ITo71CkX/mA3Etnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgmIvCRnqTcsDDzN6g+rk++7XbrRqMxO8hIVOPvteYjgQ75v1CEPrPbgtXrke8RtihkaE2d2eWDwZTzm17cu1cOORhjnTuErrlVeu89qZeQvTI4vbyMKaxw+WbbddD5rSJ8zLqggaT4u6ml96gdfNWbT8dF3xOgqQxG6TcBWOqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMefEiHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80766C4CEDD;
	Fri, 21 Feb 2025 11:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740138104;
	bh=cxSMk+k7WC7scwDG31gLO45S/n0ITo71CkX/mA3Etnk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AMefEiHJ225xdNxa4T/CAlMTctvDTe/ar3WKtq7UUPRVMtyumkMjqqO+/+DkDHvtt
	 25hFkt0FWhgdVGdQGYNlQ5JNxnzEsNMk9PqDD6IJnTsLVd8pEzV4xBSsP/WfETm/ve
	 t3w1wrnJlYwM0v97yLeABQfwa6cmsrEK8WGZZ1318DM8YMuRG5FUSDKn8PWXFFdzfo
	 h9ApIK2WsyJ82WsrnlqXlE7CWimECq9xMqQVqDf5ggfpsVPsZcugnhE00Gv8W+tW0S
	 eHFkZLvR9JBMP2Np99JXezeAJkMNDLoO+MLXBDUad9WF1sI6e5SEGuDjrAeaniTnt4
	 dGVciz38GTGAg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2bca6017608so1407357fac.0;
        Fri, 21 Feb 2025 03:41:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXwY2CwZDosZ0CkHhVCvk5oPy54Zgp+GcRB+dYLupQE+A3TO4VfU4Z2d/c+2mxYWGCxsN6edXU/T0=@vger.kernel.org, AJvYcCVk6HThkIZ1CQTfvNFYuV9NeIiDAfGCJMD+uZ9BqapFcV40xsleXdHOgSptdYefitSaf7dspcvbT7zSTr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUaCPyqbL9cSqgsVdx2YpEIRw2z+KBwrewBMonDNu9SnslOHgd
	y5PW0XWYhHekpdM6LSxMiUQDe2bXruYF+9sskwaCaiabwb1ApFPeqJN6Tyy4cB10GuTqKGZSiXl
	l8i5lcsZg9NJ/6WPCTmtmfrtabNI=
X-Google-Smtp-Source: AGHT+IH/9QWqJrGkCC6sqbKoiml+uXxP3M3fP+0kZv8x/7Ry1kcwWGF/u+UuFYcI9mCr/LyoJ/JrHB7UmMLWG7+6UL8=
X-Received: by 2002:a05:6870:5d92:b0:29e:5c37:a1c3 with SMTP id
 586e51a60fabf-2bd50c5627bmr2285695fac.2.1740138103770; Fri, 21 Feb 2025
 03:41:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67b74749.050a0220.14d86d.02b4.GAE@google.com> <20250221101005.2742983-1-lizhi.xu@windriver.com>
In-Reply-To: <20250221101005.2742983-1-lizhi.xu@windriver.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Feb 2025 12:41:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h38FRwpYeTgw0VKqKVT=RDSrLnSt+31E6i=XOAoCor9w@mail.gmail.com>
X-Gm-Features: AWEUYZm05UMkcmKrUI5sQYa56RcaC99vmuDlv9h1m_i86SjN-0-JsefCilwjYz4
Message-ID: <CAJZ5v0h38FRwpYeTgw0VKqKVT=RDSrLnSt+31E6i=XOAoCor9w@mail.gmail.com>
Subject: Re: [PATCH] module: replace the mutex lock acquisition method
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: syzbot+ace60642828c074eb913@syzkaller.appspotmail.com, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:10=E2=80=AFAM Lizhi Xu <lizhi.xu@windriver.com> =
wrote:
>
> syzbot reported a deadlock in lock_system_sleep. [1]
>
> The write operation to "/sys/module/hibernate/parameters/compressor"
> conflicts with the registration of ieee80211 device, resulting in a deadl=
ock
> in the lock param_lock.
>
> Since the conflict cannot be avoided, the way to obtain param_lock is cha=
nged
> to trylock to avoid deadlock.
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
>  include/linux/moduleparam.h | 4 ++++
>  kernel/params.c             | 9 ++++++++-
>  net/mac80211/rate.c         | 4 +++-
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index bfb85fd13e1f..cbcbfd8db721 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -306,11 +306,15 @@ struct kparam_array
>
>  #ifdef CONFIG_SYSFS
>  extern void kernel_param_lock(struct module *mod);
> +extern int kernel_param_trylock(struct module *mod);
>  extern void kernel_param_unlock(struct module *mod);
>  #else
>  static inline void kernel_param_lock(struct module *mod)
>  {
>  }
> +static inline int kernel_param_trylock(struct module *mod)
> +{
> +}
>  static inline void kernel_param_unlock(struct module *mod)
>  {
>  }
> diff --git a/kernel/params.c b/kernel/params.c
> index 0074d29c9b80..d19881fbb2ec 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -583,7 +583,9 @@ static ssize_t param_attr_store(const struct module_a=
ttribute *mattr,
>         if (!attribute->param->ops->set)
>                 return -EPERM;
>
> -       kernel_param_lock(mk->mod);
> +       if (!kernel_param_trylock(mk->mod))
> +               return -EPERM;

-EAGAIN would be better I think?

> +
>         if (param_check_unsafe(attribute->param))
>                 err =3D attribute->param->ops->set(buf, attribute->param)=
;
>         else
> @@ -607,6 +609,11 @@ void kernel_param_lock(struct module *mod)
>         mutex_lock(KPARAM_MUTEX(mod));
>  }
>
> +int kernel_param_trylock(struct module *mod)
> +{
> +       return mutex_trylock(KPARAM_MUTEX(mod));
> +}
> +
>  void kernel_param_unlock(struct module *mod)
>  {
>         mutex_unlock(KPARAM_MUTEX(mod));
> diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
> index 0d056db9f81e..aecf7ff51cd9 100644
> --- a/net/mac80211/rate.c
> +++ b/net/mac80211/rate.c
> @@ -217,7 +217,9 @@ ieee80211_rate_control_ops_get(const char *name)
>         const struct rate_control_ops *ops;
>         const char *alg_name;
>
> -       kernel_param_lock(THIS_MODULE);
> +       if (!kernel_param_trylock(THIS_MODULE))
> +               return NULL;
> +
>         if (!name)
>                 alg_name =3D ieee80211_default_rc_algo;
>         else
> --

