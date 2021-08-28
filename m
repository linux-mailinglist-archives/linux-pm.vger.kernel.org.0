Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A29C3FA3BB
	for <lists+linux-pm@lfdr.de>; Sat, 28 Aug 2021 06:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhH1EpQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 28 Aug 2021 00:45:16 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:49832 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhH1EpQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 28 Aug 2021 00:45:16 -0400
Received: by mail-io1-f70.google.com with SMTP id k6-20020a6b3c060000b0290568c2302268so5302725iob.16
        for <linux-pm@vger.kernel.org>; Fri, 27 Aug 2021 21:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JV7h5CQOr+nuXXZ8H13qPIBPgqFcVEsgvYOpM06/UEI=;
        b=mA2CKAeexa/ByHXVi+jzPimdkW6GXggLCSTpWivEBWgOjN1SyaJbuEN51J5n1RHgnb
         lRg3vyq+D+CAyz9+0Okw4WTHbCy1lJuYdB5XktUXFlMPvXbBet3Ah6b9yyo4ZYSH5X6B
         K6fKXpmO/kVVWtdRxMPd+qruTIKCLRtyTyL3vrvj/9cdQJXZDIlQyvoA62hRBxcyhH7n
         Y2WJ49wJLocHmpGJM2SaUeddhR9ohu2ID2KD7KNvC/ogRCTzjP5EsnuFf5sqGVY869sO
         0sFNx9b5zomlJAGj+vJeObChGDaknyuJAZI6uzPmxjlINELBjZ+kUZ+QPS9QtDy1oDkv
         H0Ng==
X-Gm-Message-State: AOAM533tx7MtcjkDLpN9Qlpa+3qi+Vcsgmjfd0pUtjdRw9ikvvYlHIcp
        8ndiMgMJpQO/JighVpmjpyUC9TzpVUTX7YKIwlRz1Uv2cUs8
X-Google-Smtp-Source: ABdhPJzHxr32HLgq7+E3KnzmlIQt/NZpNY7kLZyt9dJ8h3MgC8vTjHHV/rOjEIiA5zU2eCqbZSevYwX5u6bm+DWQWzT9qEjCUNGz
MIME-Version: 1.0
X-Received: by 2002:a92:7f0f:: with SMTP id a15mr8811837ild.245.1630125866379;
 Fri, 27 Aug 2021 21:44:26 -0700 (PDT)
Date:   Fri, 27 Aug 2021 21:44:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034712e05ca9741e8@google.com>
Subject: [syzbot] KASAN: null-ptr-deref Write in __pm_runtime_resume
From:   syzbot <syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, len.brown@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    5e63226c7228 Add linux-next specific files for 20210827
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=123771b1300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c03a8fdabc6b3ae
dashboard link: https://syzkaller.appspot.com/bug?extid=7d41312fe3f123a6f605
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7d41312fe3f123a6f605@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: null-ptr-deref in atomic_inc include/linux/atomic/atomic-instrumented.h:181 [inline]
BUG: KASAN: null-ptr-deref in __pm_runtime_resume+0x154/0x180 drivers/base/power/runtime.c:1105
Write of size 4 at addr 0000000000000388 by task syz-executor.1/8810

CPU: 0 PID: 8810 Comm: syz-executor.1 Not tainted 5.14.0-rc7-next-20210827-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __kasan_report mm/kasan/report.c:446 [inline]
 kasan_report.cold+0x66/0xdf mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_inc include/linux/atomic/atomic-instrumented.h:181 [inline]
 __pm_runtime_resume+0x154/0x180 drivers/base/power/runtime.c:1105
 pm_runtime_get include/linux/pm_runtime.h:370 [inline]
 h5_recv+0x2c4/0x680 drivers/bluetooth/hci_h5.c:590
 hci_uart_tty_receive+0x24d/0x710 drivers/bluetooth/hci_ldisc.c:613
 tiocsti drivers/tty/tty_io.c:2311 [inline]
 tty_ioctl+0x8db/0x1600 drivers/tty/tty_io.c:2719
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4665f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc6badab188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665f9
RDX: 00000000200000c0 RSI: 0000000000005412 RDI: 0000000000000003
RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
R13: 00007ffe925987cf R14: 00007fc6badab300 R15: 0000000000022000
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
