Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889FD423955
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 10:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbhJFIEq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Oct 2021 04:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbhJFIEq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Oct 2021 04:04:46 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E5AC061749;
        Wed,  6 Oct 2021 01:02:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oa4so887151pjb.2;
        Wed, 06 Oct 2021 01:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UbqTIpTFQS7aAGr3YM/8R5iSEHNaOAPGOgI0IFoknDk=;
        b=nKvwT6TPuRmOi2jKSnxpR7Hq5mIikmjHGB1au4acUDsayxsQQtSnc7j2EaLEGXaD0K
         LVdf9DFERU+oPFd2DZpTszwqsNrLnfIRg1YdpzTczeLYIYnTUM57NADWEWdOyyPZXV2o
         9K8bpChPL3RxfdUq5I9iUHPokB8P43cAVmWGEIMRfabkIC7fbDtoSzFQpnEFuvKKtyUU
         CxEfmGu1DDgUZDZ8iWGrMZDijNDCFcablv4WfybdgJ0cOXFh8yWPBhrcCcMChatdEZsA
         IhblRH68jEQdCrnkfHSJLS7jM8ChUZ+r54ydeOtU7hfNAtI7w23DkB8CQ68XF6JnAgtM
         MTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UbqTIpTFQS7aAGr3YM/8R5iSEHNaOAPGOgI0IFoknDk=;
        b=wAmkMrBV16RvkddhLqBC4JzeZiCLscEH7rl6pS2UCK/t+LJBhwr0TsVG87qntyV6S0
         KFVrdA9ofadw5IS1DrCtkFt8Vq/KGD9n5oMJj53kRpjKXUPqZP/8IoYLT765/BfcHEeh
         TpDNibOQWEaisGCtUzAf60kN7peunszGVAY/WMdKzysnHxErrLbq0fJuUhF1bTlWlz+C
         AiwR4m4/lUyN8wXrh4Gvl9XEcmC43VLsLY/WoGx8XqIfGQHOeaIyIIiOrU/266plCLs8
         6f5T7YtDsfw0aWCa3mUO4hXiCWxTJMTzQVcruJDLtAcRWDiUuNzLjxIYiVXqr7WwU2CK
         XzhQ==
X-Gm-Message-State: AOAM53343Dyxgztnl2IOXILmNLuiJliCZRIS1dtmdN0MAJCjCcZAEba1
        3lUtM7gAJVWJ6uIy2Cpeyup7xMU84+p3YmAO/A==
X-Google-Smtp-Source: ABdhPJwCZ1GZ36oC4PELmX4vJo6A0wL93AlBqlanAcU/f0tZbT41QjfmmpZvIQvS0nxCyATYROzMSyDfB5F54uvpaXs=
X-Received: by 2002:a17:90a:a78f:: with SMTP id f15mr9402337pjq.106.1633507374011;
 Wed, 06 Oct 2021 01:02:54 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 6 Oct 2021 16:02:43 +0800
Message-ID: <CACkBjsbe1=WzLQQvQ4zpjqwr=Yx20U7MWeMPMaK8RZ0t3+vTyg@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in __pm_runtime_resume
To:     Greg KH <gregkh@linuxfoundation.org>, len.brown@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-pm@vger.kernel.org, pavel@ucw.cz, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 0513e464f900 Merge tag 'perf-tools-fixes-for-v5.15-2021-09-27'
git tree: upstream
console output:
https://drive.google.com/file/d/1Dry825YkZ476I9qhMmrNcptbV66nxxJ0/view?usp=sharing
kernel config: https://drive.google.com/file/d/1Jqhc4DpCVE8X7d-XBdQnrMoQzifTG5ho/view?usp=sharing
Similar report:
https://syzkaller.appspot.com/bug?id=1bc76a5779300075e3466a0e2abcd753df212779

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

