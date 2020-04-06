Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A3619F547
	for <lists+linux-pm@lfdr.de>; Mon,  6 Apr 2020 13:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgDFL6n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 07:58:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgDFL6m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 07:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QHlIGxrRkJE2pW1cSLusMpGr1MeRb0ETOREca3HJSYU=; b=qPQhwwjHv7AEAtzCMOb8qPo26g
        socV/mAZXrcap68cGf453BBcWwuh8cw267VB0H5IqaC1tvG0tdSSy+V5lTCzsqBxADiaZc8UpObb8
        j34Dl+e7/CrghtFiYNHnhCxCCWQZ9l4db9Hbd04xv9vfjDLSTAE7UiNGfQA/QO/8btUbtDd9HnxgG
        q6/OacPiN4r2N3J+LzEkqkVLDVgwQBxbAMv5Z2Tn1zGmqunqgYXzWpGFpkNYxv5tQ3n8RrPG01ePP
        RDgH294yZXzptZjyC1J57NpDAtn5lVHGGcwHFVBZPF1aUXARscbLj2s6VZjdc5TyU/XRwwR0ENuNN
        13eYUDug==;
Received: from [2001:4bb8:180:5765:7ca0:239a:fe26:fec2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLQOl-0008O8-Lp; Mon, 06 Apr 2020 11:58:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PM / sleep: move SNAPSHOT_SET_SWAP_AREA handling into a helper
Date:   Mon,  6 Apr 2020 13:58:34 +0200
Message-Id: <20200406115835.1150002-2-hch@lst.de>
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

Move the handling of the SNAPSHOT_SET_SWAP_AREA ioctl from the main
ioctl helper into a helper function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/power/user.c | 57 +++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index ef90eb1fb86e..0cb555f526e4 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -196,6 +196,34 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 	return res;
 }
 
+static int snapshot_set_swap_area(struct snapshot_data *data,
+		void __user *argp)
+{
+	struct resume_swap_area swap_area;
+	sector_t offset;
+	dev_t swdev;
+
+	if (swsusp_swap_in_use())
+		return -EPERM;
+	if (copy_from_user(&swap_area, argp, sizeof(swap_area)))
+		return -EFAULT;
+
+	/*
+	 * User space encodes device types as two-byte values,
+	 * so we need to recode them
+	 */
+	swdev = new_decode_dev(swap_area.dev);
+	if (!swdev) {
+		data->swap = -1;
+		return -EINVAL;
+	}
+	offset = swap_area.offset;
+	data->swap = swap_type_of(swdev, offset, NULL);
+	if (data->swap < 0)
+		return -ENODEV;
+	return 0;
+}
+
 static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 							unsigned long arg)
 {
@@ -351,34 +379,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		break;
 
 	case SNAPSHOT_SET_SWAP_AREA:
-		if (swsusp_swap_in_use()) {
-			error = -EPERM;
-		} else {
-			struct resume_swap_area swap_area;
-			dev_t swdev;
-
-			error = copy_from_user(&swap_area, (void __user *)arg,
-					sizeof(struct resume_swap_area));
-			if (error) {
-				error = -EFAULT;
-				break;
-			}
-
-			/*
-			 * User space encodes device types as two-byte values,
-			 * so we need to recode them
-			 */
-			swdev = new_decode_dev(swap_area.dev);
-			if (swdev) {
-				offset = swap_area.offset;
-				data->swap = swap_type_of(swdev, offset, NULL);
-				if (data->swap < 0)
-					error = -ENODEV;
-			} else {
-				data->swap = -1;
-				error = -EINVAL;
-			}
-		}
+		error = snapshot_set_swap_area(data, (void __user *)arg);
 		break;
 
 	default:
-- 
2.25.1

