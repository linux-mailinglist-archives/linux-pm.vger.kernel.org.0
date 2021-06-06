Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963DD39CE2E
	for <lists+linux-pm@lfdr.de>; Sun,  6 Jun 2021 10:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFFIvI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Jun 2021 04:51:08 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:38587 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhFFIvH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Jun 2021 04:51:07 -0400
Received: by mail-il1-f200.google.com with SMTP id g13-20020a056e020d0db02901e28b9a6ae8so9812626ilj.5
        for <linux-pm@vger.kernel.org>; Sun, 06 Jun 2021 01:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3fkxxtONOcltbxGELVRZttHeuDg/ooRlUEJGK7DDlkw=;
        b=aIHfAAIR2jB5OQMS+heyCcmJ/IHKg5Dozx4/JwC1XRqtPxNhhbt0kfq08AiY67NMoN
         jl0QWK/JMRxrA6ZX8MZP048DpUpfPV7tVi3uuDF1nCwR4kKU9PhQ6IfbxmVtNE7O2o9N
         Fyfu3g7EDLLuotH8pgao74PdUKMgrbkUhPP2n6+eLUtc7BdwpYJ9naC6Bv31m/tpvs8W
         I+KsHId8A2Czqow+jgORk26iA7oVL5eP9QBxez5I8CTmIfDFuwQ4N3/utdrIxNpq8Bmi
         BkS70cld5UfnX0GNccByaG6/Pvm5bmOgxsvhcLZvWTgK/Tfy8i6+YSlUtGEarM7OlKu9
         LVdA==
X-Gm-Message-State: AOAM531r31SqDDE++BZcQF+f6Z5NZOJqm8S6cYWOz5kyH57d4OWKphG8
        ya/cJuvZuO8gWiliSMRnvWQLVph/Mhr5bJNUiW2x+ZmL1Mue
X-Google-Smtp-Source: ABdhPJwlGUz+uO1cr7JpdZY2YFh0le2aLsXzM2TacBAZa1XrdQEN4HPR/8NRr3JE3k3pCWwwmnrplq3XDEFmUeNFJ64awlk1O/NU
MIME-Version: 1.0
X-Received: by 2002:a6b:7d0b:: with SMTP id c11mr10378089ioq.8.1622969358063;
 Sun, 06 Jun 2021 01:49:18 -0700 (PDT)
Date:   Sun, 06 Jun 2021 01:49:18 -0700
In-Reply-To: <00000000000073e9c305a341a39a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000119d4505c4150042@google.com>
Subject: Re: [syzbot] WARNING in cpu_latency_qos_remove_request
From:   syzbot <syzbot+6e2d4fbfbf03293bb776@syzkaller.appspotmail.com>
To:     len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pavel@ucw.cz, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a1f92694 Add linux-next specific files for 20210518
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12e1f4e0300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d612e75ffd53a6d3
dashboard link: https://syzkaller.appspot.com/bug?extid=6e2d4fbfbf03293bb776
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12897d33d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177199afd00000

The issue was bisected to:

commit c20037652700024cffeb6b0f74306ce9b391248f
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Mar 7 20:20:29 2020 +0000

    Merge tag 'io_uring-5.6-2020-03-07' of git://git.kernel.dk/linux-block

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a8bdb3e00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a8bdb3e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a8bdb3e00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e2d4fbfbf03293bb776@syzkaller.appspotmail.com
Fixes: c20037652700 ("Merge tag 'io_uring-5.6-2020-03-07' of git://git.kernel.dk/linux-block")

------------[ cut here ]------------
cpu_latency_qos_remove_request called for unknown object
WARNING: CPU: 0 PID: 8994 at kernel/power/qos.c:322 cpu_latency_qos_remove_request+0x50/0x80 kernel/power/qos.c:322
Modules linked in:
CPU: 0 PID: 8994 Comm: syz-executor649 Not tainted 5.13.0-rc2-next-20210518-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:cpu_latency_qos_remove_request+0x50/0x80 kernel/power/qos.c:322
Code: ea 03 80 3c 02 00 75 3d 48 81 7d 28 20 0b 08 8c 74 20 e8 83 de 19 00 48 c7 c6 60 24 8c 89 48 c7 c7 c0 1f 8c 89 e8 4b ca 7f 07 <0f> 0b 5d e9 68 de 19 00 e8 63 de 19 00 48 89 ef e8 ab fc ff ff 5d
RSP: 0018:ffffc90001adfd40 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888021ef1c80 RSI: ffffffff815dbea5 RDI: fffff5200035bf9a
RBP: ffff8880279fd040 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815d5cee R11: 0000000000000000 R12: ffff8880279fd000
R13: ffff8880279fd1e4 R14: 1ffff9200035bfb4 R15: 0000000000000000
FS:  0000000001ee0300(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000458dc0 CR3: 0000000021b24000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 snd_pcm_hw_free sound/core/pcm_native.c:842 [inline]
 snd_pcm_common_ioctl+0x19d8/0x3330 sound/core/pcm_native.c:3219
 snd_pcm_ioctl+0x7e/0xb0 sound/core/pcm_native.c:3302
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_64+0x31/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x444639
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe82f2e568 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 0000000000444639
RDX: 0000000000000000 RSI: 0000000000004112 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000012b9e
R13: 00007ffe82f2e57c R14: 00007ffe82f2e590 R15: 00007ffe82f2e580

