Return-Path: <linux-pm+bounces-27997-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 973A4ACC34C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 11:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FF81883E34
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569CA28150E;
	Tue,  3 Jun 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8hV7sLq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F682698BC;
	Tue,  3 Jun 2025 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943533; cv=none; b=uJxOYL7z30iDOTwW6Ne8ENSLuijsaxFPIDfrFhCX68M/5sLayNMcD5zvtKvOrRIhwGoGa43eh8bodgs4ZwfrcNVewb3G2n3qM/PAdM5ECxg5obPwa6awLMyHrQ8opJOpCHScI70+A2QN1MB8zZs2Lt53O1lkvHlcaB4IcuV5Ehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943533; c=relaxed/simple;
	bh=zsOqiWAIopc/I1cVwsBZWObBt0Y47yQMURR5bDsXUYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVdPZ4Sorhwh/YwtoNOGmAftlbywdAs4PBW8wD9CkM8427XFxr5Hze2Rav3ySljjoy6Vh28MAbo4duTL4wHuo1A2ZEpqF7bFNws6pWvqdUz31bsSxU6rxyoKVxSJvbMeTDdC67K8rHZxnAznZAeyJNrgPpDKPAW8whZxF4IRDsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8hV7sLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DF2C4CEF4;
	Tue,  3 Jun 2025 09:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748943532;
	bh=zsOqiWAIopc/I1cVwsBZWObBt0Y47yQMURR5bDsXUYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f8hV7sLq9dVLu9eKhnwo5tSw0Dw8IwDt02v2MvyslvDfAVU42+xENQ9zq7Q+p3wOf
	 HQ00ffSAjlqXmYzOfEkrqiYpANqudsG1JOpc7WL9lP/QcNUvGv2DYb+T7vNRD57Rav
	 MiQFUuGkfOxyYroCkqHefdqCp/2fQDDhsL9IUZi2jPWMxISLABM9ATPZlNtpcE9glz
	 xwDxk/hEzBd/z4y9fo4t29Bf2FOHEj5KwAIVhPCb7bRKBZ+nUxGBQKe7sHN1d/nNBw
	 SD2uRMkySt65GB7nUxgzhxYmeSTjB1NW+orOQMVYhKvvUjU7n8AvUuRuMtcLRZhEnW
	 IUGlbmCz5P27w==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-606440d92eeso2462251eaf.2;
        Tue, 03 Jun 2025 02:38:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOAhzzKcX90nB/aOZz3Cf3voCYasdMsluHEoibwdj5eQ90KW9pHqW9VgsQuSchVu5MilDis4AIxrI=@vger.kernel.org, AJvYcCWg607ghWLbwdHMyKNzI3jfN2Eiv/zXU/7wAKlfsG4xBlMp9vIMASjILvFay1x3B6pV4KmMHC9nIkLOVkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiAwkcTGEdn0EnIpGgeK7ioxxH2znTNWb1BOr1NAjKFixOjQA2
	Zws5WS34uAiwzNpuiwPBJs74afjloeBzPo+RQhjH15ZBi4pDU/I10bWrVS35DRTJe5Jl4THDkNY
	KxPGmg2l132Y5lQEZOKrwws9K8/XrTCU=
X-Google-Smtp-Source: AGHT+IFBv7uzvOFJHhnyjbs5CZt0M71e7GPGPSE6OPYCGR3YUVFAs1qsFrLaDG4JD9JjifGUJ/sxerZ67J4qjhqhuWk=
X-Received: by 2002:a05:6820:2783:b0:60b:a8e7:b237 with SMTP id
 006d021491bc7-60db9ec7b52mr6620888eaf.8.1748943531800; Tue, 03 Jun 2025
 02:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <3541233.QJadu78ljV@rjwysocki.net>
 <aD2U3VIhf8vDkl09@debian.local> <CAJZ5v0h-nrVamqiAJ957aYjHqaeAZUUW7BRi0WxPgCFc40M5cQ@mail.gmail.com>
 <7f0e2865-d35e-4a13-8617-8679afb4b23f@kernel.org> <CAJZ5v0gL3rW8dOxXdPWYjZuq5kAaD8qTa4vZ5++k9+0WniNAdQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gL3rW8dOxXdPWYjZuq5kAaD8qTa4vZ5++k9+0WniNAdQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Jun 2025 11:38:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
