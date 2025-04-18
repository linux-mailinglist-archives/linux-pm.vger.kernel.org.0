Return-Path: <linux-pm+bounces-25725-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1EDA93B52
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 18:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A028E25F4
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B8221518F;
	Fri, 18 Apr 2025 16:52:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D671B6CE3
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995149; cv=none; b=uk8DHGlcuUtFIfP1slIiPsvBtnifwagdTfk0SzcyWbQxzPebe7m0P9Twa0FwF43x8h0SPaAoiK57JrXv9UdwJUgz140eNVwpS5z8GvwStB65MfOHKDqfpkpUzoXb2Re7HqgHD+SSWki5wi2W8AakF2oFsBkw6XDmOAnTRn7WG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995149; c=relaxed/simple;
	bh=rIr1X5ArPIoGMne64rZKsUa2zV7wM5g4JO7sSjCzaVg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=I+FX16NYpfZ4X8WycQ3J0+GfbWkkPA33aCMAxeh6slPuyVbjKdK22/2Q+5g6dbeDCtSpG7WcEW6InrCjnywW4pQ2ZthnsSklDHxkn3kgmqk5P4ZJC8kuptkn/RvZOAaFf4e9xHXuz6LT7M06XJ446UzCG+U8cGcV0ofhQCiO/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-849d26dd331so284383039f.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 09:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744995146; x=1745599946;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zal6AAVixQ//SuazCRlx5r883flDW8ZKlGrMWqngAGs=;
        b=DGbDPGAbkJHyCHe3R/OPYZUzKE9OUEJ9uFu9zLTrEWHebfGPPId/vjIkgINCuUkS3u
         G0Tzq2Cd8cJJLTklQpiMvP5c279GVrRqPadC+ChFv8l+rPNV3yCXE4RqiUbgnO6EXD0g
         bramNgdz3cvyX0RaqMukvjPuYitnaheswQcyAAWwEkj3njxfibnStRuxs15ERzT4MiZo
         /E3QIbATF2VpHKMbx6fYTepLe0yO9M7qUL0hjnYrQIDwgEr+YfnwwxJA4OnK8+VWXnFr
         UaRxH6IoGgHp5ehYU12yqTxPA7djXD9F7hoQ+budb7Xi3rbqXd3YRBl2dLxEcXi1L/Ty
         2Cug==
X-Forwarded-Encrypted: i=1; AJvYcCUmVUh+/hTgDo6JHf/NFoIGdj3ZbnpWF43Oxdn4l9d7liXaZ/ymVlKTsEIZ7a4tUz9eqNnphEdlBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPGHZjvSMif7HdF6C3DBaTrE4XcwJxJjn+/yZzjaZbkKebI3k
	Entg26aVtdfn8nIjpTqfNA27+A/fl449/lBKrlYKPOdmuAuQR1bdPBqtXmBQjhgP/8ln/uHHDxQ
	+eO4r+ughIQRA5Y1FXqFwZ4f1k4pQ63j0DH7vkMMXM3+xXki5AkmxHc8=
X-Google-Smtp-Source: AGHT+IFVK47/gPFUoOtwFbq79yvjPfy21GQSjadYJYBBzJklcDbM0w7tD5J1jBtn0Uez8v/N5td546r5oiQ6+edOV3mAnerpg13/
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa6:b0:3d4:2ea4:6b87 with SMTP id
 e9e14a558f8ab-3d8bf2c4acfmr27936405ab.11.1744995146754; Fri, 18 Apr 2025
 09:52:26 -0700 (PDT)
Date: Fri, 18 Apr 2025 09:52:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6802834a.050a0220.243d89.001f.GAE@google.com>
Subject: [syzbot] [pm?] WARNING in complete_all
From: syzbot <syzbot+47e57fb1309cf7e8d1bc@syzkaller.appspotmail.com>
To: dakr@kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8ffd015db85f Linux 6.15-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125920cc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=104a680cd89f1ed7
dashboard link: https://syzkaller.appspot.com/bug?extid=47e57fb1309cf7e8d1bc
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-8ffd015d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/54631d1d74e9/vmlinux-8ffd015d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d54de8b3f30/Image-8ffd015d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47e57fb1309cf7e8d1bc@syzkaller.appspotmail.com

