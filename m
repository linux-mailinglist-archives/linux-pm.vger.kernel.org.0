Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5493816F003
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 21:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbgBYU0q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 15:26:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54002 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731685AbgBYU0q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 15:26:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01PKMpRZ127687;
        Tue, 25 Feb 2020 20:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=UL9wyjJBjP3/IyS1CKoZAtXUZ06/abJ/4utKURUvHkg=;
 b=fC7mjojUgAGaP1M7x+OptllYga6DD1iy+NU7mP1G7GRM2qNZ3glLljPBVEiT26j0wtvM
 EdD5UDROukyjT+qJVRcr7kSpXmUUR15FHjBouCjThYsijxhxhn1kLIq4yPkAOb4kP3zf
 IeK+c77VMXLahNMy4Zf47OmDN14aylarOpIq/XeI0IsMYn1cut0tRupLcDpxeCiCidJk
 KgEJBxIhSwi1Z3+2hata6nodlUcJ3b0bEzrAhCrMobsQ6sncEyRT2voDGAtkt6ut6Lff
 7Q8529aTbtwaEhX08NsLlXY5Fv+l5qfIlEYtme74jc69T+XNhBdFjFIY+w+euWQst73s xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yd0m1uwnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 20:26:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01PKM4XH020310;
        Tue, 25 Feb 2020 20:26:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2yd17qs1yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 20:26:39 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01PKQYCE022263;
        Tue, 25 Feb 2020 20:26:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Feb 2020 12:26:33 -0800
Date:   Tue, 25 Feb 2020 12:26:32 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: Regression: hibernation is broken since
 e6bc9de714972cac34daa1dc1567ee48a47a9342
Message-ID: <20200225202632.GE6748@magnolia>
References: <20200213172351.GA6747@dumbo>
 <20200213175753.GS6874@magnolia>
 <20200213183515.GA8798@dumbo>
 <20200213193410.GB6868@magnolia>
 <20200213194135.GF6870@magnolia>
 <20200214211523.GA32637@dumbo>
 <20200222002319.GK9504@magnolia>
 <20200223190311.GA26811@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223190311.GA26811@dumbo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9542 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=2 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002250142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9542 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=2 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250142
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Feb 23, 2020 at 08:03:11PM +0100, Domenico Andreoli wrote:
> On Fri, Feb 21, 2020 at 04:23:19PM -0800, Darrick J. Wong wrote:
> > 
> > Ok, third try.  Does the following work?  This is a little more
> > selective in that it only disables the write protection on the swap
> > device/file that uswusp is going to write to.
> 
> Yes it works but also verified that once the S_SWAPFILE bit is cleared
> it's never restored, therefore the protecton is gone after the first
> hibernation.

Ok, good.  Now can you try the third part, which ought to re-apply
S_SWAPFILE after a successful resume, please?  Assuming this works, I
think we're ready with a fixpatch.

--D

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1e99f7ac1d7e..add93e205850 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -458,6 +458,7 @@ extern void swap_free(swp_entry_t);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern int free_swap_and_cache(swp_entry_t);
 extern int swap_type_of(dev_t, sector_t, struct block_device **);
+extern void swap_relockall(void);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t map_swap_page(struct page *, struct block_device **);
 extern sector_t swapdev_block(int, pgoff_t);
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 77438954cc2b..b11f7037ce5e 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -271,6 +271,8 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			break;
 		}
 		error = hibernation_restore(data->platform_support);
+		if (!error)
+			swap_relockall();
 		break;
 
 	case SNAPSHOT_FREE:
@@ -372,10 +374,17 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			 */
 			swdev = new_decode_dev(swap_area.dev);
 			if (swdev) {
+				struct block_device *bd;
+
 				offset = swap_area.offset;
-				data->swap = swap_type_of(swdev, offset, NULL);
+				data->swap = swap_type_of(swdev, offset, &bd);
 				if (data->swap < 0)
 					error = -ENODEV;
+
+				inode_lock(bd->bd_inode);
+				bd->bd_inode->i_flags &= ~S_SWAPFILE;
+				inode_unlock(bd->bd_inode);
+				bdput(bd);
 			} else {
 				data->swap = -1;
 				error = -EINVAL;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index b2a2e45c9a36..a64dcba10db6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1799,6 +1799,32 @@ int swap_type_of(dev_t device, sector_t offset, struct block_device **bdev_p)
 	return -ENODEV;
 }
 
+/* Re-lock swap devices after resuming from userspace suspend. */
+void swap_relockall(void)
+{
+	int type;
+
+	spin_lock(&swap_lock);
+	for (type = 0; type < nr_swapfiles; type++) {
+		struct swap_info_struct *sis = swap_info[type];
+		struct block_device *bdev = bdgrab(sis->bdev);
+
+		/*
+		 * uswsusp only knows how to suspend to block devices, so we
+		 * can skip swap files.
+		 */
+		if (!(sis->flags & SWP_WRITEOK) ||
+		    !(sis->flags & SWP_BLKDEV))
+			continue;
+
+		inode_lock(bd->bd_inode);
+		bd->bd_inode->i_flags |= S_SWAPFILE;
+		inode_unlock(bd->bd_inode);
+		bdput(bd);
+	}
+	spin_unlock(&swap_lock);
+}
+
 /*
  * Get the (PAGE_SIZE) block corresponding to given offset on the swapdev
  * corresponding to given index in swap_info (swap type).
