Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B95A168AEE
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2020 01:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgBVAX1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 19:23:27 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33360 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgBVAX1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 19:23:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01M0KBkn008088;
        Sat, 22 Feb 2020 00:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=vDiPCHqXKwCE9vSLdBZ4WMbduef2QvIlgdwwC3JOIvM=;
 b=T6LfVdYoPihUE7gqUVy37s9NdsUEMRBiAztT8UPl2EMwLivTrDy0Uho+P2I1HvAjDDP4
 zN/vklyjrVYlWYnQXepdiD2B21HFYJJ/umpPlewBpQV5T5D7iL3qT2I8hkry4P8Bl6r6
 IOkOI7mfbClXMPMz7I8vKiCxkZu0Qpotkj25ySptNSHdReaDvF2M5nswZtCu1HuvJ5Cx
 eVsoUYJ75UZi1NmHq/MoHZ/EgcPwhQuiE+opVX4X1hT08JtHJhjwT9eYk/7uw+8WaoUb
 2MHl8OI+SFbDHIJO6mpbOQkcviswzfAkmFBI83fBbrB+OnY2UqxXzLtGyfMV/waOvRJg +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y8uddkj0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 00:23:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01M0HuuO071147;
        Sat, 22 Feb 2020 00:23:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y8udrdje8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 00:23:21 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01M0NK8j021690;
        Sat, 22 Feb 2020 00:23:20 GMT
Received: from localhost (/10.145.179.117)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Feb 2020 16:23:20 -0800
Date:   Fri, 21 Feb 2020 16:23:19 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: Regression: hibernation is broken since
 e6bc9de714972cac34daa1dc1567ee48a47a9342
Message-ID: <20200222002319.GK9504@magnolia>
References: <20200213172351.GA6747@dumbo>
 <20200213175753.GS6874@magnolia>
 <20200213183515.GA8798@dumbo>
 <20200213193410.GB6868@magnolia>
 <20200213194135.GF6870@magnolia>
 <20200214211523.GA32637@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200214211523.GA32637@dumbo>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002220000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9538 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002220000
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 14, 2020 at 10:15:24PM +0100, Domenico Andreoli wrote:
> [ added linux-pm ]
> 
> On Thu, Feb 13, 2020 at 11:41:35AM -0800, Darrick J. Wong wrote:
> > On Thu, Feb 13, 2020 at 11:34:10AM -0800, Darrick J. Wong wrote:
> > > 
> > > Well ... you could try the in-kernel hibernate (which I think is what
> > > 'systemctl hibernate' does), though you'd lose the nifty features of
> > > µswsusp.
> 
> Indeed 'systemctl hibernate' works perfectly with v5.6-rc1 in my setup.
> 
> > > In the end, though, I'll probably have to revert all those IS_SWAPFILE
> > > checks (at least if CONFIG_HIBERNATION=y) since it's not fair to force
> > > you to totally reconfigure your hibernation setup.
> > 
> > Also, does the following partial revert fix uswsusp for you?  It'll
> > allow the direct writes that uswsusp wants to do, while leaving the rest
> > (mmap writes) in place.
> > 
> > --D
> > 
> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index 69bf2fb6f7cd..077d9fa6b87d 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -2001,8 +2001,10 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  	if (bdev_read_only(I_BDEV(bd_inode)))
> >  		return -EPERM;
> >  
> > +#ifndef CONFIG_HIBERNATION
> >  	if (IS_SWAPFILE(bd_inode))
> >  		return -ETXTBSY;
> > +#endif
> 
> This alone is enough to make uswsusp work again.
> 
> I propose this alternative:
> 
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -2001,7 +2001,8 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>         if (bdev_read_only(I_BDEV(bd_inode)))
>                 return -EPERM;
>  
> -       if (IS_SWAPFILE(bd_inode))
> +       /* Hibernation might happen via uswsusp, let it write to the swap */
> +       if (IS_SWAPFILE(bd_inode) && !IS_ENABLED(CONFIG_HIBERNATION))
>                 return -ETXTBSY;
>  
>         if (!iov_iter_count(from))
> 
> I looked for a more selective way to enable writes to swap at runtime,
> so I tried with system_entering_hibernation() but it's not yet armed
> at the point in which uswsusp wants to write to the swap and therefore
> it does not work.
> 
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -34,6 +34,7 @@
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/falloc.h>
>  #include <linux/uaccess.h>
> +#include <linux/suspend.h>
>  #include "internal.h"
> 
>  struct bdev_inode {
> @@ -2001,7 +2002,8 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>         if (bdev_read_only(I_BDEV(bd_inode)))
>                 return -EPERM;
> 
> -       if (IS_SWAPFILE(bd_inode))
> +       /* Hibernation might happen via uswsusp, let it write to the swap */
> +       if (IS_SWAPFILE(bd_inode) && !system_entering_hibernation())
>                 return -ETXTBSY;
> 
>         if (!iov_iter_count(from))
> 
> >  	if (!iov_iter_count(from))
> >  		return 0;
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 1784478270e1..3df3211abe25 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2920,8 +2920,10 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
> >  	loff_t count;
> >  	int ret;
> >  
> > +#ifndef CONFIG_HIBERNATION
> >  	if (IS_SWAPFILE(inode))
> >  		return -ETXTBSY;
> > +#endif
> >  
> >  	if (!iov_iter_count(from))
> >  		return 0;
> 
> The above is not needed in my case but I'm not sure it would not be
> needed in some other configuration of uswsusp.

Ok, third try.  Does the following work?  This is a little more
selective in that it only disables the write protection on the swap
device/file that uswusp is going to write to.

--D

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 77438954cc2b..a3ae9cbbfcf0 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -372,10 +372,17 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
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
