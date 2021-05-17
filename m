Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99EF382B40
	for <lists+linux-pm@lfdr.de>; Mon, 17 May 2021 13:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbhEQLio (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 May 2021 07:38:44 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49888 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbhEQLii (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 May 2021 07:38:38 -0400
Received: by mail-io1-f70.google.com with SMTP id z14-20020a6be20e0000b029043a04a24070so3056339ioc.16
        for <linux-pm@vger.kernel.org>; Mon, 17 May 2021 04:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=fzWof6NG8Kh47trWb40bJ/YHtNHenOjF35YU083dHvI=;
        b=fL9g5GJyUjJq2/vAVFHruiGuQd5QySdXueVCdsTGZPXQuqm9M04VvtifCi3jN4TliM
         l1GJ9346TvIRZ+5Djfc3Sqks5Y1F4HbKwEAnMJSRL0lYSuUHjKmwOIFDhXR7KlixNrOF
         BTNZgkgG7vAPJZ18RZ/60PaXfF31CWVujlSBUZj6ND8KUnyZmaoXfNeA6AcoIfnwBXDG
         g0CSFYRvzb1ctn9pkJ3FC15iCCrl3A4gjWkqcdleU8SQrtWk1mseVQzhRxMYUO5qrzGb
         sC2Yf5vfODABcOv4wLS3jxRnCB5DfUdInD+uawzli9wDPaKiZBb3NiZy3Rhpqc0AS4lg
         X8FQ==
X-Gm-Message-State: AOAM532rh3sY1wgbAkMbY5Xj5o20JbMJekGk5pxBkGDG825f4EFSYXta
        ar+jjs+UjZMfSO6Nj5RSSNqN2L2sAm5o7Zea3tn/cCzPnI8w
X-Google-Smtp-Source: ABdhPJz1ThHJpmHFL7Q4dp3DruEEXaJ0T5DIBsbIf1mwBmsn0gCQyC3HX9KWyfoj34cTvyGtAv9W6tr+A1H2ONPX3Vdhi0MbZLMp
MIME-Version: 1.0
X-Received: by 2002:a05:6602:114:: with SMTP id s20mr45649561iot.98.1621251442264;
 Mon, 17 May 2021 04:37:22 -0700 (PDT)
Date:   Mon, 17 May 2021 04:37:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ecea505c28504b9@google.com>
Subject: [syzbot] general protection fault in pm_qos_update_target
From:   syzbot <syzbot+f7d9295d2565ee819d21@syzkaller.appspotmail.com>
To:     len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pavel@ucw.cz, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dbb5afad ptrace: make ptrace() fail if the tracee changed ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108190add00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91ff0467ce169bc
dashboard link: https://syzkaller.appspot.com/bug?extid=f7d9295d2565ee819d21
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16c75e73d00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1274f41dd00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1174f41dd00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1674f41dd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f7d9295d2565ee819d21@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 9989 Comm: syz-executor.5 Not tainted 5.13.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__list_del_entry_valid+0x67/0x100 lib/list_debug.c:51
Code: 4c 89 f7 e8 9b a7 c6 fd 48 ba 00 01 00 00 00 00 ad de 49 8b 1e 48 39 d3 74 53 48 83 c2 22 49 39 d7 74 5d 4c 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 ff e8 6a a7 c6 fd 49 8b 17 4c 39 f2 75
RSP: 0018:ffffc9000bacf590 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880190e54c0
RDX: dead000000000122 RSI: ffffffff8cdeada0 RDI: ffff88802920b860
RBP: dffffc0000000000 R08: 0000000000000005 R09: ffffffff816335ff
R10: 0000000000000003 R11: ffff8880190e54c0 R12: dffffc0000000000
R13: 1ffff11005241709 R14: ffff88802920b858 R15: 0000000000000000
FS:  00007f133b30a700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff68face5c CR3: 0000000018b54000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_del_entry include/linux/list.h:132 [inline]
 list_del_init include/linux/list.h:204 [inline]
 plist_del+0x2e3/0x420 lib/plist.c:130
 pm_qos_update_target+0x20c/0x5c0 kernel/power/qos.c:114
 cpu_latency_qos_apply kernel/power/qos.c:247 [inline]
 cpu_latency_qos_remove_request+0x94/0xd0 kernel/power/qos.c:328
 snd_pcm_hw_free sound/core/pcm_native.c:842 [inline]
 snd_pcm_common_ioctl+0x62e5/0x9760 sound/core/pcm_native.c:3219
 snd_pcm_ioctl+0x86/0xa0 sound/core/pcm_native.c:3302
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665d9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f133b30a188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf60 RCX: 00000000004665d9
RDX: 0000000000000000 RSI: 0000000000004112 RDI: 0000000000000004
RBP: 00000000004bfcb9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf60
R13: 00007ffd68562d1f R14: 00007f133b30a300 R15: 0000000000022000
Modules linked in:
---[ end trace bc5d821852e61222 ]---
RIP: 0010:__list_del_entry_valid+0x67/0x100 lib/list_debug.c:51
Code: 4c 89 f7 e8 9b a7 c6 fd 48 ba 00 01 00 00 00 00 ad de 49 8b 1e 48 39 d3 74 53 48 83 c2 22 49 39 d7 74 5d 4c 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 ff e8 6a a7 c6 fd 49 8b 17 4c 39 f2 75
RSP: 0018:ffffc9000bacf590 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880190e54c0
RDX: dead000000000122 RSI: ffffffff8cdeada0 RDI: ffff88802920b860
RBP: dffffc0000000000 R08: 0000000000000005 R09: ffffffff816335ff
R10: 0000000000000003 R11: ffff8880190e54c0 R12: dffffc0000000000
R13: 1ffff11005241709 R14: ffff88802920b858 R15: 0000000000000000
FS:  00007f133b30a700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff68face5c CR3: 0000000018b54000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
