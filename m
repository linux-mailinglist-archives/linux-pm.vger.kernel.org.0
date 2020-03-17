Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15E21889FF
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 17:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgCQQQk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Mar 2020 12:16:40 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:49418 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgCQQQk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2020 12:16:40 -0400
X-Greylist: delayed 1454 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2020 12:16:38 EDT
Received: from [10.8.0.1] (helo=srv.home ident=heh29112)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1jEEVc-0000jZ-V0; Tue, 17 Mar 2020 23:52:01 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject; bh=uFJ75ZP6ogQzqlLVM5kRMZ/OeGhF72Gu5uduYLklNJo=;
        b=EacHN/gj9+7CXrtc6+GuUamMdi3ZDXpwzXHOXXTGj8feDNWyU4VEgC9fiSJvjtlzv0UlQeF0d4VUKb1vfe4ZKC0roQLp2umjspdI+8BZqPd5F35XzJpJjMn2a6r6A1PW9kZ9JvXWargCBk9DYIWxVCO5gRsVcIVutISYFWW8cWI=;
Subject: Re: Regression: hibernation is broken since
 e6bc9de714972cac34daa1dc1567ee48a47a9342
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org
References: <20200213172351.GA6747@dumbo> <20200213175753.GS6874@magnolia>
 <20200213183515.GA8798@dumbo> <20200213193410.GB6868@magnolia>
 <20200213194135.GF6870@magnolia> <20200214211523.GA32637@dumbo>
 <20200222002319.GK9504@magnolia> <20200223190311.GA26811@dumbo>
 <20200225202632.GE6748@magnolia>
From:   Brad Campbell <brad@fnarfbargle.com>
Message-ID: <f9fe045d-3613-7443-f634-f17e5630ded3@fnarfbargle.com>
Date:   Tue, 17 Mar 2020 23:51:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200225202632.GE6748@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/2/20 4:26 am, Darrick J. Wong wrote:
> On Sun, Feb 23, 2020 at 08:03:11PM +0100, Domenico Andreoli wrote:
>> On Fri, Feb 21, 2020 at 04:23:19PM -0800, Darrick J. Wong wrote:
>>>
>>> Ok, third try.  Does the following work?  This is a little more
>>> selective in that it only disables the write protection on the swap
>>> device/file that uswusp is going to write to.
>>
>> Yes it works but also verified that once the S_SWAPFILE bit is cleared
>> it's never restored, therefore the protecton is gone after the first
>> hibernation.
> 
> Ok, good.  Now can you try the third part, which ought to re-apply
> S_SWAPFILE after a successful resume, please?  Assuming this works, I
> think we're ready with a fixpatch.
> 

I just bumped up against it upgrading from 5.2 to 5.5 & a long bisection results in apparently the same point :
# first bad commit: [dc617f29dbe5ef0c8ced65ce62c464af1daaab3d] vfs: don't allow writes to swap files

Tested-By: Brad Campbell <lists2009@fnarfbargle.com>

> --D
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 1e99f7ac1d7e..add93e205850 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -458,6 +458,7 @@ extern void swap_free(swp_entry_t);
>   extern void swapcache_free_entries(swp_entry_t *entries, int n);
>   extern int free_swap_and_cache(swp_entry_t);
>   extern int swap_type_of(dev_t, sector_t, struct block_device **);
> +extern void swap_relockall(void);
>   extern unsigned int count_swap_pages(int, int);
>   extern sector_t map_swap_page(struct page *, struct block_device **);
>   extern sector_t swapdev_block(int, pgoff_t);
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 77438954cc2b..b11f7037ce5e 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -271,6 +271,8 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
>   			break;
>   		}
>   		error = hibernation_restore(data->platform_support);
> +		if (!error)
> +			swap_relockall();
>   		break;
>   
>   	case SNAPSHOT_FREE:
> @@ -372,10 +374,17 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
>   			 */
>   			swdev = new_decode_dev(swap_area.dev);
>   			if (swdev) {
> +				struct block_device *bd;
> +
>   				offset = swap_area.offset;
> -				data->swap = swap_type_of(swdev, offset, NULL);
> +				data->swap = swap_type_of(swdev, offset, &bd);
>   				if (data->swap < 0)
>   					error = -ENODEV;
> +
> +				inode_lock(bd->bd_inode);
> +				bd->bd_inode->i_flags &= ~S_SWAPFILE;
> +				inode_unlock(bd->bd_inode);
> +				bdput(bd);
>   			} else {
>   				data->swap = -1;
>   				error = -EINVAL;
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index b2a2e45c9a36..a64dcba10db6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1799,6 +1799,32 @@ int swap_type_of(dev_t device, sector_t offset, struct block_device **bdev_p)
>   	return -ENODEV;
>   }
>   
> +/* Re-lock swap devices after resuming from userspace suspend. */
> +void swap_relockall(void)
> +{
> +	int type;
> +
> +	spin_lock(&swap_lock);
> +	for (type = 0; type < nr_swapfiles; type++) {
> +		struct swap_info_struct *sis = swap_info[type];
> +		struct block_device *bdev = bdgrab(sis->bdev);
> +
> +		/*
> +		 * uswsusp only knows how to suspend to block devices, so we
> +		 * can skip swap files.
> +		 */
> +		if (!(sis->flags & SWP_WRITEOK) ||
> +		    !(sis->flags & SWP_BLKDEV))
> +			continue;
> +
> +		inode_lock(bd->bd_inode);
> +		bd->bd_inode->i_flags |= S_SWAPFILE;
> +		inode_unlock(bd->bd_inode);
> +		bdput(bd);
> +	}
> +	spin_unlock(&swap_lock);
> +}
> +
>   /*
>    * Get the (PAGE_SIZE) block corresponding to given offset on the swapdev
>    * corresponding to given index in swap_info (swap type).
> 

