Return-Path: <linux-pm+bounces-6869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8953F8ADB69
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 03:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF0E1C210AA
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 01:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC934FC1D;
	Tue, 23 Apr 2024 01:11:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E333E57E
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 01:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713834697; cv=none; b=tf49fIQ9/Mgs4qOEkhVLE6g3Zie0OamHEnSpDNNsWV7icS0k0qH4+ATnMVb9rVPBBzAZZnWF3ZcZoSd7B3gh/mVegynWEQTjVBT3IbNyw+kjY8zQ38PDL54WUZxM1nLAMOezmep9Jb2uIUOJmgfLPLTyGJ8uDjaGyH8H0AYVCfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713834697; c=relaxed/simple;
	bh=QGSQ3e01/YRwwqOYVV/xp6k+dxZWDLdeW0IbQwrqgGc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BCJXPhrYnmd33Alf9QKEC7VbtrBKJho6AqgFScjKy/EdX+a+5B+ORqH0P8IDZiA3XBwOYyQ4hMltFFZc4GkFjdlUcURvaDd0KIIbNZz6cJiu20nzBKNRfEARd7pqAuk1HZdG/Dr/x/8Pa3Q0s5Y5u0zLpiwc6NDVdqJeLVcsrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7dd914c91afso91812639f.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 18:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713834695; x=1714439495;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkYOSJvaZrQMjgr4hTD0UNEp7jD+cZIVXAudsUi1vqQ=;
        b=iMI8Ful0/T5XdICcY5HQnwOiYYVUX2wP3QRa2xKow3ADykYDNbQ+cDGvU1OAqaZPtI
         rSJYVWa26jkLLyPG9jXOE8WHSwrlsvsH4EFaBxwPLI7C+6OyH4nKcI4G53kobpW7Oyjr
         gD9YG8wx5c0ZkPGmHhRmeAyi3sUBextxxzAOFmOWAvZ/O3cGUt7FZBZnBJ17oga5dzcf
         RAXZaYs550Y7RuBZP0Cx13jJO1MObArVQl61fw4muPJPq77+WD8S5ClnnZTTh6oA8XgE
         o55T6ilrG/gdQAyjFKkRp+RytbWh+bjX/1hj0eya8KV+NuGjzAag2vjOVVmX54ZCB+Jl
         KXgw==
X-Forwarded-Encrypted: i=1; AJvYcCVy0ShuRArXHqm6Bt3vsdQnuH54dK4NuQhmOHJfvc7d/ojm0iqc21iQx+QtjzCIJbq8jDY4hIXhcgngfKA6enb2qr1fKlmCdK0=
X-Gm-Message-State: AOJu0YzS6k2H0co/nhnfuZr+0tPJ7Nn7ilooXfa2Yj9f1DfitWhdxZ3P
	mLg9CnnlkU74c9Ocd5o9zjcRT+fkuY+Jn3dHMIx9YDSuIIFUhX0drBZsZt/Hc08bLl+gMJHARE5
	2Pnj5UIz4Lt2w5Q4aauUFETWJP+OOL0trrX44va9R9lqd92fgMTjs50Y=
X-Google-Smtp-Source: AGHT+IHOwDDkK2K0IAXjoaR54TBQzMC1HDRkVzuqz537i/hHuqpW/vRncE1kCK681DU8w2/Ro15qelaDqlfBR5J61iJv+3s2Ql4h
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8687:b0:485:8e4:37ec with SMTP id
 iv7-20020a056638868700b0048508e437ecmr482841jab.3.1713834695223; Mon, 22 Apr
 2024 18:11:35 -0700 (PDT)