X-Gm-Features: AX0GCFs6073kShWhjpCCxt_P2beN4BqAUhzgFto2bxGO9CdT3q_QdgHtwvF1XHI
Message-ID: <CAJZ5v0jDZQaR8S6Kn_RoXHBU86+tpjp=qgyxm5h03YEe2S=nPg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] PM: sleep: Suspend async parents after suspending children
To: Mario Limonciello <superm1@kernel.org>, Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, 
	Saravana Kannan <saravanak@google.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="000000000000f21f990636a7a547"

--000000000000f21f990636a7a547
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 9:58=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> On Mon, Jun 2, 2025 at 5:22=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
> >
> > On 6/2/2025 9:29 AM, Rafael J. Wysocki wrote:
> > > On Mon, Jun 2, 2025 at 2:11=E2=80=AFPM Chris Bainbridge
> > > <chris.bainbridge@gmail.com> wrote:
> > >>
> > >> On Fri, Mar 14, 2025 at 02:13:53PM +0100, Rafael J. Wysocki wrote:
> > >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>>
> > >>> In analogy with the previous change affecting the resume path,
> > >>> make device_suspend() start the async suspend of the device's paren=
t
> > >>> after the device itself has been processed and make dpm_suspend() s=
tart
> > >>> processing "async" leaf devices (that is, devices without children)
> > >>> upfront so they don't need to wait for the "sync" devices they don'=
t
> > >>> depend on.
> > >>>
> > >>> On the Dell XPS13 9360 in my office, this change reduces the total
> > >>> duration of device suspend by approximately 100 ms (over 20%).
> > >>>
> > >>> Suggested-by: Saravana Kannan <saravanak@google.com>
> > >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >>
> > >> This commit results in memory corruption on suspend/resume with shor=
t
> > >> suspend duration.
> > >
> > > What do you mean by short?
> >
> > The tool he used will program a timer to wake up the system.
> > The time he input was programmed for a cycle that was short enough that
> > the suspend entry didn't finish and it triggered an aborted suspend.
>
> So it crashes during resume when the preceding suspend has been aborted I=
IUC.
>
> The exact crash mechanism is still unclear to me though.
>
> > >
> > >> Laptop appears to hang and crash is logged to pstore.
> > >
> > > Interesting that this is only happening on one system.
> > >
> > > Thanks for the report anyway, I'll look at this shortly.
> > >
> > >> To reproduce: `amd_s2idle.py --log log --duration 1 --wait 4 --count=
 30`
