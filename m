Return-Path: <linux-pm+bounces-6815-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 900308AD107
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 17:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35291C21D66
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 15:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42CA153511;
	Mon, 22 Apr 2024 15:35:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2491534E2
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800127; cv=none; b=uCCiUrM/+98BGv9GnZGZ9hhwXar396Tbw12RAn/kERXKBNRfQF3fwJ4O7maZ2Vq8PieoS1vJVKw13NlcXBFc++SjX5nb0TUVfZvrCpP5OSdMPZ4ZyBX9DfD4vpiCRllEH1rVOeQbMFpm073ZYspMbyQ1O8CdWDz1hA+KXaznj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800127; c=relaxed/simple;
	bh=OWyazZp4D8Qo127EkctJzV9VM2hgKoVyNCIkPRGrTlQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FAogG7jlaNgRTbCAIk6kQvfFMD4JsJ7wGR+B8UirKNvVFDbKkTZPXtuVBt1smIi0UXrJZmUuJpSp0iiCzBfaVoLX0nwMwWoOVUpVHDi3w3/oHvWYpLX+kFS+kZWS1+CBVH1+QCUMiHCKE9QAFdNqLyYXxKTxn2MxjOuDylAqGgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so602724639f.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 08:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800125; x=1714404925;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrVgre9w/j/M95ocT+xsZ1lldJlk/bW9cdj9Jm+iEAo=;
        b=Q0w8qgNhPQK1JR5f/vZem4CkpS5AM+zioQqKy/TIp/a7q8H47Onoj0+9uiKJCTZpsK
         q/6/M7a9uKlQQTZuNNq/0zz+vtxa1zgq0tYQryg/pRKWDYSETaBR3rqowIJb/6s1V0BJ
         4qcTOlnrNGVfBtIG1n6OnjxLiKohkoNaKcKsVdhX1MQYHSglxMrzQCmrsrBeUoLw0psi
         LlHH6C7kxMuDN3Aj12y7ganqeWTfpRTNFRQarVV0ARUSWefG1WM1ozKjZdhLfbZRHkAR
         JDdBIIDEu7q0k01PPDNd6vcPGnD7CLIR/C7w2ey8Rgk+wXQP2YZECnkgz77IrSaGPWLO
         zQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCUPIPJ26rCjozYbv+89ujio0A1sNOVVSP2j6nwdUUBnmtShJL01f+xSZ++fvG1eQN/qN2kZ3OAe0j5GmEOrhYG8rKBJlln0GAA=
X-Gm-Message-State: AOJu0YxisSev3WmeuTnXL8U5A8P9is8HkaGk5N5Q5P7iOlm8X41iyDdR
	P6ur70uRHx4w0F6HUjGvrC1LlU5KEnEI+hz643qgsQNoLZ/fPljfTcRhbf67XSzv2Ekpkx6v8ei
	avohXGwcpWD7RvBtGmgXwvTO6LgoOld6itm8HdjpqEpyiDx3l52QDFqc=
X-Google-Smtp-Source: AGHT+IG8uW9/okHFkFvM8qazTCwyWrjv5CDruDwOprecEUu703BPnsxRR1dPZJFhClzMWGZ0hkIl0bltv8A9AEojHUQ0bOznpUGb
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:148d:b0:7da:67e8:9379 with SMTP id
 a13-20020a056602148d00b007da67e89379mr250417iow.4.1713800125322; Mon, 22 Apr
 2024 08:35:25 -0700 (PDT)
Date: Mon, 22 Apr 2024 08:35:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000afab690616b12f99@google.com>
Subject: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@ucw.cz, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3cdb45594619 Merge tag 's390-6.9-4' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13d23353180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d239903bd07761e5
dashboard link: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172afcbf180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144067cb180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5135044ea611/disk-3cdb4559.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3c5a5ab80ba8/vmlinux-3cdb4559.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e215eb6531dd/bzImage-3cdb4559.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in device_for_each_child+0xa7/0x170 drivers/base/core.c:4044
Read of size 8 at addr ffff88807bee95f8 by task kbnepd bnep0/5202

CPU: 0 PID: 5202 Comm: kbnepd bnep0 Not tainted 6.9.0-rc4-syzkaller-00173-g3cdb45594619 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 device_for_each_child+0xa7/0x170 drivers/base/core.c:4044
 pm_runtime_set_memalloc_noio+0x114/0x260 drivers/base/power/runtime.c:248
 netdev_unregister_kobject+0x178/0x250 net/core/net-sysfs.c:2106
 unregister_netdevice_many_notify+0x11dd/0x16e0 net/core/dev.c:11135
 unregister_netdevice_many net/core/dev.c:11163 [inline]
 unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11042
 unregister_netdevice include/linux/netdevice.h:3115 [inline]
 unregister_netdev+0x1c/0x30 net/core/dev.c:11181
 bnep_session+0x2e09/0x3000 net/bluetooth/bnep/core.c:525
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x400000000 pfn:0x7bee9
flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000400000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), pid 5095, tgid -432259438 (syz-executor223), ts 5095, free_ts 96070220809
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 __kmalloc_large_node+0x91/0x1f0 mm/slub.c:3911
 __do_kmalloc_node mm/slub.c:3954 [inline]
 __kmalloc+0x320/0x4a0 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 hci_alloc_dev_priv+0x27/0x2030 net/bluetooth/hci_core.c:2500
 hci_alloc_dev include/net/bluetooth/hci_core.h:1672 [inline]
 __vhci_create_device drivers/bluetooth/hci_vhci.c:406 [inline]
 vhci_create_device+0x12e/0x720 drivers/bluetooth/hci_vhci.c:480
 vhci_get_user drivers/bluetooth/hci_vhci.c:537 [inline]
 vhci_write+0x3cb/0x480 drivers/bluetooth/hci_vhci.c:617
 call_write_iter include/linux/fs.h:2110 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa86/0xcb0 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5095 tgid 5095 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x986/0xab0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 __folio_put_large+0x13f/0x190 mm/swap.c:132
 __folio_put+0x299/0x390 mm/swap.c:140
 folio_put include/linux/mm.h:1506 [inline]
 free_large_kmalloc+0x105/0x1c0 mm/slub.c:4361
 kfree+0x1ca/0x3a0 mm/slub.c:4384
 hci_release_dev+0x1516/0x16a0 net/bluetooth/hci_core.c:2833
 bt_host_release+0x83/0x90 net/bluetooth/hci_sysfs.c:94
 device_release+0x9b/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x231/0x480 lib/kobject.c:737
 vhci_release+0x8b/0xd0 drivers/bluetooth/hci_vhci.c:675
 __fput+0x42b/0x8a0 fs/file_table.c:422
 task_work_run+0x251/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036

Memory state around the buggy address:
 ffff88807bee9480: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807bee9500: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88807bee9580: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                                ^
 ffff88807bee9600: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807bee9680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

