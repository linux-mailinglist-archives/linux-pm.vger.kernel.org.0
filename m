Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C9742D07F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 04:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhJNChh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 22:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhJNChf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 22:37:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE0BC061746;
        Wed, 13 Oct 2021 19:35:31 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ls18so3667850pjb.3;
        Wed, 13 Oct 2021 19:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dpYv7gDpakM2AgTSNuQ5HDLtgSxqC2BBHSYdjqaIOQ4=;
        b=dzlk0L2vzEloUNICIubm9OZjNxOLOSbBsu1tom2k0LL6KWI7VRjSzl2QOGmH00MRwM
         WhgfNg+P2qFCk5x+omUXO5j43nKkZQGFOv1Q1bhv2srm+XTJo06WvdTeJlNdrqdUYuq4
         gk5FrYeSKHIf160ysTT3ehrvqozNTm8eyO3fQ5LIgbZ+HuVcfMvk2ZzaW5x3sGafqaw4
         zC6tcPq3oyQ+pk/77y+Q0MPfyIWhczQAyJxJ9xz+18RAiHvSc13IzfnFB12mms04kpeh
         S1tIr2oOo7UCzoxPu3P8YIarSwYXg6+eFkPnzqCV1pOsY+p+g8EO+0Z5mTtp7EESKgwq
         dKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dpYv7gDpakM2AgTSNuQ5HDLtgSxqC2BBHSYdjqaIOQ4=;
        b=He8eGpCroUiIlrsbYJyiRx+g6ZByS4bbyfv8rdousxe5KoCFa5Gg2StbmnnwKlcC8s
         XPFtgXFph0ZIDaXfUKCezWBbzuaHgI9j1CfNMVVUDpvxTZXBfU4SQ1iGMIRKIDW0yF+Q
         xpXCRkPzQrBhAG6BuzwSw9mK+90QPEdF+zZbbVfFS/iqbjKIsmHrrQUmeIFXnfoYIunr
         GHzrYmqhN3Ypql0WquizenQ62fH8kKzJOrBe58iAzWZcjbMyS0mGztMlkRI8jerOtTXO
         C5PMMRYB9ODrhiny5Wnmw8CASuado4cQu2oTvGfI88NoUTGbLgSCGtw5dQe5AX+kBHdd
         uAcQ==
X-Gm-Message-State: AOAM533dlIQ+68YuMF1ELN6Mkq2d/LUBI5hbskUIbV3L0Emedj9W4O7r
        wO20Z+UU3zfVqSYNYYAcEj4qYe5LLAN+Fzy6Ww==
X-Google-Smtp-Source: ABdhPJxZRFvasyeb0vuKlwiaJRXqCNnH+ST+lbRrOiocj/SOe/yXMN6M19eQc/16EbCXTtMbKhm5x4RPHB+MBxwj5Yo=
X-Received: by 2002:a17:90b:17ce:: with SMTP id me14mr3403486pjb.112.1634178930931;
 Wed, 13 Oct 2021 19:35:30 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 14 Oct 2021 10:35:20 +0800
Message-ID: <CACkBjsZ+n6KZW7WFsKqJ-c13nsZ0shMZDxfDW6a+m6Jp+ENKoQ@mail.gmail.com>
Subject: KASAN: null-ptr-deref Write in __pm_runtime_resume
To:     Greg KH <gregkh@linuxfoundation.org>, len.brown@intel.com,
        linux-pm@vger.kernel.org, rafael@kernel.org, pavel@ucw.cz
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
console output:
https://drive.google.com/file/d/1PxZuz-gH7uq_cTOv4acy5QHJJdeDLtUP/view?usp=sharing
kernel config: https://drive.google.com/file/d/1em3xgUIMNN_-LUUdySzwN-UDPc3qiiKD/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1MvRSzjAxkpHTM5OheyQQOjSEsLdSNsFl/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1tL_4a8DbjmlbQ7pylunO9cCp24bFNh9k/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

Bluetooth: : Invalid header checksum
Bluetooth: : Invalid header checksum
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read_write
include/linux/instrumented.h:101 [inline]
BUG: KASAN: null-ptr-deref in atomic_inc
include/linux/atomic/atomic-instrumented.h:181 [inline]
BUG: KASAN: null-ptr-deref in __pm_runtime_resume+0x132/0x180
drivers/base/power/runtime.c:1105
Write of size 4 at addr 0000000000000388 by task kworker/u9:4/661

CPU: 0 PID: 661 Comm: kworker/u9:4 Not tainted 5.15.0-rc5 #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __kasan_report mm/kasan/report.c:446 [inline]
 kasan_report.cold+0x66/0xdf mm/kasan/report.c:459
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x14e/0x1b0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_inc include/linux/atomic/atomic-instrumented.h:181 [inline]
 __pm_runtime_resume+0x132/0x180 drivers/base/power/runtime.c:1105
 pm_runtime_get include/linux/pm_runtime.h:374 [inline]
 h5_recv+0x2c4/0x680 drivers/bluetooth/hci_h5.c:590
 hci_uart_tty_receive+0x24d/0x710 drivers/bluetooth/hci_ldisc.c:613
 tty_ldisc_receive_buf+0x14d/0x190 drivers/tty/tty_buffer.c:475
 tty_port_default_receive_buf+0x6e/0xa0 drivers/tty/tty_port.c:39
 receive_buf drivers/tty/tty_buffer.c:491 [inline]
 flush_to_ldisc+0x20d/0x380 drivers/tty/tty_buffer.c:543
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2297
 worker_thread+0x90/0xed0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
==================================================================
