Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB6F315F888
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 22:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgBNVPa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 16:15:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42254 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbgBNVP3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 16:15:29 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so12529962wrd.9;
        Fri, 14 Feb 2020 13:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CUR/M+JsDPA/zNxI0kwnGhffn6CjdF4EnxGaGRqf9ts=;
        b=YIQtuFIq8j/JZqVZ4o+ITcfQXPn59YUQjKR2Vwygk8FdwYgcVIAbmr+3lXzbVP/My9
         qR0jhz6Ue5qzzr7W/UW4wwMQKVF6xsq5l/NSOLkuklOCWqV2KOPzWTEx+aQbocnlncHo
         YAhCbje/LfFHsdCxZPNgPeV0kGC0raHGKaZg7HLONYmkU487gvzwqZesQrHT81NmIluq
         K7eVSSVctu6snmPZ7vHnuhZPCTQI7W7ikW5HLXCU+fz/z0UOtRL0jXwAiRy8/mV3bnK3
         RXGTqA1lG6BgapxKNpShbwdkNWxtiB3iBJvgyqGazTqAV9/ltcsBnR/3N6+mjLuqt5bs
         dbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CUR/M+JsDPA/zNxI0kwnGhffn6CjdF4EnxGaGRqf9ts=;
        b=J9rl4mKL976z0EOf6KdMU/MTsP3wNXHCU5ck86CP10Dv/IEGejt2NW/r64aFwJowBs
         8ZdOgTF/YOA9gNJmexx8A3Y9ruTnuR3Y07H9wBzMLPkmjsnfXRY9LOBDNCavDrv6XGpV
         FeEwBYCHZDNg27w9/rymeFo16NBK3dUt5v6mmvt6jpwibWbMGpRFjkpaC+2pnPx6Rs6h
         akzWfuP4OIrmfQlRAmaUmDGgePqKIo6zMtMYHxjXgwJfCOToQvgRIxm9EvYME00UX9lp
         Wynwd2a0pHPqyIzWk6FOby0XMUyFTUo6Tc1DEfy+nAh3J1MPIJBUMC8zFxQTsEyU5rIT
         lHJw==
X-Gm-Message-State: APjAAAVutzxYHFX4YR92DBdnN6k13YuJll0p08RCS2701UtIo4vt9v5S
        zuFLUFWx6fyIZes634Pts9g=
X-Google-Smtp-Source: APXvYqxi6ywswNldZdP7mnpmlT+iS3dXBegYxcsCWxu+/DB1s2FGHxtWAo7HAEX60U4k7gAqI+MXGw==
X-Received: by 2002:a05:6000:c4:: with SMTP id q4mr5616831wrx.332.1581714926560;
        Fri, 14 Feb 2020 13:15:26 -0800 (PST)
Received: from dumbo (ip4da2e549.direct-adsl.nl. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id j65sm9011625wmb.21.2020.02.14.13.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:15:25 -0800 (PST)
Date:   Fri, 14 Feb 2020 22:15:24 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: Regression: hibernation is broken since
 e6bc9de714972cac34daa1dc1567ee48a47a9342
Message-ID: <20200214211523.GA32637@dumbo>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
References: <20200213172351.GA6747@dumbo>
 <20200213175753.GS6874@magnolia>
 <20200213183515.GA8798@dumbo>
 <20200213193410.GB6868@magnolia>
 <20200213194135.GF6870@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213194135.GF6870@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

[ added linux-pm ]

On Thu, Feb 13, 2020 at 11:41:35AM -0800, Darrick J. Wong wrote:
> On Thu, Feb 13, 2020 at 11:34:10AM -0800, Darrick J. Wong wrote:
> > 
> > Well ... you could try the in-kernel hibernate (which I think is what
> > 'systemctl hibernate' does), though you'd lose the nifty features of
> > µswsusp.

Indeed 'systemctl hibernate' works perfectly with v5.6-rc1 in my setup.

> > In the end, though, I'll probably have to revert all those IS_SWAPFILE
> > checks (at least if CONFIG_HIBERNATION=y) since it's not fair to force
> > you to totally reconfigure your hibernation setup.
> 
> Also, does the following partial revert fix uswsusp for you?  It'll
> allow the direct writes that uswsusp wants to do, while leaving the rest
> (mmap writes) in place.
> 
> --D
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 69bf2fb6f7cd..077d9fa6b87d 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -2001,8 +2001,10 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	if (bdev_read_only(I_BDEV(bd_inode)))
>  		return -EPERM;
>  
> +#ifndef CONFIG_HIBERNATION
>  	if (IS_SWAPFILE(bd_inode))
>  		return -ETXTBSY;
> +#endif

This alone is enough to make uswsusp work again.

I propose this alternative:

--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2001,7 +2001,8 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
        if (bdev_read_only(I_BDEV(bd_inode)))
                return -EPERM;
 
-       if (IS_SWAPFILE(bd_inode))
+       /* Hibernation might happen via uswsusp, let it write to the swap */
+       if (IS_SWAPFILE(bd_inode) && !IS_ENABLED(CONFIG_HIBERNATION))
                return -ETXTBSY;
 
        if (!iov_iter_count(from))

I looked for a more selective way to enable writes to swap at runtime,
so I tried with system_entering_hibernation() but it's not yet armed
at the point in which uswsusp wants to write to the swap and therefore
it does not work.

--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -34,6 +34,7 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/falloc.h>
 #include <linux/uaccess.h>
+#include <linux/suspend.h>
 #include "internal.h"

 struct bdev_inode {
@@ -2001,7 +2002,8 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
        if (bdev_read_only(I_BDEV(bd_inode)))
                return -EPERM;

-       if (IS_SWAPFILE(bd_inode))
+       /* Hibernation might happen via uswsusp, let it write to the swap */
+       if (IS_SWAPFILE(bd_inode) && !system_entering_hibernation())
                return -ETXTBSY;

        if (!iov_iter_count(from))

>  	if (!iov_iter_count(from))
>  		return 0;
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1784478270e1..3df3211abe25 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2920,8 +2920,10 @@ inline ssize_t generic_write_checks(struct kiocb *iocb, struct iov_iter *from)
>  	loff_t count;
>  	int ret;
>  
> +#ifndef CONFIG_HIBERNATION
>  	if (IS_SWAPFILE(inode))
>  		return -ETXTBSY;
> +#endif
>  
>  	if (!iov_iter_count(from))
>  		return 0;

The above is not needed in my case but I'm not sure it would not be
needed in some other configuration of uswsusp.

Dom

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
