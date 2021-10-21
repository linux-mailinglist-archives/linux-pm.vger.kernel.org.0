Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01A24368E2
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 19:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhJURTs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 13:19:48 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:35546 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJURTs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 13:19:48 -0400
Received: by mail-ot1-f42.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so1291178ott.2;
        Thu, 21 Oct 2021 10:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2KcjPlP8dFVSBa3l2MWntZHeNa/nrmW3MDLjeHIqpo=;
        b=ZhsnUuZeJb3hbCCCDhnqbValqqt3+cLcv+P+L6BBcMGsFN/GpAIkebqIeVwvwyEk+O
         rvqO4j38D/gfwYZFGgDdxPXhaDweIA/3ohHakGc+xUxQri+3vccq42Amn7GokPHHArCH
         ob4pr+ir6UyFMgN+2v0ETkZimI07nwfPzikFGGbemVJFrV/DN4yWdDtW6dUy4cdPty9i
         JJvKXxjGGevjE7JpBn9oxQ4RAasv6MVE7Fq1KoXLbVGMoK9MzVVXr8mz2yR4YUDiLMtj
         bmHcg0VL9Zol/C7POCiW3ZcKoErQzvLfUL4k8vt4J+jyxKzcNfJlG74WpeBYsz7cIk8q
         iwkg==
X-Gm-Message-State: AOAM531Izbls56Zz0TVJc3XSJ5D1IdLYn5YD1a7wS7wYpdWYP+4d16tz
        8LwNQ5238ftTQizpIK6RXKqfFi6Prk4W7qjwtVo=
X-Google-Smtp-Source: ABdhPJyNBCJam9Bx1qy7vft6okiRWZlRKb/iGBMCEs0rNfzSq62IuLlvM1BUAphdbXqQgL8kD1/Y5CQPv4I1InW8oCw=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr5695139oth.198.1634836651708;
 Thu, 21 Oct 2021 10:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211013121914.3146812-1-yebin10@huawei.com> <CAJZ5v0jX4N-mXYoVVeMB0XW9KcYq9DtE3-dvOoNEBmUa1xzEtw@mail.gmail.com>
 <61715146.2040000@huawei.com> <CAJZ5v0jLQP=T9Rd8JZq2px+CEbFVXmSu0qB1qTaHPh83uzdi_Q@mail.gmail.com>
 <61717B5E.3030300@huawei.com>
In-Reply-To: <61717B5E.3030300@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Oct 2021 19:17:20 +0200
Message-ID: <CAJZ5v0i64QaN5sSxfEPWLJpZzvX6psizGjfDsi1BzRNdV45e=A@mail.gmail.com>
Subject: Re: [PATCH -next] PM: hibernate: Get block device exclusively when do swsusp_check
To:     yebin <yebin10@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Ted Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 21, 2021 at 4:38 PM yebin <yebin10@huawei.com> wrote:
>
>
>
> On 2021/10/21 21:27, Rafael J. Wysocki wrote:
> > On Thu, Oct 21, 2021 at 1:38 PM yebin <yebin10@huawei.com> wrote:
> >>
> >>
> >> On 2021/10/21 19:00, Rafael J. Wysocki wrote:
> >>> On Wed, Oct 13, 2021 at 2:06 PM Ye Bin <yebin10@huawei.com> wrote:
> >>>> We got follow issue:
> >>>> [   89.266592] ------------[ cut here ]------------
> >>>> [   89.267427] kernel BUG at fs/buffer.c:3020!
> >>>> [   89.268264] invalid opcode: 0000 [#1] SMP KASAN PTI
> >>>> [   89.269116] CPU: 7 PID: 1750 Comm: kmmpd-loop0 Not tainted 5.10.0-862.14.0.6.x86_64-08610-gc932cda3cef4-dirty #20
> >>>> [   89.273169] RIP: 0010:submit_bh_wbc.isra.0+0x538/0x6d0
> >>>> [   89.277157] RSP: 0018:ffff888105ddfd08 EFLAGS: 00010246
> >>>> [   89.278093] RAX: 0000000000000005 RBX: ffff888124231498 RCX: ffffffffb2772612
> >>>> [   89.279332] RDX: 1ffff11024846293 RSI: 0000000000000008 RDI: ffff888124231498
> >>>> [   89.280591] RBP: ffff8881248cc000 R08: 0000000000000001 R09: ffffed1024846294
> >>>> [   89.281851] R10: ffff88812423149f R11: ffffed1024846293 R12: 0000000000003800
> >>>> [   89.283095] R13: 0000000000000001 R14: 0000000000000000 R15: ffff8881161f7000
> >>>> [   89.284342] FS:  0000000000000000(0000) GS:ffff88839b5c0000(0000) knlGS:0000000000000000
> >>>> [   89.285711] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> [   89.286701] CR2: 00007f166ebc01a0 CR3: 0000000435c0e000 CR4: 00000000000006e0
> >>>> [   89.287919] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>> [   89.289138] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>> [   89.290368] Call Trace:
> >>>> [   89.290842]  write_mmp_block+0x2ca/0x510
> >>>> [   89.292218]  kmmpd+0x433/0x9a0
> >>>> [   89.294902]  kthread+0x2dd/0x3e0
> >>>> [   89.296268]  ret_from_fork+0x22/0x30
> >>>> [   89.296906] Modules linked in:
> >>>>
> >>>> We can reproduce this issue as follow:
> >>>> 1. mkfs.ext4 -O mmp  /dev/sda -b 1024
> >>>> 2. mount /dev/sda /home/test
> >>>> 3. echo "/dev/sda" > /sys/power/resume
> >>>> 4. wait a moment we will get exception
> >>>>
> >>>> The sequence of issue is as follows:
> >>>>          Thread1                       Thread2
> >>>> mount /dev/sda /home/test
> >>>> get s_mmp_bh  --> has mapped flag
> >>>> start kmmpd thread
> >>>>                                   echo "/dev/sda" > /sys/power/resume
> >>>>                                     resume_store
> >>>>                                       software_resume
> >>>>                                         swsusp_check
> >>>>                                           set_blocksize
> >>>>                                             truncate_inode_pages_range
> >>>>                                               truncate_cleanup_page
> >>>>                                                 block_invalidatepage
> >>>>                                                   discard_buffer --> clean mapped flag
> >>>> write_mmp_block
> >>>>     submit_bh
> >>>>       submit_bh_wbc
> >>>>         BUG_ON(!buffer_mapped(bh)) --> trigger bug_on
> >>>>
> >>>> To solve this issue, get block device exclusively when do swsusp_check.
> >>> And why exactly is this going to help?
> >> If a  block device is already  mounted, then do  resume, it will discard
> >> buffer
> >> which file system being used.  That can cause the file system to crash and
> >> may even cause the system to reset abnormally.
> > I see.
> >
> > Is there a way to indicate in swsusp_check() that the access will be
> > read-only and so it doesn't care whether or not the block device is in
> > use by someone else?
> The root reason is that call  'set_blocksize' in 'swsusp_check' which
> maybe invalidate
> block device's page.

I see.

> Moreover, the file system and swap partition share storage space, which
> will lead to
> data confusion.
> >> If the "/sys/power/resume" sysfs interface is unrestricted, it will provide
> >> criminals with a way to attack the system.
> >>
> >>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> >>>> ---
> >>>>    kernel/power/swap.c | 5 +++--
> >>>>    1 file changed, 3 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> >>>> index 9ec418955556..26c0bd2a50da 100644
> >>>> --- a/kernel/power/swap.c
> >>>> +++ b/kernel/power/swap.c
> >>>> @@ -1521,9 +1521,10 @@ int swsusp_read(unsigned int *flags_p)
> >>>>    int swsusp_check(void)
> >>>>    {
> >>>>           int error;
> >>>> +       void *holder;
> >>>>
> >>>>           hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
> >>>> -                                           FMODE_READ, NULL);
> >>>> +                                           FMODE_READ | FMODE_EXCL, &holder);
> >>> So you need to explain to me how this works.
> >> As we call 'blkdev_get_by_path' in 'mount_bdev'  pass mode includes
> >> FMODE_EXCL.
> >> So if 'swsusp_check' try to get block device with mode includes
> >> FMODE_EXCL will failed.
> >>
> >> I think if a block device is used as a swap partition, it cannot be
> >> mounted at the
> >> same time. Conversely, if a block device is already mounted, it cannot
> >> be used as
> >> a swap partition.
> > Well, what if a hibernation image is located in a swap file?  This is
> > one of the cases that need to be supported.
> I don't know much about this, but I think the process can call
> swsusp_check, the
> hibernation image must be loaded into the block device.