Date: Mon, 22 Apr 2024 18:11:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000367b800616b93c64@google.com>
Subject: [syzbot] [pm?] WARNING: locking bug in netdev_unregister_kobject (2)
From: syzbot <syzbot+f3298e634aa801f1327e@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@ucw.cz, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a71d2909427 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1321c763180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fca646cf17cc616b
dashboard link: https://syzkaller.appspot.com/bug?extid=f3298e634aa801f1327e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c77d21fa1405/disk-6a71d290.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/429fcd369816/vmlinux-6a71d290.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3d8a4b85112/Image-6a71d290.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3298e634aa801f1327e@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 8958 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4773 [inline]
WARNING: CPU: 0 PID: 8958 at kernel/locking/lockdep.c:232 __lock_acquire+0x78c/0x763c kernel/locking/lockdep.c:5087
Modules linked in:
CPU: 0 PID: 8958 Comm: kbnepd bnep0 Not tainted 6.9.0-rc4-syzkaller-g6a71d2909427 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 604010c5 (nZCv daIF +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4773 [inline]
pc : __lock_acquire+0x78c/0x763c kernel/locking/lockdep.c:5087
lr : hlock_class kernel/locking/lockdep.c:232 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4773 [inline]
lr : __lock_acquire+0x780/0x763c kernel/locking/lockdep.c:5087
sp : ffff8000987272c0
x29: ffff800098727580 x28: ffff0000cc9bbc80 x27: ffff0000cc9bc788
x26: 1fffe000199378f1 x25: ffff0000cc9bc6f0 x24: 0000000000000001
x23: 0000000000000003 x22: 0000000000001df5 x21: ffff8000924bc7b8
x20: 0000000000000000 x19: ffff0000cc9bc78c x18: 0000000000000008
x17: 0000000000000000 x16: ffff80008ae725bc x15: 0000000000000001
x14: 1fffe000367b9602 x13: 0000000000000000 x12: dfff800000000000
x11: 0000000000000003 x10: 0000000000ff0100 x9 : 8484f82778db8800
x8 : 0000000000000000 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800098726a38 x4 : ffff80008ef650a0 x3 : ffff8000805e616c
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 check_wait_context kernel/locking/lockdep.c:4773 [inline]
 __lock_acquire+0x78c/0x763c kernel/locking/lockdep.c:5087
 lock_acquire+0x248/0x73c kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
 klist_next+0x8c/0x2e4 lib/klist.c:382
 next_device drivers/base/core.c:3970 [inline]
 device_for_each_child+0xc0/0x174 drivers/base/core.c:4048
 pm_runtime_set_memalloc_noio+0xf0/0x210 drivers/base/power/runtime.c:248
 netdev_unregister_kobject+0x148/0x208 net/core/net-sysfs.c:2106
 unregister_netdevice_many_notify+0x117c/0x1770 net/core/dev.c:11129
 unregister_netdevice_many net/core/dev.c:11157 [inline]
 unregister_netdevice_queue net/core/dev.c:11036 [inline]
 unregister_netdevice include/linux/netdevice.h:3115 [inline]
 unregister_netdev+0x180/0x1f8 net/core/dev.c:11175
 bnep_session+0x23bc/0x257c net/bluetooth/bnep/core.c:525
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
irq event stamp: 9402
hardirqs last  enabled at (9401): [<ffff80008af65274>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (9401): [<ffff80008af65274>] _raw_spin_unlock_irq+0x30/0x80 kernel/locking/spinlock.c:202
hardirqs last disabled at (9402): [<ffff80008af65014>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (9402): [<ffff80008af65014>] _raw_spin_lock_irqsave+0x2c/0x7c kernel/locking/spinlock.c:162
softirqs last  enabled at (9230): [<ffff8000890615e4>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (9230): [<ffff8000890615e4>] netif_addr_unlock_bh include/linux/netdevice.h:4534 [inline]
softirqs last  enabled at (9230): [<ffff8000890615e4>] dev_mc_flush+0x1b4/0x1f8 net/core/dev_addr_lists.c:1036
softirqs last disabled at (9228): [<ffff800089061b1c>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address dfff800000000018
KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000018] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 8958 Comm: kbnepd bnep0 Tainted: G        W          6.9.0-rc4-syzkaller-g6a71d2909427 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
pstate: 604010c5 (nZCv daIF +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4773 [inline]
pc : __lock_acquire+0x568/0x763c kernel/locking/lockdep.c:5087
lr : hlock_class kernel/locking/lockdep.c:232 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4773 [inline]
lr : __lock_acquire+0x780/0x763c kernel/locking/lockdep.c:5087
sp : ffff8000987272c0
x29: ffff800098727580 x28: ffff0000cc9bbc80 x27: ffff0000cc9bc788
x26: 1fffe000199378f1 x25: ffff0000cc9bc6f0 x24: 0000000000000001
x23: 0000000000000003 x22: 0000000000001df5 x21: ffff8000924bc7b8
x20: 0000000000000000 x19: 00000000000000c4 x18: 0000000000000008
x17: 0000000000000000 x16: ffff80008ae725bc x15: 0000000000000001
x14: 1fffe000367b9602 x13: 0000000000000000 x12: dfff800000000000
x11: 0000000000000003 x10: 0000000000ff0100 x9 : 8484f82778db8800
x8 : 0000000000000018 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800098726a38 x4 : ffff80008ef650a0 x3 : ffff8000805e616c
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 check_wait_context kernel/locking/lockdep.c:4773 [inline]
 __lock_acquire+0x568/0x763c kernel/locking/lockdep.c:5087
 lock_acquire+0x248/0x73c kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x5c/0x7c kernel/locking/spinlock.c:162
 klist_next+0x8c/0x2e4 lib/klist.c:382
 next_device drivers/base/core.c:3970 [inline]
 device_for_each_child+0xc0/0x174 drivers/base/core.c:4048
 pm_runtime_set_memalloc_noio+0xf0/0x210 drivers/base/power/runtime.c:248
 netdev_unregister_kobject+0x148/0x208 net/core/net-sysfs.c:2106
 unregister_netdevice_many_notify+0x117c/0x1770 net/core/dev.c:11129
 unregister_netdevice_many net/core/dev.c:11157 [inline]
 unregister_netdevice_queue net/core/dev.c:11036 [inline]
 unregister_netdevice include/linux/netdevice.h:3115 [inline]
 unregister_netdev+0x180/0x1f8 net/core/dev.c:11175
 bnep_session+0x23bc/0x257c net/bluetooth/bnep/core.c:525
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Code: 34000ee8 aa1f03e8 91031113 d343fe68 (38ec6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	34000ee8 	cbz	w8, 0x1dc
   4:	aa1f03e8 	mov	x8, xzr
   8:	91031113 	add	x19, x8, #0xc4
   c:	d343fe68 	lsr	x8, x19, #3
* 10:	38ec6908 	ldrsb	w8, [x8, x12] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

