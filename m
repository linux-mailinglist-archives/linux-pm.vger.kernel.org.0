Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9819170394
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 16:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgBZP7O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Feb 2020 10:59:14 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:51393 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgBZP7O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 10:59:14 -0500
Received: by mail-il1-f198.google.com with SMTP id c12so4674746ilr.18
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2020 07:59:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Y1ebUHzTdnuJBounAIPYWFXHiCdLik50ghAjZZcergI=;
        b=FtQO6SBWCKU4pcmqXpkIYhQfOQz4yiFge6AcdMK+V2gGjD49n7N04/QZHhjBSkLjqG
         XFiwt1VDEy19dtoj3XkAfJNWhl6F/OERTfsOqr9QVqHvgf3m4AqoYP/vS5v9iFpdjZba
         GEIJJDVKuGKVFtXV+MlgQzycETp7Jsea7HW2a1uwkuCMqxK/hWm4vE/xt3PWeikPLBcJ
         f8AR2bK1aDrCXlcuJbywRFMiwU2w9rKqr6qR7sHMF0uHuNF7aEl17jO285k5CNJp5/7f
         gll2xK84yJtfVux7YptKTxkzgIyakndzaxpl6S1/0B4GAvndpOloTVsNak6hdAbA3Zap
         2mAw==
X-Gm-Message-State: APjAAAXn9VN2YrqZDefcGtr0s/KtP5eQo/xJR1b3/7BVJmLqYNaoILdO
        PnIyFwyRYh/rQ07rmlfHQP6u2sCigYyXm9/5/GKcoCVQonOb
X-Google-Smtp-Source: APXvYqw6iqnJkkGXD5uez2BWl4BIo6Jlqc4yunnpKTvjaytEUJ4dAyrrbSfc68KNzaryHWw0Fq31Go8BGqHnwH3y392uN1e53A/g
MIME-Version: 1.0
X-Received: by 2002:a02:880c:: with SMTP id r12mr5265816jai.131.1582732753994;
 Wed, 26 Feb 2020 07:59:13 -0800 (PST)
Date:   Wed, 26 Feb 2020 07:59:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000938a57059f7cafe4@google.com>
Subject: KMSAN: uninit-value in snapshot_compat_ioctl
From:   syzbot <syzbot+af962bf9e7e27bccd025@syzkaller.appspotmail.com>
To:     glider@google.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8bbbc5cf kmsan: don't compile memmove
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11514265e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd0e9a6b0e555cc3
dashboard link: https://syzkaller.appspot.com/bug?extid=af962bf9e7e27bccd025
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a89109e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176f774ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+af962bf9e7e27bccd025@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in kmsan_check_memory+0xd/0x10 mm/kmsan/kmsan_hooks.c:413
CPU: 1 PID: 11659 Comm: syz-executor923 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 kmsan_internal_check_memory+0x358/0x3d0 mm/kmsan/kmsan.c:457
 kmsan_check_memory+0xd/0x10 mm/kmsan/kmsan_hooks.c:413
 snapshot_compat_ioctl+0x559/0x650 kernel/power/user.c:422
 __do_compat_sys_ioctl fs/ioctl.c:857 [inline]
 __se_compat_sys_ioctl+0x57c/0xed0 fs/ioctl.c:808
 __ia32_compat_sys_ioctl+0xd9/0x110 fs/ioctl.c:808
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f70d99
Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000ffec145c EFLAGS: 00000213 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000080083313
RDX: 0000000000000000 RSI: 00000000080ea078 RDI: 00000000ffec14b0
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Uninit was stored to memory at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
 __msan_chain_origin+0x50/0x90 mm/kmsan/kmsan_instr.c:165
 snapshot_compat_ioctl+0x5e0/0x650 kernel/power/user.c:422
 __do_compat_sys_ioctl fs/ioctl.c:857 [inline]
 __se_compat_sys_ioctl+0x57c/0xed0 fs/ioctl.c:808
 __ia32_compat_sys_ioctl+0xd9/0x110 fs/ioctl.c:808
 do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
 do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
 entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139

Local variable ----offset@snapshot_compat_ioctl created at:
 get_current arch/x86/include/asm/current.h:15 [inline]
 snapshot_compat_ioctl+0x324/0x650 kernel/power/user.c:418
 get_current arch/x86/include/asm/current.h:15 [inline]
 snapshot_compat_ioctl+0x324/0x650 kernel/power/user.c:418

Bytes 0-7 of 8 are uninitialized
Memory access of size 8 starts at ffff9946c156bd30
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
