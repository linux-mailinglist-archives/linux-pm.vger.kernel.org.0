Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8CD1A7BC4
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 15:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502570AbgDNNGZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 09:06:25 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:52113 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502563AbgDNNGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 09:06:16 -0400
Received: by mail-io1-f69.google.com with SMTP id s1so14517465iow.18
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 06:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WGQ3SBJwnf5YlDpIwsgsa30mhVfEOL2HbfrgyzxLGnc=;
        b=OL0MKNjzEgIYaTZ2obp92Znrers5g1+dWkxa2oR9jbFxHbjNBh2zAhJoiR89MUriyS
         R+JZNFYpHOIP/4XwW6292C7LbvJYdf7L3OYwEOVYdiOGJ9HL26nXr56fBWFD6SCqldAf
         BHMGyRn/i5dQo7/Bsssk+M1kOFDadJTotHzX/HwqWCEF543kfR1oMFmsKIPSuzBfSWGq
         rnDuswcf9Mo5NFGjz+aZuvsbvGxmvHWO1MdtyzwnqvhKQhANh6aQcACqFvBca0N/jKNS
         C/H8epLouRwsltOtkakL//GXPsFb1yWrS3UtU9UKE9l4AmvRXeppLMhc+7Zo2SPFyxnJ
         d+CQ==
X-Gm-Message-State: AGi0PuaXgEXqc2SojrdQbnd/bCgA2heoWXTJzfGe7RNXeTx4KuxUpeJM
        L8YVnpXAe0VpCP65a0J2/0Q+ix3vKDd2eYVzuB7+UJYkqpRf
X-Google-Smtp-Source: APiQypJhM6Ooj+LDG0cOS+J2eVV/xc3nBrVxB8AaWinUc083RZNukheeDbjpO8n8EebTcWpWn6KhKsXwn1rfWItyQs/rkAkmoVwg
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2a56:: with SMTP id k22mr530410iov.22.1586869575527;
 Tue, 14 Apr 2020 06:06:15 -0700 (PDT)
Date:   Tue, 14 Apr 2020 06:06:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ab2f105a33fdd82@google.com>
Subject: WARNING in plist_check_prev_next
From:   syzbot <syzbot+9c64e877cca5f208807f@syzkaller.appspotmail.com>
To:     len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pavel@ucw.cz, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c0cc2711 Merge tag 'modules-for-v5.7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1600bdb3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23c5a352e32a1944
dashboard link: https://syzkaller.appspot.com/bug?extid=9c64e877cca5f208807f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9c64e877cca5f208807f@syzkaller.appspotmail.com

------------[ cut here ]------------
top: 00000000dcea6c9a, n: 0000000093c70fdb, p: 0000000013dbca61
prev: 00000000dcea6c9a, n: 0000000093c70fdb, p: 0000000013dbca61
next: 0000000093c70fdb, n: 0000000093c70fdb, p: 0000000093c70fdb
WARNING: CPU: 1 PID: 30481 at lib/plist.c:35 plist_check_prev_next+0x108/0x1a0 lib/plist.c:35
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 30481 Comm: syz-executor.3 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:plist_check_prev_next+0x108/0x1a0 lib/plist.c:35
Code: df 48 c1 ee 03 80 3c 16 00 75 6c 49 8b 14 24 41 55 4d 89 f1 49 89 d8 50 4c 89 e6 48 c7 c7 80 20 fc 88 55 41 57 e8 60 52 7b f9 <0f> 0b 48 83 c4 20 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 1f
RSP: 0018:ffffc90007d9f8d0 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffffffff899a9780 RCX: 0000000000000000
RDX: 0000000000020c0b RSI: ffffffff815cd551 RDI: fffff52000fb3f0c
RBP: ffff8880a8479858 R08: ffff8880673a60c0 R09: ffffed1015ce45f1
R10: ffff8880ae722f83 R11: ffffed1015ce45f0 R12: ffffffff899a9780
R13: ffff8880a8479858 R14: ffff8880a8479858 R15: ffffffff8bbc3ed8
 plist_check_list+0x41/0xa0 lib/plist.c:48
 plist_add+0x2f/0x4e0 lib/plist.c:78
 pm_qos_update_target+0x4ac/0x5d0 kernel/power/qos.c:125
 cpu_latency_qos_apply+0x40/0x70 kernel/power/qos.c:247
 cpu_latency_qos_add_request+0xf1/0x3c0 kernel/power/qos.c:277
 snd_pcm_hw_params+0x173c/0x1da0 sound/core/pcm_native.c:757
 snd_pcm_kernel_ioctl+0xd1/0x240 sound/core/pcm_native.c:3305
 snd_pcm_oss_change_params_locked+0x1328/0x34b0 sound/core/oss/pcm_oss.c:941
 snd_pcm_oss_make_ready_locked+0xb3/0x130 sound/core/oss/pcm_oss.c:1166
 snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1384 [inline]
 snd_pcm_oss_write+0x43b/0x8c0 sound/core/oss/pcm_oss.c:2765
 __vfs_write+0x76/0x100 fs/read_write.c:495
 vfs_write+0x268/0x5d0 fs/read_write.c:559
 ksys_write+0x12d/0x250 fs/read_write.c:612
 do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
 do_fast_syscall_32+0x270/0xe90 arch/x86/entry/common.c:396
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
