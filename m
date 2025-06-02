Return-Path: <linux-pm+bounces-27976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D424ACBC04
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 21:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B7C1634F8
	for <lists+linux-pm@lfdr.de>; Mon,  2 Jun 2025 19:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19631226D08;
	Mon,  2 Jun 2025 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+086wwQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E523922577E;
	Mon,  2 Jun 2025 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748894299; cv=none; b=C6BHg90LkpqEPhf5Id8jWQ2nC4VHRYGRDlW7DyukkyLNLbMz8XqJS2jEF+f6XL24PDLUd9i/AdNUiiL575D3N+8Z54NaMzuBXpxwzuTlmg3x0HnXMPIXBdZVlVJug42Z8PvzCONxx9OHWm+re1kapAXeWKKbwiobFbNPbO3X6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748894299; c=relaxed/simple;
	bh=N59ept9FoalL6RV5HtK1/zCQknxh/JUgfdfsOpKo2fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UL/cLUOSNFVYMRezWzm6/cej/SC1OUBoxL4x6Ge3TfKIfIDWLBoY/bRU952oAQxu/TXKGf3AQB3QT4WhfffeSqDJprqg2IOgH4jclDk4QYS5hM9ExzPjZY22TlAJTMWw3JwAT7gn0cz6EoeDKoKDmcYSByU01a/biFrQ4QXBJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+086wwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3E8C4CEF3;
	Mon,  2 Jun 2025 19:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748894295;
	bh=N59ept9FoalL6RV5HtK1/zCQknxh/JUgfdfsOpKo2fA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g+086wwQzkJxrvJnfoYJkqgskMNynpnWl6Y34mK7CBJh8icJjL3RPJQRElY1V/odV
	 puXK0E9QcBoOGd6hW0GIup/RL2U8fzRQ3Y92iB3PkGaY1m7hrGyTDWducnwrL8QX1V
	 6nC16A7u/RBhRbrARyM/MkPZWhLFHw5FPSWN1fSNOB7pLGC1NmpTOxFzbr24Z64DQn
	 J+6I8I98e7VK6p0h8mJCSeHhkPk+y1FDXF///0llhQJkQhrL4Tfh/MeJvcJ2/rYIqM
	 ZKIZ2r05XRc30bUqdMDm2+/QLlcftexzRTlmx8tUxqTfDLhoI70ANuM2tFzmc15/eN
	 6Zsp+JFqCS2NQ==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-607dceb1afdso3223920eaf.3;
        Mon, 02 Jun 2025 12:58:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCuJWTiO+QUGvTzGxhFV0p6GpPLwAFZV2Y8gWDAUSpuL1VC0sB+/8FkrH++kx7j+vd9nGpkddfYfvIf1s=@vger.kernel.org, AJvYcCVvBuQSxODswVuEtc35i8vKyS/ARTEEsxdboHrMdOm4r22HUDY1RtZDfGiUsN5nTcrkN8sx2yqV82Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp7RJgrnKQFkf22Fbwk+OCVMa6xi9FNlOeEpg4pf2DS8o3esaW
	+7dWKpcpBh4IttdXzpNjI5RTkPHaheWoSmylZ7DHj5eOR90QLWezTPdOxYXpL4CP3H/IUFBFAsf
	nQy+Z76Sv3ypfqMwtEz/GBiBZ6t0sIIU=
X-Google-Smtp-Source: AGHT+IHm58ZKj5yUNPGAYIDALbHplXvWquBSl7iBcWGEJ+6nwt0GtTpMj0CHSYu+Yzx2VxlzTHxi7gAxpcONFxjRKrM=
X-Received: by 2002:a05:6820:1b13:b0:60e:d57b:ecc3 with SMTP id
 006d021491bc7-60ed57c0312mr4449831eaf.0.1748894294380; Mon, 02 Jun 2025
 12:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <3541233.QJadu78ljV@rjwysocki.net>
 <aD2U3VIhf8vDkl09@debian.local> <CAJZ5v0h-nrVamqiAJ957aYjHqaeAZUUW7BRi0WxPgCFc40M5cQ@mail.gmail.com>
 <7f0e2865-d35e-4a13-8617-8679afb4b23f@kernel.org>
In-Reply-To: <7f0e2865-d35e-4a13-8617-8679afb4b23f@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 2 Jun 2025 21:58:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gL3rW8dOxXdPWYjZuq5kAaD8qTa4vZ5++k9+0WniNAdQ@mail.gmail.com>
X-Gm-Features: AX0GCFtilHy5dpcjMfFseTc03e3VZv8vBdBFyvRoPB3qJwzT8x0Ib2M4MfHCPik
Message-ID: <CAJZ5v0gL3rW8dOxXdPWYjZuq5kAaD8qTa4vZ5++k9+0WniNAdQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending children
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Chris Bainbridge <chris.bainbridge@gmail.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Saravana Kannan <saravanak@google.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 5:22=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 6/2/2025 9:29 AM, Rafael J. Wysocki wrote:
> > On Mon, Jun 2, 2025 at 2:11=E2=80=AFPM Chris Bainbridge
> > <chris.bainbridge@gmail.com> wrote:
> >>
> >> On Fri, Mar 14, 2025 at 02:13:53PM +0100, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> In analogy with the previous change affecting the resume path,
> >>> make device_suspend() start the async suspend of the device's parent
> >>> after the device itself has been processed and make dpm_suspend() sta=
rt
> >>> processing "async" leaf devices (that is, devices without children)
> >>> upfront so they don't need to wait for the "sync" devices they don't
> >>> depend on.
> >>>
> >>> On the Dell XPS13 9360 in my office, this change reduces the total
> >>> duration of device suspend by approximately 100 ms (over 20%).
> >>>
> >>> Suggested-by: Saravana Kannan <saravanak@google.com>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> This commit results in memory corruption on suspend/resume with short
> >> suspend duration.
> >
> > What do you mean by short?
>
> The tool he used will program a timer to wake up the system.
> The time he input was programmed for a cycle that was short enough that
> the suspend entry didn't finish and it triggered an aborted suspend.

