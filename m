Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 611E6163C54
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 06:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgBSFD1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 00:03:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgBSFD1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 00:03:27 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J53Ccr008615;
        Wed, 19 Feb 2020 05:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=4wb1PXrowO/bZ2zmYBNcI9KLy084JjW31QmqVq7Tmpk=;
 b=rtZ6DjLtAePl3u5vyRF4ewe6M6oT4TAPArEUztpLW2ghHOlQYqis+52Y0+rentyxiSM6
 mF84WCtOQNGIQt+QEscqC6w5woVZzhIB7vFPGdwSX13QVejcwA4DkvBq0TVShuYrAeX0
 ipIbyK10O+jFx1pbCmR2qLJZDvE8fUpKHaN6VKQgC8RlbA3NKYK5rnuosQuTw2hRmF9C
 +BNHwpPRQ30qs/fPK1AovGhVbwwZJF18m8U4FgvIURgQ/+j4LmhHn21CvKtv8KDr0Z66
 t4mbjWGCUcdoBkOHnUXv25FnHsjJlSeIbLFHrLi4gZGB6v5ykKRMI3avPX2ES1g28OWq 4A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2y8udk8j4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 05:03:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J51mph078154;
        Wed, 19 Feb 2020 05:03:22 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2y8ud08knm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 05:03:22 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01J53F1m020548;
        Wed, 19 Feb 2020 05:03:16 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Feb 2020 21:03:15 -0800
Date:   Tue, 18 Feb 2020 21:03:14 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: Regression: hibernation is broken since
 e6bc9de714972cac34daa1dc1567ee48a47a9342
Message-ID: <20200219050314.GA9504@magnolia>
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
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190033
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

As I suspected, the in-kernel hibernate can write the memory image to
the swap file just fine...

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

...but maybe we could do something a little more targeted?

>                 return -ETXTBSY;
>  
>         if (!iov_iter_count(from))
> 
> I looked for a more selective way to enable writes to swap at runtime,
> so I tried with system_entering_hibernation() but it's not yet armed
> at the point in which uswsusp wants to write to the swap and therefore
> it does not work.

Hmm.  I was poking around in the uswsusp code and I /think/ it prepares
the kernel for the userspace-driven hibernation by calling the ioctl
SNAPSHOT_SET_SWAP_FILE on the device that it's going to use.  If that's
true, we could have it clear S_SWAPFILE on the chosen device, though I'd
have to do some more digging to figure out how to restore the flag after
resuming from hibernation.

--D

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
> 
> Dom
> 
> -- 
> rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
> ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