Yes, it is invalid to call swsusp_check() without a hibernation image
in the target swap partition or swap file if that's what you mean.

However, in the case of a swap file, the image may be there in theory
even if the filesystem holding the swap file is mounted.

> I refer to the process of swapon. If the swap partition is a block
> device, it is also
> opened exclusively.
>
> swapon
>      claim_swapfile

There are two cases, though, the S_ISBLK() one and the S_ISREG() one,
and the latter is the swap file case I believe.

> static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
> {
>          int error;
>
>          if (S_ISBLK(inode->i_mode)) {    -->If a block device is
> specified, it is also opened exclusively here.
>                  p->bdev = blkdev_get_by_dev(inode->i_rdev,
>                                     FMODE_READ | FMODE_WRITE |
> FMODE_EXCL, p);
>                  if (IS_ERR(p->bdev)) {
>                          error = PTR_ERR(p->bdev);
>                          p->bdev = NULL;
>                          return error;
>                  }
>                  p->old_block_size = block_size(p->bdev);
>                  error = set_blocksize(p->bdev, PAGE_SIZE);
>                  if (error < 0)
>                          return error;
>                  /*
>                   * Zoned block devices contain zones that have a sequential
>                   * write only restriction.  Hence zoned block devices
> are not
>                   * suitable for swapping.  Disallow them here.
>                   */
>                  if (blk_queue_is_zoned(p->bdev->bd_disk->queue))
>                          return -EINVAL;
>                  p->flags |= SWP_BLKDEV;
>          } else if (S_ISREG(inode->i_mode)) {
>                  p->bdev = inode->i_sb->s_bdev;

Here, it is not exclusive.

Anyway, I think that the change made by the patch should be fine,
because it mostly affects restore and I'm not expecting anyone to
restore the system from an image in a swap file while the filesystem
holding it is mounted.

So I'm going to apply it with some changelog edits.

Thanks!

>          }
>
>          return 0;
> }
> >>>>           if (!IS_ERR(hib_resume_bdev)) {
> >>>>                   set_blocksize(hib_resume_bdev, PAGE_SIZE);
> >>>>                   clear_page(swsusp_header);
> >>>> @@ -1545,7 +1546,7 @@ int swsusp_check(void)
> >>>>
> >>>>    put:
> >>>>                   if (error)
> >>>> -                       blkdev_put(hib_resume_bdev, FMODE_READ);
> >>>> +                       blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
> >>>>                   else
> >>>>                           pr_debug("Image signature found, resuming\n");
> >>>>           } else {
> >>>> --
> >>> .
> >>>
> > .
> >
>