So it crashes during resume when the preceding suspend has been aborted IIU=
C.

The exact crash mechanism is still unclear to me though.

> >
> >> Laptop appears to hang and crash is logged to pstore.
> >
> > Interesting that this is only happening on one system.
> >
> > Thanks for the report anyway, I'll look at this shortly.
> >
> >> To reproduce: `amd_s2idle.py --log log --duration 1 --wait 4 --count 3=
0`
> >>
> >> I have reproduced this both with and without Mario's recent suspend fi=
x
> >> https://lore.kernel.org/amd-gfx/20250602014432.3538345-1-superm1@kerne=
l.org/T/#t
> >>
> >> Pstore log (with Mario's fix):
> >>
> >> <6>[  194.209939] PM: suspend entry (s2idle)
> >> <6>[  194.409450] Filesystems sync: 0.199 seconds
> >> <6>[  194.409756] Freezing user space processes
> >> <6>[  194.411374] Freezing user space processes completed (elapsed 0.0=
01 seconds)
> >> <6>[  194.411377] OOM killer disabled.
> >> <6>[  194.411378] Freezing remaining freezable tasks
> >> <6>[  194.412517] Freezing remaining freezable tasks completed (elapse=
d 0.001 seconds)
> >> <6>[  194.412520] printk: Suspending console(s) (use no_console_suspen=
d to debug)
> >> <7>[  194.663906] PM: suspend of devices aborted after 0.260 msecs
> >> <7>[  194.663911] PM: start suspend of devices aborted after 251.365 m=
secs
> >> <3>[  194.663913] PM: Some devices failed to suspend, or early wake ev=
ent detected
> >> <4>[  194.663975] i2c i2c-3: Unbalanced pm_runtime_enable!
> >> <4>[  194.663989] ee1004 3-0050: Attempt to enable runtime PM when it =
is blocked
> >> Oops#1 Part6
> >> <4>[  194.663991] ee1004 3-0051: Attempt to enable runtime PM when it =
is blocked
> >> <4>[  194.663992] CPU: 5 UID: 0 PID: 121 Comm: kworker/u64:10 Not tain=
ted 6.15.0-rc1-00006-g032a79431b1c #425 PREEMPT(voluntary)
> >> <4>[  194.663994] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/=
8916, BIOS F.17 12/18/2024
> >> <4>[  194.663996] Workqueue: async async_run_entry_fn
> >> <4>[  194.663998]  slab kmalloc-2k
> >> <4>[  194.664000]
> >> <4>[  194.664000]  start ffff99bbe24ac800 pointer offset 408
> >> <4>[  194.664001] Call Trace:
> >> <4>[  194.664002]  size 2048
> >> <3>[  194.664003] list_add corruption. prev->next should be next (ffff=
ffff9da75c60), but was ffff99bbd1d94790. (prev=3Dffff99bbe24ac998).
> >> <4>[  194.664003]  <TASK>
> >> <4>[  194.664007]  dump_stack_lvl+0x6e/0x90
> >> <4>[  194.664011] ------------[ cut here ]------------
> >> <4>[  194.664011]  pm_runtime_enable.cold+0x28/0x48
> >> <2>[  194.664011] kernel BUG at lib/list_debug.c:32!
> >> <4>[  194.664013]  device_resume+0x47/0x200
> >> <4>[  194.664016] Oops: invalid opcode: 0000 [#1] SMP
> >> <4>[  194.664017]  async_resume+0x1d/0x30
> >> <4>[  194.664018] CPU: 2 UID: 0 PID: 2505 Comm: amd_s2idle.py Not tain=
ted 6.15.0-rc1-00006-g032a79431b1c #425 PREEMPT(voluntary)
> >> <4>[  194.664019]  async_run_entry_fn+0x2e/0x130
> >> <4>[  194.664020] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/=
8916, BIOS F.17 12/18/2024
> >> <4>[  194.664021] RIP: 0010:__list_add_valid_or_report+0x90/0xa0
> >> <4>[  194.664022]  process_one_work+0x22b/0x5b0
> >> <4>[  194.664024] Code: e4 8a ff 0f 0b 48 89 f7 48 89 34 24 e8 49 57 c=
6 ff 48 8b 34 24 48 c7 c7 70 d1 64 9d 48 8b 16 48 89 f1 48 89 de e8 00 e4 8=
a ff <0f> 0b 90 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 41 54
> >> Oops#1 Part5
> >> <4>[  194.664025] RSP: 0018:ffffc09a45dafb20 EFLAGS: 00010246
> >> <4>[  194.664026]  worker_thread+0x1da/0x3d0
> >> <4>[  194.664027] RAX: 0000000000000075 RBX: ffffffff9da75c60 RCX: 000=
0000000000027
> >> <4>[  194.664028] RDX: 0000000000000000 RSI: 0000000000000001 RDI: fff=
f99becd11de40
> >> <4>[  194.664029] RBP: ffffffff9da74c00 R08: 0000000000000000 R09: 000=
0000000000000
> >> <4>[  194.664029] R10: 0000000000000000 R11: 0000000000000003 R12: 000=
0000000000010
> >> <4>[  194.664029]  ? bh_worker+0x260/0x260
> >> <4>[  194.664030] R13: 0000002990e47f3d R14: ffff99bbe24ac998 R15: fff=
f99bbe0b67620
> >> <4>[  194.664031] FS:  00007fe534bfc080(0000) GS:ffff99bf2ee50000(0000=
) knlGS:0000000000000000
> >> <4>[  194.664031]  kthread+0x10a/0x250
> >> <4>[  194.664032] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> <4>[  194.664033] CR2: 000055fdfaf910b8 CR3: 000000010d4a9000 CR4: 000=
0000000f50ef0
> >> <4>[  194.664034]  ? kthreads_online_cpu+0x130/0x130
> >> <4>[  194.664034] PKRU: 55555554
> >> <4>[  194.664035] Call Trace:
> >> <4>[  194.664036]  <TASK>
> >> <4>[  194.664036]  ret_from_fork+0x31/0x50
> >> <4>[  194.664037]  dpm_resume+0x139/0x350
> >> <4>[  194.664039]  ? kthreads_online_cpu+0x130/0x130
> >> <4>[  194.664041]  dpm_resume_end+0x11/0x20
> >> <4>[  194.664040]  ret_from_fork_asm+0x11/0x20
> >> <4>[  194.664042]  suspend_devices_and_enter+0x18e/0x9f0
> >> <4>[  194.664045]  </TASK>
> >> <4>[  194.664046]  pm_suspend.cold+0x22f/0x28f
> >> <4>[  194.664046] CPU: 4 UID: 0 PID: 115 Comm: kworker/u64:4 Not taint=
ed 6.15.0-rc1-00006-g032a79431b1c #425 PREEMPT(voluntary)
> >> Oops#1 Part4
> >> <4>[  194.664048]  state_store+0x6c/0xd0
> >> <4>[  194.664049] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/=
8916, BIOS F.17 12/18/2024
> >> <4>[  194.664050] Workqueue: async async_run_entry_fn
> >> <4>[  194.664051]  kernfs_fop_write_iter+0x194/0x250
> >> <4>[  194.664052] Call Trace:
> >> <4>[  194.664052]  <TASK>
> >> <4>[  194.664053]  dump_stack_lvl+0x6e/0x90
> >> <4>[  194.664054]  vfs_write+0x2ac/0x550
> >> <4>[  194.664055]  pm_runtime_enable.cold+0x28/0x48
> >> <4>[  194.664057]  device_resume+0x47/0x200
> >> <4>[  194.664058]  ksys_write+0x71/0xe0
> >> <4>[  194.664060]  async_resume+0x1d/0x30
> >> <4>[  194.664060]  do_syscall_64+0x95/0x1a0
> >> <4>[  194.664062]  async_run_entry_fn+0x2e/0x130
> >> <4>[  194.664062]  ? lockdep_sys_exit+0x1e/0x90
> >> <4>[  194.664064]  process_one_work+0x22b/0x5b0
> >> <4>[  194.664064]  ? trace_hardirqs_on_prepare+0x77/0xa0
> >> <4>[  194.664066]  ? syscall_exit_to_user_mode+0xb1/0x280
> >> <4>[  194.664067]  worker_thread+0x1da/0x3d0
> >> <4>[  194.664068]  ? __mutex_lock+0xdb/0xed0
> >> <4>[  194.664070]  ? __mutex_lock+0xafb/0xed0
> >> <4>[  194.664070]  ? bh_worker+0x260/0x260
> >> <4>[  194.664072]  ? kernfs_fop_llseek+0x35/0xd0
> >> <4>[  194.664072]  kthread+0x10a/0x250
> >> <4>[  194.664073]  ? lock_release+0x1ff/0x2a0
> >> <4>[  194.664074]  ? kthreads_online_cpu+0x130/0x130
> >> <4>[  194.664075]  ? lock_acquire+0x270/0x2d0
> >> <4>[  194.664076]  ret_from_fork+0x31/0x50
> >> <4>[  194.664077]  ? __mutex_unlock_slowpath+0x3c/0x2c0
> >> <4>[  194.664078]  ? kthreads_online_cpu+0x130/0x130
> >> <4>[  194.664079]  ? kernfs_fop_llseek+0x77/0xd0
> >> <4>[  194.664079]  ret_from_fork_asm+0x11/0x20
> >> <4>[  194.664081]  ? lockdep_sys_exit+0x1e/0x90
> >> <4>[  194.664082]  ? trace_hardirqs_on_prepare+0x77/0xa0
> >> Oops#1 Part3
> >> <4>[  194.664084]  </TASK>
> >> <4>[  194.664084]  ? syscall_exit_to_user_mode+0xb1/0x280
> >> <4>[  194.664086]  ? do_syscall_64+0xa1/0x1a0
> >> <4>[  194.664086] uvcvideo 1-3:1.0: Unbalanced pm_runtime_enable!

So it looks like this device is resumed even though it has not been suspend=
ed.

> >> <4>[  194.664087]  ? do_syscall_64+0xa1/0x1a0
> >> <4>[  194.664088]  ? do_syscall_64+0xa1/0x1a0
> >> <4>[  194.664090]  ? switch_fpu_return+0xce/0x100
> >> <4>[  194.664092]  ? lockdep_sys_exit+0x1e/0x90
> >> <4>[  194.664093]  ? trace_hardirqs_on_prepare+0x77/0xa0
> >> <4>[  194.664095]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >> <4>[  194.664096] RIP: 0033:0x7fe534d010d0
> >> <4>[  194.664098] Code: 2d 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c=
3 66 2e 0f 1f 84 00 00 00 00 00 80 3d 99 af 0e 00 00 74 17 b8 01 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> >> <4>[  194.664099] RSP: 002b:00007ffeea167ab8 EFLAGS: 00000202 ORIG_RAX=
: 0000000000000001
> >> <4>[  194.664101] RAX: ffffffffffffffda RBX: 0000000000a794f0 RCX: 000=
07fe534d010d0
> >> <4>[  194.664101] RDX: 0000000000000003 RSI: 000000002689f620 RDI: 000=
0000000000004
> >> <4>[  194.664102] RBP: 00007fe534bfbfe8 R08: 0000000000000000 R09: 000=
0000000000002
> >> <4>[  194.664103] R10: 0000000000000007 R11: 0000000000000202 R12: 000=
0000000000003
> >> <4>[  194.664103] R13: 0000000000000004 R14: 000000002689f620 R15: 000=
0000000a4bb48
> >> <4>[  194.664107]  </TASK>
> >> <4>[  194.664107] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq=
 snd_seq_device xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrac=
k_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user
> >> <4>[  194.664113] btusb 3-3:1.1: Unbalanced pm_runtime_enable!

And same here.

> >> <4>[  194.664114]  xfrm_algo xt_addrtype nft_compat nf_tables br_netfi=
lter bridge stp llc ccm overlay
> >> Oops#1 Part2
> >> <4>[  194.664120] usb 1-4:1.0: Attempt to enable runtime PM when it is=
 blocked
> >> <4>[  194.664120]  qrtr rfcomm cmac algif_hash algif_skcipher
> >> <4>[  194.664122] CPU: 7 UID: 0 PID: 2536 Comm: kworker/u64:38 Not tai=
nted 6.15.0-rc1-00006-g032a79431b1c #425 PREEMPT(voluntary)
> >> <4>[  194.664123]  af_alg bnep binfmt_misc
> >> <4>[  194.664124] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/=
8916, BIOS F.17 12/18/2024
> >> <4>[  194.664125]  nls_ascii nls_cp437 vfat fat
> >> <4>[  194.664126] Workqueue: async async_run_entry_fn
> >> <4>[  194.664127]  snd_acp3x_pdm_dma snd_soc_dmic
> >> <4>[  194.664128]
> >> <4>[  194.664128]  snd_acp3x_rn
> >> <4>[  194.664129] Call Trace:
> >> <4>[  194.664129]  snd_sof_amd_rembrandt snd_sof_amd_acp
> >> <4>[  194.664130]  <TASK>
> >> <4>[  194.664130]  snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_sof_util=
s snd_ctl_led
> >> <4>[  194.664132]  dump_stack_lvl+0x6e/0x90
> >> <4>[  194.664133]  iwlmvm snd_soc_core snd_hda_codec_realtek snd_hda_c=
odec_generic
> >> <4>[  194.664135]  pm_runtime_enable.cold+0x28/0x48
> >> <4>[  194.664135]  snd_compress
> >> <4>[  194.664136]  snd_pci_ps snd_hda_scodec_component mac80211 snd_hd=
a_codec_hdmi
> >> <4>[  194.664137]  device_resume+0x47/0x200
> >> <4>[  194.664138]  snd_soc_acpi_amd_match uvcvideo snd_rpl_pci_acp6x s=
nd_hda_intel videobuf2_vmalloc
> >> <4>[  194.664140]  async_resume+0x1d/0x30
> >> <4>[  194.664141]  snd_acp_pci
> >> <4>[  194.664141]  btusb snd_intel_dspcfg videobuf2_memops
> >> <4>[  194.664142]  async_run_entry_fn+0x2e/0x130
> >> <4>[  194.664143]  snd_amd_acpi_mach snd_hda_codec intel_rapl_msr btrt=
l snd_acp_legacy_common
> >> <4>[  194.664145]  process_one_work+0x22b/0x5b0
> >> <4>[  194.664146]  uvc libarc4 intel_rapl_common btintel snd_pci_acp6x=
 snd_hwdep videobuf2_v4l2
> >> Oops#1 Part1
> >> <4>[  194.664148]  worker_thread+0x1da/0x3d0
> >> <4>[  194.664149]  btbcm snd_pci_acp5x snd_hda_core kvm_amd videodev
> >> <4>[  194.664151]  ? bh_worker+0x260/0x260
> >> <4>[  194.664152]  btmtk hp_wmi snd_rn_pci_acp3x
> >> <4>[  194.664153]  kthread+0x10a/0x250
> >> <4>[  194.664154]  snd_pcm iwlwifi ucsi_acpi kvm
> >> <4>[  194.664155]  ? kthreads_online_cpu+0x130/0x130
> >> <4>[  194.664157]  videobuf2_common platform_profile ee1004
> >> <4>[  194.664158]  ret_from_fork+0x31/0x50
> >> <4>[  194.664158]  bluetooth snd_acp_config snd_timer
> >> <4>[  194.664160]  ? kthreads_online_cpu+0x130/0x130
> >> <4>[  194.664160]  typec_ucsi sparse_keymap mc sg
> >> <4>[  194.664162]  ret_from_fork_asm+0x11/0x20
> >> <4>[  194.664163]  cfg80211 sp5100_tco snd_soc_acpi snd rapl roles wmi=
_bmof pcspkr
> >> <4>[  194.664167]  </TASK>
> >> <4>[  194.664167]  rfkill
> >> <4>[  194.664167]  watchdog ccp k10temp soundcore snd_pci_acp3x typec =
ac battery amd_pmc joydev acpi_tad serio_raw evdev msr parport_pc dm_mod pp=
dev lp parport nvme_fabrics efi_pstore configfs nfnetlink efivarfs ip_table=
s x_tables autofs4 crc32c_generic btrfs blake2b_generic xor raid6_pq sd_mod=
 uas usb_storage scsi_mod scsi_common amdgpu drm_client_lib i2c_algo_bit dr=
m_ttm_helper ttm drm_panel_backlight_quirks drm_exec drm_suballoc_helper am=
dxcp drm_buddy gpu_sched drm_display_helper hid_multitouch drm_kms_helper h=
id_generic nvme xhci_pci xhci_hcd cec nvme_core i2c_hid_acpi ghash_clmulni_=
intel usbcore rc_core nvme_keyring i2c_hid i2c_piix4 amd_sfh video sha512_s=
sse3 usb_common crc16 nvme_auth i2c_smbus drm fan button hid wmi aesni_inte=
l crypto_simd cryptd
> >> <4>[  194.664209] ---[ end trace 0000000000000000 ]---
> >>
> >> Another crash log from latest git (without Mario's fix):
> >>
> >> <6>[  144.858062] PM: suspend entry (s2idle)
> >> <6>[  145.062853] Filesystems sync: 0.204 seconds
> >> <6>[  145.064633] Freezing user space processes
> >> <6>[  145.066592] Freezing user space processes completed (elapsed 0.0=
01 seconds)
> >> <6>[  145.066598] OOM killer disabled.
> >> <6>[  145.066600] Freezing remaining freezable tasks
> >> <6>[  145.067783] Freezing remaining freezable tasks completed (elapse=
d 0.001 seconds)
> >> <6>[  145.067787] printk: Suspending console(s) (use no_console_suspen=
d to debug)
> >> <7>[  145.333423] PM: suspend of devices aborted after 0.905 msecs
> >> <7>[  145.333431] PM: start suspend of devices aborted after 265.772 m=
secs
> >> <3>[  145.333434] PM: Some devices failed to suspend, or early wake ev=
ent detected
> >> <4>[  145.333608] i2c i2c-3: Unbalanced pm_runtime_enable!
> >> <4>[  145.333633] ee1004 3-0050: Attempt to enable runtime PM when it =
is blocked
> >> <4>[  145.333639] CPU: 12 UID: 0 PID: 2375 Comm: kworker/u64:16 Not ta=
inted 6.15.0-09115-g5e799ddbfdab #388 PREEMPT(voluntary)
> >> <4>[  145.333643] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/=
8916, BIOS F.17 12/18/2024
> >> <4>[  145.333645] Workqueue: async async_run_entry_fn
> >> <4>[  145.333650] Call Trace:
> >> <4>[  145.333651] ee1004 3-0051: Attempt to enable runtime PM when it =
is blocked
> >> Oops#1 Part7
> >> <4>[  145.333652]  <TASK>
> >> <4>[  145.333654]  dump_stack_lvl+0x6e/0x90
> >> <4>[  145.333659]  pm_runtime_enable.cold+0x14/0x48

Now this looks like a direct-complete device that is being resumed
even though it has not been suspended.

Apparently, the power.is_suspended flag is set for it, or
device_resume() would not call pm_runtime_enable(), so I'm not sure
how this can happen.

> >> <4>[  145.333662]  device_resume+0xd9/0x570
> >> <4>[  145.333665]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0=
x90
> >> <4>[  145.333668]  ? device_resume+0x570/0x570
> >> <4>[  145.333670]  async_resume+0x1d/0x30
> >> <4>[  145.333672]  async_run_entry_fn+0x97/0x4f0
> >> <4>[  145.333674]  process_one_work+0x849/0x1450
> >> <4>[  145.333678]  ? pwq_dec_nr_in_flight+0xfb0/0xfb0
> >> <4>[  145.333681]  ? assign_work+0x168/0x240
> >> <4>[  145.333683]  worker_thread+0x5f3/0xfd0
> >> <4>[  145.333688]  ? process_one_work+0x1450/0x1450
> >> <4>[  145.333691]  kthread+0x3a2/0x760
> >> <4>[  145.333694]  ? kthread_is_per_cpu+0xc0/0xc0
> >> <4>[  145.333697]  ? ret_from_fork+0x23/0x480
> >> <4>[  145.333701]  ? lock_release+0xd1/0x2a0
> >> <4>[  145.333704]  ? kthread_is_per_cpu+0xc0/0xc0
> >> <4>[  145.333707]  ret_from_fork+0x387/0x480
> >> <4>[  145.333709]  ? kthread_is_per_cpu+0xc0/0xc0
> >> <4>[  145.333711]  ? kthread_is_per_cpu+0xc0/0xc0
> >> <4>[  145.333714]  ret_from_fork_asm+0x11/0x20
> >> <4>[  145.333720]  </TASK>
> >> <4>[  145.333722] CPU: 10 UID: 0 PID: 2387 Comm: kworker/u64:28 Not ta=
inted 6.15.0-09115-g5e799ddbfdab #388 PREEMPT(voluntary)
> >> <4>[  145.333727] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/=
8916, BIOS F.17 12/18/2024
> >> <4>[  145.333729] Workqueue: async async_run_entry_fn
> >> <4>[  145.333734] Call Trace:
> >> <4>[  145.333735]  <TASK>
> >> <4>[  145.333738]  dump_stack_lvl+0x6e/0x90
> >> <4>[  145.333743]  pm_runtime_enable.cold+0x14/0x48
> >> <4>[  145.333747]  device_resume+0xd9/0x570
> >> <4>[  145.333751]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0=
x90
> >> <4>[  145.333756]  ? device_resume+0x570/0x570
> >> Oops#1 Part6
> >> <4>[  145.333759]  async_resume+0x1d/0x30
> >> <4>[  145.333763]  async_run_entry_fn+0x97/0x4f0
> >> <4>[  145.333768]  process_one_work+0x849/0x1450
> >> <4>[  145.333775]  ? pwq_dec_nr_in_flight+0xfb0/0xfb0
> >> <4>[  145.333780]  ? assign_work+0x168/0x240
> >> <4>[  145.333784]  worker_thread+0x5f3/0xfd0
> >> <4>[  145.333790]  ? process_one_work+0x1450/0x1450
> >> <4>[  145.333793] usb 1-4:1.0: Attempt to enable runtime PM when it is=
 blocked
> >> <4>[  145.333793] uvcvideo 1-3:1.0: Unbalanced pm_runtime_enable!
> >> <4>[  145.333793]  kthread+0x3a2/0x760
> >> <4>[  145.333797]  ? kthread_is_per_cpu+0xc0/0xc0
> >> <4>[  145.333801]  ? ret_from_fork+0x23/0x480
> >> <4>[  145.333805]  ? lock_release+0xd1/0x2a0
> >> <4>[  145.333808]  ? kthread_is_per_cpu+0xc0/0xc0
> >> <4>[  145.333809] btusb 3-3:1.1: Unbalanced pm_runtime_enable!
> >> <4>[  145.333813]  ret_from_fork+0x387/0x480
> >> <4>[  145.333817]  ? kthread_is_per_cpu+0xc0/0xc0
> >> <4>[  145.333820]  ? kthread_is_per_cpu+0xc0/0xc0
> >> <4>[  145.333824]  ret_from_fork_asm+0x11/0x20
> >> <4>[  145.333830]  </TASK>
> >> <4>[  145.333836] CPU: 12 UID: 0 PID: 2375 Comm: kworker/u64:16 Not ta=
inted 6.15.0-09115-g5e799ddbfdab #388 PREEMPT(voluntary)
> >> <4>[  145.333840] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/=
8916, BIOS F.17 12/18/2024
> >> <4>[  145.333843] Workqueue: async async_run_entry_fn
> >> <4>[  145.333849] Call Trace:
> >> <4>[  145.333851]  <TASK>
> >> <4>[  145.333854]  dump_stack_lvl+0x6e/0x90
> >> <4>[  145.333858]  pm_runtime_enable.cold+0x14/0x48
> >> <4>[  145.333862]  device_resume+0xd9/0x570
> >> <4>[  145.333864]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0=
x90
> >> <4>[  145.333868]  ? device_resume+0x570/0x570
> >> <4>[  145.333870]  async_resume+0x1d/0x30
> >> <4>[  145.333872]  async_run_entry_fn+0x97/0x4f0
> >> Oops#1 Part5
> >> <4>[  145.333875]  process_one_work+0x849/0x1450
> >> <4>[  145.333879]  ? pwq_dec_nr_in_flight+0xfb0/0xfb0
> >> <4>[  145.333882]  ? assign_work+0x168/0x240
> >> <4>[  145.333885]  worker_thread+0x5f3/0xfd0
> >> <4>[  145.333888]  ? process_one_work+0x1450/0x1450
> >> <4>[  145.333889]  kthread+0x3a2/0x760
> >> <4>[  145.333892]  ? kthread_is_per_cpu+0xc0/0xc0
> >> <4>[  145.333892]  slab kmalloc-2k
> >> <4>[  145.333894]  ? ret_from_fork+0x23/0x480
> >> <4>[  145.333897]  ? lock_release+0xd1/0x2a0
> >> <4>[  145.333900]  ? kthread_is_per_cpu+0xc0/0xc0
> >> <4>[  145.333902]  ret_from_fork+0x387/0x480
> >> <4>[  145.333902]  start ffff888123152000
> >> <4>[  145.333905]  ? kthread_is_per_cpu+0xc0/0xc0
> >> <4>[  145.333904]  pointer offset 408 size 2048
> >> <4>[  145.333908]  ? kthread_is_per_cpu+0xc0/0xc0
> >> <4>[  145.333908]
> >> <3>[  145.333910] list_add corruption. prev->next should be next (ffff=
ffff98f75ce0), but was ffff888137fc8790. (prev=3Dffff888123152198).
> >> <4>[  145.333910]  ret_from_fork_asm+0x11/0x20
> >> <4>[  145.333914]  </TASK>
> >> <4>[  145.333924] ------------[ cut here ]------------
> >> <2>[  145.333925] kernel BUG at lib/list_debug.c:32!
> >> <4>[  145.333931] Oops: invalid opcode: 0000 [#1] SMP KASAN
> >> <4>[  145.333934] CPU: 2 UID: 0 PID: 2403 Comm: amd_s2idle.py Not tain=
ted 6.15.0-09115-g5e799ddbfdab #388 PREEMPT(voluntary)
> >> <4>[  145.333937] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/=
8916, BIOS F.17 12/18/2024
> >> <4>[  145.333938] RIP: 0010:__list_add_valid_or_report+0xf5/0x130
> >> <4>[  145.333942] Code: 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3=
c 02 00 75 3c 49 8b 55 00 4c 89 e9 48 89 de 48 c7 c7 40 a9 0a 98 e8 eb b7 c=
1 fe <0f> 0b 4c 89 e7 e8 91 17 7d ff e9 40 ff ff ff 4c 89 ef e8 84 17 7d
> >> Oops#1 Part4
> >> <4>[  145.333944] RSP: 0018:ffff888130a87788 EFLAGS: 00010282
> >> <4>[  145.333946] RAX: 0000000000000075 RBX: ffffffff98f75ce0 RCX: 000=
0000000000000
> >> <4>[  145.333948] RDX: 0000000000000075 RSI: 0000000000000004 RDI: fff=
fed1026150ee3
> >> <4>[  145.333949] RBP: ffffffff98f714f8 R08: 0000000000000001 R09: fff=
fed107a1a5c31
> >> <4>[  145.333950] R10: ffff8883d0d2e18b R11: 0000000000000000 R12: fff=
fffff98f75ce8
> >> <4>[  145.333951] R13: ffff888123152198 R14: ffff888123152198 R15: fff=
f888130a877e8
> >> <4>[  145.333953] FS:  00007f7272279080(0000) GS:ffff888437132000(0000=
) knlGS:0000000000000000
> >> <4>[  145.333954] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> <4>[  145.333956] CR2: 00007f7271dcfed0 CR3: 000000011eb2f000 CR4: 000=
0000000f50ef0
> >> <4>[  145.333957] PKRU: 55555554
> >> <4>[  145.333958] Call Trace:
> >> <4>[  145.333960]  <TASK>
> >> <4>[  145.333961]  dpm_resume+0x2b9/0x760
> >> <4>[  145.333964]  ? dpm_resume_start+0x30/0x30
> >> <4>[  145.333967]  ? seqcount_lockdep_reader_access.constprop.0+0x82/0=
x90
> >> <4>[  145.333969]  ? ktime_get+0x32/0x150
> >> <4>[  145.333971]  dpm_resume_end+0x11/0x20
> >> <4>[  145.333974]  suspend_devices_and_enter+0x349/0x12f0
> >> <4>[  145.333978]  ? arch_suspend_enable_irqs+0x20/0x20
> >> <4>[  145.333981]  ? dpm_save_failed_dev.cold+0x36/0x36
> >> <4>[  145.333984]  ? up_write+0x1a7/0x4e0
> >> <4>[  145.333987]  pm_suspend.cold+0x3f9/0x466
> >> <4>[  145.333989]  state_store+0xa3/0x150
> >> <4>[  145.333992]  ? sysfs_file_ops+0x110/0x110
> >> <4>[  145.333994]  kernfs_fop_write_iter+0x407/0x630
> >> <4>[  145.333997]  vfs_write+0x514/0xf60
> >> <4>[  145.334000]  ? kernel_write+0x5f0/0x5f0
> >> Oops#1 Part3
> >> <4>[  145.334003]  ? ptep_set_access_flags+0xea/0x120
> >> <4>[  145.334005]  ? lruvec_init+0x1e0/0x1e0
> >> <4>[  145.334008]  ? pgd_free+0x4b0/0x4b0
> >> <4>[  145.334011]  ksys_write+0xf9/0x1c0
> >> <4>[  145.334013]  ? __ia32_sys_read+0xb0/0xb0
> >> <4>[  145.334015]  ? wp_page_reuse+0x160/0x1e0
> >> <4>[  145.334017]  ? do_wp_page+0x14b9/0x2e70
> >> <4>[  145.334020]  do_syscall_64+0x97/0x3d0
> >> <4>[  145.334023]  ? lock_acquire+0x291/0x2e0
> >> <4>[  145.334024]  ? __vmf_anon_prepare+0x1e0/0x1e0
> >> <4>[  145.334026]  ? lock_release+0x1ff/0x2a0
> >> <4>[  145.334028]  ? do_raw_spin_lock+0x12d/0x260
> >> <4>[  145.334030]  ? __rwlock_init+0x150/0x150
> >> <4>[  145.334032]  ? set_p4d+0xb0/0xb0
> >> <4>[  145.334034]  ? __handle_mm_fault+0x147d/0x2010
> >> <4>[  145.334037]  ? __mutex_lock+0x12a1/0x19f0
> >> <4>[  145.334040]  ? copy_page_range+0x4190/0x4190
> >> <4>[  145.334042]  ? lock_acquire+0x291/0x2e0
> >> <4>[  145.334044]  ? lock_release+0x1ff/0x2a0
> >> <4>[  145.334047]  ? __count_memcg_events+0x399/0x4c0
> >> <4>[  145.334049]  ? do_syscall_64+0x155/0x3d0
> >> <4>[  145.334051]  ? lock_release+0x1ff/0x2a0
> >> <4>[  145.334052]  ? count_memcg_events.constprop.0+0x4a/0x60
> >> <4>[  145.334055]  ? handle_mm_fault+0x3d8/0x7d0
> >> <4>[  145.334057]  ? lock_release+0x1ff/0x2a0
> >> <4>[  145.334059]  ? do_user_addr_fault+0x4a3/0xa00
> >> <4>[  145.334061]  ? irqentry_exit_to_user_mode+0x8d/0x270
> >> <4>[  145.334064]  ? trace_hardirqs_on_prepare+0xd7/0x110
> >> <4>[  145.334067]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >> <4>[  145.334069] RIP: 0033:0x7f727237e0d0
> >> <4>[  145.334071] Code: 2d 0e 00 64 c7 00 16 00 00 00 b8 ff ff ff ff c=
3 66 2e 0f 1f 84 00 00 00 00 00 80 3d 99 af 0e 00 00 74 17 b8 01 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> >> Oops#1 Part2
> >> <4>[  145.334073] RSP: 002b:00007fff9a1353b8 EFLAGS: 00000202 ORIG_RAX=
: 0000000000000001
> >> <4>[  145.334075] RAX: ffffffffffffffda RBX: 0000000000a794f0 RCX: 000=
07f727237e0d0
> >> <4>[  145.334076] RDX: 0000000000000003 RSI: 0000000026d40370 RDI: 000=
0000000000004
> >> <4>[  145.334077] RBP: 00007f7272278fe8 R08: 0000000000000000 R09: 000=
0000000000002
> >> <4>[  145.334078] R10: 0000000000000007 R11: 0000000000000202 R12: 000=
0000000000003
> >> <4>[  145.334079] R13: 0000000000000004 R14: 0000000026d40370 R15: 000=
0000000a4bb48
> >> <4>[  145.334083]  </TASK>
> >> <4>[  145.334084] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq=
 snd_seq_device xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrac=
k_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt=
_addrtype nft_compat nf_tables br_netfilter bridge stp llc ccm overlay qrtr=
 rfcomm cmac algif_hash algif_skcipher af_alg bnep binfmt_misc snd_soc_dmic=
 snd_acp3x_pdm_dma snd_acp3x_rn snd_sof_amd_rembrandt snd_sof_amd_acp snd_s=
of_pci nls_ascii snd_sof_xtensa_dsp nls_cp437 snd_sof vfat fat snd_sof_util=
s snd_soc_core snd_ctl_led iwlmvm snd_compress snd_hda_codec_realtek snd_pc=
i_ps snd_hda_codec_generic snd_soc_acpi_amd_match btusb mac80211 snd_hda_sc=
odec_component snd_rpl_pci_acp6x snd_hda_codec_hdmi uvcvideo btrtl snd_acp_=
pci intel_rapl_msr videobuf2_vmalloc snd_hda_intel btintel snd_amd_acpi_mac=
h intel_rapl_common videobuf2_memops snd_intel_dspcfg snd_acp_legacy_common=
 snd_hda_codec snd_pci_acp6x btbcm uvc libarc4 snd_pci_acp5x kvm_amd btmtk =
videobuf2_v4l2 snd_hwdep kvm snd_hda_core snd_rn_pci_acp3x iwlwifi
> >> Oops#1 Part1
> >> <4>[  145.334149]  videodev ucsi_acpi hp_wmi snd_pcm irqbypass bluetoo=
th snd_acp_config platform_profile videobuf2_common typec_ucsi ee1004 snd_s=
oc_acpi mc snd_timer rapl sparse_keymap wmi_bmof sg cfg80211 pcspkr sp5100_=
tco roles k10temp snd_pci_acp3x snd battery watchdog ccp rfkill typec sound=
core ac amd_pmc acpi_tad joydev evdev serio_raw msr parport_pc ppdev lp dm_=
mod parport nvme_fabrics efi_pstore configfs nfnetlink efivarfs ip_tables x=
_tables autofs4 crc32c_cryptoapi sd_mod btrfs blake2b_generic xor raid6_pq =
uas usb_storage scsi_mod scsi_common amdgpu drm_client_lib i2c_algo_bit drm=
_ttm_helper ttm drm_panel_backlight_quirks drm_exec drm_suballoc_helper amd=
xcp drm_buddy gpu_sched drm_display_helper hid_multitouch hid_generic drm_k=
ms_helper xhci_pci nvme cec xhci_hcd nvme_core ghash_clmulni_intel i2c_hid_=
acpi i2c_piix4 video rc_core nvme_keyring usbcore sha512_ssse3 i2c_hid i2c_=
smbus crc16 nvme_auth usb_common amd_sfh fan hid button wmi drm aesni_intel
> >> <4>[  145.334223] ---[ end trace 0000000000000000 ]---
> >>
>

