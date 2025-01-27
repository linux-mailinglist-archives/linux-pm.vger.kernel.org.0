Return-Path: <linux-pm+bounces-20962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D527A1D364
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 10:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A953A233E
	for <lists+linux-pm@lfdr.de>; Mon, 27 Jan 2025 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE9C1FC10C;
	Mon, 27 Jan 2025 09:31:26 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E393FFD;
	Mon, 27 Jan 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970286; cv=none; b=OYtIrgsZ689o/VT3zdAxq1n6wFYAD8bPChJhqJDwuQo+L8TyGgzRuSVnars2qPkc5eQ6CnUoYUpuoVgemESGgqkZWQOudWLKEFYjevs8Xg75p3yl9qoAmDJ+JMS58iMJhyamqzYmv1dMFs7mrNDjjbNJEN+VFY+vwJJhpUlu8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970286; c=relaxed/simple;
	bh=6dcpuseMUXL6JxAaMfEukK5jobP9F1qdIoH7nBvw8rk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzTEmeIKenPVrSJZ/IJMbjOSYN1523ttTec5+du9+J6ln0YGa2BRwiNTqkw0eSY1G1OW2v/PtGgqMMEvz3j9chLandRVFVgunzcwq3mYAoRUjThIt8b9dpFcckzqzStEt6jgH+E3dtPXDvgHM3fv0HiiIPtWoDQPAk+rVQyxwsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YhNRN3R1PzrSfy;
	Mon, 27 Jan 2025 17:29:36 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 65A401401F4;
	Mon, 27 Jan 2025 17:31:14 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 27 Jan
 2025 17:31:13 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <quzicheng@huawei.com>
CC: <pengfei.xu@intel.com>, <axboe@kernel.dk>, <hch@lst.de>,
	<jlayton@kernel.org>, <brauner@kernel.org>, <joel.granados@kernel.org>,
	<rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [Syzkaller & bisect] There is general protection fault in path_init in v6.11-rc2
Date: Mon, 27 Jan 2025 09:18:11 +0000
Message-ID: <20250127091811.3183623-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZrdzbFYJly8EaVzC@xpf.sh.intel.com>
References: <ZrdzbFYJly8EaVzC@xpf.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200012.china.huawei.com (7.221.188.145)

