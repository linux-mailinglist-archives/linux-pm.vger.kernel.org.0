Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830D344A2B3
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 02:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbhKIBT5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 20:19:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243210AbhKIBPR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Nov 2021 20:15:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFC4461A3D;
        Tue,  9 Nov 2021 01:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636419979;
        bh=Qj5sBzcwIHV/h3DLs6p4xq94A4UUZMq3ifnrURECLyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AvtiykC3ynQs6CLzsmyRJzY9VjTL/xb2z+kayM/vVRjVH5wmYj49/lyTiGGUkL5kL
         E0u91HFu5JNh8GvRZSVkb2GSrmE2y9O6IMHMrgWeA/09rz4NhGmrqZBIEG7L9tjgY2
         fbJwvUncLvymlWfKh27kLc5iW32vVohzUTSuYND9AB3sWz0O3jxCRQiVxfTxh9E1pA
         PtoEhhKQ0i0VY8EHYP0tb40nmypEfeakbSubPtBZ2L679Tud+ANu8jiprPDID4VMTX
         kHPLipGnbnmxNrpQNGy4XtNu3dOsoB20zOfR+STKzn9YpdUEUk/tt+mU/+H//3RjX1
         NAGF17C2vs3VA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 35/47] PM: hibernate: Get block device exclusively in swsusp_check()
Date:   Mon,  8 Nov 2021 12:50:19 -0500
Message-Id: <20211108175031.1190422-35-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211108175031.1190422-1-sashal@kernel.org>
References: <20211108175031.1190422-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 39fbef4b0f77f9c89c8f014749ca533643a37c9f ]

The following kernel crash can be triggered:

[   89.266592] ------------[ cut here ]------------
[   89.267427] kernel BUG at fs/buffer.c:3020!
[   89.268264] invalid opcode: 0000 [#1] SMP KASAN PTI
[   89.269116] CPU: 7 PID: 1750 Comm: kmmpd-loop0 Not tainted 5.10.0-862.14.0.6.x86_64-08610-gc932cda3cef4-dirty #20
[   89.273169] RIP: 0010:submit_bh_wbc.isra.0+0x538/0x6d0
[   89.277157] RSP: 0018:ffff888105ddfd08 EFLAGS: 00010246
[   89.278093] RAX: 0000000000000005 RBX: ffff888124231498 RCX: ffffffffb2772612
[   89.279332] RDX: 1ffff11024846293 RSI: 0000000000000008 RDI: ffff888124231498
[   89.280591] RBP: ffff8881248cc000 R08: 0000000000000001 R09: ffffed1024846294
[   89.281851] R10: ffff88812423149f R11: ffffed1024846293 R12: 0000000000003800
[   89.283095] R13: 0000000000000001 R14: 0000000000000000 R15: ffff8881161f7000
[   89.284342] FS:  0000000000000000(0000) GS:ffff88839b5c0000(0000) knlGS:0000000000000000
[   89.285711] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   89.286701] CR2: 00007f166ebc01a0 CR3: 0000000435c0e000 CR4: 00000000000006e0
[   89.287919] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   89.289138] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   89.290368] Call Trace:
[   89.290842]  write_mmp_block+0x2ca/0x510
[   89.292218]  kmmpd+0x433/0x9a0
[   89.294902]  kthread+0x2dd/0x3e0
[   89.296268]  ret_from_fork+0x22/0x30
[   89.296906] Modules linked in:

by running the following commands:

 1. mkfs.ext4 -O mmp  /dev/sda -b 1024
 2. mount /dev/sda /home/test
 3. echo "/dev/sda" > /sys/power/resume

That happens because swsusp_check() calls set_blocksize() on the
target partition which confuses the file system:

       Thread1                       Thread2
mount /dev/sda /home/test
get s_mmp_bh  --> has mapped flag
start kmmpd thread
				echo "/dev/sda" > /sys/power/resume
				  resume_store
				    software_resume
				      swsusp_check
				        set_blocksize
					  truncate_inode_pages_range
					    truncate_cleanup_page
					      block_invalidatepage
					        discard_buffer --> clean mapped flag
write_mmp_block
  submit_bh
    submit_bh_wbc
      BUG_ON(!buffer_mapped(bh))

To address this issue, modify swsusp_check() to open the target block
device with exclusive access.

Signed-off-by: Ye Bin <yebin10@huawei.com>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/swap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index e9494c29f1ca4..b5b97df142d26 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1512,9 +1512,10 @@ int swsusp_read(unsigned int *flags_p)
 int swsusp_check(void)
 {
 	int error;
+	void *holder;
 
 	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
-					    FMODE_READ, NULL);
+					    FMODE_READ | FMODE_EXCL, &holder);
 	if (!IS_ERR(hib_resume_bdev)) {
 		set_blocksize(hib_resume_bdev, PAGE_SIZE);
 		clear_page(swsusp_header);
@@ -1536,7 +1537,7 @@ int swsusp_check(void)
 
 put:
 		if (error)
-			blkdev_put(hib_resume_bdev, FMODE_READ);
+			blkdev_put(hib_resume_bdev, FMODE_READ | FMODE_EXCL);
 		else
 			pr_debug("Image signature found, resuming\n");
 	} else {
-- 
2.33.0

