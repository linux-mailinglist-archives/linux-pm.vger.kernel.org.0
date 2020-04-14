Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8041A81C0
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 17:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437674AbgDNPNm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Apr 2020 11:13:42 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:55607 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437288AbgDNPNP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Apr 2020 11:13:15 -0400
Received: by mail-io1-f70.google.com with SMTP id f4so7117375iov.22
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2020 08:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4bd4gGbYFPD8Vgj5mhiYerb95l8W8erwkDbv2sntZe4=;
        b=Bfrm45x/QbCJKItAabJlURyD1/iIr2RWRaXQ63ARPS9n3kvdzklFkBKEIwPnkmdQJV
         8jZ747l/ecgGrmmWCdgNft8W+Sp7uxEETacZ3mC+qQ2TptveMtvfehlvJ+ZlDG/BgCLP
         gK73jREYguVbSXjU1GY8776E3+7GQ0XXh42OrzkAYFK0pIFPevlRj/bsT1tr9kDF+/2H
         mbtYtkSOukQ5VOYa1BmItG1+4A2WM7WquL36/9IJuIuuhnnEFRoYqfNE5tS+ljG6y8G4
         uq+cfiVnicokz706ApJVarnw7bKVGVhTSQU+hqES9XI38w5UyUg/XIWNyDx8/8xlmc2v
         IEnA==
X-Gm-Message-State: AGi0Pua54k7yuJV47+tJbAHPFjKxUU4CIbV2WCvLIIgwLCpI1y0sHtq9
        aNDueVhaRXYj+qGQz2TDgk2XrVG6nx5wC3Osf4Q45o2liYgR
X-Google-Smtp-Source: APiQypLIzsH7qfTHqPmsTuLm4Q0+Sm9UqavdIUvKbyeJX958xaaFJ/mQ5uH3tn0w9O/2o5J3WnZ39jpgRGPQHF3fODfgTs3DKlmG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4c:: with SMTP id i12mr656378ilr.185.1586877194034;
 Tue, 14 Apr 2020 08:13:14 -0700 (PDT)
Date:   Tue, 14 Apr 2020 08:13:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073e9c305a341a39a@google.com>
Subject: WARNING in cpu_latency_qos_remove_request
From:   syzbot <syzbot+6e2d4fbfbf03293bb776@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=10834007e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23c5a352e32a1944
dashboard link: https://syzkaller.appspot.com/bug?extid=6e2d4fbfbf03293bb776
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fbbffbe00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6e2d4fbfbf03293bb776@syzkaller.appspotmail.com

------------[ cut here ]------------
cpu_latency_qos_remove_request called for unknown object
WARNING: CPU: 1 PID: 9086 at kernel/power/qos.c:322 cpu_latency_qos_remove_request+0x59/0x380 kernel/power/qos.c:322
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 9086 Comm: syz-executor.2 Not tainted 5.6.0-syzkaller #0
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
RIP: 0010:cpu_latency_qos_remove_request+0x59/0x380 kernel/power/qos.c:322
Code: 02 00 0f 85 f4 02 00 00 48 81 7d 28 80 97 9a 89 74 25 e8 3a 85 18 00 48 c7 c6 20 fc 2b 88 48 c7 c7 20 f8 2b 88 e8 4f b9 e9 ff <0f> 0b 5b 5d 41 5c 41 5d e9 1a 85 18 00 e8 15 85 18 00 0f 1f 44 00
RSP: 0018:ffffc90002717bb0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815cd551 RDI: fffff520004e2f68
RBP: ffff8880a3644840 R08: ffff8880a2b04300 R09: ffffed1015ce66a9
R10: ffff8880ae733547 R11: ffffed1015ce66a8 R12: ffff8880a3644800
R13: ffff8880a36449e4 R14: 1ffff920004e2f85 R15: 0000000000000000
 snd_pcm_hw_free sound/core/pcm_native.c:827 [inline]
 snd_pcm_common_ioctl+0xb32/0x2260 sound/core/pcm_native.c:3192
 snd_pcm_ioctl_compat+0x70b/0x10d0 sound/core/pcm_compat.c:532
 __do_compat_sys_ioctl fs/ioctl.c:857 [inline]
 __se_compat_sys_ioctl fs/ioctl.c:808 [inline]
 __ia32_compat_sys_ioctl+0x23d/0x2b0 fs/ioctl.c:808
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
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
