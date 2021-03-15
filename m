Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB74633B242
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 13:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhCOMKJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 08:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhCOMJs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Mar 2021 08:09:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD3DB64EB3;
        Mon, 15 Mar 2021 12:09:46 +0000 (UTC)
Date:   Mon, 15 Mar 2021 12:09:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+5ecbe63baca437585bd4@syzkaller.appspotmail.com>,
        Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: kernel BUG in memory_bm_free
Message-ID: <20210315120943.GB22897@arm.com>
References: <0000000000009c21de05ba6849e7@google.com>
 <CACT4Y+ZjVc+_fg+Ggx8zRWSGqzf4gmZcngBXLf_R4F-GKU4a9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZjVc+_fg+Ggx8zRWSGqzf4gmZcngBXLf_R4F-GKU4a9A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 15, 2021 at 08:08:06AM +0100, Dmitry Vyukov wrote:
> On Wed, Feb 3, 2021 at 6:59 AM syzbot
> <syzbot+5ecbe63baca437585bd4@syzkaller.appspotmail.com> wrote:
> > syzbot found the following issue on:
> >
> > HEAD commit:    3aaf0a27 Merge tag 'clang-format-for-linux-v5.11-rc7' of g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17ef6108d00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=10152c2ea16351e7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5ecbe63baca437585bd4
> > userspace arch: arm64
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+5ecbe63baca437585bd4@syzkaller.appspotmail.com
> 
> The BUG is:
> BUG_ON(!virt_addr_valid(addr));
> 
> #syz fix: arm64: Do not pass tagged addresses to __is_lm_address()

Does this mean that commit 91cb2c8b072e ("arm64: Do not pass tagged
addresses to __is_lm_address()") fixes the regression? The patch was
merged in -5.11-rc7 I think.

-- 
Catalin