> > >>
> > >> I have reproduced this both with and without Mario's recent suspend =
fix
> > >> https://lore.kernel.org/amd-gfx/20250602014432.3538345-1-superm1@ker=
nel.org/T/#t
> > >>
> > >> Pstore log (with Mario's fix):
> > >>
> > >> <6>[  194.209939] PM: suspend entry (s2idle)
> > >> <6>[  194.409450] Filesystems sync: 0.199 seconds
> > >> <6>[  194.409756] Freezing user space processes
> > >> <6>[  194.411374] Freezing user space processes completed (elapsed 0=
.001 seconds)
> > >> <6>[  194.411377] OOM killer disabled.
> > >> <6>[  194.411378] Freezing remaining freezable tasks
> > >> <6>[  194.412517] Freezing remaining freezable tasks completed (elap=
sed 0.001 seconds)
> > >> <6>[  194.412520] printk: Suspending console(s) (use no_console_susp=
end to debug)
> > >> <7>[  194.663906] PM: suspend of devices aborted after 0.260 msecs
> > >> <7>[  194.663911] PM: start suspend of devices aborted after 251.365=
 msecs
> > >> <3>[  194.663913] PM: Some devices failed to suspend, or early wake =
event detected
> > >> <4>[  194.663975] i2c i2c-3: Unbalanced pm_runtime_enable!
> > >> <4>[  194.663989] ee1004 3-0050: Attempt to enable runtime PM when i=
t is blocked
> > >> Oops#1 Part6
> > >> <4>[  194.663991] ee1004 3-0051: Attempt to enable runtime PM when i=
t is blocked
> > >> <4>[  194.663992] CPU: 5 UID: 0 PID: 121 Comm: kworker/u64:10 Not ta=
inted 6.15.0-rc1-00006-g032a79431b1c #425 PREEMPT(voluntary)
> > >> <4>[  194.663994] Hardware name: HP HP Pavilion Aero Laptop 13-be0xx=
x/8916, BIOS F.17 12/18/2024
> > >> <4>[  194.663996] Workqueue: async async_run_entry_fn
> > >> <4>[  194.663998]  slab kmalloc-2k
> > >> <4>[  194.664000]
> > >> <4>[  194.664000]  start ffff99bbe24ac800 pointer offset 408
> > >> <4>[  194.664001] Call Trace:
> > >> <4>[  194.664002]  size 2048
> > >> <3>[  194.664003] list_add corruption. prev->next should be next (ff=
ffffff9da75c60), but was ffff99bbd1d94790. (prev=3Dffff99bbe24ac998).
> > >> <4>[  194.664003]  <TASK>
> > >> <4>[  194.664007]  dump_stack_lvl+0x6e/0x90
> > >> <4>[  194.664011] ------------[ cut here ]------------
> > >> <4>[  194.664011]  pm_runtime_enable.cold+0x28/0x48
> > >> <2>[  194.664011] kernel BUG at lib/list_debug.c:32!
> > >> <4>[  194.664013]  device_resume+0x47/0x200
> > >> <4>[  194.664016] Oops: invalid opcode: 0000 [#1] SMP
> > >> <4>[  194.664017]  async_resume+0x1d/0x30
> > >> <4>[  194.664018] CPU: 2 UID: 0 PID: 2505 Comm: amd_s2idle.py Not ta=
inted 6.15.0-rc1-00006-g032a79431b1c #425 PREEMPT(voluntary)
> > >> <4>[  194.664019]  async_run_entry_fn+0x2e/0x130
> > >> <4>[  194.664020] Hardware name: HP HP Pavilion Aero Laptop 13-be0xx=
x/8916, BIOS F.17 12/18/2024
> > >> <4>[  194.664021] RIP: 0010:__list_add_valid_or_report+0x90/0xa0
> > >> <4>[  194.664022]  process_one_work+0x22b/0x5b0
> > >> <4>[  194.664024] Code: e4 8a ff 0f 0b 48 89 f7 48 89 34 24 e8 49 57=
 c6 ff 48 8b 34 24 48 c7 c7 70 d1 64 9d 48 8b 16 48 89 f1 48 89 de e8 00 e4=
 8a ff <0f> 0b 90 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 41 54
> > >> Oops#1 Part5
> > >> <4>[  194.664025] RSP: 0018:ffffc09a45dafb20 EFLAGS: 00010246
> > >> <4>[  194.664026]  worker_thread+0x1da/0x3d0
> > >> <4>[  194.664027] RAX: 0000000000000075 RBX: ffffffff9da75c60 RCX: 0=
000000000000027
> > >> <4>[  194.664028] RDX: 0000000000000000 RSI: 0000000000000001 RDI: f=
fff99becd11de40
> > >> <4>[  194.664029] RBP: ffffffff9da74c00 R08: 0000000000000000 R09: 0=
000000000000000
> > >> <4>[  194.664029] R10: 0000000000000000 R11: 0000000000000003 R12: 0=
000000000000010
> > >> <4>[  194.664029]  ? bh_worker+0x260/0x260
> > >> <4>[  194.664030] R13: 0000002990e47f3d R14: ffff99bbe24ac998 R15: f=
fff99bbe0b67620
> > >> <4>[  194.664031] FS:  00007fe534bfc080(0000) GS:ffff99bf2ee50000(00=
00) knlGS:0000000000000000
> > >> <4>[  194.664031]  kthread+0x10a/0x250
> > >> <4>[  194.664032] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >> <4>[  194.664033] CR2: 000055fdfaf910b8 CR3: 000000010d4a9000 CR4: 0=
000000000f50ef0
> > >> <4>[  194.664034]  ? kthreads_online_cpu+0x130/0x130
> > >> <4>[  194.664034] PKRU: 55555554
> > >> <4>[  194.664035] Call Trace:
> > >> <4>[  194.664036]  <TASK>
> > >> <4>[  194.664036]  ret_from_fork+0x31/0x50
> > >> <4>[  194.664037]  dpm_resume+0x139/0x350
> > >> <4>[  194.664039]  ? kthreads_online_cpu+0x130/0x130
> > >> <4>[  194.664041]  dpm_resume_end+0x11/0x20
> > >> <4>[  194.664040]  ret_from_fork_asm+0x11/0x20
> > >> <4>[  194.664042]  suspend_devices_and_enter+0x18e/0x9f0
> > >> <4>[  194.664045]  </TASK>
> > >> <4>[  194.664046]  pm_suspend.cold+0x22f/0x28f
> > >> <4>[  194.664046] CPU: 4 UID: 0 PID: 115 Comm: kworker/u64:4 Not tai=
nted 6.15.0-rc1-00006-g032a79431b1c #425 PREEMPT(voluntary)
> > >> Oops#1 Part4
> > >> <4>[  194.664048]  state_store+0x6c/0xd0
> > >> <4>[  194.664049] Hardware name: HP HP Pavilion Aero Laptop 13-be0xx=
x/8916, BIOS F.17 12/18/2024
> > >> <4>[  194.664050] Workqueue: async async_run_entry_fn
> > >> <4>[  194.664051]  kernfs_fop_write_iter+0x194/0x250
> > >> <4>[  194.664052] Call Trace:
> > >> <4>[  194.664052]  <TASK>
> > >> <4>[  194.664053]  dump_stack_lvl+0x6e/0x90
> > >> <4>[  194.664054]  vfs_write+0x2ac/0x550
> > >> <4>[  194.664055]  pm_runtime_enable.cold+0x28/0x48
> > >> <4>[  194.664057]  device_resume+0x47/0x200
> > >> <4>[  194.664058]  ksys_write+0x71/0xe0
> > >> <4>[  194.664060]  async_resume+0x1d/0x30
> > >> <4>[  194.664060]  do_syscall_64+0x95/0x1a0
> > >> <4>[  194.664062]  async_run_entry_fn+0x2e/0x130
> > >> <4>[  194.664062]  ? lockdep_sys_exit+0x1e/0x90
> > >> <4>[  194.664064]  process_one_work+0x22b/0x5b0
> > >> <4>[  194.664064]  ? trace_hardirqs_on_prepare+0x77/0xa0
> > >> <4>[  194.664066]  ? syscall_exit_to_user_mode+0xb1/0x280
> > >> <4>[  194.664067]  worker_thread+0x1da/0x3d0
> > >> <4>[  194.664068]  ? __mutex_lock+0xdb/0xed0
> > >> <4>[  194.664070]  ? __mutex_lock+0xafb/0xed0
> > >> <4>[  194.664070]  ? bh_worker+0x260/0x260
> > >> <4>[  194.664072]  ? kernfs_fop_llseek+0x35/0xd0
> > >> <4>[  194.664072]  kthread+0x10a/0x250
> > >> <4>[  194.664073]  ? lock_release+0x1ff/0x2a0
> > >> <4>[  194.664074]  ? kthreads_online_cpu+0x130/0x130
> > >> <4>[  194.664075]  ? lock_acquire+0x270/0x2d0
> > >> <4>[  194.664076]  ret_from_fork+0x31/0x50
> > >> <4>[  194.664077]  ? __mutex_unlock_slowpath+0x3c/0x2c0
> > >> <4>[  194.664078]  ? kthreads_online_cpu+0x130/0x130
> > >> <4>[  194.664079]  ? kernfs_fop_llseek+0x77/0xd0
> > >> <4>[  194.664079]  ret_from_fork_asm+0x11/0x20
> > >> <4>[  194.664081]  ? lockdep_sys_exit+0x1e/0x90
> > >> <4>[  194.664082]  ? trace_hardirqs_on_prepare+0x77/0xa0
> > >> Oops#1 Part3
> > >> <4>[  194.664084]  </TASK>
> > >> <4>[  194.664084]  ? syscall_exit_to_user_mode+0xb1/0x280
> > >> <4>[  194.664086]  ? do_syscall_64+0xa1/0x1a0
> > >> <4>[  194.664086] uvcvideo 1-3:1.0: Unbalanced pm_runtime_enable!
>
> So it looks like this device is resumed even though it has not been suspe=
nded.

Or it is resumed for the second time in a row during the same transition.

I think I know what is going on and the bug is not in the commit in questio=
n.

There is a race between dpm_async_resume_children() and the first loop
in dpm_resume() which fortunately is only fatal when the preceding
suspend transition is aborted.  Namely, that loop can call
dpm_clear_async_state() for a device after dpm_async_with_cleanup()
has run for it, so power.work_in_progress gets cleared and
__dpm_async() will allow an async work to be scheduled for the same
device once again.

Chris, please check if the attached patch helps.  I'm going to post it
as a fix anyway later today, but it would be good to verify that it is
sufficient.

Thanks!

--000000000000f21f990636a7a547
Content-Type: text/x-patch; charset="US-ASCII"; name="pm-sleep-fix-async-resume.patch"
Content-Disposition: attachment; filename="pm-sleep-fix-async-resume.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mbgbsk170>
X-Attachment-Id: f_mbgbsk170

LS0tCiBkcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jIHwgICAgNyArKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspCgotLS0gYS9kcml2ZXJzL2Jhc2UvcG93ZXIvbWFpbi5jCisr
KyBiL2RyaXZlcnMvYmFzZS9wb3dlci9tYWluLmMKQEAgLTYzOCw2ICs2MzgsMTMgQEAKIHN0YXRp
YyB2b2lkIGRwbV9hc3luY19yZXN1bWVfY2hpbGRyZW4oc3RydWN0IGRldmljZSAqZGV2LCBhc3lu
Y19mdW5jX3QgZnVuYykKIHsKIAkvKgorCSAqIFByZXZlbnQgcmFjaW5nIHdpdGggZHBtX2NsZWFy
X2FzeW5jX3N0YXRlKCkgZHVyaW5nIGluaXRpYWwgbGlzdAorCSAqIHdhbGtzIGluIGRwbV9ub2ly
cV9yZXN1bWVfZGV2aWNlcygpLCBkcG1fcmVzdW1lX2Vhcmx5KCksIGFuZAorCSAqIGRwbV9yZXN1
bWUoKS4KKwkgKi8KKwlndWFyZChtdXRleCkoJmRwbV9saXN0X210eCk7CisKKwkvKgogCSAqIFN0
YXJ0IHByb2Nlc3NpbmcgImFzeW5jIiBjaGlsZHJlbiBvZiB0aGUgZGV2aWNlIHVubGVzcyBpdCdz
IGJlZW4KIAkgKiBzdGFydGVkIGFscmVhZHkgZm9yIHRoZW0uCiAJICoK
--000000000000f21f990636a7a547--