------------[ cut here ]------------
Not in threaded context on PREEMPT_RT as expected
WARNING: CPU: 1 PID: 4317 at kernel/sched/completion.c:71 complete_all+0x1a4/0x1e4 kernel/sched/completion.c:71
Modules linked in:
CPU: 1 UID: 0 PID: 4317 Comm: kworker/u8:6 Not tainted 6.15.0-rc2-syzkaller #0 PREEMPT 
Hardware name: linux,dummy-virt (DT)
Workqueue: netns cleanup_net
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : complete_all+0x1a4/0x1e4 kernel/sched/completion.c:71
lr : complete_all+0x1a4/0x1e4 kernel/sched/completion.c:71
sp : ffff8000a2727630
x29: ffff8000a2727630 x28: 1fffe00003ac34ff x27: ffff00001d61a7fc
x26: ffff00001d61aaf0 x25: ffff00000f4c5000 x24: 0000000000000000
x23: 0000000004208060 x22: 1ffff000144e4ee8 x21: ffff7fffe309e000
x20: ffff000017580000 x19: ffff00001d61a858 x18: ffff80008d90745c
x17: ffff80008703efc0 x16: 1fffe0000d41bb38 x15: dfff800000000000
x14: ffff00006a0c85b0 x13: 0000000000000000 x12: ffff7000144e4e33
x11: 1ffff000144e4e32 x10: ffff7000144e4e32 x9 : dfff800000000000
x8 : ffff8000a2727198 x7 : ffff8000a27272a0 x6 : ffff8000a27271f0
x5 : ffff8000a27271d8 x4 : 0000000000000004 x3 : 1fffe0000d41ad55
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000017580000
Call trace:
 complete_all+0x1a4/0x1e4 kernel/sched/completion.c:71 (P)
 device_pm_remove+0x5c/0x2cc drivers/base/power/main.c:157
 device_del+0x2d8/0x7b4 drivers/base/core.c:3856
 netdev_unregister_kobject+0x230/0x408 net/core/net-sysfs.c:2308
 unregister_netdevice_many_notify+0xd84/0x1af4 net/core/dev.c:12007
 unregister_netdevice_many+0x18/0x24 net/core/dev.c:12035
 cleanup_net+0x408/0x93c net/core/net_namespace.c:649
 process_one_work+0x7cc/0x18d4 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x734/0xb84 kernel/workqueue.c:3400
 kthread+0x348/0x5fc kernel/kthread.c:464
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
irq event stamp: 747794
hardirqs last  enabled at (747793): [<ffff80008024b4fc>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1525 [inline]
hardirqs last  enabled at (747793): [<ffff80008024b4fc>] finish_lock_switch kernel/sched/core.c:5130 [inline]
hardirqs last  enabled at (747793): [<ffff80008024b4fc>] finish_task_switch.isra.0+0x1a8/0x854 kernel/sched/core.c:5248
hardirqs last disabled at (747794): [<ffff80008543cc18>] el1_dbg+0x24/0x9c arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (747746): [<ffff8000801b6c08>] softirq_handle_end kernel/softirq.c:425 [inline]
softirqs last  enabled at (747746): [<ffff8000801b6c08>] handle_softirqs+0x88c/0xdb4 kernel/softirq.c:607
softirqs last disabled at (747729): [<ffff800080010760>] __do_softirq+0x14/0x20 kernel/softirq.c:613
---[ end trace 0000000000000000 ]---
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
bond1 (unregistering): Released all slaves
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
netdevsim netdevsim1 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim1 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim1 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim1 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): Released all slaves
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode


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

