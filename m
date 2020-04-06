Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAEA19F549
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 13:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgDFL6q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 07:58:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgDFL6o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 07:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qaqepCPg8Rs1dJnIiISXKi9Db9ulnrlsuqyzXsNq9N0=; b=uND0BZKqEj4sXLG5ufE/jQSjWH
        uXDlJ2C75WOsSYz5iDs2e/NdXVtSDtCeT++1Mv4cd577cKul5RbAS3S+FCQwzDv3AIEtBhj3BPT+g
        Vq3xrgDGVrvI6GZYp64yEgW0V8KPX8uTeI7/pn15gAC/M4r+LH+MYic3dHWFbFS8/suCiwYmdpKdv
        fzeEac/AivnkZak7jVR23xyZ1m5j2mfC5tV7TOhM1qCMoZsOtpvC4Ta8JG/3ht3TsF7xoWBTiXnTu
        GpyWJ0D6M0xr3RH6g8MBlJb22rpFeOMKm9tLREp/vh3+KMo1J7jUnnMKaEoue7kPCk/tJp9Vpirc2
        vA8KwMTA==;
Received: from [2001:4bb8:180:5765:7ca0:239a:fe26:fec2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLQOo-0008OV-1t; Mon, 06 Apr 2020 11:58:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PM / sleep: handle the compat case in snapshot_set_swap_area
Date:   Mon,  6 Apr 2020 13:58:35 +0200
Message-Id: <20200406115835.1150002-3-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406115835.1150002-1-hch@lst.de>
References: <20200406115835.1150002-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use in_compat_syscall to copy directly from the 32-bit ABI structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/power/user.c | 54 ++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 0cb555f526e4..7959449765d9 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -196,28 +196,44 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 	return res;
 }
 
+struct compat_resume_swap_area {
+	compat_loff_t offset;
+	u32 dev;
+} __packed;
+
 static int snapshot_set_swap_area(struct snapshot_data *data,
 		void __user *argp)
 {
-	struct resume_swap_area swap_area;
 	sector_t offset;
 	dev_t swdev;
 
 	if (swsusp_swap_in_use())
 		return -EPERM;
-	if (copy_from_user(&swap_area, argp, sizeof(swap_area)))
-		return -EFAULT;
+
+	if (in_compat_syscall()) {
+		struct compat_resume_swap_area swap_area;
+
+		if (copy_from_user(&swap_area, argp, sizeof(swap_area)))
+			return -EFAULT;
+		swdev = new_decode_dev(swap_area.dev);
+		offset = swap_area.offset;
+	} else {
+		struct resume_swap_area swap_area;
+
+		if (copy_from_user(&swap_area, argp, sizeof(swap_area)))
+			return -EFAULT;
+		swdev = new_decode_dev(swap_area.dev);
+		offset = swap_area.offset;
+	}
 
 	/*
 	 * User space encodes device types as two-byte values,
 	 * so we need to recode them
 	 */
-	swdev = new_decode_dev(swap_area.dev);
 	if (!swdev) {
 		data->swap = -1;
 		return -EINVAL;
 	}
-	offset = swap_area.offset;
 	data->swap = swap_type_of(swdev, offset, NULL);
 	if (data->swap < 0)
 		return -ENODEV;
@@ -394,12 +410,6 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 }
 
 #ifdef CONFIG_COMPAT
-
-struct compat_resume_swap_area {
-	compat_loff_t offset;
-	u32 dev;
-} __packed;
-
 static long
 snapshot_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
@@ -410,33 +420,13 @@ snapshot_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case SNAPSHOT_AVAIL_SWAP_SIZE:
 	case SNAPSHOT_ALLOC_SWAP_PAGE:
 	case SNAPSHOT_CREATE_IMAGE:
+	case SNAPSHOT_SET_SWAP_AREA:
 		return snapshot_ioctl(file, cmd,
 				      (unsigned long) compat_ptr(arg));
-
-	case SNAPSHOT_SET_SWAP_AREA: {
-		struct compat_resume_swap_area __user *u_swap_area =
-			compat_ptr(arg);
-		struct resume_swap_area swap_area;
-		mm_segment_t old_fs;
-		int err;
-
-		err = get_user(swap_area.offset, &u_swap_area->offset);
-		err |= get_user(swap_area.dev, &u_swap_area->dev);
-		if (err)
-			return -EFAULT;
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = snapshot_ioctl(file, SNAPSHOT_SET_SWAP_AREA,
-				     (unsigned long) &swap_area);
-		set_fs(old_fs);
-		return err;
-	}
-
 	default:
 		return snapshot_ioctl(file, cmd, arg);
 	}
 }
-
 #endif /* CONFIG_COMPAT */
 
 static const struct file_operations snapshot_fops = {
-- 
2.25.1