Bluetooth: : Invalid header checksum
BUG: kernel NULL pointer dereference, address: 0000000000000388
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 18801067 P4D 18801067 PUD 18802067 PMD 0
Oops: 0002 [#1] PREEMPT SMP
CPU: 3 PID: 769 Comm: kworker/u10:3 Not tainted 5.15.0-rc3+ #21
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events_unbound flush_to_ldisc
RIP: 0010:arch_atomic_inc arch/x86/include/asm/atomic.h:95 [inline]
RIP: 0010:atomic_inc include/linux/atomic/atomic-instrumented.h:182 [inline]
RIP: 0010:__pm_runtime_resume+0x34/0xa0 drivers/base/power/runtime.c:1105
Code: fb e8 90 dc d4 fe 40 f6 c5 01 75 0e e8 85 dc d4 fe f6 83 91 03
00 00 04 74 4e e8 77 dc d4 fe 40 f6 c5 04 74 0c e8 6c dc d4 fe <f0> ff
83 88 03 00 00 e8 60 dc d4 fe 4c 8d a3 e8 01 00 00 4c 89 e7
RSP: 0018:ffffc90002807cf8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8881007b2280 RSI: ffffffff8262b4f4 RDI: 0000000000000000
RBP: 0000000000000005 R08: 0000000000082a20 R09: 00000000ffffffff
R10: ffffffff8369c890 R11: 0000000000000005 R12: ffff88811220802e
R13: ffff88811220b800 R14: ffff88811083f000 R15: 0000000000000040
FS:  0000000000000000(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000388 CR3: 0000000018800000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 pm_runtime_get include/linux/pm_runtime.h:374 [inline]
 h5_recv+0x9e/0x260 drivers/bluetooth/hci_h5.c:590
 hci_uart_tty_receive+0xfc/0x370 drivers/bluetooth/hci_ldisc.c:613
 tty_ldisc_receive_buf+0x89/0x90 drivers/tty/tty_buffer.c:475
 tty_port_default_receive_buf+0x50/0x80 drivers/tty/tty_port.c:39
 receive_buf drivers/tty/tty_buffer.c:491 [inline]
 flush_to_ldisc+0xda/0x130 drivers/tty/tty_buffer.c:543
 process_one_work+0x359/0x850 kernel/workqueue.c:2297
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: 0000000000000388
---[ end trace f71af1d10b9bdcd8 ]---
RIP: 0010:arch_atomic_inc arch/x86/include/asm/atomic.h:95 [inline]
RIP: 0010:atomic_inc include/linux/atomic/atomic-instrumented.h:182 [inline]
RIP: 0010:__pm_runtime_resume+0x34/0xa0 drivers/base/power/runtime.c:1105
Code: fb e8 90 dc d4 fe 40 f6 c5 01 75 0e e8 85 dc d4 fe f6 83 91 03
00 00 04 74 4e e8 77 dc d4 fe 40 f6 c5 04 74 0c e8 6c dc d4 fe <f0> ff
83 88 03 00 00 e8 60 dc d4 fe 4c 8d a3 e8 01 00 00 4c 89 e7
RSP: 0018:ffffc90002807cf8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8881007b2280 RSI: ffffffff8262b4f4 RDI: 0000000000000000
RBP: 0000000000000005 R08: 0000000000082a20 R09: 00000000ffffffff
R10: ffffffff8369c890 R11: 0000000000000005 R12: ffff88811220802e
R13: ffff88811220b800 R14: ffff88811083f000 R15: 0000000000000040
FS:  0000000000000000(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000388 CR3: 0000000018800000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
----------------
Code disassembly (best guess):
   0: fb                    sti
   1: e8 90 dc d4 fe        callq  0xfed4dc96
   6: 40 f6 c5 01          test   $0x1,%bpl
   a: 75 0e                jne    0x1a
   c: e8 85 dc d4 fe        callq  0xfed4dc96
  11: f6 83 91 03 00 00 04 testb  $0x4,0x391(%rbx)
  18: 74 4e                je     0x68
  1a: e8 77 dc d4 fe        callq  0xfed4dc96
  1f: 40 f6 c5 04          test   $0x4,%bpl
  23: 74 0c                je     0x31
  25: e8 6c dc d4 fe        callq  0xfed4dc96
* 2a: f0 ff 83 88 03 00 00 lock incl 0x388(%rbx) <-- trapping instruction
  31: e8 60 dc d4 fe        callq  0xfed4dc96
  36: 4c 8d a3 e8 01 00 00 lea    0x1e8(%rbx),%r12
  3d: 4c 89 e7              mov    %r12,%rdi
