Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4453D4343BE
	for <lists+linux-pm@lfdr.de>; Wed, 20 Oct 2021 05:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhJTDPJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 23:15:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25299 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTDPJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Oct 2021 23:15:09 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HYwY01kxYzbhBM;
        Wed, 20 Oct 2021 11:08:20 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Wed, 20 Oct 2021 11:12:53 +0800
Subject: Re: [PATCH -next] PM: hibernate: Get block device exclusively when do
 swsusp_check
To:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <linux-pm@vger.kernel.org>
References: <20211013121914.3146812-1-yebin10@huawei.com>
CC:     <tytso@mit.edu>, <linux-kernel@vger.kernel.org>, <jack@suse.cz>
From:   yebin <yebin10@huawei.com>
Message-ID: <616F8935.7070509@huawei.com>
Date:   Wed, 20 Oct 2021 11:12:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20211013121914.3146812-1-yebin10@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 2021/10/13 20:19, Ye Bin wrote:
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
>         Thread1                       Thread2
> mount /dev/sda /home/test
> get s_mmp_bh  --> has mapped flag
> start kmmpd thread
> 				echo "/dev/sda" > /sys/power/resume
> 				  resume_store
> 				    software_resume
> 				      swsusp_check
> 				        set_blocksize
> 					  truncate_inode_pages_range
> 					    truncate_cleanup_page
> 					      block_invalidatepage
> 					        discard_buffer --> clean mapped flag
> write_mmp_block
>    submit_bh
>      submit_bh_wbc
>        BUG_ON(!buffer_mapped(bh)) --> trigger bug_on
>
> To solve this issue, get block device exclusively when do swsusp_check.
>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   kernel/power/swap.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 9ec418955556..26c0bd2a50da 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1521,9 +1521,10 @@ int swsusp_read(unsigned int *flags_p)
>   int swsusp_check(void)
>   {
>   	int error;
> +	void *holder;
>   
>   	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
> -					    FMODE_READ, NULL);
> +					    FMODE_READ | FMODE_EXCL, &holder);
>   	if (!IS_ERR(hib_resume_bdev)) {
>   		set_blocksize(hib_resume_bdev, PAGE_SIZE);
>   		clear_page(swsusp_header);
> @@ -1545,7 +1546,7 @@ int swsusp_check(void)
>   
>   put:
>   		if (error)
> -			blkdev_put(hib_resume_bdev, FMODE_READ);
> +			blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
>   		else
>   			pr_debug("Image signature found, resuming\n");
>   	} else {
ping...