Hi,=0D
=0D
I am encountering this similar panic issue in v6.6 and would greatly =0D
appreciate any guidance or suggestions you might have. =0D
=0D
It seems that the sysfs path was passed to acct(), and when the process =0D
exited, the fs_struct was released. However, acct_pin_kill() attempted =0D
to write to the hibernate sysfs interface, triggering a null pointer =0D
dereference.=0D
=0D
I added a few more logs =EF=BC=88labeled the file path, the function name a=
nd some key info) based on Pengfei. Below are the relevant log =0D
excerpts and details of the problem for the process/thread T9251:=0D
=0D
[  266.570716][ T9251] kernel/acct.c acct_on(): ./file0=0D
[  266.574701][ T7380] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.576955][ T9251] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.579385][ T9317] fs/fs_struct.c exit_fs(): the kill is: 1, fs_struct =
is released=0D
[  266.579674][ T7380] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.584518][ T9244] fs/fs_struct.c exit_fs(): the kill is: 0, fs_struct =
is released=0D
[  266.587130][ T9268] fs/fs_struct.c exit_fs(): the kill is: 0, fs_struct =
is released=0D
[  266.587478][ T9251] fs/fs_struct.c exit_fs(): the kill is: 1, fs_struct =
is released=0D
[  266.591099][ T9278] Process accounting resumed=0D
[  266.592558][ T7380] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.595184][ T9278] kernel/power/hibernate.c resume_store()=0D
[  266.598253][ T7380] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.601043][ T9278] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.605319][ T7380] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.609439][ T9278] fs/fs_struct.c exit_fs(): the kill is: 1, fs_struct =
is released=0D
[  266.614479][ T9321] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.615085][ T9320] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.616612][ T9251] kernel/power/hibernate.c resume_store()=0D
[  266.620361][ T9321] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.622487][ T9251] fs/namei.c path_init():, fs_struct is: null=0D
[  266.624631][ T9319] fs/fs_struct.c exit_fs(): the kill is: 1, fs_struct =
is released=0D
[  266.625668][ T9321] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.625737][ T9321] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.628762][ T9251] Unable to handle kernel paging request at virtual ad=
dress dfff800000000001=0D
[  266.629149][ T9328] fs/fs_struct.c exit_fs(): the kill is: 1, fs_struct =
is released=0D
[  266.633753][ T9321] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.635200][ T9251] KASAN: null-ptr-deref in range [0x0000000000000008-0=
x000000000000000f]=0D
[  266.637804][ T9331] fs/fs_struct.c exit_fs(): the kill is: 1, fs_struct =
is released=0D
[  266.641370][ T9251] Mem abort info:=0D
[  266.641375][ T9251]   ESR =3D 0x0000000096000004=0D
[  266.643344][ T9334] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.643533][ T9332] fs/fs_struct.c exit_fs(): the kill is: 1, fs_struct =
is released=0D
[  266.649985][ T9335] fs/fs_struct.c exit_fs(): the kill is: 1, fs_struct =
is released=0D
[  266.650571][ T9251]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits=0D
[  266.679306][ T9333] fs/namei.c path_init():, fs_struct is: not null=0D
[  266.681354][ T9251]   SET =3D 0, FnV =3D 0=0D
[  266.681360][ T9251]   EA =3D 0, S1PTW =3D 0=0D
[  267.132845][ T9280] fs/fs_struct.c exit_fs(): the kill is: 0, fs_struct =
is released=0D
[  267.132913][ T9274] fs/fs_struct.c exit_fs(): the kill is: 0, fs_struct =
is released=0D
[  267.133970][ T9251]   FSC =3D 0x04: level 0 translation fault=0D
[  267.133978][ T9251] Data abort info:=0D
[  267.133981][ T9251]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000=
=0D
[  267.133984][ T9251]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0=0D
[  267.133988][ T9251]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0=
=0D
[  267.133992][ T9251] [dfff800000000001] address between user and kernel a=
ddress ranges=0D
[  267.134000][ T9251] Internal error: Oops: 0000000096000004 [#1] SMP=0D
[  267.134817][ T9320] fs/fs_struct.c exit_fs(): the kill is: 1, fs_struct =
is released=0D
[  267.137764][ T7101] fs/namei.c path_init():, fs_struct is: not null=0D
[  267.140527][ T9251] Modules linked in:=0D
[  267.140541][ T9251] CPU: 2 PID: 9251 Comm: syz.3.547 Not tainted 6.6.0-q=
zc-reproduct-1+ #12=0D
[  267.140550][ T9251] Hardware name: linux,dummy-virt (DT)=0D
[  267.140554][ T9251] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSB=
S BTYPE=3D--)=0D
[  267.140561][ T9251] pc : path_init+0x5f0/0x16c0=0D
[  267.140582][ T9251] lr : path_init+0x5c8/0x16c0=0D
[  267.140588][ T9251] sp : ffff800082c06e40=0D
[  267.140592][ T9251] x29: ffff800082c06e40 x28: 0000000000000000=0D
[  267.143204][ T7101] fs/namei.c path_init():, fs_struct is: not null=0D
[  267.146064][ T9251]  x27: dfff800000000000=0D
[  267.146073][ T9251] x26: 0000000000000000 x25: 0000000000000008 x24: 000=
0000000000041=0D
[  267.146082][ T9251] x23: ffff1f2bceea5520 x22: 1ffff00010580e0c x21: fff=
f800082c07080=0D
[  267.146091][ T9251] x20: 1ffff00010580e10 x19: ffff800082c07060 x18: 000=
0000000000000=0D
[  267.146100][ T9251] x17: 0000000000000000 x16: 0000000000000000 x15: 000=
0000000000000=0D
[  267.146108][ T9251] x14: 0000000000000000 x13: 205d343332395420 x12: 000=
0000000000005=0D
[  267.146115][ T9251] x11: ffff800082c07090 x10: ffff800082c07068=0D
[  267.148952][ T7101] fs/namei.c path_init():, fs_struct is: not null=0D
[  267.151802][ T9251]  x9 : dfff800000000001=0D
[  267.151810][ T9251] x8 : 00008fffefa7f290 x7 : ffff800082c070a0 x6 : 000=
0000000000003=0D
[  267.151819][ T9251] x5 : ffff800082c06b80 x4 : ffff700010580d71 x3 : 1ff=
ff00010580de0=0D
[  267.151827][ T9251] x2 : 0000000000000000 x1 : ffff1f2bc490bfc0 x0 : 000=
000000000002b=0D
[  267.151836][ T9251] Call trace:=0D
[  267.151840][ T9251]  path_init+0x5f0/0x16c0=0D
[  267.151848][ T9251]  path_lookupat+0x3c/0x590=0D
[  267.151855][ T9251]  filename_lookup+0x144/0x410=0D
[  267.151859][ T9251]  kern_path+0x44/0x70=0D
[  267.151863][ T9251]  lookup_bdev+0xb8/0x220=0D
[  267.151871][ T9251]  resume_store+0x184/0x320=0D
[  267.151878][ T9251]  kobj_attr_store+0x3c/0x70=0D
[  267.154689][ T7101] fs/namei.c path_init():, fs_struct is: not null=0D
[  267.157783][ T9251]  sysfs_kf_write+0xfc/0x188=0D
[  267.157796][ T9251]  kernfs_fop_write_iter+0x274/0x3e0=0D
[  267.157800][ T9251]  __kernel_write_iter+0x1c4/0x600=0D
[  267.157808][ T9251]  __kernel_write+0xbc/0x100=0D
[  267.157813][ T9251]  do_acct_process+0x3e8/0x620=0D
[  267.157821][ T9251]  acct_pin_kill+0x3c/0x110=0D
[  267.157826][ T9251]  pin_kill+0x164/0x610=0D
[  267.157832][ T9251]  mnt_pin_kill+0x50/0x98=0D
[  267.157836][ T9251]  cleanup_mnt+0x24c/0x2c8=0D
[  267.161037][ T7101] fs/namei.c path_init():, fs_struct is: not null=0D
[  267.164241][ T9251]  __cleanup_mnt+0x1c/0x30=0D
[  267.164252][ T9251]  task_work_run+0x17c/0x308=0D
[  267.164259][ T9251]  do_exit+0x3ac/0xa30=0D
[  267.164267][ T9251]  do_group_exit+0x100/0x348=0D
[  267.164272][ T9251]  get_signal+0x107c/0x10f8=0D
[  267.164277][ T9251]  do_signal+0x160/0x400=0D
[  267.164283][ T9251]  do_notify_resume+0x1c4/0x470=0D
[  267.164287][ T9251]  el0_svc+0x1c0/0x1e8=0D
[  267.164294][ T9251]  el0t_64_sync_handler+0xc0/0xc8=0D
[  267.164299][ T9251]  el0t_64_sync+0x188/0x190=0D
[  267.166883][ T7101] fs/namei.c path_init():, fs_struct is: not null=0D
[  267.170069][ T9251] Code: 91010267 d343fe76 9100c26b 9100226a (39c00120)=
 =0D
[  267.170079][ T9251] ---[ end trace 0000000000000000 ]---=0D
[  267.170084][ T9251] Kernel panic - not syncing: Oops: Fatal exception=0D
[  267.170090][ T9251] SMP: stopping secondary CPUs=0D
[  267.170167][ T9251] Kernel Offset: 0x22a72e400000 from 0xffff80008000000=
0=0D
[  267.170172][ T9251] PHYS_OFFSET: 0xffffe0d540000000=0D
[  267.170175][ T9251] CPU features: 0x00,00000008,00002009,e0080000,100042=
1b=0D
[  267.170182][ T9251] Memory Limit: none=0D
[  269.627565][ T9251] ---[ end Kernel panic - not syncing: Oops: Fatal exc=
eption ]---=0D

