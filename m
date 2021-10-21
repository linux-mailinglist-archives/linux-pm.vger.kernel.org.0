Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D3E435FD4
	for <lists+linux-pm@lfdr.de>; Thu, 21 Oct 2021 13:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhJULDP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Oct 2021 07:03:15 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46969 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJULDO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Oct 2021 07:03:14 -0400
Received: by mail-oi1-f177.google.com with SMTP id o204so326284oih.13;
        Thu, 21 Oct 2021 04:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQB03aERhPb99oHnESpq/nq79NV5D0aQvL4LDkQ/zDk=;
        b=Ux4b7WtGy1Pk99xxEopoRsT3SFOe2IF8XoGy25S6CQPjZ4DSKFR8QM8umbReE0qENg
         VoIleiCcFQ87o2g1EVXzc6ZQqvmfMX+YQN1HoF7mzyn2qm6s+5Psg5WaiRM4csgx2rcU
         AiC/y+f6hqV57uCeWnGSrKb+GWwPjYym0UH1EQEv0c5gfBbyvvLFQpRs0ECoBDlmpdSJ
         BEEtHVHnG8Ec4reRJBMMMmppB7vJmAQ5aBmgc2sX5QIXztw0X3FNo1YssQasvbEte+rA
         qu24xOm88rxyz69EFwTICIBeusZARAq4kBg3FutvWy9mOXq4VzdsHIFePel4cTeuK9GW
         0tFw==
X-Gm-Message-State: AOAM533NBDIuKG2b7JEDKVLhQ+KuYms7YNxUZV7SZRwuHcgVXm9FUBp1
        KcJ3p9UR74G+y2/UFIYGxBv/lZ7i7fA3dhKuSwY=
X-Google-Smtp-Source: ABdhPJyZH4OpYfocBo/c5qu/kBqqp236G5hTl6J5kVgpvKkN69j376xtOGkW2x2egefbBLRSKBlA7EFbT6na4GiIk70=
X-Received: by 2002:a05:6808:1286:: with SMTP id a6mr130928oiw.51.1634814058579;
 Thu, 21 Oct 2021 04:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211013121914.3146812-1-yebin10@huawei.com>
In-Reply-To: <20211013121914.3146812-1-yebin10@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Oct 2021 13:00:47 +0200
Message-ID: <CAJZ5v0jX4N-mXYoVVeMB0XW9KcYq9DtE3-dvOoNEBmUa1xzEtw@mail.gmail.com>
Subject: Re: [PATCH -next] PM: hibernate: Get block device exclusively when do swsusp_check
To:     Ye Bin <yebin10@huawei.com>
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

On Wed, Oct 13, 2021 at 2:06 PM Ye Bin <yebin10@huawei.com> wrote:
>
> We got follow issue:
> [   89.266592] ------------[ cut here ]------------
> [   89.267427] kernel BUG at fs/buffer.c:3020!
> [   89.268264] invalid opcode: 0000 [#1] SMP KASAN PTI
> [   89.269116] CPU: 7 PID: 1750 Comm: kmmpd-loop0 Not tainted 5.10.0-862.14.0.6.x86_64-08610-gc932cda3cef4-dirty #20
> [   89.273169] RIP: 0010:submit_bh_wbc.isra.0+0x538/0x6d0
> [   89.277157] RSP: 0018:ffff888105ddfd08 EFLAGS: 00010246
> [   89.278093] RAX: 0000000000000005 RBX: ffff888124231498 RCX: ffffffffb2772612
> [   89.279332] RDX: 1ffff11024846293 RSI: 0000000000000008 RDI: ffff888124231498
> [   89.280591] RBP: ffff8881248cc000 R08: 0000000000000001 R09: ffffed1024846294
> [   89.281851] R10: ffff88812423149f R11: ffffed1024846293 R12: 0000000000003800
> [   89.283095] R13: 0000000000000001 R14: 0000000000000000 R15: ffff8881161f7000
> [   89.284342] FS:  0000000000000000(0000) GS:ffff88839b5c0000(0000) knlGS:0000000000000000
> [   89.285711] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   89.286701] CR2: 00007f166ebc01a0 CR3: 0000000435c0e000 CR4: 00000000000006e0
> [   89.287919] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   89.289138] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   89.290368] Call Trace:
> [   89.290842]  write_mmp_block+0x2ca/0x510
> [   89.292218]  kmmpd+0x433/0x9a0
> [   89.294902]  kthread+0x2dd/0x3e0
> [   89.296268]  ret_from_fork+0x22/0x30
> [   89.296906] Modules linked in:
>
> We can reproduce this issue as follow:
> 1. mkfs.ext4 -O mmp  /dev/sda -b 1024
> 2. mount /dev/sda /home/test
> 3. echo "/dev/sda" > /sys/power/resume
> 4. wait a moment we will get exception
>
> The sequence of issue is as follows:
>        Thread1                       Thread2
> mount /dev/sda /home/test
> get s_mmp_bh  --> has mapped flag
> start kmmpd thread
>                                 echo "/dev/sda" > /sys/power/resume
>                                   resume_store
>                                     software_resume
>                                       swsusp_check
>                                         set_blocksize
>                                           truncate_inode_pages_range
>                                             truncate_cleanup_page
>                                               block_invalidatepage
>                                                 discard_buffer --> clean mapped flag
> write_mmp_block
>   submit_bh
>     submit_bh_wbc
>       BUG_ON(!buffer_mapped(bh)) --> trigger bug_on
>
> To solve this issue, get block device exclusively when do swsusp_check.

And why exactly is this going to help?

>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/power/swap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 9ec418955556..26c0bd2a50da 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1521,9 +1521,10 @@ int swsusp_read(unsigned int *flags_p)
>  int swsusp_check(void)
>  {
>         int error;
> +       void *holder;
>
>         hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
> -                                           FMODE_READ, NULL);
> +                                           FMODE_READ | FMODE_EXCL, &holder);

So you need to explain to me how this works.

>         if (!IS_ERR(hib_resume_bdev)) {
>                 set_blocksize(hib_resume_bdev, PAGE_SIZE);
>                 clear_page(swsusp_header);
> @@ -1545,7 +1546,7 @@ int swsusp_check(void)
>
>  put:
>                 if (error)
> -                       blkdev_put(hib_resume_bdev, FMODE_READ);
> +                       blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
>                 else
>                         pr_debug("Image signature found, resuming\n");
>         } else {
> --
