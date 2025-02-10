Return-Path: <linux-pm+bounces-21703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F353A2F121
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 16:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5A91881DA2
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 15:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BAB23F280;
	Mon, 10 Feb 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctr7wpoR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF923F263;
	Mon, 10 Feb 2025 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200383; cv=none; b=m1zXJmNrgAsFifOCbCYFGUpPAAUMHHojoa8Zw3DDzdQ9m08ScD73ZkOmps266OND6n+UqMblODepFR3gqBe7fAhw84BScnkVmCKRh8VFyf1pE7QoUKCUTS+Oz1oo7xxvh+QpVoWRozeo8gmst2+rXuwcKxfknQWfYYQYL4sIM+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200383; c=relaxed/simple;
	bh=APYtOSADgHf0kenb4M99pAOXDNmU/DldQWJpKl9XSjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ire484Epbpi0wyV0ql5ld41USsyurxAXNdMx430LrLJd2PNYf5P1HwdtuKQFD2TtgXDoLHMP0I8okPB2nP6GZ89j3oLw0T8RVgCO1zS2S6itXu6Rlq5ixw4Bld/rseBvftq/6fTPd/fx0jWph+ClWDcSvLIuogtmzK8P/6EJw4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctr7wpoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30B9C4CEDF;
	Mon, 10 Feb 2025 15:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739200383;
	bh=APYtOSADgHf0kenb4M99pAOXDNmU/DldQWJpKl9XSjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ctr7wpoRdyxnhEkxj9x58qv1h9WTqhtZuh7Jf96AhXKu9mcatWonusZ5QWA2nPC7t
	 +8UEd/lz0a6gHZoj112d1BmCeKuuPif1xOutKfbUxCQU4HOqhzWBYqli3mkNhkwVlK
	 YvWASzUECcdN/ZfSzrpxEhTQZqXj26pv9plfRlpl1cK59msFtuM/Xwj5p9xh8jFt7N
	 v9IQoqU22ivI1bD/Z6pWiNXRn+jXte3ZBx7/JAlw3yb+BX1Vpy1+xlGmS9xeqrgHwJ
	 Fk7dbZVXofBT0G1hOnNw0rJeBYHStvjYyM/ta46qtKts877/O1KDcyypoQpE2ae6sT
	 gOuRqhvqnJNqw==
Date: Mon, 10 Feb 2025 16:12:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Zicheng Qu <quzicheng@huawei.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: jlayton@kernel.org, axboe@kernel.dk, joel.granados@kernel.org, 
	tglx@linutronix.de, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	hch@lst.de, len.brown@intel.com, pavel@ucw.cz, pengfei.xu@intel.com, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com, linux-pm@vger.kernel.org, 
	tanghui20@huawei.com, zhangqiao22@huawei.com, judy.chenhui@huawei.com
Subject: Re: [PATCH] acct: Prevent NULL pointer dereference when writing to
 sysfs
Message-ID: <20250210-unordnung-petersilie-90e37411db18@brauner>
References: <20250127091811.3183623-1-quzicheng@huawei.com>
 <20250210131719.528717-1-quzicheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210131719.528717-1-quzicheng@huawei.com>

On Mon, Feb 10, 2025 at 01:17:19PM +0000, Zicheng Qu wrote:
> The acct feature is designed to write process records to specified
> files, typically paths like /var/log/pacct. However, writing to sysfs
> paths (e.g., /sys/power/resume) maylead to a NULL pointer dereference
> issue. The acct() should not write to sysfs.
> 
> When call the acct() with a sysfs path, such as /sys/power/resume, the
> process exit via do_exit(), it calls exit_fs() to clean up fs_struct
> inside. Subsequently, exit_task_work() calls acct_pin_kill(), triggering
> sysfs operations. This invokes the hibernate resume_store(). Since the
> fs_struct has been cleaned, it results in a NULL pointer dereference.

This is a mess.

As an immediate fix what you're doing will stop the bleeding for sysfs
only. But who knows what people can do if they pass in a procfs or some
other special sauce filesystem path.

There's no guarantee that there isn't an internal lookup that's somehow
triggered in some filesystem by this accounting nonsense.

One fix would be to move exit_fs() past exit_task_work(). It looks like
that this should be doable without much of a problem and it would fix
the path_init() problem.

There should hopefully be nothing relying on task->fs == NULL in
exit_task_work().

There's other solutions but they all get increasingly disgusting or
maybe I'm not imaginative enough rn.

But bigger picture: Can we try and get rid of that accounting stuff? We
could start by making acct(2) return -ENOSYS unconditionally for a start
and see if anything does actually break.

