Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58546032C
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 11:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfGEJhR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 05:37:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40826 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbfGEJhQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 05:37:16 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so9657244iom.7
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2019 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vw6dqlz5AQh19iWs1fP2phxHi5N3sf2U6HwsMEsBlk=;
        b=OF53/H53SyjrSxyvxkDBRDfFDFAUB2gg1hcwYrfTdFZaXJdoM1qVsKz4m81GNdidUu
         ZHCiVKGRuD4WU6kedY9yzgvOON+PMisJ4rSEUKjG84R7xQNS5p4Ixz1WMXfHituVBPcD
         /ENmGWPzVvmqnjbJ1VjyDnJP2HhhztJUOM1cBGWQC/7jdXwGSaQgyL28xsJlySqUha3w
         JWRNPuQBgl/HXAzF9WlDSaxtKh0Z221w6Q29ZYgwPMvn97MH5bLvM+noJ3A+K3YQi0CO
         UyjdSy/NwxWMUw49vOyZE5QkH1IEz3XBuia8OmmUeAfK1iO0OEaoSf+oq94jEAjIKl2A
         /Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vw6dqlz5AQh19iWs1fP2phxHi5N3sf2U6HwsMEsBlk=;
        b=tN3ZaoC6qi31i0rQ7byGEhfkLNlck9hW9lPC4z6mZOftPn3uMAHjjRaJ0P+9pq8eop
         Yn6KYbEh/6Fot2vGHTO/8snb6mVm4I3+JPhNa/eEdIhuv8+8FWWbFchfUpQwegSHyhjo
         S9ZJMCZS3TTES5lJGALRbWFORQtAjGl2Ep5p6LQT4SeSZcoourn3WC1hRBt56CWDMP8N
         6iw4DP5qeJ8qb9z8ETg1o1i5BHUZvUKnCDnhljnGJHqS/hMC5OlaSdQl0ljl8sS4Z8b0
         H4sat1oGyaXmJzsWZb1+5qIqpGcM7V7qCu3V2SHT1+heiTRUdGqwECPTEY7YT8mHYoFV
         sIbA==
X-Gm-Message-State: APjAAAVfklUR0otvCjtX546LgZvvnuCjjp3/CCmClxSfhLqV4fGP/jcS
        0rZoLv4dtwxHA3LYX6TRaTPPpXVrM1l9CP8H+HY29g==
X-Google-Smtp-Source: APXvYqyf6YyPZzEuLuWMf/F9c1sfpHKI5GlN48qxjg5Wdx5RmM8EI1GripT73jsGQuvPk60GnwxLSk3+OQeF8FCS+1c=
X-Received: by 2002:a5e:c241:: with SMTP id w1mr2959734iop.58.1562319435635;
 Fri, 05 Jul 2019 02:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005bf6c3058cde49a7@google.com> <8755905.1UUJr7qOyo@kreacher>
In-Reply-To: <8755905.1UUJr7qOyo@kreacher>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 5 Jul 2019 11:37:04 +0200
Message-ID: <CACT4Y+awzZOSAseosiUDvs_zk7hFRuQrrr0LjRmVwesVbF_+aQ@mail.gmail.com>
Subject: Re: linux-next boot error: WARNING in corrupted
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     syzbot <syzbot+de771ae9390dffed7266@syzkaller.appspotmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 5, 2019 at 11:23 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Thursday, July 4, 2019 7:27:04 PM CEST syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    16c474c9 Add linux-next specific files for 20190704
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17f8b463a00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=983f02aae1ef31b6
> > dashboard link: https://syzkaller.appspot.com/bug?extid=de771ae9390dffed7266
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+de771ae9390dffed7266@syzkaller.appspotmail.com
> >
...
> > ------------[ cut here ]------------
> > __dev_pm_qos_remove_request() called for unknown object
> > WARNING: CPU: 1 PID: 1 at drivers/base/power/qos.c:486
> > __dev_pm_qos_remove_request+0x3d3/0x4d0 drivers/base/power/qos.c:486
>
> Viresh, any chance to look at this?
>
> I'm a bit concerned about the freq QoS series at this point, may defer pushing it.

FWIW here is full WARNING since I am hitting it locally too:

commit 16c474c9ba39ede5fd1cd835ac52b3760d7820b7 (HEAD, tag:
next-20190704, next/master)
    Add linux-next specific files for 20190704

------------[ cut here ]------------
__dev_pm_qos_remove_request() called for unknown object
WARNING: CPU: 3 PID: 1 at drivers/base/power/qos.c:486
__dev_pm_qos_remove_reques0
Kernel panic - not syncing: panic_on_warn set ...
CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.2.0-rc7-next-20190704 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x172/0x1f0 lib/dump_stack.c:113
 panic+0x2dc/0x755 kernel/panic.c:219
 __warn.cold+0x20/0x4c kernel/panic.c:576
 report_bug+0x263/0x2b0 lib/bug.c:186
 fixup_bug arch/x86/kernel/traps.c:179 [inline]
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
 do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
 invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:1008
RIP: 0010:__dev_pm_qos_remove_request+0x3d3/0x4d0 drivers/base/power/qos.c:486
Code: 09 fd e9 9a fd ff ff 41 bd ed ff ff ff e9 b8 fd ff ff e8 d0 c9
7b fd 48 c7 2
RSP: 0000:ffff88806c27fac8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815cae36 RDI: ffffed100d84ff4b
RBP: ffff88806c27faf8 R08: ffff88806c276000 R09: fffffbfff14a6b45
R10: fffffbfff14a6b44 R11: ffffffff8a535a27 R12: ffff8880664cf0f8
R13: ffff88806ae4c000 R14: 0000000000000004 R15: ffff88806ae4c008
 dev_pm_qos_remove_request+0x24/0x40 drivers/base/power/qos.c:520
 cpufreq_policy_free+0x2b7/0x3d0 drivers/cpufreq/cpufreq.c:1282
 cpufreq_online+0x239/0x17a0 drivers/cpufreq/cpufreq.c:1482
 cpufreq_add_dev+0x119/0x160 drivers/cpufreq/cpufreq.c:1500
 subsys_interface_register+0x2fc/0x470 drivers/base/bus.c:1081
 cpufreq_register_driver+0x331/0x570 drivers/cpufreq/cpufreq.c:2669
 acpi_cpufreq_init+0x579/0x5ff drivers/cpufreq/acpi-cpufreq.c:966
 do_one_initcall+0x120/0x81a init/main.c:939
 do_initcall_level init/main.c:1007 [inline]
 do_initcalls init/main.c:1015 [inline]
 do_basic_setup init/main.c:1033 [inline]
 kernel_init_freeable+0x4d4/0x5c3 init/main.c:1193
 kernel_init+0x12/0x1c5 init/main.c:1111
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..
