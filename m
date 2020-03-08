Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F9117D10A
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2020 04:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCHD15 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Mar 2020 22:27:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgCHD14 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 7 Mar 2020 22:27:56 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0D712070A;
        Sun,  8 Mar 2020 03:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583638076;
        bh=5TXqc/wHOgpq3fBa+jiwOk9beKszHKLHMpxvbc3OoD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/7AWOvSLlzDiPa4iOe5/OS5yMWyBEL6gL8SJdyu/qF4RMsRlhR7g8vBPmfuZ9Myf
         vVGRZcalA0mD5h9JX08vA3aGaDafGGqgUtkuiGB0k2otUTs/VQVbaDT5CypS/IgoPo
         mrlwjEkI6jCzkC4HPYw9cwI3BzvjqZHgbiJnVfus=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     glider@google.com, linux-kernel@vger.kernel.org,
        syzbot+af962bf9e7e27bccd025@syzkaller.appspotmail.com
Subject: [PATCH] PM / hibernate: Remove unnecessary compat ioctl overrides
Date:   Sat,  7 Mar 2020 19:27:01 -0800
Message-Id: <20200308032701.998434-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200308032434.GX15444@sol.localdomain>
References: <20200308032434.GX15444@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Since the SNAPSHOT_GET_IMAGE_SIZE, SNAPSHOT_AVAIL_SWAP_SIZE, and
SNAPSHOT_ALLOC_SWAP_PAGE ioctls produce an loff_t result, and loff_t is
always 64-bit even in the compat case, there's no reason to have the
special compat handling for these ioctls.  Just remove this unneeded
code so that these ioctls call into snapshot_ioctl() directly, doing
just the compat_ptr() conversion on the argument.

(This unnecessary code was also causing a KMSAN false positive.)

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kernel/power/user.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 77438954cc2b..58ed9478787f 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -409,21 +409,7 @@ snapshot_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 	case SNAPSHOT_GET_IMAGE_SIZE:
 	case SNAPSHOT_AVAIL_SWAP_SIZE:
-	case SNAPSHOT_ALLOC_SWAP_PAGE: {
-		compat_loff_t __user *uoffset = compat_ptr(arg);
-		loff_t offset;
-		mm_segment_t old_fs;
-		int err;
-
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = snapshot_ioctl(file, cmd, (unsigned long) &offset);
-		set_fs(old_fs);
-		if (!err && put_user(offset, uoffset))
-			err = -EFAULT;
-		return err;
-	}
-
+	case SNAPSHOT_ALLOC_SWAP_PAGE:
 	case SNAPSHOT_CREATE_IMAGE:
 		return snapshot_ioctl(file, cmd,
 				      (unsigned long) compat_ptr(arg));
-- 
2.25.1