> This patch ensures that acct does not attempt to write to sysfs paths,
> preventing the described issue.
> 
> [  220.064848][ T4630] Unable to handle kernel paging request at virtual address dfff800000000001
> [  220.073744][ T4630] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> [  220.080847][ T4630] Mem abort info:
> [  220.088915][ T4630]   ESR = 0x0000000096000004
> [  220.088921][ T4630]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  220.088925][ T4630]   SET = 0, FnV = 0
> [  220.088927][ T4630]   EA = 0, S1PTW = 0
> [  220.088930][ T4630]   FSC = 0x04: level 0 translation fault
> [  220.088933][ T4630] Data abort info:
> [  220.088934][ T4630]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [  220.088937][ T4630]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [  220.088940][ T4630]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [  220.088943][ T4630] [dfff800000000001] address between user and kernel address ranges
> [  220.088949][ T4630] Internal error: Oops: 0000000096000004 [#1] SMP
> [  220.098020][ T4630] Modules linked in:
> [  220.104001][ T4630]
> [  220.104007][ T4630] CPU: 1 PID: 4630 Comm: syz.14.167 Not tainted 6.6.0-qzc-20250207-+ #16
> [  220.104014][ T4630] Hardware name: linux,dummy-virt (DT)
> [  220.104017][ T4630] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  220.104023][ T4630] pc : path_init+0x61c/0x1710
> [  220.104036][ T4630] lr : path_init+0x5f4/0x1710
> [  220.104042][ T4630] sp : ffff800083c86e20
> [  220.104044][ T4630] x29: ffff800083c86e20 x28: 0000000000000000 x27: dfff800000000000
> [  220.109465][ T4630]
> [  220.109469][ T4630] x26: 0000000000000000
> [  220.114307][ T4630]  x25: 0000000000000008 x24: 0000000000000041
> [  220.114316][ T4630] x23: ffff303e696a2220 x22: 1ffff00010790e08 x21: ffff800083c87060
> [  220.114324][ T4630] x20: 1ffff00010790e0c x19: ffff800083c87040 x18: 0000000000000000
> [  220.114331][ T4630] x17: 756e203a73692074 x16: 63757274735f7366 x15: 202c292865726f74
> [  220.114339][ T4630] x14: 735f656d75736572 x13: 205d303336345420 x12: 0000000000000005
> [  220.114346][ T4630] x11: ffff800083c87070 x10: ffff800083c87048 x9 : dfff800000000001
> [  220.114354][ T4630] x8 : 00008fffef86f294
> [  220.119872][ T4630]  x7 : ffff800083c87080
> [  220.126082][ T4630]  x6 : 0000000000000003
> [  220.126089][ T4630] x5 : ffff800083c86b60 x4 : ffff700010790d6d x3 : 1ffff00010790ddc
> [  220.126097][ T4630] x2 : 0000000000000000 x1 : ffff303e680f1540 x0 : 0000000000000032
> [  220.126105][ T4630] Call trace:
> [  220.126108][ T4630]  path_init+0x61c/0x1710
> [  220.152138][ T4630]  path_lookupat+0x3c/0x590
> [  220.152150][ T4630]  filename_lookup+0x144/0x410
> [  220.152155][ T4630]  kern_path+0x44/0x70
> [  220.152158][ T4630]  lookup_bdev+0xb8/0x220
> [  220.158873][ T4630]  resume_store+0x1d8/0x3f8
> [  220.158882][ T4630]  kobj_attr_store+0x3c/0x70
> [  220.163343][ T4630]  sysfs_kf_write+0xfc/0x188
> [  220.163352][ T4630]  kernfs_fop_write_iter+0x274/0x3e0
> [  220.163356][ T4630]  __kernel_write_iter+0x1c4/0x600
> [  220.163363][ T4630]  __kernel_write+0xbc/0x100
> [  220.163368][ T4630]  do_acct_process+0x3e8/0x620
> [  220.163374][ T4630]  acct_pin_kill+0xa0/0x190
> [  220.163379][ T4630]  pin_kill+0x164/0x610
> [  220.163384][ T4630]  mnt_pin_kill+0x50/0x98
> [  220.169427][ T4630]  cleanup_mnt+0x24c/0x2c8
> [  220.169438][ T4630]  __cleanup_mnt+0x1c/0x30
> [  220.169443][ T4630]  task_work_run+0x17c/0x308
> [  220.169449][ T4630]  do_exit+0x3ac/0xa30
> [  220.169455][ T4630]  do_group_exit+0x100/0x348
> [  220.169460][ T4630]  get_signal+0x107c/0x10f8
> [  220.169464][ T4630]  do_signal+0x160/0x400
> [  220.169468][ T4630]  do_notify_resume+0x1c4/0x470
> [  220.169472][ T4630]  el0_svc+0x1c0/0x1e8
> [  220.169479][ T4630]  el0t_64_sync_handler+0xc0/0xc8
> [  220.169482][ T4630]  el0t_64_sync+0x188/0x190
> [  220.169489][ T4630] Code: 91010267 d343fe76 9100c26b 9100226a (39c00120)
> [  220.174309][ T4630] ---[ end trace 0000000000000000 ]---
> [  220.174316][ T4630] Kernel panic - not syncing: Oops: Fatal exception
> [  220.174319][ T4630] SMP: stopping secondary CPUs
> [  220.174387][ T4630] Kernel Offset: 0x3dd279e00000 from 0xffff800080000000
> [  220.174391][ T4630] PHYS_OFFSET: 0xffffcfc2c0000000
> [  220.174394][ T4630] CPU features: 0x00,00000008,00002009,e0080000,1000421b
> [  220.174398][ T4630] Memory Limit: none
> [  220.347443][ T4630] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---
> 
> Fixes: 669abf4e5539 ("vfs: make path_openat take a struct filename pointer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
> ---
>  kernel/acct.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/acct.c b/kernel/acct.c
> index 31222e8cd534..0beee5effee7 100644
> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -239,6 +239,14 @@ static int acct_on(struct filename *pathname)
>  		filp_close(file, NULL);
>  		return -EIO;
>  	}
> +
> +	mnt = file->f_path.mnt;
> +	if (mnt->mnt_sb->s_magic == SYSFS_MAGIC) {
> +		kfree(acct);
> +		filp_close(file, NULL);
> +		return -EINVAL;
> +	}
> +
>  	internal = mnt_clone_internal(&file->f_path);
>  	if (IS_ERR(internal)) {
>  		kfree(acct);
> @@ -252,7 +260,7 @@ static int acct_on(struct filename *pathname)
>  		filp_close(file, NULL);
>  		return err;
>  	}
> -	mnt = file->f_path.mnt;
> +
>  	file->f_path.mnt = internal;
>  
>  	atomic_long_set(&acct->count, 1);
> -- 
> 2.34.1
> 

