Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 416FD17D108
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2020 04:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgCHDYh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Mar 2020 22:24:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCHDYh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 7 Mar 2020 22:24:37 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 609FA2070A;
        Sun,  8 Mar 2020 03:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583637876;
        bh=VDHIU9pNBGNOCslj1TQUtB7e7K9gbuLRUs2LG+C5evU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CpPMRXjdo0puU9drHNQbgbKmFzLqxiQE0RbTPAYqv7kHm1F2KChUB87RQFgCv7fWk
         geofjcuyYQWXWo2+hKMWAgSwDUdlne0xHGth9DixTsf/oH0p4iwuWD9F/9xnmPNlOd
         6Bcd0yoXykOSTTCQoEH7N5PsyA0u6Fasxr2GVOo4=
Date:   Sat, 7 Mar 2020 19:24:34 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     glider@google.com
Cc:     syzbot <syzbot+af962bf9e7e27bccd025@syzkaller.appspotmail.com>,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, pavel@ucw.cz, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com
Subject: Re: KMSAN: uninit-value in snapshot_compat_ioctl
Message-ID: <20200308032434.GX15444@sol.localdomain>
References: <000000000000938a57059f7cafe4@google.com>
 <20200307235437.GW15444@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307235437.GW15444@sol.localdomain>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Mar 07, 2020 at 03:54:37PM -0800, Eric Biggers wrote:
> On Wed, Feb 26, 2020 at 07:59:13AM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    8bbbc5cf kmsan: don't compile memmove
> > git tree:       https://github.com/google/kmsan.git master
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11514265e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cd0e9a6b0e555cc3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=af962bf9e7e27bccd025
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > userspace arch: i386
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a89109e00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176f774ee00000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+af962bf9e7e27bccd025@syzkaller.appspotmail.com
> > 
> > =====================================================
> > BUG: KMSAN: uninit-value in kmsan_check_memory+0xd/0x10 mm/kmsan/kmsan_hooks.c:413
> > CPU: 1 PID: 11659 Comm: syz-executor923 Not tainted 5.6.0-rc2-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1c9/0x220 lib/dump_stack.c:118
> >  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
> >  kmsan_internal_check_memory+0x358/0x3d0 mm/kmsan/kmsan.c:457
> >  kmsan_check_memory+0xd/0x10 mm/kmsan/kmsan_hooks.c:413
> >  snapshot_compat_ioctl+0x559/0x650 kernel/power/user.c:422
> >  __do_compat_sys_ioctl fs/ioctl.c:857 [inline]
> >  __se_compat_sys_ioctl+0x57c/0xed0 fs/ioctl.c:808
> >  __ia32_compat_sys_ioctl+0xd9/0x110 fs/ioctl.c:808
> >  do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
> >  do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
> >  entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
> > RIP: 0023:0xf7f70d99
> > Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> > RSP: 002b:00000000ffec145c EFLAGS: 00000213 ORIG_RAX: 0000000000000036
> > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000080083313
> > RDX: 0000000000000000 RSI: 00000000080ea078 RDI: 00000000ffec14b0
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > 
> > Uninit was stored to memory at:
> >  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
> >  kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:310
> >  __msan_chain_origin+0x50/0x90 mm/kmsan/kmsan_instr.c:165
> >  snapshot_compat_ioctl+0x5e0/0x650 kernel/power/user.c:422
> >  __do_compat_sys_ioctl fs/ioctl.c:857 [inline]
> >  __se_compat_sys_ioctl+0x57c/0xed0 fs/ioctl.c:808
> >  __ia32_compat_sys_ioctl+0xd9/0x110 fs/ioctl.c:808
> >  do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
> >  do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
> >  entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
> > 
> > Local variable ----offset@snapshot_compat_ioctl created at:
> >  get_current arch/x86/include/asm/current.h:15 [inline]
> >  snapshot_compat_ioctl+0x324/0x650 kernel/power/user.c:418
> >  get_current arch/x86/include/asm/current.h:15 [inline]
> >  snapshot_compat_ioctl+0x324/0x650 kernel/power/user.c:418
> > 
> > Bytes 0-7 of 8 are uninitialized
> > Memory access of size 8 starts at ffff9946c156bd30
> > =====================================================
> 
> Looks like a KMSAN false positive?  As far as I can tell, the memory is being
> initialized by put_user() called under set_fs(KERNEL_DS).
> 

Although, it also looks like the problematic code can just be removed, since
always sizeof(compat_loff_t) == sizeof(loff_t).  I'll send a patch to do that...
