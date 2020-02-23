Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9D3169989
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2020 20:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgBWTDQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Feb 2020 14:03:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34183 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBWTDP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Feb 2020 14:03:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id n10so7853822wrm.1;
        Sun, 23 Feb 2020 11:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=A5PcRNqVDequHW3hKDEELTuy+nfThlBZndOvTTb6Fzk=;
        b=AiZCF/a2q8ooI9RYiTznc9nYqhl3/7byEYXyNvKbyt86kczZ4RqS+FIH2UF2g5Rrf7
         Qdvgpn7kRC/MUeY6T1nIEHbA2m1JijwgttNfNUJZal6KQCWbL7dMuMaBa+Z/czcHjyl4
         qbdrTbQ4ACXTDuactRbJCJ4naOG0CzW06uyDar3wxOOPDWmxtwgHLmH8sQy3/6HUZHEz
         El37Fc8TXC20FvNxqSBAXPdEYf9l95rKz7TbOkKjT4wtEJcLpY5xXgUGrCGvXupW/ePL
         tCxUdqDZt4VAkasTUgJxzyeJOlnsUgTzWKqtl4e80AgugR8cuo69rtFNHb+dCr1SLpkZ
         Qejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=A5PcRNqVDequHW3hKDEELTuy+nfThlBZndOvTTb6Fzk=;
        b=l/ASUnJcBbeOEeYVUnSA6eUph3xc36drgCp0TyQKUVI1z/CYbvAEZ8hogypLjMo8s5
         vosy3M3HzoaWyscbgBl0D69t+1xckKuMKr01ywakPS/nhghIzNMRt+EtQnxGgnSX7mW6
         JzSMJncYqrlff6hu3bhzMJfiPByELr5MRkXgHk+s1QBKN13s53fjbweb0enjXwrhaCGe
         K4KGK8yY4/C+12dfdL6SlavgmiVIha5X1ihXzFgJXCK2Z9cOu1Pr6RNeHFxQSFaX/QT/
         EDtGpN1RQ1578hKKPGfkT8CqGK88d64e7Afw8/nh1nG+/ksW1e0ox7D5p0qhMxpVMxMv
         kXBg==
X-Gm-Message-State: APjAAAUmjtHuSrKu+Jr75umuhH3m28UxQ3ef/F9qCgSmAsPAENKSrnPc
        WI+xu9owilH6yLkv5/iaYeM=
X-Google-Smtp-Source: APXvYqxfXJKIZsXIveZSysVzGSvhzDQFvhvyaaEt/yWFzajfEc5h0Bse/ct1rSyy5oVYBNw1Tp/vLw==
X-Received: by 2002:a5d:560d:: with SMTP id l13mr35511905wrv.222.1582484593685;
        Sun, 23 Feb 2020 11:03:13 -0800 (PST)
Received: from dumbo (ip4da2e549.direct-adsl.nl. [77.162.229.73])
        by smtp.gmail.com with ESMTPSA id y12sm14812427wrw.88.2020.02.23.11.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 11:03:12 -0800 (PST)
Date:   Sun, 23 Feb 2020 20:03:11 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
Subject: Re: Regression: hibernation is broken since
 e6bc9de714972cac34daa1dc1567ee48a47a9342
Message-ID: <20200223190311.GA26811@dumbo>
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
 <20200214211523.GA32637@dumbo>
 <20200222002319.GK9504@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222002319.GK9504@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 21, 2020 at 04:23:19PM -0800, Darrick J. Wong wrote:
> 
> Ok, third try.  Does the following work?  This is a little more
> selective in that it only disables the write protection on the swap
> device/file that uswusp is going to write to.

Yes it works but also verified that once the S_SWAPFILE bit is cleared
it's never restored, therefore the protecton is gone after the first
hibernation.

> 
> --D
> 
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 77438954cc2b..a3ae9cbbfcf0 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -372,10 +372,17 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
>  			 */
>  			swdev = new_decode_dev(swap_area.dev);
>  			if (swdev) {
> +				struct block_device *bd;
> +
>  				offset = swap_area.offset;
> -				data->swap = swap_type_of(swdev, offset, NULL);
> +				data->swap = swap_type_of(swdev, offset, &bd);
>  				if (data->swap < 0)
>  					error = -ENODEV;
> +
> +				inode_lock(bd->bd_inode);
> +				bd->bd_inode->i_flags &= ~S_SWAPFILE;
> +				inode_unlock(bd->bd_inode);
> +				bdput(bd);
>  			} else {
>  				data->swap = -1;
>  				error = -EINVAL;

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
